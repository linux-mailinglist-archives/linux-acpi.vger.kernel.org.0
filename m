Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01CA38F85D
	for <lists+linux-acpi@lfdr.de>; Tue, 25 May 2021 04:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbhEYC6F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 May 2021 22:58:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:60020 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229503AbhEYC6F (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 24 May 2021 22:58:05 -0400
IronPort-SDR: n2uSrClcBa10OG6s690+C6+5OPKkmxHA8+YR0DNFbihmD+09jUyRW4iXpRvggwusxYnGclRlte
 KHP02z58/6qA==
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="287657958"
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="287657958"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2021 19:56:36 -0700
IronPort-SDR: PmSN1XQ1H8pDr0lOX/rUCCHuPCkM+YnpZ4R4Ryr1hwCs/PmLULsvuABYDOKAC0D5TQ3vHnnIPC
 G3fxN8zCRrPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,327,1613462400"; 
   d="scan'208";a="546323839"
Received: from lkp-server02.sh.intel.com (HELO 1ec8406c5392) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 May 2021 19:56:35 -0700
Received: from kbuild by 1ec8406c5392 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1llNFC-0001TB-Cd; Tue, 25 May 2021 02:56:34 +0000
Date:   Tue, 25 May 2021 10:56:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 04e5775c09a2edfe8b310fd22099d46d98e0a5d2
Message-ID: <60ac6756.Ry0ZjKs6/VsAolJM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 04e5775c09a2edfe8b310fd22099d46d98e0a5d2  Merge branch 'acpi-misc' into bleeding-edge

i386-tinyconfig vmlinux size:

=======================================================================
 TOTAL  TEXT                                                           
=======================================================================
     0     0  04e5775c09a2 Merge branch 'acpi-misc' into bleeding-edge 
  -172  -174  c4681547bcce..04e5775c09a2 (ALL COMMITS)                 
=======================================================================

elapsed time: 722m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         shannon_defconfig
powerpc                      ppc64e_defconfig
arm                         assabet_defconfig
powerpc                       eiger_defconfig
microblaze                      mmu_defconfig
powerpc                     skiroot_defconfig
powerpc                      tqm8xx_defconfig
sh                                  defconfig
arm                          gemini_defconfig
powerpc                 linkstation_defconfig
mips                         tb0226_defconfig
powerpc                       maple_defconfig
arm                            qcom_defconfig
sh                   sh7724_generic_defconfig
arm                      integrator_defconfig
arm                        oxnas_v6_defconfig
sh                         microdev_defconfig
parisc                generic-32bit_defconfig
x86_64                            allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210524
i386                 randconfig-a002-20210524
i386                 randconfig-a005-20210524
i386                 randconfig-a006-20210524
i386                 randconfig-a004-20210524
i386                 randconfig-a003-20210524
i386                 randconfig-a011-20210524
i386                 randconfig-a016-20210524
i386                 randconfig-a015-20210524
i386                 randconfig-a012-20210524
i386                 randconfig-a014-20210524
i386                 randconfig-a013-20210524
x86_64               randconfig-a005-20210524
x86_64               randconfig-a001-20210524
x86_64               randconfig-a006-20210524
x86_64               randconfig-a003-20210524
x86_64               randconfig-a004-20210524
x86_64               randconfig-a002-20210524
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-b001-20210524
x86_64               randconfig-a013-20210524
x86_64               randconfig-a012-20210524
x86_64               randconfig-a014-20210524
x86_64               randconfig-a016-20210524
x86_64               randconfig-a015-20210524
x86_64               randconfig-a011-20210524

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
