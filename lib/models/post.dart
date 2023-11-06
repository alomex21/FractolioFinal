// OK to Shop permite obtener información detallada de un alimento, con la cual se puede
// determinar si es apto o no para el consumo de personas con distintas preferencias
// alimentarias y de estilo de vida.
//
// ### Estructura general
//
// La API de OK to Shop está basada en REST. Posee URLs intuitivas y orientadas a recursos,
// y usa los códigos de respuesta HTTP para indicar el resultado de cada llamado.
//
// Los llamados deben realizarse usando HTTPS, de lo contrario se obtendrá un error HTTP 403
// `Forbidden`. Se puede acceder a nuestra API incluso desde algún aplicativo Web ya que
// soportamos CORS.
//
// Tanto las solicitudes como las respuestas están codificadas en JSON (incluso los
// errores). Si ocurre un error en la petición, el valor de `N` en `errorId` será un valor
// positivo y `response` contendrá un string con la descripción del error; en caso
// contrario, `N` será 0 y `response` tendrá un string, un número, un arreglo o un objeto
// dependiendo del endpoint consultado:
//
// ``` json
// {
// "errorId": N,
// "response": [string/int/float/array/object],
// "serverTime": M
// }
//
// ```
//
// En cualquier respuesta, `M` es la cantidad de segundos que tardó el servidor en procesar
// la petición.
//
// ### Autenticación
//
// Una vez que se ha iniciado sesión, se obtendrá un Token de 128 caracteres alfanuméricos
// el cual debe enviarse como encabezado de la siguiente forma:
//
// ``` shell
// x-auth-token: token_provisto_por_ok_to_shop
//
// ```
//
// ### Paginación y filtros
//
// Algunos recursos permiten paginarse (como las búsquedas, listas de productos sugeridos y
// otros) en cuyo caso pueden incorporarse como parte del query string los parámetros "page"
// y "pageSize":
//
// - **page** **`(int)`**: Desde 1 hasta N, indica la página de resultados que se desea
// obtener. En caso de omitirse, se asume el valor 1.
// - **pageSize** **`(int)`**: Desde 1 hasta N, indica la cantidad máxima de resultados a
// obtener en cada página. Dependiendo del recurso existen valores máximos diferentes. En
// caso de omitirse, se asume el valor máximo para ese recurso.
// - **since** **`(int)`**: Para aquellos recursos en los que la fecha de última
// actualización es relevante, indica el timestamp (medido en segundos desde el Unix Epoch)
// a partir del cual se quiere obtener información. En caso de omitirse, se asume el valor
// 0.
//
//
// Aquellos recursos que puedan ser paginados incluirán, además del objeto "response", un
// objeto adicional llamado "pagination".
//
// Por ejemplo, este objeto indica que se está mostrando la quinta página (`page`) de
// resultados, desplegando un máximo de 50 registros por página (`pageSize`), y que el total
// de resultados encontrados (`totalItems`) es de 1768.
//
// ``` json
// "pagination": {
// "page": 5,
// "pageSize": 50,
// "totalItems": 1768,
// "hasMore": true,
// "links": {
// "self": "https://api.okto.shop/v2/resource?page=5&pageSize=50",
// "first": "https://api.okto.shop/v2/resource?page=1&pageSize=50",
// "prev": "https://api.okto.shop/v2/resource?page=4&pageSize=50",
// "next": "https://api.okto.shop/v2/resource?page=6&pageSize=50",
// "last": "https://api.okto.shop/v2/resource?page=36&pageSize=50"
// }
// }
//
// ```
//
// Como puede apreciarse, dentro de "pagination" viene el objeto `links`, el cual indica las
// URLs que deben llamarse para ir a la primera (`first`) y última (`last`) páginas de
// resultados, y dependiendo de la cantidad de elementos encontrados, se incluyen además los
// links para navegar hacia la siguiente página (`next`) o para volver a la anterior
// (`prev`).
//
// El valor de `hasMore` será siempre el booleano _true_, a menos que se haya alcanzado la
// última página de resultados encontrados, en cuyo caso será el booleano _false_.
//
// ### Ubicación Geográfica
//
// Algunos recursos pueden recibir las coordenadas geográficas del usuario. Esta información
// se utilizará para fines estadísticos y para desplegar alternativas de productos más
// relevantes al usuario.
//
// Las coordenadas deben expresarse en el sistema WGS842 (mismo que utiliza Google Maps) con
// máximo 5 cifras decimales y se mostrará la latitud y la longitud, positiva para Norte y
// Este, negativa para Sur y Oeste.
//
// A modo de ejemplo, si se quiere buscar y desplegar información de productos para un
// usuario que se encuentra cerca de la estatua de Condorito en Cumpeo (Comuna de Río Claro,
// Chile), se deben enviar sus coordenadas geográficas en el encabezado de la petición de
// esta manera:
//
// ``` shell
// okts-lat: -35.28127
// okts-lon: -71.25901
//
// ```
// To parse this JSON data, do
//
//     final listOfCountries = listOfCountriesFromJson(jsonString);
//     final listOfErrors = listOfErrorsFromJson(jsonString);
//     final listOfSelectableIngredients = listOfSelectableIngredientsFromJson(jsonString);
//     final listOfLanguages = listOfLanguagesFromJson(jsonString);
//     final listOfProductCategories = listOfProductCategoriesFromJson(jsonString);
//     final productsInCategory = productsInCategoryFromJson(jsonString);
//     final ingredientInProductSuitabilityExplanation = ingredientInProductSuitabilityExplanationFromJson(jsonString);
//     final productSuitabilityExplanation = productSuitabilityExplanationFromJson(jsonString);
//     final productDetailsUsingId = productDetailsUsingIdFromJson(jsonString);
//     final productSponsoredContent = productSponsoredContentFromJson(jsonString);
//     final productSuitableAlternatives = productSuitableAlternativesFromJson(jsonString);
//     final storesThatSellThisProduct = storesThatSellThisProductFromJson(jsonString);
//     final listOfFilters = listOfFiltersFromJson(jsonString);
//     final listOfSuitabilityTypes = listOfSuitabilityTypesFromJson(jsonString);
//     final listOfWarningSigns = listOfWarningSignsFromJson(jsonString);
//     final sendFeedbackForProduct = sendFeedbackForProductFromJson(jsonString);
//     final sendPhotosWithBarcode = sendPhotosWithBarcodeFromJson(jsonString);
//     final newProducts = newProductsFromJson(jsonString);
//     final newProductsReportedByUser = newProductsReportedByUserFromJson(jsonString);
//     final suitabilityChanges = suitabilityChangesFromJson(jsonString);
//     final updatedProductsReportedByUser = updatedProductsReportedByUserFromJson(jsonString);
//     final listOfAllProducts = listOfAllProductsFromJson(jsonString);
//     final searchProductByTerm = searchProductByTermFromJson(jsonString);
//     final searchProductByBarcodeGtin = searchProductByBarcodeGtinFromJson(jsonString);
//     final sponsoredProducts = sponsoredProductsFromJson(jsonString);
//     final about = aboutFromJson(jsonString);
//     final disclaimer = disclaimerFromJson(jsonString);
//     final privacyPolicy = privacyPolicyFromJson(jsonString);
//     final ourTeam = ourTeamFromJson(jsonString);
//     final termsOfService = termsOfServiceFromJson(jsonString);
//     final addFamilyMember = addFamilyMemberFromJson(jsonString);
//     final deleteFamilyMember = deleteFamilyMemberFromJson(jsonString);
//     final editFamilyMember = editFamilyMemberFromJson(jsonString);
//     final listOfFamilyMembers = listOfFamilyMembersFromJson(jsonString);
//     final listsOfFavoritesForCurrentUser = listsOfFavoritesForCurrentUserFromJson(jsonString);
//     final createFavoritesList = createFavoritesListFromJson(jsonString);
//     final renameFavoritesList = renameFavoritesListFromJson(jsonString);
//     final deleteFavoritesList = deleteFavoritesListFromJson(jsonString);
//     final listOfProductsInAFavoritesList = listOfProductsInAFavoritesListFromJson(jsonString);
//     final addProductToFavoritesList = addProductToFavoritesListFromJson(jsonString);
//     final deleteProductFromFavoritesList = deleteProductFromFavoritesListFromJson(jsonString);
//     final notificationsForCurrentUser = notificationsForCurrentUserFromJson(jsonString);
//     final deleteNotifications = deleteNotificationsFromJson(jsonString);
//     final markAsRead = markAsReadFromJson(jsonString);
//     final getUsersSearchHistory = getUsersSearchHistoryFromJson(jsonString);
//     final deleteProductFromSearchHistory = deleteProductFromSearchHistoryFromJson(jsonString);

// ignore_for_file: constant_identifier_names

import 'dart:convert';

ListOfCountries listOfCountriesFromJson(String str) =>
    ListOfCountries.fromJson(json.decode(str));

String listOfCountriesToJson(ListOfCountries data) =>
    json.encode(data.toJson());

ListOfErrors listOfErrorsFromJson(String str) =>
    ListOfErrors.fromJson(json.decode(str));

String listOfErrorsToJson(ListOfErrors data) => json.encode(data.toJson());

ListOfSelectableIngredients listOfSelectableIngredientsFromJson(String str) =>
    ListOfSelectableIngredients.fromJson(json.decode(str));

String listOfSelectableIngredientsToJson(ListOfSelectableIngredients data) =>
    json.encode(data.toJson());

ListOfLanguages listOfLanguagesFromJson(String str) =>
    ListOfLanguages.fromJson(json.decode(str));

String listOfLanguagesToJson(ListOfLanguages data) =>
    json.encode(data.toJson());

ListOfProductCategories listOfProductCategoriesFromJson(String str) =>
    ListOfProductCategories.fromJson(json.decode(str));

String listOfProductCategoriesToJson(ListOfProductCategories data) =>
    json.encode(data.toJson());

ProductsInCategory productsInCategoryFromJson(String str) =>
    ProductsInCategory.fromJson(json.decode(str));

String productsInCategoryToJson(ProductsInCategory data) =>
    json.encode(data.toJson());

IngredientInProductSuitabilityExplanation
    ingredientInProductSuitabilityExplanationFromJson(String str) =>
        IngredientInProductSuitabilityExplanation.fromJson(json.decode(str));

String ingredientInProductSuitabilityExplanationToJson(
        IngredientInProductSuitabilityExplanation data) =>
    json.encode(data.toJson());

ProductSuitabilityExplanation productSuitabilityExplanationFromJson(
        String str) =>
    ProductSuitabilityExplanation.fromJson(json.decode(str));

String productSuitabilityExplanationToJson(
        ProductSuitabilityExplanation data) =>
    json.encode(data.toJson());

ProductDetailsUsingId productDetailsUsingIdFromJson(String str) =>
    ProductDetailsUsingId.fromJson(json.decode(str));

String productDetailsUsingIdToJson(ProductDetailsUsingId data) =>
    json.encode(data.toJson());

ProductSponsoredContent productSponsoredContentFromJson(String str) =>
    ProductSponsoredContent.fromJson(json.decode(str));

String productSponsoredContentToJson(ProductSponsoredContent data) =>
    json.encode(data.toJson());

ProductSuitableAlternatives productSuitableAlternativesFromJson(String str) =>
    ProductSuitableAlternatives.fromJson(json.decode(str));

String productSuitableAlternativesToJson(ProductSuitableAlternatives data) =>
    json.encode(data.toJson());

StoresThatSellThisProduct storesThatSellThisProductFromJson(String str) =>
    StoresThatSellThisProduct.fromJson(json.decode(str));

String storesThatSellThisProductToJson(StoresThatSellThisProduct data) =>
    json.encode(data.toJson());

ListOfFilters listOfFiltersFromJson(String str) =>
    ListOfFilters.fromJson(json.decode(str));

String listOfFiltersToJson(ListOfFilters data) => json.encode(data.toJson());

ListOfSuitabilityTypes listOfSuitabilityTypesFromJson(String str) =>
    ListOfSuitabilityTypes.fromJson(json.decode(str));

String listOfSuitabilityTypesToJson(ListOfSuitabilityTypes data) =>
    json.encode(data.toJson());

ListOfWarningSigns listOfWarningSignsFromJson(String str) =>
    ListOfWarningSigns.fromJson(json.decode(str));

String listOfWarningSignsToJson(ListOfWarningSigns data) =>
    json.encode(data.toJson());

SendFeedbackForProduct sendFeedbackForProductFromJson(String str) =>
    SendFeedbackForProduct.fromJson(json.decode(str));

String sendFeedbackForProductToJson(SendFeedbackForProduct data) =>
    json.encode(data.toJson());

SendPhotosWithBarcode sendPhotosWithBarcodeFromJson(String str) =>
    SendPhotosWithBarcode.fromJson(json.decode(str));

String sendPhotosWithBarcodeToJson(SendPhotosWithBarcode data) =>
    json.encode(data.toJson());

NewProducts newProductsFromJson(String str) =>
    NewProducts.fromJson(json.decode(str));

String newProductsToJson(NewProducts data) => json.encode(data.toJson());

NewProductsReportedByUser newProductsReportedByUserFromJson(String str) =>
    NewProductsReportedByUser.fromJson(json.decode(str));

String newProductsReportedByUserToJson(NewProductsReportedByUser data) =>
    json.encode(data.toJson());

SuitabilityChanges suitabilityChangesFromJson(String str) =>
    SuitabilityChanges.fromJson(json.decode(str));

String suitabilityChangesToJson(SuitabilityChanges data) =>
    json.encode(data.toJson());

UpdatedProductsReportedByUser updatedProductsReportedByUserFromJson(
        String str) =>
    UpdatedProductsReportedByUser.fromJson(json.decode(str));

String updatedProductsReportedByUserToJson(
        UpdatedProductsReportedByUser data) =>
    json.encode(data.toJson());

ListOfAllProducts listOfAllProductsFromJson(String str) =>
    ListOfAllProducts.fromJson(json.decode(str));

String listOfAllProductsToJson(ListOfAllProducts data) =>
    json.encode(data.toJson());

