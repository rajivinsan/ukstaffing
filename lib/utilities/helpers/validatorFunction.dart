class ValidatorFunction{

  static fieldValidator(String? input, String fieldName){
    if(input!.isEmpty || input.trim().length == 0){
      return "Enter Valid $fieldName";
    }
    if(fieldName == 'Phone Number' && input.trim().length != 10){
      return "$fieldName must be at least 10 characters";
    }
    if(fieldName == 'Email' && !(input.contains('@'))){
      return "Enter Valid $fieldName";
    }
    if(fieldName == 'Password' && input.trim().length < 7){
      return "$fieldName must be at least 7 characters";
    }
  }

}