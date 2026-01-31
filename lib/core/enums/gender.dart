/// Gender enum for user profiles
enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  final String label;
  const Gender(this.label);

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (g) => g.label.toLowerCase() == value.toLowerCase(),
      orElse: () => Gender.other,
    );
  }
}
