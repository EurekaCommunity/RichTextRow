Pod::Spec.new do |s|
  s.name             = 'RichTextRow'
  s.version          = '1.0.4'
  s.summary          = 'Eureka custom row that allows us to display and edit html.'
  s.homepage         = 'https://github.com/EurekaCommunity/RichTextRow'
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { 'Fabio Felici' => 'fab.felici@gmail.com' }
  s.source           = { git: 'https://github.com/EurekaCommunity/RichTextRow.git', tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/EurekaCommunity'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*.{swift}'
  s.ios.resource_bundle = { 'Resources' => 'Sources/**/*.{html,js}' }
  s.dependency 'Eureka', '~> 5.2.1'
  s.swift_versions   = ['4.2']
end