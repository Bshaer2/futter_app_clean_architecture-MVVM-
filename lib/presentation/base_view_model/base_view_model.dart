abstract class BaseViewModel with BaseViewModelInput, BaseViewModelOutput {

}

abstract mixin class BaseViewModelInput {
  void start();
  void dispose();
}

abstract mixin class BaseViewModelOutput {

}
