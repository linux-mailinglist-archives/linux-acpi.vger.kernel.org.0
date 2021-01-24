Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AD6301E66
	for <lists+linux-acpi@lfdr.de>; Sun, 24 Jan 2021 20:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbhAXTNM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 24 Jan 2021 14:13:12 -0500
Received: from mga04.intel.com ([192.55.52.120]:25385 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbhAXTNH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 24 Jan 2021 14:13:07 -0500
IronPort-SDR: bXmAq3iL5/WgdWVj7GNJNE5bjFKLkYNIQJ8VIWvn3wzNyQZFsIIcJ5Bl52NTfdVRafIcOCTO07
 19XCoRwSOtoA==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="177058659"
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="177058659"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 11:12:46 -0800
IronPort-SDR: bWltPLuGspN6msS4NihJx/K3HZKo9pSa2nSCtNaH+R6RrEeZa0iT0NoJSwtNAaS4HjH0ykStRy
 mbEzowHhYNrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,371,1602572400"; 
   d="scan'208";a="349908223"
Received: from lkp-server01.sh.intel.com (HELO 27c4e0a4b6d9) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2021 11:12:45 -0800
Received: from kbuild by 27c4e0a4b6d9 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l3koW-0000Qb-CZ; Sun, 24 Jan 2021 19:12:44 +0000
Date:   Mon, 25 Jan 2021 03:12:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 a44d3fbdfbd1dde8c1726ba55638767fa359103d
Message-ID: <600dc681.3mAl9WQXnragfNZk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a44d3fbdfbd1dde8c1726ba55638767fa359103d  Merge branch 'pm-domains' into bleeding-edge

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-randconfig-s002-20210124
|   `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-pm_clk_list_unlock-wrong-count-at-exit
|-- x86_64-randconfig-s021-20210124
|   `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-pm_clk_list_unlock-wrong-count-at-exit
`-- x86_64-randconfig-s022-20210124
    `-- drivers-base-power-clock_ops.c:sparse:sparse:context-imbalance-in-pm_clk_list_unlock-wrong-count-at-exit

elapsed time: 737m

configs tested: 95
configs skipped: 2

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
mips                malta_kvm_guest_defconfig
mips                malta_qemu_32r6_defconfig
arm                          pcm027_defconfig
sparc64                             defconfig
arm                       netwinder_defconfig
powerpc                    sam440ep_defconfig
sh                           se7206_defconfig
mips                         bigsur_defconfig
mips                         mpc30x_defconfig
mips                          ath79_defconfig
xtensa                    smp_lx200_defconfig
mips                      loongson3_defconfig
powerpc                     mpc512x_defconfig
sh                          rsk7269_defconfig
mips                           mtx1_defconfig
powerpc                     asp8347_defconfig
powerpc                         wii_defconfig
powerpc                 canyonlands_defconfig
sh                           sh2007_defconfig
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
i386                 randconfig-a001-20210124
i386                 randconfig-a002-20210124
i386                 randconfig-a004-20210124
i386                 randconfig-a006-20210124
i386                 randconfig-a005-20210124
i386                 randconfig-a003-20210124
x86_64               randconfig-a012-20210124
x86_64               randconfig-a016-20210124
x86_64               randconfig-a015-20210124
x86_64               randconfig-a011-20210124
x86_64               randconfig-a013-20210124
x86_64               randconfig-a014-20210124
i386                 randconfig-a013-20210124
i386                 randconfig-a011-20210124
i386                 randconfig-a012-20210124
i386                 randconfig-a015-20210124
i386                 randconfig-a014-20210124
i386                 randconfig-a016-20210124
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
x86_64               randconfig-a003-20210124
x86_64               randconfig-a002-20210124
x86_64               randconfig-a001-20210124
x86_64               randconfig-a005-20210124
x86_64               randconfig-a006-20210124
x86_64               randconfig-a004-20210124

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
