Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8A92DD1A6
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Dec 2020 13:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgLQMn7 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Dec 2020 07:43:59 -0500
Received: from mga05.intel.com ([192.55.52.43]:51318 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbgLQMnz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Dec 2020 07:43:55 -0500
IronPort-SDR: FJKh6Ko7tfMb2rat8wE45R2cDQkaI8+X9ykh10QmWpjTMtIA1qk9bytNQNh8m7xxxVh07HOcUd
 C4eZffEj/wHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="259968551"
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="259968551"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2020 04:43:14 -0800
IronPort-SDR: pF/DtvoHNbRMFe/po6ctXEkJkEqrWucIB9e1xHPTB5YkEVdP4icQePG1fk5mzmi21K2VsOya6i
 Izc7D4t25D8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,428,1599548400"; 
   d="scan'208";a="353236494"
Received: from lkp-server02.sh.intel.com (HELO 070e1a605002) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 Dec 2020 04:43:12 -0800
Received: from kbuild by 070e1a605002 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kpsci-0001Bq-9g; Thu, 17 Dec 2020 12:43:12 +0000
Date:   Thu, 17 Dec 2020 20:42:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 73b0a2fc40a024992e122124ae8f0422594c78a7
Message-ID: <5fdb5240.SPgo4D6LT33VD97k%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 73b0a2fc40a024992e122124ae8f0422594c78a7  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 726m

configs tested: 120
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     akebono_defconfig
mips                         tb0219_defconfig
powerpc                    klondike_defconfig
mips                          rm200_defconfig
mips                            gpr_defconfig
ia64                             allmodconfig
c6x                                 defconfig
mips                        jmr3927_defconfig
arm                       versatile_defconfig
arm                        magician_defconfig
xtensa                  nommu_kc705_defconfig
mips                           ip28_defconfig
powerpc                    socrates_defconfig
x86_64                           alldefconfig
arm                         assabet_defconfig
sh                           se7619_defconfig
mips                         rt305x_defconfig
arm                            zeus_defconfig
arc                        vdk_hs38_defconfig
sh                          rsk7264_defconfig
powerpc                      katmai_defconfig
powerpc                 mpc834x_mds_defconfig
arm                         shannon_defconfig
powerpc                 mpc8560_ads_defconfig
sh                            shmin_defconfig
arm                           tegra_defconfig
mips                      loongson3_defconfig
arm                         hackkit_defconfig
powerpc                      pcm030_defconfig
mips                     decstation_defconfig
arm                             ezx_defconfig
mips                        vocore2_defconfig
mips                           ip22_defconfig
powerpc                   motionpro_defconfig
powerpc                       maple_defconfig
xtensa                generic_kc705_defconfig
powerpc                       eiger_defconfig
arm                         s3c2410_defconfig
microblaze                      mmu_defconfig
arm                             pxa_defconfig
powerpc                   bluestone_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
arm                      footbridge_defconfig
arm                        mini2440_defconfig
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
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
x86_64               randconfig-a003-20201217
x86_64               randconfig-a006-20201217
x86_64               randconfig-a002-20201217
x86_64               randconfig-a005-20201217
x86_64               randconfig-a004-20201217
x86_64               randconfig-a001-20201217
i386                 randconfig-a001-20201217
i386                 randconfig-a004-20201217
i386                 randconfig-a003-20201217
i386                 randconfig-a002-20201217
i386                 randconfig-a006-20201217
i386                 randconfig-a005-20201217
i386                 randconfig-a014-20201217
i386                 randconfig-a013-20201217
i386                 randconfig-a012-20201217
i386                 randconfig-a011-20201217
i386                 randconfig-a015-20201217
i386                 randconfig-a016-20201217
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
x86_64               randconfig-a016-20201217
x86_64               randconfig-a012-20201217
x86_64               randconfig-a013-20201217
x86_64               randconfig-a015-20201217
x86_64               randconfig-a014-20201217
x86_64               randconfig-a011-20201217

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
