Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C58B48087A
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Dec 2021 11:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhL1KkC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Dec 2021 05:40:02 -0500
Received: from mga14.intel.com ([192.55.52.115]:21436 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhL1KkC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 28 Dec 2021 05:40:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640688002; x=1672224002;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=tiRyDOyL5kkRwfgvPqclCj2b1zkGRkJfUXvHFTZE8Ek=;
  b=PODAb+JdrsUEpy6fn1hfMSs26SRcbuLG66/8jNEqtMaECeXe0KqRrRw+
   haYEI/eWpI/bV1wHSPe7RIUgRIGgcK/gFkMcSRBmY2lXlWams3l6fv5BM
   twyj70+HHShbeI0dAttc1sdiE9xU5FA+L13zFVRX03yl3sZ+vjNebJRzG
   lNFfY6PRLYPvWRYU5Tzv2Tg0HgTKs9hVun8BaMVTWBZV0JHrftDMmO7wh
   ZCcvi/nPm8NNGvHHzwEMKCuHZJh0D/6IXSuXkq/Zi5ra3zsisvBiN6yR7
   s4oOPT9uuL/8IufZzoPdrdWGQV42OylrjHHotYvqrN6f5ZyBAFp4/PGlt
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10210"; a="241563998"
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="241563998"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2021 02:40:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,242,1635231600"; 
   d="scan'208";a="469995176"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2021 02:40:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n29tf-0007Uq-HW; Tue, 28 Dec 2021 10:39:59 +0000
Date:   Tue, 28 Dec 2021 18:39:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 86e4182dd2d1465f6446863dd26da97ea069c8a2
Message-ID: <61cae944.Twod0fyG7mT0FqUV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 86e4182dd2d1465f6446863dd26da97ea069c8a2  Merge branch 'acpi-pfrut' into bleeding-edge

Warning reports:

https://lore.kernel.org/llvm/202112280907.gTYYYuB4-lkp@intel.com

Warning in current branch:

drivers/acpi/acpica/exregion.c:519:17: warning: performing pointer subtraction with a null pointer has undefined behavior [-Wnull-pointer-subtraction]

Warning ids grouped by kconfigs:

clang_recent_errors
|-- i386-randconfig-a012-20211228
|   `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-with-a-null-pointer-has-undefined-behavior
`-- x86_64-randconfig-a015-20211228
    `-- drivers-acpi-acpica-exregion.c:warning:performing-pointer-subtraction-with-a-null-pointer-has-undefined-behavior

elapsed time: 721m

configs tested: 102
configs skipped: 3

gcc tested configs:
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm64                               defconfig
arm64                            allyesconfig
i386                 randconfig-c001-20211228
powerpc                 mpc8540_ads_defconfig
mips                        jmr3927_defconfig
powerpc                   microwatt_defconfig
sh                            shmin_defconfig
powerpc                      obs600_defconfig
powerpc                    amigaone_defconfig
sparc                               defconfig
arm                           spitz_defconfig
sh                         ap325rxa_defconfig
powerpc                  mpc866_ads_defconfig
s390                             alldefconfig
sh                              ul2_defconfig
ia64                      gensparse_defconfig
sh                            migor_defconfig
powerpc                           allnoconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
arm                          ixp4xx_defconfig
riscv                          rv32_defconfig
sh                          urquell_defconfig
arm                  randconfig-c002-20211228
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
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
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a001-20211228
x86_64               randconfig-a003-20211228
x86_64               randconfig-a002-20211228
x86_64               randconfig-a005-20211228
x86_64               randconfig-a004-20211228
x86_64               randconfig-a006-20211228
i386                 randconfig-a002-20211228
i386                 randconfig-a003-20211228
i386                 randconfig-a001-20211228
i386                 randconfig-a005-20211228
i386                 randconfig-a006-20211228
i386                 randconfig-a004-20211228
arc                  randconfig-r043-20211228
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                    rhel-8.3-kselftests

clang tested configs:
x86_64               randconfig-a014-20211228
x86_64               randconfig-a013-20211228
x86_64               randconfig-a012-20211228
x86_64               randconfig-a011-20211228
x86_64               randconfig-a016-20211228
x86_64               randconfig-a015-20211228
i386                 randconfig-a012-20211228
i386                 randconfig-a011-20211228
i386                 randconfig-a013-20211228
i386                 randconfig-a014-20211228
i386                 randconfig-a016-20211228
i386                 randconfig-a015-20211228
hexagon              randconfig-r041-20211228
riscv                randconfig-r042-20211228
s390                 randconfig-r044-20211228
hexagon              randconfig-r045-20211228

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
