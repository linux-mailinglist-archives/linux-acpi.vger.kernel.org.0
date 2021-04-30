Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CD736F6C7
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Apr 2021 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhD3H7q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 30 Apr 2021 03:59:46 -0400
Received: from mga07.intel.com ([134.134.136.100]:34385 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhD3H7q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 30 Apr 2021 03:59:46 -0400
IronPort-SDR: Pr8GFpUoe4HVWd76m5dq6uk94Pbp6bCkpbayPoxnyo8Qu7B5SLtEOm9jVNvlkUHrpI3DegGqJB
 G/8pTtoGzp5w==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="261169779"
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="261169779"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 00:58:57 -0700
IronPort-SDR: 9clr2pxJ0ZWxbKfNTkLkHvjS60rM72iieD0CB07obbjDz5lq2C8J/Jw16MrGj8Eseyo9HOxLkp
 kJIjnLI5VuhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,262,1613462400"; 
   d="scan'208";a="616783938"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Apr 2021 00:58:56 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcO35-00084l-Gu; Fri, 30 Apr 2021 07:58:55 +0000
Date:   Fri, 30 Apr 2021 15:58:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 eebece9da63e0050345a10e89cb33d7312c9ec3c
Message-ID: <608bb895.fsqfEdV2vXKjjV9I%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: eebece9da63e0050345a10e89cb33d7312c9ec3c  Merge branches 'acpi-misc' and 'acpi-docs' into linux-next

elapsed time: 722m

configs tested: 141
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
mips                     cu1830-neo_defconfig
nios2                         3c120_defconfig
sh                               j2_defconfig
arm                            hisi_defconfig
x86_64                              defconfig
arm                          ixp4xx_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                      tqm8xx_defconfig
m68k                       m5249evb_defconfig
arm64                            alldefconfig
um                             i386_defconfig
arc                        nsimosci_defconfig
arm                         socfpga_defconfig
mips                         db1xxx_defconfig
sh                         microdev_defconfig
m68k                       bvme6000_defconfig
arm                           tegra_defconfig
powerpc                        icon_defconfig
powerpc                 mpc836x_rdk_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5208evb_defconfig
powerpc                 linkstation_defconfig
arm                       aspeed_g5_defconfig
powerpc                    socrates_defconfig
arm                        mini2440_defconfig
arm                         lpc32xx_defconfig
powerpc                   currituck_defconfig
arm                           viper_defconfig
i386                             alldefconfig
arm                        spear6xx_defconfig
powerpc                          g5_defconfig
arm                           omap1_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                   bluestone_defconfig
csky                                defconfig
powerpc                     ksi8560_defconfig
arm                          simpad_defconfig
ia64                                defconfig
arm                             mxs_defconfig
arm                      pxa255-idp_defconfig
sh                        edosk7705_defconfig
powerpc                 mpc8540_ads_defconfig
sh                        sh7763rdp_defconfig
powerpc                   lite5200b_defconfig
arm                        neponset_defconfig
arc                    vdk_hs38_smp_defconfig
x86_64                           alldefconfig
sh                             shx3_defconfig
mips                        vocore2_defconfig
m68k                            q40_defconfig
arc                              alldefconfig
m68k                        m5272c3_defconfig
openrisc                 simple_smp_defconfig
powerpc                     ppa8548_defconfig
arc                          axs103_defconfig
powerpc                 mpc8272_ads_defconfig
sh                        edosk7760_defconfig
sh                   sh7770_generic_defconfig
sh                            hp6xx_defconfig
arm                          lpd270_defconfig
openrisc                    or1ksim_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
sh                            shmin_defconfig
arm                         s3c2410_defconfig
arm                           sunxi_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a004-20210429
x86_64               randconfig-a002-20210429
x86_64               randconfig-a005-20210429
x86_64               randconfig-a006-20210429
x86_64               randconfig-a001-20210429
x86_64               randconfig-a003-20210429
i386                 randconfig-a005-20210429
i386                 randconfig-a002-20210429
i386                 randconfig-a001-20210429
i386                 randconfig-a006-20210429
i386                 randconfig-a003-20210429
i386                 randconfig-a004-20210429
i386                 randconfig-a012-20210429
i386                 randconfig-a014-20210429
i386                 randconfig-a013-20210429
i386                 randconfig-a011-20210429
i386                 randconfig-a015-20210429
i386                 randconfig-a016-20210429
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
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210429
x86_64               randconfig-a016-20210429
x86_64               randconfig-a011-20210429
x86_64               randconfig-a014-20210429
x86_64               randconfig-a013-20210429
x86_64               randconfig-a012-20210429

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
