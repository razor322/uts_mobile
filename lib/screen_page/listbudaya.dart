import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uts_mobile2_app/const.dart';
import 'package:uts_mobile2_app/model/model_listbudaya.dart';
import 'package:uts_mobile2_app/screen_page/detailbudaya.dart';
import 'package:uts_mobile2_app/screen_page/login.dart';

class PageListBudaya extends StatefulWidget {
  const PageListBudaya({Key? key}) : super(key: key);

  @override
  State<PageListBudaya> createState() => _PageListBudayaState();
}

class _PageListBudayaState extends State<PageListBudaya> {
  late List<Datum> _allBudaya = [];
  late List<Datum> _searchResult = [];
  TextEditingController txtCari = TextEditingController();
  bool isLoading = false;

  Future<void> getBudaya() async {
    setState(() => isLoading = true);
    try {
      final response = await http.get(Uri.parse('${url}listbudaya.php'));
      if (response.statusCode == 200) {
        _allBudaya = modelListbudayaFromJson(response.body).data ?? [];
        _searchResult = _allBudaya;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _filterBudaya(String query) {
    final results = _allBudaya
        .where((budaya) =>
            budaya.judul!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => _searchResult = results);
  }

  @override
  void initState() {
    super.initState();
    getBudaya();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image.asset(
                './assets/LogoDua.png', // Path to your logo image
                width: 750,
                height: 100,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              onChanged: _filterBudaya,
              controller: txtCari,
              decoration: InputDecoration(
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
                fillColor: Colors.white,
                hintText: "Search",
                hintStyle: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                Datum? data = _searchResult[index];

                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      //ketika item di klik pindah ke detail
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageDetailBudaya(data)));
                    },
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  '$url/image/${data?.gambar}',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '${data?.judul}',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                '${data?.konten}',
                                maxLines: 2,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
