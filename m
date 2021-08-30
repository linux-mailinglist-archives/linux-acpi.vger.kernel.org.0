Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2623B3FB89D
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Aug 2021 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbhH3O6k (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Aug 2021 10:58:40 -0400
Received: from mga01.intel.com ([192.55.52.88]:25043 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233162AbhH3O6k (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Aug 2021 10:58:40 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="240525776"
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="240525776"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 07:57:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,363,1620716400"; 
   d="scan'208";a="689279409"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Aug 2021 07:57:34 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mKij7-0005DQ-ET; Mon, 30 Aug 2021 14:57:33 +0000
Date:   Mon, 30 Aug 2021 22:57:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 a93c0039d89d6f11b98f49db841515e65a5dd0ba
Message-ID: <612cf1be.T4XIgVHNfE5ffyii%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a93c0039d89d6f11b98f49db841515e65a5dd0ba  Merge branch 'acpi-bus' into linux-next

elapsed time: 4062m

configs tested: 387
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210827
i386                 randconfig-c001-20210829
i386                 randconfig-c001-20210830
ia64                             allmodconfig
i386                             allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
ia64                             allyesconfig
powerpc              randconfig-c003-20210827
um                           x86_64_defconfig
riscv                            allyesconfig
mips                             allyesconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allmodconfig
powerpc                          allyesconfig
s390                             allyesconfig
m68k                             allmodconfig
s390                             allmodconfig
powerpc                          allmodconfig
m68k                             allyesconfig
sparc                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                           allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
alpha                            allyesconfig
mips                 randconfig-c004-20210829
arm                        mini2440_defconfig
x86_64                            allnoconfig
powerpc                      ppc44x_defconfig
powerpc                     tqm5200_defconfig
xtensa                    smp_lx200_defconfig
arm                        realview_defconfig
arm                          ep93xx_defconfig
arm                          pxa3xx_defconfig
mips                malta_qemu_32r6_defconfig
mips                         cobalt_defconfig
mips                        qi_lb60_defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
sh                           se7705_defconfig
powerpc                        fsp2_defconfig
sh                              ul2_defconfig
sh                        sh7785lcr_defconfig
sh                           se7780_defconfig
nios2                         10m50_defconfig
sparc                       sparc64_defconfig
arm                     am200epdkit_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc836x_mds_defconfig
nios2                         3c120_defconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
arm                           h3600_defconfig
powerpc                 mpc832x_mds_defconfig
sh                          polaris_defconfig
powerpc                     rainier_defconfig
arm                             rpc_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                           gcw0_defconfig
sh                          rsk7269_defconfig
mips                      fuloong2e_defconfig
sh                        sh7763rdp_defconfig
m68k                       m5275evb_defconfig
arm                       spear13xx_defconfig
arm                      footbridge_defconfig
um                               alldefconfig
microblaze                      mmu_defconfig
m68k                          multi_defconfig
powerpc                     tqm8541_defconfig
mips                          ath25_defconfig
arc                     nsimosci_hs_defconfig
arm                         nhk8815_defconfig
arm                         lpc18xx_defconfig
mips                         mpc30x_defconfig
mips                           ip32_defconfig
m68k                        m5272c3_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc32_defconfig
arm                           sunxi_defconfig
mips                        workpad_defconfig
powerpc                    amigaone_defconfig
powerpc                     sbc8548_defconfig
arm                         at91_dt_defconfig
sh                ecovec24-romimage_defconfig
powerpc                          g5_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
arm                         socfpga_defconfig
powerpc                    mvme5100_defconfig
arm64                            alldefconfig
powerpc                       holly_defconfig
arm                        multi_v5_defconfig
powerpc                     mpc512x_defconfig
sh                           se7206_defconfig
mips                     loongson2k_defconfig
arm                           h5000_defconfig
mips                     cu1830-neo_defconfig
sh                          sdk7780_defconfig
x86_64                           alldefconfig
powerpc                   microwatt_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
arm                         palmz72_defconfig
xtensa                  audio_kc705_defconfig
powerpc                     ksi8560_defconfig
m68k                       m5475evb_defconfig
sh                          kfr2r09_defconfig
mips                      pic32mzda_defconfig
arm                            lart_defconfig
sh                         apsh4a3a_defconfig
arm                       imx_v4_v5_defconfig
mips                           xway_defconfig
mips                        maltaup_defconfig
openrisc                 simple_smp_defconfig
sh                   sh7770_generic_defconfig
sh                            migor_defconfig
arm                          pxa168_defconfig
s390                                defconfig
sh                          r7780mp_defconfig
arm                          badge4_defconfig
mips                  decstation_64_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     redwood_defconfig
arm                           stm32_defconfig
s390                             alldefconfig
powerpc                      tqm8xx_defconfig
mips                     loongson1b_defconfig
arm                         s5pv210_defconfig
xtensa                           alldefconfig
sh                        edosk7705_defconfig
mips                         tb0219_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                       ebony_defconfig
sh                             espt_defconfig
arm                        mvebu_v7_defconfig
powerpc                      obs600_defconfig
sh                            shmin_defconfig
mips                           ip28_defconfig
openrisc                  or1klitex_defconfig
mips                      malta_kvm_defconfig
powerpc                      cm5200_defconfig
sh                           se7722_defconfig
sh                           se7751_defconfig
ia64                        generic_defconfig
sh                          rsk7201_defconfig
sh                         microdev_defconfig
arm                            mmp2_defconfig
m68k                        m5307c3_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                        nlm_xlp_defconfig
powerpc                        warp_defconfig
m68k                        mvme147_defconfig
xtensa                       common_defconfig
mips                  cavium_octeon_defconfig
arm                         hackkit_defconfig
arm                      pxa255-idp_defconfig
m68k                       bvme6000_defconfig
mips                    maltaup_xpa_defconfig
sh                        edosk7760_defconfig
powerpc                  storcenter_defconfig
powerpc                      makalu_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      ppc6xx_defconfig
sh                           se7721_defconfig
m68k                                defconfig
mips                         db1xxx_defconfig
arm                         vf610m4_defconfig
xtensa                              defconfig
um                                  defconfig
sh                           se7750_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
h8300                               defconfig
sh                          lboxre2_defconfig
arm                         shannon_defconfig
powerpc                     powernv_defconfig
powerpc                    socrates_defconfig
arm                       netwinder_defconfig
arc                           tb10x_defconfig
arm                        keystone_defconfig
powerpc                      chrp32_defconfig
arm                       multi_v4t_defconfig
mips                         tb0226_defconfig
m68k                             alldefconfig
mips                       capcella_defconfig
arm                         assabet_defconfig
arm                      integrator_defconfig
openrisc                         alldefconfig
arm                           sama5_defconfig
mips                        bcm47xx_defconfig
arm                            dove_defconfig
riscv                          rv32_defconfig
powerpc                     akebono_defconfig
arc                        vdk_hs38_defconfig
sh                         ap325rxa_defconfig
sh                   rts7751r2dplus_defconfig
nds32                             allnoconfig
alpha                               defconfig
powerpc                      bamboo_defconfig
powerpc                      ppc64e_defconfig
arm                  colibri_pxa270_defconfig
m68k                       m5249evb_defconfig
powerpc                       ppc64_defconfig
arm                        cerfcube_defconfig
sparc                            alldefconfig
parisc                generic-32bit_defconfig
m68k                            q40_defconfig
powerpc               mpc834x_itxgp_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc837x_mds_defconfig
xtensa                  nommu_kc705_defconfig
arc                    vdk_hs38_smp_defconfig
arm                        vexpress_defconfig
mips                         rt305x_defconfig
arc                     haps_hs_smp_defconfig
arm                        shmobile_defconfig
mips                           rs90_defconfig
arm                            hisi_defconfig
powerpc                      pasemi_defconfig
powerpc                 mpc832x_rdb_defconfig
m68k                       m5208evb_defconfig
arm                            pleb_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                         s3c6400_defconfig
arm                         lubbock_defconfig
sh                      rts7751r2d1_defconfig
i386                             alldefconfig
mips                       rbtx49xx_defconfig
arm                         bcm2835_defconfig
sh                           se7343_defconfig
powerpc                     kilauea_defconfig
arm                       imx_v6_v7_defconfig
sh                   secureedge5410_defconfig
mips                        bcm63xx_defconfig
microblaze                          defconfig
openrisc                            defconfig
powerpc                       eiger_defconfig
mips                  maltasmvp_eva_defconfig
sh                        apsh4ad0a_defconfig
ia64                                defconfig
nios2                               defconfig
nds32                               defconfig
csky                                defconfig
arc                                 defconfig
parisc                              defconfig
sparc                               defconfig
i386                                defconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210828
i386                 randconfig-a006-20210828
i386                 randconfig-a002-20210828
i386                 randconfig-a005-20210828
i386                 randconfig-a003-20210828
i386                 randconfig-a004-20210828
x86_64               randconfig-a014-20210827
x86_64               randconfig-a015-20210827
x86_64               randconfig-a016-20210827
x86_64               randconfig-a013-20210827
x86_64               randconfig-a012-20210827
x86_64               randconfig-a011-20210827
x86_64               randconfig-a014-20210830
x86_64               randconfig-a015-20210830
x86_64               randconfig-a013-20210830
x86_64               randconfig-a016-20210830
x86_64               randconfig-a012-20210830
x86_64               randconfig-a011-20210830
x86_64               randconfig-a014-20210829
x86_64               randconfig-a016-20210829
x86_64               randconfig-a015-20210829
x86_64               randconfig-a012-20210829
x86_64               randconfig-a013-20210829
x86_64               randconfig-a011-20210829
i386                 randconfig-a011-20210827
i386                 randconfig-a016-20210827
i386                 randconfig-a012-20210827
i386                 randconfig-a014-20210827
i386                 randconfig-a013-20210827
i386                 randconfig-a015-20210827
i386                 randconfig-a011-20210829
i386                 randconfig-a016-20210829
i386                 randconfig-a012-20210829
i386                 randconfig-a014-20210829
i386                 randconfig-a013-20210829
i386                 randconfig-a015-20210829
i386                 randconfig-a016-20210830
i386                 randconfig-a011-20210830
i386                 randconfig-a015-20210830
i386                 randconfig-a014-20210830
i386                 randconfig-a012-20210830
i386                 randconfig-a013-20210830
arc                  randconfig-r043-20210827
riscv                randconfig-r042-20210827
s390                 randconfig-r044-20210827
s390                 randconfig-r044-20210830
arc                  randconfig-r043-20210830
riscv                randconfig-r042-20210830
arc                  randconfig-r043-20210829
riscv                randconfig-r042-20210829
s390                 randconfig-r044-20210829
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210829
i386                 randconfig-c001-20210829
arm                  randconfig-c002-20210829
riscv                randconfig-c006-20210829
x86_64               randconfig-c007-20210829
powerpc              randconfig-c003-20210829
mips                 randconfig-c004-20210829
i386                 randconfig-c001-20210828
s390                 randconfig-c005-20210828
arm                  randconfig-c002-20210828
riscv                randconfig-c006-20210828
x86_64               randconfig-c007-20210828
mips                 randconfig-c004-20210828
s390                 randconfig-c005-20210827
i386                 randconfig-c001-20210827
arm                  randconfig-c002-20210827
riscv                randconfig-c006-20210827
powerpc              randconfig-c003-20210827
x86_64               randconfig-c007-20210827
mips                 randconfig-c004-20210827
i386                 randconfig-c001-20210830
s390                 randconfig-c005-20210830
riscv                randconfig-c006-20210830
powerpc              randconfig-c003-20210830
mips                 randconfig-c004-20210830
arm                  randconfig-c002-20210830
x86_64               randconfig-c007-20210830
x86_64               randconfig-a005-20210827
x86_64               randconfig-a001-20210827
x86_64               randconfig-a006-20210827
x86_64               randconfig-a003-20210827
x86_64               randconfig-a004-20210827
x86_64               randconfig-a002-20210827
x86_64               randconfig-a001-20210829
x86_64               randconfig-a006-20210829
x86_64               randconfig-a005-20210829
x86_64               randconfig-a003-20210829
x86_64               randconfig-a004-20210829
x86_64               randconfig-a002-20210829
x86_64               randconfig-a005-20210830
x86_64               randconfig-a001-20210830
x86_64               randconfig-a003-20210830
x86_64               randconfig-a002-20210830
x86_64               randconfig-a004-20210830
x86_64               randconfig-a006-20210830
i386                 randconfig-a001-20210829
i386                 randconfig-a006-20210829
i386                 randconfig-a005-20210829
i386                 randconfig-a004-20210829
i386                 randconfig-a003-20210829
i386                 randconfig-a006-20210827
i386                 randconfig-a001-20210827
i386                 randconfig-a002-20210827
i386                 randconfig-a005-20210827
i386                 randconfig-a004-20210827
i386                 randconfig-a003-20210827
i386                 randconfig-a002-20210829
i386                 randconfig-a005-20210830
i386                 randconfig-a002-20210830
i386                 randconfig-a003-20210830
i386                 randconfig-a006-20210830
i386                 randconfig-a004-20210830
i386                 randconfig-a001-20210830
i386                 randconfig-a011-20210828
i386                 randconfig-a016-20210828
i386                 randconfig-a012-20210828
i386                 randconfig-a014-20210828
i386                 randconfig-a013-20210828
i386                 randconfig-a015-20210828
hexagon              randconfig-r041-20210827
hexagon              randconfig-r045-20210827

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
