bool fromJsonStringYn(String? yn) {
  return yn == "y";
}

String toJsonStringYn(bool? yn) {
  return yn == true ? "y" : "n";
}

int fromJsonInt(dynamic val) {
  if (val == null) return 0;

  if (val.runtimeType == int) {
    return val;
  }

  return int.parse(val);
}

String toJsonInt(int n) {
  return n.toString();
}

double fromJsonDouble(dynamic val) {
  if (val == null) return 0;

  if (val.runtimeType == double) {
    return val;
  }

  return double.parse(val);
}

String toJsonDouble(double n) {
  return n.toString();
}
