Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEB5149B65
	for <lists+linux-acpi@lfdr.de>; Sun, 26 Jan 2020 16:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgAZPaX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 26 Jan 2020 10:30:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:16591 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAZPaX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 26 Jan 2020 10:30:23 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 07:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="308565152"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jan 2020 07:30:21 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivjrg-000Fpp-MO; Sun, 26 Jan 2020 23:30:20 +0800
Date:   Sun, 26 Jan 2020 23:30:04 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD INCOMPLETE
 5fe5946b2ebcf750cfd4847550fa96eb1f03c870
Message-ID: <5e2db07c.aJhkabFbzNwKacLE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: 5fe5946b2ebcf750cfd4847550fa96eb1f03c870  Merge branch 'pm-core-next' into bleeding-edge

TIMEOUT after 2896m


Sorry we cannot finish the testset for your branch within a reasonable time.
It's our fault -- either some build server is down or some build worker is busy
doing bisects for _other_ trees. The branch will get more complete coverage and
possible error reports when our build infrastructure is restored or catches up.
There will be no more build success notification for this branch head, but you
can expect reasonably good test coverage after waiting for 1 day.

configs timed out: 19

alpha                               defconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                              allnoconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
nds32                               defconfig
powerpc                           allnoconfig
powerpc                             defconfig
powerpc                       ppc64_defconfig
s390                             alldefconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig

configs tested: 97
configs skipped: 1

arm                              allmodconfig
arm                         at91_dt_defconfig
arm64                               defconfig
arm                        multi_v5_defconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                               allnoconfig
arm                           efm32_defconfig
arm                           sunxi_defconfig
arm64                             allnoconfig
arm64                            allmodconfig
arm                          exynos_defconfig
arm                        shmobile_defconfig
arm                        multi_v7_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
m68k                          multi_defconfig
m68k                       m5475evb_defconfig
h8300                    h8300h-sim_defconfig
h8300                     edosk2674_defconfig
m68k                           sun3_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
ia64                             alldefconfig
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
i386                              allnoconfig
i386                                defconfig
i386                             allyesconfig
i386                             alldefconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                                allnoconfig
sh                            titan_defconfig
x86_64               randconfig-c003-20200126
i386                 randconfig-c003-20200126
x86_64               randconfig-c002-20200126
x86_64               randconfig-c001-20200126
i386                 randconfig-c001-20200126
i386                 randconfig-c002-20200126
parisc                        c3000_defconfig
parisc                         b180_defconfig
parisc                              defconfig
parisc                            allnoconfig
sparc64                          allmodconfig
sparc                            allyesconfig
sparc64                          allyesconfig
sparc                               defconfig
sparc64                           allnoconfig
sparc64                             defconfig
arm64                randconfig-a001-20200125
ia64                 randconfig-a001-20200125
arm                  randconfig-a001-20200125
arc                  randconfig-a001-20200125
sparc                randconfig-a001-20200125
x86_64               randconfig-f003-20200126
x86_64               randconfig-f001-20200126
x86_64               randconfig-f002-20200126
i386                 randconfig-f002-20200126
i386                 randconfig-f003-20200126
i386                 randconfig-f001-20200126
arc                              allyesconfig
microblaze                    nommu_defconfig
powerpc                          rhel-kconfig
microblaze                      mmu_defconfig
arc                                 defconfig
csky                                defconfig
nds32                             allnoconfig
x86_64                                    lkp
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                              fedora-25
x86_64                                  kexec
x86_64                         rhel-7.2-clear
h8300                randconfig-a001-20200125
nios2                randconfig-a001-20200125
c6x                  randconfig-a001-20200125
sparc64              randconfig-a001-20200125
microblaze           randconfig-a001-20200125

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation
