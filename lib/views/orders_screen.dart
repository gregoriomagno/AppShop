import 'package:flutter/material.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/order_widget.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatelessWidget {
  Future<void> _refreshOrders(BuildContext context) {
    return Provider.of<Orders>(context, listen: false).loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    // final Orders orders = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).loadOrders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.error != null) {
            return Center(child: Text('Ocorreu um erro!'));
          } else {
            return Consumer<Orders>(
              builder: (ctx, orders, child) {
                return RefreshIndicator(
                  onRefresh: () => _refreshOrders(context),
                  child: ListView.builder(
                    itemCount: orders.itemsCount,
                    itemBuilder: (ctx, i) => OrderWidget(orders.items[i]),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
