import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                child: Center(
                  child: Image.asset(
                    'assets/images/Black_Yellow_Minimalist_Brain_Logo_(2).png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          : const LoginWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    child: Center(
                      child: Image.asset(
                        'assets/images/Black_Yellow_Minimalist_Brain_Logo_(2).png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : const LoginWidget(),
        ),
        FFRoute(
          name: 'Login',
          path: '/login',
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: 'Cambiar_Contrasena',
          path: '/cambiarContrasena',
          builder: (context, params) => const CambiarContrasenaWidget(),
        ),
        FFRoute(
          name: 'Ayuda_Soporte',
          path: '/ayudaSoporte',
          builder: (context, params) => const AyudaSoporteWidget(),
        ),
        FFRoute(
          name: 'Editar_Informacion',
          path: '/editarInformacion',
          builder: (context, params) => const EditarInformacionWidget(),
        ),
        FFRoute(
          name: 'Horario',
          path: '/horario',
          builder: (context, params) => const HorarioWidget(),
        ),
        FFRoute(
          name: 'CarnetAsitencia',
          path: '/carnetAsitencia',
          builder: (context, params) => const CarnetAsitenciaWidget(),
        ),
        FFRoute(
          name: 'ReportePorFecha',
          path: '/reportePorFecha',
          builder: (context, params) => const ReportePorFechaWidget(),
        ),
        FFRoute(
          name: 'Asistencia',
          path: '/asistencia',
          builder: (context, params) => const AsistenciaWidget(),
        ),
        FFRoute(
          name: 'CargarPermisos',
          path: '/cargarPermisos',
          builder: (context, params) => const CargarPermisosWidget(),
        ),
        FFRoute(
          name: 'Observaciones',
          path: '/observaciones',
          builder: (context, params) => const ObservacionesWidget(),
        ),
        FFRoute(
          name: 'CrearObservaciones',
          path: '/crearObservaciones',
          builder: (context, params) => const CrearObservacionesWidget(),
        ),
        FFRoute(
          name: 'BarraBusqueda',
          path: '/barraBusqueda',
          builder: (context, params) => const BarraBusquedaWidget(),
        ),
        FFRoute(
          name: 'ReportePorEstudiante',
          path: '/reportePorEstudiante',
          builder: (context, params) => const ReportePorEstudianteWidget(),
        ),
        FFRoute(
          name: 'SeleccionarReporte',
          path: '/seleccionarReporte',
          builder: (context, params) => const SeleccionarReporteWidget(),
        ),
        FFRoute(
          name: 'ReporteDiario',
          path: '/reporteDiario',
          builder: (context, params) => const ReporteDiarioWidget(),
        ),
        FFRoute(
          name: 'Inicio',
          path: '/inicio',
          builder: (context, params) => const InicioWidget(),
        ),
        FFRoute(
          name: 'profile',
          path: '/profile',
          builder: (context, params) => const ProfileWidget(),
        ),
        FFRoute(
          name: 'Notificaciones',
          path: '/notificaciones',
          builder: (context, params) => const NotificacionesWidget(),
        ),
        FFRoute(
          name: 'boton',
          path: '/boton',
          builder: (context, params) => const BotonWidget(),
        ),
        FFRoute(
          name: 'EditarObservacion',
          path: '/editarObservacion',
          builder: (context, params) => const EditarObservacionWidget(),
        ),
        FFRoute(
          name: 'Estudiante',
          path: '/estudiante',
          builder: (context, params) => const EstudianteWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouter.of(context).location;
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}
