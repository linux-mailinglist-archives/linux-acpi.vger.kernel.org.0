Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6AD641D4B2
	for <lists+linux-acpi@lfdr.de>; Thu, 30 Sep 2021 09:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348782AbhI3Hsg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 30 Sep 2021 03:48:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:12165 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348793AbhI3Hsg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 30 Sep 2021 03:48:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10122"; a="204611573"
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="204611573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2021 00:46:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,335,1624345200"; 
   d="scan'208";a="708903292"
Received: from lkp-server02.sh.intel.com (HELO f7acefbbae94) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 30 Sep 2021 00:46:49 -0700
Received: from kbuild by f7acefbbae94 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mVqmG-00040n-VF; Thu, 30 Sep 2021 07:46:48 +0000
Date:   Thu, 30 Sep 2021 15:45:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fb49d3272e86255e33a132a455cd965e578f9a8e
Message-ID: <61556b2f.g2wS+B5xyte8V6MS%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fb49d3272e86255e33a132a455cd965e578f9a8e  Merge branch 'acpica' into bleeding-edge

elapsed time: 731m

configs tested: 92
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                 randconfig-c001-20210929
powerpc                    sam440ep_defconfig
arm                         axm55xx_defconfig
sh                           se7343_defconfig
arm                         nhk8815_defconfig
powerpc                 mpc836x_rdk_defconfig
powerpc                 mpc8272_ads_defconfig
mips                      malta_kvm_defconfig
mips                       capcella_defconfig
arm                     am200epdkit_defconfig
x86_64               randconfig-c001-20210929
arm                  randconfig-c002-20210929
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
x86_64               randconfig-a002-20210929
x86_64               randconfig-a005-20210929
x86_64               randconfig-a001-20210929
x86_64               randconfig-a006-20210929
x86_64               randconfig-a003-20210929
x86_64               randconfig-a004-20210929
i386                 randconfig-a001-20210929
i386                 randconfig-a005-20210929
i386                 randconfig-a002-20210929
i386                 randconfig-a006-20210929
i386                 randconfig-a004-20210929
i386                 randconfig-a003-20210929
arc                  randconfig-r043-20210929
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a014-20210929
x86_64               randconfig-a011-20210929
x86_64               randconfig-a013-20210929
x86_64               randconfig-a015-20210929
x86_64               randconfig-a012-20210929
x86_64               randconfig-a016-20210929
i386                 randconfig-a014-20210929
i386                 randconfig-a013-20210929
i386                 randconfig-a016-20210929
i386                 randconfig-a011-20210929
i386                 randconfig-a015-20210929
i386                 randconfig-a012-20210929
hexagon              randconfig-r045-20210929
riscv                randconfig-r042-20210929
hexagon              randconfig-r041-20210929
s390                 randconfig-r044-20210929

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
