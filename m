Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7BC364F68
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Apr 2021 02:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhDTAUJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 19 Apr 2021 20:20:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:31177 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230042AbhDTAUI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 19 Apr 2021 20:20:08 -0400
IronPort-SDR: NI0ii8vuNFTKM49JB/aQejlPDTSzU3z1Pw9dyz/txoyoMLE6Cjzkv6rGtxcndQs2XFmglOWTY+
 WGmF8WTN9TZA==
X-IronPort-AV: E=McAfee;i="6200,9189,9959"; a="182912756"
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="182912756"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2021 17:19:37 -0700
IronPort-SDR: dW+vUhBQ0V/1k9WbuJZlP/ArZtgsRjL/gwVVvsQUBLx7LAk/3qjsbT1RCgyxQs3pLqmjHMVg29
 +mVsC/OTaiKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,235,1613462400"; 
   d="scan'208";a="445336525"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 19 Apr 2021 17:19:34 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lYe74-0001zW-8O; Tue, 20 Apr 2021 00:19:34 +0000
Date:   Tue, 20 Apr 2021 08:19:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 304bbea920d32fc73cdc144d3db268dba0b585df
Message-ID: <607e1dfc.wOZoGnAp8ZS2fx85%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 304bbea920d32fc73cdc144d3db268dba0b585df  Merge branch 'devprop' into linux-next

elapsed time: 724m

configs tested: 175
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
powerpc                      chrp32_defconfig
arm                        mvebu_v5_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     mpc5200_defconfig
m68k                          atari_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     kmeter1_defconfig
openrisc                 simple_smp_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc832x_mds_defconfig
mips                           xway_defconfig
sh                             espt_defconfig
sparc64                          alldefconfig
arm                        realview_defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
arm                       versatile_defconfig
arm                       multi_v4t_defconfig
powerpc                   motionpro_defconfig
sh                         ap325rxa_defconfig
nds32                             allnoconfig
mips                      pic32mzda_defconfig
xtensa                           allyesconfig
sh                          urquell_defconfig
arc                     haps_hs_smp_defconfig
sh                      rts7751r2d1_defconfig
xtensa                         virt_defconfig
arm                            mmp2_defconfig
arm                           omap1_defconfig
arm                        multi_v5_defconfig
powerpc                     tqm8540_defconfig
sh                                  defconfig
powerpc                    adder875_defconfig
powerpc                     sbc8548_defconfig
arm                          ixp4xx_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                     davinci_all_defconfig
h8300                     edosk2674_defconfig
mips                          ath79_defconfig
sh                         ecovec24_defconfig
i386                             alldefconfig
powerpc                     rainier_defconfig
arm                         vf610m4_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc834x_itx_defconfig
xtensa                    smp_lx200_defconfig
arm                        mini2440_defconfig
arm                        neponset_defconfig
mips                        bcm63xx_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                         ps3_defconfig
powerpc                 mpc832x_rdb_defconfig
sparc                       sparc64_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                            hp6xx_defconfig
powerpc                 linkstation_defconfig
sh                          sdk7786_defconfig
s390                             allmodconfig
arm                        vexpress_defconfig
mips                           gcw0_defconfig
arm                         assabet_defconfig
alpha                            alldefconfig
arm                            lart_defconfig
powerpc                          g5_defconfig
powerpc                      bamboo_defconfig
mips                        nlm_xlr_defconfig
nds32                               defconfig
arm                           h3600_defconfig
arm                         lubbock_defconfig
arm                          ep93xx_defconfig
powerpc                     kilauea_defconfig
mips                      fuloong2e_defconfig
parisc                generic-64bit_defconfig
mips                        maltaup_defconfig
arm                           h5000_defconfig
powerpc                     mpc83xx_defconfig
powerpc                      ppc64e_defconfig
powerpc                         wii_defconfig
mips                            e55_defconfig
sparc                               defconfig
mips                         tb0287_defconfig
powerpc                     powernv_defconfig
m68k                        m5407c3_defconfig
powerpc                       ppc64_defconfig
ia64                             allmodconfig
powerpc                 xes_mpc85xx_defconfig
ia64                                defconfig
powerpc                      katmai_defconfig
sh                          rsk7201_defconfig
riscv                    nommu_virt_defconfig
mips                      maltaaprp_defconfig
arm                        spear3xx_defconfig
powerpc                      pcm030_defconfig
powerpc                    klondike_defconfig
powerpc                      arches_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
nios2                         3c120_defconfig
sh                          landisk_defconfig
arm                          pcm027_defconfig
sparc                       sparc32_defconfig
arm                          imote2_defconfig
arm                          gemini_defconfig
arm                          exynos_defconfig
powerpc                 mpc834x_mds_defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210419
x86_64               randconfig-a001-20210419
x86_64               randconfig-a005-20210419
x86_64               randconfig-a002-20210419
x86_64               randconfig-a006-20210419
x86_64               randconfig-a004-20210419
i386                 randconfig-a003-20210419
i386                 randconfig-a001-20210419
i386                 randconfig-a006-20210419
i386                 randconfig-a005-20210419
i386                 randconfig-a004-20210419
i386                 randconfig-a002-20210419
i386                 randconfig-a015-20210419
i386                 randconfig-a013-20210419
i386                 randconfig-a014-20210419
i386                 randconfig-a016-20210419
i386                 randconfig-a012-20210419
i386                 randconfig-a011-20210419
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210419
x86_64               randconfig-a015-20210419
x86_64               randconfig-a013-20210419
x86_64               randconfig-a011-20210419
x86_64               randconfig-a012-20210419
x86_64               randconfig-a016-20210419

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
