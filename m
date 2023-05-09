Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E96FBEC3
	for <lists+linux-acpi@lfdr.de>; Tue,  9 May 2023 07:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjEIFhE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 May 2023 01:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEIFhD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 May 2023 01:37:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C244C26;
        Mon,  8 May 2023 22:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683610622; x=1715146622;
  h=date:from:to:cc:subject:message-id;
  bh=N/7M4UOAj2Vru/560/Jjzu0vJb/bHyVLcmek9i2lp+A=;
  b=MGTQgQICdzOybjK6w7HoBtL+oCY7TCo17EAJQ/QF6Dw0eEtUCI4sFtu7
   fSNx9uT+bUrwKO96xEHiOMXkp36Mus+yZwPKS9fQC5OkYRFJQRz4bnnoi
   olhERBisufDjwc1dshI1iIoUYsYEJLD4Byibntx8YEQzRmtkZDTXVxxt4
   8Rl/4TgbA9GDfFL9+5MzDTDV3Q2yPhF4sr3uhsX6dhmNUS2VS4ZQvZcHu
   f9bJcSETd4VmnDAwLVoBVnadc7kXS6DvmBoMpdM308lDA1G/bGn8GC8uM
   3WNiHb6QxeEVTUKwYS7jxhacn8gxnDRq5yCm2Pccq7/g5LesEtMFk+OM5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="347275206"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="347275206"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 22:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822931438"
X-IronPort-AV: E=Sophos;i="5.99,261,1677571200"; 
   d="scan'208";a="822931438"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 08 May 2023 22:37:00 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pwG1z-0001lU-2r;
        Tue, 09 May 2023 05:36:59 +0000
Date:   Tue, 09 May 2023 13:36:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 85de455f3aad3a3b44a411aa32449cec478c737c
Message-ID: <20230509053610.n3VSC%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 85de455f3aad3a3b44a411aa32449cec478c737c  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 720m

configs tested: 124
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230507   gcc  
alpha        buildonly-randconfig-r005-20230508   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230508   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230507   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230507   clang
arm                  randconfig-r024-20230507   gcc  
arm                  randconfig-r046-20230507   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230507   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230508   gcc  
csky                 randconfig-r014-20230508   gcc  
hexagon              randconfig-r001-20230507   clang
hexagon              randconfig-r011-20230508   clang
hexagon              randconfig-r023-20230508   clang
hexagon              randconfig-r041-20230507   clang
hexagon              randconfig-r045-20230507   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230508   clang
i386                 randconfig-a002-20230508   clang
i386                 randconfig-a003-20230508   clang
i386                 randconfig-a004-20230508   clang
i386                 randconfig-a005-20230508   clang
i386                 randconfig-a006-20230508   clang
i386                 randconfig-a011-20230508   gcc  
i386                 randconfig-a012-20230508   gcc  
i386                 randconfig-a013-20230508   gcc  
i386                 randconfig-a014-20230508   gcc  
i386                 randconfig-a015-20230508   gcc  
i386                 randconfig-a016-20230508   gcc  
i386                 randconfig-r015-20230508   gcc  
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230507   gcc  
ia64                 randconfig-r025-20230508   gcc  
ia64                 randconfig-r026-20230507   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230508   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230508   gcc  
loongarch            randconfig-r014-20230507   gcc  
loongarch            randconfig-r024-20230508   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230508   gcc  
microblaze           randconfig-r004-20230508   gcc  
microblaze           randconfig-r011-20230507   gcc  
microblaze           randconfig-r013-20230507   gcc  
microblaze           randconfig-r015-20230507   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230507   clang
mips                 randconfig-r016-20230507   gcc  
mips                 randconfig-r033-20230507   clang
mips                 randconfig-r034-20230507   clang
nios2        buildonly-randconfig-r005-20230507   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230508   gcc  
nios2                randconfig-r005-20230508   gcc  
openrisc             randconfig-r021-20230508   gcc  
openrisc             randconfig-r031-20230507   gcc  
openrisc             randconfig-r036-20230507   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230507   clang
powerpc              randconfig-r025-20230507   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230508   clang
riscv                randconfig-r013-20230508   gcc  
riscv                randconfig-r022-20230508   gcc  
riscv                randconfig-r042-20230507   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230507   gcc  
s390                 randconfig-r044-20230507   clang
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r002-20230507   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230507   gcc  
sparc                randconfig-r022-20230507   gcc  
sparc64      buildonly-randconfig-r006-20230508   gcc  
sparc64              randconfig-r005-20230507   gcc  
sparc64              randconfig-r006-20230507   gcc  
sparc64              randconfig-r012-20230508   gcc  
sparc64              randconfig-r032-20230507   gcc  
sparc64              randconfig-r035-20230507   gcc  
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
x86_64               randconfig-a011-20230508   gcc  
x86_64               randconfig-a012-20230508   gcc  
x86_64               randconfig-a013-20230508   gcc  
x86_64               randconfig-a014-20230508   gcc  
x86_64               randconfig-a015-20230508   gcc  
x86_64               randconfig-a016-20230508   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230508   gcc  
xtensa               randconfig-r016-20230508   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
