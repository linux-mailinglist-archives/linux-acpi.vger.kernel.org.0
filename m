Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8DB19E36F
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Apr 2020 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgDDI0q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Apr 2020 04:26:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:48962 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgDDI0q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 4 Apr 2020 04:26:46 -0400
IronPort-SDR: 5a4t5BLJaYCB5zf5YsHxMIyPdHqVmOFCsKh7r8XO0LXJjY7ZSD+WHTjYCDfF9C/DIbMn+yngEi
 lbcT2qEfQpvw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 01:26:45 -0700
IronPort-SDR: wyZvYV/McKS3Lqmlf/DuTEqK8YI9Ej0TcDYL43Yh478CV1Nc3J4miouwZmDK0NzBBeiH8n8bPJ
 m9kBRDecEH3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,343,1580803200"; 
   d="scan'208";a="250394652"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 04 Apr 2020 01:26:43 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKe8Y-00019x-Lo; Sat, 04 Apr 2020 16:26:42 +0800
Date:   Sat, 04 Apr 2020 16:25:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 3c55e7bed1061c07f3678df7889e35719349dd22
Message-ID: <5e88448e.Rv0Nqa6k3U2fl3Kn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 3c55e7bed1061c07f3678df7889e35719349dd22  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 1358m

configs tested: 145
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
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
x86_64               randconfig-a003-20200403
i386                 randconfig-a002-20200403
x86_64               randconfig-a002-20200403
x86_64               randconfig-a001-20200403
i386                 randconfig-a003-20200403
i386                 randconfig-a001-20200403
nds32                randconfig-a001-20200403
m68k                 randconfig-a001-20200403
alpha                randconfig-a001-20200403
parisc               randconfig-a001-20200403
riscv                randconfig-a001-20200403
sparc64              randconfig-a001-20200403
h8300                randconfig-a001-20200403
nios2                randconfig-a001-20200403
microblaze           randconfig-a001-20200403
c6x                  randconfig-a001-20200403
s390                 randconfig-a001-20200403
xtensa               randconfig-a001-20200403
csky                 randconfig-a001-20200403
openrisc             randconfig-a001-20200403
sh                   randconfig-a001-20200403
i386                 randconfig-b003-20200403
x86_64               randconfig-b001-20200403
i386                 randconfig-b001-20200403
i386                 randconfig-b002-20200403
i386                 randconfig-c001-20200403
i386                 randconfig-c003-20200403
x86_64               randconfig-c002-20200403
i386                 randconfig-c002-20200403
x86_64               randconfig-c001-20200403
x86_64               randconfig-d001-20200403
i386                 randconfig-d003-20200403
i386                 randconfig-d001-20200403
i386                 randconfig-d002-20200403
i386                 randconfig-e001-20200403
x86_64               randconfig-e002-20200403
i386                 randconfig-e003-20200403
x86_64               randconfig-e003-20200403
i386                 randconfig-e002-20200403
i386                 randconfig-f001-20200403
i386                 randconfig-f003-20200403
x86_64               randconfig-f003-20200403
x86_64               randconfig-f001-20200403
i386                 randconfig-f002-20200403
x86_64               randconfig-f002-20200403
x86_64               randconfig-g003-20200403
i386                 randconfig-g003-20200403
x86_64               randconfig-g002-20200403
i386                 randconfig-g001-20200403
i386                 randconfig-g002-20200403
x86_64               randconfig-g001-20200403
arm64                randconfig-a001-20200403
sparc                randconfig-a001-20200403
ia64                 randconfig-a001-20200403
arc                  randconfig-a001-20200403
arm                  randconfig-a001-20200403
powerpc              randconfig-a001-20200403
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
