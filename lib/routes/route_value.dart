enum RouteValue {
  splash(path: '/'),
  home(path: '/home'),
  trip(path: 'trip'),
  resourse(path: 'resourse'),
  diary(path: 'diary'),
  article(path: 'article'),
  calculator(path: 'calculator'),
  action(path: 'action'),
    notes(path: 'notes'),
  unknown(path: '');

  final String path;
  const RouteValue({required this.path});
}
