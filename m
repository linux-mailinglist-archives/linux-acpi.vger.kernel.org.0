Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7D854AA7BB
	for <lists+linux-acpi@lfdr.de>; Sat,  5 Feb 2022 09:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiBEItX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 5 Feb 2022 03:49:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:32246 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232461AbiBEItW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 5 Feb 2022 03:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644050962; x=1675586962;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=4NRaCf50AvqUsL6DWfxkD7/BXjABUN0b0Mvb4hpkGW0=;
  b=bvKMWrlReVOyQQ4tJ8HMeZWU5tV3xrJJ1WBGch1YHjs1AeLvWKRbh0u2
   E/lcMhHQch2nVHgHd0FVR2Mc26105nkeZiVemsmFJXJLHLiSNj6hZzZYO
   x0y4IG3jI2TfxPRafNgaZZY03EyngGJZzCAbGPokVbSHmD6lx3slgiokZ
   zYyje6/DMO65X9xP2k9k/Zwz+7BqShxGAeM/CkmpjgsTeIzlkwGZeNrrl
   7WW+7JXPuvGbkEIrwFUpEGOQhM2gsVnBcNq1Q7Z1dvM0mrlqFmiYHf87c
   Fd7hORHUarnO+a1gShGze1xJ8Di0Xn3KKNXsF3+hs7GUI1SMvpGu9/TgK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246088510"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="246088510"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 00:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="631943712"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Feb 2022 00:49:19 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGGkx-000YoC-0v; Sat, 05 Feb 2022 08:49:19 +0000
Date:   Sat, 05 Feb 2022 16:49:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 32ee4d3735ab552d457eeae837ef1ce10360585e
Message-ID: <61fe3a06.GThAYLvk1hSuoU/Q%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 32ee4d3735ab552d457eeae837ef1ce10360585e  Merge branch 'devprop' into bleeding-edge

possible Warning in current branch (please contact us if interested):

drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/st/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]
drivers/thermal/thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-buildonly-randconfig-r004-20220201
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arc-randconfig-r043-20220130
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-defconfig
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- drivers-thermal-st-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-randconfig-r023-20220131
|   `-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-randconfig-r034-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm64-defconfig
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-randconfig-r035-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- ia64-randconfig-s032-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- m68k-randconfig-r031-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- microblaze-randconfig-r036-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- nds32-randconfig-c024-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-randconfig-r011-20220130
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-randconfig-r024-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- riscv-randconfig-r042-20220130
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- s390-randconfig-r023-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
`-- s390-randconfig-r044-20220130
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration

clang_recent_errors
|-- arm-randconfig-r016-20220130
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- arm64-randconfig-r026-20220131
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r006-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r041-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220131
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220203
|   |-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-a011
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-a013
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- i386-randconfig-c001
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- riscv-randconfig-c006-20220130
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a011-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a012-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a013-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a014-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a015-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- x86_64-randconfig-a016-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
`-- x86_64-randconfig-c007
    `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function

elapsed time: 721m

configs tested: 119
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20220131
arm                         vf610m4_defconfig
powerpc64                        alldefconfig
sh                        sh7757lcr_defconfig
mips                      fuloong2e_defconfig
mips                  maltasmvp_eva_defconfig
mips                         db1xxx_defconfig
arm                       aspeed_g5_defconfig
sh                         ap325rxa_defconfig
arm                        clps711x_defconfig
sh                          landisk_defconfig
mips                     loongson1b_defconfig
arm                           corgi_defconfig
xtensa                    xip_kc705_defconfig
arc                     nsimosci_hs_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
nios2                            allyesconfig
alpha                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                 randconfig-a003-20220131
i386                 randconfig-a002-20220131
i386                 randconfig-a001-20220131
i386                 randconfig-a004-20220131
i386                 randconfig-a006-20220131
i386                 randconfig-a005-20220131
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220203
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
riscv                randconfig-r042-20220203
s390                 randconfig-r044-20220130
s390                 randconfig-r044-20220203
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
x86_64               randconfig-a004-20220131
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64                        randconfig-c007
arm                  randconfig-c002-20220130
powerpc              randconfig-c003-20220130
mips                 randconfig-c004-20220130
s390                 randconfig-c005-20220130
i386                          randconfig-c001
riscv                randconfig-c006-20220130
powerpc                      ppc44x_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
x86_64               randconfig-a013-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
x86_64               randconfig-a015-20220131
i386                          randconfig-a013
i386                          randconfig-a015
i386                          randconfig-a011
riscv                randconfig-r042-20220131
hexagon              randconfig-r045-20220203
hexagon              randconfig-r041-20220203
s390                 randconfig-r044-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
