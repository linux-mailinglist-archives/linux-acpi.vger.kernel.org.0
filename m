Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6EC36BDA9
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 05:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhD0DPF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 23:15:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:56971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231363AbhD0DPF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 26 Apr 2021 23:15:05 -0400
IronPort-SDR: XB0Lk4HYHJ9n/DWWc8O4foElvt8AyIFCYOG7k2aupFyuKD2BUvxJhaCnxIodQNH/eGGdazhvnv
 deK6pLn0ZbOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9966"; a="176556810"
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="176556810"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2021 20:14:22 -0700
IronPort-SDR: JIbvIJWJn2kpTmy7LV+AeFCDsP5ojIMAnuioAW7Cb0vXE2iDtejz1T0xGj4T6MCm978UZY9316
 y5a+GouNGKLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,252,1613462400"; 
   d="scan'208";a="465332174"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Apr 2021 20:14:20 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lbEB2-0006FH-7z; Tue, 27 Apr 2021 03:14:20 +0000
Date:   Tue, 27 Apr 2021 11:14:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 3c44d15e5ffdbc1b9d31d098b65c5cb50211d802
Message-ID: <60878185.fxFzWu9O6pKSBDvQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3c44d15e5ffdbc1b9d31d098b65c5cb50211d802  Merge branch 'pm-sleep' into linux-next

elapsed time: 720m

configs tested: 160
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                            allyesconfig
riscv                            allmodconfig
x86_64                           allyesconfig
i386                             allyesconfig
riscv                            allyesconfig
arm                     eseries_pxa_defconfig
um                             i386_defconfig
sh                            shmin_defconfig
ia64                            zx1_defconfig
sh                            hp6xx_defconfig
mips                         tb0287_defconfig
sh                          rsk7264_defconfig
mips                     decstation_defconfig
powerpc                   currituck_defconfig
powerpc                     tqm8548_defconfig
arm                       imx_v4_v5_defconfig
mips                         tb0219_defconfig
arm                           u8500_defconfig
parisc                generic-64bit_defconfig
powerpc                          g5_defconfig
mips                     loongson1c_defconfig
sparc64                             defconfig
sh                           se7343_defconfig
mips                malta_kvm_guest_defconfig
arm                       aspeed_g4_defconfig
sh                          sdk7780_defconfig
arm                      pxa255-idp_defconfig
mips                      fuloong2e_defconfig
arm                         mv78xx0_defconfig
sparc                       sparc32_defconfig
sh                           se7705_defconfig
s390                                defconfig
sh                           sh2007_defconfig
sh                     sh7710voipgw_defconfig
powerpc                     kilauea_defconfig
m68k                          multi_defconfig
powerpc                     powernv_defconfig
arm                       aspeed_g5_defconfig
sh                             shx3_defconfig
sh                          r7780mp_defconfig
sparc                            alldefconfig
mips                       lemote2f_defconfig
xtensa                  cadence_csp_defconfig
sh                           se7206_defconfig
powerpc                    socrates_defconfig
sh                           se7712_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc834x_mds_defconfig
arm                            lart_defconfig
arm                            xcep_defconfig
mips                             allmodconfig
sh                            migor_defconfig
arm                      tct_hammer_defconfig
powerpc                      makalu_defconfig
xtensa                generic_kc705_defconfig
sh                          polaris_defconfig
openrisc                            defconfig
arc                        nsimosci_defconfig
xtensa                  nommu_kc705_defconfig
arc                              allyesconfig
ia64                                defconfig
arc                           tb10x_defconfig
powerpc                      pmac32_defconfig
arm                            qcom_defconfig
arm                         at91_dt_defconfig
mips                        nlm_xlr_defconfig
arc                    vdk_hs38_smp_defconfig
sh                   secureedge5410_defconfig
mips                         mpc30x_defconfig
powerpc                     stx_gp3_defconfig
arm                          pxa168_defconfig
m68k                          amiga_defconfig
mips                            ar7_defconfig
riscv                            alldefconfig
arm                            hisi_defconfig
arm                          ixp4xx_defconfig
powerpc                    sam440ep_defconfig
powerpc                      chrp32_defconfig
powerpc                      pasemi_defconfig
mips                            gpr_defconfig
xtensa                              defconfig
powerpc                         ps3_defconfig
arm                         axm55xx_defconfig
powerpc                     tqm8555_defconfig
sh                         ap325rxa_defconfig
arm                       spear13xx_defconfig
mips                     loongson1b_defconfig
arm                             mxs_defconfig
sh                          r7785rp_defconfig
arm                          ep93xx_defconfig
sh                          rsk7201_defconfig
ia64                             allmodconfig
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
s390                             allmodconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20210426
i386                 randconfig-a002-20210426
i386                 randconfig-a001-20210426
i386                 randconfig-a006-20210426
i386                 randconfig-a004-20210426
i386                 randconfig-a003-20210426
x86_64               randconfig-a015-20210426
x86_64               randconfig-a016-20210426
x86_64               randconfig-a011-20210426
x86_64               randconfig-a014-20210426
x86_64               randconfig-a012-20210426
x86_64               randconfig-a013-20210426
i386                 randconfig-a014-20210426
i386                 randconfig-a012-20210426
i386                 randconfig-a011-20210426
i386                 randconfig-a013-20210426
i386                 randconfig-a015-20210426
i386                 randconfig-a016-20210426
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
x86_64               randconfig-a002-20210426
x86_64               randconfig-a004-20210426
x86_64               randconfig-a001-20210426
x86_64               randconfig-a006-20210426
x86_64               randconfig-a005-20210426
x86_64               randconfig-a003-20210426

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
