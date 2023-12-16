Return-Path: <linux-acpi+bounces-2494-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEEF815B0C
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Dec 2023 19:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E296B1C219E3
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Dec 2023 18:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76DA30CFA;
	Sat, 16 Dec 2023 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TZTrNHAO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3185321B7;
	Sat, 16 Dec 2023 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702751204; x=1734287204;
  h=date:from:to:cc:subject:message-id;
  bh=qI/zSIVIJ1UWdpWxxcJLsEoloAqrOOxgpOiTNb9x5cM=;
  b=TZTrNHAO7sDCoKB0gqJguKC0JSs1nZ5i/T+pRwyVy3DFU46kAUHZKtXX
   5x4CLmgYv/Vyx4wP4IkvobmCDtFsxYR1xo9ckSrbAJdpuPNrrkXga7VU3
   ocpz+sv2EfwXHyXIK4RMBfCUIf9hv3Ho7BR78jPK34kAmydqeYxiEt2BO
   cyx07tu9cVw9BDnu6JrW6BCh4Mn0t1LTfE7Gwj4tJ3e6tboXa8OX2XEF0
   lqerynJ9iF+l7O5VGMvvsxWsSl7a0SersO3/AJAoPzT4FFGLnA5YrHTy6
   N9/tGTRs9CRtbXNkmKkmmSK53nRJCES2rrfYpfIRNCPYC2rsDkF7AVlnD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="380377685"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="380377685"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2023 10:26:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10926"; a="768355516"
X-IronPort-AV: E=Sophos;i="6.04,281,1695711600"; 
   d="scan'208";a="768355516"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2023 10:26:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rEZN0-00020t-2Y;
	Sat, 16 Dec 2023 18:26:38 +0000
Date: Sun, 17 Dec 2023 02:26:29 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ccca2f50d14c99bce8dc7e52d4f757edd8a38bbf
Message-ID: <202312170226.nLlFdsqt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ccca2f50d14c99bce8dc7e52d4f757edd8a38bbf  Merge branch 'thermal-core' into bleeding-edge

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
`-- x86_64-buildonly-randconfig-002-20231216
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
`-- x86_64-allyesconfig
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o

elapsed time: 1475m

configs tested: 169
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231216   gcc  
arc                   randconfig-002-20231216   gcc  
arc                           tb10x_defconfig   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                               allnoconfig   gcc  
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20231216   gcc  
arm                   randconfig-002-20231216   gcc  
arm                   randconfig-003-20231216   gcc  
arm                   randconfig-004-20231216   gcc  
arm                          sp7021_defconfig   clang
arm                           spitz_defconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231216   gcc  
arm64                 randconfig-002-20231216   gcc  
arm64                 randconfig-003-20231216   gcc  
arm64                 randconfig-004-20231216   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231216   gcc  
csky                  randconfig-002-20231216   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231216   clang
hexagon               randconfig-002-20231216   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231216   gcc  
i386         buildonly-randconfig-002-20231216   gcc  
i386         buildonly-randconfig-003-20231216   gcc  
i386         buildonly-randconfig-004-20231216   gcc  
i386         buildonly-randconfig-005-20231216   gcc  
i386         buildonly-randconfig-006-20231216   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231216   gcc  
i386                  randconfig-002-20231216   gcc  
i386                  randconfig-003-20231216   gcc  
i386                  randconfig-004-20231216   gcc  
i386                  randconfig-005-20231216   gcc  
i386                  randconfig-006-20231216   gcc  
i386                  randconfig-011-20231216   clang
i386                  randconfig-012-20231216   clang
i386                  randconfig-013-20231216   clang
i386                  randconfig-014-20231216   clang
i386                  randconfig-015-20231216   clang
i386                  randconfig-016-20231216   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231216   gcc  
loongarch             randconfig-002-20231216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                      bmips_stb_defconfig   clang
mips                          malta_defconfig   clang
mips                        vocore2_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231216   gcc  
nios2                 randconfig-002-20231216   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231216   gcc  
parisc                randconfig-002-20231216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                   bluestone_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc               randconfig-001-20231216   gcc  
powerpc               randconfig-002-20231216   gcc  
powerpc               randconfig-003-20231216   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20231216   gcc  
powerpc64             randconfig-002-20231216   gcc  
powerpc64             randconfig-003-20231216   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231216   gcc  
riscv                 randconfig-002-20231216   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231216   clang
s390                  randconfig-002-20231216   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231216   gcc  
sh                    randconfig-002-20231216   gcc  
sh                          rsk7269_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231216   gcc  
sparc64               randconfig-002-20231216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231216   gcc  
um                    randconfig-002-20231216   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231216   gcc  
x86_64       buildonly-randconfig-002-20231216   gcc  
x86_64       buildonly-randconfig-003-20231216   gcc  
x86_64       buildonly-randconfig-004-20231216   gcc  
x86_64       buildonly-randconfig-005-20231216   gcc  
x86_64       buildonly-randconfig-006-20231216   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231216   clang
x86_64                randconfig-002-20231216   clang
x86_64                randconfig-003-20231216   clang
x86_64                randconfig-004-20231216   clang
x86_64                randconfig-005-20231216   clang
x86_64                randconfig-006-20231216   clang
x86_64                randconfig-011-20231216   gcc  
x86_64                randconfig-012-20231216   gcc  
x86_64                randconfig-013-20231216   gcc  
x86_64                randconfig-014-20231216   gcc  
x86_64                randconfig-015-20231216   gcc  
x86_64                randconfig-016-20231216   gcc  
x86_64                randconfig-071-20231216   gcc  
x86_64                randconfig-072-20231216   gcc  
x86_64                randconfig-073-20231216   gcc  
x86_64                randconfig-074-20231216   gcc  
x86_64                randconfig-075-20231216   gcc  
x86_64                randconfig-076-20231216   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231216   gcc  
xtensa                randconfig-002-20231216   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

