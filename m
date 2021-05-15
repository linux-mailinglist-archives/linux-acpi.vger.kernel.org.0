Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90870381487
	for <lists+linux-acpi@lfdr.de>; Sat, 15 May 2021 02:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234500AbhEOA13 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 20:27:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:3236 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229898AbhEOA12 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 14 May 2021 20:27:28 -0400
IronPort-SDR: 159VspbfjFQgSXj3Zenv/2pKQCf3HBCPezRSRd8SPVTu/22zSoN4zo49HuOI9Khz3BAlwoiRpd
 WrDF6bttBH5A==
X-IronPort-AV: E=McAfee;i="6200,9189,9984"; a="200302854"
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="200302854"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2021 17:26:16 -0700
IronPort-SDR: 67WbnLsQEn9lQtKDXrx34PIPlgZcDiu5WKDlSzU93+eQLmfCXwFJnQMYKxhZYlpAKiGfqpMXkR
 b6c9+uP3zQyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,300,1613462400"; 
   d="scan'208";a="438200955"
Received: from lkp-server01.sh.intel.com (HELO ddd90b05c979) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 May 2021 17:26:14 -0700
Received: from kbuild by ddd90b05c979 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lhi8E-0000wK-1u; Sat, 15 May 2021 00:26:14 +0000
Date:   Sat, 15 May 2021 08:25:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 05bb2ae3f2bf0f86fe8740b90d357cccb7aa3764
Message-ID: <609f1500.aw88k2HeS5wYKyms%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 05bb2ae3f2bf0f86fe8740b90d357cccb7aa3764  Merge branch 'acpi-dptf' into linux-next

elapsed time: 723m

configs tested: 172
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
mips                           mtx1_defconfig
arm                           u8500_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc836x_rdk_defconfig
sh                          rsk7264_defconfig
arm                         lpc32xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                         ecovec24_defconfig
xtensa                  cadence_csp_defconfig
powerpc                 mpc832x_rdb_defconfig
powerpc                       ppc64_defconfig
arm                   milbeaut_m10v_defconfig
mips                          rb532_defconfig
arm                          ixp4xx_defconfig
um                                  defconfig
powerpc                    socrates_defconfig
parisc                generic-64bit_defconfig
mips                        nlm_xlr_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                           se7721_defconfig
openrisc                         alldefconfig
m68k                       m5208evb_defconfig
m68k                        m5407c3_defconfig
powerpc                      arches_defconfig
arm                           omap1_defconfig
arm                         mv78xx0_defconfig
arm                       mainstone_defconfig
powerpc                      mgcoge_defconfig
arm                          exynos_defconfig
powerpc                     ppa8548_defconfig
sh                     magicpanelr2_defconfig
powerpc                     pseries_defconfig
arm                      pxa255-idp_defconfig
arm                        spear3xx_defconfig
arm                              alldefconfig
openrisc                  or1klitex_defconfig
powerpc                    amigaone_defconfig
sh                          sdk7786_defconfig
powerpc                 mpc832x_mds_defconfig
arm                     davinci_all_defconfig
mips                         tb0219_defconfig
m68k                       m5275evb_defconfig
sh                           sh2007_defconfig
m68k                        m5272c3_defconfig
powerpc                 mpc836x_mds_defconfig
xtensa                           allyesconfig
sh                           se7712_defconfig
m68k                       bvme6000_defconfig
mips                      maltaaprp_defconfig
xtensa                  nommu_kc705_defconfig
nios2                         3c120_defconfig
ia64                                defconfig
mips                          rm200_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc5200_defconfig
arm                            mps2_defconfig
ia64                          tiger_defconfig
powerpc                   currituck_defconfig
riscv                               defconfig
arc                                 defconfig
m68k                       m5249evb_defconfig
m68k                           sun3_defconfig
powerpc                     mpc512x_defconfig
openrisc                 simple_smp_defconfig
mips                           ip22_defconfig
arc                          axs101_defconfig
m68k                          hp300_defconfig
powerpc                         wii_defconfig
riscv                          rv32_defconfig
openrisc                            defconfig
arm                        mvebu_v5_defconfig
arc                           tb10x_defconfig
sparc64                          alldefconfig
openrisc                    or1ksim_defconfig
powerpc                 mpc8272_ads_defconfig
parisc                           alldefconfig
powerpc64                           defconfig
ia64                            zx1_defconfig
arm                        multi_v7_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                             allyesconfig
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
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
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
x86_64               randconfig-a004-20210514
x86_64               randconfig-a003-20210514
x86_64               randconfig-a001-20210514
x86_64               randconfig-a005-20210514
x86_64               randconfig-a002-20210514
x86_64               randconfig-a006-20210514
i386                 randconfig-a003-20210514
i386                 randconfig-a001-20210514
i386                 randconfig-a004-20210514
i386                 randconfig-a005-20210514
i386                 randconfig-a002-20210514
i386                 randconfig-a006-20210514
x86_64               randconfig-a012-20210515
x86_64               randconfig-a015-20210515
x86_64               randconfig-a011-20210515
x86_64               randconfig-a013-20210515
x86_64               randconfig-a016-20210515
x86_64               randconfig-a014-20210515
i386                 randconfig-a016-20210515
i386                 randconfig-a014-20210515
i386                 randconfig-a011-20210515
i386                 randconfig-a012-20210515
i386                 randconfig-a015-20210515
i386                 randconfig-a013-20210515
i386                 randconfig-a016-20210514
i386                 randconfig-a014-20210514
i386                 randconfig-a011-20210514
i386                 randconfig-a012-20210514
i386                 randconfig-a015-20210514
i386                 randconfig-a013-20210514
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20210515
x86_64               randconfig-a003-20210515
x86_64               randconfig-a001-20210515
x86_64               randconfig-a005-20210515
x86_64               randconfig-a002-20210515
x86_64               randconfig-a006-20210515
x86_64               randconfig-a015-20210514
x86_64               randconfig-a012-20210514
x86_64               randconfig-a011-20210514
x86_64               randconfig-a013-20210514
x86_64               randconfig-a016-20210514
x86_64               randconfig-a014-20210514

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
