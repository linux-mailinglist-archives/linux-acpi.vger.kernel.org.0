Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCA1C54A4
	for <lists+linux-acpi@lfdr.de>; Tue,  5 May 2020 13:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgEELnt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 5 May 2020 07:43:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:62531 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728497AbgEELns (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 5 May 2020 07:43:48 -0400
IronPort-SDR: teX/szcJNDRZK2FQLhKzuPmPVtXYaDzxDtVWMLqGWf/O6D+9CXuidtM++wj/7TbDWfgW6dd4LO
 XxoNWZsGTUsg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2020 04:43:47 -0700
IronPort-SDR: gbqUbdAidyOdY/+RyXLPOE4jOoKjkeE808a5nZLDiXVJqlEjttfcExw7e3iWJC/hv3um8hgYXA
 cS75dEXfevug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,354,1583222400"; 
   d="scan'208";a="304454962"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 05 May 2020 04:43:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jVvzF-000GMC-FH; Tue, 05 May 2020 19:43:45 +0800
Date:   Tue, 05 May 2020 19:43:40 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 1985b45de01473658db9194e948eb151f9e076ae
Message-ID: <5eb1516c.V6ENfdDLNTTMZ8HN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 1985b45de01473658db9194e948eb151f9e076ae  Merge branch 'pm-cpuidle' into linux-next

elapsed time: 1303m

configs tested: 235
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
powerpc                             defconfig
ia64                                defconfig
parisc                generic-32bit_defconfig
mips                             allmodconfig
xtensa                       common_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
s390                             allyesconfig
h8300                    h8300h-sim_defconfig
powerpc                     ep8248e_defconfig
ia64                        generic_defconfig
riscv                          rv32_defconfig
powerpc                          g5_defconfig
mips                          ath79_defconfig
nds32                             allnoconfig
mips                       capcella_defconfig
riscv                             allnoconfig
parisc                           allmodconfig
s390                          debug_defconfig
ia64                             allyesconfig
i386                              allnoconfig
i386                             allyesconfig
i386                             alldefconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                              allnoconfig
ia64                          tiger_defconfig
ia64                         bigsur_defconfig
ia64                             alldefconfig
m68k                       m5475evb_defconfig
m68k                             allmodconfig
m68k                       bvme6000_defconfig
m68k                          multi_defconfig
nios2                         3c120_defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
c6x                              allyesconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
h8300                     edosk2674_defconfig
xtensa                          iss_defconfig
arc                                 defconfig
arc                              allyesconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
mips                            ar7_defconfig
mips                             allyesconfig
mips                         64r6el_defconfig
mips                              allnoconfig
mips                           32r2_defconfig
mips                malta_kvm_guest_defconfig
mips                         tb0287_defconfig
mips                           ip32_defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                        bcm63xx_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                           allyesconfig
powerpc                      chrp32_defconfig
powerpc                       holly_defconfig
powerpc                       ppc64_defconfig
powerpc                          rhel-kconfig
powerpc                           allnoconfig
powerpc                  mpc866_ads_defconfig
powerpc                    amigaone_defconfig
powerpc                    adder875_defconfig
powerpc                     mpc512x_defconfig
m68k                 randconfig-a001-20200505
mips                 randconfig-a001-20200505
nds32                randconfig-a001-20200505
parisc               randconfig-a001-20200505
alpha                randconfig-a001-20200505
riscv                randconfig-a001-20200505
m68k                 randconfig-a001-20200503
mips                 randconfig-a001-20200503
nds32                randconfig-a001-20200503
alpha                randconfig-a001-20200503
parisc               randconfig-a001-20200503
riscv                randconfig-a001-20200503
m68k                 randconfig-a001-20200502
mips                 randconfig-a001-20200502
nds32                randconfig-a001-20200502
alpha                randconfig-a001-20200502
parisc               randconfig-a001-20200502
riscv                randconfig-a001-20200502
h8300                randconfig-a001-20200503
nios2                randconfig-a001-20200503
microblaze           randconfig-a001-20200503
c6x                  randconfig-a001-20200503
sparc64              randconfig-a001-20200503
s390                 randconfig-a001-20200504
xtensa               randconfig-a001-20200504
sh                   randconfig-a001-20200504
openrisc             randconfig-a001-20200504
csky                 randconfig-a001-20200504
s390                 randconfig-a001-20200505
xtensa               randconfig-a001-20200505
sh                   randconfig-a001-20200505
openrisc             randconfig-a001-20200505
csky                 randconfig-a001-20200505
xtensa               randconfig-a001-20200503
sh                   randconfig-a001-20200503
openrisc             randconfig-a001-20200503
csky                 randconfig-a001-20200503
s390                 randconfig-a001-20200430
xtensa               randconfig-a001-20200430
csky                 randconfig-a001-20200430
openrisc             randconfig-a001-20200430
sh                   randconfig-a001-20200430
x86_64               randconfig-a003-20200505
x86_64               randconfig-a001-20200505
i386                 randconfig-a001-20200505
i386                 randconfig-a003-20200505
i386                 randconfig-a002-20200505
i386                 randconfig-b003-20200503
x86_64               randconfig-b002-20200503
i386                 randconfig-b001-20200503
x86_64               randconfig-b003-20200503
x86_64               randconfig-b001-20200503
i386                 randconfig-b002-20200503
i386                 randconfig-b003-20200502
i386                 randconfig-b001-20200502
x86_64               randconfig-b003-20200502
x86_64               randconfig-b001-20200502
i386                 randconfig-b002-20200502
x86_64               randconfig-c002-20200502
i386                 randconfig-c002-20200502
i386                 randconfig-c001-20200502
i386                 randconfig-c003-20200502
x86_64               randconfig-c002-20200505
x86_64               randconfig-c001-20200505
i386                 randconfig-c002-20200505
i386                 randconfig-c003-20200505
x86_64               randconfig-c003-20200505
i386                 randconfig-c001-20200505
i386                 randconfig-d003-20200502
i386                 randconfig-d001-20200502
x86_64               randconfig-d002-20200502
i386                 randconfig-d002-20200502
x86_64               randconfig-e003-20200503
x86_64               randconfig-e002-20200503
i386                 randconfig-e003-20200503
x86_64               randconfig-e001-20200503
i386                 randconfig-e002-20200503
i386                 randconfig-e001-20200503
i386                 randconfig-e003-20200505
x86_64               randconfig-e002-20200505
x86_64               randconfig-e003-20200505
x86_64               randconfig-e001-20200505
i386                 randconfig-e002-20200505
i386                 randconfig-e001-20200505
i386                 randconfig-f003-20200503
x86_64               randconfig-f002-20200503
i386                 randconfig-f001-20200503
i386                 randconfig-f002-20200503
i386                 randconfig-f003-20200505
x86_64               randconfig-f001-20200505
x86_64               randconfig-f003-20200505
i386                 randconfig-f001-20200505
i386                 randconfig-f002-20200505
i386                 randconfig-f003-20200502
x86_64               randconfig-f001-20200502
x86_64               randconfig-f003-20200502
x86_64               randconfig-f002-20200502
i386                 randconfig-f001-20200502
i386                 randconfig-f002-20200502
i386                 randconfig-g003-20200505
i386                 randconfig-g002-20200505
i386                 randconfig-g001-20200505
x86_64               randconfig-g002-20200505
i386                 randconfig-h001-20200503
i386                 randconfig-h002-20200503
i386                 randconfig-h003-20200503
x86_64               randconfig-h002-20200503
ia64                 randconfig-a001-20200503
arm64                randconfig-a001-20200503
arc                  randconfig-a001-20200503
arm                  randconfig-a001-20200503
sparc                randconfig-a001-20200503
ia64                 randconfig-a001-20200505
arc                  randconfig-a001-20200505
powerpc              randconfig-a001-20200505
arm                  randconfig-a001-20200505
sparc                randconfig-a001-20200505
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
riscv                            allmodconfig
s390                       zfcpdump_defconfig
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
x86_64                    rhel-7.6-kselftests

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
