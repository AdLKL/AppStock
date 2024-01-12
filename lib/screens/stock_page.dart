import 'package:accordion/accordion.dart';
import 'package:appstock/database/produit_dao.dart';
import 'package:appstock/models/produit.dart';
import 'package:appstock/widgets/create_row.dart';
import 'package:flutter/material.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _MyStockState();
}

class _MyStockState extends State<StockPage> {
  Future<List<Produit>>? futureProduit;
  final produitDAO = ProduitDAO();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      futureProduit = produitDAO.fetchAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Stock'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Container(
                    child: Accordion(
                        headerBackgroundColor: Color(0xFFCEDFD8),
                        contentBackgroundColor: Color(0xFF33EB5B5),
                        paddingListTop: 0,
                        paddingListBottom: 0,
                        rightIcon: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.black,
                            size: 35,
                          ),
                        ),
                        children: [
                          AccordionSection(
                            header: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.25,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              15,
                                            ),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/produit.png'),
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Container(
                                              child: const Text(
                                                'Table of products',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFF886767),
                                                ),
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) => CreateRow(
                                                          onSubmit:
                                                              (produit) async {
                                                        await produitDAO
                                                            .insertProduit(
                                                                produit);
                                                        if (!mounted) return;
                                                        _loadData();
                                                        Navigator.of(context)
                                                            .pop();
                                                      }));
                                            },
                                            child: Text('Add Product'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                            content: Container(
                              child: Column(
                                children: [
                                  const Row(
                                    children: [],
                                  ),
                                  // Display produit values under each attribute
                                  FutureBuilder<List<Produit>>(
                                    future: futureProduit,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        final produits = snapshot.data!;
                                        return produits.isEmpty
                                            ? const Center(
                                                child: Text(
                                                  'No Products..',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 25),
                                                ),
                                              )
                                            : ListView.separated(
                                                separatorBuilder:
                                                    (context, index) =>
                                                        const SizedBox(
                                                  height: 12,
                                                ),
                                                itemCount: produits.length,
                                                itemBuilder: (context, index) {
                                                  final produit =
                                                      produits[index];
                                                  return ListTile(
                                                    title: Text(
                                                      produit.nom,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    subtitle: Text(produit
                                                        .prixUnitaire
                                                        .toString()),
                                                    trailing: IconButton(
                                                      onPressed: () async {
                                                        await produitDAO
                                                            .delete(produit);
                                                        _loadData();
                                                      },
                                                      icon: const Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    onTap: () {
                                                      showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CreateRow(
                                                                  produit:
                                                                      produit,
                                                                  onSubmit:
                                                                      (title) async {
                                                                    await produitDAO
                                                                        .update(
                                                                            produit);
                                                                    _loadData();
                                                                    if (!mounted) {
                                                                      return;
                                                                    }
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }));
                                                    },
                                                  );
                                                },
                                              );
                                      }
                                    },
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  );
                }),
          ),
        ));
  }
}
