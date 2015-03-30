# == Class: site::puppet
#
class site::puppet (
  $ensure                     = 'present',

  $config_dir_source          = undef,
  $config_file_template       = 'site/puppet/puppet.conf.erb',
) {

  $options_default = {
    server => 'puppet',
  }
  #
  $options_user=hiera_hash('puppet_options', {} )
  $options=merge($options_default,$options_user)

  ::tp::install { 'puppet':
    ensure         => $ensure,
  }
  ::tp::dir { 'puppet':
    ensure => $ensure,
    source => $config_dir_source,
  }
  ::tp::conf { 'puppet':
    ensure       => $ensure,
    template     => $config_file_template,
    options_hash => $options,
  }

}
