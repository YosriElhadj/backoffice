import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'http://localhost:3000/graphql', // Replace with your actual backend URL
  );

  static GraphQLClient createClient() {
    return GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  static Widget createProvider({required Widget child}) {
    return GraphQLProvider(
      client: ValueNotifier(createClient()),
      child: child,
    );
  }
}