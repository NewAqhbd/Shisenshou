class BooleanWrapper {
  boolean value;

  BooleanWrapper(boolean value) {
    this.value = value;
  }
}

void checkMoveIsValid(BooleanWrapper isValid) {
  isValid.value = true;
}
