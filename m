Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89304368ACD
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236468AbhDWB40 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 21:56:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:19896 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236141AbhDWB40 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 21:56:26 -0400
IronPort-SDR: wDeU4bvVXjTNvWRx8qpYqPIJe7VOsc6Ik/xivxyQUMDq2n1MjIiBl8R2wq0fbjpnM3zmUuQhb8
 riBdRmiFrYpw==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="183132578"
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="183132578"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 18:55:50 -0700
IronPort-SDR: 1U74NBZ4Qs6fnYuQz9QjZJS44FrL0tGp8De7xs3R6A+GPS73SHioUJ/5MoFK5vlLMnWsROT2v2
 jHRxnRFVqiSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,244,1613462400"; 
   d="scan'208";a="453442702"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2021 18:55:49 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lZl2q-0004Si-Ii; Fri, 23 Apr 2021 01:55:48 +0000
Date:   Fri, 23 Apr 2021 09:55:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 07ca763aa24938bc9d16edae9174df3edfe20ef0
Message-ID: <6082290c.8tE3XiqQkHFyfVke%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 07ca763aa24938bc9d16edae9174df3edfe20ef0  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 724m

configs tested: 96
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
arm                      footbridge_defconfig
h8300                    h8300h-sim_defconfig
xtensa                              defconfig
powerpc                  iss476-smp_defconfig
powerpc                       maple_defconfig
arm                       aspeed_g5_defconfig
m68k                       m5275evb_defconfig
xtensa                  audio_kc705_defconfig
arc                     nsimosci_hs_defconfig
sh                          kfr2r09_defconfig
sh                        sh7763rdp_defconfig
csky                             alldefconfig
powerpc                     kmeter1_defconfig
powerpc                         ps3_defconfig
mips                            ar7_defconfig
arm                           stm32_defconfig
s390                             alldefconfig
ia64                         bigsur_defconfig
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
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210421
x86_64               randconfig-a002-20210421
x86_64               randconfig-a001-20210421
x86_64               randconfig-a005-20210421
x86_64               randconfig-a006-20210421
x86_64               randconfig-a003-20210421
i386                 randconfig-a005-20210421
i386                 randconfig-a002-20210421
i386                 randconfig-a001-20210421
i386                 randconfig-a006-20210421
i386                 randconfig-a004-20210421
i386                 randconfig-a003-20210421
i386                 randconfig-a012-20210421
i386                 randconfig-a014-20210421
i386                 randconfig-a011-20210421
i386                 randconfig-a013-20210421
i386                 randconfig-a015-20210421
i386                 randconfig-a016-20210421
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
x86_64               randconfig-a015-20210421
x86_64               randconfig-a016-20210421
x86_64               randconfig-a011-20210421
x86_64               randconfig-a014-20210421
x86_64               randconfig-a013-20210421
x86_64               randconfig-a012-20210421

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
