Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A79C19B770
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Apr 2020 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgDAVMx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Apr 2020 17:12:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:50251 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732337AbgDAVMw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 1 Apr 2020 17:12:52 -0400
IronPort-SDR: r+VplLC15mvjDkAdh7MfhxhiDCE1dSqEjc9pkbWVXFi5JhMld1tD5uZGRB0I8L48X6yDKMBle6
 2Z1F/z57VY4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 14:12:51 -0700
IronPort-SDR: YDZxjJIKhntbeAFIVaJ4+N3t2htiMprYCORUQvkrF1Pv3eC9/ru9AxED/6pbNZHdn+EESTzalp
 vqWSPJlwn+Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="450704916"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2020 14:12:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jJkfI-000F2G-OJ; Thu, 02 Apr 2020 05:12:48 +0800
Date:   Thu, 02 Apr 2020 05:12:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 54cd0f59877df1854dbea5e1a12cb31572daf7a0
Message-ID: <5e8503b5.1Cb2HNPDbYtUzY2Y%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 54cd0f59877df1854dbea5e1a12cb31572daf7a0  Merge branch 'acpi-drivers' into bleeding-edge

elapsed time: 481m

configs tested: 158
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
x86_64               randconfig-a003-20200401
i386                 randconfig-a002-20200401
x86_64               randconfig-a002-20200401
x86_64               randconfig-a001-20200401
i386                 randconfig-a003-20200401
i386                 randconfig-a001-20200401
nds32                randconfig-a001-20200401
m68k                 randconfig-a001-20200401
alpha                randconfig-a001-20200401
parisc               randconfig-a001-20200401
riscv                randconfig-a001-20200401
microblaze           randconfig-a001-20200331
h8300                randconfig-a001-20200331
nios2                randconfig-a001-20200331
c6x                  randconfig-a001-20200331
sparc64              randconfig-a001-20200331
s390                 randconfig-a001-20200401
xtensa               randconfig-a001-20200401
csky                 randconfig-a001-20200401
openrisc             randconfig-a001-20200401
sh                   randconfig-a001-20200401
i386                 randconfig-b003-20200401
x86_64               randconfig-b002-20200401
x86_64               randconfig-b003-20200401
i386                 randconfig-b001-20200401
x86_64               randconfig-b001-20200401
i386                 randconfig-b002-20200401
i386                 randconfig-c001-20200401
i386                 randconfig-c003-20200401
x86_64               randconfig-c003-20200401
i386                 randconfig-c002-20200401
x86_64               randconfig-c001-20200401
x86_64               randconfig-d001-20200401
i386                 randconfig-d003-20200401
i386                 randconfig-d001-20200401
x86_64               randconfig-d002-20200401
i386                 randconfig-d002-20200401
i386                 randconfig-e001-20200401
x86_64               randconfig-e002-20200401
i386                 randconfig-e003-20200401
x86_64               randconfig-e001-20200401
i386                 randconfig-e002-20200401
i386                 randconfig-f001-20200401
i386                 randconfig-f003-20200401
x86_64               randconfig-f003-20200401
x86_64               randconfig-f001-20200401
i386                 randconfig-f002-20200401
x86_64               randconfig-f002-20200401
x86_64               randconfig-g003-20200401
i386                 randconfig-g003-20200401
x86_64               randconfig-g002-20200401
i386                 randconfig-g001-20200401
i386                 randconfig-g002-20200401
x86_64               randconfig-g001-20200401
x86_64               randconfig-h002-20200401
i386                 randconfig-h002-20200401
i386                 randconfig-h003-20200401
i386                 randconfig-h001-20200401
x86_64               randconfig-h001-20200401
x86_64               randconfig-h003-20200401
arm64                randconfig-a001-20200401
sparc                randconfig-a001-20200401
ia64                 randconfig-a001-20200401
arc                  randconfig-a001-20200401
powerpc              randconfig-a001-20200401
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
