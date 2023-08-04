Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3677015B
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Aug 2023 15:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjHDNVw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 4 Aug 2023 09:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjHDNVg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Aug 2023 09:21:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FAF61A7;
        Fri,  4 Aug 2023 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691155180; x=1722691180;
  h=date:from:to:cc:subject:message-id;
  bh=wU1Q6gXCsJtOA6HKky8pz4KIFO/dlUQnZqUJXMI5yU0=;
  b=JOeqljILsl3A5cR9TNPQH0lsV+it+K9QT/Gu+YwbHaCiPjuoOlcQADzO
   2k63J3zQ6zVKoqT1JcY1LFjmBYrImjUWkUgC0N/jLwSGJe+dWW9yMvEv3
   lI6zHoS/h19cdT9xczpyk2ZmQZ4sXc9HW+F5chY0Y1dMYvtJkQhHhKSnz
   FYt4beEpSOjmhClXRRcuPNPUbNlx2XaQdbMbRsSu82XY98amxNBDokyw6
   49V/nqrqZ2ghXUgBjNB2VYDpu54tcQDuNG3egUnrIF5k5qdzPaDXqsKSm
   SJa3Srs18Jm4i14uzcrCbE0bap3r5cBoyPIQqfkkq4f04ikHugBdBVb9b
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="372897292"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="372897292"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 06:18:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="820128155"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="820128155"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Aug 2023 06:18:26 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRuhF-0002rx-2t;
        Fri, 04 Aug 2023 13:18:25 +0000
Date:   Fri, 04 Aug 2023 21:17:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 f20cf9380d2943d4ccb835e329168badc713fccf
Message-ID: <202308042147.94du9tOE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f20cf9380d2943d4ccb835e329168badc713fccf  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202308020253.WHEHp60K-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/acpi/thermal.c:1042:32: warning: variable 'result' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- arm64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-debian-10.3
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i001-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i002-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i004-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-i006-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- i386-randconfig-m021-20230730
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allmodconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- loongarch-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-allyesconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-buildonly-randconfig-r002-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-defconfig
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-kexec
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x011-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x013-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x014-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x015-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
|-- x86_64-randconfig-x016-20230731
|   `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used
`-- x86_64-rhel-8.3
    `-- drivers-acpi-thermal.c:warning:variable-result-set-but-not-used

elapsed time: 951m

configs tested: 118
configs skipped: 3

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230731   gcc  
alpha                randconfig-r026-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r003-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r004-20230731   clang
arm                  randconfig-r011-20230801   gcc  
arm                  randconfig-r032-20230801   clang
arm                  randconfig-r046-20230731   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230731   clang
csky                                defconfig   gcc  
csky                 randconfig-r034-20230801   gcc  
hexagon              randconfig-r022-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
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
i386                 randconfig-r033-20230801   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230801   gcc  
m68k                 randconfig-r025-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   clang
mips                 randconfig-r002-20230731   clang
mips                       rbtx49xx_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r024-20230731   gcc  
openrisc             randconfig-r015-20230801   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                      ep88xc_defconfig   gcc  
powerpc                      katmai_defconfig   clang
powerpc              randconfig-r001-20230731   gcc  
powerpc              randconfig-r036-20230801   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230801   clang
riscv                randconfig-r042-20230731   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230801   gcc  
s390                 randconfig-r044-20230731   clang
sh                               allmodconfig   gcc  
sh                 kfr2r09-romimage_defconfig   gcc  
sh                   randconfig-r031-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r006-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230801   gcc  
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
xtensa                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
