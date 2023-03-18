Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECFC6BF875
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Mar 2023 08:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjCRH0r (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Mar 2023 03:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCRH0q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Mar 2023 03:26:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7B541084;
        Sat, 18 Mar 2023 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679124404; x=1710660404;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CfAflA8vXYfK/iNfi95bqTYDl6STUEVh+3kaYzB0TqI=;
  b=bT9W5ujeuJpDfNGDv+dvHxuWLT/l8Hc8LnROqlCLzNzbBPlMhsIsgd38
   CvVKdEdyx4zsB4fCVxjdoaAwd1ARb8JYLH/5DkNjlwOSycgX4ss5Qtv39
   1n48hZZc2HFl2TeR0ErcmbGGyQxPRz/dBn3QkHFJ875JWdme6JsgZNbmX
   an/V9rErHW8uW7WvefMyXNZjlY5UfIQsZhHAD/hERoEbLJHzWOl1vlOdw
   xuzObjIF8pSFIgVkMuQUqXYkGKXCAvyKfcL2WkYHC2yh30dKGLMDI/toG
   2WC7T1vpdeRvBhwTLj7fMQkTCQd1nF5KTZVGfGHHUM3ZD+3Osa8S+wDhY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="338435338"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="338435338"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2023 00:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10652"; a="680535891"
X-IronPort-AV: E=Sophos;i="5.98,271,1673942400"; 
   d="scan'208";a="680535891"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Mar 2023 00:26:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pdQxY-0009ty-31;
        Sat, 18 Mar 2023 07:26:36 +0000
Date:   Sat, 18 Mar 2023 15:26:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 fbb52f459fa642489b835b0416094a37c4723e72
Message-ID: <6415678f.jSS7aAmzcl98bOnB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: fbb52f459fa642489b835b0416094a37c4723e72  Merge branch 'thermal-intel' into bleeding-edge

elapsed time: 723m

configs tested: 138
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230312   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230312   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r022-20230313   gcc  
arc                  randconfig-r026-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230313   gcc  
arm          buildonly-randconfig-r002-20230312   clang
arm          buildonly-randconfig-r005-20230313   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230312   gcc  
arm                  randconfig-r034-20230313   clang
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230313   gcc  
arm64                randconfig-r012-20230313   clang
arm64                randconfig-r013-20230312   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230313   gcc  
csky                 randconfig-r036-20230313   gcc  
hexagon              randconfig-r016-20230313   clang
hexagon              randconfig-r021-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230313   gcc  
i386         buildonly-randconfig-r003-20230313   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230312   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230312   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230312   gcc  
m68k                 randconfig-r032-20230312   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r002-20230312   gcc  
mips                 randconfig-r033-20230312   gcc  
mips                 randconfig-r035-20230312   gcc  
nios2        buildonly-randconfig-r003-20230312   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230312   gcc  
nios2                randconfig-r014-20230312   gcc  
openrisc     buildonly-randconfig-r001-20230312   gcc  
parisc       buildonly-randconfig-r006-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r026-20230313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230312   clang
powerpc              randconfig-r016-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230313   clang
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230313   clang
riscv                randconfig-r024-20230312   gcc  
riscv                randconfig-r024-20230313   clang
riscv                randconfig-r032-20230313   gcc  
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230313   gcc  
s390                 randconfig-r013-20230313   clang
s390                 randconfig-r021-20230312   gcc  
s390                 randconfig-r025-20230312   gcc  
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230313   gcc  
sh                   randconfig-r023-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230313   gcc  
sparc                randconfig-r034-20230312   gcc  
sparc64              randconfig-r006-20230312   gcc  
sparc64              randconfig-r025-20230313   gcc  
sparc64              randconfig-r033-20230313   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r002-20230313   gcc  
x86_64               randconfig-r035-20230313   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230313   gcc  
xtensa               randconfig-r015-20230312   gcc  
xtensa               randconfig-r023-20230312   gcc  
xtensa               randconfig-r036-20230312   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
