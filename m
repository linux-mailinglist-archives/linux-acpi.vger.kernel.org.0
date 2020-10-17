Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA40329108E
	for <lists+linux-acpi@lfdr.de>; Sat, 17 Oct 2020 09:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437501AbgJQHew (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 17 Oct 2020 03:34:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:57432 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437499AbgJQHew (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 17 Oct 2020 03:34:52 -0400
IronPort-SDR: ffWYxgfpm695Wc3hf4TXt7UBTc4aCaChfM5HdifObkdUnMH/ppZiSEn8VSAoVLX/pgGUZrkZwg
 lANWC+0zhutQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9776"; a="153685583"
X-IronPort-AV: E=Sophos;i="5.77,385,1596524400"; 
   d="scan'208";a="153685583"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2020 00:34:51 -0700
IronPort-SDR: u149OFch6qTRlH/ytILhEWV1hPGUqQiaSZ5l27ZW1prNdnAsguTXEdP54Bidar3u9L4wjeBAeL
 OLRNvOph7OGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,386,1596524400"; 
   d="scan'208";a="347432793"
Received: from lkp-server02.sh.intel.com (HELO 262a2cdd3070) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2020 00:34:50 -0700
Received: from kbuild by 262a2cdd3070 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kTgjp-0000Id-Lx; Sat, 17 Oct 2020 07:34:49 +0000
Date:   Sat, 17 Oct 2020 15:33:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [pm:bleeding-edge] BUILD SUCCESS
 c2825af90052036b70e910900491f1e07dd18378
Message-ID: <5f8a9e5f.gwmRF836mrFc3a54%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git  bleeding-edge
branch HEAD: c2825af90052036b70e910900491f1e07dd18378  Merge branch 'pm-avs' into bleeding-edge

elapsed time: 723m

configs tested: 91
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                     tqm8555_defconfig
arc                             nps_defconfig
sh                          rsk7201_defconfig
arm                             mxs_defconfig
mips                        qi_lb60_defconfig
powerpc                      acadia_defconfig
arc                        nsimosci_defconfig
mips                         db1xxx_defconfig
powerpc                   lite5200b_defconfig
m68k                         amcore_defconfig
arc                              alldefconfig
h8300                    h8300h-sim_defconfig
powerpc                    socrates_defconfig
sh                          sdk7780_defconfig
powerpc                    mvme5100_defconfig
m68k                        stmark2_defconfig
sh                        sh7757lcr_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a005-20201016
i386                 randconfig-a006-20201016
i386                 randconfig-a001-20201016
i386                 randconfig-a003-20201016
i386                 randconfig-a004-20201016
i386                 randconfig-a002-20201016
x86_64               randconfig-a016-20201016
x86_64               randconfig-a012-20201016
x86_64               randconfig-a015-20201016
x86_64               randconfig-a013-20201016
x86_64               randconfig-a014-20201016
x86_64               randconfig-a011-20201016
i386                 randconfig-a016-20201016
i386                 randconfig-a013-20201016
i386                 randconfig-a015-20201016
i386                 randconfig-a011-20201016
i386                 randconfig-a012-20201016
i386                 randconfig-a014-20201016
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201016
x86_64               randconfig-a002-20201016
x86_64               randconfig-a006-20201016
x86_64               randconfig-a001-20201016
x86_64               randconfig-a005-20201016
x86_64               randconfig-a003-20201016

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
