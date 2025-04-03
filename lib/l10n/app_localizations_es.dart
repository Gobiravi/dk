import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get title => 'DIKLA SPIRIT';

  @override
  String get home => 'Inicio';

  @override
  String get shop => 'Tienda';

  @override
  String get cart => 'Carrito';

  @override
  String get myAccount => 'Mi Cuenta';

  @override
  String get chat => 'Chat';

  @override
  String get shopNow => 'Compra Ahora';

  @override
  String get viewAll => 'Ver Todo';

  @override
  String get fastResults => 'Porque te gustan\nlos resultados rápidos.';

  @override
  String get elevateExperience => 'Eleva tu\nExperiencia';

  @override
  String get moreFromDikla => 'Más de Dikla Spirit';

  @override
  String get bestSellingService => 'Servicios más vendidos';

  @override
  String get homeReviewHeader => '¡ÚNETE A MILES DE CLIENTES FELICES \nCON MÁS DE 2000 RESEÑAS DE CINCO ESTRELLAS!';

  @override
  String get checkMoreReviews => 'Ver Más Reseñas';

  @override
  String get quickSolutions => 'Soluciones Rápidas\nAquí Mismo';

  @override
  String get homeGuidance => '¿Necesitas un poco de orientación\nsobre qué es lo mejor para ti?';

  @override
  String get sortBy => 'Ordenar Por';

  @override
  String get filterBy => 'Filtrar Por';

  @override
  String get relevance => 'Relevancia (Predeterminado)';

  @override
  String get bestselling => 'Más Vendidos';

  @override
  String get top_rated => 'Mejor Valorados';

  @override
  String get price_low_to_high => 'Precio de Menor a Mayor';

  @override
  String get price_high_to_low => 'Precio de Mayor a Menor';

  @override
  String get sortBynew => 'Nuevos';

  @override
  String get clearAll => 'Borrar Todo';

  @override
  String get showResults => 'Mostrar Resultados';

  @override
  String get suitable_for_all => 'Adecuado para todas las parejas y géneros';

  @override
  String get with_a_click_its_yours => 'Con un clic es tuyo';

  @override
  String get color => 'Color';

  @override
  String get availability => 'Disponibilidad: ';

  @override
  String get description => 'Descripción: ';

  @override
  String get get_started => 'Comenzar';

  @override
  String get personalize_your_experience => 'Personaliza Tu Experiencia';

  @override
  String get confirm_preferences => 'Por favor confirma tus preferencias a continuación';

  @override
  String get choose_language => 'Elige tu idioma para comenzar';

  @override
  String get select_currency => 'Selecciona tu moneda';

  @override
  String get save_preferences => 'Guardar Preferencias';

  @override
  String get save_changes => 'Guardar cambios';

  @override
  String get howStrongDoYouWantYourSpell => '¿Qué tan fuerte quieres tu hechizo?';

  @override
  String get forMoreQuestions => 'Para más preguntas';

  @override
  String get ratingAndReviews => 'Calificaciones y reseñas';

  @override
  String get rating => 'Calificación';

  @override
  String get questionsAndAnswers => 'Preguntas y respuestas';

  @override
  String get youMayAlsoLikeThis => 'También te puede gustar esto';

  @override
  String get writeAReview => 'Escribe una reseña';

  @override
  String get sortByRating => 'Ordenar por calificación';

  @override
  String get myBag => 'Mi bolso';

  @override
  String get go_to_checkout => 'Ir a caja';

  @override
  String get fastResultsProductDetail => 'Para obtener resultados más rápidos \nTe ayudará también';

  @override
  String get moveFromBag => 'Mover de la bolsa';

  @override
  String get my_orders => 'Mis pedidos';

  @override
  String get order_details => 'Detalles del pedido';

  @override
  String get help_center => 'Centro de ayuda';

  @override
  String get submit_request => 'Enviar una solicitud';

  @override
  String get profile_details => 'Establecer detalles del perfil';

  @override
  String get contact_informatiom => 'Información del contacto';

  @override
  String get personal_informatiom => 'Información personal';

  @override
  String get my_profile => 'Mi perfil';

  @override
  String get my_review => 'Mi reseña';

  @override
  String get language_and_region => 'idioma y región';

  @override
  String get language => 'Idioma';

  @override
  String get currency => 'Divisa';

  @override
  String get country => 'país';

  @override
  String get support_and_information => 'Soporte e información';

  @override
  String get quick_qa_with_dikla => 'Preguntas y respuestas breves con Dikla';

  @override
  String get dikla_support_team => 'Equipo de soporte de Dikla';

  @override
  String get dikla_promise_of_privacy => 'La promesa de privacidad de Dikla';

  @override
  String get terms_and_condition => 'Términos y condiciones';

  @override
  String get dikla_my_story => 'Dikla - Mi historia';

  @override
  String get dikla_happy_clients => 'Dikla - Clientes satisfechos';

  @override
  String get log_out => 'Finalizar la sesión';

  @override
  String get version => 'Versión';

  @override
  String get select_country => 'Seleccione país';

  @override
  String get hey => 'ey';

  @override
  String get welcome => 'Bienvenida';

  @override
  String get shipping_address => 'Dirección de envío';

  @override
  String get zodiac_sign => 'Signo del zodiaco';

  @override
  String get select_your_zodiac_sign => 'Select Your Zodiac Sign';

  @override
  String get recent_purchase_dikla => 'Compra reciente de \n Dikla Spirit';

  @override
  String get popular_categories => 'Categorías populares';

  @override
  String get out_of_stock => 'Agotado';

  @override
  String pageSettingsInputLanguage(String locale) {
    String _temp0 = intl.Intl.selectLogic(
      locale,
      {
        'he': 'עברית',
        'en': 'English',
        'es': 'Español',
        'other': '-',
      },
    );
    return '$_temp0';
  }
}
