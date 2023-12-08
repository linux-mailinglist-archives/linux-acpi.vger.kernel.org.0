Return-Path: <linux-acpi+bounces-2250-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A6380AEFD
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 22:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CAE71F211F3
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Dec 2023 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D1F58AA9;
	Fri,  8 Dec 2023 21:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1Sfyph+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5546D10E0;
	Fri,  8 Dec 2023 13:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702072240; x=1733608240;
  h=date:from:to:cc:subject:message-id;
  bh=e8Y0PjF8T4uapBFY2FjiIiebyRDxyX87pPuV9t/vp5g=;
  b=i1Sfyph+C31IgW1yUP1vzystS180YfbcoXULrY8ARlAsVWuQG3JNmZWQ
   EB2feQJ7iPRUkmY6eRej5w3swRC2OuD9TKIXoVz1CFPTQ+bVadtWzVk+V
   tRYitcOCw+GOUq4Lbxntq/ZaC73iJndWlzRqC8MeMwg/ad2HzFz3mocDY
   ewpCLNUlg/tk1HG8AYz8wPXlU4PXQZhjrEAkq+Eis3GGgJs/QbVdS5djq
   AyPUS6B+ubLkn5ifwEEcXG0Hp31vy0AIu3YjxqJT13Mc5ypAS7CyXYJG+
   k/jHl7gMarN14zZ+vDPz8Yp2yhONmskVhZ8QFXplf5b5olqvXWsfLwBFe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="391641065"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="391641065"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 13:50:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="801240867"
X-IronPort-AV: E=Sophos;i="6.04,261,1695711600"; 
   d="scan'208";a="801240867"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 08 Dec 2023 13:50:37 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rBijz-000EQH-28;
	Fri, 08 Dec 2023 21:50:35 +0000
Date: Sat, 09 Dec 2023 05:50:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 169769cb3761a9d80809ad64ed85e9b1f5b3a810
Message-ID: <202312090511.bO2VCDug-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 169769cb3761a9d80809ad64ed85e9b1f5b3a810  Merge branch 'acpi-utils-fix' into linux-next

Warning ids grouped by kconfigs:

clang_recent_errors
`-- x86_64-allyesconfig
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-busymod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-demo.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-callbacks-mod.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-sample.o
    |-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix1.o
    `-- WARNING:modpost:missing-MODULE_DESCRIPTION()-in-samples-livepatch-livepatch-shadow-fix2.o

elapsed time: 1467m

configs tested: 171
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
arc                   randconfig-001-20231208   gcc  
arc                   randconfig-002-20231208   gcc  
arc                           tb10x_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                            dove_defconfig   clang
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20231208   clang
arm                   randconfig-002-20231208   clang
arm                   randconfig-003-20231208   clang
arm                   randconfig-004-20231208   clang
arm                         s3c6400_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231208   clang
arm64                 randconfig-002-20231208   clang
arm64                 randconfig-003-20231208   clang
arm64                 randconfig-004-20231208   clang
csky                             alldefconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231208   gcc  
csky                  randconfig-002-20231208   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20231208   clang
hexagon               randconfig-002-20231208   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20231208   clang
i386         buildonly-randconfig-002-20231208   clang
i386         buildonly-randconfig-003-20231208   clang
i386         buildonly-randconfig-004-20231208   clang
i386         buildonly-randconfig-005-20231208   clang
i386         buildonly-randconfig-006-20231208   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20231208   clang
i386                  randconfig-002-20231208   clang
i386                  randconfig-003-20231208   clang
i386                  randconfig-004-20231208   clang
i386                  randconfig-005-20231208   clang
i386                  randconfig-006-20231208   clang
i386                  randconfig-011-20231208   gcc  
i386                  randconfig-012-20231208   gcc  
i386                  randconfig-013-20231208   gcc  
i386                  randconfig-014-20231208   gcc  
i386                  randconfig-015-20231208   gcc  
i386                  randconfig-016-20231208   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231208   gcc  
loongarch             randconfig-002-20231208   gcc  
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
mips                 decstation_r4k_defconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                      malta_kvm_defconfig   clang
mips                      maltaaprp_defconfig   clang
mips                          rb532_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231208   gcc  
nios2                 randconfig-002-20231208   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231208   gcc  
parisc                randconfig-002-20231208   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc               randconfig-001-20231208   clang
powerpc               randconfig-002-20231208   clang
powerpc               randconfig-003-20231208   clang
powerpc                      walnut_defconfig   clang
powerpc64             randconfig-001-20231208   clang
powerpc64             randconfig-002-20231208   clang
powerpc64             randconfig-003-20231208   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   clang
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231208   clang
riscv                 randconfig-002-20231208   clang
riscv                          rv32_defconfig   clang
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231208   gcc  
s390                  randconfig-002-20231208   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231208   gcc  
sh                    randconfig-002-20231208   gcc  
sh                        sh7763rdp_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231208   gcc  
sparc64               randconfig-002-20231208   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231208   clang
um                    randconfig-002-20231208   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20231208   clang
x86_64       buildonly-randconfig-002-20231208   clang
x86_64       buildonly-randconfig-003-20231208   clang
x86_64       buildonly-randconfig-004-20231208   clang
x86_64       buildonly-randconfig-005-20231208   clang
x86_64       buildonly-randconfig-006-20231208   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231208   gcc  
x86_64                randconfig-002-20231208   gcc  
x86_64                randconfig-003-20231208   gcc  
x86_64                randconfig-004-20231208   gcc  
x86_64                randconfig-005-20231208   gcc  
x86_64                randconfig-006-20231208   gcc  
x86_64                randconfig-011-20231208   clang
x86_64                randconfig-012-20231208   clang
x86_64                randconfig-013-20231208   clang
x86_64                randconfig-014-20231208   clang
x86_64                randconfig-015-20231208   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20231208   gcc  
xtensa                randconfig-002-20231208   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

