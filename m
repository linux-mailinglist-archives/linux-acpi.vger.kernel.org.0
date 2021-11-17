Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F8454308
	for <lists+linux-acpi@lfdr.de>; Wed, 17 Nov 2021 09:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhKQI5s (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 Nov 2021 03:57:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:28503 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231591AbhKQI5s (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 17 Nov 2021 03:57:48 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10170"; a="231382814"
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="231382814"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 00:54:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,241,1631602800"; 
   d="scan'208";a="506826538"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Nov 2021 00:54:45 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnGiK-0001Rw-SH; Wed, 17 Nov 2021 08:54:44 +0000
Date:   Wed, 17 Nov 2021 16:53:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 16029e67d98a06dadf0204aec4309239aef6af0f
Message-ID: <6194c31d.0YLf30UBdcn8wNVE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 16029e67d98a06dadf0204aec4309239aef6af0f  Merge branch 'acpi-thermal' into bleeding-edge

elapsed time: 728m

configs tested: 109
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211117
powerpc                    socrates_defconfig
mips                  decstation_64_defconfig
mips                     loongson2k_defconfig
xtensa                       common_defconfig
arm                         axm55xx_defconfig
arm                           sama5_defconfig
arm                           stm32_defconfig
arm                       spear13xx_defconfig
ia64                             alldefconfig
mips                          rm200_defconfig
mips                         rt305x_defconfig
powerpc                 mpc832x_mds_defconfig
riscv                             allnoconfig
arm                            mps2_defconfig
xtensa                  cadence_csp_defconfig
arm                    vt8500_v6_v7_defconfig
arc                        nsim_700_defconfig
arm                   milbeaut_m10v_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                  randconfig-c002-20211116
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                              debian-10.3
arc                              allyesconfig
nds32                             allnoconfig
nios2                               defconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a004-20211117
x86_64               randconfig-a005-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a015-20211116
x86_64               randconfig-a013-20211116
x86_64               randconfig-a012-20211116
x86_64               randconfig-a011-20211116
x86_64               randconfig-a016-20211116
x86_64               randconfig-a014-20211116
i386                 randconfig-a012-20211116
i386                 randconfig-a013-20211116
i386                 randconfig-a011-20211116
i386                 randconfig-a015-20211116
i386                 randconfig-a014-20211116
i386                 randconfig-a016-20211116
arc                  randconfig-r043-20211116
riscv                randconfig-r042-20211116
s390                 randconfig-r044-20211116
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a003-20211116
x86_64               randconfig-a001-20211116
x86_64               randconfig-a002-20211116
x86_64               randconfig-a006-20211116
x86_64               randconfig-a004-20211116
x86_64               randconfig-a005-20211116
i386                 randconfig-a003-20211116
i386                 randconfig-a005-20211116
i386                 randconfig-a001-20211116
i386                 randconfig-a004-20211116
i386                 randconfig-a002-20211116
i386                 randconfig-a006-20211116
hexagon              randconfig-r045-20211116
hexagon              randconfig-r041-20211116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
