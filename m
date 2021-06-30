Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86183B7B56
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jun 2021 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhF3BkJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 21:40:09 -0400
Received: from mga04.intel.com ([192.55.52.120]:47623 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230033AbhF3BkI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 29 Jun 2021 21:40:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="206448856"
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="206448856"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 18:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,310,1616482800"; 
   d="scan'208";a="558134934"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2021 18:37:38 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lyPAY-0009Tf-6J; Wed, 30 Jun 2021 01:37:38 +0000
Date:   Wed, 30 Jun 2021 09:36:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 e132b9a1079c9a25ae896d443b0eca1b272b5f5b
Message-ID: <60dbcaae.BXdivaVhXNyA6ZcM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e132b9a1079c9a25ae896d443b0eca1b272b5f5b  Merge branch 'pm-opp' into linux-next

elapsed time: 730m

configs tested: 159
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
ia64                             allyesconfig
arm                         at91_dt_defconfig
arm                       imx_v6_v7_defconfig
ia64                         bigsur_defconfig
powerpc                     mpc512x_defconfig
mips                         tb0219_defconfig
mips                         db1xxx_defconfig
sh                               j2_defconfig
arm                          badge4_defconfig
powerpc                        icon_defconfig
sh                     magicpanelr2_defconfig
arm                  colibri_pxa300_defconfig
powerpc64                           defconfig
mips                            gpr_defconfig
powerpc                      ppc44x_defconfig
powerpc                      pcm030_defconfig
arm                            qcom_defconfig
arm                           sama5_defconfig
sh                            titan_defconfig
mips                     loongson1c_defconfig
ia64                        generic_defconfig
arm                         hackkit_defconfig
m68k                        m5307c3_defconfig
powerpc                      mgcoge_defconfig
powerpc                     skiroot_defconfig
arm                      integrator_defconfig
arc                          axs101_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    gamecube_defconfig
arm                           sunxi_defconfig
arm                         cm_x300_defconfig
powerpc                      obs600_defconfig
arm                        keystone_defconfig
arm                          exynos_defconfig
openrisc                 simple_smp_defconfig
mips                 decstation_r4k_defconfig
powerpc                      ep88xc_defconfig
ia64                          tiger_defconfig
arm                      pxa255-idp_defconfig
powerpc                     tqm8548_defconfig
arm                      jornada720_defconfig
powerpc                      bamboo_defconfig
x86_64                           alldefconfig
mips                           ci20_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
powerpc                  mpc885_ads_defconfig
arm                            zeus_defconfig
riscv                    nommu_k210_defconfig
arc                         haps_hs_defconfig
powerpc                     tqm8540_defconfig
mips                           gcw0_defconfig
powerpc                    amigaone_defconfig
arm                            lart_defconfig
mips                            ar7_defconfig
riscv                    nommu_virt_defconfig
arm                          moxart_defconfig
arm                         s5pv210_defconfig
arm                         s3c2410_defconfig
h8300                            allyesconfig
sh                         apsh4a3a_defconfig
csky                                defconfig
powerpc                   currituck_defconfig
arm                       mainstone_defconfig
openrisc                            defconfig
arm                           tegra_defconfig
mips                      loongson3_defconfig
powerpc                     powernv_defconfig
sh                           se7751_defconfig
mips                        qi_lb60_defconfig
powerpc                     pseries_defconfig
powerpc                       eiger_defconfig
powerpc                      chrp32_defconfig
mips                         tb0226_defconfig
h8300                            alldefconfig
powerpc                     asp8347_defconfig
powerpc                       holly_defconfig
x86_64                            allnoconfig
arm                        spear3xx_defconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
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
powerpc                           allnoconfig
i386                 randconfig-a001-20210628
i386                 randconfig-a002-20210628
i386                 randconfig-a003-20210628
i386                 randconfig-a006-20210628
i386                 randconfig-a005-20210628
i386                 randconfig-a004-20210628
i386                 randconfig-a002-20210629
i386                 randconfig-a001-20210629
i386                 randconfig-a003-20210629
i386                 randconfig-a006-20210629
i386                 randconfig-a005-20210629
i386                 randconfig-a004-20210629
x86_64               randconfig-a012-20210628
x86_64               randconfig-a016-20210628
x86_64               randconfig-a015-20210628
x86_64               randconfig-a013-20210628
x86_64               randconfig-a014-20210628
x86_64               randconfig-a011-20210628
i386                 randconfig-a011-20210628
i386                 randconfig-a014-20210628
i386                 randconfig-a013-20210628
i386                 randconfig-a015-20210628
i386                 randconfig-a016-20210628
i386                 randconfig-a012-20210628
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210628
x86_64               randconfig-a002-20210628
x86_64               randconfig-a005-20210628
x86_64               randconfig-a001-20210628
x86_64               randconfig-a003-20210628
x86_64               randconfig-a004-20210628
x86_64               randconfig-a006-20210628

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
