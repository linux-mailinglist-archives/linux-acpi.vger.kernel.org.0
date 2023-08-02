Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A38F76C556
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Aug 2023 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjHBGfT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 2 Aug 2023 02:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjHBGfS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Aug 2023 02:35:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BA7122;
        Tue,  1 Aug 2023 23:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690958117; x=1722494117;
  h=date:from:to:cc:subject:message-id;
  bh=fgPiCcpWtj+FzHdRH1YAzGX4QGkFNfGElMeEaxYtb00=;
  b=diygFtU2Kp2yrVgKe71CBCP3r16ECNqAu4J8FyRgTTbs5whUnz6SXB6T
   fzFYuVtqjAIoA4kHdsx389IfIBxROdKOtTghbaRfYo4mEUVoHl0N5R8TK
   KrEWleMi4zaed/86lS9yoLg5q3kUsUplszFiAR6b89xQIbEVvrBedtGZ1
   Ec0GtxML5JSDkynUxFaSCJIEciIREf8Hfcw0OATVvrJvJyo8+yVXNknMS
   IItau5Fje2HUuaBCCuuN3ANrO/3xzyruj3h2sGa8kntl2iR6XLtYOweMQ
   zzMooQrF6GGUKeO9pc8f1yKOhvslYjqbwGj/CLOK6i+sg6joBSQesZ+7x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369491831"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="369491831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 23:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="678934692"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="678934692"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 01 Aug 2023 23:35:15 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qR5Ry-0000wp-1o;
        Wed, 02 Aug 2023 06:35:14 +0000
Date:   Wed, 02 Aug 2023 14:35:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 57fb4aeb308cdc2169b440c112bcbbbbdc7b6cc5
Message-ID: <202308021405.25Vb9jo2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 57fb4aeb308cdc2169b440c112bcbbbbdc7b6cc5  Merge branch 'pm-cpuidle' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308020253.WHEHp60K-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/acpi/thermal.c:1028:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]
drivers/acpi/thermal.c:1184:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- arm64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i052-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i053-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i062-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-m021-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x051-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
`-- x86_64-randconfig-x052-20230730
    `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used

elapsed time: 859m

configs tested: 122
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230801   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r005-20230731   gcc  
arc                  randconfig-r023-20230731   gcc  
arc                  randconfig-r043-20230801   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r046-20230801   gcc  
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230801   clang
hexagon              randconfig-r045-20230801   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i016-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230731   gcc  
loongarch            randconfig-r012-20230731   gcc  
loongarch            randconfig-r014-20230731   gcc  
loongarch            randconfig-r026-20230731   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze           randconfig-r021-20230731   gcc  
microblaze           randconfig-r022-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                     loongson1b_defconfig   gcc  
mips                          malta_defconfig   clang
mips                 randconfig-r002-20230731   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r024-20230731   gcc  
openrisc             randconfig-r034-20230801   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230731   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                     ep8248e_defconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm8555_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230801   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230801   clang
sh                               allmodconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                   randconfig-r001-20230731   gcc  
sh                   randconfig-r006-20230731   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230801   gcc  
sparc64              randconfig-r031-20230801   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230731   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
