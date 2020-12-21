Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 784822E023E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Dec 2020 22:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbgLUV7V (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 21 Dec 2020 16:59:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:13441 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgLUV7V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 21 Dec 2020 16:59:21 -0500
IronPort-SDR: BLD+p4FhCNuJ/+WM8TIL2RNNarbCRBotCdvofFR7Txc26+KLSFiduNYjL7WWh26KBOXX4S76yS
 GYLwzqKvAI/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9842"; a="175936822"
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="175936822"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 13:58:39 -0800
IronPort-SDR: mSZJFdvGkE8sUE3M97hsklyXP6oe/ToH1TpvCj7w+qFqLksp3CbZH2B0E7QMRdpHEbA9gnvQsm
 /DutovF4aKfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,437,1599548400"; 
   d="scan'208";a="396533088"
Received: from lkp-server01.sh.intel.com (HELO 65587561063d) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Dec 2020 13:58:37 -0800
Received: from kbuild by 65587561063d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1krTCO-00017b-VF; Mon, 21 Dec 2020 21:58:36 +0000
Date:   Tue, 22 Dec 2020 05:58:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 7e946849977d59d3e6c0b3112da6a36757051bc7
Message-ID: <5fe11a7c.SVNV1lvSlZrvFHtY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 7e946849977d59d3e6c0b3112da6a36757051bc7  Merge branch 'acpi-sleep' into linux-next

Warning reports:

https://lore.kernel.org/linux-acpi/202012180806.uUcdy2LC-lkp@intel.com
https://lore.kernel.org/linux-acpi/202012220413.PaYA4ruj-lkp@intel.com

Warning in current branch:

drivers/acpi/x86/s2idle.c:108:30: warning: variable 'info' set but not used [-Wunused-but-set-variable]
drivers/acpi/x86/s2idle.c:138:25: warning: variable 'obj_new' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-defconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a012-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a013-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a014-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-a016-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-c001-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-m021-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- i386-randconfig-s001-20201221
|   `-- drivers-acpi-x86-s2idle.c:sparse:sparse:restricted-suspend_state_t-degrades-to-integer
|-- x86_64-allmodconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-allyesconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-defconfig
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-kexec
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-randconfig-s021-20201221
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel-7.6-kselftests
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
|-- x86_64-rhel-8.3
|   |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
|   `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used
`-- x86_64-rhel-8.3-kbuiltin
    |-- drivers-acpi-x86-s2idle.c:warning:variable-info-set-but-not-used
    `-- drivers-acpi-x86-s2idle.c:warning:variable-obj_new-set-but-not-used

elapsed time: 723m

configs tested: 111
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       imx_v4_v5_defconfig
nios2                         3c120_defconfig
sh                   sh7724_generic_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
arm                     am200epdkit_defconfig
powerpc                 mpc832x_mds_defconfig
arm                           u8500_defconfig
mips                       capcella_defconfig
mips                            e55_defconfig
sh                        sh7757lcr_defconfig
arc                          axs103_defconfig
sh                        sh7763rdp_defconfig
powerpc                      acadia_defconfig
powerpc                    mvme5100_defconfig
arm                           omap1_defconfig
s390                             alldefconfig
c6x                        evmc6474_defconfig
h8300                     edosk2674_defconfig
mips                      malta_kvm_defconfig
mips                         tb0287_defconfig
openrisc                            defconfig
arm                          ep93xx_defconfig
c6x                              alldefconfig
sh                  sh7785lcr_32bit_defconfig
sh                                  defconfig
powerpc                 mpc8560_ads_defconfig
c6x                         dsk6455_defconfig
sh                           se7721_defconfig
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
i386                 randconfig-a002-20201221
i386                 randconfig-a005-20201221
i386                 randconfig-a006-20201221
i386                 randconfig-a004-20201221
i386                 randconfig-a003-20201221
i386                 randconfig-a001-20201221
i386                 randconfig-a005-20201222
i386                 randconfig-a002-20201222
i386                 randconfig-a006-20201222
i386                 randconfig-a004-20201222
i386                 randconfig-a003-20201222
i386                 randconfig-a001-20201222
i386                 randconfig-a011-20201221
i386                 randconfig-a016-20201221
i386                 randconfig-a014-20201221
i386                 randconfig-a012-20201221
i386                 randconfig-a015-20201221
i386                 randconfig-a013-20201221
x86_64               randconfig-a001-20201221
x86_64               randconfig-a006-20201221
x86_64               randconfig-a002-20201221
x86_64               randconfig-a004-20201221
x86_64               randconfig-a003-20201221
x86_64               randconfig-a005-20201221
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
x86_64               randconfig-a015-20201221
x86_64               randconfig-a014-20201221
x86_64               randconfig-a016-20201221
x86_64               randconfig-a012-20201221
x86_64               randconfig-a013-20201221
x86_64               randconfig-a011-20201221

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
