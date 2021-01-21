Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489492FE2D1
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 07:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbhAUG1G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 01:27:06 -0500
Received: from mga06.intel.com ([134.134.136.31]:58483 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbhAUG02 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 21 Jan 2021 01:26:28 -0500
IronPort-SDR: z0ynmDEXZTU89ZoL3ClzIwcX9z2vWNGvC6ootWMvhauWI798Kk1uItPLSOyhaAsyi50jAVHUYr
 lmtpShlp+haA==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="240764674"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="240764674"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 22:25:46 -0800
IronPort-SDR: YCSivWnmkbZ0e9A8AW3RrJNGJYH5aQykJ1/4YZV6IXTwbH564DyN1ToorCSixoFTBnSHwxdOxz
 J2BZr155h1ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="467350049"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Jan 2021 22:25:44 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2TPb-0006Lb-TM; Thu, 21 Jan 2021 06:25:43 +0000
Date:   Thu, 21 Jan 2021 14:25:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 693e119601907f923bcf08aca03793a0d1cf4416
Message-ID: <60091e62.ARJpxQVSwHfZKZ/b%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 693e119601907f923bcf08aca03793a0d1cf4416  Merge branch 'acpi-platform' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s002-20210119
    `-- include-linux-spinlock.h:sparse:sparse:context-imbalance-in-pm_clk_list_lock-wrong-count-at-exit

elapsed time: 722m

configs tested: 96
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
mips                        workpad_defconfig
sh                                  defconfig
arm                          gemini_defconfig
mips                           jazz_defconfig
arm                           spitz_defconfig
mips                  cavium_octeon_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                     redwood_defconfig
mips                          rm200_defconfig
ia64                          tiger_defconfig
m68k                       bvme6000_defconfig
powerpc                    klondike_defconfig
sh                            titan_defconfig
powerpc                     rainier_defconfig
powerpc                  storcenter_defconfig
arm                         axm55xx_defconfig
arm                           h3600_defconfig
c6x                                 defconfig
xtensa                       common_defconfig
m68k                          multi_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
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
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120
x86_64               randconfig-a015-20210119
x86_64               randconfig-a013-20210119
x86_64               randconfig-a012-20210119
x86_64               randconfig-a016-20210119
x86_64               randconfig-a011-20210119
x86_64               randconfig-a014-20210119

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
