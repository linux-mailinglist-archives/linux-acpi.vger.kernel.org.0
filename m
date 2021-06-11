Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2C73A396A
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Jun 2021 03:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhFKB4e (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 21:56:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:50514 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230280AbhFKB4e (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 10 Jun 2021 21:56:34 -0400
IronPort-SDR: HpM2hvEHuyHIrNACHgmq1eSAvaBtxaY4fDCOyN+RfVpQDsS5vIKN5qKKLk/pMRdgRaRB4QBtva
 yDe1llkS6CIw==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="203608362"
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="203608362"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2021 18:54:36 -0700
IronPort-SDR: d/ScbsOBg+fHebLR6GX/Ht2IrL7pxGzKTzd8bqQlXHmNsAffQ0ezojuwDKlubkSSWhwrQmhWVM
 w2Ebi96pJx/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,265,1616482800"; 
   d="scan'208";a="419929888"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Jun 2021 18:54:35 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lrWNX-0000NH-1R; Fri, 11 Jun 2021 01:54:35 +0000
Date:   Fri, 11 Jun 2021 09:54:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 bd8ae083b1f33fcc969fac4384495f21b355e13a
Message-ID: <60c2c249.Qm30P1cyQ8CYve29%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bd8ae083b1f33fcc969fac4384495f21b355e13a  Merge branch 'acpi-scan' into bleeding-edge

elapsed time: 722m

configs tested: 96
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                  mpc885_ads_defconfig
powerpc                      pasemi_defconfig
sh                          r7785rp_defconfig
s390                                defconfig
arm                              alldefconfig
s390                       zfcpdump_defconfig
powerpc                    socrates_defconfig
ia64                        generic_defconfig
arm                          badge4_defconfig
arm                  colibri_pxa270_defconfig
xtensa                       common_defconfig
mips                      fuloong2e_defconfig
arc                         haps_hs_defconfig
ia64                         bigsur_defconfig
sh                     sh7710voipgw_defconfig
powerpc                         ps3_defconfig
arm                            mmp2_defconfig
powerpc                     sequoia_defconfig
arm                        mvebu_v7_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a002-20210610
i386                 randconfig-a006-20210610
i386                 randconfig-a004-20210610
i386                 randconfig-a001-20210610
i386                 randconfig-a005-20210610
i386                 randconfig-a003-20210610
x86_64               randconfig-a015-20210610
x86_64               randconfig-a011-20210610
x86_64               randconfig-a012-20210610
x86_64               randconfig-a014-20210610
x86_64               randconfig-a016-20210610
x86_64               randconfig-a013-20210610
i386                 randconfig-a015-20210610
i386                 randconfig-a013-20210610
i386                 randconfig-a016-20210610
i386                 randconfig-a014-20210610
i386                 randconfig-a012-20210610
i386                 randconfig-a011-20210610
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
um                            kunit_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210610
x86_64               randconfig-a001-20210610
x86_64               randconfig-a004-20210610
x86_64               randconfig-a003-20210610
x86_64               randconfig-a006-20210610
x86_64               randconfig-a005-20210610

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
