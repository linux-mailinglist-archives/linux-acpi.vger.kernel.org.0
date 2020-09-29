Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2637627BB1E
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Sep 2020 04:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgI2Crd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 28 Sep 2020 22:47:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:7690 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgI2Crc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 28 Sep 2020 22:47:32 -0400
IronPort-SDR: 9cOIc/1lkK4J8vN3FfAHHntZbLgkhAeRvtXoaqDKEMr9vUj13zXpGiQ1bvYUu7siUEHhFTcsEV
 m0JI0JVUOIOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9758"; a="162981705"
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="162981705"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2020 19:47:32 -0700
IronPort-SDR: NTFC79nVp3nM20f1HV6tPF7lu6x/41Y620bpURqmHfp6oeSrNvsTu1OTZgFOS93O9u2tUzxHQL
 I6mmImDSGfCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,316,1596524400"; 
   d="scan'208";a="293495720"
Received: from lkp-server02.sh.intel.com (HELO 029ab7997206) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 28 Sep 2020 19:47:30 -0700
Received: from kbuild by 029ab7997206 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kN5ft-00000n-QC; Tue, 29 Sep 2020 02:47:29 +0000
Date:   Tue, 29 Sep 2020 10:47:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe
Message-ID: <5f72a03b.3V6oX1ZdKGavplMX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: eb6335b68ce3fc85a93c4c6cd3bb6bc5ac490efe  Merge branch 'pnp' into linux-next

elapsed time: 725m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                         rt305x_defconfig
mips                      fuloong2e_defconfig
arm                       versatile_defconfig
mips                        nlm_xlp_defconfig
sh                        edosk7705_defconfig
nios2                         3c120_defconfig
powerpc                      arches_defconfig
powerpc                      cm5200_defconfig
sparc                       sparc32_defconfig
arm                          badge4_defconfig
powerpc                        cell_defconfig
powerpc                      obs600_defconfig
sh                        apsh4ad0a_defconfig
sh                            shmin_defconfig
arm                        neponset_defconfig
arm                          collie_defconfig
powerpc                     rainier_defconfig
powerpc                     mpc512x_defconfig
mips                       lemote2f_defconfig
riscv                          rv32_defconfig
arc                            hsdk_defconfig
m68k                       bvme6000_defconfig
arm                         mv78xx0_defconfig
riscv                               defconfig
arm                           spitz_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                      maltaaprp_defconfig
arm                        spear6xx_defconfig
mips                         db1xxx_defconfig
powerpc                 mpc836x_rdk_defconfig
arc                      axs103_smp_defconfig
arm                              zx_defconfig
arm                        mvebu_v5_defconfig
c6x                        evmc6472_defconfig
mips                           gcw0_defconfig
m68k                             allmodconfig
arm                         vf610m4_defconfig
mips                       rbtx49xx_defconfig
nios2                         10m50_defconfig
mips                     cu1000-neo_defconfig
sh                           se7619_defconfig
powerpc                     stx_gp3_defconfig
sh                      rts7751r2d1_defconfig
m68k                             alldefconfig
mips                     decstation_defconfig
arm                           stm32_defconfig
powerpc                     kilauea_defconfig
powerpc                     pseries_defconfig
arm                         lpc32xx_defconfig
ia64                            zx1_defconfig
arm                          simpad_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                 randconfig-a006-20200928
i386                 randconfig-a002-20200928
i386                 randconfig-a003-20200928
i386                 randconfig-a004-20200928
i386                 randconfig-a005-20200928
i386                 randconfig-a001-20200928
i386                 randconfig-a002-20200927
i386                 randconfig-a006-20200927
i386                 randconfig-a003-20200927
i386                 randconfig-a004-20200927
i386                 randconfig-a005-20200927
i386                 randconfig-a001-20200927
i386                 randconfig-a012-20200928
i386                 randconfig-a016-20200928
i386                 randconfig-a014-20200928
i386                 randconfig-a013-20200928
i386                 randconfig-a015-20200928
i386                 randconfig-a011-20200928
x86_64               randconfig-a003-20200928
x86_64               randconfig-a002-20200928
x86_64               randconfig-a001-20200928
x86_64               randconfig-a005-20200928
x86_64               randconfig-a004-20200928
x86_64               randconfig-a006-20200928
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20200928
x86_64               randconfig-a013-20200928
x86_64               randconfig-a015-20200928
x86_64               randconfig-a014-20200928
x86_64               randconfig-a016-20200928
x86_64               randconfig-a012-20200928

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
