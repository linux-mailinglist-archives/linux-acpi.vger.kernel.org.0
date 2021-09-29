Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFE6641C369
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Sep 2021 13:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244949AbhI2L1S (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Sep 2021 07:27:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:25410 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244528AbhI2L1S (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 29 Sep 2021 07:27:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10121"; a="288575338"
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="288575338"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2021 04:25:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,332,1624345200"; 
   d="scan'208";a="538779189"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2021 04:25:26 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVXiH-0002UW-MM; Wed, 29 Sep 2021 11:25:25 +0000
Date:   Wed, 29 Sep 2021 19:24:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 5264d800ffd532b515f32ad3a3439b5611438157
Message-ID: <61544cf4.M13BfTeVAKOd9SWQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5264d800ffd532b515f32ad3a3439b5611438157  Merge branch 'pm-pci' into linux-next

Warning reports:

https://lore.kernel.org/linux-pm/202109291232.WuE3FUSQ-lkp@intel.com

Warning in current branch:

drivers/pci/pci-acpi.c:1125:12: warning: 'adev' is used uninitialized [-Wuninitialized]
drivers/pci/pci-acpi.c:1127:12: warning: 'adev' is used uninitialized [-Wuninitialized]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-defconfig
|   `-- drivers-pci-pci-acpi.c:warning:adev-is-used-uninitialized
`-- ia64-randconfig-r031-20210928
    `-- drivers-pci-pci-acpi.c:warning:adev-is-used-uninitialized

elapsed time: 739m

configs tested: 180
configs skipped: 3

gcc tested configs:
arm                              allyesconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allmodconfig
i386                 randconfig-c001-20210928
i386                 randconfig-c001-20210929
i386                 randconfig-c001-20210927
arm                       imx_v6_v7_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      bamboo_defconfig
mips                    maltaup_xpa_defconfig
arm                          ep93xx_defconfig
powerpc                    amigaone_defconfig
powerpc                     ksi8560_defconfig
powerpc                    sam440ep_defconfig
sh                          rsk7203_defconfig
powerpc                       ebony_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
arm                          iop32x_defconfig
powerpc                 mpc8560_ads_defconfig
m68k                            mac_defconfig
powerpc                 mpc837x_mds_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
powerpc                      mgcoge_defconfig
riscv                            allyesconfig
mips                       lemote2f_defconfig
sh                        sh7757lcr_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
powerpc                      arches_defconfig
mips                     decstation_defconfig
arm                         s5pv210_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                     skiroot_defconfig
sh                           se7722_defconfig
arm                            pleb_defconfig
arm                     am200epdkit_defconfig
mips                      maltasmvp_defconfig
powerpc                 mpc837x_rdb_defconfig
nds32                            alldefconfig
mips                           jazz_defconfig
arm                       netwinder_defconfig
arm                  colibri_pxa270_defconfig
mips                      maltaaprp_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     tqm8541_defconfig
powerpc                 linkstation_defconfig
sh                        sh7763rdp_defconfig
arm                           sama7_defconfig
powerpc                     tqm8560_defconfig
nds32                               defconfig
powerpc                      ep88xc_defconfig
m68k                          atari_defconfig
mips                           ip32_defconfig
arc                        nsimosci_defconfig
arm                         bcm2835_defconfig
powerpc                     ep8248e_defconfig
m68k                       bvme6000_defconfig
sh                           se7721_defconfig
mips                     loongson1c_defconfig
mips                         mpc30x_defconfig
riscv             nommu_k210_sdcard_defconfig
arc                        nsim_700_defconfig
arm                           tegra_defconfig
riscv                            alldefconfig
sparc64                             defconfig
arm                            hisi_defconfig
powerpc                     kilauea_defconfig
arm                        keystone_defconfig
arm                        mvebu_v7_defconfig
mips                            gpr_defconfig
mips                   sb1250_swarm_defconfig
arm                        spear6xx_defconfig
m68k                        mvme16x_defconfig
sparc                       sparc32_defconfig
arm                            mmp2_defconfig
arm                         assabet_defconfig
sh                           sh2007_defconfig
arm                          ixp4xx_defconfig
sh                          urquell_defconfig
mips                           ip27_defconfig
mips                      fuloong2e_defconfig
sh                          r7780mp_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
microblaze                      mmu_defconfig
sh                           se7751_defconfig
powerpc                     tqm5200_defconfig
sh                          sdk7780_defconfig
arm                             ezx_defconfig
x86_64               randconfig-c001-20210928
arm                  randconfig-c002-20210928
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a014-20210928
x86_64               randconfig-a011-20210928
x86_64               randconfig-a013-20210928
x86_64               randconfig-a012-20210928
x86_64               randconfig-a015-20210928
x86_64               randconfig-a016-20210928
i386                 randconfig-a014-20210928
i386                 randconfig-a013-20210928
i386                 randconfig-a016-20210928
i386                 randconfig-a011-20210928
i386                 randconfig-a015-20210928
i386                 randconfig-a012-20210928
arc                  randconfig-r043-20210928
riscv                randconfig-r042-20210928
s390                 randconfig-r044-20210928
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
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
powerpc              randconfig-c003-20210927
x86_64               randconfig-c007-20210927
mips                 randconfig-c004-20210927
arm                  randconfig-c002-20210927
riscv                randconfig-c006-20210927
s390                 randconfig-c005-20210927
i386                 randconfig-c001-20210927
x86_64               randconfig-a002-20210928
x86_64               randconfig-a005-20210928
x86_64               randconfig-a001-20210928
x86_64               randconfig-a006-20210928
x86_64               randconfig-a003-20210928
x86_64               randconfig-a004-20210928
i386                 randconfig-a001-20210928
i386                 randconfig-a005-20210928
i386                 randconfig-a002-20210928
i386                 randconfig-a006-20210928
i386                 randconfig-a004-20210928
i386                 randconfig-a003-20210928
hexagon              randconfig-r045-20210928
hexagon              randconfig-r041-20210928
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
