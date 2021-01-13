Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57BE2F452A
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Jan 2021 08:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbhAMHZK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Jan 2021 02:25:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:37153 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbhAMHZK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Jan 2021 02:25:10 -0500
IronPort-SDR: wkf57km0osEQiOtSWA2jCoQ9MUJOJy7RQmF+Ql2ypramRmrj+dPlJaPtK2mkznUTjsoUfCdQsT
 632W0StGMHog==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="239704011"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="239704011"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 23:24:28 -0800
IronPort-SDR: b0vpYcBw8km+tWq4XyqIxdaaIoe0dUForOI7n1jYyI1zL6AJHbeePxGYRANjNuOSdxYA+ZzbeD
 aOGfy+7RhMAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="464806425"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jan 2021 23:24:26 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzaW2-00005x-A5; Wed, 13 Jan 2021 07:24:26 +0000
Date:   Wed, 13 Jan 2021 15:24:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 73249694887d2dab4f292c3b080bd1e8fd1ff7d6
Message-ID: <5ffea010.nytAwTqeAXJdS3c+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 73249694887d2dab4f292c3b080bd1e8fd1ff7d6  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 722m

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
mips                           mtx1_defconfig
m68k                          atari_defconfig
powerpc                    mvme5100_defconfig
arc                    vdk_hs38_smp_defconfig
sh                     magicpanelr2_defconfig
mips                  cavium_octeon_defconfig
riscv                            alldefconfig
arc                            hsdk_defconfig
arm                            xcep_defconfig
powerpc                     ksi8560_defconfig
mips                      fuloong2e_defconfig
powerpc                      arches_defconfig
powerpc                     tqm8548_defconfig
mips                            gpr_defconfig
arm                         shannon_defconfig
m68k                       m5475evb_defconfig
arm                            pleb_defconfig
mips                           xway_defconfig
um                             i386_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210112
i386                 randconfig-a005-20210112
i386                 randconfig-a006-20210112
i386                 randconfig-a003-20210112
i386                 randconfig-a001-20210112
i386                 randconfig-a004-20210112
x86_64               randconfig-a015-20210112
x86_64               randconfig-a012-20210112
x86_64               randconfig-a013-20210112
x86_64               randconfig-a016-20210112
x86_64               randconfig-a014-20210112
x86_64               randconfig-a011-20210112
i386                 randconfig-a012-20210112
i386                 randconfig-a011-20210112
i386                 randconfig-a016-20210112
i386                 randconfig-a013-20210112
i386                 randconfig-a015-20210112
i386                 randconfig-a014-20210112
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210112
x86_64               randconfig-a004-20210112
x86_64               randconfig-a001-20210112
x86_64               randconfig-a005-20210112
x86_64               randconfig-a003-20210112
x86_64               randconfig-a002-20210112

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
