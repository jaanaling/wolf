enum IconProvider {
  background(imageName: 'background.png'),
  box(imageName: 'box.png'),
  button(imageName: 'button.png'),
  cbox(imageName: 'cbox.png'),
  chain(imageName: 'chain.png'),
  field(imageName: 'field.png'),
  icon(imageName: 'icon.png'),
  items(imageName: 'items.png'),
  logo(imageName: 'logo.png'),
  mark(imageName: 'mark.png'),
  masq(imageName: 'masq.png'),
  masq2(imageName: 'masq2.png'),
  rbutton(imageName: 'rbutton.png'),
  spalsh(imageName: 'spalsh.png'),
  window(imageName: 'window.png'),
  notes(imageName: 'notes.png'),
  progress(imageName: 'progress.png'),
  progressBack(imageName: "progress_back.png"),

  unknown(imageName: '');

  const IconProvider({required this.imageName});

  final String imageName;
  static const _imageFolderPath = 'assets/images';

  String buildImageUrl() => '$_imageFolderPath/$imageName';
  static String buildImageByName(String name) => '$_imageFolderPath/$name';
}