SearchProductByTerm searchProductByTermFromJson(String str) =>
    SearchProductByTerm.fromJson(json.decode(str));

String searchProductByTermToJson(SearchProductByTerm data) =>
    json.encode(data.toJson());

SearchProductByBarcodeGtin searchProductByBarcodeGtinFromJson(String str) =>
    SearchProductByBarcodeGtin.fromJson(json.decode(str));

String searchProductByBarcodeGtinToJson(SearchProductByBarcodeGtin data) =>
    json.encode(data.toJson());

SponsoredProducts sponsoredProductsFromJson(String str) =>
    SponsoredProducts.fromJson(json.decode(str));

String sponsoredProductsToJson(SponsoredProducts data) =>
    json.encode(data.toJson());

About aboutFromJson(String str) => About.fromJson(json.decode(str));

String aboutToJson(About data) => json.encode(data.toJson());

Disclaimer disclaimerFromJson(String str) =>
    Disclaimer.fromJson(json.decode(str));

String disclaimerToJson(Disclaimer data) => json.encode(data.toJson());

PrivacyPolicy privacyPolicyFromJson(String str) =>
    PrivacyPolicy.fromJson(json.decode(str));

String privacyPolicyToJson(PrivacyPolicy data) => json.encode(data.toJson());

OurTeam ourTeamFromJson(String str) => OurTeam.fromJson(json.decode(str));

String ourTeamToJson(OurTeam data) => json.encode(data.toJson());

TermsOfService termsOfServiceFromJson(String str) =>
    TermsOfService.fromJson(json.decode(str));

String termsOfServiceToJson(TermsOfService data) => json.encode(data.toJson());

AddFamilyMember addFamilyMemberFromJson(String str) =>
    AddFamilyMember.fromJson(json.decode(str));

String addFamilyMemberToJson(AddFamilyMember data) =>
    json.encode(data.toJson());

DeleteFamilyMember deleteFamilyMemberFromJson(String str) =>
    DeleteFamilyMember.fromJson(json.decode(str));

String deleteFamilyMemberToJson(DeleteFamilyMember data) =>
    json.encode(data.toJson());

EditFamilyMember editFamilyMemberFromJson(String str) =>
    EditFamilyMember.fromJson(json.decode(str));

String editFamilyMemberToJson(EditFamilyMember data) =>
    json.encode(data.toJson());

ListOfFamilyMembers listOfFamilyMembersFromJson(String str) =>
    ListOfFamilyMembers.fromJson(json.decode(str));

String listOfFamilyMembersToJson(ListOfFamilyMembers data) =>
    json.encode(data.toJson());

ListsOfFavoritesForCurrentUser listsOfFavoritesForCurrentUserFromJson(
        String str) =>
    ListsOfFavoritesForCurrentUser.fromJson(json.decode(str));

String listsOfFavoritesForCurrentUserToJson(
        ListsOfFavoritesForCurrentUser data) =>
    json.encode(data.toJson());

CreateFavoritesList createFavoritesListFromJson(String str) =>
    CreateFavoritesList.fromJson(json.decode(str));

String createFavoritesListToJson(CreateFavoritesList data) =>
    json.encode(data.toJson());

RenameFavoritesList renameFavoritesListFromJson(String str) =>
    RenameFavoritesList.fromJson(json.decode(str));

String renameFavoritesListToJson(RenameFavoritesList data) =>
    json.encode(data.toJson());

DeleteFavoritesList deleteFavoritesListFromJson(String str) =>
    DeleteFavoritesList.fromJson(json.decode(str));

String deleteFavoritesListToJson(DeleteFavoritesList data) =>
    json.encode(data.toJson());

ListOfProductsInAFavoritesList listOfProductsInAFavoritesListFromJson(
        String str) =>
    ListOfProductsInAFavoritesList.fromJson(json.decode(str));

String listOfProductsInAFavoritesListToJson(
        ListOfProductsInAFavoritesList data) =>
    json.encode(data.toJson());

AddProductToFavoritesList addProductToFavoritesListFromJson(String str) =>
    AddProductToFavoritesList.fromJson(json.decode(str));

String addProductToFavoritesListToJson(AddProductToFavoritesList data) =>
    json.encode(data.toJson());

DeleteProductFromFavoritesList deleteProductFromFavoritesListFromJson(
        String str) =>
    DeleteProductFromFavoritesList.fromJson(json.decode(str));

String deleteProductFromFavoritesListToJson(
        DeleteProductFromFavoritesList data) =>
    json.encode(data.toJson());

NotificationsForCurrentUser notificationsForCurrentUserFromJson(String str) =>
    NotificationsForCurrentUser.fromJson(json.decode(str));

String notificationsForCurrentUserToJson(NotificationsForCurrentUser data) =>
    json.encode(data.toJson());

DeleteNotifications deleteNotificationsFromJson(String str) =>
    DeleteNotifications.fromJson(json.decode(str));

String deleteNotificationsToJson(DeleteNotifications data) =>
    json.encode(data.toJson());

MarkAsRead markAsReadFromJson(String str) =>
    MarkAsRead.fromJson(json.decode(str));

String markAsReadToJson(MarkAsRead data) => json.encode(data.toJson());

GetUsersSearchHistory getUsersSearchHistoryFromJson(String str) =>
    GetUsersSearchHistory.fromJson(json.decode(str));

String getUsersSearchHistoryToJson(GetUsersSearchHistory data) =>
    json.encode(data.toJson());

DeleteProductFromSearchHistory deleteProductFromSearchHistoryFromJson(
        String str) =>
    DeleteProductFromSearchHistory.fromJson(json.decode(str));

String deleteProductFromSearchHistoryToJson(
        DeleteProductFromSearchHistory data) =>
    json.encode(data.toJson());

///List of Countries
///
///GET {{url}}/countries
///
///Lista de países para los cuales hay información poblada en nuestra base de datos de
///alimentos.
///
///| **ID** | **Alfa-2** | **Alfa-3** | **Nombre** |
///| --- | --- | --- | --- |
///| 32 | AR | ARG | Argentina |
///| 152 | CL | CHL | Chile |
///| 170 | CO | COL | Colombia |
///| 604 | PE | PER | Perú |
class ListOfCountries {
  int errorId;
  List<ListOfCountriesResponse> response;
  double serverTime;

