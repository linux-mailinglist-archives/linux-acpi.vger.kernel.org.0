Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F732E7E66
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Dec 2020 07:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgLaGNN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Dec 2020 01:13:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:24485 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgLaGNN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 31 Dec 2020 01:13:13 -0500
IronPort-SDR: ZqKxxa5U/moPHyi88jFJvNpx8XesGzDehLH+CLBN6leFIIAbZg85lU/Ixr6eXDFeYHGkgRNNmK
 s3xq9dT4c2Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9850"; a="163737738"
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; 
   d="scan'208";a="163737738"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Dec 2020 22:12:32 -0800
IronPort-SDR: RKAqR6faMHtreLbdY0LPclLnNoc+94VuYVAhO3U19XlY99AdIMTCwe1v7gR6n+PYMU6SGuUr8d
 HMLMNmXu/qzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,463,1599548400"; 
   d="scan'208";a="563689565"
Received: from lkp-server02.sh.intel.com (HELO 4242b19f17ef) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 30 Dec 2020 22:12:31 -0800
Received: from kbuild by 4242b19f17ef with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kurCI-0004kU-IS; Thu, 31 Dec 2020 06:12:30 +0000
Date:   Thu, 31 Dec 2020 14:11:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 2e19c856a4614c113119f3f4d4795b190c5c828f
Message-ID: <5fed6b9f.xlILK10i2fBDuwxj%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 2e19c856a4614c113119f3f4d4795b190c5c828f  Merge branch 'acpi-platform' into bleeding-edge

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
|-- i386-randconfig-a011-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a012-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a013-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a015-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a016-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-m021-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-p002-20201230
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
|-- x86_64-randconfig-a001-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a003-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a005-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-a006-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-s022-20201230
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel-7.6-kselftests
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel-8.3
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
`-- x86_64-rhel-8.3-kbuiltin
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

elapsed time: 725m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
m68k                        m5407c3_defconfig
sh                            shmin_defconfig
arm                         s3c6400_defconfig
mips                           rs90_defconfig
h8300                    h8300h-sim_defconfig
sh                             shx3_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     akebono_defconfig
powerpc                      obs600_defconfig
powerpc                    klondike_defconfig
arm                        mvebu_v5_defconfig
s390                             alldefconfig
sh                   rts7751r2dplus_defconfig
powerpc                    sam440ep_defconfig
arc                     haps_hs_smp_defconfig
ia64                             alldefconfig
sh                     sh7710voipgw_defconfig
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
i386                 randconfig-a005-20201230
i386                 randconfig-a006-20201230
i386                 randconfig-a004-20201230
i386                 randconfig-a003-20201230
i386                 randconfig-a002-20201230
i386                 randconfig-a001-20201230
i386                 randconfig-a016-20201230
i386                 randconfig-a014-20201230
i386                 randconfig-a012-20201230
i386                 randconfig-a015-20201230
i386                 randconfig-a011-20201230
i386                 randconfig-a013-20201230
x86_64               randconfig-a005-20201230
x86_64               randconfig-a001-20201230
x86_64               randconfig-a006-20201230
x86_64               randconfig-a002-20201230
x86_64               randconfig-a004-20201230
x86_64               randconfig-a003-20201230
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
x86_64               randconfig-a015-20201230
x86_64               randconfig-a014-20201230
x86_64               randconfig-a016-20201230
x86_64               randconfig-a011-20201230
x86_64               randconfig-a013-20201230
x86_64               randconfig-a012-20201230

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
