Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BE7740A8E
	for <lists+linux-acpi@lfdr.de>; Wed, 28 Jun 2023 10:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjF1IHD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 28 Jun 2023 04:07:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:37884 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232964AbjF1IDe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 28 Jun 2023 04:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687939414; x=1719475414;
  h=date:from:to:cc:subject:message-id;
  bh=W+v8nOmQIWr2c1pMFo9exl/PrPSS1dJPCRsv0RHbKNc=;
  b=BTCzlDbQf3PMicbamc7xEqbVWorFk98MZJBQdDmQ6yzauaULI0ZLJJWw
   pQBwWXy//HmkY+0nLdcWbKbcBxLY3GV0IybGTmHYqmNEiyeDyPLFGsm05
   QAMrhObyBbhn9CP4c/hISRtQCQjLsCeXppBC0sqsWLpaAAokvU1SSanvr
   XMrbvW/m2IJHi6CsBRFLgll8gSOF8Ejq8G3AH7cuorq/2hGPcoF8sVNiT
   vQ11eXG03e4tRqbRej451scu5o2lsMkKE55EBJm/JL7dX985SE2eHeSPw
   YlbBGPOrCAVltXmYrP9emrkOKKz3ZGVAfJsc9Ts/fMqfNOa1CD7iy9HFo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="360625099"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="360625099"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 00:31:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10754"; a="840968432"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="840968432"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 28 Jun 2023 00:31:21 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEPe4-000D4X-1x;
        Wed, 28 Jun 2023 07:31:20 +0000
Date:   Wed, 28 Jun 2023 15:30:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1d70c4c81b3511cd494d475eee1f111a5db59290
Message-ID: <202306281545.CtV06mbw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 1d70c4c81b3511cd494d475eee1f111a5db59290  Merge branch 'pm-opp' into linux-next

elapsed time: 731m

configs tested: 147
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230627   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230627   gcc  
arc                  randconfig-r036-20230627   gcc  
arc                  randconfig-r043-20230627   gcc  
arc                        vdk_hs38_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                         axm55xx_defconfig   gcc  
arm                                 defconfig   gcc  
arm                        neponset_defconfig   clang
arm                  randconfig-r001-20230627   clang
arm                  randconfig-r005-20230627   clang
arm                  randconfig-r016-20230627   gcc  
arm                  randconfig-r046-20230627   gcc  
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230627   gcc  
csky                 randconfig-r031-20230627   gcc  
hexagon              randconfig-r041-20230627   clang
hexagon              randconfig-r045-20230627   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230627   gcc  
i386         buildonly-randconfig-r005-20230627   gcc  
i386         buildonly-randconfig-r006-20230627   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230627   gcc  
i386                 randconfig-i001-20230628   clang
i386                 randconfig-i002-20230627   gcc  
i386                 randconfig-i002-20230628   clang
i386                 randconfig-i003-20230627   gcc  
i386                 randconfig-i003-20230628   clang
i386                 randconfig-i004-20230627   gcc  
i386                 randconfig-i004-20230628   clang
i386                 randconfig-i005-20230627   gcc  
i386                 randconfig-i005-20230628   clang
i386                 randconfig-i006-20230627   gcc  
i386                 randconfig-i006-20230628   clang
i386                 randconfig-i011-20230627   clang
i386                 randconfig-i012-20230627   clang
i386                 randconfig-i013-20230627   clang
i386                 randconfig-i014-20230627   clang
i386                 randconfig-i015-20230627   clang
i386                 randconfig-i016-20230627   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230627   gcc  
loongarch            randconfig-r034-20230627   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230627   gcc  
m68k                 randconfig-r016-20230627   gcc  
m68k                 randconfig-r036-20230627   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230627   clang
mips                 randconfig-r014-20230627   gcc  
mips                 randconfig-r023-20230627   gcc  
mips                 randconfig-r025-20230627   gcc  
mips                          rb532_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230627   gcc  
nios2                randconfig-r004-20230627   gcc  
nios2                randconfig-r035-20230627   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r006-20230627   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230627   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                    gamecube_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc              randconfig-r012-20230627   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230627   clang
riscv                randconfig-r042-20230627   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230627   gcc  
s390                 randconfig-r012-20230627   clang
s390                 randconfig-r033-20230627   gcc  
s390                 randconfig-r044-20230627   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r024-20230627   gcc  
sh                   randconfig-r025-20230627   gcc  
sh                   randconfig-r026-20230627   gcc  
sh                          rsk7203_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230627   gcc  
sparc64              randconfig-r005-20230627   gcc  
sparc64              randconfig-r032-20230627   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230627   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230627   gcc  
x86_64       buildonly-randconfig-r002-20230627   gcc  
x86_64       buildonly-randconfig-r003-20230627   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230627   clang
x86_64               randconfig-x002-20230627   clang
x86_64               randconfig-x003-20230627   clang
x86_64               randconfig-x004-20230627   clang
x86_64               randconfig-x005-20230627   clang
x86_64               randconfig-x006-20230627   clang
x86_64               randconfig-x011-20230627   gcc  
x86_64               randconfig-x012-20230627   gcc  
x86_64               randconfig-x013-20230627   gcc  
x86_64               randconfig-x014-20230627   gcc  
x86_64               randconfig-x015-20230627   gcc  
x86_64               randconfig-x016-20230627   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230627   gcc  
xtensa               randconfig-r022-20230627   gcc  
xtensa               randconfig-r023-20230627   gcc  
xtensa               randconfig-r031-20230627   gcc  
xtensa               randconfig-r033-20230627   gcc  
xtensa               randconfig-r034-20230627   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
