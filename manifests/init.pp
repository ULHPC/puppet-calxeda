# File::      <tt>init.pp</tt>
# Author::    UL HPC Management Team <hpc-sysadmins@uni.lu>
# Copyright:: Copyright (c) 2015 UL HPC Management Team
# License::   GPLv3
#
# ------------------------------------------------------------------------------
# = Class: calxeda
#
# Calxeda management tools
#
# == Parameters:
#
# n/a
#
# == Actions:
#
# n/a
#
# == Requires:
#
# n/a
#
# == Sample Usage:
#
# n/a
#
# == Warnings
#
# /!\ Always respect the style guide available
# here[http://docs.puppetlabs.com/guides/style_guide]
#
#
# [Remember: No empty lines between comments and class definition]
#
class calxeda {
    contain calxeda::ipmi
    contain calxeda::cxmanage
}
