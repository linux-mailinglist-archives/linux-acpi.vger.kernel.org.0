Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61C7C143153
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Jan 2020 19:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATSOC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 20 Jan 2020 13:14:02 -0500
Received: from mga07.intel.com ([134.134.136.100]:6625 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgATSOC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 20 Jan 2020 13:14:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2020 10:14:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,342,1574150400"; 
   d="scan'208";a="374382959"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 20 Jan 2020 10:14:00 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1itbYl-000Hb6-H5; Tue, 21 Jan 2020 02:13:59 +0800
Date:   Tue, 21 Jan 2020 02:13:35 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 971a12f8e68bf3b19eb1161e1fcefdf3b0573907
Message-ID: <5e25edcf.kO1auxAqDHJDghhQ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 971a12f8e68bf3b19eb1161e1fcefdf3b0573907  Merge branch 'pm-cpuidle-next' into testing

elapsed time: 400m

configs tested: 163
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

parisc                            allnoconfig
parisc                            allyesonfig
parisc                         b180_defconfig
parisc                        c3000_defconfig
parisc                              defconfig
x86_64               randconfig-e001-20200120
x86_64               randconfig-e002-20200120
x86_64               randconfig-e003-20200120
i386                 randconfig-e001-20200120
i386                 randconfig-e002-20200120
i386                 randconfig-e003-20200120
i386                             alldefconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
csky                 randconfig-a001-20200120
openrisc             randconfig-a001-20200120
s390                 randconfig-a001-20200120
sh                   randconfig-a001-20200120
xtensa               randconfig-a001-20200120
xtensa                       common_defconfig
openrisc                    or1ksim_defconfig
nios2                         3c120_defconfig
xtensa                          iss_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
nios2                         10m50_defconfig
openrisc                 simple_smp_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
x86_64               randconfig-g001-20200120
x86_64               randconfig-g002-20200120
x86_64               randconfig-g003-20200120
i386                 randconfig-g001-20200120
i386                 randconfig-g002-20200120
i386                 randconfig-g003-20200120
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
x86_64               randconfig-d001-20200120
x86_64               randconfig-d002-20200120
x86_64               randconfig-d003-20200120
i386                 randconfig-d001-20200120
i386                 randconfig-d002-20200120
i386                 randconfig-d003-20200120
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64               randconfig-c001-20200120
x86_64               randconfig-c002-20200120
x86_64               randconfig-c003-20200120
i386                 randconfig-c001-20200120
i386                 randconfig-c002-20200120
i386                 randconfig-c003-20200120
x86_64               randconfig-f001-20200120
x86_64               randconfig-f002-20200120
x86_64               randconfig-f003-20200120
i386                 randconfig-f001-20200120
i386                 randconfig-f002-20200120
i386                 randconfig-f003-20200120
ia64                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
c6x                  randconfig-a001-20200120
h8300                randconfig-a001-20200120
microblaze           randconfig-a001-20200120
nios2                randconfig-a001-20200120
sparc64              randconfig-a001-20200120
x86_64               randconfig-a001-20200120
x86_64               randconfig-a002-20200120
x86_64               randconfig-a003-20200120
i386                 randconfig-a001-20200120
i386                 randconfig-a002-20200120
i386                 randconfig-a003-20200120
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
arc                  randconfig-a001-20200120
arm                  randconfig-a001-20200120
arm64                randconfig-a001-20200120
ia64                 randconfig-a001-20200120
powerpc              randconfig-a001-20200120
sparc                randconfig-a001-20200120
x86_64               randconfig-b001-20200120
x86_64               randconfig-b002-20200120
x86_64               randconfig-b003-20200120
i386                 randconfig-b001-20200120
i386                 randconfig-b002-20200120
i386                 randconfig-b003-20200120
x86_64               randconfig-h001-20200120
x86_64               randconfig-h002-20200120
x86_64               randconfig-h003-20200120
i386                 randconfig-h001-20200120
i386                 randconfig-h002-20200120
i386                 randconfig-h003-20200120
c6x                  randconfig-a001-20200121
h8300                randconfig-a001-20200121
microblaze           randconfig-a001-20200121
nios2                randconfig-a001-20200121
sparc64              randconfig-a001-20200121

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
