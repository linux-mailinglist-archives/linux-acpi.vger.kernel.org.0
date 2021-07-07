Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35CB3BE07B
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jul 2021 03:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhGGBM5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 6 Jul 2021 21:12:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:35997 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhGGBM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 6 Jul 2021 21:12:57 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="189598134"
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="189598134"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 18:10:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,330,1616482800"; 
   d="scan'208";a="627857349"
Received: from lkp-server01.sh.intel.com (HELO 4aae0cb4f5b5) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 06 Jul 2021 18:10:16 -0700
Received: from kbuild by 4aae0cb4f5b5 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m0w4t-000DHX-77; Wed, 07 Jul 2021 01:10:15 +0000
Date:   Wed, 07 Jul 2021 09:09:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 7570e1f151ada42f46d385c0e67940fe1e732804
Message-ID: <60e4fedd.KeUF+gcntEGUCndG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7570e1f151ada42f46d385c0e67940fe1e732804  Merge branch 'pm-domains' into linux-next

elapsed time: 727m

configs tested: 147
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
x86_64                    rhel-8.3-kselftests
ia64                             allyesconfig
powerpc                      ppc6xx_defconfig
mips                 decstation_r4k_defconfig
sh                           se7206_defconfig
m68k                       bvme6000_defconfig
ia64                      gensparse_defconfig
powerpc                     tqm8560_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                         shannon_defconfig
sh                          rsk7264_defconfig
m68k                            q40_defconfig
x86_64                           alldefconfig
s390                       zfcpdump_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     tqm5200_defconfig
mips                          ath25_defconfig
sh                           se7619_defconfig
arm                          pxa168_defconfig
powerpc                    adder875_defconfig
arc                    vdk_hs38_smp_defconfig
powerpc                     pseries_defconfig
mips                        bcm47xx_defconfig
mips                           ip32_defconfig
powerpc                     akebono_defconfig
mips                     cu1830-neo_defconfig
arc                              alldefconfig
sh                     magicpanelr2_defconfig
powerpc                    ge_imp3a_defconfig
xtensa                       common_defconfig
arm                      jornada720_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      bmips_stb_defconfig
arm                             rpc_defconfig
s390                             alldefconfig
sh                          kfr2r09_defconfig
sh                   secureedge5410_defconfig
sh                        apsh4ad0a_defconfig
arm                            mps2_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                     tqm8555_defconfig
powerpc                      acadia_defconfig
powerpc                      chrp32_defconfig
m68k                          atari_defconfig
mips                           xway_defconfig
arm                      footbridge_defconfig
sh                             sh03_defconfig
xtensa                    smp_lx200_defconfig
i386                                defconfig
arm                        vexpress_defconfig
mips                            e55_defconfig
sh                            hp6xx_defconfig
powerpc                   motionpro_defconfig
sh                           se7750_defconfig
microblaze                      mmu_defconfig
m68k                        stmark2_defconfig
arm                            lart_defconfig
powerpc                    mvme5100_defconfig
sh                         microdev_defconfig
sh                           se7722_defconfig
mips                       bmips_be_defconfig
powerpc                     mpc5200_defconfig
alpha                            alldefconfig
powerpc                 linkstation_defconfig
arm                           viper_defconfig
ia64                          tiger_defconfig
arm                            dove_defconfig
x86_64                            allnoconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210706
i386                 randconfig-a006-20210706
i386                 randconfig-a001-20210706
i386                 randconfig-a003-20210706
i386                 randconfig-a005-20210706
i386                 randconfig-a002-20210706
x86_64               randconfig-a012-20210706
x86_64               randconfig-a011-20210706
x86_64               randconfig-a013-20210706
x86_64               randconfig-a015-20210706
x86_64               randconfig-a014-20210706
x86_64               randconfig-a016-20210706
i386                 randconfig-a012-20210706
i386                 randconfig-a011-20210706
i386                 randconfig-a015-20210706
i386                 randconfig-a016-20210706
i386                 randconfig-a014-20210706
i386                 randconfig-a013-20210706
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210706
x86_64               randconfig-a002-20210706
x86_64               randconfig-a003-20210706
x86_64               randconfig-a001-20210706
x86_64               randconfig-a004-20210706
x86_64               randconfig-a005-20210706
x86_64               randconfig-a006-20210706

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
