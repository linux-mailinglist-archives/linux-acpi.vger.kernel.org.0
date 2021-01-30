Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A78309396
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Jan 2021 10:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhA3Jmw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 30 Jan 2021 04:42:52 -0500
Received: from mga09.intel.com ([134.134.136.24]:13355 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230168AbhA3JkJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 30 Jan 2021 04:40:09 -0500
IronPort-SDR: ldOyrqH71DKdub8IpEFEBUrvJc44zqWgIUycb/xnbOqX4wG4n7Ajk0vU9UHnoY5HI5oql70Byn
 x3ocaOQYDz3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9879"; a="180656007"
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="180656007"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2021 22:59:54 -0800
IronPort-SDR: ppu7VpAmIDKtzn7aP7tHzRr/sj0d6JFiDwSTqa1T4IiO3nu6oOWEyswWFDs1MS94WZoclYIuRi
 QlvbSD1sk2cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,387,1602572400"; 
   d="scan'208";a="404774942"
Received: from lkp-server02.sh.intel.com (HELO 625d3a354f04) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Jan 2021 22:59:53 -0800
Received: from kbuild by 625d3a354f04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l5kEa-0004MF-IK; Sat, 30 Jan 2021 06:59:52 +0000
Date:   Sat, 30 Jan 2021 14:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 e86d494782b7e43504b343d37b88c5c1d7af9ff6
Message-ID: <601503d0.mNkS62LRsk+LcCq4%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e86d494782b7e43504b343d37b88c5c1d7af9ff6  Merge branch 'pnp' into linux-next

elapsed time: 724m

configs tested: 128
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
nios2                         3c120_defconfig
powerpc                     tqm5200_defconfig
arm                             rpc_defconfig
mips                    maltaup_xpa_defconfig
powerpc                     tqm8540_defconfig
sh                        edosk7705_defconfig
arm                       imx_v4_v5_defconfig
riscv                             allnoconfig
m68k                           sun3_defconfig
riscv                            allmodconfig
arm                  colibri_pxa300_defconfig
x86_64                           allyesconfig
powerpc                 mpc8315_rdb_defconfig
arm                             pxa_defconfig
arm                       omap2plus_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                         lubbock_defconfig
microblaze                          defconfig
xtensa                  cadence_csp_defconfig
mips                         rt305x_defconfig
sh                          kfr2r09_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                      jornada720_defconfig
arc                          axs101_defconfig
powerpc                 mpc8540_ads_defconfig
sh                               j2_defconfig
arm                          ep93xx_defconfig
sh                        dreamcast_defconfig
sh                          rsk7203_defconfig
arm                      tct_hammer_defconfig
powerpc                    mvme5100_defconfig
sh                           se7712_defconfig
c6x                        evmc6474_defconfig
arm                         shannon_defconfig
mips                      pistachio_defconfig
arm                        multi_v5_defconfig
mips                          ath79_defconfig
sh                           se7721_defconfig
mips                     cu1830-neo_defconfig
xtensa                    xip_kc705_defconfig
powerpc                      walnut_defconfig
sh                             sh03_defconfig
arc                        nsim_700_defconfig
sh                         ecovec24_defconfig
xtensa                         virt_defconfig
powerpc                    amigaone_defconfig
mips                      pic32mzda_defconfig
powerpc                     asp8347_defconfig
sh                   sh7770_generic_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
arc                              allyesconfig
c6x                              allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210130
i386                 randconfig-a003-20210130
i386                 randconfig-a002-20210130
i386                 randconfig-a001-20210130
i386                 randconfig-a004-20210130
i386                 randconfig-a006-20210130
i386                 randconfig-a013-20210130
i386                 randconfig-a011-20210130
i386                 randconfig-a015-20210130
i386                 randconfig-a012-20210130
i386                 randconfig-a014-20210130
i386                 randconfig-a016-20210130
x86_64               randconfig-a004-20210130
x86_64               randconfig-a002-20210130
x86_64               randconfig-a001-20210130
x86_64               randconfig-a005-20210130
x86_64               randconfig-a006-20210130
x86_64               randconfig-a003-20210130
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                                   rhel
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20210130
x86_64               randconfig-a011-20210130
x86_64               randconfig-a014-20210130
x86_64               randconfig-a016-20210130
x86_64               randconfig-a012-20210130
x86_64               randconfig-a013-20210130
x86_64               randconfig-a012-20210129
x86_64               randconfig-a015-20210129
x86_64               randconfig-a016-20210129
x86_64               randconfig-a011-20210129
x86_64               randconfig-a013-20210129
x86_64               randconfig-a014-20210129

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
