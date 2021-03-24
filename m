Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5B3347218
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 08:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhCXHLc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 03:11:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:64960 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235724AbhCXHLW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 24 Mar 2021 03:11:22 -0400
IronPort-SDR: SyPMFeaBjzgVgCk0OyvTxY3ymZYJ82a3hoiy/QoE3vWOeYnT1dI7WeAGAJxKeoDM+pikAHwz5X
 B4S7b6dyZsyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="188334200"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="188334200"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 00:11:21 -0700
IronPort-SDR: 3rB1Vgo9eYH16EdowpJLEHjIRK3J0eXOrpdRwp10lM1hjL2Gr0RgXXDkrPiVtrMgsCYgMrWEur
 GGUnyRw8ACIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="374547211"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 24 Mar 2021 00:11:19 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lOxfi-00015w-PU; Wed, 24 Mar 2021 07:11:18 +0000
Date:   Wed, 24 Mar 2021 15:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 8293f64f5e42b8ffe71896671103b0e82919013d
Message-ID: <605ae5ee.jtwoa6GL0HY6siDG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8293f64f5e42b8ffe71896671103b0e82919013d  Merge branch 'pm-em' into bleeding-edge

elapsed time: 723m

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
i386                             allyesconfig
riscv                            allyesconfig
powerpc                     redwood_defconfig
mips                            ar7_defconfig
m68k                            mac_defconfig
arm                          imote2_defconfig
mips                  cavium_octeon_defconfig
arm                       imx_v4_v5_defconfig
mips                        workpad_defconfig
powerpc64                           defconfig
m68k                        mvme147_defconfig
arm                     davinci_all_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc834x_mds_defconfig
sh                          rsk7201_defconfig
arm                  colibri_pxa300_defconfig
mips                           jazz_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7619_defconfig
m68k                        stmark2_defconfig
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
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a003-20210323
i386                 randconfig-a004-20210323
i386                 randconfig-a001-20210323
i386                 randconfig-a002-20210323
i386                 randconfig-a006-20210323
i386                 randconfig-a005-20210323
i386                 randconfig-a014-20210323
i386                 randconfig-a011-20210323
i386                 randconfig-a015-20210323
i386                 randconfig-a016-20210323
i386                 randconfig-a012-20210323
i386                 randconfig-a013-20210323
x86_64               randconfig-a002-20210323
x86_64               randconfig-a003-20210323
x86_64               randconfig-a006-20210323
x86_64               randconfig-a001-20210323
x86_64               randconfig-a004-20210323
x86_64               randconfig-a005-20210323
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a012-20210323
x86_64               randconfig-a015-20210323
x86_64               randconfig-a013-20210323
x86_64               randconfig-a014-20210323
x86_64               randconfig-a011-20210323
x86_64               randconfig-a016-20210323

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
