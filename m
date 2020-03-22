Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7589918EAEC
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Mar 2020 18:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgCVRiS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 22 Mar 2020 13:38:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:25022 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgCVRiS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 22 Mar 2020 13:38:18 -0400
IronPort-SDR: Dlr++7ZPvOT9OEfFRUIUb0KfKCGh6CxsF/jmqekSn0wly5ayZC2XXd5HQqneNdaGKCZq5pC+Tp
 Z0bd5KUwKThg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 10:38:17 -0700
IronPort-SDR: 75OJ+XSFnPbilSvJNh7auC25X+IoZQ5yjZZor8KXmnidXOrtT6UfLfISE2LgUhjEBhM/RGXjzW
 kIrk8a7L3k6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="419264868"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Mar 2020 10:38:14 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jG4YA-0009Ey-3y; Mon, 23 Mar 2020 01:38:14 +0800
Date:   Mon, 23 Mar 2020 01:38:03 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 5e3ada361a7aef36e173fc7004a8e9f0066f9010
Message-ID: <5e77a27b.sp4WeAC/AqdcPMv1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 5e3ada361a7aef36e173fc7004a8e9f0066f9010  Merge branch 'pnp' into linux-next

elapsed time: 480m

configs tested: 162
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                           sunxi_defconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
s390                              allnoconfig
powerpc                             defconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                              allyesconfig
c6x                        evmc6678_defconfig
nios2                         10m50_defconfig
nios2                         3c120_defconfig
openrisc                    or1ksim_defconfig
openrisc                 simple_smp_defconfig
xtensa                       common_defconfig
xtensa                          iss_defconfig
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
parisc                           allyesconfig
parisc                generic-32bit_defconfig
parisc                generic-64bit_defconfig
x86_64               randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a003-20200322
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
mips                 randconfig-a001-20200322
nds32                randconfig-a001-20200322
m68k                 randconfig-a001-20200322
parisc               randconfig-a001-20200322
alpha                randconfig-a001-20200322
riscv                randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
c6x                  randconfig-a001-20200322
sparc64              randconfig-a001-20200322
csky                 randconfig-a001-20200322
openrisc             randconfig-a001-20200322
s390                 randconfig-a001-20200322
sh                   randconfig-a001-20200322
xtensa               randconfig-a001-20200322
i386                 randconfig-b003-20200322
i386                 randconfig-b001-20200322
x86_64               randconfig-b003-20200322
i386                 randconfig-b002-20200322
x86_64               randconfig-b002-20200322
x86_64               randconfig-c001-20200322
x86_64               randconfig-c002-20200322
x86_64               randconfig-c003-20200322
i386                 randconfig-c001-20200322
i386                 randconfig-c002-20200322
i386                 randconfig-c003-20200322
i386                 randconfig-d003-20200322
i386                 randconfig-d001-20200322
i386                 randconfig-d002-20200322
x86_64               randconfig-d001-20200322
x86_64               randconfig-d003-20200322
x86_64               randconfig-d002-20200322
x86_64               randconfig-e001-20200322
x86_64               randconfig-e002-20200322
x86_64               randconfig-e003-20200322
i386                 randconfig-e001-20200322
i386                 randconfig-e002-20200322
i386                 randconfig-e003-20200322
i386                 randconfig-f001-20200322
i386                 randconfig-f003-20200322
i386                 randconfig-f002-20200322
x86_64               randconfig-f002-20200322
x86_64               randconfig-f003-20200322
x86_64               randconfig-f001-20200322
i386                 randconfig-g003-20200322
x86_64               randconfig-g002-20200322
i386                 randconfig-g001-20200322
i386                 randconfig-g002-20200322
x86_64               randconfig-g001-20200322
x86_64               randconfig-g003-20200322
x86_64               randconfig-h002-20200322
x86_64               randconfig-h003-20200322
i386                 randconfig-h003-20200322
x86_64               randconfig-h001-20200322
i386                 randconfig-h001-20200322
i386                 randconfig-h002-20200322
arm                  randconfig-a001-20200322
arm64                randconfig-a001-20200322
ia64                 randconfig-a001-20200322
arc                  randconfig-a001-20200322
sparc                randconfig-a001-20200322
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                    lkp
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                               rhel-7.6

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
