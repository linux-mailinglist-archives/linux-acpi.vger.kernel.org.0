Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A970D3705E5
	for <lists+linux-acpi@lfdr.de>; Sat,  1 May 2021 08:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhEAGdj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 1 May 2021 02:33:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:46155 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhEAGdj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 1 May 2021 02:33:39 -0400
IronPort-SDR: gcULoz8qdRbFIWm/8iojUfhEpNTOBIUzcyI4jgH5vvVqBX0/FzWq4zJNoUlxsknTSUHUL1rrC9
 r5kBy4F9tBiA==
X-IronPort-AV: E=McAfee;i="6200,9189,9970"; a="261379219"
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="261379219"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2021 23:32:48 -0700
IronPort-SDR: qt/YbPnbW/g8Grf9zf8scoQX9cSgEgXmMbFqil4N72+tZhl2JfwbeDweSA3HWoksgA1noQT9CU
 18y5NqdghUhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,264,1613462400"; 
   d="scan'208";a="404869519"
Received: from lkp-server01.sh.intel.com (HELO a48ff7ddd223) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 30 Apr 2021 23:32:46 -0700
Received: from kbuild by a48ff7ddd223 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lcjBF-0008Sk-Ks; Sat, 01 May 2021 06:32:45 +0000
Date:   Sat, 01 May 2021 14:31:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 1f348871f80e24c62f1119ceb3e97eafd3f57143
Message-ID: <608cf5d8.5LMxTk79i8IxbmTn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1f348871f80e24c62f1119ceb3e97eafd3f57143  Merge branch 'acpi-pm' into linux-next

elapsed time: 721m

configs tested: 142
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
mips                     loongson1b_defconfig
powerpc                     rainier_defconfig
mips                       capcella_defconfig
arm                  colibri_pxa270_defconfig
sh                 kfr2r09-romimage_defconfig
arm                            lart_defconfig
microblaze                      mmu_defconfig
arm                       spear13xx_defconfig
arm                        shmobile_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     tqm8560_defconfig
sh                           se7780_defconfig
arc                              allyesconfig
arm                            hisi_defconfig
sh                           se7343_defconfig
arc                        nsimosci_defconfig
sh                           se7750_defconfig
powerpc                    ge_imp3a_defconfig
ia64                        generic_defconfig
powerpc                      bamboo_defconfig
arm                        oxnas_v6_defconfig
mips                         rt305x_defconfig
powerpc                      katmai_defconfig
m68k                       m5275evb_defconfig
h8300                            allyesconfig
arm                      pxa255-idp_defconfig
arm                        cerfcube_defconfig
xtensa                       common_defconfig
arm                          pxa910_defconfig
m68k                          multi_defconfig
arm                          imote2_defconfig
powerpc                         ps3_defconfig
powerpc                     tqm8541_defconfig
arm                         axm55xx_defconfig
mips                     decstation_defconfig
arm                        trizeps4_defconfig
ia64                          tiger_defconfig
mips                        jmr3927_defconfig
m68k                       bvme6000_defconfig
ia64                         bigsur_defconfig
mips                        vocore2_defconfig
arm                         cm_x300_defconfig
m68k                          hp300_defconfig
xtensa                         virt_defconfig
arm                           sunxi_defconfig
parisc                              defconfig
s390                             alldefconfig
mips                          ath79_defconfig
m68k                        stmark2_defconfig
powerpc                     tqm5200_defconfig
arm                             mxs_defconfig
arm                             rpc_defconfig
mips                          ath25_defconfig
h8300                       h8s-sim_defconfig
mips                           ip27_defconfig
m68k                        m5407c3_defconfig
sh                        edosk7760_defconfig
sh                   secureedge5410_defconfig
arm                         mv78xx0_defconfig
openrisc                  or1klitex_defconfig
mips                          rb532_defconfig
mips                           gcw0_defconfig
powerpc                   lite5200b_defconfig
xtensa                    smp_lx200_defconfig
powerpc                  storcenter_defconfig
sparc                       sparc32_defconfig
arm                          pxa168_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nds32                             allnoconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
nds32                               defconfig
csky                                defconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
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
x86_64               randconfig-a003-20210430
x86_64               randconfig-a004-20210430
x86_64               randconfig-a002-20210430
x86_64               randconfig-a006-20210430
x86_64               randconfig-a001-20210430
x86_64               randconfig-a005-20210430
i386                 randconfig-a004-20210430
i386                 randconfig-a001-20210430
i386                 randconfig-a003-20210430
i386                 randconfig-a002-20210430
i386                 randconfig-a005-20210430
i386                 randconfig-a006-20210430
i386                 randconfig-a013-20210430
i386                 randconfig-a011-20210430
i386                 randconfig-a016-20210430
i386                 randconfig-a015-20210430
i386                 randconfig-a012-20210430
i386                 randconfig-a014-20210430
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
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
x86_64               randconfig-a011-20210430
x86_64               randconfig-a016-20210430
x86_64               randconfig-a013-20210430
x86_64               randconfig-a014-20210430
x86_64               randconfig-a012-20210430
x86_64               randconfig-a015-20210430

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
