Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F552A3C21
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Nov 2020 06:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgKCFnS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Nov 2020 00:43:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:46407 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgKCFnS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 3 Nov 2020 00:43:18 -0500
IronPort-SDR: 5tplrrvHr/8l5DpYqcKKIofzYwGS5dj2p5AimmiOHzHEpY+0c+a9HpuIvL/2/GjMseU9KTanba
 8po5Rr74vXRQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="165498735"
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="165498735"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 21:43:18 -0800
IronPort-SDR: q7TZnBerEMMFCCgOrnWI0bZEMTGESRAx/Vv0RUBP77VX3uRP+7jhSDf0+HOTzkThTbCHFg+WSU
 a+25FRJml7qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,447,1596524400"; 
   d="scan'208";a="526938734"
Received: from lkp-server02.sh.intel.com (HELO e61783667810) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 02 Nov 2020 21:43:16 -0800
Received: from kbuild by e61783667810 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZp6C-000037-3X; Tue, 03 Nov 2020 05:43:16 +0000
Date:   Tue, 03 Nov 2020 13:42:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 b5d7c2d02f9915dcecf7ffa3b7d25cc01368465a
Message-ID: <5fa0edce.69RZlbbqrc+NFjb/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: b5d7c2d02f9915dcecf7ffa3b7d25cc01368465a  Merge branch 'pm-cpufreq-next' into bleeding-edge

elapsed time: 723m

configs tested: 93
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm                    vt8500_v6_v7_defconfig
powerpc                    amigaone_defconfig
arm                        spear6xx_defconfig
arm                            mmp2_defconfig
ia64                        generic_defconfig
mips                    maltaup_xpa_defconfig
xtensa                generic_kc705_defconfig
powerpc                      obs600_defconfig
sh                   sh7770_generic_defconfig
powerpc                 mpc837x_mds_defconfig
sh                           se7206_defconfig
arm                      tct_hammer_defconfig
m68k                       m5208evb_defconfig
microblaze                      mmu_defconfig
arm                          pxa3xx_defconfig
mips                      fuloong2e_defconfig
sh                          sdk7780_defconfig
arm                       cns3420vb_defconfig
arm                  colibri_pxa270_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201102
i386                 randconfig-a006-20201102
i386                 randconfig-a005-20201102
i386                 randconfig-a001-20201102
i386                 randconfig-a002-20201102
i386                 randconfig-a003-20201102
x86_64               randconfig-a012-20201102
x86_64               randconfig-a015-20201102
x86_64               randconfig-a011-20201102
x86_64               randconfig-a013-20201102
x86_64               randconfig-a014-20201102
x86_64               randconfig-a016-20201102
i386                 randconfig-a013-20201102
i386                 randconfig-a015-20201102
i386                 randconfig-a014-20201102
i386                 randconfig-a016-20201102
i386                 randconfig-a011-20201102
i386                 randconfig-a012-20201102
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201102
x86_64               randconfig-a005-20201102
x86_64               randconfig-a003-20201102
x86_64               randconfig-a002-20201102
x86_64               randconfig-a006-20201102
x86_64               randconfig-a001-20201102

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
