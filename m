Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7B3A08FD
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 03:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235320AbhFIB2R (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 8 Jun 2021 21:28:17 -0400
Received: from mga03.intel.com ([134.134.136.65]:38019 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhFIB2R (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 8 Jun 2021 21:28:17 -0400
IronPort-SDR: bCzxLoUPqfksCfprB0W8VeNkTLrwv/Et0DAsNlbuehWCGYb+mkyVR+sw5WzSuN3YliQFmJXyok
 Ghsz8z/X+CHw==
X-IronPort-AV: E=McAfee;i="6200,9189,10009"; a="205006626"
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="205006626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 18:26:22 -0700
IronPort-SDR: nWPMKqjlSxvZl1FxEs3IIHo+WSwvNCK3k2ySe2g2UQbRIDh8Ck1NI0yLqkKRDG7ugwMz0QOvMl
 E4fYUiVaay1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,259,1616482800"; 
   d="scan'208";a="402273090"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Jun 2021 18:26:20 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lqmz5-0009Iy-Sk; Wed, 09 Jun 2021 01:26:19 +0000
Date:   Wed, 09 Jun 2021 09:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 5a32725a7531b9d4ecec3acb3d13458f10b71690
Message-ID: <60c01882.2Dba3vo0xLFz1L7C%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5a32725a7531b9d4ecec3acb3d13458f10b71690  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 730m

configs tested: 214
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
mips                         rt305x_defconfig
mips                      malta_kvm_defconfig
powerpc                     asp8347_defconfig
arm                           spitz_defconfig
sparc                       sparc32_defconfig
nios2                            allyesconfig
sh                          rsk7203_defconfig
mips                    maltaup_xpa_defconfig
openrisc                 simple_smp_defconfig
mips                      maltasmvp_defconfig
arm                         orion5x_defconfig
h8300                       h8s-sim_defconfig
arm                   milbeaut_m10v_defconfig
xtensa                           alldefconfig
mips                          ath79_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7722_defconfig
sh                           se7724_defconfig
sh                          sdk7786_defconfig
arc                          axs103_defconfig
nios2                         3c120_defconfig
ia64                                defconfig
arc                              alldefconfig
xtensa                       common_defconfig
xtensa                  nommu_kc705_defconfig
arm                    vt8500_v6_v7_defconfig
mips                     loongson2k_defconfig
powerpc                     taishan_defconfig
xtensa                          iss_defconfig
powerpc                     pseries_defconfig
parisc                generic-32bit_defconfig
h8300                    h8300h-sim_defconfig
mips                      loongson3_defconfig
ia64                      gensparse_defconfig
m68k                            q40_defconfig
openrisc                            defconfig
mips                     cu1000-neo_defconfig
arc                        nsim_700_defconfig
arm                       versatile_defconfig
sh                         microdev_defconfig
sh                             espt_defconfig
powerpc                 mpc837x_rdb_defconfig
h8300                            allyesconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
powerpc                      cm5200_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8560_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      pic32mzda_defconfig
sh                          sdk7780_defconfig
mips                      fuloong2e_defconfig
xtensa                  audio_kc705_defconfig
arm                         lpc32xx_defconfig
sh                           se7343_defconfig
mips                         tb0226_defconfig
arm                      integrator_defconfig
arm                         cm_x300_defconfig
arm                         bcm2835_defconfig
mips                            ar7_defconfig
arm64                            alldefconfig
arm                           tegra_defconfig
nds32                            alldefconfig
mips                         tb0219_defconfig
powerpc                 mpc832x_rdb_defconfig
nios2                         10m50_defconfig
arm                          ixp4xx_defconfig
sh                           se7206_defconfig
sh                 kfr2r09-romimage_defconfig
powerpc                 linkstation_defconfig
mips                  cavium_octeon_defconfig
arm                             mxs_defconfig
mips                       rbtx49xx_defconfig
mips                             allmodconfig
arc                         haps_hs_defconfig
powerpc                         wii_defconfig
arm                         s3c2410_defconfig
mips                       lemote2f_defconfig
arm                       aspeed_g4_defconfig
mips                           ip27_defconfig
powerpc                      ppc6xx_defconfig
arm                         s5pv210_defconfig
arm                         shannon_defconfig
m68k                          amiga_defconfig
s390                             allyesconfig
powerpc                     tqm8555_defconfig
powerpc                    mvme5100_defconfig
csky                                defconfig
arm                        cerfcube_defconfig
mips                      maltaaprp_defconfig
sh                          landisk_defconfig
sh                   sh7724_generic_defconfig
powerpc                      mgcoge_defconfig
arm                        mvebu_v5_defconfig
m68k                        mvme147_defconfig
um                           x86_64_defconfig
powerpc                    gamecube_defconfig
powerpc                       ebony_defconfig
arm                         mv78xx0_defconfig
ia64                         bigsur_defconfig
m68k                           sun3_defconfig
powerpc                      pmac32_defconfig
arm                          simpad_defconfig
arm                          pxa3xx_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                       aspeed_g5_defconfig
arm                        magician_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7619_defconfig
xtensa                         virt_defconfig
arm                       imx_v6_v7_defconfig
arm                       netwinder_defconfig
um                             i386_defconfig
powerpc                     tqm5200_defconfig
sh                   secureedge5410_defconfig
powerpc                      bamboo_defconfig
powerpc                  mpc866_ads_defconfig
mips                        workpad_defconfig
powerpc                     mpc83xx_defconfig
arm                      jornada720_defconfig
nds32                             allnoconfig
arc                           tb10x_defconfig
microblaze                          defconfig
powerpc                     kilauea_defconfig
arc                      axs103_smp_defconfig
powerpc                      walnut_defconfig
arm                         nhk8815_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
arm                     am200epdkit_defconfig
mips                      bmips_stb_defconfig
um                               alldefconfig
arm                          pxa168_defconfig
arm                        spear6xx_defconfig
arm                            pleb_defconfig
powerpc                 mpc832x_mds_defconfig
sh                           se7721_defconfig
h8300                               defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210608
x86_64               randconfig-a002-20210608
x86_64               randconfig-a003-20210608
x86_64               randconfig-a006-20210608
x86_64               randconfig-a005-20210608
x86_64               randconfig-a001-20210608
i386                 randconfig-a003-20210608
i386                 randconfig-a006-20210608
i386                 randconfig-a004-20210608
i386                 randconfig-a001-20210608
i386                 randconfig-a005-20210608
i386                 randconfig-a002-20210608
i386                 randconfig-a015-20210608
i386                 randconfig-a013-20210608
i386                 randconfig-a016-20210608
i386                 randconfig-a011-20210608
i386                 randconfig-a012-20210608
i386                 randconfig-a014-20210608
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210607
x86_64               randconfig-a004-20210607
x86_64               randconfig-a003-20210607
x86_64               randconfig-a006-20210607
x86_64               randconfig-a005-20210607
x86_64               randconfig-a001-20210607
x86_64               randconfig-a015-20210608
x86_64               randconfig-a012-20210608
x86_64               randconfig-a014-20210608
x86_64               randconfig-a011-20210608
x86_64               randconfig-a016-20210608
x86_64               randconfig-a013-20210608

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
