Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C27E42B355
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 05:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbhJMDZH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 23:25:07 -0400
Received: from mga12.intel.com ([192.55.52.136]:41855 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhJMDZH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 23:25:07 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="207451245"
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="207451245"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 20:23:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,369,1624345200"; 
   d="scan'208";a="441481231"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 12 Oct 2021 20:23:02 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1maUr6-0004BV-Qi; Wed, 13 Oct 2021 03:23:00 +0000
Date:   Wed, 13 Oct 2021 11:22:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 046529f63ea9a6120a03d380acdef19dc3a800b4
Message-ID: <616650e5.gXRPDNfcdHf0GCn+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 046529f63ea9a6120a03d380acdef19dc3a800b4  Merge branch 'acpi-pm' into bleeding-edge

elapsed time: 723m

configs tested: 104
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20211012
arm                        shmobile_defconfig
sh                          r7780mp_defconfig
powerpc                 linkstation_defconfig
mips                      malta_kvm_defconfig
arm                           sama7_defconfig
arm                         lpc18xx_defconfig
nios2                         10m50_defconfig
powerpc                      ppc6xx_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                      rts7751r2d1_defconfig
powerpc                   motionpro_defconfig
sh                           se7206_defconfig
arm                        mvebu_v5_defconfig
powerpc                        fsp2_defconfig
arm                            dove_defconfig
arm                           corgi_defconfig
powerpc                       ebony_defconfig
mips                      bmips_stb_defconfig
powerpc                       eiger_defconfig
mips                            e55_defconfig
mips                        nlm_xlp_defconfig
arm                  randconfig-c002-20211012
x86_64               randconfig-c001-20211012
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
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20211012
i386                 randconfig-a003-20211012
i386                 randconfig-a004-20211012
i386                 randconfig-a005-20211012
i386                 randconfig-a002-20211012
i386                 randconfig-a006-20211012
x86_64               randconfig-a004-20211012
x86_64               randconfig-a006-20211012
x86_64               randconfig-a001-20211012
x86_64               randconfig-a005-20211012
x86_64               randconfig-a002-20211012
x86_64               randconfig-a003-20211012
arc                  randconfig-r043-20211012
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a015-20211012
x86_64               randconfig-a012-20211012
x86_64               randconfig-a016-20211012
x86_64               randconfig-a014-20211012
x86_64               randconfig-a013-20211012
x86_64               randconfig-a011-20211012
i386                 randconfig-a016-20211012
i386                 randconfig-a014-20211012
i386                 randconfig-a011-20211012
i386                 randconfig-a015-20211012
i386                 randconfig-a012-20211012
i386                 randconfig-a013-20211012
hexagon              randconfig-r041-20211012
s390                 randconfig-r044-20211012
riscv                randconfig-r042-20211012
hexagon              randconfig-r045-20211012

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
