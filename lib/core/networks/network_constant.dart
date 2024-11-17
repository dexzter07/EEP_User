/// @author: Sagar K.C.
/// @email: sagar.kc@fonepay.com
/// @created_at: 12/18/2023, Monday

class NetworkConstant {
  static const String baseUrl = 'https://uat-payment-app.fonepay.com/';
  static const String rcBaseUrl = 'https://rc-payment-app.fonepay.com/';
  static const String betaBaseUrl = 'https://beta-payment-app.fonepay.com/';
  static const String clientId = 'FONEPAY_PAYMENT_APP';
  static const String appType = 'FONEPAY_TOURIST_APP';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String cardAmountRefund = 'Card Amount Refund';

  //Firebase Network Constant
  static const String isPassportParsedFromApi = 'is_passport_parsed_from_api';
  static const String urlForFaqs = 'url_fonepay_website_faqs';
  static const String urlForHelpTopics = 'url_fonepay_website_help';
  static const String urlForPrivacyPolicy =
      'url_fonepay_website_privacy_policy';
  static const String urlForTermsOfServices =
      'url_fonepay_website_terms_of_services';
  static const String fonepayContactEmail = 'fonepay_contact_email';
  static const String fonepayContactPhoneNumber =
      'fonepay_contact_phone_number';
}
