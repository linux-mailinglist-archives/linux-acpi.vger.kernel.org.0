Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C562B8AA2
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Nov 2020 05:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgKSEcp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Nov 2020 23:32:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:24903 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgKSEco (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Nov 2020 23:32:44 -0500
IronPort-SDR: E5NtHAibTacElwz3mvJDadGsYUbMfGhgGwzlIWNkPRezlewUMffkri26IYUjKOGf0RzT2vkVS3
 lNhjVyWu8+7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="255940294"
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="255940294"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2020 20:32:43 -0800
IronPort-SDR: gNAF51XrXcqAAQ9vM91+QizrRHKvgKczkkCndMsq3vw++sUAT3jhrrI2BXhKp/T3uvRdzkU8R+
 9EoCdFccLVZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,489,1596524400"; 
   d="scan'208";a="431108008"
Received: from lkp-server01.sh.intel.com (HELO cbf10a1dd0e4) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 18 Nov 2020 20:32:42 -0800
Received: from kbuild by cbf10a1dd0e4 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kfbcf-00004K-Gl; Thu, 19 Nov 2020 04:32:41 +0000
Date:   Thu, 19 Nov 2020 12:32:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 e98c22d0368879136786ad5a500791d1846ab754
Message-ID: <5fb5f55f.shZdKr2N8+FrAMy9%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: e98c22d0368879136786ad5a500791d1846ab754  Merge branches 'acpi-misc' and 'acpi-resources' into linux-next

elapsed time: 726m

configs tested: 202
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
sh                         ap325rxa_defconfig
mips                  maltasmvp_eva_defconfig
mips                      pic32mzda_defconfig
powerpc                      bamboo_defconfig
powerpc                     tqm8560_defconfig
m68k                          sun3x_defconfig
arc                        nsim_700_defconfig
mips                      loongson3_defconfig
arm                           sunxi_defconfig
nios2                               defconfig
powerpc                    socrates_defconfig
um                           x86_64_defconfig
powerpc                        fsp2_defconfig
powerpc                      ppc6xx_defconfig
arm                            mps2_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8555_defconfig
sh                        apsh4ad0a_defconfig
arm                         hackkit_defconfig
powerpc                     redwood_defconfig
m68k                         apollo_defconfig
mips                         bigsur_defconfig
xtensa                           alldefconfig
mips                        workpad_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                    adder875_defconfig
sh                ecovec24-romimage_defconfig
m68k                            mac_defconfig
sh                           sh2007_defconfig
sh                          polaris_defconfig
arm                       aspeed_g5_defconfig
arm                           stm32_defconfig
powerpc                     sbc8548_defconfig
arm                   milbeaut_m10v_defconfig
arm                         shannon_defconfig
arc                          axs101_defconfig
mips                         db1xxx_defconfig
m68k                          amiga_defconfig
arm                            zeus_defconfig
powerpc                      ep88xc_defconfig
arm                           sama5_defconfig
powerpc                      cm5200_defconfig
arm                        realview_defconfig
s390                          debug_defconfig
mips                            e55_defconfig
sh                     sh7710voipgw_defconfig
mips                 decstation_r4k_defconfig
sh                           se7206_defconfig
powerpc                   lite5200b_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
arm                       versatile_defconfig
sh                            hp6xx_defconfig
sh                          urquell_defconfig
powerpc                      obs600_defconfig
arm                             mxs_defconfig
sh                   sh7770_generic_defconfig
powerpc                     pq2fads_defconfig
parisc                generic-64bit_defconfig
arm                             rpc_defconfig
powerpc                      katmai_defconfig
powerpc                     mpc5200_defconfig
powerpc                 mpc8272_ads_defconfig
m68k                           sun3_defconfig
powerpc                    sam440ep_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm5200_defconfig
m68k                        m5407c3_defconfig
powerpc                     kilauea_defconfig
arm                        clps711x_defconfig
mips                malta_qemu_32r6_defconfig
mips                        nlm_xlr_defconfig
powerpc                      chrp32_defconfig
powerpc               mpc834x_itxgp_defconfig
c6x                         dsk6455_defconfig
arm                         lpc32xx_defconfig
powerpc                  iss476-smp_defconfig
riscv                    nommu_k210_defconfig
powerpc                    ge_imp3a_defconfig
m68k                        mvme16x_defconfig
sh                        sh7757lcr_defconfig
powerpc                      pcm030_defconfig
sparc                            allyesconfig
powerpc                      ppc64e_defconfig
powerpc                     skiroot_defconfig
sh                         ecovec24_defconfig
sh                           se7722_defconfig
arc                        vdk_hs38_defconfig
sh                          kfr2r09_defconfig
arm                     am200epdkit_defconfig
arm                           efm32_defconfig
arm                           corgi_defconfig
powerpc                 mpc837x_rdb_defconfig
mips                         rt305x_defconfig
sh                               alldefconfig
arm                      tct_hammer_defconfig
sh                             sh03_defconfig
arm                         axm55xx_defconfig
powerpc                       ebony_defconfig
sparc                       sparc32_defconfig
arc                                 defconfig
riscv                    nommu_virt_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                           ip32_defconfig
arm                       spear13xx_defconfig
sh                           se7705_defconfig
arm                         cm_x300_defconfig
sh                          r7780mp_defconfig
arc                              alldefconfig
powerpc                     mpc83xx_defconfig
powerpc                     tqm8540_defconfig
powerpc                   motionpro_defconfig
powerpc                         wii_defconfig
powerpc                     kmeter1_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20201118
x86_64               randconfig-a003-20201118
x86_64               randconfig-a004-20201118
x86_64               randconfig-a002-20201118
x86_64               randconfig-a006-20201118
x86_64               randconfig-a001-20201118
i386                 randconfig-a006-20201119
i386                 randconfig-a005-20201119
i386                 randconfig-a002-20201119
i386                 randconfig-a001-20201119
i386                 randconfig-a003-20201119
i386                 randconfig-a004-20201119
i386                 randconfig-a006-20201118
i386                 randconfig-a005-20201118
i386                 randconfig-a002-20201118
i386                 randconfig-a001-20201118
i386                 randconfig-a003-20201118
i386                 randconfig-a004-20201118
i386                 randconfig-a012-20201118
i386                 randconfig-a014-20201118
i386                 randconfig-a016-20201118
i386                 randconfig-a011-20201118
i386                 randconfig-a013-20201118
i386                 randconfig-a015-20201118
i386                 randconfig-a012-20201119
i386                 randconfig-a014-20201119
i386                 randconfig-a016-20201119
i386                 randconfig-a011-20201119
i386                 randconfig-a013-20201119
i386                 randconfig-a015-20201119
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20201118
x86_64               randconfig-a014-20201118
x86_64               randconfig-a011-20201118
x86_64               randconfig-a013-20201118
x86_64               randconfig-a016-20201118
x86_64               randconfig-a012-20201118
x86_64               randconfig-a005-20201119
x86_64               randconfig-a003-20201119
x86_64               randconfig-a004-20201119
x86_64               randconfig-a002-20201119
x86_64               randconfig-a006-20201119
x86_64               randconfig-a001-20201119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
