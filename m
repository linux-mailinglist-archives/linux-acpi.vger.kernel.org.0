Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7544E754745
	for <lists+linux-acpi@lfdr.de>; Sat, 15 Jul 2023 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGOHoL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 15 Jul 2023 03:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjGOHoL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Jul 2023 03:44:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841B035B3;
        Sat, 15 Jul 2023 00:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689407049; x=1720943049;
  h=date:from:to:cc:subject:message-id;
  bh=ehtHmDNW5Iv8jFhAIarNgyBP4yo1wFV2cS32VFlX8mI=;
  b=TRVNAfO9Q9fpNrtV6p8RsEfSXxTnh96t6K9wi97SeNOxMQmLVajGhXao
   8INaU6LU1U3I0+7WeEJ1EdPz732JivPyJwJs6DBPKgwNoOaZTSNLDnn8q
   3g9fIgKGehKSqXFZW0BjiDMONRPKlo/2/x8FQmADyj5jy3rV+GmjSTHwL
   vrkWzQ2QCR2xvOrBrz8nY6XHSi5MH2MaOIWzQox0lVJk12OL45yp4Xodw
   Fo8yhB3+SW8ZApw6NoirqnFjA+sCG5IL+jgDFMs7CE3QLgp3dmRmcBqQ2
   iX1i25a7moo9nYTNUEd10YKoftTappGCAyXm3TvS4CfcvfOisxzkWMvtd
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="396456696"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="396456696"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2023 00:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="699945390"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="699945390"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jul 2023 00:43:53 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qKZwX-00080r-01;
        Sat, 15 Jul 2023 07:43:53 +0000
Date:   Sat, 15 Jul 2023 15:43:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736
Message-ID: <202307151541.rZTx7h5Q-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4f9dd7927c1cdbaffb20fcdbcc2bdc6caa0b4736  Merge branch 'pm-cpuidle' into bleeding-edge

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202307150306.FvaBEkzg-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307150527.HDJ9XJMo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307150552.aLyOhzH2-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202307150637.CGq9exEE-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/acpi/dptf/../internal.h:161:6: warning: no previous prototype for 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
drivers/acpi/dptf/../internal.h:161:6: warning: no previous prototype for function 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
drivers/acpi/internal.h:161: multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:drivers/acpi/internal.h:161: first defined here
drivers/acpi/internal.h:161:6: warning: no previous prototype for 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
drivers/acpi/internal.h:161:6: warning: no previous prototype for function 'acpi_early_processor_control_setup' [-Wmissing-prototypes]
ld.lld: error: duplicate symbol: acpi_early_processor_control_setup
osi.c:(.text+0x134): multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:tables.c:(.text+0x0): first defined here
osi.c:(.text+0x168): multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:tables.c:(.text+0x0): first defined here
osi.c:(.text+0x408): multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:tables.c:(.text+0x948): first defined here
osi.c:(.text.acpi_early_processor_control_setup+0x0): multiple definition of `acpi_early_processor_control_setup'; drivers/acpi/tables.o:tables.c:(.text.acpi_early_processor_control_setup+0x0): first defined here

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   |-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- multiple-definition-of-acpi_early_processor_control_setup-drivers-acpi-tables.o:tables.c:(.text):first-defined-here
|-- arm64-defconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   |-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- multiple-definition-of-acpi_early_processor_control_setup-drivers-acpi-tables.o:drivers-acpi-internal.h:first-defined-here
|-- loongarch-allmodconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|-- loongarch-allnoconfig
|   `-- multiple-definition-of-acpi_early_processor_control_setup-drivers-acpi-tables.o:tables.c:(.text):first-defined-here
|-- loongarch-allyesconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|-- riscv-allmodconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   |-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- multiple-definition-of-acpi_early_processor_control_setup-drivers-acpi-tables.o:tables.c:(.text.acpi_early_processor_control_setup):first-defined-here
|-- riscv-allyesconfig
|   |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
|   `-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
`-- riscv-defconfig
    |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
    |-- drivers-acpi-internal.h:warning:no-previous-prototype-for-acpi_early_processor_control_setup
    `-- multiple-definition-of-acpi_early_processor_control_setup-drivers-acpi-tables.o:tables.c:(.text):first-defined-here
clang_recent_errors
`-- arm64-randconfig-r021-20230714
    |-- drivers-acpi-dptf-..-internal.h:warning:no-previous-prototype-for-function-acpi_early_processor_control_setup
    |-- drivers-acpi-internal.h:warning:no-previous-prototype-for-function-acpi_early_processor_control_setup
    `-- ld.lld:error:duplicate-symbol:acpi_early_processor_control_setup

elapsed time: 723m

configs tested: 125
configs skipped: 4

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r035-20230714   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                  randconfig-r021-20230715   gcc  
arc                  randconfig-r043-20230714   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                         mv78xx0_defconfig   clang
arm                        mvebu_v5_defconfig   clang
arm                         nhk8815_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                  randconfig-r003-20230714   clang
arm                  randconfig-r046-20230714   gcc  
arm                          sp7021_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r001-20230714   clang
hexagon              randconfig-r041-20230714   clang
hexagon              randconfig-r045-20230714   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230714   gcc  
i386         buildonly-randconfig-r005-20230714   gcc  
i386         buildonly-randconfig-r006-20230714   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230714   gcc  
i386                 randconfig-i002-20230714   gcc  
i386                 randconfig-i003-20230714   gcc  
i386                 randconfig-i004-20230714   gcc  
i386                 randconfig-i005-20230714   gcc  
i386                 randconfig-i006-20230714   gcc  
i386                 randconfig-i011-20230714   clang
i386                 randconfig-i012-20230714   clang
i386                 randconfig-i013-20230714   clang
i386                 randconfig-i014-20230714   clang
i386                 randconfig-i015-20230714   clang
i386                 randconfig-i016-20230714   clang
i386                 randconfig-r024-20230715   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r005-20230714   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r031-20230714   gcc  
microblaze           randconfig-r015-20230714   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230714   gcc  
nios2                randconfig-r014-20230714   gcc  
nios2                randconfig-r022-20230715   gcc  
openrisc             randconfig-r023-20230715   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230714   gcc  
parisc               randconfig-r026-20230715   gcc  
parisc               randconfig-r032-20230714   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc                         wii_defconfig   gcc  
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230714   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230714   clang
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r004-20230714   gcc  
sh                        sh7785lcr_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230714   gcc  
sparc64              randconfig-r025-20230715   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r011-20230714   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230714   gcc  
x86_64       buildonly-randconfig-r002-20230714   gcc  
x86_64       buildonly-randconfig-r003-20230714   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230714   clang
x86_64               randconfig-x002-20230714   clang
x86_64               randconfig-x003-20230714   clang
x86_64               randconfig-x005-20230714   clang
x86_64               randconfig-x006-20230714   clang
x86_64               randconfig-x011-20230714   gcc  
x86_64               randconfig-x012-20230714   gcc  
x86_64               randconfig-x013-20230714   gcc  
x86_64               randconfig-x014-20230714   gcc  
x86_64               randconfig-x015-20230714   gcc  
x86_64               randconfig-x016-20230714   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230714   gcc  
xtensa               randconfig-r033-20230714   gcc  
xtensa               randconfig-r036-20230714   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
