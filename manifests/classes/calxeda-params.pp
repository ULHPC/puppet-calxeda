# File::      <tt>calxeda-params.pp</tt>
# Author::    Hyacinthe Cartiaux (hyacinthe.cartiaux@uni.lu)
# Copyright:: Copyright (c) 2013 Hyacinthe Cartiaux
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: calxeda::params
#
# In this class are defined as variables values that are used in other
# calxeda classes.
# This class should be included, where necessary, and eventually be enhanced
# with support for more OS
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
# The usage of a dedicated param classe is advised to better deal with
# parametrized classes, see
# http://docs.puppetlabs.com/guides/parameterized_classes.html
#
# [Remember: No empty lines between comments and class definition]
#
class calxeda::params {

    # ensure the presence (or absence) of calxeda
    $ensure = $calxeda_ensure ? {
        ''      => 'present',
        default => "${calxeda_ensure}"
    }

    #### MODULE INTERNAL VARIABLES  #########
    # (Modify to adapt to unsupported OSes)
    #######################################
    # calxeda ipmitool git repo
    $ipmi_git       = 'https://github.com/Cynerva/ipmitool.git'
    # calxeda ipmitool dependency
    $ipmi_dep       = 'libssl-dev'
    # calxeda ipmitool build dependency
    $build_dep      = $::operatingsystem ? {
        /(?i-mx:ubuntu|debian)/ => 'build-essential',
        default => 'build-essential'
    }
    # calxeda ipmitool build directory
    $ipmi_build_dir = '/root/cxipmitool'

    # calxeda mgmt tool dependency
    $cxmanage_dep   = 'python-pip'

    # calxeda mgmt tool name (for pip)
    $cxmanage_name  = 'cxmanage'

}

