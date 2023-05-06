Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3676F909C
	for <lists+linux-acpi@lfdr.de>; Sat,  6 May 2023 10:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjEFIgK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 6 May 2023 04:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFIgK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 6 May 2023 04:36:10 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC2E659F;
        Sat,  6 May 2023 01:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683362168; x=1714898168;
  h=date:from:to:cc:subject:message-id;
  bh=+GAyhS8rOCjpR96ucmfnR3s22x5B9ZLcQ6I4c0R2EsI=;
  b=WaGGbX+Ly9iCDahGoQ/9xI04T8fRxzMzeNA++zXhVhPBzZODwBEO6Mx5
   GgsJk3fbC9FheHmlvauPWiQUWcHsV62vwVAkfxLVrXSi2vPqnnNII6h54
   wDFnBOoKbe8mSccOyBbChxBIzZyGuq2aqt6K+GzEsjxC467PniGEgOScz
   eAi0tiOQyVt1j0DA5enBSe0AknJvmWRiLVXZCKRdWLgwMqHhlom9sAqRG
   dtRNOgnP6vvnnLBAiR7CoNUefUDuMiT8Vm6VeEhKM8IHFsE42Td0lWBOk
   r85mKx9K4U61WfZBSH7r7WgU7j4+cFf4v+qTMZacZG6B9cfaNar0FHb5B
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="352416132"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="352416132"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2023 01:36:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="762759788"
X-IronPort-AV: E=Sophos;i="5.99,254,1677571200"; 
   d="scan'208";a="762759788"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 May 2023 01:36:06 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pvDOf-00003t-2N;
        Sat, 06 May 2023 08:36:05 +0000
Date:   Sat, 06 May 2023 16:35:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 170e7b17571df81a831d1018a6ffa58fe6d7eeb9
Message-ID: <20230506083512.5Bfw2%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 170e7b17571df81a831d1018a6ffa58fe6d7eeb9  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 725m

configs tested: 199
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230505   gcc  
alpha        buildonly-randconfig-r006-20230502   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230505   gcc  
alpha                randconfig-r014-20230502   gcc  
alpha                randconfig-r031-20230501   gcc  
alpha                randconfig-r034-20230430   gcc  
alpha                randconfig-r036-20230502   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230501   gcc  
arc          buildonly-randconfig-r006-20230430   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230505   gcc  
arc                  randconfig-r015-20230502   gcc  
arc                  randconfig-r023-20230505   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arc                  randconfig-r043-20230504   gcc  
arc                  randconfig-r043-20230505   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230430   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230505   clang
arm                  randconfig-r015-20230430   gcc  
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm                  randconfig-r046-20230504   clang
arm                  randconfig-r046-20230505   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230505   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230430   gcc  
arm64                randconfig-r015-20230504   gcc  
arm64                randconfig-r016-20230502   gcc  
arm64                randconfig-r023-20230430   clang
arm64                randconfig-r024-20230430   clang
arm64                randconfig-r026-20230430   clang
csky         buildonly-randconfig-r005-20230501   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230501   gcc  
csky                 randconfig-r036-20230430   gcc  
hexagon      buildonly-randconfig-r001-20230505   clang
hexagon      buildonly-randconfig-r003-20230502   clang
hexagon              randconfig-r013-20230430   clang
hexagon              randconfig-r013-20230504   clang
hexagon              randconfig-r014-20230501   clang
hexagon              randconfig-r016-20230501   clang
hexagon              randconfig-r016-20230504   clang
hexagon              randconfig-r035-20230501   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r041-20230504   clang
hexagon              randconfig-r041-20230505   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
hexagon              randconfig-r045-20230504   clang
hexagon              randconfig-r045-20230505   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230430   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r014-20230505   gcc  
loongarch            randconfig-r015-20230501   gcc  
loongarch            randconfig-r024-20230505   gcc  
loongarch            randconfig-r031-20230502   gcc  
loongarch            randconfig-r034-20230502   gcc  
loongarch            randconfig-r036-20230501   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230504   gcc  
m68k                 randconfig-r004-20230430   gcc  
m68k                 randconfig-r006-20230504   gcc  
m68k                 randconfig-r024-20230502   gcc  
m68k                 randconfig-r034-20230501   gcc  
microblaze           randconfig-r001-20230430   gcc  
microblaze           randconfig-r012-20230504   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230502   gcc  
mips                 randconfig-r003-20230505   clang
mips                 randconfig-r011-20230504   clang
mips                 randconfig-r012-20230505   gcc  
nios2        buildonly-randconfig-r002-20230502   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230504   gcc  
nios2                randconfig-r013-20230505   gcc  
openrisc     buildonly-randconfig-r004-20230430   gcc  
openrisc     buildonly-randconfig-r006-20230505   gcc  
openrisc             randconfig-r003-20230501   gcc  
openrisc             randconfig-r006-20230501   gcc  
openrisc             randconfig-r011-20230430   gcc  
openrisc             randconfig-r022-20230502   gcc  
openrisc             randconfig-r022-20230505   gcc  
openrisc             randconfig-r026-20230502   gcc  
openrisc             randconfig-r035-20230502   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230504   gcc  
parisc               randconfig-r003-20230430   gcc  
parisc               randconfig-r004-20230505   gcc  
parisc               randconfig-r011-20230502   gcc  
parisc               randconfig-r032-20230430   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r001-20230501   gcc  
powerpc              randconfig-r001-20230504   clang
powerpc              randconfig-r013-20230501   clang
powerpc              randconfig-r021-20230430   clang
powerpc              randconfig-r023-20230502   gcc  
powerpc              randconfig-r031-20230430   gcc  
powerpc              randconfig-r033-20230501   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230505   gcc  
riscv                randconfig-r013-20230502   gcc  
riscv                randconfig-r014-20230430   clang
riscv                randconfig-r015-20230505   clang
riscv                randconfig-r032-20230501   gcc  
riscv                randconfig-r035-20230430   gcc  
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                randconfig-r042-20230504   gcc  
riscv                randconfig-r042-20230505   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230501   clang
s390         buildonly-randconfig-r004-20230502   gcc  
s390         buildonly-randconfig-r005-20230502   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r021-20230502   gcc  
s390                 randconfig-r022-20230501   clang
s390                 randconfig-r023-20230501   clang
s390                 randconfig-r025-20230430   clang
s390                 randconfig-r033-20230502   clang
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
s390                 randconfig-r044-20230504   gcc  
s390                 randconfig-r044-20230505   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r002-20230501   gcc  
sh                   randconfig-r006-20230430   gcc  
sh                   randconfig-r025-20230502   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230501   gcc  
sparc                randconfig-r005-20230504   gcc  
sparc                randconfig-r033-20230430   gcc  
sparc64      buildonly-randconfig-r003-20230430   gcc  
sparc64              randconfig-r011-20230501   gcc  
sparc64              randconfig-r012-20230430   gcc  
sparc64              randconfig-r012-20230501   gcc  
sparc64              randconfig-r016-20230505   gcc  
sparc64              randconfig-r021-20230505   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64               randconfig-r004-20230501   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230430   gcc  
xtensa               randconfig-r001-20230505   gcc  
xtensa               randconfig-r022-20230430   gcc  
xtensa               randconfig-r025-20230501   gcc  
xtensa               randconfig-r026-20230501   gcc  
xtensa               randconfig-r026-20230505   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
