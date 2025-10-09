Return-Path: <linux-acpi+bounces-17663-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5C7BC779F
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 08:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FEE819E60C5
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 06:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B10E28DF33;
	Thu,  9 Oct 2025 06:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JR424Y/9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA6828D8D1;
	Thu,  9 Oct 2025 06:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989655; cv=none; b=IQqJmEHKvOuSLv+zhzle/kXuFSOc3mxE1d6kCi6bBx94Mg/g5NIfFzXi1OAluWWgXK9HPR1A/9wmCNlK5mq7yxZHIGZPZT2lEa/czUAUd/6Ml1k7eHnuGU9nLqnkvtC9jqn4XwY9pd14OYw5CWWaWfqSOibCAH3dRNfsmoR9+jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989655; c=relaxed/simple;
	bh=FCU4dazMrK0Z5c2f1ZSY/+XJujj304SKOL+Z1DhTSsk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pK4AMWKWFVIz7RjZCyu0UPLhV0q5k97cCpDZ+jaRleU0Q26JQU8pgwAvT2Ok205Wvw3zQkgbETMYLEPC3kgxSpmFty/GgAjullhyeCdKFNkVRen6GKckkFFtmDO/N3xJLQfvpns/HL2ZJKbIFm2qb7ggWhAqHCb5V69u0MTNtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JR424Y/9; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759989653; x=1791525653;
  h=date:from:to:cc:subject:message-id;
  bh=FCU4dazMrK0Z5c2f1ZSY/+XJujj304SKOL+Z1DhTSsk=;
  b=JR424Y/93myRtC3eXofRfVnth+OLGUZAXvAe0dfY1577UTWadYHEMhK5
   7G/GPN9sDkzECKoPNRk147XxH4smtd5MwmgzN5p/yKhWT7/hXkXAcyGv9
   fPd1JvwZh8SIjjH6/g1S4dwktq5VlTJByhg77x3+unyZxSspnfmygtDa/
   P3XNvtbAqRj9k+zmXRlRpddD+tuusvPTjf8zcR8/FrnezKKsty+ZQv3v6
   iqJkErS/2u17wPaDbKTfuoSrURJHqskIqZoTZYE8QPfWOYmnOdXJAybe2
   ya0hryvK/GglgWeRvKeL5f9QF7OMtMVDUZDmlCz+bEXKhWr1QmeoD3xVX
   w==;
X-CSE-ConnectionGUID: EAJ9yZosQji6hN4zCmfr2Q==
X-CSE-MsgGUID: QDtjbjE0Q/+WcFS27BIN3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11576"; a="73537201"
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="73537201"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2025 23:00:52 -0700
X-CSE-ConnectionGUID: FgMzd0UmRpKi22IiyMqD3A==
X-CSE-MsgGUID: yjo/WDs6TnSom7Ve7yp9Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,215,1754982000"; 
   d="scan'208";a="180657942"
Received: from lkp-server01.sh.intel.com (HELO 6a630e8620ab) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 08 Oct 2025 23:00:50 -0700
Received: from kbuild by 6a630e8620ab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v6jho-00002a-0R;
	Thu, 09 Oct 2025 06:00:48 +0000
Date: Thu, 09 Oct 2025 14:00:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8ddd11b0e3d3368e9404fde6b5f21e03dd85b501
Message-ID: <202510091420.vp1Z41Yv-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8ddd11b0e3d3368e9404fde6b5f21e03dd85b501  Merge branch 'pm-cpufreq' into linux-next

Unverified Warning (likely false positive, kindly check if interested):

    drivers/base/power/runtime-test.c:182 pm_runtime_error_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:22 pm_runtime_depth_test() warn: pm_runtime_get_sync() also returns 1 on success
    drivers/base/power/runtime-test.c:78 pm_runtime_idle_test() warn: pm_runtime_get_sync() also returns 1 on success
    include/linux/pm_runtime.h:631 class_pm_runtime_active_try_constructor() warn: passing zero to 'ERR_PTR'

Warning ids grouped by kconfigs:

recent_errors
|-- i386-randconfig-141-20251004
|   |-- drivers-base-power-runtime-test.c-pm_runtime_depth_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   |-- drivers-base-power-runtime-test.c-pm_runtime_error_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   |-- drivers-base-power-runtime-test.c-pm_runtime_idle_test()-warn:pm_runtime_get_sync()-also-returns-on-success
|   `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR
`-- x86_64-randconfig-161-20251004
    `-- include-linux-pm_runtime.h-class_pm_runtime_active_try_constructor()-warn:passing-zero-to-ERR_PTR

elapsed time: 7659m

configs tested: 131
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                     haps_hs_smp_defconfig    gcc-15.1.0
arc                   randconfig-001-20251004    gcc-8.5.0
arc                   randconfig-002-20251004    gcc-10.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                       aspeed_g5_defconfig    gcc-15.1.0
arm                          gemini_defconfig    clang-20
arm                            mps2_defconfig    clang-22
arm                             mxs_defconfig    clang-22
arm                   randconfig-001-20251004    gcc-8.5.0
arm                   randconfig-002-20251004    gcc-15.1.0
arm                   randconfig-003-20251004    gcc-12.5.0
arm                   randconfig-004-20251004    gcc-11.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251004    clang-20
arm64                 randconfig-002-20251004    gcc-8.5.0
arm64                 randconfig-003-20251004    clang-22
arm64                 randconfig-004-20251004    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251004    gcc-15.1.0
csky                  randconfig-002-20251004    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251004    clang-22
hexagon               randconfig-002-20251004    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251004    gcc-13
i386        buildonly-randconfig-002-20251004    clang-20
i386        buildonly-randconfig-003-20251004    clang-20
i386        buildonly-randconfig-004-20251004    clang-20
i386        buildonly-randconfig-005-20251004    clang-20
i386        buildonly-randconfig-006-20251004    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251004    gcc-15.1.0
loongarch             randconfig-002-20251004    clang-22
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           xway_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251004    gcc-10.5.0
nios2                 randconfig-002-20251004    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251004    gcc-8.5.0
parisc                randconfig-002-20251004    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                       ebony_defconfig    clang-22
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                      pasemi_defconfig    clang-22
powerpc               randconfig-001-20251004    clang-22
powerpc               randconfig-002-20251004    gcc-8.5.0
powerpc               randconfig-003-20251004    clang-22
powerpc64             randconfig-001-20251004    gcc-14.3.0
powerpc64             randconfig-002-20251004    clang-22
powerpc64             randconfig-003-20251004    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251004    clang-22
riscv                 randconfig-002-20251004    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20251004    gcc-8.5.0
s390                  randconfig-002-20251004    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251004    gcc-15.1.0
sh                    randconfig-002-20251004    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251004    gcc-8.5.0
sparc                 randconfig-002-20251004    gcc-15.1.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251004    gcc-14.3.0
sparc64               randconfig-002-20251004    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251004    clang-18
um                    randconfig-002-20251004    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251004    gcc-14
x86_64      buildonly-randconfig-002-20251004    clang-20
x86_64      buildonly-randconfig-003-20251004    clang-20
x86_64      buildonly-randconfig-004-20251004    clang-20
x86_64      buildonly-randconfig-005-20251004    gcc-14
x86_64      buildonly-randconfig-006-20251004    gcc-14
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251004    gcc-13.4.0
xtensa                randconfig-002-20251004    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

