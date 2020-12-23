Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6942E1955
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Dec 2020 08:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgLWHQI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 23 Dec 2020 02:16:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:61606 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727432AbgLWHQI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Dec 2020 02:16:08 -0500
IronPort-SDR: i/w7EmYf3xFJL9xhJRDPJ+9QweNZcx8GDT8uM44bRRCFI8xbk5XScqzUxS51Y9djme6bMuf+Ny
 shy8t5shAvjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="194422105"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="194422105"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2020 23:15:28 -0800
IronPort-SDR: ZuUpEDSO/cZ55VzlC53twSGBC7MbkvkgBfrJABlZOdys0NCzJi+20zAClfNyS4/bAqF1Ep5Ynr
 7r3qvhYfpWFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; 
   d="scan'208";a="356842150"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Dec 2020 23:15:26 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kryMn-00009w-0j; Wed, 23 Dec 2020 07:15:25 +0000
Date:   Wed, 23 Dec 2020 15:14:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 a33520709645543f108361fe21fa9434a351c4e9
Message-ID: <5fe2ee54.aq6frW9Bt080+FzM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: a33520709645543f108361fe21fa9434a351c4e9  Merge branch 'pm-cpuidle' into bleeding-edge

Warning reports:

https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp@intel.com

Warning in current branch:

drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used [-Wunused-but-set-variable]
drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-defconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a002-20201222
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a005-20201222
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a012-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a013-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a014-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a016-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-c001-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-m021-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-r031-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-s001-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-allmodconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-defconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-kexec
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a001-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a002-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a004-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a006-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-s021-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel-8.3
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
`-- x86_64-rhel-8.3-kbuiltin
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

elapsed time: 724m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         bcm2835_defconfig
m68k                          amiga_defconfig
powerpc                     kilauea_defconfig
x86_64                           allyesconfig
mips                           xway_defconfig
powerpc                      ppc64e_defconfig
arm                      pxa255-idp_defconfig
arm                           tegra_defconfig
arm                      integrator_defconfig
m68k                       m5475evb_defconfig
c6x                        evmc6678_defconfig
arm64                            alldefconfig
arm                       multi_v4t_defconfig
ia64                            zx1_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     eseries_pxa_defconfig
mips                           mtx1_defconfig
um                             i386_defconfig
m68k                       bvme6000_defconfig
sh                           sh2007_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a005-20201222
i386                 randconfig-a002-20201222
i386                 randconfig-a006-20201222
i386                 randconfig-a004-20201222
i386                 randconfig-a003-20201222
i386                 randconfig-a001-20201222
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201221
x86_64               randconfig-a014-20201221
x86_64               randconfig-a016-20201221
x86_64               randconfig-a012-20201221
x86_64               randconfig-a013-20201221
x86_64               randconfig-a011-20201221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
