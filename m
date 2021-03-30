Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D3C34E30A
	for <lists+linux-acpi@lfdr.de>; Tue, 30 Mar 2021 10:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhC3IVf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 30 Mar 2021 04:21:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:18459 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhC3IV2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Mar 2021 04:21:28 -0400
IronPort-SDR: vWubqws/0S5PZqIcnmeUo8N3v9jASGIt8Ftl+e2sJigsKZxy3iqhT6OCE6saBMs5feCbsN7M9E
 8W0Jb6SBK8lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="253061643"
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="253061643"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2021 01:21:27 -0700
IronPort-SDR: KhzZcLyCacj5K8wC/c57nLE3VGJ0vLRPLrfCOCl7PII55CEepG9hvduAq9oAZelas57329x6T9
 BiKs743Rio6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,290,1610438400"; 
   d="scan'208";a="415733823"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2021 01:21:25 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lR9cq-00059v-AP; Tue, 30 Mar 2021 08:21:24 +0000
Date:   Tue, 30 Mar 2021 16:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD REGRESSION
 a70fdf61936ab0200d31bebea4b44bb67454ce07
Message-ID: <6062df67.xFGyi2yKtRohuAOm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a70fdf61936ab0200d31bebea4b44bb67454ce07  Merge branch 'acpi-processor-fixes' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/linux-acpi/202103300514.cNhP3ar5-lkp@intel.com
https://lore.kernel.org/linux-acpi/202103300806.BOpYVHTe-lkp@intel.com

Error/Warning in current branch:

drivers/acpi/processor_idle.c:548:7: error: implicit declaration of function 'wakeup_cpu0' [-Werror,-Wimplicit-function-declaration]
drivers/acpi/processor_idle.c:548:7: error: implicit declaration of function 'wakeup_cpu0' [-Werror=implicit-function-declaration]
drivers/acpi/processor_idle.c:549:4: error: implicit declaration of function 'start_cpu0' [-Werror,-Wimplicit-function-declaration]
drivers/acpi/processor_idle.c:549:4: error: implicit declaration of function 'start_cpu0'; did you mean 'task_cpu'? [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-a014-20210329
    |-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-function-start_cpu0
    `-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-function-wakeup_cpu0

clang_recent_errors
`-- x86_64-randconfig-a013-20210329
    |-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-function-start_cpu0-Werror-Wimplicit-function-declaration
    `-- drivers-acpi-processor_idle.c:error:implicit-declaration-of-function-wakeup_cpu0-Werror-Wimplicit-function-declaration

elapsed time: 878m

configs tested: 102
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
xtensa                         virt_defconfig
m68k                       m5249evb_defconfig
arm                   milbeaut_m10v_defconfig
arm                        magician_defconfig
powerpc                     tqm8540_defconfig
mips                      maltaaprp_defconfig
arm                            zeus_defconfig
mips                          rm200_defconfig
powerpc                     pseries_defconfig
arm                         hackkit_defconfig
m68k                             alldefconfig
parisc                generic-64bit_defconfig
xtensa                  cadence_csp_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                 mpc8272_ads_defconfig
sh                          kfr2r09_defconfig
mips                           rs90_defconfig
arm                        neponset_defconfig
alpha                            alldefconfig
powerpc                    mvme5100_defconfig
powerpc                      acadia_defconfig
sh                           se7343_defconfig
arm                           tegra_defconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210329
i386                 randconfig-a004-20210329
i386                 randconfig-a001-20210329
i386                 randconfig-a002-20210329
i386                 randconfig-a006-20210329
i386                 randconfig-a005-20210329
i386                 randconfig-a014-20210329
i386                 randconfig-a011-20210329
i386                 randconfig-a015-20210329
i386                 randconfig-a016-20210329
i386                 randconfig-a013-20210329
i386                 randconfig-a012-20210329
x86_64               randconfig-a002-20210329
x86_64               randconfig-a003-20210329
x86_64               randconfig-a006-20210329
x86_64               randconfig-a001-20210329
x86_64               randconfig-a005-20210329
x86_64               randconfig-a004-20210329
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210329
x86_64               randconfig-a012-20210329
x86_64               randconfig-a013-20210329
x86_64               randconfig-a014-20210329
x86_64               randconfig-a011-20210329
x86_64               randconfig-a016-20210329

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
