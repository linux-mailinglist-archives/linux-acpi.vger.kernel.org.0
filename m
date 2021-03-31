Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC834FB02
	for <lists+linux-acpi@lfdr.de>; Wed, 31 Mar 2021 10:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhCaIAT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 31 Mar 2021 04:00:19 -0400
Received: from mga01.intel.com ([192.55.52.88]:30386 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234293AbhCaH7t (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 31 Mar 2021 03:59:49 -0400
IronPort-SDR: S6CoU/QmkbXGaIUNXbhiNNMb0CphKQfjFF/xDa1tfNeHu0KuwDk/aB9HbOPAxkAxJa3qwosxOn
 9qZLNgbzwgeg==
X-IronPort-AV: E=McAfee;i="6000,8403,9939"; a="212177378"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="212177378"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 00:59:48 -0700
IronPort-SDR: aLOedz153PmDqwYsOkJgWhRs4bc/2wotTaHPjnNRtKr0gja1R5bnI/bOHTXFEOf1qV21foKBDU
 6J1zyo/z/8oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="516776708"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 Mar 2021 00:59:47 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lRVlS-0005kg-Di; Wed, 31 Mar 2021 07:59:46 +0000
Date:   Wed, 31 Mar 2021 15:59:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 506a524e05e240d2878cf86a56c47e72e09d329f
Message-ID: <60642bd7./m2WooV6CS58fgIS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 506a524e05e240d2878cf86a56c47e72e09d329f  Merge branches 'acpi-scan' and 'acpi-processor-fixes' into linux-next

Warning reports:

https://lore.kernel.org/linux-acpi/202103310719.fEFGj0lc-lkp@intel.com
https://lore.kernel.org/linux-acpi/202103310741.YpByfbnj-lkp@intel.com

Warning in current branch:

drivers/acpi/processor_idle.c:542:15: warning: extra tokens at end of #ifdef directive
drivers/acpi/processor_idle.c:546:15: warning: extra tokens at end of #ifdef directive
drivers/acpi/processor_idle.c:546:15: warning: extra tokens at end of #ifdef directive [-Wextra-tokens]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- ia64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:extra-tokens-at-end-of-ifdef-directive
|-- ia64-allyesconfig
|   `-- drivers-acpi-processor_idle.c:warning:extra-tokens-at-end-of-ifdef-directive
|-- x86_64-allmodconfig
|   `-- drivers-acpi-processor_idle.c:warning:extra-tokens-at-end-of-ifdef-directive
`-- x86_64-randconfig-s022-20210330
    `-- drivers-acpi-processor_idle.c:warning:extra-tokens-at-end-of-ifdef-directive

clang_recent_errors
`-- x86_64-randconfig-a012-20210330
    `-- drivers-acpi-processor_idle.c:warning:extra-tokens-at-end-of-ifdef-directive

elapsed time: 723m

configs tested: 128
configs skipped: 4

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
mips                           gcw0_defconfig
powerpc                        warp_defconfig
powerpc                     kmeter1_defconfig
mips                           ip22_defconfig
powerpc                 mpc837x_rdb_defconfig
nios2                         3c120_defconfig
xtensa                    xip_kc705_defconfig
openrisc                            defconfig
mips                           rs90_defconfig
arm                         s3c2410_defconfig
mips                         db1xxx_defconfig
arm                        cerfcube_defconfig
arm                           tegra_defconfig
sh                              ul2_defconfig
arm                        neponset_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                         virt_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
arm                          gemini_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                        fsp2_defconfig
arc                              alldefconfig
ia64                      gensparse_defconfig
sh                          sdk7780_defconfig
m68k                          amiga_defconfig
sh                               j2_defconfig
arm                        magician_defconfig
arm                          exynos_defconfig
h8300                               defconfig
arm                     am200epdkit_defconfig
sh                           se7343_defconfig
ia64                            zx1_defconfig
parisc                           allyesconfig
mips                         cobalt_defconfig
powerpc                     pq2fads_defconfig
powerpc                      obs600_defconfig
mips                        bcm47xx_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                      ppc44x_defconfig
nios2                               defconfig
mips                            ar7_defconfig
mips                     cu1000-neo_defconfig
sparc                       sparc64_defconfig
sh                           se7619_defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                      arches_defconfig
mips                        qi_lb60_defconfig
mips                malta_kvm_guest_defconfig
powerpc                       ebony_defconfig
sh                            migor_defconfig
mips                       lemote2f_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210330
x86_64               randconfig-a003-20210330
x86_64               randconfig-a002-20210330
x86_64               randconfig-a001-20210330
x86_64               randconfig-a005-20210330
x86_64               randconfig-a006-20210330
i386                 randconfig-a004-20210330
i386                 randconfig-a006-20210330
i386                 randconfig-a003-20210330
i386                 randconfig-a002-20210330
i386                 randconfig-a001-20210330
i386                 randconfig-a005-20210330
i386                 randconfig-a015-20210330
i386                 randconfig-a011-20210330
i386                 randconfig-a014-20210330
i386                 randconfig-a013-20210330
i386                 randconfig-a016-20210330
i386                 randconfig-a012-20210330
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
x86_64               randconfig-a012-20210330
x86_64               randconfig-a015-20210330
x86_64               randconfig-a014-20210330
x86_64               randconfig-a016-20210330
x86_64               randconfig-a013-20210330
x86_64               randconfig-a011-20210330

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
