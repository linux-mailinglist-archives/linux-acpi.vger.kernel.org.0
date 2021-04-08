Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0135357BE7
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Apr 2021 07:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhDHFjS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Apr 2021 01:39:18 -0400
Received: from mga02.intel.com ([134.134.136.20]:64087 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhDHFjR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Apr 2021 01:39:17 -0400
IronPort-SDR: vg0MGdxmp6K2nLB3ANC+pcn9/ZnptgBGFJ8l8liEL1AwjVACluslsIc7ucx3ctxkB0qtcAGNs1
 s3TzS33+RbVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="180596689"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="180596689"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 22:38:59 -0700
IronPort-SDR: ytLxkecBTKztSVfHVgmK3wQ4FQRnCLXmnBMUpAaPKmAKq5UKUUVw0fNp7VqcBbx/WMsD0k1B+G
 78Szhl7Q4ZMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="441605368"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 07 Apr 2021 22:38:58 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lUNNZ-000ELD-Dw; Thu, 08 Apr 2021 05:38:57 +0000
Date:   Thu, 08 Apr 2021 13:37:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 d68e242804c977189801d2675b53d3eddfd7d818
Message-ID: <606e96b4.d5MT9yrSH5aMrs0V%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d68e242804c977189801d2675b53d3eddfd7d818  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 729m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
x86_64                           allyesconfig
mips                           ip28_defconfig
arm                         lpc18xx_defconfig
sh                               alldefconfig
powerpc               mpc834x_itxgp_defconfig
sh                             espt_defconfig
powerpc                     mpc5200_defconfig
arm                       omap2plus_defconfig
arm                        mvebu_v7_defconfig
arm                        neponset_defconfig
powerpc                      chrp32_defconfig
arm                         axm55xx_defconfig
sh                          kfr2r09_defconfig
mips                      fuloong2e_defconfig
arm                            pleb_defconfig
sh                        sh7757lcr_defconfig
powerpc                       maple_defconfig
arm                        shmobile_defconfig
mips                        maltaup_defconfig
riscv             nommu_k210_sdcard_defconfig
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
i386                 randconfig-a006-20210407
i386                 randconfig-a003-20210407
i386                 randconfig-a001-20210407
i386                 randconfig-a004-20210407
i386                 randconfig-a002-20210407
i386                 randconfig-a005-20210407
x86_64               randconfig-a014-20210407
x86_64               randconfig-a015-20210407
x86_64               randconfig-a013-20210407
x86_64               randconfig-a011-20210407
x86_64               randconfig-a012-20210407
x86_64               randconfig-a016-20210407
i386                 randconfig-a014-20210407
i386                 randconfig-a011-20210407
i386                 randconfig-a016-20210407
i386                 randconfig-a012-20210407
i386                 randconfig-a015-20210407
i386                 randconfig-a013-20210407
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
