Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B866400A1A
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Sep 2021 08:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349535AbhIDGcy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Sep 2021 02:32:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:19045 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237310AbhIDGcy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 4 Sep 2021 02:32:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10096"; a="219645774"
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="219645774"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2021 23:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,267,1624345200"; 
   d="scan'208";a="522077007"
Received: from lkp-server01.sh.intel.com (HELO 2115029a3e5c) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 03 Sep 2021 23:31:51 -0700
Received: from kbuild by 2115029a3e5c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mMPDS-0001Hu-HH; Sat, 04 Sep 2021 06:31:50 +0000
Date:   Sat, 04 Sep 2021 14:30:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 6f65d2319f21868fed3a3a424e6e4005611f1488
Message-ID: <613312a2.kYQFYH3APlFamFNE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6f65d2319f21868fed3a3a424e6e4005611f1488  Merge branches 'acpi-pci', 'acpi-pm' and 'acpi-docs' into linux-next

elapsed time: 720m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210904
um                               alldefconfig
powerpc                     kilauea_defconfig
sh                           se7343_defconfig
mips                        workpad_defconfig
sh                   sh7770_generic_defconfig
arm                         s5pv210_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     rainier_defconfig
mips                         tb0226_defconfig
m68k                        m5272c3_defconfig
mips                        bcm63xx_defconfig
arm                         socfpga_defconfig
arm                        spear6xx_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                         amcore_defconfig
sparc                       sparc64_defconfig
sh                           se7206_defconfig
mips                       capcella_defconfig
arm                          collie_defconfig
powerpc                 mpc836x_mds_defconfig
microblaze                      mmu_defconfig
arm                  colibri_pxa270_defconfig
arm                          simpad_defconfig
arc                     haps_hs_smp_defconfig
powerpc                    klondike_defconfig
powerpc                     tqm8548_defconfig
powerpc                        cell_defconfig
h8300                     edosk2674_defconfig
powerpc                      pasemi_defconfig
s390                             allmodconfig
powerpc                     mpc83xx_defconfig
powerpc                      makalu_defconfig
mips                           gcw0_defconfig
riscv                               defconfig
xtensa                       common_defconfig
powerpc                     tqm8540_defconfig
arm                  colibri_pxa300_defconfig
arm                       imx_v6_v7_defconfig
sh                          urquell_defconfig
xtensa                  nommu_kc705_defconfig
arm                         at91_dt_defconfig
ia64                        generic_defconfig
powerpc                      katmai_defconfig
arm                         nhk8815_defconfig
sh                          polaris_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     asp8347_defconfig
arm                       versatile_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
arm                        clps711x_defconfig
um                                  defconfig
m68k                             allyesconfig
mips                         rt305x_defconfig
mips                        maltaup_defconfig
arm                           viper_defconfig
powerpc                  mpc866_ads_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                      pxa255-idp_defconfig
ia64                         bigsur_defconfig
nds32                            alldefconfig
powerpc                          g5_defconfig
arm                         lubbock_defconfig
h8300                    h8300h-sim_defconfig
openrisc                 simple_smp_defconfig
arm                            lart_defconfig
powerpc                      ppc64e_defconfig
mips                           ci20_defconfig
sh                     magicpanelr2_defconfig
arm                    vt8500_v6_v7_defconfig
sh                         ecovec24_defconfig
sh                   rts7751r2dplus_defconfig
powerpc               mpc834x_itxgp_defconfig
m68k                        mvme16x_defconfig
mips                      bmips_stb_defconfig
mips                      maltaaprp_defconfig
powerpc                     akebono_defconfig
sh                         microdev_defconfig
powerpc                 mpc85xx_cds_defconfig
xtensa                generic_kc705_defconfig
parisc                generic-32bit_defconfig
arm                          exynos_defconfig
sh                          rsk7264_defconfig
powerpc                     tqm5200_defconfig
mips                    maltaup_xpa_defconfig
arm                  randconfig-c002-20210904
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
x86_64               randconfig-a006-20210904
x86_64               randconfig-a004-20210904
x86_64               randconfig-a003-20210904
x86_64               randconfig-a005-20210904
x86_64               randconfig-a001-20210904
x86_64               randconfig-a002-20210904
i386                 randconfig-a005-20210904
i386                 randconfig-a004-20210904
i386                 randconfig-a006-20210904
i386                 randconfig-a002-20210904
i386                 randconfig-a003-20210904
i386                 randconfig-a001-20210904
arc                  randconfig-r043-20210904
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
s390                 randconfig-c005-20210904
mips                 randconfig-c004-20210904
powerpc              randconfig-c003-20210904
x86_64               randconfig-c007-20210904
i386                 randconfig-c001-20210904
arm                  randconfig-c002-20210904
riscv                randconfig-c006-20210904
x86_64               randconfig-a011-20210904
x86_64               randconfig-a016-20210904
x86_64               randconfig-a012-20210904
x86_64               randconfig-a015-20210904
x86_64               randconfig-a014-20210904
x86_64               randconfig-a013-20210904
i386                 randconfig-a012-20210904
i386                 randconfig-a015-20210904
i386                 randconfig-a011-20210904
i386                 randconfig-a013-20210904
i386                 randconfig-a014-20210904
i386                 randconfig-a016-20210904
riscv                randconfig-r042-20210904
hexagon              randconfig-r045-20210904
s390                 randconfig-r044-20210904
hexagon              randconfig-r041-20210904

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
