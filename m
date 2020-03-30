Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACFDB1972E7
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 06:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgC3EF5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 00:05:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:5158 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgC3EF5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 30 Mar 2020 00:05:57 -0400
IronPort-SDR: iS/yF1VouVXLc1foVZGMrDH7icbj6boLAmC/vZ5op5qDkqEKT+f9KNJhLqGIA/oekPraIv4RVJ
 zinLBmWNNkYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 21:05:56 -0700
IronPort-SDR: ur4u1wuGlyI9LHAvEQYPzhLmaDFYU1lhjjznlTvCbf8m5pdxvaeyZunsX4zAc+DuL3M1oajgV2
 ygzohgYf0DSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; 
   d="scan'208";a="241511011"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2020 21:05:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jIlgQ-000DXO-5y; Mon, 30 Mar 2020 12:05:54 +0800
Date:   Mon, 30 Mar 2020 12:05:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 54c617385f8e16da77e722e6e45ff5962b3e0419
Message-ID: <5e816ffe.T6Luqq6y+d+fiUoR%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 54c617385f8e16da77e722e6e45ff5962b3e0419  Merge branch 'acpica-next' into bleeding-edge

elapsed time: 811m

configs tested: 158
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
arm64                            allmodconfig
arm                              allmodconfig
arm64                             allnoconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                       h8s-sim_defconfig
h8300                     edosk2674_defconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
h8300                    h8300h-sim_defconfig
m68k                           sun3_defconfig
m68k                          multi_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a002-20200329
x86_64               randconfig-a001-20200329
i386                 randconfig-a001-20200329
i386                 randconfig-a003-20200329
nds32                randconfig-a001-20200329
mips                 randconfig-a001-20200329
parisc               randconfig-a001-20200329
m68k                 randconfig-a001-20200329
alpha                randconfig-a001-20200329
riscv                randconfig-a001-20200329
h8300                randconfig-a001-20200329
nios2                randconfig-a001-20200329
microblaze           randconfig-a001-20200329
sparc64              randconfig-a001-20200329
c6x                  randconfig-a001-20200329
s390                 randconfig-a001-20200329
xtensa               randconfig-a001-20200329
csky                 randconfig-a001-20200329
openrisc             randconfig-a001-20200329
sh                   randconfig-a001-20200329
i386                 randconfig-b003-20200329
x86_64               randconfig-b003-20200329
i386                 randconfig-b001-20200329
i386                 randconfig-b002-20200329
x86_64               randconfig-b002-20200329
x86_64               randconfig-b001-20200329
x86_64               randconfig-c003-20200329
i386                 randconfig-c002-20200329
x86_64               randconfig-c001-20200329
x86_64               randconfig-c002-20200329
i386                 randconfig-c003-20200329
i386                 randconfig-c001-20200329
i386                 randconfig-d003-20200329
i386                 randconfig-d001-20200329
x86_64               randconfig-d002-20200329
i386                 randconfig-d002-20200329
x86_64               randconfig-d001-20200329
x86_64               randconfig-d003-20200329
x86_64               randconfig-e001-20200329
i386                 randconfig-e002-20200329
x86_64               randconfig-e003-20200329
i386                 randconfig-e003-20200329
x86_64               randconfig-e002-20200329
i386                 randconfig-e001-20200329
i386                 randconfig-f001-20200329
i386                 randconfig-f003-20200329
i386                 randconfig-f002-20200329
x86_64               randconfig-f002-20200329
x86_64               randconfig-f001-20200329
i386                 randconfig-g003-20200329
x86_64               randconfig-g002-20200329
i386                 randconfig-g002-20200329
i386                 randconfig-g001-20200329
x86_64               randconfig-g001-20200329
x86_64               randconfig-h002-20200329
x86_64               randconfig-h003-20200329
i386                 randconfig-h003-20200329
x86_64               randconfig-h001-20200329
i386                 randconfig-h001-20200329
i386                 randconfig-h002-20200329
arm                  randconfig-a001-20200329
arm64                randconfig-a001-20200329
ia64                 randconfig-a001-20200329
sparc                randconfig-a001-20200329
arc                  randconfig-a001-20200329
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                          rsk7269_defconfig
sh                               allmodconfig
sh                            titan_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
i386                             alldefconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
