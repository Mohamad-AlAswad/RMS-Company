class CustomConverter {
  static List<String> toListString(List<dynamic> list) =>
      list.map((e) => e as String).toList();
}
