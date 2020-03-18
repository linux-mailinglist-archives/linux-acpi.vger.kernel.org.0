Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5018A1F3
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgCRRtm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Mar 2020 13:49:42 -0400
Received: from mga04.intel.com ([192.55.52.120]:7041 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRRtm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 18 Mar 2020 13:49:42 -0400
IronPort-SDR: 5jENlgvk3LRhdyJR6yfSTlpTMHk6475jXkVcYlTq37EIypp7S7sbK5NGs3wigvThNCaaAF9x5v
 u90zD0FxWb8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 10:49:40 -0700
IronPort-SDR: JqoRi7soQ2PLlVzhXNeyP1zo4aP5jiEgpLS62eZeWhNUXhm7KuCQqlvNCZKClaxVV+x/fX9BxX
 kMKrRNVNF7CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="238256112"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 10:49:38 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jEcoz-000IgV-RH; Thu, 19 Mar 2020 01:49:37 +0800
Date:   Thu, 19 Mar 2020 01:48:48 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 c03d064a440c2a5cbe3da782db05d3e18dc5ec3e
Message-ID: <5e725f00.x1QanKGUdoru37AN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: c03d064a440c2a5cbe3da782db05d3e18dc5ec3e  Merge branch 'pnp' into linux-next

elapsed time: 485m

configs tested: 164
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm                         at91_dt_defconfig
arm                           efm32_defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                        multi_v7_defconfig
arm                        shmobile_defconfig
arm                           sunxi_defconfig
sparc                            allyesconfig
nios2                         3c120_defconfig
s390                             allmodconfig
i386                             alldefconfig
nios2                         10m50_defconfig
sh                          rsk7269_defconfig
sh                            titan_defconfig
riscv                    nommu_virt_defconfig
m68k                             allmodconfig
i386                              allnoconfig
i386                             allyesconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                    or1ksim_defconfig
xtensa                          iss_defconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
arc                              allyesconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
parisc                           allyesconfig
i386                 randconfig-a003-20200318
i386                 randconfig-a001-20200318
x86_64               randconfig-a001-20200318
x86_64               randconfig-a002-20200318
i386                 randconfig-a002-20200318
x86_64               randconfig-a003-20200318
riscv                randconfig-a001-20200318
m68k                 randconfig-a001-20200318
nds32                randconfig-a001-20200318
alpha                randconfig-a001-20200318
parisc               randconfig-a001-20200318
mips                 randconfig-a001-20200318
h8300                randconfig-a001-20200318
sparc64              randconfig-a001-20200318
c6x                  randconfig-a001-20200318
nios2                randconfig-a001-20200318
microblaze           randconfig-a001-20200318
csky                 randconfig-a001-20200318
openrisc             randconfig-a001-20200318
s390                 randconfig-a001-20200318
sh                   randconfig-a001-20200318
xtensa               randconfig-a001-20200318
x86_64               randconfig-b001-20200318
x86_64               randconfig-b002-20200318
x86_64               randconfig-b003-20200318
i386                 randconfig-b001-20200318
i386                 randconfig-b002-20200318
i386                 randconfig-b003-20200318
x86_64               randconfig-c001-20200318
x86_64               randconfig-c002-20200318
x86_64               randconfig-c003-20200318
i386                 randconfig-c001-20200318
i386                 randconfig-c002-20200318
i386                 randconfig-c003-20200318
x86_64               randconfig-d001-20200318
i386                 randconfig-d001-20200318
i386                 randconfig-d003-20200318
i386                 randconfig-d002-20200318
x86_64               randconfig-d002-20200318
x86_64               randconfig-d003-20200318
x86_64               randconfig-e001-20200318
x86_64               randconfig-e002-20200318
x86_64               randconfig-e003-20200318
i386                 randconfig-e001-20200318
i386                 randconfig-e002-20200318
i386                 randconfig-e003-20200318
x86_64               randconfig-f001-20200318
x86_64               randconfig-f002-20200318
x86_64               randconfig-f003-20200318
i386                 randconfig-f001-20200318
i386                 randconfig-f002-20200318
i386                 randconfig-f003-20200318
x86_64               randconfig-g001-20200318
x86_64               randconfig-g002-20200318
x86_64               randconfig-g003-20200318
i386                 randconfig-g001-20200318
i386                 randconfig-g002-20200318
i386                 randconfig-g003-20200318
x86_64               randconfig-h001-20200318
x86_64               randconfig-h002-20200318
x86_64               randconfig-h003-20200318
i386                 randconfig-h001-20200318
i386                 randconfig-h002-20200318
i386                 randconfig-h003-20200318
arc                  randconfig-a001-20200318
arm                  randconfig-a001-20200318
arm64                randconfig-a001-20200318
ia64                 randconfig-a001-20200318
powerpc              randconfig-a001-20200318
sparc                randconfig-a001-20200318
riscv                            allmodconfig
riscv                             allnoconfig
riscv                            allyesconfig
riscv                               defconfig
riscv                          rv32_defconfig
s390                             alldefconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                             defconfig
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
