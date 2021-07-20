Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46B8B3CF44D
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jul 2021 08:13:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238793AbhGTFcO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 20 Jul 2021 01:32:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:46476 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236458AbhGTFcH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 20 Jul 2021 01:32:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10050"; a="275007547"
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="275007547"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2021 23:12:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,254,1620716400"; 
   d="scan'208";a="432378659"
Received: from lkp-server02.sh.intel.com (HELO 1b5a72ed9419) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 19 Jul 2021 23:12:29 -0700
Received: from kbuild by 1b5a72ed9419 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m5izV-00004S-68; Tue, 20 Jul 2021 06:12:29 +0000
Date:   Tue, 20 Jul 2021 10:54:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 d713e0c8339876fb5070b53cb1bec248c37fbf38
Message-ID: <60f63ad9.z+M/5R9SB1DCpEvW%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d713e0c8339876fb5070b53cb1bec248c37fbf38  Merge branch 'pm-pci' into linux-next

elapsed time: 726m

configs tested: 185
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
um                           x86_64_defconfig
riscv                            allyesconfig
mips                             allyesconfig
um                             i386_defconfig
mips                             allmodconfig
riscv                            allmodconfig
arm                         cm_x300_defconfig
sh                          rsk7264_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
powerpc                     pseries_defconfig
powerpc                 mpc834x_mds_defconfig
arm                  colibri_pxa300_defconfig
arm                       netwinder_defconfig
powerpc                    gamecube_defconfig
riscv                               defconfig
m68k                           sun3_defconfig
sh                            hp6xx_defconfig
arm                       aspeed_g4_defconfig
arc                           tb10x_defconfig
xtensa                           alldefconfig
powerpc                  iss476-smp_defconfig
arc                          axs103_defconfig
sh                           se7206_defconfig
mips                        jmr3927_defconfig
powerpc                        warp_defconfig
arm                        cerfcube_defconfig
microblaze                          defconfig
sh                           se7343_defconfig
powerpc                     stx_gp3_defconfig
mips                           ci20_defconfig
nds32                            alldefconfig
arm                        clps711x_defconfig
arm                         bcm2835_defconfig
arm                             rpc_defconfig
mips                  decstation_64_defconfig
openrisc                    or1ksim_defconfig
mips                          malta_defconfig
riscv             nommu_k210_sdcard_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc83xx_defconfig
arm                        shmobile_defconfig
mips                     loongson1c_defconfig
powerpc                      bamboo_defconfig
powerpc                      katmai_defconfig
sh                           se7780_defconfig
arm                        mvebu_v5_defconfig
arm                         lubbock_defconfig
arm                   milbeaut_m10v_defconfig
um                               alldefconfig
arm                           sama5_defconfig
powerpc                      ppc6xx_defconfig
mips                         tb0226_defconfig
arm                         orion5x_defconfig
mips                        omega2p_defconfig
riscv                    nommu_virt_defconfig
arm                        vexpress_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc8540_ads_defconfig
x86_64                           allyesconfig
powerpc                    klondike_defconfig
powerpc                      cm5200_defconfig
arm                            hisi_defconfig
powerpc                 mpc836x_mds_defconfig
arm                       omap2plus_defconfig
sh                          r7780mp_defconfig
powerpc                     tqm8540_defconfig
mips                      maltaaprp_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                               j2_defconfig
powerpc                 mpc832x_mds_defconfig
arm                            mmp2_defconfig
arm                       aspeed_g5_defconfig
sh                        edosk7705_defconfig
sh                           se7722_defconfig
sh                               alldefconfig
sh                          sdk7786_defconfig
arm                      footbridge_defconfig
sh                            titan_defconfig
powerpc                     rainier_defconfig
arm                        mini2440_defconfig
arc                              alldefconfig
powerpc                   motionpro_defconfig
m68k                          atari_defconfig
sh                ecovec24-romimage_defconfig
sh                               allmodconfig
arm                    vt8500_v6_v7_defconfig
nds32                             allnoconfig
arm                        trizeps4_defconfig
h8300                            allyesconfig
h8300                     edosk2674_defconfig
powerpc                     tqm8548_defconfig
sh                   rts7751r2dplus_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20210720
x86_64               randconfig-a006-20210720
x86_64               randconfig-a001-20210720
x86_64               randconfig-a005-20210720
x86_64               randconfig-a004-20210720
x86_64               randconfig-a002-20210720
i386                 randconfig-a005-20210720
i386                 randconfig-a003-20210720
i386                 randconfig-a004-20210720
i386                 randconfig-a002-20210720
i386                 randconfig-a001-20210720
i386                 randconfig-a006-20210720
i386                 randconfig-a005-20210719
i386                 randconfig-a004-20210719
i386                 randconfig-a006-20210719
i386                 randconfig-a001-20210719
i386                 randconfig-a003-20210719
i386                 randconfig-a002-20210719
x86_64               randconfig-a013-20210719
x86_64               randconfig-a012-20210719
x86_64               randconfig-a015-20210719
x86_64               randconfig-a014-20210719
x86_64               randconfig-a011-20210719
x86_64               randconfig-a016-20210719
i386                 randconfig-a014-20210719
i386                 randconfig-a015-20210719
i386                 randconfig-a011-20210719
i386                 randconfig-a013-20210719
i386                 randconfig-a016-20210719
i386                 randconfig-a012-20210719
i386                 randconfig-a016-20210720
i386                 randconfig-a013-20210720
i386                 randconfig-a012-20210720
i386                 randconfig-a014-20210720
i386                 randconfig-a011-20210720
i386                 randconfig-a015-20210720
x86_64               randconfig-a005-20210718
x86_64               randconfig-a004-20210718
x86_64               randconfig-a002-20210718
x86_64               randconfig-a003-20210718
x86_64               randconfig-a006-20210718
x86_64               randconfig-a001-20210718
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210720
x86_64               randconfig-b001-20210719
x86_64               randconfig-a011-20210720
x86_64               randconfig-a016-20210720
x86_64               randconfig-a013-20210720
x86_64               randconfig-a014-20210720
x86_64               randconfig-a012-20210720
x86_64               randconfig-a015-20210720

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
