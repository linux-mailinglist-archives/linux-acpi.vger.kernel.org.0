Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C71D30D416
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 08:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbhBCHdu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 02:33:50 -0500
Received: from mga17.intel.com ([192.55.52.151]:51375 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231560AbhBCHdt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Feb 2021 02:33:49 -0500
IronPort-SDR: eSnG9c4sE5fJjUvuJlB0t99hEfhgV1loxXFDQalgztxWJa11+hXeGId2oHYtxSV0cxlZlQQSFX
 e0wnec8s8f4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9883"; a="160760594"
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="160760594"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 23:33:06 -0800
IronPort-SDR: myPpU4KpGAAi2oJxA6jCNviYva/KF4ik+5VbI/NWOTj1BzC0PsZDI+2XwJX4rqqcAhOjJCab6U
 xMV1UoCYrCpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="372281236"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Feb 2021 23:33:03 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7Cer-00009K-30; Wed, 03 Feb 2021 07:33:01 +0000
Date:   Wed, 03 Feb 2021 15:31:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 c42187278fc107ad17fdaa2def70c451bcfdb6be
Message-ID: <601a516e.9kydFKsx8s1Ahqhn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c42187278fc107ad17fdaa2def70c451bcfdb6be  Merge branch 'pm-domains' into linux-next

elapsed time: 726m

configs tested: 155
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
h8300                     edosk2674_defconfig
arm                          ep93xx_defconfig
h8300                               defconfig
arm                           viper_defconfig
c6x                        evmc6457_defconfig
powerpc                      mgcoge_defconfig
mips                        qi_lb60_defconfig
mips                        nlm_xlr_defconfig
powerpc                     kilauea_defconfig
arm                         socfpga_defconfig
mips                      malta_kvm_defconfig
powerpc                    klondike_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-32bit_defconfig
riscv                               defconfig
powerpc                     mpc5200_defconfig
arm                             pxa_defconfig
powerpc                      acadia_defconfig
m68k                        m5272c3_defconfig
arm                        neponset_defconfig
mips                     loongson1c_defconfig
mips                          malta_defconfig
sh                        apsh4ad0a_defconfig
alpha                            allyesconfig
powerpc                    ge_imp3a_defconfig
xtensa                    xip_kc705_defconfig
m68k                        mvme16x_defconfig
arm                          collie_defconfig
arm                         cm_x300_defconfig
sh                           se7206_defconfig
powerpc                     pq2fads_defconfig
mips                             allyesconfig
arm                      integrator_defconfig
mips                        bcm63xx_defconfig
sh                          landisk_defconfig
m68k                            q40_defconfig
arc                    vdk_hs38_smp_defconfig
arc                           tb10x_defconfig
c6x                        evmc6474_defconfig
powerpc                    adder875_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                           mtx1_defconfig
riscv                            allyesconfig
arm                        keystone_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5208evb_defconfig
powerpc                        warp_defconfig
xtensa                  audio_kc705_defconfig
sh                     magicpanelr2_defconfig
sh                         ap325rxa_defconfig
arc                         haps_hs_defconfig
powerpc                      katmai_defconfig
arm                           h5000_defconfig
arm                        multi_v7_defconfig
powerpc                     tqm8560_defconfig
nios2                         3c120_defconfig
arm                            pleb_defconfig
sh                           se7343_defconfig
arm                          badge4_defconfig
sh                             espt_defconfig
arm                           stm32_defconfig
powerpc                     tqm8555_defconfig
c6x                        evmc6472_defconfig
c6x                              alldefconfig
microblaze                      mmu_defconfig
m68k                          hp300_defconfig
powerpc                      pasemi_defconfig
m68k                          amiga_defconfig
arm                          pcm027_defconfig
sh                   secureedge5410_defconfig
um                             i386_defconfig
powerpc                  storcenter_defconfig
mips                    maltaup_xpa_defconfig
mips                       lemote2f_defconfig
mips                      bmips_stb_defconfig
powerpc                      cm5200_defconfig
powerpc                     skiroot_defconfig
microblaze                          defconfig
powerpc                          allyesconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc40x_defconfig
sh                            migor_defconfig
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
mips                             allmodconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210202
i386                 randconfig-a005-20210202
i386                 randconfig-a003-20210202
i386                 randconfig-a006-20210202
i386                 randconfig-a002-20210202
i386                 randconfig-a004-20210202
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
