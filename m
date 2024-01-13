Return-Path: <linux-acpi+bounces-2833-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B9F82CD94
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jan 2024 16:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD9881F2263B
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Jan 2024 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900BC1FA4;
	Sat, 13 Jan 2024 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ewlU6F6p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8F23AD;
	Sat, 13 Jan 2024 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705160767; x=1736696767;
  h=date:from:to:cc:subject:message-id;
  bh=HeB047Qg9LA2ybr5pLWsN6OfYSQtF62oj7HnyAFAlKs=;
  b=ewlU6F6pyTHKH9mW6QQEl2po5QrPisF2YssdIiCilLJ35jkOAKsJaWrD
   jZuAG360aX/ZokES2iUnB1y4SDg6GQ/i7eQaIFb3+FGhtvQQ7yUyOp59C
   TCUCskMbAbkPd2laAiraP4Kgde6nkGX0gQ2Boz7ABUpraWofAouMhnWA0
   jpN22hoyA2rr8LLDQnlmFONHQXiqvCTttaBRp1BaI72b5O1gpc9iy+sAw
   tj7cafKsrp0ZSTo37Zjq7cm0SuBopfL1PsELTrOgSIJPlg2Yd5tDzDOkF
   Q4GDrc5y+VZbgGvuovF6GlBhP/zHFApMGIRTOydJM27LbChElOIUBtuYp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="465771363"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="465771363"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 07:46:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="25025828"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 13 Jan 2024 07:46:05 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOgCv-000AdQ-0x;
	Sat, 13 Jan 2024 15:46:01 +0000
Date: Sat, 13 Jan 2024 23:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 15f5ad190ec05493ea77da93644d86d26834b485
Message-ID: <202401132300.UJEwM93p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 15f5ad190ec05493ea77da93644d86d26834b485  Merge branch 'thermal-core' into linux-next

elapsed time: 1463m

configs tested: 174
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
arc                   randconfig-001-20240113   gcc  
arc                   randconfig-002-20240113   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                   randconfig-001-20240113   gcc  
arm                   randconfig-002-20240113   gcc  
arm                   randconfig-003-20240113   gcc  
arm                   randconfig-004-20240113   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240113   gcc  
arm64                 randconfig-002-20240113   gcc  
arm64                 randconfig-003-20240113   gcc  
arm64                 randconfig-004-20240113   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240113   gcc  
csky                  randconfig-002-20240113   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240113   clang
hexagon               randconfig-002-20240113   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240113   gcc  
i386         buildonly-randconfig-002-20240113   gcc  
i386         buildonly-randconfig-003-20240113   gcc  
i386         buildonly-randconfig-004-20240113   gcc  
i386         buildonly-randconfig-005-20240113   gcc  
i386         buildonly-randconfig-006-20240113   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20240113   gcc  
i386                  randconfig-002-20240113   gcc  
i386                  randconfig-003-20240113   gcc  
i386                  randconfig-004-20240113   gcc  
i386                  randconfig-005-20240113   gcc  
i386                  randconfig-006-20240113   gcc  
i386                  randconfig-011-20240113   clang
i386                  randconfig-012-20240113   clang
i386                  randconfig-013-20240113   clang
i386                  randconfig-014-20240113   clang
i386                  randconfig-015-20240113   clang
i386                  randconfig-016-20240113   clang
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240113   gcc  
loongarch             randconfig-002-20240113   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240113   gcc  
nios2                 randconfig-002-20240113   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240113   gcc  
parisc                randconfig-002-20240113   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                 mpc8313_rdb_defconfig   clang
powerpc               randconfig-001-20240113   gcc  
powerpc               randconfig-002-20240113   gcc  
powerpc               randconfig-003-20240113   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     taishan_defconfig   gcc  
powerpc                     tqm8540_defconfig   gcc  
powerpc64             randconfig-001-20240113   gcc  
powerpc64             randconfig-002-20240113   gcc  
powerpc64             randconfig-003-20240113   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20240113   gcc  
riscv                 randconfig-002-20240113   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20240113   clang
s390                  randconfig-002-20240113   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          lboxre2_defconfig   gcc  
sh                    randconfig-001-20240113   gcc  
sh                    randconfig-002-20240113   gcc  
sh                            titan_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240113   gcc  
sparc64               randconfig-002-20240113   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20240113   gcc  
um                    randconfig-002-20240113   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240113   gcc  
x86_64       buildonly-randconfig-002-20240113   gcc  
x86_64       buildonly-randconfig-003-20240113   gcc  
x86_64       buildonly-randconfig-004-20240113   gcc  
x86_64       buildonly-randconfig-005-20240113   gcc  
x86_64       buildonly-randconfig-006-20240113   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240113   clang
x86_64                randconfig-002-20240113   clang
x86_64                randconfig-003-20240113   clang
x86_64                randconfig-004-20240113   clang
x86_64                randconfig-005-20240113   clang
x86_64                randconfig-006-20240113   clang
x86_64                randconfig-011-20240113   gcc  
x86_64                randconfig-012-20240113   gcc  
x86_64                randconfig-013-20240113   gcc  
x86_64                randconfig-014-20240113   gcc  
x86_64                randconfig-015-20240113   gcc  
x86_64                randconfig-016-20240113   gcc  
x86_64                randconfig-071-20240113   gcc  
x86_64                randconfig-072-20240113   gcc  
x86_64                randconfig-073-20240113   gcc  
x86_64                randconfig-074-20240113   gcc  
x86_64                randconfig-075-20240113   gcc  
x86_64                randconfig-076-20240113   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240113   gcc  
xtensa                randconfig-002-20240113   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

