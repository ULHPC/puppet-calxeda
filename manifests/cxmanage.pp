# File::      <tt>cxmanage.pp</tt>
# Author::    UL HPC Management Team <hpc-sysadmins@uni.lu>
# Copyright:: Copyright (c) 2015 UL HPC Management Team
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: calxeda::cxmanage
#
# Calxeda management tools
#
# == Parameters:
#
# $ensure:: *Default*: 'present'. Ensure the presence (or absence) of cxmanage
#
# == Actions:
#
# Install and configure calxeda cxmanage
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
#     include calxeda::cxmanage
#
# You can then specialize the various aspects of the configuration,
# for instance:
#
#         class { 'calxeda::cxmanage':
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
class calxeda::cxmanage(
    $ensure = $calxeda::params::ensure
)
inherits calxeda::params
{
    info ("Configuring calxeda::cxmanage (with ensure = ${ensure})")

    if ! ($ensure in [ 'present', 'absent' ]) {
        fail("calxeda::cxmanage 'ensure' parameter must be set to either 'absent' or 'present'")
    }

    case $::operatingsystem {
        debian, ubuntu:         { include calxeda::cxmanage::debian }
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
class calxeda::cxmanage::common {

    # Load the variables used in this module. Check the calxeda-params.pp file
    require calxeda::params

    package { $calxeda::params::cxmanage_dep:
        ensure  => $calxeda::cxmanage::ensure,
    }

    if $calxeda::cxmanage::ensure == 'present' {

        exec { 'cxmanage-install':
            command => "pip install ${calxeda::params::cxmanage_name}",
            path    => '/usr/bin:/usr/sbin:/bin',
            creates => '/usr/local/bin/cxmanage',
            user    => 'root',
            require => Package[$calxeda::params::cxmanage_dep]
        }

    }
    else
    {
        # Here $calxeda::cxmanage::ensure is 'absent'

        exec { 'cxmanage-uninstall':
            command => 'make uninstall',
            path    => '/usr/bin:/usr/sbin:/bin',
            cwd     => $calxeda::params::cxmanage_build_dir,
            onlyif  => 'test -f /usr/local/bin/cxmanagetool',
            user    => 'root'
        }

        Exec['cxmanage-uninstall'] -> Package[$calxeda::params::cxmanage_dep]

    }

}


# ------------------------------------------------------------------------------
# = Class: calxeda::cxmanage::debian
#
# Specialization class for Debian systems
class calxeda::cxmanage::debian inherits calxeda::cxmanage::common { }

