Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F187247E0C5
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Dec 2021 10:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347382AbhLWJSh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 23 Dec 2021 04:18:37 -0500
Received: from mga05.intel.com ([192.55.52.43]:62382 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347380AbhLWJSh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 23 Dec 2021 04:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640251117; x=1671787117;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KgTzfJuw1PWM0ANJHJO8QFp8w9NyND/kbpTu0eJK1qo=;
  b=eShiaa+RiJ9wMoQcQswNx7AnkBnYH1tbfauZRQc/Ft/+3amE/CfpcQXK
   wQ2QQtJo4fU9M1JpVrnd96ZqQlAix/S+Xcc/pujJLxo8JOxK15+zR3U2P
   m9K4G3g0WBS1KPXj4t0CdGB7w0b/TsmQp2op99NBeKktIdTRaNFFaiaaG
   RmABbF5Cz9Zx0K8fLzw/vwHeSTx0WWLafv5+2PBT61qVW72awJCdgB28/
   8YX3N6JbgUyzPdt+iDEHPLuk7IlsUEhM8WW81NN21KQ0zyJjNTI099qY6
   5LYe5B/LhoEUEfRMzXqPSFUmUy+eUZzTHg4qP5r8CXUd0Rl8GqapUJSL9
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="327100958"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="327100958"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 01:18:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="550632087"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Dec 2021 01:18:35 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n0KF8-0001cz-GF; Thu, 23 Dec 2021 09:18:34 +0000
Date:   Thu, 23 Dec 2021 17:17:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 58d53ba537f27d9ddcf2c94f5f5bd52b63246b95
Message-ID: <61c43ec2.2mtTOn0Hn5ex2OIE%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 58d53ba537f27d9ddcf2c94f5f5bd52b63246b95  Merge branch 'pm-core' into bleeding-edge

elapsed time: 854m

configs tested: 96
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211223
arm                      pxa255-idp_defconfig
arc                        nsimosci_defconfig
sh                          sdk7786_defconfig
mips                          ath25_defconfig
mips                         tb0287_defconfig
arm                       aspeed_g4_defconfig
arm                          pxa3xx_defconfig
sh                           se7722_defconfig
mips                     cu1000-neo_defconfig
powerpc                         wii_defconfig
mips                            e55_defconfig
arm                  randconfig-c002-20211223
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211222
x86_64               randconfig-a003-20211222
x86_64               randconfig-a005-20211222
x86_64               randconfig-a006-20211222
x86_64               randconfig-a004-20211222
x86_64               randconfig-a002-20211222
i386                 randconfig-a002-20211222
i386                 randconfig-a003-20211222
i386                 randconfig-a001-20211222
i386                 randconfig-a005-20211222
i386                 randconfig-a006-20211222
i386                 randconfig-a004-20211222
x86_64               randconfig-a015-20211223
x86_64               randconfig-a014-20211223
x86_64               randconfig-a011-20211223
x86_64               randconfig-a012-20211223
x86_64               randconfig-a013-20211223
x86_64               randconfig-a016-20211223
i386                 randconfig-a012-20211223
i386                 randconfig-a011-20211223
i386                 randconfig-a013-20211223
i386                 randconfig-a014-20211223
i386                 randconfig-a015-20211223
i386                 randconfig-a016-20211223
arc                  randconfig-r043-20211222
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests

clang tested configs:
hexagon              randconfig-r045-20211222
riscv                randconfig-r042-20211222
s390                 randconfig-r044-20211222
hexagon              randconfig-r041-20211222

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
