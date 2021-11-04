Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1744544D
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Nov 2021 14:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhKDN4b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Nov 2021 09:56:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:46664 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhKDN4a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Nov 2021 09:56:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="255346056"
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="255346056"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 06:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="600254262"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2021 06:53:49 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1midBd-0006Sv-3a; Thu, 04 Nov 2021 13:53:49 +0000
Date:   Thu, 04 Nov 2021 21:53:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c983c327442e1d67cccb9e2c73589d7cafd2514c
Message-ID: <6183e5da.3b1O4twb/XE75+ep%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c983c327442e1d67cccb9e2c73589d7cafd2514c  Merge branch 'acpi-video' into bleeding-edge

elapsed time: 1154m

configs tested: 118
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211103
mips                     loongson1b_defconfig
powerpc                      cm5200_defconfig
mips                         mpc30x_defconfig
powerpc                        icon_defconfig
sh                           se7721_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                         3c120_defconfig
nds32                               defconfig
powerpc                 mpc8540_ads_defconfig
arm                        neponset_defconfig
powerpc                     tqm8560_defconfig
arm                          collie_defconfig
sh                      rts7751r2d1_defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5249evb_defconfig
m68k                       bvme6000_defconfig
sparc                       sparc32_defconfig
powerpc                         ps3_defconfig
mips                      bmips_stb_defconfig
arm                        mvebu_v7_defconfig
arm                            dove_defconfig
arm                       multi_v4t_defconfig
powerpc                     tqm8540_defconfig
arm                  randconfig-c002-20211103
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
i386                                defconfig
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a012-20211103
x86_64               randconfig-a015-20211103
i386                 randconfig-a014-20211103
i386                 randconfig-a016-20211103
i386                 randconfig-a013-20211103
i386                 randconfig-a015-20211103
i386                 randconfig-a011-20211103
i386                 randconfig-a012-20211103
arc                  randconfig-r043-20211103
riscv                randconfig-r042-20211103
s390                 randconfig-r044-20211103
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211103
arm                  randconfig-c002-20211103
i386                 randconfig-c001-20211103
s390                 randconfig-c005-20211103
powerpc              randconfig-c003-20211103
mips                 randconfig-c004-20211104
i386                 randconfig-c001-20211104
arm                  randconfig-c002-20211104
s390                 randconfig-c005-20211104
riscv                randconfig-c006-20211104
powerpc              randconfig-c003-20211104
x86_64               randconfig-c007-20211104
i386                 randconfig-a005-20211103
i386                 randconfig-a003-20211103
i386                 randconfig-a001-20211103
i386                 randconfig-a004-20211103
i386                 randconfig-a006-20211103
i386                 randconfig-a002-20211103
x86_64               randconfig-a012-20211104
x86_64               randconfig-a016-20211104
x86_64               randconfig-a015-20211104
x86_64               randconfig-a013-20211104
x86_64               randconfig-a011-20211104
x86_64               randconfig-a014-20211104
x86_64               randconfig-a006-20211103
x86_64               randconfig-a004-20211103
x86_64               randconfig-a001-20211103
x86_64               randconfig-a002-20211103
x86_64               randconfig-a005-20211103
x86_64               randconfig-a003-20211103
hexagon              randconfig-r041-20211103
hexagon              randconfig-r045-20211103

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
