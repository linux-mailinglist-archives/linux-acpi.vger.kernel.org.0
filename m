Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE45734880A
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Mar 2021 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYEqA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 25 Mar 2021 00:46:00 -0400
Received: from mga18.intel.com ([134.134.136.126]:38728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhCYEpb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Mar 2021 00:45:31 -0400
IronPort-SDR: 13RJnqaA7wccRPjd9PHDQeIcikdda60K1yD7WpFw9bcFPph+Bang3pnLiuiWPp7ApKxxjSqdhR
 cDSZeVjv94zA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="178402975"
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="178402975"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 21:45:29 -0700
IronPort-SDR: YuSKM3978AlVgPTFFiIulu+pEQJXd3ZEZkKmk7EcbyaeEdod9stFrUwEmyCelhJ8jJKquL2J4H
 efbI0R+fv2qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,276,1610438400"; 
   d="scan'208";a="414028665"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2021 21:45:28 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lPHs7-0001kk-AC; Thu, 25 Mar 2021 04:45:27 +0000
Date:   Thu, 25 Mar 2021 12:44:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 4418cf015150057d48231fa98b51cb962bae7767
Message-ID: <605c1544.KELa9kI6bnyujFUr%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4418cf015150057d48231fa98b51cb962bae7767  Merge branch 'acpi-tables' into bleeding-edge

elapsed time: 755m

configs tested: 93
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
riscv                            allmodconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                      tct_hammer_defconfig
arm                             mxs_defconfig
sh                            titan_defconfig
arc                    vdk_hs38_smp_defconfig
mips                 decstation_r4k_defconfig
powerpc                     pseries_defconfig
mips                        jmr3927_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc834x_mds_defconfig
m68k                          multi_defconfig
arc                     haps_hs_smp_defconfig
m68k                       m5475evb_defconfig
powerpc                    klondike_defconfig
arm                     am200epdkit_defconfig
mips                       bmips_be_defconfig
arm                           h5000_defconfig
mips                     cu1000-neo_defconfig
arm                          pxa168_defconfig
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
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20210324
i386                 randconfig-a003-20210324
i386                 randconfig-a001-20210324
i386                 randconfig-a002-20210324
i386                 randconfig-a006-20210324
i386                 randconfig-a005-20210324
x86_64               randconfig-a012-20210324
x86_64               randconfig-a015-20210324
x86_64               randconfig-a014-20210324
x86_64               randconfig-a013-20210324
x86_64               randconfig-a016-20210324
x86_64               randconfig-a011-20210324
i386                 randconfig-a014-20210324
i386                 randconfig-a011-20210324
i386                 randconfig-a015-20210324
i386                 randconfig-a016-20210324
i386                 randconfig-a013-20210324
i386                 randconfig-a012-20210324
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a002-20210324
x86_64               randconfig-a003-20210324
x86_64               randconfig-a001-20210324
x86_64               randconfig-a006-20210324
x86_64               randconfig-a005-20210324
x86_64               randconfig-a004-20210324

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
