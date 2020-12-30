Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285D82E7629
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Dec 2020 06:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgL3FTM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 30 Dec 2020 00:19:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:18802 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL3FTM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Dec 2020 00:19:12 -0500
IronPort-SDR: BbUjCSG+nfP426y45FPkB4eAjFCVjBDqVsnaoZ+GpnqS8oml6aHa0mAF6UZn1TWkuWTsj+nxEY
 hV9iuJ3P5aVQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176724342"
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="176724342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 21:18:31 -0800
IronPort-SDR: KVrMcJBxkoh6uPezi1lmCqno4I9Q0g4ugYXc8UMLlxh68EAFpNXEBkqZOi/HF9bnCwonZaY13W
 HqRyZlaXcoMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,460,1599548400"; 
   d="scan'208";a="460360537"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2020 21:18:29 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kuTsT-000422-2j; Wed, 30 Dec 2020 05:18:29 +0000
Date:   Wed, 30 Dec 2020 13:17:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD REGRESSION
 0c7a6fd3a0e835b0158a1f52176f5d3858fac110
Message-ID: <5fec0d86.i0RjnNeExICZGSu7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 0c7a6fd3a0e835b0158a1f52176f5d3858fac110  Merge branch 'pm-cpuidle-next' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp@intel.com
https://lore.kernel.org/linux-acpi/202012271352.JvNDF17O-lkp@intel.com
https://lore.kernel.org/linux-acpi/202012280239.stlWMtr3-lkp@intel.com
https://lore.kernel.org/linux-acpi/202012280249.nrNm8Jn3-lkp@intel.com

Error/Warning in current branch:

drivers/acpi/platform_profile.c:147:24: warning: address of array 'pprof->choices' will always evaluate to 'true' [-Wpointer-bool-conversion]
drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used [-Wunused-but-set-variable]
drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not used [-Wunused-but-set-variable]
dtpm.c:(.text+0x24c): undefined reference to `__udivdi3'
dtpm.c:(.text+0x2a4): undefined reference to `__udivdi3'
dtpm.c:(.text+0x3bc): undefined reference to `__udivdi3'
dtpm.c:(.text+0x514): undefined reference to `__aeabi_uldivmod'
dtpm.c:(.text+0x52d): undefined reference to `__udivdi3'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- arm-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__aeabi_uldivmod
|-- h8300-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- h8300-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- i386-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- i386-randconfig-a006-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-r002-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-s001-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- m68k-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- m68k-allyesconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- sh-allmodconfig
|   `-- dtpm.c:(.text):undefined-reference-to-__udivdi3
|-- x86_64-randconfig-a002-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a004-20201229
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
`-- x86_64-randconfig-s021-20201229
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

clang_recent_errors
|-- x86_64-randconfig-a011-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
|-- x86_64-randconfig-a012-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
|-- x86_64-randconfig-a013-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
|-- x86_64-randconfig-a014-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
|-- x86_64-randconfig-a015-20201229
|   `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true
`-- x86_64-randconfig-a016-20201229
    `-- drivers-acpi-platform_profile.c:warning:address-of-array-pprof-choices-will-always-evaluate-to-true

elapsed time: 724m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                           se7619_defconfig
sh                        sh7785lcr_defconfig
arm                        trizeps4_defconfig
mips                        workpad_defconfig
um                           x86_64_defconfig
mips                     cu1000-neo_defconfig
m68k                          sun3x_defconfig
mips                        bcm47xx_defconfig
arm                            mps2_defconfig
mips                         tb0287_defconfig
s390                          debug_defconfig
arm                           sama5_defconfig
arm                         s3c2410_defconfig
arm                         lpc18xx_defconfig
sh                         microdev_defconfig
arm                         s5pv210_defconfig
mips                         tb0226_defconfig
arm                          pxa910_defconfig
c6x                        evmc6474_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a001-20201229
x86_64               randconfig-a006-20201229
x86_64               randconfig-a002-20201229
x86_64               randconfig-a004-20201229
x86_64               randconfig-a003-20201229
x86_64               randconfig-a005-20201229
i386                 randconfig-a002-20201229
i386                 randconfig-a005-20201229
i386                 randconfig-a004-20201229
i386                 randconfig-a006-20201229
i386                 randconfig-a003-20201229
i386                 randconfig-a001-20201229
i386                 randconfig-a014-20201229
i386                 randconfig-a012-20201229
i386                 randconfig-a011-20201229
i386                 randconfig-a016-20201229
i386                 randconfig-a015-20201229
i386                 randconfig-a013-20201229
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20201229
x86_64               randconfig-a015-20201229
x86_64               randconfig-a016-20201229
x86_64               randconfig-a012-20201229
x86_64               randconfig-a011-20201229
x86_64               randconfig-a013-20201229

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
