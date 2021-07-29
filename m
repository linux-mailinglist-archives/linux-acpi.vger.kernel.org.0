Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79693DA198
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jul 2021 12:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhG2KzE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jul 2021 06:55:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:10137 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236297AbhG2KzE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 29 Jul 2021 06:55:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="234748462"
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="234748462"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2021 03:55:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,278,1620716400"; 
   d="scan'208";a="438197145"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2021 03:54:59 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m93gp-000951-3b; Thu, 29 Jul 2021 10:54:59 +0000
Date:   Thu, 29 Jul 2021 18:54:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 604483c9d25283debe498a972c2b4565581e3aaa
Message-ID: <610288fc./qagMLSQVR8tK3Jl%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 604483c9d25283debe498a972c2b4565581e3aaa  Merge branch 'acpi-dptf' into linux-next

elapsed time: 1076m

configs tested: 110
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210728
powerpc                     kilauea_defconfig
m68k                          multi_defconfig
sh                          polaris_defconfig
powerpc                 mpc8560_ads_defconfig
powerpc                       holly_defconfig
x86_64                              defconfig
arm                       spear13xx_defconfig
sh                   sh7724_generic_defconfig
m68k                         apollo_defconfig
arm                           u8500_defconfig
powerpc                   currituck_defconfig
mips                           ip32_defconfig
mips                  cavium_octeon_defconfig
ia64                             allmodconfig
sh                          rsk7269_defconfig
m68k                       m5249evb_defconfig
sh                           sh2007_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     mpc5200_defconfig
powerpc                    adder875_defconfig
sh                          r7780mp_defconfig
mips                           mtx1_defconfig
m68k                             allmodconfig
arm                        vexpress_defconfig
mips                     loongson2k_defconfig
sh                          rsk7264_defconfig
sh                   sh7770_generic_defconfig
h8300                            alldefconfig
openrisc                 simple_smp_defconfig
x86_64                            allnoconfig
ia64                                defconfig
ia64                             allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20210728
x86_64               randconfig-a003-20210728
x86_64               randconfig-a001-20210728
x86_64               randconfig-a004-20210728
x86_64               randconfig-a005-20210728
x86_64               randconfig-a002-20210728
i386                 randconfig-a005-20210728
i386                 randconfig-a003-20210728
i386                 randconfig-a004-20210728
i386                 randconfig-a002-20210728
i386                 randconfig-a001-20210728
i386                 randconfig-a006-20210728
i386                 randconfig-a016-20210728
i386                 randconfig-a012-20210728
i386                 randconfig-a013-20210728
i386                 randconfig-a014-20210728
i386                 randconfig-a011-20210728
i386                 randconfig-a015-20210728
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-c001-20210728
x86_64               randconfig-a006-20210729
x86_64               randconfig-a003-20210729
x86_64               randconfig-a001-20210729
x86_64               randconfig-a004-20210729
x86_64               randconfig-a005-20210729
x86_64               randconfig-a002-20210729
x86_64               randconfig-a016-20210728
x86_64               randconfig-a011-20210728
x86_64               randconfig-a014-20210728
x86_64               randconfig-a013-20210728
x86_64               randconfig-a012-20210728
x86_64               randconfig-a015-20210728

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
