List makeNestedList(List list) {
  List output = [];
  List temp = [];
  for (int i = 0; i < list.length; i++) {
    if (i % 2 == 0 && i != 0) {
      output.add(temp);
      temp = [];
    }
    temp.add(list[i]);
  }
  output.add(temp);
  return output;
}
