abstract class AllProductsStates {}

class AllProductsInitState extends AllProductsStates {}

class AllProductsLoadingState extends AllProductsStates {}

class AllProductsReadyState extends AllProductsStates {}

class NoProductsState extends AllProductsStates {}

class LoadingAddingToCartState extends AllProductsStates {}

class ErrorAddingToCartState extends AllProductsStates {}

class AllProductsErrorState extends AllProductsStates {}
