Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF2B3190632
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 08:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCXHYG (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 03:24:06 -0400
Received: from mga05.intel.com ([192.55.52.43]:63249 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbgCXHYG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 03:24:06 -0400
IronPort-SDR: NCKQGsZPiZt1lpx6VO595YIoH9g6P/6/TSJBvW9pI3akErlDajhvnM8WmscjskQwS3b9CvP5Uw
 57HBWE3s9cCA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 00:24:05 -0700
IronPort-SDR: judfSNTvNxTdpvjPcD8R8mkue8RpDADIlgExBXDzpwgrH8WxWJg3pP3AGMDnT02aJUbxe84iOn
 aIt59wFkaCPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="scan'208";a="238135100"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Mar 2020 00:24:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGdut-000FUd-EG; Tue, 24 Mar 2020 15:24:03 +0800
Date:   Tue, 24 Mar 2020 15:23:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 c6e2eb7ccc3d252115a7d8cba393770ec7366063
Message-ID: <5e79b57e.SAyMKQnUhAfZgGUz%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: c6e2eb7ccc3d252115a7d8cba393770ec7366063  Merge branch 'pnp' into linux-next

elapsed time: 886m

configs tested: 181
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
sparc64                             defconfig
riscv                          rv32_defconfig
xtensa                       common_defconfig
arc                              allyesconfig
i386                              allnoconfig
m68k                          multi_defconfig
i386                             allyesconfig
i386                             alldefconfig
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
xtensa                          iss_defconfig
nds32                               defconfig
nds32                             allnoconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
h8300                    h8300h-sim_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                           sun3_defconfig
arc                                 defconfig
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
i386                 randconfig-a002-20200323
i386                 randconfig-a001-20200323
x86_64               randconfig-a002-20200323
x86_64               randconfig-a001-20200323
i386                 randconfig-a003-20200323
x86_64               randconfig-a003-20200323
x86_64               randconfig-a001-20200322
x86_64               randconfig-a002-20200322
x86_64               randconfig-a003-20200322
i386                 randconfig-a001-20200322
i386                 randconfig-a002-20200322
i386                 randconfig-a003-20200322
mips                 randconfig-a001-20200323
nds32                randconfig-a001-20200323
m68k                 randconfig-a001-20200323
parisc               randconfig-a001-20200323
alpha                randconfig-a001-20200323
riscv                randconfig-a001-20200323
h8300                randconfig-a001-20200323
microblaze           randconfig-a001-20200323
nios2                randconfig-a001-20200323
c6x                  randconfig-a001-20200323
sparc64              randconfig-a001-20200323
c6x                  randconfig-a001-20200322
h8300                randconfig-a001-20200322
microblaze           randconfig-a001-20200322
nios2                randconfig-a001-20200322
sparc64              randconfig-a001-20200322
s390                 randconfig-a001-20200323
xtensa               randconfig-a001-20200323
csky                 randconfig-a001-20200323
openrisc             randconfig-a001-20200323
sh                   randconfig-a001-20200323
x86_64               randconfig-b001-20200323
x86_64               randconfig-b002-20200323
x86_64               randconfig-b003-20200323
i386                 randconfig-b001-20200323
i386                 randconfig-b002-20200323
i386                 randconfig-b003-20200323
x86_64               randconfig-c001-20200323
x86_64               randconfig-c002-20200323
x86_64               randconfig-c003-20200323
i386                 randconfig-c001-20200323
i386                 randconfig-c002-20200323
i386                 randconfig-c003-20200323
x86_64               randconfig-d001-20200323
x86_64               randconfig-d002-20200323
x86_64               randconfig-d003-20200323
i386                 randconfig-d001-20200323
i386                 randconfig-d002-20200323
i386                 randconfig-d003-20200323
x86_64               randconfig-e001-20200323
x86_64               randconfig-e002-20200323
x86_64               randconfig-e003-20200323
i386                 randconfig-e001-20200323
i386                 randconfig-e002-20200323
i386                 randconfig-e003-20200323
x86_64               randconfig-f001-20200323
x86_64               randconfig-f002-20200323
x86_64               randconfig-f003-20200323
i386                 randconfig-f001-20200323
i386                 randconfig-f002-20200323
i386                 randconfig-f003-20200323
x86_64               randconfig-f001-20200324
x86_64               randconfig-f002-20200324
x86_64               randconfig-f003-20200324
i386                 randconfig-f001-20200324
i386                 randconfig-f002-20200324
i386                 randconfig-f003-20200324
x86_64               randconfig-g001-20200323
x86_64               randconfig-g002-20200323
x86_64               randconfig-g003-20200323
i386                 randconfig-g001-20200323
i386                 randconfig-g002-20200323
i386                 randconfig-g003-20200323
x86_64               randconfig-h002-20200323
i386                 randconfig-h003-20200323
i386                 randconfig-h001-20200323
i386                 randconfig-h002-20200323
x86_64               randconfig-h001-20200323
x86_64               randconfig-h003-20200323
arm                  randconfig-a001-20200323
powerpc              randconfig-a001-20200323
arm64                randconfig-a001-20200323
ia64                 randconfig-a001-20200323
sparc                randconfig-a001-20200323
arc                  randconfig-a001-20200323
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
s390                          debug_defconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                             alldefconfig
s390                                defconfig
sh                               allmodconfig
sh                                allnoconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
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
