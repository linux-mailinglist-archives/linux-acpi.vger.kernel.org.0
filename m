Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 655294300BD
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 09:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbhJPHGy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 03:06:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:43777 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236688AbhJPHGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 03:06:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10138"; a="228312078"
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="228312078"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2021 00:04:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,377,1624345200"; 
   d="scan'208";a="628024989"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 16 Oct 2021 00:04:44 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mbdkK-0008pR-8A; Sat, 16 Oct 2021 07:04:44 +0000
Date:   Sat, 16 Oct 2021 15:04:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 180a736395e7e100b947e3e4a2a5bfe046faacfc
Message-ID: <616a797e.1TZMbgH5KG4ncVQL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 180a736395e7e100b947e3e4a2a5bfe046faacfc  Merge branches 'acpi-battery', 'acpi-scan', 'acpi-soc' and 'acpi-misc' into linux-next

elapsed time: 734m

configs tested: 134
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211015
mips                           ip28_defconfig
sh                        sh7763rdp_defconfig
mips                      bmips_stb_defconfig
powerpc                      acadia_defconfig
mips                        nlm_xlr_defconfig
xtensa                           alldefconfig
mips                        workpad_defconfig
mips                         bigsur_defconfig
mips                           jazz_defconfig
m68k                         amcore_defconfig
arm                         at91_dt_defconfig
powerpc                 mpc8272_ads_defconfig
powerpc                    socrates_defconfig
arm                      tct_hammer_defconfig
mips                      maltasmvp_defconfig
arm                        trizeps4_defconfig
h8300                       h8s-sim_defconfig
sh                        sh7785lcr_defconfig
mips                      maltaaprp_defconfig
sh                     magicpanelr2_defconfig
parisc                           alldefconfig
arm                        mvebu_v5_defconfig
m68k                        m5307c3_defconfig
mips                         db1xxx_defconfig
mips                          malta_defconfig
microblaze                      mmu_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
mips                         tb0219_defconfig
m68k                       m5475evb_defconfig
m68k                          atari_defconfig
sh                          rsk7201_defconfig
powerpc                      obs600_defconfig
arc                              alldefconfig
arm                      integrator_defconfig
arm                  randconfig-c002-20211015
x86_64               randconfig-c001-20211015
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
s390                             allmodconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
arc                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20211016
x86_64               randconfig-a004-20211016
x86_64               randconfig-a001-20211016
x86_64               randconfig-a005-20211016
x86_64               randconfig-a002-20211016
x86_64               randconfig-a003-20211016
x86_64               randconfig-a012-20211015
x86_64               randconfig-a015-20211015
x86_64               randconfig-a016-20211015
x86_64               randconfig-a014-20211015
x86_64               randconfig-a011-20211015
x86_64               randconfig-a013-20211015
i386                 randconfig-a016-20211015
i386                 randconfig-a014-20211015
i386                 randconfig-a011-20211015
i386                 randconfig-a015-20211015
i386                 randconfig-a012-20211015
i386                 randconfig-a013-20211015
arc                  randconfig-r043-20211015
s390                 randconfig-r044-20211015
riscv                randconfig-r042-20211015
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
mips                 randconfig-c004-20211015
arm                  randconfig-c002-20211015
i386                 randconfig-c001-20211015
s390                 randconfig-c005-20211015
x86_64               randconfig-c007-20211015
powerpc              randconfig-c003-20211015
riscv                randconfig-c006-20211015
x86_64               randconfig-a006-20211015
x86_64               randconfig-a004-20211015
x86_64               randconfig-a001-20211015
x86_64               randconfig-a005-20211015
x86_64               randconfig-a002-20211015
x86_64               randconfig-a003-20211015
i386                 randconfig-a003-20211015
i386                 randconfig-a001-20211015
i386                 randconfig-a005-20211015
i386                 randconfig-a004-20211015
i386                 randconfig-a002-20211015
i386                 randconfig-a006-20211015
hexagon              randconfig-r041-20211015
hexagon              randconfig-r045-20211015
hexagon              randconfig-r041-20211016
s390                 randconfig-r044-20211016
riscv                randconfig-r042-20211016
hexagon              randconfig-r045-20211016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
