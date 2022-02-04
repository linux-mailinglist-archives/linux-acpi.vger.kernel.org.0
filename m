Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2C4A96D7
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Feb 2022 10:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357898AbiBDJcH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Feb 2022 04:32:07 -0500
Received: from mga02.intel.com ([134.134.136.20]:30680 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359152AbiBDJbl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Feb 2022 04:31:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643967101; x=1675503101;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=5EL1VBYApL9UypzAY486rLPxoexZxlq9oTOM2BiBcj0=;
  b=bajtKzCn+LJg2N3z+hvN+ni0QeXs+jVs1Bbyb2DEMGoC4E1EsnJC4sn2
   hwxyMDA6eSO6PFRsSxZJ5ihljXE41/RbHf/CfmgXdfl/pAdlDYWEB73jK
   3aFSFssaXlJFkoELupubcV/Md0NsrTYE9MP+KzjJp6Kihv91NvTJ2J/ZL
   Ot4orORQMaoCsr6i/M74lsAvTtq7TJCZ91QpnU4BJhDvJKH50+TwpFKPb
   spSPXXG/A/U7SR03bhk62oYspo2FPHAJmVMVqhOz29hxsouuBiQ13/BZA
   Gly1U1BXgLkv1TfB3liDJJl85kfMArEU0omhTL2yvMnN4TrcXpp07vvYf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="235738767"
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="235738767"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 01:26:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,342,1635231600"; 
   d="scan'208";a="524254454"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 04 Feb 2022 01:26:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFur7-000XQG-4e; Fri, 04 Feb 2022 09:26:13 +0000
Date:   Fri, 04 Feb 2022 17:25:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 119d56b735c4f42a805657c0b9b5982e58f41929
Message-ID: <61fcf124.z6Ri5a/JbVZn2kR4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 119d56b735c4f42a805657c0b9b5982e58f41929  Merge branch 'thermal-hfi' into bleeding-edge

possible Warning in current branch (please contact us if interested):

drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/qcom/../thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/samsung/../thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]
drivers/thermal/st/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: 'struct cpu_capability' declared inside parameter list will not be visible outside of this definition or declaration
drivers/thermal/tegra/../thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]
drivers/thermal/thermal_netlink.h:113:71: warning: declaration of 'struct cpu_capability' will not be visible outside of this function [-Wvisibility]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arc-randconfig-r043-20220130
|   `-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm-defconfig
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- drivers-thermal-st-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- arm64-defconfig
|   |-- drivers-thermal-qcom-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- mips-buildonly-randconfig-r005-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-randconfig-r012-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-randconfig-r013-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-randconfig-r026-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- openrisc-randconfig-r035-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
|-- powerpc-buildonly-randconfig-r006-20220130
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration
`-- xtensa-randconfig-m031-20220131
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:struct-cpu_capability-declared-inside-parameter-list-will-not-be-visible-outside-of-this-definition-or-declaration

clang_recent_errors
|-- hexagon-buildonly-randconfig-r001-20220131
|   `-- drivers-thermal-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- hexagon-randconfig-r045-20220131
|   `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
|-- riscv-buildonly-randconfig-r005-20220131
|   `-- drivers-thermal-qcom-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
`-- riscv-randconfig-r001-20220130
    |-- drivers-thermal-samsung-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function
    `-- drivers-thermal-tegra-..-thermal_netlink.h:warning:declaration-of-struct-cpu_capability-will-not-be-visible-outside-of-this-function

elapsed time: 728m

configs tested: 110
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
arm                         assabet_defconfig
mips                 decstation_r4k_defconfig
m68k                          multi_defconfig
powerpc                     mpc83xx_defconfig
powerpc                     stx_gp3_defconfig
openrisc                  or1klitex_defconfig
xtensa                    smp_lx200_defconfig
sh                            shmin_defconfig
sh                           se7343_defconfig
powerpc                     rainier_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
arm                  randconfig-c002-20220130
arm                  randconfig-c002-20220131
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                             allyesconfig
m68k                                defconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
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
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64               randconfig-a004-20220131
x86_64               randconfig-a003-20220131
x86_64               randconfig-a001-20220131
x86_64               randconfig-a006-20220131
x86_64               randconfig-a005-20220131
x86_64               randconfig-a002-20220131
riscv                randconfig-r042-20220130
arc                  randconfig-r043-20220130
arc                  randconfig-r043-20220131
s390                 randconfig-r044-20220130
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests
x86_64                          rhel-8.3-func

clang tested configs:
arm                    vt8500_v6_v7_defconfig
mips                          rm200_defconfig
powerpc                   lite5200b_defconfig
arm                             mxs_defconfig
mips                          ath79_defconfig
powerpc                     ppa8548_defconfig
mips                        bcm63xx_defconfig
riscv                             allnoconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220131
x86_64               randconfig-a015-20220131
x86_64               randconfig-a014-20220131
x86_64               randconfig-a016-20220131
x86_64               randconfig-a011-20220131
x86_64               randconfig-a012-20220131
i386                 randconfig-a013-20220131
i386                 randconfig-a014-20220131
i386                 randconfig-a012-20220131
i386                 randconfig-a015-20220131
i386                 randconfig-a016-20220131
i386                 randconfig-a011-20220131
s390                 randconfig-r044-20220131
hexagon              randconfig-r045-20220130
hexagon              randconfig-r045-20220131
hexagon              randconfig-r041-20220130
hexagon              randconfig-r041-20220131
riscv                randconfig-r042-20220131

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
