# File::      <tt>calxeda-ipmi.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: calxeda
#
# Calxeda management tools
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of calxeda ipmitool
#
# == Actions:
#
# Install and configure calxeda ipmitool
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     include calxeda::ipmi
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'calxeda::ipmi':
#             ensure => 'present'
#         }
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class calxeda::ipmi(
    $ensure = $calxeda::params::ensure
)
inherits calxeda::params
{
    info ("Configuring calxeda::ipmi (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("calxeda::ipmi 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include calxeda::ipmi::debian }
        default: {
            fail("Module $::{module_name} is not supported on $::{operatingsystem}")
        }
    }
}

# ------------------------------------------------------------------------------
# = Class: calxeda::common
#
# Base class to be inherited by the other calxeda classes
#
# Note: respect the Naming standard provided here[http://projects.puppetlabs.com/projects/puppet/wiki/Module_Standards]
class calxeda::ipmi::common {

    # Load the variables used in this module. Check the calxeda-params.pp file
    require calxeda::params

    package { $calxeda::params::ipmi_dep:
        ensure  => $calxeda::ipmi::ensure,
    }
    package { $calxeda::params::build_dep:
        ensure  => $calxeda::ipmi::ensure,
    }

    if $calxeda::ipmi::ensure == 'present' {

        git::clone { 'cx-ipmitool':
            ensure => $calxeda::ipmi::ensure,
            path   => $calxeda::params::ipmi_build_dir,
            source => $calxeda::params::ipmi_git,
        }

        exec { 'cx-ipmitool-compilation':
            command => 'configure && make && make install',
            path    => "${calxeda::params::ipmi_build_dir}:/usr/bin:/usr/sbin:/bin",
            cwd     => $calxeda::params::ipmi_build_dir,
            creates => '/usr/local/bin/ipmitool',
            user    => 'root',
            require => [ Package[$calxeda::params::ipmi_dep], Package[$calxeda::params::build_dep], Git::Clone['cx-ipmitool'] ]
        }

    }
    else
    {
        # Here $calxeda::ipmi::ensure is 'absent'

        exec { 'cx-ipmitool-uninstall':
            command => 'make uninstall',
            path    => '/usr/bin:/usr/sbin:/bin',
            cwd     => $calxeda::params::ipmi_build_dir,
            onlyif  => 'test -f /usr/local/bin/ipmitool',
            user    => 'root'
        }

        Exec['cx-ipmitool-uninstall'] -> Package[$calxeda::params::build_dep]

        exec { 'cx-ipmitool-remove-src':
            command => "rm -rf ${calxeda::params::ipmi_build_dir}",
            path    => '/usr/bin:/usr/sbin:/bin',
            cwd     => $calxeda::params::ipmi_build_dir,
            onlyif  => "test -d ${calxeda::params::ipmi_build_dir}",
            user    => 'root',
            require => Exec['cx-ipmitool-uninstall']
        }

    }

}


# ------------------------------------------------------------------------------
# = Class: calxeda::ipmi::debian
#
# Specialization class for Debian systems
class calxeda::ipmi::debian inherits calxeda::ipmi::common { }

