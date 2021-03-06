# encoding: utf-8

# Inherit this control in order to make a few changes to it:
include_controls 'cis/cis-centos6-level1' do
  # Don't include these controls:
  skip_control 'xccdf_org.cisecurity.benchmarks_rule_1.1.1_Create_Separate_Partition_for_tmp'
  skip_control 'xccdf_org.cisecurity.benchmarks_rule_1.1.8_Create_Separate_Partition_for_varlogaudit'

  # Change the impact of this control:
  control 'xccdf_org.cisecurity.benchmarks_rule_1.1.9_Create_Separate_Partition_for_home' do
    impact 0.3
  end

  # Completly update this control:
  control "xccdf_org.cisecurity.benchmarks_rule_7.2_Disable_System_Accounts" do
    title "Disable System Accounts"
    desc  "There are a number of accounts provided with CentOS that are used to manage applications and are not intended to provide an interactive shell."
    impact 1.0
    describe passwd.where { user =~ /^(?!root|sync|shutdown|halt).*$/ } do
      its("entries") { should_not be_empty }
    end
    describe passwd.where { user =~ /^(?!root|sync|shutdown|halt).*$/ && uid.to_i < 500 && shell != "/sbin/nologin" } do
      its("entries") { should be_empty }
    end
  end
end
