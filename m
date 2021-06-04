Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163BB39B422
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Jun 2021 09:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhFDHlA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Jun 2021 03:41:00 -0400
Received: from mga12.intel.com ([192.55.52.136]:5573 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhFDHlA (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Jun 2021 03:41:00 -0400
IronPort-SDR: J2Vah9LnNZSkmVOW0gd7bMlIUJCvNPjPbeJsKz02ljBrd7Zlkt4sMjeGmz2UY4PTFbtcsgBMZk
 Gkh2UrbQ/srg==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="183925954"
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="183925954"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 00:39:13 -0700
IronPort-SDR: mzzh9kbrZ7NTt8r5RjMZLB4vH5jk+cPHEyrbmnJUPCbOJ9suI/nzUUCUdlCZNbuBkxG8mHJuvP
 gh51NGoQIE2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,247,1616482800"; 
   d="scan'208";a="633966076"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jun 2021 00:39:11 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lp4QA-0006mp-Ft; Fri, 04 Jun 2021 07:39:10 +0000
Date:   Fri, 04 Jun 2021 15:38:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 a25ea0c642c2fa68ced9d7e9cfc85ed4ea470deb
Message-ID: <60b9d86e.+X61TmaMmC5O0v7e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a25ea0c642c2fa68ced9d7e9cfc85ed4ea470deb  Merge branches 'pm-core' and 'pm-cpufreq' into linux-next

elapsed time: 2292m

configs tested: 358
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         socfpga_defconfig
arm                            qcom_defconfig
sh                          sdk7786_defconfig
mips                       rbtx49xx_defconfig
parisc                           allyesconfig
mips                        vocore2_defconfig
mips                           ip27_defconfig
powerpc                      pasemi_defconfig
m68k                       m5249evb_defconfig
arm                         lpc32xx_defconfig
mips                        qi_lb60_defconfig
arm                      footbridge_defconfig
mips                        nlm_xlr_defconfig
mips                  decstation_64_defconfig
mips                           ip22_defconfig
mips                      maltaaprp_defconfig
nios2                            alldefconfig
arm                      tct_hammer_defconfig
powerpc                      cm5200_defconfig
mips                       capcella_defconfig
ia64                      gensparse_defconfig
sh                            hp6xx_defconfig
powerpc                      katmai_defconfig
powerpc                   currituck_defconfig
powerpc                    adder875_defconfig
m68k                         apollo_defconfig
powerpc               mpc834x_itxgp_defconfig
powerpc                      arches_defconfig
powerpc                           allnoconfig
h8300                     edosk2674_defconfig
arm                             mxs_defconfig
parisc                generic-64bit_defconfig
arm                           h5000_defconfig
arm                          pxa168_defconfig
mips                          rm200_defconfig
sh                            titan_defconfig
powerpc                     tqm8548_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                         apsh4a3a_defconfig
arc                         haps_hs_defconfig
arm                         mv78xx0_defconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
sh                           se7722_defconfig
m68k                         amcore_defconfig
mips                    maltaup_xpa_defconfig
powerpc                    amigaone_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
m68k                       m5275evb_defconfig
powerpc                 mpc836x_mds_defconfig
powerpc                         ps3_defconfig
mips                         tb0287_defconfig
sh                          landisk_defconfig
mips                        maltaup_defconfig
parisc                              defconfig
sh                               j2_defconfig
powerpc                 mpc837x_mds_defconfig
mips                       lemote2f_defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
powerpc                  storcenter_defconfig
xtensa                generic_kc705_defconfig
sh                          rsk7203_defconfig
powerpc                     ep8248e_defconfig
powerpc                     sequoia_defconfig
arm                         orion5x_defconfig
xtensa                           allyesconfig
arm                         s3c6400_defconfig
sparc                       sparc32_defconfig
powerpc                     tqm8540_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                    sam440ep_defconfig
riscv             nommu_k210_sdcard_defconfig
arm                         lpc18xx_defconfig
riscv                            allyesconfig
arm                          exynos_defconfig
powerpc                     kilauea_defconfig
sh                        sh7757lcr_defconfig
sh                               alldefconfig
powerpc                     sbc8548_defconfig
arm                       netwinder_defconfig
mips                           rs90_defconfig
arm                        cerfcube_defconfig
powerpc                 canyonlands_defconfig
powerpc64                        alldefconfig
arm                       omap2plus_defconfig
xtensa                    smp_lx200_defconfig
arm                           omap1_defconfig
arm                    vt8500_v6_v7_defconfig
arm                            zeus_defconfig
m68k                          amiga_defconfig
mips                            gpr_defconfig
powerpc                     redwood_defconfig
powerpc                    gamecube_defconfig
mips                      loongson3_defconfig
microblaze                          defconfig
powerpc                     tqm5200_defconfig
sh                             shx3_defconfig
arm                           viper_defconfig
powerpc                 mpc8315_rdb_defconfig
nios2                         3c120_defconfig
powerpc                      pcm030_defconfig
nds32                             allnoconfig
powerpc                   lite5200b_defconfig
arm                           u8500_defconfig
um                                  defconfig
sh                          kfr2r09_defconfig
arm                  colibri_pxa270_defconfig
mips                            e55_defconfig
m68k                          hp300_defconfig
ia64                             allyesconfig
sh                        sh7785lcr_defconfig
powerpc                      tqm8xx_defconfig
m68k                            q40_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc8560_ads_defconfig
arm                          simpad_defconfig
powerpc                     tqm8541_defconfig
m68k                       m5208evb_defconfig
arm                           stm32_defconfig
arm                          ep93xx_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                        cell_defconfig
mips                        bcm63xx_defconfig
arm                       imx_v4_v5_defconfig
sparc                            allyesconfig
arm                         s3c2410_defconfig
xtensa                              defconfig
nios2                               defconfig
powerpc                     pseries_defconfig
sh                           se7343_defconfig
sh                          urquell_defconfig
um                            kunit_defconfig
arm                         cm_x300_defconfig
powerpc                mpc7448_hpc2_defconfig
powerpc                 mpc837x_rdb_defconfig
parisc                           alldefconfig
mips                        omega2p_defconfig
mips                          rb532_defconfig
arm                     davinci_all_defconfig
sh                      rts7751r2d1_defconfig
arc                            hsdk_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc83xx_defconfig
nds32                               defconfig
sh                   secureedge5410_defconfig
csky                             alldefconfig
xtensa                    xip_kc705_defconfig
arm                           sunxi_defconfig
sh                          rsk7264_defconfig
arm                            lart_defconfig
m68k                        mvme147_defconfig
sh                           se7619_defconfig
powerpc                 mpc834x_mds_defconfig
mips                           mtx1_defconfig
sh                           se7712_defconfig
powerpc                     rainier_defconfig
arm                         axm55xx_defconfig
sh                             espt_defconfig
sh                        dreamcast_defconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
arm                         nhk8815_defconfig
mips                  cavium_octeon_defconfig
arm                         palmz72_defconfig
mips                      pic32mzda_defconfig
arm                            mmp2_defconfig
mips                      fuloong2e_defconfig
powerpc                      acadia_defconfig
sh                        sh7763rdp_defconfig
arc                              alldefconfig
sh                     sh7710voipgw_defconfig
mips                         tb0219_defconfig
m68k                        m5307c3_defconfig
arm                       multi_v4t_defconfig
arm                       spear13xx_defconfig
powerpc                    ge_imp3a_defconfig
openrisc                  or1klitex_defconfig
powerpc64                           defconfig
arm                           sama5_defconfig
h8300                            alldefconfig
mips                           ci20_defconfig
arm                           tegra_defconfig
powerpc                          allmodconfig
sh                              ul2_defconfig
mips                     loongson2k_defconfig
mips                      pistachio_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                       aspeed_g4_defconfig
sh                           sh2007_defconfig
xtensa                  cadence_csp_defconfig
arm                      pxa255-idp_defconfig
arm                           spitz_defconfig
arm                        vexpress_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
powerpc                   motionpro_defconfig
sh                          r7780mp_defconfig
arm                         assabet_defconfig
mips                         cobalt_defconfig
arc                        vdk_hs38_defconfig
um                             i386_defconfig
riscv                            allmodconfig
powerpc                      ppc44x_defconfig
mips                         rt305x_defconfig
arm                         lubbock_defconfig
powerpc                     akebono_defconfig
powerpc                      bamboo_defconfig
powerpc                       ppc64_defconfig
arc                        nsimosci_defconfig
mips                      malta_kvm_defconfig
ia64                                defconfig
powerpc                     skiroot_defconfig
mips                 decstation_r4k_defconfig
arm                       mainstone_defconfig
sh                           se7721_defconfig
sh                           se7206_defconfig
mips                      maltasmvp_defconfig
m68k                        stmark2_defconfig
arm                           corgi_defconfig
powerpc                 mpc8313_rdb_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a002-20210602
x86_64               randconfig-a004-20210602
x86_64               randconfig-a003-20210602
x86_64               randconfig-a006-20210602
x86_64               randconfig-a005-20210602
x86_64               randconfig-a001-20210602
x86_64               randconfig-a002-20210604
x86_64               randconfig-a004-20210604
x86_64               randconfig-a003-20210604
x86_64               randconfig-a006-20210604
x86_64               randconfig-a005-20210604
x86_64               randconfig-a001-20210604
i386                 randconfig-a003-20210602
i386                 randconfig-a006-20210602
i386                 randconfig-a004-20210602
i386                 randconfig-a001-20210602
i386                 randconfig-a005-20210602
i386                 randconfig-a002-20210602
i386                 randconfig-a003-20210601
i386                 randconfig-a006-20210601
i386                 randconfig-a004-20210601
i386                 randconfig-a001-20210601
i386                 randconfig-a002-20210601
i386                 randconfig-a005-20210601
i386                 randconfig-a003-20210603
i386                 randconfig-a006-20210603
i386                 randconfig-a004-20210603
i386                 randconfig-a001-20210603
i386                 randconfig-a002-20210603
i386                 randconfig-a005-20210603
i386                 randconfig-a003-20210604
i386                 randconfig-a006-20210604
i386                 randconfig-a004-20210604
i386                 randconfig-a001-20210604
i386                 randconfig-a005-20210604
i386                 randconfig-a002-20210604
x86_64               randconfig-a015-20210603
x86_64               randconfig-a011-20210603
x86_64               randconfig-a012-20210603
x86_64               randconfig-a014-20210603
x86_64               randconfig-a016-20210603
x86_64               randconfig-a013-20210603
x86_64               randconfig-a015-20210601
x86_64               randconfig-a011-20210601
x86_64               randconfig-a012-20210601
x86_64               randconfig-a014-20210601
x86_64               randconfig-a016-20210601
x86_64               randconfig-a013-20210601
i386                 randconfig-a015-20210603
i386                 randconfig-a011-20210603
i386                 randconfig-a014-20210603
i386                 randconfig-a012-20210603
i386                 randconfig-a015-20210602
i386                 randconfig-a013-20210602
i386                 randconfig-a016-20210602
i386                 randconfig-a011-20210602
i386                 randconfig-a014-20210602
i386                 randconfig-a012-20210602
i386                 randconfig-a013-20210603
i386                 randconfig-a016-20210603
i386                 randconfig-a015-20210601
i386                 randconfig-a013-20210601
i386                 randconfig-a011-20210601
i386                 randconfig-a016-20210601
i386                 randconfig-a014-20210601
i386                 randconfig-a012-20210601
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210603
x86_64               randconfig-b001-20210604
x86_64               randconfig-b001-20210601
x86_64               randconfig-b001-20210602
x86_64               randconfig-a002-20210603
x86_64               randconfig-a004-20210603
x86_64               randconfig-a003-20210603
x86_64               randconfig-a006-20210603
x86_64               randconfig-a005-20210603
x86_64               randconfig-a001-20210603
x86_64               randconfig-a015-20210602
x86_64               randconfig-a011-20210602
x86_64               randconfig-a012-20210602
x86_64               randconfig-a014-20210602
x86_64               randconfig-a016-20210602
x86_64               randconfig-a013-20210602
x86_64               randconfig-a015-20210604
x86_64               randconfig-a011-20210604
x86_64               randconfig-a014-20210604
x86_64               randconfig-a012-20210604
x86_64               randconfig-a016-20210604
x86_64               randconfig-a013-20210604
x86_64               randconfig-a002-20210601
x86_64               randconfig-a004-20210601
x86_64               randconfig-a003-20210601
x86_64               randconfig-a006-20210601
x86_64               randconfig-a005-20210601
x86_64               randconfig-a001-20210601

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
