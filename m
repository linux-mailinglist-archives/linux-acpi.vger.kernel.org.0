Return-Path: <linux-acpi+bounces-2647-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329EA82083C
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Dec 2023 20:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56B1B1C21E0F
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Dec 2023 19:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCEDBE4C;
	Sat, 30 Dec 2023 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqOaGFUL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABA3D29F;
	Sat, 30 Dec 2023 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703963362; x=1735499362;
  h=date:from:to:cc:subject:message-id;
  bh=mPmyZFCBxWX5+HP6lIx+9RsXRZ/8BVf92xkr+fbWpmc=;
  b=fqOaGFULUu2AZNzzbkMvsD/6dnSUZzFKorg2xSoErpf7GZN7pTnsHXvR
   F3NdxVvtLrxWBkF5RWr5ZIOwUG9JG+tPrKMFrDfyPD+hU+XehGRg3YkzF
   KRhu1ezN47p/KSQHxBe+qS6jb0hOARgCT2uTTZMVhfJxvzr1+tprh8kKG
   wKs23SuisAsZQ8a/52UvUXizSsN2msz/8cMIwG4CecjSJ2xJBbw81Indp
   NuIE78iXlwZy/XqWzqgXb9xGKbnrnRPTDH0rdHemjE8inwO3FeSUrZHix
   OkuX3HkhylpG99uNeCtL5JSMQo6nPYtSnZK1fuNbTZyW2HXuRMYYgEmxX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="10113323"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="10113323"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2023 11:09:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10939"; a="902509416"
X-IronPort-AV: E=Sophos;i="6.04,318,1695711600"; 
   d="scan'208";a="902509416"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 30 Dec 2023 11:09:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJehw-000IhV-1b;
	Sat, 30 Dec 2023 19:09:16 +0000
Date: Sun, 31 Dec 2023 03:09:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 85286fa00783a83c0db17a934a2a5ec11d10800b
Message-ID: <202312310306.y9G4CC70-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 85286fa00783a83c0db17a934a2a5ec11d10800b  Merge branch 'acpi-button' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- s390-allmodconfig
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
|   |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
|   `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o
`-- s390-allyesconfig
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

elapsed time: 1456m

configs tested: 179
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
arc                   randconfig-001-20231230   gcc  
arc                   randconfig-002-20231230   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   clang
arm                   randconfig-001-20231230   clang
arm                   randconfig-002-20231230   clang
arm                   randconfig-003-20231230   clang
arm                   randconfig-004-20231230   clang
arm                        realview_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           stm32_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231230   clang
arm64                 randconfig-002-20231230   clang
arm64                 randconfig-003-20231230   clang
arm64                 randconfig-004-20231230   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231230   gcc  
csky                  randconfig-002-20231230   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231230   clang
hexagon               randconfig-002-20231230   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231230   clang
i386         buildonly-randconfig-002-20231230   clang
i386         buildonly-randconfig-003-20231230   clang
i386         buildonly-randconfig-004-20231230   clang
i386         buildonly-randconfig-005-20231230   clang
i386         buildonly-randconfig-006-20231230   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231230   clang
i386                  randconfig-002-20231230   clang
i386                  randconfig-003-20231230   clang
i386                  randconfig-004-20231230   clang
i386                  randconfig-005-20231230   clang
i386                  randconfig-006-20231230   clang
i386                  randconfig-011-20231230   gcc  
i386                  randconfig-012-20231230   gcc  
i386                  randconfig-013-20231230   gcc  
i386                  randconfig-014-20231230   gcc  
i386                  randconfig-015-20231230   gcc  
i386                  randconfig-016-20231230   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231230   gcc  
loongarch             randconfig-002-20231230   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231230   gcc  
nios2                 randconfig-002-20231230   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231230   gcc  
parisc                randconfig-002-20231230   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                    amigaone_defconfig   gcc  
powerpc                      arches_defconfig   gcc  
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20231230   clang
powerpc               randconfig-002-20231230   clang
powerpc               randconfig-003-20231230   clang
powerpc64             randconfig-001-20231230   clang
powerpc64             randconfig-002-20231230   clang
powerpc64             randconfig-003-20231230   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20231230   clang
riscv                 randconfig-002-20231230   clang
riscv                          rv32_defconfig   clang
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231230   gcc  
s390                  randconfig-002-20231230   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20231230   gcc  
sh                    randconfig-002-20231230   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231230   gcc  
sparc64               randconfig-002-20231230   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231230   clang
um                    randconfig-002-20231230   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231230   clang
x86_64       buildonly-randconfig-002-20231230   clang
x86_64       buildonly-randconfig-003-20231230   clang
x86_64       buildonly-randconfig-004-20231230   clang
x86_64       buildonly-randconfig-005-20231230   clang
x86_64       buildonly-randconfig-006-20231230   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231230   gcc  
x86_64                randconfig-002-20231230   gcc  
x86_64                randconfig-003-20231230   gcc  
x86_64                randconfig-004-20231230   gcc  
x86_64                randconfig-005-20231230   gcc  
x86_64                randconfig-006-20231230   gcc  
x86_64                randconfig-011-20231230   clang
x86_64                randconfig-012-20231230   clang
x86_64                randconfig-013-20231230   clang
x86_64                randconfig-014-20231230   clang
x86_64                randconfig-015-20231230   clang
x86_64                randconfig-016-20231230   clang
x86_64                randconfig-071-20231230   clang
x86_64                randconfig-072-20231230   clang
x86_64                randconfig-073-20231230   clang
x86_64                randconfig-074-20231230   clang
x86_64                randconfig-075-20231230   clang
x86_64                randconfig-076-20231230   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231230   gcc  
xtensa                randconfig-002-20231230   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

