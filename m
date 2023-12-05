Return-Path: <linux-acpi+bounces-2155-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE0805A0F
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 17:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B32D282076
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 16:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B97675AD
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Dec 2023 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDjGX42x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A97EBA;
	Tue,  5 Dec 2023 07:59:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701791983; x=1733327983;
  h=date:from:to:cc:subject:message-id;
  bh=9gi9Q5dPPsTINOugO1Uy8KpyrPJChX9pvm2AkXJ/cGI=;
  b=JDjGX42xiBa6smj2KgEhWAV/ZXmVffyNlUy1QOAADiivEOuaMUWXx31L
   k5VeSb0LuY1fQ5qMFNuHcyrGOtzGTxuRynoKb/a7/E7fVXFOXC6n5ctKd
   an8Qj7jzXD5iS+q/GiCMSUXXzXpzsKhw386gDFSabA8Ld1lDfH53dU4J7
   r2VFJbCuuTRKHtMgpPNjUtpRgztCwGE4Timb/fkv7fQrf54ABywago9+A
   DQjLI0xqsFuUvajfB315COCYMFK1W36xUsaXRpdaom4uaDV8DTxVEe25m
   GuFNeB3klxn4j/ULbj6FFHRTmMmKtliOZt9VdElfh0z5lfSL+GILfnDxN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1000678"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="1000678"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 07:59:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774672760"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="774672760"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 05 Dec 2023 07:59:41 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rAXpj-0009GX-1v;
	Tue, 05 Dec 2023 15:59:39 +0000
Date: Tue, 05 Dec 2023 23:59:06 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ded74510ac4ba22b6c9d4731a869c22b4eb31acc
Message-ID: <202312052303.2eIbiDat-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ded74510ac4ba22b6c9d4731a869c22b4eb31acc  Merge branch 'acpi-osl' into linux-next

elapsed time: 1456m

configs tested: 214
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
arc                          axs103_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                   randconfig-001-20231205   gcc  
arc                   randconfig-002-20231205   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   clang
arm                          exynos_defconfig   gcc  
arm                             mxs_defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20231205   gcc  
arm                   randconfig-002-20231205   gcc  
arm                   randconfig-003-20231205   gcc  
arm                   randconfig-004-20231205   gcc  
arm                         s5pv210_defconfig   clang
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231205   gcc  
arm64                 randconfig-002-20231205   gcc  
arm64                 randconfig-003-20231205   gcc  
arm64                 randconfig-004-20231205   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231205   gcc  
csky                  randconfig-002-20231205   gcc  
hexagon                          alldefconfig   clang
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231205   clang
hexagon               randconfig-002-20231205   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231205   gcc  
i386         buildonly-randconfig-002-20231205   gcc  
i386         buildonly-randconfig-003-20231205   gcc  
i386         buildonly-randconfig-004-20231205   gcc  
i386         buildonly-randconfig-005-20231205   gcc  
i386         buildonly-randconfig-006-20231205   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231205   gcc  
i386                  randconfig-002-20231205   gcc  
i386                  randconfig-003-20231205   gcc  
i386                  randconfig-004-20231205   gcc  
i386                  randconfig-005-20231205   gcc  
i386                  randconfig-006-20231205   gcc  
i386                  randconfig-011-20231205   clang
i386                  randconfig-012-20231205   clang
i386                  randconfig-013-20231205   clang
i386                  randconfig-014-20231205   clang
i386                  randconfig-015-20231205   clang
i386                  randconfig-016-20231205   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231205   gcc  
loongarch             randconfig-002-20231205   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                         rt305x_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231205   gcc  
nios2                 randconfig-002-20231205   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                       virt_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20231205   gcc  
parisc                randconfig-002-20231205   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 canyonlands_defconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                      ep88xc_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc               randconfig-001-20231205   gcc  
powerpc               randconfig-002-20231205   gcc  
powerpc               randconfig-003-20231205   gcc  
powerpc                     redwood_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
powerpc                      tqm8xx_defconfig   gcc  
powerpc                        warp_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20231205   gcc  
powerpc64             randconfig-002-20231205   gcc  
powerpc64             randconfig-003-20231205   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231205   gcc  
riscv                 randconfig-002-20231205   gcc  
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231205   clang
s390                  randconfig-002-20231205   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                    randconfig-001-20231205   gcc  
sh                    randconfig-002-20231205   gcc  
sh                           se7724_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231205   gcc  
sparc64               randconfig-002-20231205   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231205   gcc  
um                    randconfig-002-20231205   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231205   gcc  
x86_64       buildonly-randconfig-002-20231205   gcc  
x86_64       buildonly-randconfig-003-20231205   gcc  
x86_64       buildonly-randconfig-004-20231205   gcc  
x86_64       buildonly-randconfig-005-20231205   gcc  
x86_64       buildonly-randconfig-006-20231205   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231205   clang
x86_64                randconfig-002-20231205   clang
x86_64                randconfig-003-20231205   clang
x86_64                randconfig-004-20231205   clang
x86_64                randconfig-005-20231205   clang
x86_64                randconfig-006-20231205   clang
x86_64                randconfig-011-20231205   gcc  
x86_64                randconfig-012-20231205   gcc  
x86_64                randconfig-013-20231205   gcc  
x86_64                randconfig-014-20231205   gcc  
x86_64                randconfig-015-20231205   gcc  
x86_64                randconfig-016-20231205   gcc  
x86_64                randconfig-071-20231205   gcc  
x86_64                randconfig-072-20231205   gcc  
x86_64                randconfig-073-20231205   gcc  
x86_64                randconfig-074-20231205   gcc  
x86_64                randconfig-075-20231205   gcc  
x86_64                randconfig-076-20231205   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20231205   gcc  
xtensa                randconfig-002-20231205   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

