Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51B63249EF
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Feb 2021 06:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbhBYFG5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Feb 2021 00:06:57 -0500
Received: from mga01.intel.com ([192.55.52.88]:57064 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229445AbhBYFGz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Feb 2021 00:06:55 -0500
IronPort-SDR: 8bPvbzd9hRILz5ArYVIDjmSxf+5WF9hxpoHRByGkBzejTZlDIL8613gkppUindUb2Q/mVgAQis
 S3HxQDMITtQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="204896167"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="204896167"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 21:06:14 -0800
IronPort-SDR: J6oNWdpzBIsWGrrGo7qs+37JCED0mk2Rs/NwLPM2TsQAk4T9SK/J+aWxphS7l06VB3Z1UsLu77
 kaemGNdJnhhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; 
   d="scan'208";a="367261224"
Received: from lkp-server01.sh.intel.com (HELO 16660e54978b) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Feb 2021 21:06:12 -0800
Received: from kbuild by 16660e54978b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lF8qp-0002VX-Vd; Thu, 25 Feb 2021 05:06:11 +0000
Date:   Thu, 25 Feb 2021 13:05:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 aa22459146987c639004f1fe5a30fe95743c1a1c
Message-ID: <60373024.wiSJ29Hw53lVyzbJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: aa22459146987c639004f1fe5a30fe95743c1a1c  Merge branches 'acpi-platform' and 'acpi-tables' into linux-next

elapsed time: 728m

configs tested: 134
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm5200_defconfig
mips                         db1xxx_defconfig
arm                          pcm027_defconfig
ia64                            zx1_defconfig
sh                            migor_defconfig
powerpc                     ppa8548_defconfig
xtensa                generic_kc705_defconfig
sh                          urquell_defconfig
arm                         s3c6400_defconfig
arm                        magician_defconfig
mips                        bcm47xx_defconfig
sh                            shmin_defconfig
arm                        clps711x_defconfig
arm                          moxart_defconfig
powerpc                     skiroot_defconfig
arm                      jornada720_defconfig
nios2                            allyesconfig
arc                        nsim_700_defconfig
riscv                             allnoconfig
riscv                               defconfig
powerpc                     stx_gp3_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
powerpc                      cm5200_defconfig
arm                         s3c2410_defconfig
arc                        nsimosci_defconfig
powerpc                    adder875_defconfig
sh                            titan_defconfig
sparc                       sparc64_defconfig
arm                             ezx_defconfig
sh                          rsk7201_defconfig
arm                           corgi_defconfig
mips                           ip27_defconfig
arm                           u8500_defconfig
mips                        jmr3927_defconfig
powerpc                      acadia_defconfig
mips                  decstation_64_defconfig
sh                           se7750_defconfig
m68k                       m5475evb_defconfig
arm                           sama5_defconfig
nios2                               defconfig
mips                            ar7_defconfig
arm                        multi_v7_defconfig
sh                           se7780_defconfig
sh                               allmodconfig
parisc                generic-64bit_defconfig
arm                           tegra_defconfig
xtensa                              defconfig
arm                         cm_x300_defconfig
powerpc                    ge_imp3a_defconfig
arm                             mxs_defconfig
arm                            mmp2_defconfig
arm                          lpd270_defconfig
mips                           ci20_defconfig
arm                      tct_hammer_defconfig
c6x                                 defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
powerpc                     mpc83xx_defconfig
mips                           ip28_defconfig
arc                        vdk_hs38_defconfig
mips                         tb0219_defconfig
arm                        realview_defconfig
mips                 decstation_r4k_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210223
i386                 randconfig-a006-20210223
i386                 randconfig-a004-20210223
i386                 randconfig-a003-20210223
i386                 randconfig-a001-20210223
i386                 randconfig-a002-20210223
x86_64               randconfig-a015-20210223
x86_64               randconfig-a011-20210223
x86_64               randconfig-a012-20210223
x86_64               randconfig-a016-20210223
x86_64               randconfig-a014-20210223
x86_64               randconfig-a013-20210223
i386                 randconfig-a013-20210223
i386                 randconfig-a012-20210223
i386                 randconfig-a011-20210223
i386                 randconfig-a014-20210223
i386                 randconfig-a016-20210223
i386                 randconfig-a015-20210223
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a001-20210223
x86_64               randconfig-a002-20210223
x86_64               randconfig-a003-20210223
x86_64               randconfig-a005-20210223
x86_64               randconfig-a006-20210223
x86_64               randconfig-a004-20210223

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
