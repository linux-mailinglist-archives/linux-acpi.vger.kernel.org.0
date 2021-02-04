Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3651230ED71
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 08:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbhBDHe6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 02:34:58 -0500
Received: from mga07.intel.com ([134.134.136.100]:39008 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234521AbhBDHe5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 4 Feb 2021 02:34:57 -0500
IronPort-SDR: SdAGlXHwMNdkvJBaxDgDOXRFlVPAO4Ny0SpcIC6yQfL+YiURjWvwPMDsN1+8W8Cqbydj40DNGr
 3ZpIUCSRDVLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="245261638"
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="245261638"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 23:34:14 -0800
IronPort-SDR: tuQBFfMGQL7Xgm+mxxMJvT42Elb3QZ331n87q9q6vZQxYBLTXN9Hi3DWTxnZ4oDEl98Q0kEmSd
 piTJvsGWGNeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,400,1602572400"; 
   d="scan'208";a="576198674"
Received: from lkp-server02.sh.intel.com (HELO 8b832f01bb9c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 03 Feb 2021 23:34:12 -0800
Received: from kbuild by 8b832f01bb9c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l7Z9X-0000pE-Uy; Thu, 04 Feb 2021 07:34:11 +0000
Date:   Thu, 04 Feb 2021 15:33:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 d0df27d78279aaa73c22e54f0b97d5f3f508f27e
Message-ID: <601ba352.VfF+oLpzGWFpeVB1%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d0df27d78279aaa73c22e54f0b97d5f3f508f27e  Merge branch 'sfi-removal' into bleeding-edge

elapsed time: 723m

configs tested: 95
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                         cm_x300_defconfig
sh                          urquell_defconfig
arm                        spear6xx_defconfig
sh                ecovec24-romimage_defconfig
c6x                        evmc6472_defconfig
arc                      axs103_smp_defconfig
arc                            hsdk_defconfig
arc                        nsim_700_defconfig
powerpc                      ppc6xx_defconfig
powerpc                     tqm8548_defconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                    socrates_defconfig
sh                          sdk7780_defconfig
sh                         microdev_defconfig
arm                          pxa168_defconfig
arc                          axs103_defconfig
s390                          debug_defconfig
mips                         bigsur_defconfig
arm                          lpd270_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
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
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a001-20210203
i386                 randconfig-a005-20210203
i386                 randconfig-a003-20210203
i386                 randconfig-a006-20210203
i386                 randconfig-a002-20210203
i386                 randconfig-a004-20210203
x86_64               randconfig-a013-20210202
x86_64               randconfig-a014-20210202
x86_64               randconfig-a015-20210202
x86_64               randconfig-a016-20210202
x86_64               randconfig-a011-20210202
x86_64               randconfig-a012-20210202
i386                 randconfig-a013-20210202
i386                 randconfig-a016-20210202
i386                 randconfig-a014-20210202
i386                 randconfig-a012-20210202
i386                 randconfig-a015-20210202
i386                 randconfig-a011-20210202
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a006-20210202
x86_64               randconfig-a001-20210202
x86_64               randconfig-a005-20210202
x86_64               randconfig-a002-20210202
x86_64               randconfig-a004-20210202
x86_64               randconfig-a003-20210202

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