  ListOfCountries({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfCountries.fromJson(Map<String, dynamic> json) =>
      ListOfCountries(
        errorId: json["errorId"],
        response: List<ListOfCountriesResponse>.from(
            json["response"].map((x) => ListOfCountriesResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ListOfCountriesResponse {
  int id;
  String alpha2;
  String? alpha3;
  String name;

  ListOfCountriesResponse({
    required this.id,
    required this.alpha2,
    this.alpha3,
    required this.name,
  });

  factory ListOfCountriesResponse.fromJson(Map<String, dynamic> json) =>
      ListOfCountriesResponse(
        id: json["id"],
        alpha2: json["alpha2"],
        alpha3: json["alpha3"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alpha2": alpha2,
        "alpha3": alpha3,
        "name": name,
      };
}

///List of Errors
///
///GET {{url}}/errors
///
///| **ID** | **Description** | **Status Code** |
///| --- | --- | --- |
///| 1 | Internal Server Error | 500 |
///| 2 | Unauthorized | 401 |
///| 3 | Forbidden | 403 |
///| 4 | Method Not Allowed | 405 |
///| 5 | Bad Request | 400 |
///| 6 | Not Found | 404 |
///| 7 | Token Not Valid | 401 |
///| 8 | Token Expired | 401 |
///| 9 | HTTPS is required | 403 |
///| 100 | User Not Found | 404 |
///| 101 | New Password required | 400 |
///| 102 | User E-Mail already in use | 400 |
///| 103 | Permission Profile Not Found | 404 |
///| 104 | Current Password is not valid | 400 |
///| 105 | User Name not valid | 400 |
///| 106 | User Last Name not valid | 400 |
///| 107 | Invalid Permission Profile Name | 400 |
///| 108 | Permission Profile Name already in use | 400 |
///| 109 | User Banned | 403 |
///| 110 | Daily Quota Exceeded | 429 |
///| 111 | Monthly Quota Exceeded | 429 |
///| 200 | File Not Found | 404 |
///| 201 | Can't overwrite file | 400 |
///| 202 | File is not a valid Photo | 400 |
///| 203 | Couldn't upload one or more files | 400 |
///| 300 | E-Mail not valid | 400 |
///| 301 | Couldn't connect to E-Mail provider | 400 |
///| 400 | Mobile not valid | 400 |
///| 500 | Date not valid | 400 |
///| 600 | Geo Location Not Valid | 400 |
///| 601 | Country Not Found | 404 |
///| 700 | Language Not Found | 404 |
///| 800 | Family Member Not Found | 404 |
///| 801 | Family Member Alias is not valid | 400 |
///| 802 | Family Member Alias already in use | 400 |
///| 900 | Restriction Group Not Found | 404 |
///| 901 | Ingredient Not Found | 404 |
///| 902 | Filter Not Found | 404 |
///| 903 | Filter options minimum not reached | 400 |
///| 1000 | Product Not Found | 404 |
///| 1001 | Product already exists | 400 |
///| 1100 | Product Category Not Found | 404 |
///| 1201 | Favorites List Not Found | 404 |
///| 1202 | Favorites List Name already in use | 400 |
///| 1203 | Favorites List Name is not valid | 400 |
class ListOfErrors {
  int errorId;
  List<ListOfErrorsResponse> response;
  double serverTime;

  ListOfErrors({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfErrors.fromJson(Map<String, dynamic> json) => ListOfErrors(
        errorId: json["errorId"],
        response: List<ListOfErrorsResponse>.from(
            json["response"].map((x) => ListOfErrorsResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ListOfErrorsResponse {
  int errorId;
  String description;
  int statusCode;

  ListOfErrorsResponse({
    required this.errorId,
    required this.description,
    required this.statusCode,
  });

  factory ListOfErrorsResponse.fromJson(Map<String, dynamic> json) =>
      ListOfErrorsResponse(
        errorId: json["errorId"],
        description: json["description"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "description": description,
        "statusCode": statusCode,
      };
}

///List of selectable Ingredients
///
///GET {{url}}/ingredients
///
///Al realizar este llamado se obtiene la lista completa de aquellos ingredientes que pueden
///ser seleccionados por un usuario como parte de sus restricciones o preferencias
///alimentarias.
class ListOfSelectableIngredients {
  int errorId;
  List<IngredientElement> response;
  double serverTime;

  ListOfSelectableIngredients({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfSelectableIngredients.fromJson(Map<String, dynamic> json) =>
      ListOfSelectableIngredients(
        errorId: json["errorId"],
        response: List<IngredientElement>.from(
            json["response"].map((x) => IngredientElement.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class IngredientElement {
  String id;
  String name;

  IngredientElement({
    required this.id,
    required this.name,
  });

  factory IngredientElement.fromJson(Map<String, dynamic> json) =>
      IngredientElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

///List of Languages
///
///GET {{url}}/langs
///
///Lista de idiomas en los cuales se puede obtener respuesta.
///
///| **ID** | **Alfa-2** | **Nombre** |
///| --- | --- | --- |
///| 1 | es | Español |
///| 2 | en | English |
class ListOfLanguages {
  int errorId;
  List<ListOfCountriesResponse> response;
  double serverTime;

  ListOfLanguages({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfLanguages.fromJson(Map<String, dynamic> json) =>
      ListOfLanguages(
        errorId: json["errorId"],
        response: List<ListOfCountriesResponse>.from(
            json["response"].map((x) => ListOfCountriesResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

///List of Product Categories
///
///GET {{url}}/products/categories?parentId=0
///
///Cada categoría tiene los siguientes atributos:
///
///- **id** **`(int)`**: Identificador único de la categoría.
///
///- **parentId** **`(int)`**: identificador de la categoría de la cual depende.
///
///- **name** **`(string)`**: nombre de la categoría.
///
///- **image** **`(string)`**: URL a una imagen referencial.
///
///- **lastUpdate** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) de la
///última modificación.
///
///
///Es posible listar todas las categorías a la vez, o ver solo las categorías que dependen
///de una en específico usando el parámetro GET `parentId` (ver los dos ejemplos
///proporcionados).
class ListOfProductCategories {
  int errorId;
  List<ListOfProductCategoriesResponse> response;
  double serverTime;

  ListOfProductCategories({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfProductCategories.fromJson(Map<String, dynamic> json) =>
      ListOfProductCategories(
        errorId: json["errorId"],
        response: List<ListOfProductCategoriesResponse>.from(json["response"]
            .map((x) => ListOfProductCategoriesResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ListOfProductCategoriesResponse {
  int id;
  int parentId;
  String name;
  String image;
  int lastUpdate;

  ListOfProductCategoriesResponse({
    required this.id,
    required this.parentId,
    required this.name,
    required this.image,
    required this.lastUpdate,
  });

  factory ListOfProductCategoriesResponse.fromJson(Map<String, dynamic> json) =>
      ListOfProductCategoriesResponse(
        id: json["id"],
        parentId: json["parentId"],
        name: json["name"],
        image: json["image"],
        lastUpdate: json["lastUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "parentId": parentId,
        "name": name,
        "image": image,
        "lastUpdate": lastUpdate,
      };
}

///Products in Category
///
///GET {{url}}/products/categories/CATEGORY_ID/products?page=1&pageSize=50&since=0
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos contenidos dentro de
///la categoría cuyo ID es `CATEGORY_ID`, o cualquiera de sus subcategorías.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
///
///En caso de querer visualizar solo los productos que han sido actualizados desde un
///determinado timestamp en adelante (medido en segundos desde el Unix Epoch), se puede
///enviar dicho valor en el parámetro `since`.
class ProductsInCategory {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  ProductsInCategory({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory ProductsInCategory.fromJson(Map<String, dynamic> json) =>
      ProductsInCategory(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

class Pagination {
  int page;
  int pageSize;
  int totalItems;
  bool hasMore;
  Links links;

  Pagination({
    required this.page,
    required this.pageSize,
    required this.totalItems,
    required this.hasMore,
    required this.links,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        totalItems: json["totalItems"],
        hasMore: json["hasMore"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "totalItems": totalItems,
        "hasMore": hasMore,
        "links": links.toJson(),
      };
}

class Links {
  String self;
  String first;
  String? next;
  String last;

  Links({
    required this.self,
    required this.first,
    this.next,
    required this.last,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: json["self"],
        first: json["first"],
        next: json["next"],
        last: json["last"],
      );

  Map<String, dynamic> toJson() => {
        "self": self,
        "first": first,
        "next": next,
        "last": last,
      };
}

class ProductsInCategoryResponse {
  String id;
  String photoUrl;
  String description;
  String retailerName;
  bool sponsored;
  String? campaignId;
  double sizeValue;
  double drainedSizeValue;
  Unit sizeUnit;
  int lastUpdate;
  PurpleWhoCanShop whoCanShop;
  CampaignId? responseCampaignId;

  ProductsInCategoryResponse({
    required this.id,
    required this.photoUrl,
    required this.description,
    required this.retailerName,
    required this.sponsored,
    this.campaignId,
    required this.sizeValue,
    required this.drainedSizeValue,
    required this.sizeUnit,
    required this.lastUpdate,
    required this.whoCanShop,
    this.responseCampaignId,
  });

  factory ProductsInCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductsInCategoryResponse(
        id: json["id"],
        photoUrl: json["photoUrl"],
        description: json["description"],
        retailerName: json["retailerName"],
        sponsored: json["sponsored"],
        campaignId: json["campaignID"],
        sizeValue: json["sizeValue"]?.toDouble(),
        drainedSizeValue: json["drainedSizeValue"]?.toDouble(),
        sizeUnit: unitValues.map[json["sizeUnit"]]!,
        lastUpdate: json["lastUpdate"],
        whoCanShop: PurpleWhoCanShop.fromJson(json["whoCanShop"]),
        responseCampaignId: campaignIdValues.map[json["campaignId"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "photoUrl": photoUrl,
        "description": description,
        "retailerName": retailerName,
        "sponsored": sponsored,
        "campaignID": campaignId,
        "sizeValue": sizeValue,
        "drainedSizeValue": drainedSizeValue,
        "sizeUnit": unitValues.reverse[sizeUnit],
        "lastUpdate": lastUpdate,
        "whoCanShop": whoCanShop.toJson(),
        "campaignId": campaignIdValues.reverse[responseCampaignId],
      };
}

enum CampaignId { EMPTY, THE_1234_ABCDEFGHIJLKMNOP }

final campaignIdValues = EnumValues({
  "": CampaignId.EMPTY,
  "1234-abcdefghijlkmnop": CampaignId.THE_1234_ABCDEFGHIJLKMNOP
});

enum Unit { CC, G, KG, LT, ML, UNIDADES }

final unitValues = EnumValues({
  "cc": Unit.CC,
  "g": Unit.G,
  "kg": Unit.KG,
  "lt": Unit.LT,
  "ml": Unit.ML,
  "Unidades": Unit.UNIDADES
});

class PurpleWhoCanShop {
  Purple119828 the119828;

  PurpleWhoCanShop({
    required this.the119828,
  });

  factory PurpleWhoCanShop.fromJson(Map<String, dynamic> json) =>
      PurpleWhoCanShop(
        the119828: Purple119828.fromJson(json["119828"]),
      );

  Map<String, dynamic> toJson() => {
        "119828": the119828.toJson(),
      };
}

class Purple119828 {
  int status;

  Purple119828({
    required this.status,
  });

  factory Purple119828.fromJson(Map<String, dynamic> json) => Purple119828(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}

///Ingredient in Product Suitability Explanation
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID/suitability/ingredient/INGREDIENT_ID
///
///Devuelve un string con una explicación de por qué un determinado ingrediente en un
///producto no es apto para el usuario que lo está consultando.
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando esta información.
///
///`INGREDIENT_ID` se refiere al Identificador único del ingrediente contenido en el
///producto, para el cual se está consultando esta información.
class IngredientInProductSuitabilityExplanation {
  int errorId;
  IngredientInProductSuitabilityExplanationResponse response;
  double serverTime;

  IngredientInProductSuitabilityExplanation({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory IngredientInProductSuitabilityExplanation.fromJson(
          Map<String, dynamic> json) =>
      IngredientInProductSuitabilityExplanation(
        errorId: json["errorId"],
        response: IngredientInProductSuitabilityExplanationResponse.fromJson(
            json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

class IngredientInProductSuitabilityExplanationResponse {
  String hmtlDescription;

  IngredientInProductSuitabilityExplanationResponse({
    required this.hmtlDescription,
  });

  factory IngredientInProductSuitabilityExplanationResponse.fromJson(
          Map<String, dynamic> json) =>
      IngredientInProductSuitabilityExplanationResponse(
        hmtlDescription: json["hmtlDescription"],
      );

  Map<String, dynamic> toJson() => {
        "hmtlDescription": hmtlDescription,
      };
}

///Product Suitability Explanation
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID/suitability/familyMember/FAMILY_MEMBER_ID
///
///Devuelve un string con una explicación de por qué un producto no es apto para un
///integrante del grupo familiar del usuario que está consultando.
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando esta información.
///
///`FAMILY_MEMBER_ID` es el identificador del integrante del grupo familiar del usuario para
///el cual se está consultando la aptitud de este producto.
class ProductSuitabilityExplanation {
  int errorId;
  IngredientInProductSuitabilityExplanationResponse response;
  double serverTime;

  ProductSuitabilityExplanation({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ProductSuitabilityExplanation.fromJson(Map<String, dynamic> json) =>
      ProductSuitabilityExplanation(
        errorId: json["errorId"],
        response: IngredientInProductSuitabilityExplanationResponse.fromJson(
            json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Product details using ID
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID
///
///Este es el endpoint principal de OK to Shop, pues permite conocer en profundidad el
///contenido de un producto.
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando su información, el cual puede
///haberse obtenido luego de listar los productos contenidos en una categoría, hacer una
///búsqueda por texto, ingresar el código de barras de su empaque, o cualquier otra **"Lista
///de productos OKTS"**.
///
///Para cada producto se entrega la siguiente información:
///
///- **id** **`(string)`**: Identificador único de ese producto (dentro de la base de datos
///de OK to Shop).
///- **tradingCountryId** **`(int)`**: Identificador del país donde se comercializa este
///producto (según el estándar ISO 3166-1).
///- **tradingCountryCode** **`(string)`**: Código de 2 letras del país donde se
///comercializa este producto (según el estándar ISO 3166-1).
///- **tradingCountryName** **`(string)`**: Nombre del país donde se comercializa este
///producto.
///- **language** **`(string)`**: Idioma en el cual se está entregando la información del
///producto (según el estándar ISO 639-1).
///- **suspended** **`(boolean)`**: Indica si el producto está suspendido temporalmente
///debido a que su información está en revisión.
///- **sponsored** **`(boolean)`**: Indica si el producto está siendo patrocinado en alguna
///campaña.
///- **chronology** **`(object)`**:
///- **timestampIn** **`(int)`**: Timestamp en el cual el producto fue añadido a la base de
///datos (medido en segundos desde el Unix Epoch).
///- **lastReview** **`(int)`**: Timestamp en el cual el producto fue revisado por última
///vez por el equipo de OK to Shop (medido en segundos desde el Unix Epoch).
///- **lastUpdate** **`(int)`**: Timestamp en el cual el producto fue modificado por última
///vez en la base de datos (medido en segundos desde el Unix Epoch).
///- **version** **`(int)`**: Cada vez que se detecta un cambio en la composición de un
///producto, se añade 1 a este contador.
///- **timestampOut** **`(int)`**: Timestamp en el cual el producto fue eliminado de la base
///de datos (medido en segundos desde el Unix Epoch). Si este valor está en 0 es porque el
///producto se encuentra vigente.
///- **identifiers** **`(array)`**: Arreglo de objetos que contiene los distintos
///identificadores únicos que se conocen para el producto (código de barras, número de
///registro sanitario, etc). Cada objeto tiene los siguientes elementos:
///- **type** **`(string)`**: Tipo de identificador. El más común es "barcode", que
///representa el código GTIN (EAN/UPC) del producto.
///- **value** **`(string)`**: El identificador o código en cuestión.
///- **isVariable** **`(boolean)`**: Indica si este identificador se utiliza para construir
///otros identificadores. Esto es común cuando hay productos que se venden a granel o por
///peso y la primera parte de su código identifica al producto y la parte final indica el
///peso o precio a cobrar.
///- **basicInformation** **`(object)`**:
///- **photoUrl** **`(string)`**: URL de la vista previa del producto.
///- **bigPhotoUrl** **`(string)`**: URL de la imagen ampliada del producto.
///- **photoSource** **`(string)`**: Origen desde el cual se obtuvo la imagen.
///- **categoryId** **`(int)`**: Identificador único de la categoría a la que pertenece el
///producto.
///- **categoryName** **`(string)`**: Nombre de la categoría a la que pertenece el
///producto.
///- **brands** **`(array)`**: Arreglo de objetos que contiene todas las marcas detectadas
///para el producto. Cada objeto tiene los siguientes elementos:
///- **id** **`(int)`**: Identificador único de la marca.
///- **name** **`(string)`**: Nombre de la marca.
///- **description** **`(string)`**: Descripción general del producto.
///- **variant** **`(string)`**: Variedad o sabor del producto.
///- **additionalInformation** **`(array)`**: Arreglo de objetos que contiene información
///que no se encuentra comúnmente en todos los productos y depende de su naturaleza (acidez,
///cepa, etc). Cada objeto tiene los siguientes elementos:
///- **fieldId** **`(int)`**: Identificador único del tipo de dato.
///- **fieldName** **`(string)`**: Nombre del tipo de dato.
///- **value** **`(string)`**: Valor del dato.
///- **suitability** **`(array)`**: Arreglo de objetos que contiene información de la
///aptitud del producto para las preferencias o restricciones más comunes. Cada objeto tiene
///los siguientes elementos:
///- **code** **`(string)`**: Código único de la preferencia o restricción.
///- **name** **`(string)`**: Nombre de la preferencia o restricción.
///- **pngImagePath** **`(string)`**: URL al icono de esta preferencia o restricción en
///formato PNG transparente.
///- **svgImagePath** **`(string)`**: URL al icono de esta preferencia o restricción en
///formato SVG.
///- **declaredBy** **`(array)`**: Arreglo de objetos, donde cada elemento indica la(s)
///fuente(s) desde la cual se logró determinar esta aptitud. Cada uno tiene la siguiente
///estructura:
///- **id** **`(int)`**: Identificador único de la entidad o fuente de la cual se obtuvo la
///información. En caso de valer 0 se asume que esta información se obtuvo directamente
///desde el empaque del producto.
///- **name** **`(string)`**: Nombre de la entidad o fuente de la cual se obtuvo la
///información.
///- **logoUrl** **`(string)`**: URL al logo de la entidad o fuente de la cual se obtuvo la
///información.
///- **countryId** **`(int)`**: Identificador del país al cual pertenece la entidad o fuente
///de la cual se obtuvo la información (según el estándar ISO 3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país al cual pertenece la
///entidad o fuente de la cual se obtuvo la información (según el estándar ISO
///3166-1).
///- **countryName** **`(string)`**: Nombre del país al cual pertenece la entidad o fuente
///de la cual se obtuvo la información.
///- **degreeId** **`(int)`**: Grado de certeza de la aptitud informada, puede tomar valores
///desde -3 a +3.
///- **degreeName** **`(string)`**: Dependiendo del valor de `degreeId`, los valores
///posibles en ester campo son: -3 ("NO APTO, Según entidad Certificadora"), -2 ("NO APTO,
///Según lista de Ingredientes y Trazas"), -1 ("DUDOSO, Según lista de Ingredientes y
///Trazas"), 1 ("APTO, Según lista de Ingredientes y Trazas"), 2 ("APTO, Según sello visible
///en el envase") y 3 ("APTO, Según entidad Certificadora").
///- **start** **`(int)`**: Timestamp en el que se inició la certificación o validación de
///la aptitud (medido en segundos desde el Unix Epoch) de la última modificación.
///- **end** **`(int)`**: Timestamp en que finalizará o finalizó la certificación o
///validación de la aptitud (medido en segundos desde el Unix Epoch) de la última
///modificación.
///- **lastUpdate** **`(int)`**: Timestamp en el que se modificó por última vez la
///certificación o validación de la aptitud (medido en segundos desde el Unix Epoch) de la
///última modificación.
///- **htmlContent** **`(string)`**: Mensaje aclaratorio de la entidad o fuente de la cual
///se obtuvo la información.
///- **actionUrl** **`(string)`**: URL donde obtener más información sobre la certificación
///o validación de la aptitud.
///- **symbols** **`(array)`**: Arreglo de objetos, donde cada elemento representa distintos
///sellos de advertencia presentes en el empaque. Cada uno tiene la siguiente
///estructura:
///- **id** **`(int)`**: Identificador único del sello.
///- **type** **`(string)`**: Tipo de sello. Usualmente será una advertencia nutricional
///("nutritional_warning") pero a futuro se podrían añadir sellos de advertencia de otra
///naturaleza cuando OK to Shop incorpore productos de más categorías (control de
///psicotrópicos, advertencias de manipulación o consumo, etc).
///- **code** **`(string)`**: Código del sello.
///- **name** **`(string)`**: Nombre del sello.
///- **pngImagePath** **`(string)`**: URL al icono de este sello en formato PNG
///transparente.
///- **svgImagePath** **`(string)`**: URL al icono de este sello en formato SVG.
///- **content** **`(object)`**: Detalla las dimensiones, peso y contenidos del
///producto.
///- **totalItems** **`(int)`**: Cantidad de elementos contenidos en el empaque (usualmente
///este valor será 1, pero puede tener números mayores cuando se trata de packs de
///productos).
///- **item** **`(object)`**: Peso o volumen bruto del producto.
///- **weightValue** **`(float)`**: Valor del peso bruto. Este campo podría ser
///nulo.
///- **volumeValue** **`(float)`**: Valor del volumen bruto. Este campo podría ser
///nulo.
///- **weightMeasurementUnit** **`(string)`**: Unidad de medida del peso bruto. Este campo
///podría ser nulo.
///- **volumeMeasurementUnit** **`(string)`**: Unidad de medida del volumen bruto. Este
///campo podría ser nulo.
///- **net** **`(object)`**: Peso o volumen neto del producto.
///- **weightValue** **`(float)`**: Valor del peso neto. Este campo podría ser nulo.
///- **volumeValue** **`(float)`**: Valor del volumen neto. Este campo podría ser
///nulo.
///- **weightMeasurementUnit** **`(string)`**: Unidad de medida del peso neto. Este campo
///podría ser nulo.
///- **volumeMeasurementUnit** **`(string)`**: Unidad de medida del volumen neto. Este campo
///podría ser nulo.
///- **drained** **`(object)`**: Peso drenado (o escurrido) del producto.
///- **weightValue** **`(float)`**: Valor del peso drenado.
///- **weightMeasurementUnit** **`(string)`**: Unidad de medida del peso drenado.
///- **isPack** **`(boolean)`**: Indica si este producto es un pack.
///- **packProducts** **`(array)`**: Arreglo de objetos, donde cada elemento indica cuántas
///unidades de cada producto componen el pack. Cada uno tiene la siguiente
///estructura:
///- **id** **`(string)`**: Identificador único de ese producto (dentro de la base de datos
///de OK to Shop). Este identificador puede ser utilizado para obtener más detalles de este
///producto llamando a este mismo endpoint.
///- **description** **`(string)`**: Breve descripción del producto.
///- **totalItems** **`(int)`**: Cantidad de unidades de este producto contenidas en el
///pack.
///- **elements** **`(array)`**: Arreglo de objetos con el detalle de los contenidos de cada
///elemento del producto. Cada uno de estos objetos tiene la siguiente estructura:
///- **title** **`(string)`**: Título del elemento.
///- **form** **`(string)`**: Presentación del producto (botella, lata, sachet, etc).
///- **ingredients** **`(array)`**: Arreglo de objetos con la lista de todos los
///ingredientes de este elemento. Cada ingrediente tiene la siguiente estructura:
///- **id** **`(string)`**: Identificador único del ingrediente.
///- **name** **`(string)`**: Nombre del ingrediente
///- **containsText** **`(string)`**: Título utilizado para destacar ciertos ingredientes
///que usualmente se destacan en negrita o se repiten para hacer énfasis en su presencia
///(ej: "Alérgenos que contiene", o simplemente "Contiene").
///- **contains** **`(array)`**: Arreglo de objetos con la lista de todos los ingredientes a
///destacar de este elemento. Cada ingrediente tiene la siguiente estructura:
///- **id** **`(string)`**: Identificador único del ingrediente.
///- **name** **`(string)`**: Nombre del ingrediente
///- **nutritionalTracesText** **`(string)`**: Título utilizado para mencionar aquellos
///alérgenos comunes en el país de comercialización que, si bien no son parte de la
///formulación del producto en cuestión, pueden aparecer en pequeñas cantidades debido a la
///contaminación cruzada. Esto se debe a que las máquinas utilizadas para elaborar o empacar
///un producto que no contiene determinados alérgenos, pueden ser usadas para elaborar otros
///productos que sí los contienen (ej: "Puede contener trazas de", "Elaborado en líneas que
///también procesan", etc).
///- **nutritionalTraces** **`(array)`**: Arreglo de objetos con la lista de todos los
///ingredientes que podrían aparecer como trazas nutricionales. Cada ingrediente tiene la
///siguiente estructura:
///- **id** **`(string)`**: Identificador único del ingrediente.
///- **name** **`(string)`**: Nombre del ingrediente
///- **mechanicalTracesText** **`(string)`**: Título utilizado para mencionar aquellos
///residuos (cuescos, cáscaras) que podrían estar contenidos en el producto, y que podrían
///causar algún malestar o dolor al consumidor (ej: "Puede contener trazas mecánicas de",
///"Puede contener", etc).
///- **mechanicalTraces** **`(array)`**: Arreglo de objetos con la lista de todos los
///ingredientes que podrían aparecer como trazas mecánicas. Cada ingrediente tiene la
///siguiente estructura:
///- **id** **`(string)`**: Identificador único del ingrediente.
///- **name** **`(string)`**: Nombre del ingrediente
///- **annotation** **`(string)`**: Texto opcional con información que podría ser de interés
///del usuario pero que no altera las propiedades nutricionales del producto (ej: "Contiene
///ingredientes de origen transgénico").
///- **nutritionalTable** **`(object)`**: Tabla nutricional
///- **portionText** **`(string)`**: Descripción coloquial de la porción.
///- **portionValue** **`(string)`**: Tamaño de la porción.
///- **totalPortions** **`(float)`**: Cantidad de porciones en este producto.
///- **fields** **`(array)`**: Este arreglo contiene a su vez otros arreglos que permiten
///desplegar la Tabla Nutricional del producto. El primer elemento de este arreglo define la
///cantidad de columnas y sus títulos, y el resto de los arreglos contienen la información
///de cada fila.
///`Ejemplo: [["","100g","1 Porción"],["Energía (kCal)","338","229,8"],["Proteínas
///(g)","2,7","1,8"],...]`
///- **annotation** **`(string)`**: Texto opcional con información complementaria a la Tabla
///Nutricional (ej: "Basado en una dieta de 2.000 calorías diarias").
///- **sweetenerTable** **`(object)`**: Tabla de Ingesta Diaria Admisible (I.D.A.) de
///edulcorantes.
///- **fields** **`(array)`**: Este arreglo contiene a su vez otros arreglos que permiten
///desplegar la Tabla de I.D.A. del producto. El primer elemento de este arreglo define la
///cantidad de columnas y sus títulos, y el resto de los arreglos contienen la información
///de cada fila. `Ejemplo: [["Endulzante","100 ml","1 porción","I.D.A."],["Estevia
///Rebaudiana","2,4 g","6,0 mg","0-4 mg/Kg en base a esteviol"],["Sucralosa","2,3 g","5,8
///mg","0-15 mg/Kg"]]`
///- **annotation** **`(string)`**: Texto opcional con información complementaria a la tabla
///de I.D.A. (ej: "Ingesta Diaria Admisible por 1 Kg de peso corporal").
///- **alcoholByVolume** **`(string)`**: Graduación alcohólica por volumen.
///- **alcoholProof** **`(string)`**: Graduación alcohólica "proof".
///- **promotionalInformation** **`(object)`**:
///- **description** **`(string)`**: Texto con descripción _emocional_ utilizado por el
///productor o importador para describir el producto.
///- **claims** **`(array)`**: Arreglo de strings, donde cada uno es una afirmación que el
///productor o importador hacen del producto. Ejemplos: "Buena fuente de proteínas", "Ideal
///para viajes", etc.
///- **multimedia** **`(array)`**: Arreglo de objetos con material promocional general del
///producto, que puede ser de utilidad para sitios de ecommerce y apps al momento de mostrar
///el producto al consumidor final. Cada objeto tiene la siguiente estructura:
///- **type** **`(string)`**: Puede tener los siguientes valores: "image", "video" o
///"X3D".
///- **description** **`(string)`**: Descripción del recurso.
///- **url** **`(string)`**: URL pública desde la cual obtener el recurso.
///- **consumption** **`(object)`**: Objeto que indica las condiciones de almacenamiento y
///directrices para su consumo o uso.
///- **timespan** **`(string)`**: Duración del producto. Ej: "Consumir antes de 12 meses
///según fecha impresa en la tapa del empaque".
///- **storageConditions** **`(string)`**: Condiciones de almacenamiento. Ej: "Consérvese en
///lugar fresco y seco. Una vez abierto, mantener refrigerado y consumir antes de 4
///días".
///- **directions** **`(string)`**: Instrucciones de preparación o consumo. Ej: "Hornear por
///15 minutos en horno precalentado a 180°C".
///- **packaging** **`(object)`**: Objeto con las características del empaque como su
///materialidad y dimensiones. De momento solo se entregará la información externa del
///empaque en el objeto `outer`, cuya estructura es la siguiente:
///- **typeId** **`(int)`**: Identificador único del tipo de empaque.
///- **typeName** **`(string)`**: Nombre del tipo de empaque.
///- **materials** **`(array)`**: Arreglo de strings, donde cada uno indica los materiales
///presentes en el empaque.
///- **origin** **`(object)`**: Objeto con la información de las empresas involucradas en la
///producción, distribución e importación del producto, y sus respectivos países.
///- **producer** **`(object)`**: Información del productor.
///- **companyId** **`(int)`**: Identificador único de la compañía.
///- **companyName** **`(string)`**: Nombre de la compañía.
///- **countryId** **`(int)`**: Identificador del país al cual pertenece la compañía (según
///el estándar ISO 3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país al cual pertenece la
///compañía (según el estándar ISO 3166-1).
///- **countryName** **`(string)`**: Nombre del país de la compañía.
///- **packer** **`(object)`**: Información del empacador.
///- **companyId** **`(int)`**: Identificador único de la compañía.
///- **companyName** **`(string)`**: Nombre de la compañía.
///- **countryId** **`(int)`**: Identificador del país al cual pertenece la compañía (según
///el estándar ISO 3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país al cual pertenece la
///compañía (según el estándar ISO 3166-1).
///- **countryName** **`(string)`**: Nombre del país de la compañía.
///- **importer** **`(object)`**: Información del importador.
///- **companyId** **`(int)`**: Identificador único de la compañía.
///- **companyName** **`(string)`**: Nombre de la compañía.
///- **countryId** **`(int)`**: Identificador del país al cual pertenece la compañía (según
///el estándar ISO 3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país al cual pertenece la
///compañía (según el estándar ISO 3166-1).
///- **countryName** **`(string)`**: Nombre del país de la compañía.
///- **distributor** **`(object)`**: Información del distribuidor.
///- **companyId** **`(int)`**: Identificador único de la compañía.
///- **companyName** **`(string)`**: Nombre de la compañía.
///- **countryId** **`(int)`**: Identificador del país al cual pertenece la compañía (según
///el estándar ISO 3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país al cual pertenece la
///compañía (según el estándar ISO 3166-1).
///- **countryName** **`(string)`**: Nombre del país de la compañía.
///- **componentsOrigin** **`(array)`**: Arreglo de objetos con la información de el o los
///países de donde provienen los componentes del producto. Cada objeto tiene la siguiente
///estructura:
///- **countryId** **`(int)`**: Identificador del país (según el estándar ISO
///3166-1).
///- **countryCode** **`(string)`**: Código de 2 letras del país (según el estándar ISO
///3166-1).
///- **countryName** **`(string)`**: Nombre del país.
///- **favoritesList** **`(array)`**: Arreglo de objetos que indica en cuáles listas de
///favoritos el usuario ha añadido este producto. Cada objeto tiene la siguiente
///estructura:
///
///- **id** **`(int)`**: Identificador único de la Lista de Favoritos (llamados "FLID" y que
///se explican más adelante en esta documentación).
///
///- **name** **`(string)`**: Nombre de la Lista de Favoritos.
///- **lastUpdate** **`(int)`**: Timestamp de la última vez que se actualizó la lista
///(medido en segundos desde el Unix Epoch).
///- **totalItems** **`(int)`**: Cantidad de productos contenidos en la Lista de Favoritos.
///- **whoCanShop** **`(object)`**: Este objeto contiene en su interior otros objetos, cuyas
///llaves son los identificadores de los integrantes del grupo familiar del usuario
///(llamados "FMID" y que se explican más adelante en esta documentación). Cada integrante
///contiene un `status` indicando si el producto es apto (1), dudoso (-1) o no apto (-2).
class ProductDetailsUsingId {
  int errorId;
  ProductDetailsUsingIdResponse response;
  double serverTime;

  ProductDetailsUsingId({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ProductDetailsUsingId.fromJson(Map<String, dynamic> json) =>
      ProductDetailsUsingId(
        errorId: json["errorId"],
        response: ProductDetailsUsingIdResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

class ProductDetailsUsingIdResponse {
  String id;
  int tradingCountryId;
  String tradingCountryCode;
  String tradingCountryName;
  String language;
  bool suspended;
  bool sponsored;
  Chronology chronology;
  List<dynamic> identifiers;
  BasicInformation basicInformation;
  List<dynamic> additionalInformation;
  List<SuitabilityElement> suitability;
  List<Symbol> symbols;
  Content content;
  List<Element> elements;
  PromotionalInformation promotionalInformation;
  List<dynamic> multimedia;
  Consumption consumption;
  Packaging packaging;
  Origin origin;
  List<dynamic> favoritesList;
  FluffyWhoCanShop whoCanShop;

  ProductDetailsUsingIdResponse({
    required this.id,
    required this.tradingCountryId,
    required this.tradingCountryCode,
    required this.tradingCountryName,
    required this.language,
    required this.suspended,
    required this.sponsored,
    required this.chronology,
    required this.identifiers,
    required this.basicInformation,
    required this.additionalInformation,
    required this.suitability,
    required this.symbols,
    required this.content,
    required this.elements,
    required this.promotionalInformation,
    required this.multimedia,
    required this.consumption,
    required this.packaging,
    required this.origin,
    required this.favoritesList,
    required this.whoCanShop,
  });

  factory ProductDetailsUsingIdResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsUsingIdResponse(
        id: json["id"],
        tradingCountryId: json["tradingCountryId"],
        tradingCountryCode: json["tradingCountryCode"],
        tradingCountryName: json["tradingCountryName"],
        language: json["language"],
        suspended: json["suspended"],
        sponsored: json["sponsored"],
        chronology: Chronology.fromJson(json["chronology"]),
        identifiers: List<dynamic>.from(json["identifiers"].map((x) => x)),
        basicInformation: BasicInformation.fromJson(json["basicInformation"]),
        additionalInformation:
            List<dynamic>.from(json["additionalInformation"].map((x) => x)),
        suitability: List<SuitabilityElement>.from(
            json["suitability"].map((x) => SuitabilityElement.fromJson(x))),
        symbols:
            List<Symbol>.from(json["symbols"].map((x) => Symbol.fromJson(x))),
        content: Content.fromJson(json["content"]),
        elements: List<Element>.from(
            json["elements"].map((x) => Element.fromJson(x))),
        promotionalInformation:
            PromotionalInformation.fromJson(json["promotionalInformation"]),
        multimedia: List<dynamic>.from(json["multimedia"].map((x) => x)),
        consumption: Consumption.fromJson(json["consumption"]),
        packaging: Packaging.fromJson(json["packaging"]),
        origin: Origin.fromJson(json["origin"]),
        favoritesList: List<dynamic>.from(json["favoritesList"].map((x) => x)),
        whoCanShop: FluffyWhoCanShop.fromJson(json["whoCanShop"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tradingCountryId": tradingCountryId,
        "tradingCountryCode": tradingCountryCode,
        "tradingCountryName": tradingCountryName,
        "language": language,
        "suspended": suspended,
        "sponsored": sponsored,
        "chronology": chronology.toJson(),
        "identifiers": List<dynamic>.from(identifiers.map((x) => x)),
        "basicInformation": basicInformation.toJson(),
        "additionalInformation":
            List<dynamic>.from(additionalInformation.map((x) => x)),
        "suitability": List<dynamic>.from(suitability.map((x) => x.toJson())),
        "symbols": List<dynamic>.from(symbols.map((x) => x.toJson())),
        "content": content.toJson(),
        "elements": List<dynamic>.from(elements.map((x) => x.toJson())),
        "promotionalInformation": promotionalInformation.toJson(),
        "multimedia": List<dynamic>.from(multimedia.map((x) => x)),
        "consumption": consumption.toJson(),
        "packaging": packaging.toJson(),
        "origin": origin.toJson(),
        "favoritesList": List<dynamic>.from(favoritesList.map((x) => x)),
        "whoCanShop": whoCanShop.toJson(),
      };
}

class BasicInformation {
  String photoUrl;
  String bigPhotoUrl;
  String photoSource;
  int categoryId;
  String categoryName;
  List<Brand> brands;
  String description;
  String variant;

  BasicInformation({
    required this.photoUrl,
    required this.bigPhotoUrl,
    required this.photoSource,
    required this.categoryId,
    required this.categoryName,
    required this.brands,
    required this.description,
    required this.variant,
  });

  factory BasicInformation.fromJson(Map<String, dynamic> json) =>
      BasicInformation(
        photoUrl: json["photoUrl"],
        bigPhotoUrl: json["bigPhotoUrl"],
        photoSource: json["photoSource"],
        categoryId: json["categoryId"],
        categoryName: json["categoryName"],
        brands: List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        description: json["description"],
        variant: json["variant"],
      );

  Map<String, dynamic> toJson() => {
        "photoUrl": photoUrl,
        "bigPhotoUrl": bigPhotoUrl,
        "photoSource": photoSource,
        "categoryId": categoryId,
        "categoryName": categoryName,
        "brands": List<dynamic>.from(brands.map((x) => x.toJson())),
        "description": description,
        "variant": variant,
      };
}

class Brand {
  int id;
  String name;

  Brand({
    required this.id,
    required this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Chronology {
  int timestampIn;
  int lastReview;
  int lastUpdate;
  int version;
  int timestampOut;

  Chronology({
    required this.timestampIn,
    required this.lastReview,
    required this.lastUpdate,
    required this.version,
    required this.timestampOut,
  });

  factory Chronology.fromJson(Map<String, dynamic> json) => Chronology(
        timestampIn: json["timestampIn"],
        lastReview: json["lastReview"],
        lastUpdate: json["lastUpdate"],
        version: json["version"],
        timestampOut: json["timestampOut"],
      );

  Map<String, dynamic> toJson() => {
        "timestampIn": timestampIn,
        "lastReview": lastReview,
        "lastUpdate": lastUpdate,
        "version": version,
        "timestampOut": timestampOut,
      };
}

class Consumption {
  String timespan;
  String storageConditions;
  String directions;

  Consumption({
    required this.timespan,
    required this.storageConditions,
    required this.directions,
  });

  factory Consumption.fromJson(Map<String, dynamic> json) => Consumption(
        timespan: json["timespan"],
        storageConditions: json["storageConditions"],
        directions: json["directions"],
      );

  Map<String, dynamic> toJson() => {
        "timespan": timespan,
        "storageConditions": storageConditions,
        "directions": directions,
      };
}

class Content {
  int totalItems;
  Item item;
  Item net;
  Drained drained;
  bool isPack;
  List<dynamic> packProducts;

  Content({
    required this.totalItems,
    required this.item,
    required this.net,
    required this.drained,
    required this.isPack,
    required this.packProducts,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        totalItems: json["totalItems"],
        item: Item.fromJson(json["item"]),
        net: Item.fromJson(json["net"]),
        drained: Drained.fromJson(json["drained"]),
        isPack: json["isPack"],
        packProducts: List<dynamic>.from(json["packProducts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "item": item.toJson(),
        "net": net.toJson(),
        "drained": drained.toJson(),
        "isPack": isPack,
        "packProducts": List<dynamic>.from(packProducts.map((x) => x)),
      };
}

class Drained {
  int weightValue;
  Unit weightMeasurementUnit;

  Drained({
    required this.weightValue,
    required this.weightMeasurementUnit,
  });

  factory Drained.fromJson(Map<String, dynamic> json) => Drained(
        weightValue: json["weightValue"],
        weightMeasurementUnit: unitValues.map[json["weightMeasurementUnit"]]!,
      );

  Map<String, dynamic> toJson() => {
        "weightValue": weightValue,
        "weightMeasurementUnit": unitValues.reverse[weightMeasurementUnit],
      };
}

class Item {
  int weightValue;
  dynamic volumeValue;
  Unit weightMeasurementUnit;
  String volumeMeasurementUnit;

  Item({
    required this.weightValue,
    required this.volumeValue,
    required this.weightMeasurementUnit,
    required this.volumeMeasurementUnit,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        weightValue: json["weightValue"],
        volumeValue: json["volumeValue"],
        weightMeasurementUnit: unitValues.map[json["weightMeasurementUnit"]]!,
        volumeMeasurementUnit: json["volumeMeasurementUnit"],
      );

  Map<String, dynamic> toJson() => {
        "weightValue": weightValue,
        "volumeValue": volumeValue,
        "weightMeasurementUnit": unitValues.reverse[weightMeasurementUnit],
        "volumeMeasurementUnit": volumeMeasurementUnit,
      };
}

class Element {
  String title;
  String form;
  List<IngredientElement> ingredients;
  String containsText;
  List<dynamic> contains;
  String nutritionalTracesText;
  List<IngredientElement> nutritionalTraces;
  String mechanicalTracesText;
  List<dynamic> mechanicalTraces;
  String annotation;
  NutritionalTable nutritionalTable;
  SweetenerTable sweetenerTable;
  String alcoholByVolume;
  String alcoholProof;

  Element({
    required this.title,
    required this.form,
    required this.ingredients,
    required this.containsText,
    required this.contains,
    required this.nutritionalTracesText,
    required this.nutritionalTraces,
    required this.mechanicalTracesText,
    required this.mechanicalTraces,
    required this.annotation,
    required this.nutritionalTable,
    required this.sweetenerTable,
    required this.alcoholByVolume,
    required this.alcoholProof,
  });

  factory Element.fromJson(Map<String, dynamic> json) => Element(
        title: json["title"],
        form: json["form"],
        ingredients: List<IngredientElement>.from(
            json["ingredients"].map((x) => IngredientElement.fromJson(x))),
        containsText: json["containsText"],
        contains: List<dynamic>.from(json["contains"].map((x) => x)),
        nutritionalTracesText: json["nutritionalTracesText"],
        nutritionalTraces: List<IngredientElement>.from(
            json["nutritionalTraces"]
                .map((x) => IngredientElement.fromJson(x))),
        mechanicalTracesText: json["mechanicalTracesText"],
        mechanicalTraces:
            List<dynamic>.from(json["mechanicalTraces"].map((x) => x)),
        annotation: json["annotation"],
        nutritionalTable: NutritionalTable.fromJson(json["nutritionalTable"]),
        sweetenerTable: SweetenerTable.fromJson(json["sweetenerTable"]),
        alcoholByVolume: json["alcoholByVolume"],
        alcoholProof: json["alcoholProof"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "form": form,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
        "containsText": containsText,
        "contains": List<dynamic>.from(contains.map((x) => x)),
        "nutritionalTracesText": nutritionalTracesText,
        "nutritionalTraces":
            List<dynamic>.from(nutritionalTraces.map((x) => x.toJson())),
        "mechanicalTracesText": mechanicalTracesText,
        "mechanicalTraces": List<dynamic>.from(mechanicalTraces.map((x) => x)),
        "annotation": annotation,
        "nutritionalTable": nutritionalTable.toJson(),
        "sweetenerTable": sweetenerTable.toJson(),
        "alcoholByVolume": alcoholByVolume,
        "alcoholProof": alcoholProof,
      };
}

class NutritionalTable {
  String portionText;
  String portionValue;
  String totalPortions;
  List<List<String>> fields;
  String annotation;

  NutritionalTable({
    required this.portionText,
    required this.portionValue,
    required this.totalPortions,
    required this.fields,
    required this.annotation,
  });

  factory NutritionalTable.fromJson(Map<String, dynamic> json) =>
      NutritionalTable(
        portionText: json["portionText"],
        portionValue: json["portionValue"],
        totalPortions: json["totalPortions"],
        fields: List<List<String>>.from(
            json["fields"].map((x) => List<String>.from(x.map((x) => x)))),
        annotation: json["annotation"],
      );

  Map<String, dynamic> toJson() => {
        "portionText": portionText,
        "portionValue": portionValue,
        "totalPortions": totalPortions,
        "fields": List<dynamic>.from(
            fields.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "annotation": annotation,
      };
}

class SweetenerTable {
  List<dynamic> fields;
  String annotation;

  SweetenerTable({
    required this.fields,
    required this.annotation,
  });

  factory SweetenerTable.fromJson(Map<String, dynamic> json) => SweetenerTable(
        fields: List<dynamic>.from(json["fields"].map((x) => x)),
        annotation: json["annotation"],
      );

  Map<String, dynamic> toJson() => {
        "fields": List<dynamic>.from(fields.map((x) => x)),
        "annotation": annotation,
      };
}

class Origin {
  Distributor producer;
  Distributor packer;
  Distributor importer;
  Distributor distributor;
  List<dynamic> componentsOrigin;

  Origin({
    required this.producer,
    required this.packer,
    required this.importer,
    required this.distributor,
    required this.componentsOrigin,
  });

  factory Origin.fromJson(Map<String, dynamic> json) => Origin(
        producer: Distributor.fromJson(json["producer"]),
        packer: Distributor.fromJson(json["packer"]),
        importer: Distributor.fromJson(json["importer"]),
        distributor: Distributor.fromJson(json["distributor"]),
        componentsOrigin:
            List<dynamic>.from(json["componentsOrigin"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "producer": producer.toJson(),
        "packer": packer.toJson(),
        "importer": importer.toJson(),
        "distributor": distributor.toJson(),
        "componentsOrigin": List<dynamic>.from(componentsOrigin.map((x) => x)),
      };
}

class Distributor {
  int companyId;
  String companyName;
  int countryId;
  String countryCode;
  String countryName;

  Distributor({
    required this.companyId,
    required this.companyName,
    required this.countryId,
    required this.countryCode,
    required this.countryName,
  });

  factory Distributor.fromJson(Map<String, dynamic> json) => Distributor(
        companyId: json["companyId"],
        companyName: json["companyName"],
        countryId: json["countryId"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
      );

  Map<String, dynamic> toJson() => {
        "companyId": companyId,
        "companyName": companyName,
        "countryId": countryId,
        "countryCode": countryCode,
        "countryName": countryName,
      };
}

class Packaging {
  Outer outer;

  Packaging({
    required this.outer,
  });

  factory Packaging.fromJson(Map<String, dynamic> json) => Packaging(
        outer: Outer.fromJson(json["outer"]),
      );

  Map<String, dynamic> toJson() => {
        "outer": outer.toJson(),
      };
}

class Outer {
  int typeId;
  String typeName;
  List<dynamic> materials;

  Outer({
    required this.typeId,
    required this.typeName,
    required this.materials,
  });

  factory Outer.fromJson(Map<String, dynamic> json) => Outer(
        typeId: json["typeId"],
        typeName: json["typeName"],
        materials: List<dynamic>.from(json["materials"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "typeId": typeId,
        "typeName": typeName,
        "materials": List<dynamic>.from(materials.map((x) => x)),
      };
}

class PromotionalInformation {
  String description;
  List<dynamic> claims;

  PromotionalInformation({
    required this.description,
    required this.claims,
  });

  factory PromotionalInformation.fromJson(Map<String, dynamic> json) =>
      PromotionalInformation(
        description: json["description"],
        claims: List<dynamic>.from(json["claims"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "claims": List<dynamic>.from(claims.map((x) => x)),
      };
}

class SuitabilityElement {
  String? code;
  String name;
  String pngImagePath;
  String svgImagePath;
  List<DeclaredBy>? declaredBy;
  int? id;
  List<Brand>? options;

  SuitabilityElement({
    this.code,
    required this.name,
    required this.pngImagePath,
    required this.svgImagePath,
    this.declaredBy,
    this.id,
    this.options,
  });

  factory SuitabilityElement.fromJson(Map<String, dynamic> json) =>
      SuitabilityElement(
        code: json["code"],
        name: json["name"],
        pngImagePath: json["pngImagePath"],
        svgImagePath: json["svgImagePath"],
        declaredBy: json["declaredBy"] == null
            ? []
            : List<DeclaredBy>.from(
                json["declaredBy"]!.map((x) => DeclaredBy.fromJson(x))),
        id: json["id"],
        options: json["options"] == null
            ? []
            : List<Brand>.from(json["options"]!.map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "pngImagePath": pngImagePath,
        "svgImagePath": svgImagePath,
        "declaredBy": declaredBy == null
            ? []
            : List<dynamic>.from(declaredBy!.map((x) => x.toJson())),
        "id": id,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class DeclaredBy {
  int id;
  String name;
  String logoUrl;
  int countryId;
  String countryCode;
  String countryName;
  int degreeId;
  String degreeName;
  int start;
  int end;
  int lastUpdate;
  String htmlContent;
  String actionUrl;

  DeclaredBy({
    required this.id,
    required this.name,
    required this.logoUrl,
    required this.countryId,
    required this.countryCode,
    required this.countryName,
    required this.degreeId,
    required this.degreeName,
    required this.start,
    required this.end,
    required this.lastUpdate,
    required this.htmlContent,
    required this.actionUrl,
  });

  factory DeclaredBy.fromJson(Map<String, dynamic> json) => DeclaredBy(
        id: json["id"],
        name: json["name"],
        logoUrl: json["logoUrl"],
        countryId: json["countryId"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
        degreeId: json["degreeId"],
        degreeName: json["degreeName"],
        start: json["start"],
        end: json["end"],
        lastUpdate: json["lastUpdate"],
        htmlContent: json["htmlContent"],
        actionUrl: json["actionUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logoUrl": logoUrl,
        "countryId": countryId,
        "countryCode": countryCode,
        "countryName": countryName,
        "degreeId": degreeId,
        "degreeName": degreeName,
        "start": start,
        "end": end,
        "lastUpdate": lastUpdate,
        "htmlContent": htmlContent,
        "actionUrl": actionUrl,
      };
}

class Symbol {
  int id;
  String type;
  String code;
  String name;
  String pngImagePath;
  String svgImagePath;

  Symbol({
    required this.id,
    required this.type,
    required this.code,
    required this.name,
    required this.pngImagePath,
    required this.svgImagePath,
  });

  factory Symbol.fromJson(Map<String, dynamic> json) => Symbol(
        id: json["id"],
        type: json["type"],
        code: json["code"],
        name: json["name"],
        pngImagePath: json["pngImagePath"],
        svgImagePath: json["svgImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "code": code,
        "name": name,
        "pngImagePath": pngImagePath,
        "svgImagePath": svgImagePath,
      };
}

class FluffyWhoCanShop {
  Fluffy119828 the119828;

  FluffyWhoCanShop({
    required this.the119828,
  });

  factory FluffyWhoCanShop.fromJson(Map<String, dynamic> json) =>
      FluffyWhoCanShop(
        the119828: Fluffy119828.fromJson(json["119828"]),
      );

  Map<String, dynamic> toJson() => {
        "119828": the119828.toJson(),
      };
}

class Fluffy119828 {
  int status;
  List<dynamic> ingredients;

  Fluffy119828({
    required this.status,
    required this.ingredients,
  });

  factory Fluffy119828.fromJson(Map<String, dynamic> json) => Fluffy119828(
        status: json["status"],
        ingredients: List<dynamic>.from(json["ingredients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
      };
}

///Product Sponsored Content
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID/sponsoredContent
///
///A través de OK to Shop, las empresas productoras e importadoras de alimentos pueden
///entregar contenido patrocinado personalizado de acuerdo a las preferencias del usuario,
///su ubicación geográfica y/o fecha y hora en que está consultando alguno de sus
///productos.
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando esta información.
///
///Cuando hay contenido patrocinado disponible para un producto, este endpoint devuelve un
///arreglo de objetos, cada uno de los cuales tiene la siguiente estructura:
///
///- **type** **`(string)`**: Puede tener cinco valores: "video", "image", "text", "button"
///o "socialMedia".
///
///- **mediaUrl** **`(string)`**: Cuando el tipo es "video" o "image" este campo contendrá
///la URL al recurso. En el caso de ser un video, éste puede venir de YouTube o Vimeo.
///
///- **actionUrl** **`(string)`**: Cuando el tipo es "button" o "socialMedia" este campo
///contendrá la URL a la cual será redirigido el usuario.
///
///- **content** **`(string)`**: Texto plano a desplegar cuando el tipo es "text" o
///"button". Cuando el tipo es "socialMedia", este campo se utiliza para determinar el icono
///a desplegar, en cuyo caso los valores posibles son `instagram`, `facebook`, `youtube`,
///`vimeo`, `linkedin`, `tiktok`, `threads`, `twitch` y `discord`.
///
///- **htmlContent** **`(string)`**: Texto enriquecido (HTML) a desplegar cuando el tipo es
///"text" o "button".
class ProductSponsoredContent {
  int errorId;
  List<ProductSponsoredContentResponse> response;
  double serverTime;

  ProductSponsoredContent({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ProductSponsoredContent.fromJson(Map<String, dynamic> json) =>
      ProductSponsoredContent(
        errorId: json["errorId"],
        response: List<ProductSponsoredContentResponse>.from(json["response"]
            .map((x) => ProductSponsoredContentResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ProductSponsoredContentResponse {
  String type;
  String mediaUrl;
  String actionUrl;
  String content;
  String htmlContent;

  ProductSponsoredContentResponse({
    required this.type,
    required this.mediaUrl,
    required this.actionUrl,
    required this.content,
    required this.htmlContent,
  });

  factory ProductSponsoredContentResponse.fromJson(Map<String, dynamic> json) =>
      ProductSponsoredContentResponse(
        type: json["type"],
        mediaUrl: json["mediaUrl"],
        actionUrl: json["actionUrl"],
        content: json["content"],
        htmlContent: json["htmlContent"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "mediaUrl": mediaUrl,
        "actionUrl": actionUrl,
        "content": content,
        "htmlContent": htmlContent,
      };
}

///Product Suitable Alternatives
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID/alternatives?page=1&pageSize=20
///
///Devuelve una **"Lista de productos OKTS"** con productos alternativos al consultado que
///son aptos para el usuario, en la misma categoría o una similar, para el país que tiene
///seleccionado.
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando esta información.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class ProductSuitableAlternatives {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  ProductSuitableAlternatives({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory ProductSuitableAlternatives.fromJson(Map<String, dynamic> json) =>
      ProductSuitableAlternatives(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Stores that sell this product
///
///GET {{url}}/products/OK_TO_SHOP_PRODUCT_ID/stores?page=1&pageSize=20
///
///Entrega una lista de todas las tiendas registradas en OK to Shop que venden este producto
///y su precio de venta. Para cada tienda se entregan los siguientes detalles:
///
///- **name** **`(string)`**: Nombre de la tienda física, app o sitio de ecommerce.
///
///- **type** **`(string)`**: Puede tener dos valores: "online" u "offline".
///
///- **siteUrl** **`(string)`**: Para las tiendas del tipo "online", indica la URL del sitio
///web principal.
///
///- **productUrl** **`(string)`**: Para las tiendas del tipo "online", indica la URL donde
///se encuentra el producto.
///
///- **latitude** **`(float)`**: Para las tiendas del tipo "offline", indica la latitud
///usando el sistema WGS842 (mismo que utiliza Google Maps).
///
///- **longitude** **`(float)`**: Para las tiendas del tipo "offline", indica la longitud
///usando el sistema WGS842 (mismo que utiliza Google Maps).
///
///- **address** **`(string)`**: Para las tiendas del tipo "offline", indica la
///dirección.
///
///- **inStoreLocation** **`(string)`**: Para las tiendas del tipo "offline", indica la
///ubicación del producto dentro de la tienda.
///
///- **logoUrl** **`(string)`**: URL del logo de la tienda.
///
///- **lastUpdate** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) de la
///última actualización de este precio.
///
///- **sponsored** **`(boolean)`**: Indica si la tienda en cuestión está apareciendo en los
///primeros lugares debido a que está siendo promocionada.
///
///- **price** **`(object)`**:
///
///- **value** **`(float)`**: Precio sin formato.
///
///- **formatted** **`(string)`**: Precio con formato.
///
///- **currency** **`(string)`**: Moneda.
///
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto (dentro de la base
///de datos de OK to Shop) para el cual se está consultando esta información.
class StoresThatSellThisProduct {
  int errorId;
  List<StoresThatSellThisProductResponse> response;
  Pagination pagination;
  double serverTime;

  StoresThatSellThisProduct({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory StoresThatSellThisProduct.fromJson(Map<String, dynamic> json) =>
      StoresThatSellThisProduct(
        errorId: json["errorId"],
        response: List<StoresThatSellThisProductResponse>.from(json["response"]
            .map((x) => StoresThatSellThisProductResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

class StoresThatSellThisProductResponse {
  String name;
  String type;
  String siteUrl;
  String productUrl;
  double latitude;
  double longitude;
  String address;
  String inStoreLocation;
  String logoUrl;
  int lastUpdate;
  bool sponsored;
  Price price;

  StoresThatSellThisProductResponse({
    required this.name,
    required this.type,
    required this.siteUrl,
    required this.productUrl,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.inStoreLocation,
    required this.logoUrl,
    required this.lastUpdate,
    required this.sponsored,
    required this.price,
  });

  factory StoresThatSellThisProductResponse.fromJson(
          Map<String, dynamic> json) =>
      StoresThatSellThisProductResponse(
        name: json["name"],
        type: json["type"],
        siteUrl: json["siteUrl"],
        productUrl: json["productUrl"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        address: json["address"],
        inStoreLocation: json["inStoreLocation"],
        logoUrl: json["logoUrl"],
        lastUpdate: json["lastUpdate"],
        sponsored: json["sponsored"],
        price: Price.fromJson(json["price"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "siteUrl": siteUrl,
        "productUrl": productUrl,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
        "inStoreLocation": inStoreLocation,
        "logoUrl": logoUrl,
        "lastUpdate": lastUpdate,
        "sponsored": sponsored,
        "price": price.toJson(),
      };
}

class Price {
  int value;
  String formatted;
  String currency;

  Price({
    required this.value,
    required this.formatted,
    required this.currency,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        value: json["value"],
        formatted: json["formatted"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "formatted": formatted,
        "currency": currency,
      };
}

///List of Filters
///
///GET {{url}}/products/filters
///
///Cada Filtro tiene un nombre, un código, un identificador único, y links a las imágenes
///respectivas en formato PNG transparente y SVG.
///
///Algunos filtros tienen opciones adicionales (en el arreglo `options`)
///
///El resultado de hacer este llamado entregará distintas respuestas dependiendo del país
///que tenga configurado el usuario.
class ListOfFilters {
  int errorId;
  List<ListOfFiltersResponse> response;
  double serverTime;

  ListOfFilters({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfFilters.fromJson(Map<String, dynamic> json) => ListOfFilters(
        errorId: json["errorId"],
        response: List<ListOfFiltersResponse>.from(
            json["response"].map((x) => ListOfFiltersResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ListOfFiltersResponse {
  int id;
  String code;
  String name;
  String pngImagePath;
  String svgImagePath;
  int minimumSelected;
  List<Brand> options;

  ListOfFiltersResponse({
    required this.id,
    required this.code,
    required this.name,
    required this.pngImagePath,
    required this.svgImagePath,
    required this.minimumSelected,
    required this.options,
  });

  factory ListOfFiltersResponse.fromJson(Map<String, dynamic> json) =>
      ListOfFiltersResponse(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        pngImagePath: json["pngImagePath"],
        svgImagePath: json["svgImagePath"],
        minimumSelected: json["minimumSelected"],
        options:
            List<Brand>.from(json["options"].map((x) => Brand.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "pngImagePath": pngImagePath,
        "svgImagePath": svgImagePath,
        "minimumSelected": minimumSelected,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

///List of Suitability Types
///
///GET {{url}}/products/suitability
///
///Cada Tipo de Aptitud tiene:
///
///- **id** **`(int)`**: Identificador único del Tipo de Aptitud.
///
///- **code** **`(string)`**: Código del Tipo de Aptitud.
///
///- **certifiedName** **`(string)`**: Nombre que se utiliza cuando se trata de información
///obtenida de algún sello o entidad certificadora.
///
///- **inferredName** **`(string)`**: Nombre que se utiliza cuando se infiere una propiedad
///o aptitud en función del contenido del empaque.
///
///- **nutritionRelated** **`(boolean)`**: Marca que indica si se trata de algún sello o
///certificación relacionado con nutrición.
///
///- **pngImagePath** **`(string)`**: Link a un icono de referencia en formato PNG
///transparente.
///
///- **svgImagePath** **`(string)`**: Link a un icono de referencia en formato SVG.
class ListOfSuitabilityTypes {
  int errorId;
  List<ListOfSuitabilityTypesResponse> response;
  double serverTime;

  ListOfSuitabilityTypes({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfSuitabilityTypes.fromJson(Map<String, dynamic> json) =>
      ListOfSuitabilityTypes(
        errorId: json["errorId"],
        response: List<ListOfSuitabilityTypesResponse>.from(json["response"]
            .map((x) => ListOfSuitabilityTypesResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

class ListOfSuitabilityTypesResponse {
  int id;
  String code;
  String certifiedName;
  String inferredName;
  bool nutritionRelated;
  String pngImagePath;
  String svgImagePath;

  ListOfSuitabilityTypesResponse({
    required this.id,
    required this.code,
    required this.certifiedName,
    required this.inferredName,
    required this.nutritionRelated,
    required this.pngImagePath,
    required this.svgImagePath,
  });

  factory ListOfSuitabilityTypesResponse.fromJson(Map<String, dynamic> json) =>
      ListOfSuitabilityTypesResponse(
        id: json["id"],
        code: json["code"],
        certifiedName: json["certifiedName"],
        inferredName: json["inferredName"],
        nutritionRelated: json["nutritionRelated"],
        pngImagePath: json["pngImagePath"],
        svgImagePath: json["svgImagePath"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "certifiedName": certifiedName,
        "inferredName": inferredName,
        "nutritionRelated": nutritionRelated,
        "pngImagePath": pngImagePath,
        "svgImagePath": svgImagePath,
      };
}

///List of Warning Signs
///
///GET {{url}}/products/warnings
///
///Cada Sello de Advertencia tiene un nombre, un código, un identificador único, y links a
///las imágenes respectivas en formato PNG transparente y SVG.
///
///El resultado de hacer este llamado entregará distintas respuestas dependiendo del país
///que tenga configurado el usuario.
class ListOfWarningSigns {
  int errorId;
  List<SuitabilityElement> response;
  double serverTime;

  ListOfWarningSigns({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfWarningSigns.fromJson(Map<String, dynamic> json) =>
      ListOfWarningSigns(
        errorId: json["errorId"],
        response: List<SuitabilityElement>.from(
            json["response"].map((x) => SuitabilityElement.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

///Send Feedback for Product
///
///POST {{url}}/products/OK_TO_SHOP_PRODUCT_ID/feedback
///
///`OK_TO_SHOP_PRODUCT_ID` se refiere al Identificador único del producto para el cual se
///están enviando estas fotografías.
///
///El arreglo `photos` debe contener las imágenes a enviar, codificadas como strings en Base
///64. Los tipos de imágenes soportados son `image/png`, `image/gif`, `image/jpeg` y
///`image/webp`.
///
///El string `comments` (opcional) debe tener máximo 65.535 caracteres de longitud, y se
///utiliza para que el equipo de analistas de OK to Shop tenga más contexto del producto en
///cuestión y los motivos por los cuales se están enviando estas fotografías.
class SendFeedbackForProduct {
  int errorId;
  int response;
  double serverTime;

  SendFeedbackForProduct({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory SendFeedbackForProduct.fromJson(Map<String, dynamic> json) =>
      SendFeedbackForProduct(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///Send Photos with Barcode
///
///POST {{url}}/products/submit_photos/PRODUCT_BARCODE
///
///`PRODUCT_BARCODE` se refiere al número del código de barras impreso en el empaque del
///producto para el cual se están enviando estas fotografías.
///
///El arreglo `photos` debe contener las imágenes a enviar, codificadas como strings en Base
///64. Los tipos de imágenes soportados son `image/png`, `image/gif`, `image/jpeg` y
///`image/webp`.
///
///El string `comments` (opcional) debe tener máximo 65.535 caracteres de longitud, y se
///utiliza para que el equipo de analistas de OK to Shop tenga más contexto del producto en
///cuestión y los motivos por los cuales se están enviando estas fotografías.
class SendPhotosWithBarcode {
  int errorId;
  int response;
  double serverTime;

  SendPhotosWithBarcode({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory SendPhotosWithBarcode.fromJson(Map<String, dynamic> json) =>
      SendPhotosWithBarcode(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///New Products
///
///GET {{url}}/products/updates/newProducts?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos nuevos o actualizados
///recientemente que son aptos para el usuario, para el país que tiene seleccionado.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class NewProducts {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  NewProducts({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory NewProducts.fromJson(Map<String, dynamic> json) => NewProducts(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///New Products reported by User
///
///GET {{url}}/products/updates/newProductsReportedByUser?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos **nuevos** que fueron
///añadidos gracias a las fotografías proporcionadas por el usuario, para el país que tiene
///seleccionado.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class NewProductsReportedByUser {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  NewProductsReportedByUser({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory NewProductsReportedByUser.fromJson(Map<String, dynamic> json) =>
      NewProductsReportedByUser(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Suitability Changes
///
///GET {{url}}/products/updates/suitabilityChanges?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos cuya aptitud ha
///cambiado recientemente según las preferencias del usuario, para el país que tiene
///seleccionado.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class SuitabilityChanges {
  int errorId;
  List<dynamic> response;
  Pagination pagination;
  double serverTime;

  SuitabilityChanges({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory SuitabilityChanges.fromJson(Map<String, dynamic> json) =>
      SuitabilityChanges(
        errorId: json["errorId"],
        response: List<dynamic>.from(json["response"].map((x) => x)),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x)),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Updated Products reported by User
///
///GET {{url}}/products/updates/updatedProductsReportedByUser?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos que fueron
///**actualizados** gracias a las fotografías proporcionadas por el usuario, para el país
///que tiene seleccionado.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class UpdatedProductsReportedByUser {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  UpdatedProductsReportedByUser({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory UpdatedProductsReportedByUser.fromJson(Map<String, dynamic> json) =>
      UpdatedProductsReportedByUser(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///List of all Products
///
///GET {{url}}/products?page=1&pageSize=50&since=0
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos disponibles en la base
///de datos de OK to Shop, para el país que tiene seleccionado el usuario.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
///
///En caso de querer visualizar solo los productos que han sido actualizados desde un
///determinado timestamp en adelante (medido en segundos desde el Unix Epoch), se puede
///enviar dicho valor en el parámetro `since`.
class ListOfAllProducts {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  ListOfAllProducts({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory ListOfAllProducts.fromJson(Map<String, dynamic> json) =>
      ListOfAllProducts(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Search Product by Term
///
///GET {{url}}/products/search?term=TERM+TO+SEARCH&page=1&pageSize=20
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos cuya descripción
///coincide con la frase buscada (`term`), para el país que tiene seleccionado el usuario.
///
///Cuando se realiza la búsqueda no importa si una palabra está con mayúsculas o minúsculas,
///y no se consideran las tildes u otros signos ortográficos. Para separar palabras, debe
///usarse el signo `+` en vez del espacio.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class SearchProductByTerm {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  SearchProductByTerm({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory SearchProductByTerm.fromJson(Map<String, dynamic> json) =>
      SearchProductByTerm(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Search Product by Barcode (GTIN)
///
///GET {{url}}/products/barcode/PRODUCT_BARCODE
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos cuyo código de barras
///(GTIN, EAN, UPC) coincide con `PRODUCT_BARCODE`, para el país que tiene seleccionado el
///usuario.
///
///Para realizar la búsqueda pueden omitirse los ceros iniciales del código de barras, pero
///el resto de los dígitos deben coincidir exactamente para que se encuentren resultados.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class SearchProductByBarcodeGtin {
  int errorId;
  List<ProductsInCategoryResponse> response;
  double serverTime;

  SearchProductByBarcodeGtin({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory SearchProductByBarcodeGtin.fromJson(Map<String, dynamic> json) =>
      SearchProductByBarcodeGtin(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

///Sponsored Products
///
///GET {{url}}/products/sponsored?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos patrocinados a
///destacar para el usuario, para el país que tiene seleccionado.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class SponsoredProducts {
  int errorId;
  List<ProductsInCategoryResponse> response;
  double serverTime;

  SponsoredProducts({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory SponsoredProducts.fromJson(Map<String, dynamic> json) =>
      SponsoredProducts(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

///About
///
///GET {{url}}/texts/about
///
///Información general de nuestra empresa y declararación de propósito.
class About {
  int errorId;
  AboutResponse response;
  double serverTime;

  About({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        errorId: json["errorId"],
        response: AboutResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

class AboutResponse {
  String htmlContent;
  int lastUpdate;

  AboutResponse({
    required this.htmlContent,
    required this.lastUpdate,
  });

  factory AboutResponse.fromJson(Map<String, dynamic> json) => AboutResponse(
        htmlContent: json["htmlContent"],
        lastUpdate: json["lastUpdate"],
      );

  Map<String, dynamic> toJson() => {
        "htmlContent": htmlContent,
        "lastUpdate": lastUpdate,
      };
}

///Disclaimer
///
///GET {{url}}/texts/disclaimer
///
///Descargo legal que indicamos a continuación de la ficha de cada producto, y que
///aconsejamos incluir también a todas las empresas que utilizan nuestra información.
class Disclaimer {
  int errorId;
  AboutResponse response;
  double serverTime;

  Disclaimer({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory Disclaimer.fromJson(Map<String, dynamic> json) => Disclaimer(
        errorId: json["errorId"],
        response: AboutResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Privacy Policy
///
///GET {{url}}/texts/privacy
///
///Nuestra política de privacidad. Probablemente la más breve y simple de cualquier servicio
///;)
class PrivacyPolicy {
  int errorId;
  AboutResponse response;
  double serverTime;

  PrivacyPolicy({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
        errorId: json["errorId"],
        response: AboutResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Our Team
///
///GET {{url}}/texts/team
///
///Cómo se estructura nuestro equipo y breve descripción de sus funciones.
class OurTeam {
  int errorId;
  AboutResponse response;
  double serverTime;

  OurTeam({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory OurTeam.fromJson(Map<String, dynamic> json) => OurTeam(
        errorId: json["errorId"],
        response: AboutResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Terms of Service
///
///GET {{url}}/texts/terms
///
///Términos de uso de nuestro servicio.
class TermsOfService {
  int errorId;
  AboutResponse response;
  double serverTime;

  TermsOfService({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory TermsOfService.fromJson(Map<String, dynamic> json) => TermsOfService(
        errorId: json["errorId"],
        response: AboutResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Add Family Member
///
///POST {{url}}/users/me/familyMembers
///
///Para añadir a un integrante del grupo familiar solo se necesita indicar un "alias" que no
///debe estar vacío ni ser igual al de otro integrante del grupo familiar del usuario
///(máximo 50 caracteres de longitud). **Todo el resto de los campos son opcionales**.
///
///La imagen del integrante puede ser incluída en el campo `photo` codificada mediante un
///string en Base 64. Los tipos de imágenes soportados son `image/png`, `image/gif`,
///`image/jpeg` y `image/webp`. La imagen enviada será convertida automáticamente a una de
///aspecto cuadrado de dimensiones 312x312 px.
///
///Los códigos de los filtros e ingredientes que se pueden utilizar para definir sus
///preferencias o restricciones alimentarias son los mismos que se obtienen con los
///endpoints `https://api.okto.shop/v2/products/filters` y
///`https://api.okto.shop/v2/ingredients` respectivamente.
///
///Si el integrante del grupo familiar es creado correctamente, se le asignará un
///Identificador Único (numérico) al que nos referimos como **"FMID"** en esta
///documentación, con el cual se puede editar o eliminar posteriormente, o saber si un
///producto es apto o no según las preferencias establecidas para él o ella.
///
///**Importante:** en el caso de los ingredientes, además de su identificador único se debe
///acompañar un booleano llamado `strict` el cual, de ser verdadero, indica que el
///integrante no puede consumir ese ingrediente ni siquiera como traza (esto es
///particularmente relevante para personas con alergias alimentarias).
class AddFamilyMember {
  int errorId;
  AddFamilyMemberResponse response;
  double serverTime;

  AddFamilyMember({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory AddFamilyMember.fromJson(Map<String, dynamic> json) =>
      AddFamilyMember(
        errorId: json["errorId"],
        response: AddFamilyMemberResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

class AddFamilyMemberResponse {
  int id;
  String alias;
  String photoUrl;
  int lastUpdate;
  List<SuitabilityElement> filters;
  List<Ingredient> ingredients;

  AddFamilyMemberResponse({
    required this.id,
    required this.alias,
    required this.photoUrl,
    required this.lastUpdate,
    required this.filters,
    required this.ingredients,
  });

  factory AddFamilyMemberResponse.fromJson(Map<String, dynamic> json) =>
      AddFamilyMemberResponse(
        id: json["id"],
        alias: json["alias"],
        photoUrl: json["photoUrl"],
        lastUpdate: json["lastUpdate"],
        filters: List<SuitabilityElement>.from(
            json["filters"].map((x) => SuitabilityElement.fromJson(x))),
        ingredients: List<Ingredient>.from(
            json["ingredients"].map((x) => Ingredient.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "alias": alias,
        "photoUrl": photoUrl,
        "lastUpdate": lastUpdate,
        "filters": List<dynamic>.from(filters.map((x) => x.toJson())),
        "ingredients": List<dynamic>.from(ingredients.map((x) => x.toJson())),
      };
}

class Ingredient {
  String id;
  String name;
  bool strict;

  Ingredient({
    required this.id,
    required this.name,
    required this.strict,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
        id: json["id"],
        name: json["name"],
        strict: json["strict"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "strict": strict,
      };
}

///Delete Family Member
///
///DELETE {{url}}/users/me/familyMembers/FAMILY_MEMBER_ID
///
///Para eliminar el registro de un integrante del grupo familiar del usuario, basta con
///reemplazar `FAMILY_MEMBER_ID` por el "FMID" del integrante en cuestión.
///
///Una vez eliminado el registro esta acción no se puede deshacer, pero puede volver a
///crearse otro integrante con el mismo alias del recién eliminado.
class DeleteFamilyMember {
  int errorId;
  int response;
  double serverTime;

  DeleteFamilyMember({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory DeleteFamilyMember.fromJson(Map<String, dynamic> json) =>
      DeleteFamilyMember(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///Edit Family Member
///
///PATCH {{url}}/users/me/familyMembers/FAMILY_MEMBER_ID
///
///Para modificar la información de un integrante del grupo familiar, se debe reemplazar
///`FAMILY_MEMBER_ID` por el "FMID" del integrante en cuestión.
///
///En el cuerpo del llamado se debe enviar un JSON siguiendo la misma estructura empleada al
///crear un integrante, y solo se actualizarán los campos que se hayan enviado en el cuerpo
///de este llamado. En otras palabras, si un campo no se menciona en el llamado, conservará
///sus valores anteriores.
///
///**Importante:** Si un integrante ya tenía definida una restricción según un filtro (sin
///huevo, kosher, etc.) y quiere añadir otro, se debe volver a enviar **toda la lista de
///filtros que el usuario desea mantener** configurados en el perfil de este integrante.
///Aquellos filtros que no hayan sido incluídos en esta nueva lista, serán removidos de su
///lista de restricciones.
///
///Esto último **también aplica para la lista de ingredientes**: cada vez que se envíe una
///lista, se asumirá que es la lista definitiva que se desea mantener.
///
///**Ejemplo 1:** Si solo se quiere modificar el alias del integrante, el cuerpo del llamado
///debe contener únicamente `{"alias":"El nuevo nombre"}` .
///
///**Ejemplo 2:** Para eliminar todas las restricciones de ingredientes de un integrante, el
///cuerpo del llamado debe contener la llave "ingredients" con el valor "\[\]" (arreglo
///vacío), es decir `{"ingredients":[]}` .
///
///**Ejemplo 3:** Para establecer que un integrante no quiere consumir ajo ni berenjenas
///(estas últimas ni siquiera como trazas) el cuerpo del llamado debería ser el siguiente
///
///`{"ingredients":[{"id":"651-ToKErLLUu5L3oKM9","strict":false},{"id":"10469-cVOTwi7tjzTRYrC8","strict":true}]}`
///.
///
///**Ejemplo 4:** Para modificar en un solo llamado el alias de un integrante y al mismo
///tiempo definir como filtro que no consume gluten ni siquiera en trazas, el cuerpo del
///llamado debería ser `{"alias":"El nuevo nombre","filters":[{"id":19},{"id":33}]}` .
class EditFamilyMember {
  int errorId;
  AddFamilyMemberResponse response;
  double serverTime;

  EditFamilyMember({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory EditFamilyMember.fromJson(Map<String, dynamic> json) =>
      EditFamilyMember(
        errorId: json["errorId"],
        response: AddFamilyMemberResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///List of Family Members
///
///GET {{url}}/users/me/familyMembers/
///
///Devuelve un arreglo de objetos, donde cada uno representa un integrante del grupo
///familiar del usuario con sus respectivas restricciones o preferencias. Cada objeto tiene
///la siguiente estructura:
///
///- **id** **`(int)`**: "FMID" del integrante.
///- **alias** **`(string)`**: Alias del integrante.
///- **photoUrl** **`(string)`**: URL a la imagen de perfil del integrante.
///- **lastUpdate** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) en que
///el integrante fue modificado por última vez.
///- **filters** **`(array)`**:
///
///- **ingredients** **`(array)`**:
class ListOfFamilyMembers {
  int errorId;
  List<AddFamilyMemberResponse> response;
  double serverTime;

  ListOfFamilyMembers({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory ListOfFamilyMembers.fromJson(Map<String, dynamic> json) =>
      ListOfFamilyMembers(
        errorId: json["errorId"],
        response: List<AddFamilyMemberResponse>.from(
            json["response"].map((x) => AddFamilyMemberResponse.fromJson(x))),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "serverTime": serverTime,
      };
}

///Lists of Favorites for current user
///
///GET {{url}}/users/me/favorites?page=1&pageSize=50
///
///Tal como su nombre lo indica, este endpoint devuelve un arreglo de objetos que tienen la
///siguiente estructura:
///
///- **id** **`(int)`**: Identificador único de la Lista de Favoritos (el cual llamaremos
///**"FLID"** durante el resto de la documentación).
///
///- **name** **`(string)`**: Nombre de la Lista de Favoritos
///
///- **lastUpdate** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) en que
///esta Lista fue modificada por última vez.
///
///- **totalItems** **`(int)`**: Cantidad de productos contenidos dentro de esta Lista de
///Favoritos.
class ListsOfFavoritesForCurrentUser {
  int errorId;
  List<ListsOfFavoritesForCurrentUserResponse> response;
  Pagination pagination;
  double serverTime;

  ListsOfFavoritesForCurrentUser({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory ListsOfFavoritesForCurrentUser.fromJson(Map<String, dynamic> json) =>
      ListsOfFavoritesForCurrentUser(
        errorId: json["errorId"],
        response: List<ListsOfFavoritesForCurrentUserResponse>.from(
            json["response"].map(
                (x) => ListsOfFavoritesForCurrentUserResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

class ListsOfFavoritesForCurrentUserResponse {
  int id;
  String name;
  int lastUpdate;
  int totalItems;
  int? countryId;

  ListsOfFavoritesForCurrentUserResponse({
    required this.id,
    required this.name,
    required this.lastUpdate,
    required this.totalItems,
    this.countryId,
  });

  factory ListsOfFavoritesForCurrentUserResponse.fromJson(
          Map<String, dynamic> json) =>
      ListsOfFavoritesForCurrentUserResponse(
        id: json["id"],
        name: json["name"],
        lastUpdate: json["lastUpdate"],
        totalItems: json["totalItems"],
        countryId: json["countryId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lastUpdate": lastUpdate,
        "totalItems": totalItems,
        "countryId": countryId,
      };
}

///Create Favorites List
///
///POST {{url}}/users/me/favorites
///
///Para añadir una Lista de Favoritos solo se necesita indicar su nombre, el cual no debe
///estar vacío ni ser igual al de otra Lista (máximo 100 caracteres de longitud).
///
///Si la Lista es creada correctamente, se le asignará un Identificador Único (numérico) al
///que nos referimos como **"FLID"** en esta documentación, con el cual se puede editar o
///eliminar posteriormente.
class CreateFavoritesList {
  int errorId;
  ListsOfFavoritesForCurrentUserResponse response;
  double serverTime;

  CreateFavoritesList({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory CreateFavoritesList.fromJson(Map<String, dynamic> json) =>
      CreateFavoritesList(
        errorId: json["errorId"],
        response:
            ListsOfFavoritesForCurrentUserResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Rename Favorites List
///
///PATCH {{url}}/users/me/favorites/FAVORITE_LIST_ID
///
///Permite cambiar el nombre de una Lista de Favoritos.
///
///Se debe reemplazar `FAVORITE_LIST_ID` por el "FLID" de la Lista en cuestión y el nuevo
///nombre no debe estar vacío ni ser igual al de otra Lista (máximo 100 caracteres de
///longitud).
class RenameFavoritesList {
  int errorId;
  ListsOfFavoritesForCurrentUserResponse response;
  double serverTime;

  RenameFavoritesList({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory RenameFavoritesList.fromJson(Map<String, dynamic> json) =>
      RenameFavoritesList(
        errorId: json["errorId"],
        response:
            ListsOfFavoritesForCurrentUserResponse.fromJson(json["response"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response.toJson(),
        "serverTime": serverTime,
      };
}

///Delete Favorites List
///
///DELETE {{url}}/users/me/favorites/FAVORITE_LIST_ID
///
///Permite eliminar una Lista de Favoritos.
///
///Se debe reemplazar `FAVORITE_LIST_ID` por el "FLID" de la Lista en cuestión.
///
///Una vez eliminada una Lista, esta acción no se puede deshacer, pero puede volver a
///crearse otra con el mismo nombre de la recién eliminada (sin embargo se habrá perdido su
///contenido).
class DeleteFavoritesList {
  int errorId;
  int response;
  double serverTime;

  DeleteFavoritesList({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory DeleteFavoritesList.fromJson(Map<String, dynamic> json) =>
      DeleteFavoritesList(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///List of Products in a Favorites List
///
///GET {{url}}/users/me/favorites/FAVORITE_LIST_ID/products?page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos contenidos dentro de
///la Lista cuyo ID es `FAVORITE_LIST_ID` .
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class ListOfProductsInAFavoritesList {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  ListOfProductsInAFavoritesList({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory ListOfProductsInAFavoritesList.fromJson(Map<String, dynamic> json) =>
      ListOfProductsInAFavoritesList(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Add product to Favorites List
///
///POST {{url}}/users/me/favorites/FAVORITE_LIST_ID/products
///
///Añade un producto a una Lista de Favoritos. Para ello se debe reemplazar
///`FAVORITE_LIST_ID` por el "FLID" de la Lista en cuestión, y `OK_TO_SHOP_PRODUCT_ID` por
///el Identificador único del Producto a añadir.
class AddProductToFavoritesList {
  int errorId;
  int response;
  double serverTime;

  AddProductToFavoritesList({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory AddProductToFavoritesList.fromJson(Map<String, dynamic> json) =>
      AddProductToFavoritesList(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///Delete Product from Favorites List
///
///DELETE {{url}}/users/me/favorites/FAVORITE_LIST_ID/products/OK_TO_SHOP_PRODUCT_ID
///
///Elimina un producto a una Lista de Favoritos. Para ello se debe reemplazar
///`FAVORITE_LIST_ID` por el "FLID" de la Lista en cuestión, y `OK_TO_SHOP_PRODUCT_ID` por
///el Identificador único del Producto a eliminar.
class DeleteProductFromFavoritesList {
  int errorId;
  int response;
  double serverTime;

  DeleteProductFromFavoritesList({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory DeleteProductFromFavoritesList.fromJson(Map<String, dynamic> json) =>
      DeleteProductFromFavoritesList(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

///Notifications for current user
///
///GET {{url}}/users/me/notifications?since=0&page=1&pageSize=50
///
///Devuelve un arreglo de objetos con todas las notificaciones disponibles para un usuario.
///
///La estructura de cada objeto es la siguiente:
///
///- **id** **`(string)`**: Identificador único de la notificación.
///
///- **timestamp** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) en que la
///notificación fue generada.
///
///- **type** **`(string)`**: Tipo de notificación (sirve para determinar el icono a
///desplegar y si se debe emitir alguna notificación push dependiendo de las preferencias
///del usuario).
///
///- **productId** **`(string)`**: Identificador único del producto en referencia.
///
///- **htmlContent** **`(string)`**: Mensaje explicativo en HTML.
///
///- **readTimestamp** **`(int)`**: Timestamp (medido en segundos desde el Unix Epoch) en
///que la notificación fue leída por primera vez.
///
///
///Los resultados pueden paginarse para mejorar el rendimiento de la respuesta.
class NotificationsForCurrentUser {
  int errorId;
  List<NotificationsForCurrentUserResponse> response;
  Pagination pagination;
  double serverTime;

  NotificationsForCurrentUser({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory NotificationsForCurrentUser.fromJson(Map<String, dynamic> json) =>
      NotificationsForCurrentUser(
        errorId: json["errorId"],
        response: List<NotificationsForCurrentUserResponse>.from(
            json["response"]
                .map((x) => NotificationsForCurrentUserResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

class NotificationsForCurrentUserResponse {
  String id;
  int timestamp;
  String type;
  String productId;
  String htmlContent;
  int readTimestamp;

  NotificationsForCurrentUserResponse({
    required this.id,
    required this.timestamp,
    required this.type,
    required this.productId,
    required this.htmlContent,
    required this.readTimestamp,
  });

  factory NotificationsForCurrentUserResponse.fromJson(
          Map<String, dynamic> json) =>
      NotificationsForCurrentUserResponse(
        id: json["id"],
        timestamp: json["timestamp"],
        type: json["type"],
        productId: json["productId"],
        htmlContent: json["htmlContent"],
        readTimestamp: json["readTimestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "timestamp": timestamp,
        "type": type,
        "productId": productId,
        "htmlContent": htmlContent,
        "readTimestamp": readTimestamp,
      };
}

///Delete notifications
///
///DELETE {{url}}/users/me/notifications?notificationIds=[3,17]&since=12345
///
///Elimina todas las notificaciones cuyo Identificador único está contenido en
///`notificationIds`, o bien cuyo Timestamp de creación sea igual o superior al valor de
///`since` (medido en segundos desde el Unix Epoch).
///
///La respuesta de este endpoint es un arreglo con todos los Identificadores únicos de las
///notificaciones correctamente eliminadas.
class DeleteNotifications {
  int errorId;
  List<String> response;
  double serverTime;

  DeleteNotifications({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory DeleteNotifications.fromJson(Map<String, dynamic> json) =>
      DeleteNotifications(
        errorId: json["errorId"],
        response: List<String>.from(json["response"].map((x) => x)),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x)),
        "serverTime": serverTime,
      };
}

///Mark as read
///
///POST {{url}}/users/me/notifications/markAsRead
///
///Establece como Timestamp de primera lectura el valor de `since` (medido en segundos desde
///el Unix Epoch) para las notificaciones cuyos Identificadores únicos están contenidas
///dentro del arreglo `notificationIds` .
///
///La respuesta de este endpoint es un arreglo con todos los Identificadores únicos de las
///notificaciones correctamente actualizadas.
class MarkAsRead {
  int errorId;
  List<String> response;
  double serverTime;

  MarkAsRead({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory MarkAsRead.fromJson(Map<String, dynamic> json) => MarkAsRead(
        errorId: json["errorId"],
        response: List<String>.from(json["response"].map((x) => x)),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x)),
        "serverTime": serverTime,
      };
}

///Get users Search History
///
///GET {{url}}/users/me/searchHistory?since=0&page=1&pageSize=50
///
///Devuelve una **"Lista de productos OKTS"** con todos los productos a los que el usuario
///ha accedido luego de encontrarlos usando la búsqueda de texto.
///
///Al igual que las demás listas de productos, los resultados pueden paginarse para mejorar
///el rendimiento de la respuesta.
class GetUsersSearchHistory {
  int errorId;
  List<ProductsInCategoryResponse> response;
  Pagination pagination;
  double serverTime;

  GetUsersSearchHistory({
    required this.errorId,
    required this.response,
    required this.pagination,
    required this.serverTime,
  });

  factory GetUsersSearchHistory.fromJson(Map<String, dynamic> json) =>
      GetUsersSearchHistory(
        errorId: json["errorId"],
        response: List<ProductsInCategoryResponse>.from(json["response"]
            .map((x) => ProductsInCategoryResponse.fromJson(x))),
        pagination: Pagination.fromJson(json["pagination"]),
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
        "pagination": pagination.toJson(),
        "serverTime": serverTime,
      };
}

///Delete product from Search History
///
///DELETE {{url}}/users/me/searchHistory?productId=OK_TO_SHOP_PRODUCT_ID&since=12345
///
///Elimina de la lista de productos buscados aquel cuyo Identificador único coincide con
///`productId`, o bien que hayan sido buscados en una fecha igual o posterior al Timestamp
///indicado en `since` (medido en segundos desde el Unix Epoch).
class DeleteProductFromSearchHistory {
  int errorId;
  int response;
  double serverTime;

  DeleteProductFromSearchHistory({
    required this.errorId,
    required this.response,
    required this.serverTime,
  });

  factory DeleteProductFromSearchHistory.fromJson(Map<String, dynamic> json) =>
      DeleteProductFromSearchHistory(
        errorId: json["errorId"],
        response: json["response"],
        serverTime: json["serverTime"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "errorId": errorId,
        "response": response,
        "serverTime": serverTime,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
