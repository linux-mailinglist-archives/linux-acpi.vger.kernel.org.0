Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48296A9145
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 07:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjCCGzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 01:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCCGzJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 01:55:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41865EFA1;
        Thu,  2 Mar 2023 22:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677826504; x=1709362504;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0QjW6tkdRtJOoLbLN87Z7ElWynbVR4HANDk+HL2UB+c=;
  b=CKcP42EMzhJop3dCtnALZfQYruZ7no5AikbYtiHy4dflMTNI1xmlgocy
   USIvht+j0pP6CuGlMZ0zP7Z/AipYOxIu71bdQDz5SeeIX7iSPkizzU9Cc
   poXxpXAZDIdqPrtDHGwx+fIWYVX0CGyO69Ni57iD5pIoWdNw0WDDaXXZp
   GCOsIJmK1u7Jo3qTrxLbuDh+xtaVNMm/pgcaQ82PCZkIrqPWlE4KotW16
   n6n126yqRfIJa6V8ZM7i4dQ+p+kszvtHOzNQ6PpGnC/8TeqFCzNnDpJFZ
   IsZENvqya7/moJwf9yxHZQaZLR7rpjXxADRKzB9QKx/tZYrzSPlXjyqx9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318796089"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="318796089"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 22:54:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="677534096"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="677534096"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Mar 2023 22:54:52 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXzJc-0001HD-04;
        Fri, 03 Mar 2023 06:54:52 +0000
Date:   Fri, 03 Mar 2023 14:53:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a922b2afa144b354c914ade31bd5b0df258f1c94
Message-ID: <64019986.Iz3/1CtPwPQfcBs8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a922b2afa144b354c914ade31bd5b0df258f1c94  Merge branch 'thermal-intel' into linux-next

elapsed time: 725m

configs tested: 160
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r004-20230303   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230302   gcc  
alpha                randconfig-r005-20230302   gcc  
alpha                randconfig-r036-20230302   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230302   gcc  
arc                  randconfig-r014-20230302   gcc  
arc                  randconfig-r015-20230302   gcc  
arc                  randconfig-r016-20230303   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230302   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                  randconfig-r002-20230302   clang
arm                  randconfig-r021-20230302   gcc  
arm                  randconfig-r031-20230302   clang
arm                  randconfig-r032-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230303   clang
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230302   clang
arm64                randconfig-r024-20230302   clang
arm64                randconfig-r034-20230302   gcc  
arm64                randconfig-r035-20230302   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230302   gcc  
csky                 randconfig-r036-20230302   gcc  
hexagon      buildonly-randconfig-r001-20230302   clang
hexagon              randconfig-r002-20230302   clang
hexagon              randconfig-r006-20230302   clang
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
i386                          randconfig-c001   gcc  
ia64                             allmodconfig   gcc  
ia64                             allyesconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230302   gcc  
ia64                 randconfig-r023-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230302   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230303   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230302   gcc  
m68k                 randconfig-r003-20230302   gcc  
m68k                 randconfig-r022-20230302   gcc  
m68k                 randconfig-r033-20230302   gcc  
m68k                 randconfig-r035-20230302   gcc  
microblaze   buildonly-randconfig-r001-20230302   gcc  
microblaze   buildonly-randconfig-r002-20230302   gcc  
microblaze   buildonly-randconfig-r005-20230303   gcc  
microblaze           randconfig-r011-20230302   gcc  
microblaze           randconfig-r012-20230302   gcc  
microblaze           randconfig-r015-20230302   gcc  
microblaze           randconfig-r025-20230302   gcc  
microblaze           randconfig-r026-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r005-20230302   clang
mips                     decstation_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                       lemote2f_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                        qi_lb60_defconfig   clang
mips                 randconfig-r006-20230302   clang
mips                 randconfig-r013-20230302   gcc  
mips                           rs90_defconfig   clang
mips                   sb1250_swarm_defconfig   clang
mips                           xway_defconfig   gcc  
nios2        buildonly-randconfig-r006-20230302   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230302   gcc  
openrisc             randconfig-r026-20230302   gcc  
openrisc             randconfig-r032-20230302   gcc  
parisc       buildonly-randconfig-r003-20230302   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        fsp2_defconfig   clang
powerpc              randconfig-r012-20230303   gcc  
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230302   clang
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230303   gcc  
riscv                randconfig-r022-20230302   clang
riscv                randconfig-r024-20230302   clang
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230302   clang
s390                                defconfig   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230303   gcc  
sh           buildonly-randconfig-r006-20230302   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                   randconfig-r013-20230303   gcc  
sh                   randconfig-r021-20230302   gcc  
sh                          sdk7786_defconfig   gcc  
sparc        buildonly-randconfig-r001-20230303   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230302   gcc  
sparc64              randconfig-r011-20230302   gcc  
sparc64              randconfig-r023-20230302   gcc  
sparc64              randconfig-r025-20230302   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r014-20230303   gcc  
xtensa               randconfig-r034-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
