Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF402B14E0
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Nov 2020 04:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKMDvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 12 Nov 2020 22:51:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:21556 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKMDvg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 12 Nov 2020 22:51:36 -0500
IronPort-SDR: MwouKXMVeAgg6MwQHT4f8f71tvivrWO+JfSA5T4ArSuJs2+h80QbdZl8F5gcLo2pMXN0HtnlKf
 BtXSBL2NruJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9803"; a="150272240"
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="150272240"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2020 19:51:34 -0800
IronPort-SDR: n1nfLwoTZbywH3Z2Oo5WXtFx2iIp7bF5BbID9HcYOcX+Vfdy39/Mq1QHkWtnc6r71FzSE+Mysn
 7WgMUMhyYuPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,474,1596524400"; 
   d="scan'208";a="530918005"
Received: from lkp-server02.sh.intel.com (HELO 697932c29306) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 12 Nov 2020 19:51:32 -0800
Received: from kbuild by 697932c29306 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kdQ7X-00003M-1F; Fri, 13 Nov 2020 03:51:31 +0000
Date:   Fri, 13 Nov 2020 11:51:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 52d108cd060dea3403c01d460c2ffbc7eaaf4a9c
Message-ID: <5fae02b7.TOue6GAJlIifEnop%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 52d108cd060dea3403c01d460c2ffbc7eaaf4a9c  Merge branch 'powercap' into linux-next

elapsed time: 727m

configs tested: 212
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         bcm2835_defconfig
arm                        shmobile_defconfig
arm                        spear6xx_defconfig
arm                       aspeed_g5_defconfig
ia64                        generic_defconfig
sh                   rts7751r2dplus_defconfig
sh                         microdev_defconfig
powerpc                      katmai_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
riscv                            allmodconfig
powerpc                    ge_imp3a_defconfig
sparc                               defconfig
sparc64                          alldefconfig
sh                        dreamcast_defconfig
powerpc                       maple_defconfig
openrisc                            defconfig
powerpc                      acadia_defconfig
sh                          rsk7201_defconfig
mips                        workpad_defconfig
m68k                         apollo_defconfig
sh                ecovec24-romimage_defconfig
riscv                            alldefconfig
arm                          pxa3xx_defconfig
powerpc                     pq2fads_defconfig
m68k                         amcore_defconfig
arm                           tegra_defconfig
powerpc                 mpc8315_rdb_defconfig
xtensa                         virt_defconfig
arm                         at91_dt_defconfig
sh                             espt_defconfig
sparc                       sparc64_defconfig
arm                          collie_defconfig
mips                             allyesconfig
sh                           se7722_defconfig
powerpc                        warp_defconfig
arm                  colibri_pxa270_defconfig
arm                              alldefconfig
arm                           h3600_defconfig
m68k                        m5407c3_defconfig
m68k                        mvme16x_defconfig
sh                          rsk7203_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
powerpc                    mvme5100_defconfig
sh                          sdk7786_defconfig
mips                       bmips_be_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
arm                          exynos_defconfig
m68k                           sun3_defconfig
nds32                            alldefconfig
powerpc64                           defconfig
arm                       imx_v6_v7_defconfig
arm                        cerfcube_defconfig
m68k                        mvme147_defconfig
powerpc                    adder875_defconfig
powerpc                       ebony_defconfig
xtensa                    smp_lx200_defconfig
microblaze                      mmu_defconfig
arm                        trizeps4_defconfig
arc                          axs101_defconfig
mips                           ip28_defconfig
powerpc                     powernv_defconfig
powerpc                     tqm8555_defconfig
ia64                         bigsur_defconfig
ia64                             alldefconfig
powerpc                  mpc885_ads_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
arm                         shannon_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
sh                           sh2007_defconfig
mips                malta_kvm_guest_defconfig
i386                             alldefconfig
mips                        maltaup_defconfig
arm                         mv78xx0_defconfig
mips                          malta_defconfig
arm                      footbridge_defconfig
xtensa                              defconfig
mips                 decstation_r4k_defconfig
arm                         nhk8815_defconfig
arm                             pxa_defconfig
nios2                            alldefconfig
xtensa                    xip_kc705_defconfig
arm                          ep93xx_defconfig
arm                       multi_v4t_defconfig
arm                            u300_defconfig
c6x                        evmc6457_defconfig
powerpc                    socrates_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                   lite5200b_defconfig
mips                       lemote2f_defconfig
powerpc                 mpc832x_mds_defconfig
arm                         assabet_defconfig
arm                          pxa168_defconfig
microblaze                          defconfig
powerpc                      ppc6xx_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
s390                          debug_defconfig
arm                         socfpga_defconfig
m68k                        m5307c3_defconfig
ia64                      gensparse_defconfig
m68k                        stmark2_defconfig
m68k                             alldefconfig
powerpc                      ep88xc_defconfig
arc                         haps_hs_defconfig
arm                      jornada720_defconfig
sh                               allmodconfig
arm                           spitz_defconfig
powerpc                      pmac32_defconfig
arm                           viper_defconfig
powerpc                      obs600_defconfig
arm64                            alldefconfig
sh                        sh7785lcr_defconfig
arm                         orion5x_defconfig
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
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201112
i386                 randconfig-a005-20201112
i386                 randconfig-a002-20201112
i386                 randconfig-a001-20201112
i386                 randconfig-a003-20201112
i386                 randconfig-a004-20201112
i386                 randconfig-a006-20201111
i386                 randconfig-a005-20201111
i386                 randconfig-a002-20201111
i386                 randconfig-a001-20201111
i386                 randconfig-a003-20201111
i386                 randconfig-a004-20201111
i386                 randconfig-a006-20201113
i386                 randconfig-a005-20201113
i386                 randconfig-a002-20201113
i386                 randconfig-a001-20201113
i386                 randconfig-a003-20201113
i386                 randconfig-a004-20201113
x86_64               randconfig-a015-20201111
x86_64               randconfig-a011-20201111
x86_64               randconfig-a014-20201111
x86_64               randconfig-a013-20201111
x86_64               randconfig-a016-20201111
x86_64               randconfig-a012-20201111
i386                 randconfig-a012-20201113
i386                 randconfig-a014-20201113
i386                 randconfig-a016-20201113
i386                 randconfig-a011-20201113
i386                 randconfig-a015-20201113
i386                 randconfig-a013-20201113
i386                 randconfig-a012-20201111
i386                 randconfig-a014-20201111
i386                 randconfig-a016-20201111
i386                 randconfig-a011-20201111
i386                 randconfig-a015-20201111
i386                 randconfig-a013-20201111
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a003-20201111
x86_64               randconfig-a005-20201111
x86_64               randconfig-a004-20201111
x86_64               randconfig-a002-20201111
x86_64               randconfig-a006-20201111
x86_64               randconfig-a001-20201111
x86_64               randconfig-a003-20201113
x86_64               randconfig-a005-20201113
x86_64               randconfig-a004-20201113
x86_64               randconfig-a002-20201113
x86_64               randconfig-a006-20201113
x86_64               randconfig-a001-20201113

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
