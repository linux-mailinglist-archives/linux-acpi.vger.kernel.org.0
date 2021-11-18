Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B3B455609
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Nov 2021 08:49:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243746AbhKRHvt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Nov 2021 02:51:49 -0500
Received: from mga02.intel.com ([134.134.136.20]:19666 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243336AbhKRHvp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Nov 2021 02:51:45 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10171"; a="221348952"
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="221348952"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2021 23:48:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,243,1631602800"; 
   d="scan'208";a="455218205"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 17 Nov 2021 23:48:42 -0800
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mnc9x-0002q0-NB; Thu, 18 Nov 2021 07:48:41 +0000
Date:   Thu, 18 Nov 2021 15:48:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 310eeb695db6630697feeb3476ed08bc9231d404
Message-ID: <61960553.W2LhaHc9vxjlKxJ8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 310eeb695db6630697feeb3476ed08bc9231d404  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 721m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211118
arm                        shmobile_defconfig
powerpc                       eiger_defconfig
sh                        sh7785lcr_defconfig
powerpc                     powernv_defconfig
mips                      fuloong2e_defconfig
sh                   secureedge5410_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    ge_imp3a_defconfig
mips                      loongson3_defconfig
arm                           sama5_defconfig
arm                            mmp2_defconfig
arm                          simpad_defconfig
mips                           ip22_defconfig
mips                     loongson1c_defconfig
powerpc                   currituck_defconfig
powerpc                     ksi8560_defconfig
xtensa                  nommu_kc705_defconfig
sh                             sh03_defconfig
arm                  randconfig-c002-20211117
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
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
s390                                defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                                defconfig
i386                              debian-10.3
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a003-20211117
x86_64               randconfig-a002-20211117
x86_64               randconfig-a001-20211117
x86_64               randconfig-a006-20211117
x86_64               randconfig-a004-20211117
x86_64               randconfig-a005-20211117
i386                 randconfig-a003-20211117
i386                 randconfig-a001-20211117
i386                 randconfig-a002-20211117
i386                 randconfig-a006-20211117
i386                 randconfig-a005-20211117
i386                 randconfig-a004-20211117
arc                  randconfig-r043-20211117
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a013-20211117
x86_64               randconfig-a011-20211117
x86_64               randconfig-a012-20211117
x86_64               randconfig-a016-20211117
x86_64               randconfig-a014-20211117
x86_64               randconfig-a015-20211117
i386                 randconfig-a014-20211117
i386                 randconfig-a012-20211117
i386                 randconfig-a013-20211117
i386                 randconfig-a011-20211117
i386                 randconfig-a015-20211117
i386                 randconfig-a016-20211117
hexagon              randconfig-r045-20211117
hexagon              randconfig-r041-20211117
s390                 randconfig-r044-20211117
riscv                randconfig-r042-20211117

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
