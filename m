Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5EA403A15
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Sep 2021 14:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbhIHMoE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Sep 2021 08:44:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:9982 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234005AbhIHMoD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 8 Sep 2021 08:44:03 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10100"; a="242769383"
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="242769383"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2021 05:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,277,1624345200"; 
   d="scan'208";a="524815432"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 08 Sep 2021 05:42:53 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mNwui-00029g-R8; Wed, 08 Sep 2021 12:42:52 +0000
Date:   Wed, 08 Sep 2021 20:42:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 7d0798a20c777f0726d75b686224b15444d491f1
Message-ID: <6138afab.2Dgwf19YXvbB6ciZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 7d0798a20c777f0726d75b686224b15444d491f1  Merge branches 'pm-sleep', 'pm-em', 'pm-cpufreq-next' and 'acpi-scan' into bleeding-edge

elapsed time: 1015m

configs tested: 102
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
i386                 randconfig-c001-20210908
arc                         haps_hs_defconfig
mips                          ath79_defconfig
xtensa                  cadence_csp_defconfig
powerpc                      ppc44x_defconfig
sh                          sdk7780_defconfig
sh                        edosk7760_defconfig
powerpc                     tqm8540_defconfig
arm                         orion5x_defconfig
mips                           ci20_defconfig
mips                      pic32mzda_defconfig
mips                        maltaup_defconfig
arm                       versatile_defconfig
arm                          imote2_defconfig
arm                       netwinder_defconfig
sh                           se7343_defconfig
arm                            dove_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                      maltaaprp_defconfig
x86_64               randconfig-c001-20210908
arm                  randconfig-c002-20210908
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
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
i386                 randconfig-a005-20210906
i386                 randconfig-a004-20210906
i386                 randconfig-a006-20210906
i386                 randconfig-a002-20210906
i386                 randconfig-a003-20210906
i386                 randconfig-a001-20210906
arc                  randconfig-r043-20210906
x86_64               randconfig-a006-20210906
x86_64               randconfig-a004-20210906
x86_64               randconfig-a003-20210906
x86_64               randconfig-a005-20210906
x86_64               randconfig-a001-20210906
x86_64               randconfig-a002-20210906
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a011-20210906
x86_64               randconfig-a016-20210906
x86_64               randconfig-a012-20210906
x86_64               randconfig-a015-20210906
x86_64               randconfig-a014-20210906
x86_64               randconfig-a013-20210906
i386                 randconfig-a012-20210906
i386                 randconfig-a015-20210906
i386                 randconfig-a011-20210906
i386                 randconfig-a013-20210906
i386                 randconfig-a014-20210906
i386                 randconfig-a016-20210906
riscv                randconfig-r042-20210906
hexagon              randconfig-r045-20210906
s390                 randconfig-r044-20210906
hexagon              randconfig-r041-20210906

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
