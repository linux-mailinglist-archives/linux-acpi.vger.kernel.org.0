Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 675EA1893BE
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 02:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgCRBit (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 17 Mar 2020 21:38:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:60775 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726680AbgCRBit (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 17 Mar 2020 21:38:49 -0400
IronPort-SDR: 9K2c7G8KQ2+FZAzmlZOkmwXY4ubWFtRknRQQ0CANj6dz71gL72F9IhrCY/j5EdAVjvX/rA05r1
 6piK6g464gOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 18:38:48 -0700
IronPort-SDR: PYIg8zsoqSoKaAuDhxEAo54cxF8/ki0flW1p44NGgwjs9eoKiWWqOUT4tG7SnV63LdAEfQ26KE
 VB01UYqHuN6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="279586774"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 17 Mar 2020 18:38:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jENfS-000BRk-36; Wed, 18 Mar 2020 09:38:46 +0800
Date:   Wed, 18 Mar 2020 09:38:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 48c5a4c87535359453a3189abce4c7ef1977cd95
Message-ID: <5e717b93.y/kbxr9x1qKsm7mS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 48c5a4c87535359453a3189abce4c7ef1977cd95  Merge branch 'pnp' into bleeding-edge

elapsed time: 484m

configs tested: 151
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm                              allyesconfig
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
i386                             alldefconfig
i386                                defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                             alldefconfig
arm64                            allmodconfig
arm                              allmodconfig
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
powerpc                             defconfig
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
i386                 randconfig-a003-20200317
i386                 randconfig-a001-20200317
x86_64               randconfig-a001-20200317
x86_64               randconfig-a003-20200317
i386                 randconfig-a002-20200317
x86_64               randconfig-a002-20200317
riscv                randconfig-a001-20200317
alpha                randconfig-a001-20200317
nds32                randconfig-a001-20200317
m68k                 randconfig-a001-20200317
parisc               randconfig-a001-20200317
mips                 randconfig-a001-20200317
h8300                randconfig-a001-20200317
sparc64              randconfig-a001-20200317
c6x                  randconfig-a001-20200317
nios2                randconfig-a001-20200317
microblaze           randconfig-a001-20200317
xtensa               randconfig-a001-20200317
openrisc             randconfig-a001-20200317
csky                 randconfig-a001-20200317
sh                   randconfig-a001-20200317
s390                 randconfig-a001-20200317
x86_64               randconfig-b001-20200317
x86_64               randconfig-b002-20200317
x86_64               randconfig-b003-20200317
i386                 randconfig-b001-20200317
i386                 randconfig-b002-20200317
i386                 randconfig-b003-20200317
x86_64               randconfig-d001-20200317
i386                 randconfig-d001-20200317
i386                 randconfig-d003-20200317
i386                 randconfig-d002-20200317
x86_64               randconfig-d003-20200317
x86_64               randconfig-d002-20200317
x86_64               randconfig-f001-20200317
i386                 randconfig-f002-20200317
i386                 randconfig-f003-20200317
i386                 randconfig-f001-20200317
x86_64               randconfig-f002-20200317
x86_64               randconfig-f003-20200317
i386                 randconfig-g001-20200318
i386                 randconfig-g003-20200318
x86_64               randconfig-g003-20200318
x86_64               randconfig-g002-20200318
x86_64               randconfig-g001-20200318
i386                 randconfig-g002-20200318
x86_64               randconfig-h001-20200317
i386                 randconfig-h001-20200317
x86_64               randconfig-h002-20200317
x86_64               randconfig-h003-20200317
i386                 randconfig-h002-20200317
i386                 randconfig-h003-20200317
arc                  randconfig-a001-20200317
ia64                 randconfig-a001-20200317
arm                  randconfig-a001-20200317
arm64                randconfig-a001-20200317
sparc                randconfig-a001-20200317
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
