Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AC932014B
	for <lists+linux-acpi@lfdr.de>; Fri, 19 Feb 2021 23:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhBSWUx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 19 Feb 2021 17:20:53 -0500
Received: from mga12.intel.com ([192.55.52.136]:3822 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229515AbhBSWUx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 19 Feb 2021 17:20:53 -0500
IronPort-SDR: 31t5MkZPcATDe+5/2Ul2mgVW957nAtuLcx9ZrZz+7aScbsGtFrmCOx5tslOmiLK2ltCyZtPf/o
 GLKz+QHa9YPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163130565"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="163130565"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2021 14:20:12 -0800
IronPort-SDR: pC71vhmFU2tDf6B0FQIZQWZDEOAgWg6yfu5JluhbEiLNoSljw3CVzq0128QAxaKgBDvTaNghzf
 kIUWcTc0N00Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; 
   d="scan'208";a="440443242"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2021 14:20:10 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lDE89-000AfC-Fx; Fri, 19 Feb 2021 22:20:09 +0000
Date:   Sat, 20 Feb 2021 06:19:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 8b72d3aa065ce33df4f042840078542b1e5d2c45
Message-ID: <6030398b.B2E7yyx8RuCeVTwN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8b72d3aa065ce33df4f042840078542b1e5d2c45  Merge branches 'pm-cpufreq-fixes' and 'pm-opp-fixes' into linux-next

elapsed time: 723m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      cm5200_defconfig
mips                       rbtx49xx_defconfig
powerpc                     stx_gp3_defconfig
sh                           se7780_defconfig
arm                        mvebu_v5_defconfig
powerpc                     sequoia_defconfig
ia64                             alldefconfig
sh                             espt_defconfig
arm                          pcm027_defconfig
mips                      pistachio_defconfig
arm                  colibri_pxa270_defconfig
sh                            migor_defconfig
arm                          pxa910_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                  storcenter_defconfig
mips                       bmips_be_defconfig
arm                            u300_defconfig
powerpc                  iss476-smp_defconfig
arm                        spear3xx_defconfig
powerpc                   motionpro_defconfig
arm                             pxa_defconfig
sh                          polaris_defconfig
arm                         at91_dt_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         bcm2835_defconfig
arm                         s5pv210_defconfig
powerpc                 canyonlands_defconfig
sh                     sh7710voipgw_defconfig
powerpc                      ppc44x_defconfig
mips                         rt305x_defconfig
arm                       omap2plus_defconfig
powerpc                    amigaone_defconfig
sparc64                          alldefconfig
mips                          rb532_defconfig
mips                           jazz_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                     sbc8548_defconfig
arm                         hackkit_defconfig
powerpc                    adder875_defconfig
sh                           se7724_defconfig
arm                           stm32_defconfig
arm                          imote2_defconfig
xtensa                         virt_defconfig
arm                           corgi_defconfig
m68k                        mvme16x_defconfig
sh                   sh7770_generic_defconfig
arm                            hisi_defconfig
ia64                            zx1_defconfig
sh                                  defconfig
mips                     cu1830-neo_defconfig
sparc                               defconfig
arc                         haps_hs_defconfig
powerpc                       ppc64_defconfig
sh                          rsk7201_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210219
i386                 randconfig-a003-20210219
i386                 randconfig-a002-20210219
i386                 randconfig-a004-20210219
i386                 randconfig-a001-20210219
i386                 randconfig-a006-20210219
x86_64               randconfig-a012-20210219
x86_64               randconfig-a016-20210219
x86_64               randconfig-a013-20210219
x86_64               randconfig-a015-20210219
x86_64               randconfig-a011-20210219
x86_64               randconfig-a014-20210219
i386                 randconfig-a016-20210219
i386                 randconfig-a012-20210219
i386                 randconfig-a014-20210219
i386                 randconfig-a013-20210219
i386                 randconfig-a011-20210219
i386                 randconfig-a015-20210219
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20210219
x86_64               randconfig-a001-20210219
x86_64               randconfig-a004-20210219
x86_64               randconfig-a002-20210219
x86_64               randconfig-a005-20210219
x86_64               randconfig-a006-20210219

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
