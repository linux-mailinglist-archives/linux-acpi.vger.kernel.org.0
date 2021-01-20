Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6F2FCCD6
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Jan 2021 09:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbhATIgo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 Jan 2021 03:36:44 -0500
Received: from mga11.intel.com ([192.55.52.93]:28427 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731037AbhATIcq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Jan 2021 03:32:46 -0500
IronPort-SDR: vZUA+MwwUQ3XK4Lfoig9Y+p3jz0U8czDaMEC4LaEfCkIx2ywE6JGWUiXMcDtk2Jte1wzvlAKYc
 fiXWRuAhhseQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="175563402"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="175563402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 00:32:01 -0800
IronPort-SDR: Q/5gFqjj8WVHygQrcpWUC87/5ltNkSgngrJJb7HPNiLWDTzgTGSv7pg0hVix/fnY7666pKEEsF
 zK0sVbtv6rAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="366169984"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Jan 2021 00:31:59 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l28uF-0005hW-9m; Wed, 20 Jan 2021 08:31:59 +0000
Date:   Wed, 20 Jan 2021 16:31:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 f2d717f48fb25785d65f740bf2425bb3ce5cce44
Message-ID: <6007ea62.jSePxiLME1D20RPZ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f2d717f48fb25785d65f740bf2425bb3ce5cce44  Merge branch 'pm-clk' into bleeding-edge

elapsed time: 726m

configs tested: 97
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      pmac32_defconfig
mips                           ci20_defconfig
arm                           sunxi_defconfig
mips                        bcm63xx_defconfig
powerpc                  iss476-smp_defconfig
mips                malta_kvm_guest_defconfig
m68k                         amcore_defconfig
mips                  decstation_64_defconfig
ia64                            zx1_defconfig
sh                              ul2_defconfig
sh                           se7721_defconfig
mips                     loongson1b_defconfig
mips                           jazz_defconfig
mips                        omega2p_defconfig
powerpc                 canyonlands_defconfig
nds32                            alldefconfig
xtensa                    xip_kc705_defconfig
sh                           se7724_defconfig
arm                          pcm027_defconfig
sh                   secureedge5410_defconfig
mips                       lemote2f_defconfig
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
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
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
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
