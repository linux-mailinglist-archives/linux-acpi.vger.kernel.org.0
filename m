Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1AE7772DD
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 10:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjHJI1J (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Aug 2023 04:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234382AbjHJI1H (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2023 04:27:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4901BCF;
        Thu, 10 Aug 2023 01:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691656026; x=1723192026;
  h=date:from:to:cc:subject:message-id;
  bh=DJ5mRzZTvB0IPNRw4ZYrQBwlV4zuLDV+mUbsfDnSjOg=;
  b=D8HSv2DyLzqc1AI4/lWzRDo3sfPaN3RM62ZGyAe6jZJ6tSfBGYh4j3l1
   pLYe7oD0DxxO61xXVUWAqitgEU9D1ANrEU/Q9bZxFtCTESofyR1jeMxg0
   jWMWVYXNT3ARghGSoRGn+DNSwhjTa6stxb8Vt27wjDx20Y3vDKQe9qX6s
   KWMMascLhpxnhZ5zQpTgrXhONSSvJaW5SogOhqdgVFevBEeWaIBn6on46
   mP+PXY9KnEdCMv7NH0bhjG959srORrgUdl7inWaKX+vuLGYCRxYFEdcCx
   /w/zwrymJ1Dhyzy/5Wyv5AwVmgIDaUu0CiTm1SolhUNKgSmFfBhfdgRaZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="402296900"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="402296900"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 01:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="725702028"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="725702028"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 01:27:04 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qU10Z-0006r5-19;
        Thu, 10 Aug 2023 08:27:03 +0000
Date:   Thu, 10 Aug 2023 16:26:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 d8094e7904c2148417eb46e618fdf9649bb01e76
Message-ID: <202308101621.jjROtMGW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d8094e7904c2148417eb46e618fdf9649bb01e76  Merge branch 'acpi-thermal-next' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308020253.WHEHp60K-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/acpi/thermal.c:1008:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- arm64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-buildonly-randconfig-r005-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-debian-10.3
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i001-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i002-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i003-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i004-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i005-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allmodconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-kexec
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x012-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x014-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x016-20230809
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
`-- x86_64-rhel-8.3
    `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used

elapsed time: 722m

configs tested: 105
configs skipped: 6

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r006-20230809   gcc  
alpha                randconfig-r025-20230809   gcc  
alpha                randconfig-r034-20230809   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230809   gcc  
arc                  randconfig-r043-20230809   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230809   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230809   clang
arm64                randconfig-r024-20230809   clang
arm64                randconfig-r033-20230809   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230809   clang
hexagon              randconfig-r045-20230809   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230809   gcc  
i386         buildonly-randconfig-r005-20230809   gcc  
i386         buildonly-randconfig-r006-20230809   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230809   gcc  
i386                 randconfig-i002-20230809   gcc  
i386                 randconfig-i003-20230809   gcc  
i386                 randconfig-i004-20230809   gcc  
i386                 randconfig-i005-20230809   gcc  
i386                 randconfig-i006-20230809   gcc  
i386                 randconfig-i011-20230809   clang
i386                 randconfig-i012-20230809   clang
i386                 randconfig-i013-20230809   clang
i386                 randconfig-i014-20230809   clang
i386                 randconfig-i015-20230809   clang
i386                 randconfig-i016-20230809   clang
i386                 randconfig-r011-20230809   clang
i386                 randconfig-r014-20230809   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230809   clang
nios2                               defconfig   gcc  
nios2                randconfig-r035-20230809   gcc  
openrisc             randconfig-r021-20230809   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230809   gcc  
parisc               randconfig-r026-20230809   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230809   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230809   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r031-20230809   gcc  
sparc                randconfig-r032-20230809   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230809   clang
um                   randconfig-r004-20230809   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230809   gcc  
x86_64       buildonly-randconfig-r002-20230809   gcc  
x86_64       buildonly-randconfig-r003-20230809   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230809   clang
x86_64               randconfig-x002-20230809   clang
x86_64               randconfig-x003-20230809   clang
x86_64               randconfig-x004-20230809   clang
x86_64               randconfig-x005-20230809   clang
x86_64               randconfig-x006-20230809   clang
x86_64               randconfig-x011-20230809   gcc  
x86_64               randconfig-x012-20230809   gcc  
x86_64               randconfig-x013-20230809   gcc  
x86_64               randconfig-x014-20230809   gcc  
x86_64               randconfig-x015-20230809   gcc  
x86_64               randconfig-x016-20230809   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r016-20230809   gcc  
xtensa               randconfig-r036-20230809   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
