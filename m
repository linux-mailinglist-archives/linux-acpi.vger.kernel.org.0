Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6CA3F0401
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Aug 2021 14:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhHRMvT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Aug 2021 08:51:19 -0400
Received: from mga18.intel.com ([134.134.136.126]:30872 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233634AbhHRMvT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Aug 2021 08:51:19 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="203462882"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="203462882"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2021 05:50:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="449713602"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Aug 2021 05:50:40 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGL1j-000SuO-Oe; Wed, 18 Aug 2021 12:50:39 +0000
Date:   Wed, 18 Aug 2021 20:50:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 10bc7fbefe3a9ab4a8e7531752e200ceff5919c7
Message-ID: <611d0217.Fw+tnLnzUNuKSaug%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 10bc7fbefe3a9ab4a8e7531752e200ceff5919c7  Merge branch 'pm-cpufreq-fixes' into linux-next

elapsed time: 1048m

configs tested: 117
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210816
arc                              allyesconfig
nios2                            allyesconfig
alpha                            allyesconfig
riscv                    nommu_k210_defconfig
mips                      malta_kvm_defconfig
powerpc                     rainier_defconfig
ia64                        generic_defconfig
powerpc                     tqm8540_defconfig
mips                      maltasmvp_defconfig
powerpc                     sequoia_defconfig
sh                        sh7757lcr_defconfig
powerpc                        icon_defconfig
powerpc                     redwood_defconfig
powerpc                     asp8347_defconfig
parisc                generic-32bit_defconfig
powerpc                 mpc837x_mds_defconfig
arm                            mps2_defconfig
arc                        vdk_hs38_defconfig
mips                           jazz_defconfig
mips                     cu1000-neo_defconfig
ia64                            zx1_defconfig
sh                        edosk7705_defconfig
powerpc                   microwatt_defconfig
arm                  colibri_pxa270_defconfig
um                               alldefconfig
sh                           se7721_defconfig
sh                          rsk7201_defconfig
mips                        jmr3927_defconfig
arm                      footbridge_defconfig
arm                          ep93xx_defconfig
arm                        keystone_defconfig
mips                          ath79_defconfig
powerpc                      katmai_defconfig
x86_64                            allnoconfig
powerpc                   currituck_defconfig
powerpc                 canyonlands_defconfig
sh                         ecovec24_defconfig
powerpc                           allnoconfig
arm                         cm_x300_defconfig
mips                  maltasmvp_eva_defconfig
powerpc                      cm5200_defconfig
arm                       spear13xx_defconfig
arm                         socfpga_defconfig
xtensa                    xip_kc705_defconfig
mips                     loongson1c_defconfig
arm                          badge4_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a006-20210816
x86_64               randconfig-a004-20210816
x86_64               randconfig-a003-20210816
x86_64               randconfig-a001-20210816
x86_64               randconfig-a005-20210816
x86_64               randconfig-a002-20210816
i386                 randconfig-a004-20210816
i386                 randconfig-a003-20210816
i386                 randconfig-a002-20210816
i386                 randconfig-a001-20210816
i386                 randconfig-a006-20210816
i386                 randconfig-a005-20210816
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210816
x86_64               randconfig-a013-20210816
x86_64               randconfig-a016-20210816
x86_64               randconfig-a012-20210816
x86_64               randconfig-a015-20210816
x86_64               randconfig-a014-20210816
i386                 randconfig-a011-20210816
i386                 randconfig-a015-20210816
i386                 randconfig-a013-20210816
i386                 randconfig-a014-20210816
i386                 randconfig-a016-20210816
i386                 randconfig-a012-20210816

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
