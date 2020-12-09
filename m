Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1E42D3DD4
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Dec 2020 09:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgLIIn4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Dec 2020 03:43:56 -0500
Received: from mga02.intel.com ([134.134.136.20]:20100 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbgLIInv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 9 Dec 2020 03:43:51 -0500
IronPort-SDR: fN450IapBiHPPqKxhCvRFdxchci4047AdS3/UEQi6FsCqLsl9LBz1WI8J6Kto91A9R7euVujtm
 bIs/7yiyTxNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="161093952"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="161093952"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 00:43:05 -0800
IronPort-SDR: NK3+4N7P4orNvAirTXXVrwL0+T8oBxh+ZV6fnhW87ba+yQ92x4+1ufYOqLV8ADrSOVphlrCUeV
 5cqTF+okSw4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="552551835"
Received: from lkp-server01.sh.intel.com (HELO 2bbb63443648) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 09 Dec 2020 00:43:03 -0800
Received: from kbuild by 2bbb63443648 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmv3u-0000An-Tl; Wed, 09 Dec 2020 08:43:02 +0000
Date:   Wed, 09 Dec 2020 16:42:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 bea64589d9432e630e98f3d0089b5bb697f25cbb
Message-ID: <5fd08ddf.etLo2RPy/wXNw8ih%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: bea64589d9432e630e98f3d0089b5bb697f25cbb  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 720m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                       maple_defconfig
arm                             rpc_defconfig
parisc                generic-32bit_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                        warp_defconfig
sh                          lboxre2_defconfig
sh                         apsh4a3a_defconfig
x86_64                           alldefconfig
powerpc                         wii_defconfig
powerpc                     mpc83xx_defconfig
sh                          rsk7264_defconfig
arc                     haps_hs_smp_defconfig
sh                           se7724_defconfig
powerpc                     ep8248e_defconfig
arm                         assabet_defconfig
powerpc                      mgcoge_defconfig
arc                            hsdk_defconfig
xtensa                              defconfig
powerpc                      pmac32_defconfig
sh                           se7721_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a013-20201208
i386                 randconfig-a014-20201208
i386                 randconfig-a011-20201208
i386                 randconfig-a015-20201208
i386                 randconfig-a012-20201208
i386                 randconfig-a016-20201208
x86_64               randconfig-a004-20201208
x86_64               randconfig-a006-20201208
x86_64               randconfig-a005-20201208
x86_64               randconfig-a001-20201208
x86_64               randconfig-a002-20201208
x86_64               randconfig-a003-20201208
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a016-20201208
x86_64               randconfig-a012-20201208
x86_64               randconfig-a013-20201208
x86_64               randconfig-a014-20201208
x86_64               randconfig-a015-20201208
x86_64               randconfig-a011-20201208

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
