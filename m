Return-Path: <linux-acpi+bounces-2596-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0561A81CB6E
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Dec 2023 15:38:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 294031C217E2
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Dec 2023 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AD91D55E;
	Fri, 22 Dec 2023 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eb7MKkPP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F6E1CFAE;
	Fri, 22 Dec 2023 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703255922; x=1734791922;
  h=date:from:to:cc:subject:message-id;
  bh=3ccm4/0zDgn0JcMJ6cz++1E96aS6+Ihb79HHInMLl8o=;
  b=Eb7MKkPPbSWMNKfzqonLrwgSgF6+jsOn0Eff4vn/OhD4ZOxOlrner9Ue
   6q4frUIOcnbihKHLfUjeHCWfwwFAMkfyTXgbAbRYabEnSTRjIaPXr4eaq
   LPosPciNhkZIxGIWvHRJh8iFSoze7sm/7EU3eoeOFwBMa8rmqasAO9GUP
   6SR0OoIYNx3WwiGsFlmH91MQxcPNFRLBZtabN3ke8tOQ3oYtbq9Y57/dI
   K5+FKfRfnYW3fPCzYvFFodDqMuJA3Aonu0YW1dDl1mf0Xx+9JuA9h7/pu
   8tjEnHajE/BQFa1Pbqz7heC61fWNVA+Vcv2PddSoKchttzNGdDEeeDVPZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427282433"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="427282433"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 06:38:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="895479979"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="895479979"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Dec 2023 06:38:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGgfd-0009YN-2z;
	Fri, 22 Dec 2023 14:38:37 +0000
Date: Fri, 22 Dec 2023 22:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4e374de186c531ab44eb9d7bf13cd3a42e7db245
Message-ID: <202312222223.KBrNzFXU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4e374de186c531ab44eb9d7bf13cd3a42e7db245  Merge branch 'acpi-apei' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
|-- s390-allyesconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
`-- x86_64-buildonly-randconfig-003-20231222
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
clang_recent_errors
|-- x86_64-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
|-- x86_64-allyesconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
`-- x86_64-randconfig-001-20231222
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o

elapsed time: 1470m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20231222   gcc  
arc                   randconfig-002-20231222   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            mps2_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-001-20231222   gcc  
arm                   randconfig-002-20231222   gcc  
arm                   randconfig-003-20231222   gcc  
arm                   randconfig-004-20231222   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231222   gcc  
arm64                 randconfig-002-20231222   gcc  
arm64                 randconfig-003-20231222   gcc  
arm64                 randconfig-004-20231222   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231222   gcc  
csky                  randconfig-002-20231222   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231222   clang
hexagon               randconfig-002-20231222   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231222   gcc  
i386         buildonly-randconfig-002-20231222   gcc  
i386         buildonly-randconfig-003-20231222   gcc  
i386         buildonly-randconfig-004-20231222   gcc  
i386         buildonly-randconfig-005-20231222   gcc  
i386         buildonly-randconfig-006-20231222   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231222   gcc  
i386                  randconfig-002-20231222   gcc  
i386                  randconfig-003-20231222   gcc  
i386                  randconfig-004-20231222   gcc  
i386                  randconfig-005-20231222   gcc  
i386                  randconfig-006-20231222   gcc  
i386                  randconfig-011-20231222   clang
i386                  randconfig-012-20231222   clang
i386                  randconfig-013-20231222   clang
i386                  randconfig-014-20231222   clang
i386                  randconfig-015-20231222   clang
i386                  randconfig-016-20231222   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231222   gcc  
loongarch             randconfig-002-20231222   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath79_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231222   gcc  
nios2                 randconfig-002-20231222   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231222   gcc  
parisc                randconfig-002-20231222   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc               randconfig-001-20231222   gcc  
powerpc               randconfig-002-20231222   gcc  
powerpc               randconfig-003-20231222   gcc  
powerpc64             randconfig-001-20231222   gcc  
powerpc64             randconfig-002-20231222   gcc  
powerpc64             randconfig-003-20231222   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                    nommu_virt_defconfig   clang
riscv                 randconfig-001-20231222   gcc  
riscv                 randconfig-002-20231222   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20231222   clang
s390                  randconfig-002-20231222   clang
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                    randconfig-001-20231222   gcc  
sh                    randconfig-002-20231222   gcc  
sh                           se7619_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64               randconfig-001-20231222   gcc  
sparc64               randconfig-002-20231222   gcc  
um                               allmodconfig   clang
um                               allyesconfig   clang
um                    randconfig-001-20231222   gcc  
um                    randconfig-002-20231222   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231222   gcc  
x86_64       buildonly-randconfig-002-20231222   gcc  
x86_64       buildonly-randconfig-003-20231222   gcc  
x86_64       buildonly-randconfig-004-20231222   gcc  
x86_64       buildonly-randconfig-005-20231222   gcc  
x86_64       buildonly-randconfig-006-20231222   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231222   clang
x86_64                randconfig-002-20231222   clang
x86_64                randconfig-003-20231222   clang
x86_64                randconfig-004-20231222   clang
x86_64                randconfig-005-20231222   clang
x86_64                randconfig-006-20231222   clang
x86_64                randconfig-011-20231222   gcc  
x86_64                randconfig-012-20231222   gcc  
x86_64                randconfig-013-20231222   gcc  
x86_64                randconfig-014-20231222   gcc  
x86_64                randconfig-015-20231222   gcc  
x86_64                randconfig-016-20231222   gcc  
x86_64                randconfig-071-20231222   gcc  
x86_64                randconfig-072-20231222   gcc  
x86_64                randconfig-073-20231222   gcc  
x86_64                randconfig-074-20231222   gcc  
x86_64                randconfig-075-20231222   gcc  
x86_64                randconfig-076-20231222   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20231222   gcc  
xtensa                randconfig-002-20231222   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

