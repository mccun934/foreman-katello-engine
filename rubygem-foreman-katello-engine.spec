%{?scl:%scl_package rubygem-%{gem_name}}
%{!?scl:%global pkg_name %{name}}

%global gem_name foreman-katello-engine

%define rubyabi 1.9.1
%global foreman_bundlerd_dir /usr/share/foreman/bundler.d

Summary: Katello specific parts of Foreman
Name: %{?scl_prefix}rubygem-%{gem_name}
Version: 0.0.12
Release: 1%{?dist}
Group: Development/Libraries
License: GPLv2
URL: http://github.com/Katello/foreman-katello-engine
Source0: http://rubygems.org/downloads/%{gem_name}-%{version}.gem
Requires: foreman
Requires: %{?scl_prefix}ruby(abi) >= %{rubyabi}
Requires: %{?scl_prefix}rubygem(deface)
Requires: %{?scl_prefix}rubygem(katello_api)
Requires: %{?scl_prefix}rubygems
BuildRequires: %{?scl_prefix}rubygems-devel
BuildRequires: %{?scl_prefix}ruby(abi) >= %{rubyabi}
BuildRequires: %{?scl_prefix}rubygems
BuildArch: noarch
Provides: %{?scl_prefix}rubygem(%{gem_name}) = %{version}

%description
Katello specific parts of Foreman.

%package doc
BuildArch:  noarch
Requires:   %{?scl_prefix}%{pkg_name} = %{version}-%{release}
Summary:    Documentation for rubygem-%{gem_name}

%description doc
This package contains documentation for rubygem-%{gem_name}.

%prep
%setup -n %{pkg_name}-%{version} -q -c -T
mkdir -p .%{gem_dir}
%{?scl:scl enable %{scl} "}
gem install --local --install-dir .%{gem_dir} \
            --force %{SOURCE0} --no-rdoc --no-ri
%{?scl:"}

%build

%install
mkdir -p %{buildroot}%{gem_dir}
cp -a .%{gem_dir}/* \
        %{buildroot}%{gem_dir}/

mkdir -p %{buildroot}%{foreman_bundlerd_dir}
cat <<GEMFILE > %{buildroot}%{foreman_bundlerd_dir}/katello.rb
gem 'foreman-katello-engine'
GEMFILE


%files
%dir %{gem_instdir}
%{gem_instdir}/app
%{gem_instdir}/lib
%{gem_instdir}/config
%{gem_instdir}/db
%exclude %{gem_cache}
%{gem_spec}
%{foreman_bundlerd_dir}/katello.rb
%doc %{gem_instdir}/LICENSE

%exclude %{gem_instdir}/test
%exclude %{gem_dir}/cache/%{gem_name}-%{version}.gem

%files doc
%doc %{gem_instdir}/LICENSE
%doc %{gem_instdir}/README.md
%{gem_instdir}/Rakefile
%{gem_instdir}/Gemfile
%{gem_instdir}/%{gem_name}.gemspec

%changelog
* Wed Jul 31 2013 Partha Aji <paji@redhat.com> 0.0.12-1
- Bumping the release for gemspec (paji@redhat.com)

* Wed Jul 31 2013 Partha Aji <paji@redhat.com> 0.0.11-1
- Setting#create! is now preferred way of creatting setting records
  (tstrachota@redhat.com)
- Adds proper system identification via HTTP header (mhulan@redhat.com)
- Merge pull request #15 from iNecas/tests-independence (inecas@redhat.com)
- Make sure the tests are independent (inecas@redhat.com)
- 972744 - make the API calls to Katello on behalf of the current user
  (inecas@redhat.com)
- BZ #970199 - fixes the name of the snippet (dmitri@appliedlogic.ca)

* Mon Jun 03 2013 Ivan Necas <inecas@redhat.com> 0.0.10-1
- Check we can release with tito before pushing into rubygems
  (inecas@redhat.com)

* Mon Jun 03 2013 Ivan Necas <inecas@redhat.com> 0.0.9-1
- Include all files in the app directory, not just ruby (shk@redhat.com)

* Thu May 30 2013 Ivan Necas <inecas@redhat.com> 0.0.8-1
- fixing typo in rollback migration (lzap+git@redhat.com)
- Fix licence to be GPLv3+ to match Foreman (dcleal@redhat.com)

* Wed May 29 2013 Mike McCune <mmccune@redhat.com> 0.0.8-1
- importing specfile from katello-thirdparty

* Thu May 09 2013 Ivan Necas <inecas@redhat.com> 0.0.7-1
- Add cross-link to Katello (inecas@redhat.com)

* Wed May 08 2013 Ivan Necas <inecas@redhat.com> 0.0.6-1
- Update to upstream (inecas@redhat.com)
- remove empty tito.props and definition which are duplicate with default from
  rel-eng/tito.props (msuchy@redhat.com)
- with recent tito you do not need SCL meta package (msuchy@redhat.com)

* Mon Apr 08 2013 Ivan Necas <inecas@redhat.com> 0.0.4-3
- fix dependency (inecas@redhat.com)

* Fri Mar 29 2013 Ivan Necas <inecas@redhat.com> 0.0.4-2
- SCL

* Thu Mar 28 2013 Ivan Necas <inecas@redhat.com> 0.0.4-1
- new package built with tito



