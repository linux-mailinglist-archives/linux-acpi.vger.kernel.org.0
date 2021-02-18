Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9131E952
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Feb 2021 12:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhBRLvU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 18 Feb 2021 06:51:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:22459 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230428AbhBRKOL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 18 Feb 2021 05:14:11 -0500
IronPort-SDR: P0Nw3GViz5AaV+ETM7+zv7hJYUlF8gqitqCuE4mEZKkDs15QD8bP5EEiIesIvf7e1glMFlzRSJ
 k3cBDtxjcQfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="182665043"
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="182665043"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2021 02:09:38 -0800
IronPort-SDR: mard8TJbZeholjzD5Ca8t/YAk0s5CZ3dQ8iFWlFD68/n7L6Q7kgLNMLmDmQzW/ilTQggVzvbh8
 dd/TXXmXWwhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,186,1610438400"; 
   d="scan'208";a="400430609"
Received: from lkp-server02.sh.intel.com (HELO cd560a204411) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 18 Feb 2021 02:09:37 -0800
Received: from kbuild by cd560a204411 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lCgFc-0009bC-CN; Thu, 18 Feb 2021 10:09:36 +0000
Date:   Thu, 18 Feb 2021 18:09:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 c9756fcd3979ee48382b8e442bb0375bfa05291f
Message-ID: <602e3cc6.MQhu9YenDQ+chS5K%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c9756fcd3979ee48382b8e442bb0375bfa05291f  Merge branch 'pm-cpufreq-fixes' into linux-next

elapsed time: 725m

configs tested: 121
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                        multi_v5_defconfig
arm                            u300_defconfig
powerpc                        icon_defconfig
sh                          polaris_defconfig
arm                            lart_defconfig
powerpc                     rainier_defconfig
arm                        cerfcube_defconfig
arm                         lpc32xx_defconfig
arm                         s3c2410_defconfig
arm                          pxa3xx_defconfig
m68k                       m5208evb_defconfig
mips                      pic32mzda_defconfig
sparc                       sparc64_defconfig
powerpc                      katmai_defconfig
powerpc                      acadia_defconfig
xtensa                    xip_kc705_defconfig
m68k                        m5307c3_defconfig
m68k                        m5407c3_defconfig
arm                             rpc_defconfig
sh                           sh2007_defconfig
mips                           ip27_defconfig
powerpc                 xes_mpc85xx_defconfig
arc                         haps_hs_defconfig
xtensa                           alldefconfig
sh                     sh7710voipgw_defconfig
powerpc                 mpc8315_rdb_defconfig
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
i386                 randconfig-a003-20210216
i386                 randconfig-a005-20210216
i386                 randconfig-a002-20210216
i386                 randconfig-a006-20210216
i386                 randconfig-a001-20210216
i386                 randconfig-a004-20210216
x86_64               randconfig-a013-20210217
x86_64               randconfig-a016-20210217
x86_64               randconfig-a012-20210217
x86_64               randconfig-a015-20210217
x86_64               randconfig-a014-20210217
x86_64               randconfig-a011-20210217
i386                 randconfig-a016-20210216
i386                 randconfig-a014-20210216
i386                 randconfig-a012-20210216
i386                 randconfig-a013-20210216
i386                 randconfig-a011-20210216
i386                 randconfig-a015-20210216
i386                 randconfig-a016-20210217
i386                 randconfig-a014-20210217
i386                 randconfig-a012-20210217
i386                 randconfig-a013-20210217
i386                 randconfig-a011-20210217
i386                 randconfig-a015-20210217
x86_64               randconfig-a003-20210216
x86_64               randconfig-a002-20210216
x86_64               randconfig-a004-20210216
x86_64               randconfig-a001-20210216
x86_64               randconfig-a005-20210216
x86_64               randconfig-a006-20210216
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
x86_64               randconfig-a013-20210216
x86_64               randconfig-a016-20210216
x86_64               randconfig-a012-20210216
x86_64               randconfig-a015-20210216
x86_64               randconfig-a014-20210216
x86_64               randconfig-a011-20210216
x86_64               randconfig-a003-20210215
x86_64               randconfig-a002-20210215
x86_64               randconfig-a001-20210215
x86_64               randconfig-a004-20210215
x86_64               randconfig-a005-20210215
x86_64               randconfig-a006-20210215

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
