Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7D0194FB2
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Mar 2020 04:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgC0DfD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Mar 2020 23:35:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:6232 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgC0DfD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 26 Mar 2020 23:35:03 -0400
IronPort-SDR: Ii0WDo9jmBKpki18p/7Vs8XViR1GeHp6ccY/W5TSutC+i+Se7JBWX1+PKLyoEbpYCf3bQ98R7Q
 pDiyZQEzThvg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2020 20:35:02 -0700
IronPort-SDR: yCn3c6bYy1wdSvKqPIMDG0VQSiVlROkaKo4N5mjFK3PDtIuc6MMmxZBN2MeDGbtC+mglnLA8pp
 yKAt5461cDng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,310,1580803200"; 
   d="scan'208";a="236502940"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Mar 2020 20:35:00 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jHflr-00084o-Vv; Fri, 27 Mar 2020 11:34:59 +0800
Date:   Fri, 27 Mar 2020 11:34:54 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b
Message-ID: <5e7d745e.1x6kDbrVmUlVWP5G%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 8b4ddf47b7b4dd54539f1821c95a8dee3295fb0b  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 481m

configs tested: 160
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
arm64                               defconfig
sparc                            allyesconfig
m68k                           sun3_defconfig
s390                             allyesconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
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
x86_64               randconfig-a001-20200326
x86_64               randconfig-a002-20200326
x86_64               randconfig-a003-20200326
i386                 randconfig-a001-20200326
i386                 randconfig-a002-20200326
i386                 randconfig-a003-20200326
alpha                randconfig-a001-20200326
m68k                 randconfig-a001-20200326
mips                 randconfig-a001-20200326
nds32                randconfig-a001-20200326
parisc               randconfig-a001-20200326
riscv                randconfig-a001-20200326
h8300                randconfig-a001-20200326
microblaze           randconfig-a001-20200326
nios2                randconfig-a001-20200326
c6x                  randconfig-a001-20200326
sparc64              randconfig-a001-20200326
c6x                  randconfig-a001-20200327
h8300                randconfig-a001-20200327
microblaze           randconfig-a001-20200327
nios2                randconfig-a001-20200327
sparc64              randconfig-a001-20200327
s390                 randconfig-a001-20200326
csky                 randconfig-a001-20200326
xtensa               randconfig-a001-20200326
openrisc             randconfig-a001-20200326
sh                   randconfig-a001-20200326
x86_64               randconfig-c003-20200326
x86_64               randconfig-c001-20200326
x86_64               randconfig-c002-20200326
i386                 randconfig-c001-20200326
i386                 randconfig-c002-20200326
i386                 randconfig-c003-20200326
i386                 randconfig-d003-20200326
i386                 randconfig-d001-20200326
i386                 randconfig-d002-20200326
x86_64               randconfig-e001-20200326
x86_64               randconfig-e002-20200326
x86_64               randconfig-e003-20200326
i386                 randconfig-e001-20200326
i386                 randconfig-e002-20200326
i386                 randconfig-e003-20200326
x86_64               randconfig-f001-20200326
x86_64               randconfig-f002-20200326
x86_64               randconfig-f003-20200326
i386                 randconfig-f001-20200326
i386                 randconfig-f002-20200326
i386                 randconfig-f003-20200326
x86_64               randconfig-g001-20200326
x86_64               randconfig-g002-20200326
x86_64               randconfig-g003-20200326
i386                 randconfig-g001-20200326
i386                 randconfig-g002-20200326
i386                 randconfig-g003-20200326
x86_64               randconfig-h001-20200326
x86_64               randconfig-h002-20200326
x86_64               randconfig-h003-20200326
i386                 randconfig-h001-20200326
i386                 randconfig-h002-20200326
i386                 randconfig-h003-20200326
arc                  randconfig-a001-20200326
arm                  randconfig-a001-20200326
arm64                randconfig-a001-20200326
ia64                 randconfig-a001-20200326
powerpc              randconfig-a001-20200326
sparc                randconfig-a001-20200326
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
