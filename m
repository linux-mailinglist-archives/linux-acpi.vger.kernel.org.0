Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6368742FBB
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jun 2023 23:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjF2VwO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jun 2023 17:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbjF2VwN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2023 17:52:13 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA8A30C4;
        Thu, 29 Jun 2023 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688075532; x=1719611532;
  h=date:from:to:cc:subject:message-id;
  bh=DklM5qmVcQPcrDXSjN3k7QLlotTnln0BiiMc8Z3Le68=;
  b=AinfRoQGG/7BY2NkWm4JHpcR/Xxk5TFQ5dOrQfIHnB336RN7GBFLPoLm
   bIaVtILBRwSHw7bPHyWSRX/boPzFb+xaAy6o1xSApFCmJtfvl2QuAMF6g
   MWGlJNdJVkDJel4fca4d8JJ47KPLgfLSrbuoTClFrc4acOTgbl/SGeW3p
   uHrC0Q5SkXkaJBP+BIP93jP1lFS8j840N7koBUu6SfT51+w5okvPGEDoa
   kGmVJtDrAhybUFPaN2kGuwI370rNzU96ZVhiI5LgcaxEqQi5xtnj41nb+
   WVFeLkRh6Mb1aB17gL420TwNJuMtjuZyCBDfa24IzxEWWsXasde3m+KNj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="359717531"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="359717531"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2023 14:52:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="830696074"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; 
   d="scan'208";a="830696074"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jun 2023 14:51:59 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qEzYV-000EQg-0D;
        Thu, 29 Jun 2023 21:51:59 +0000
Date:   Fri, 30 Jun 2023 05:51:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e48016b194ff7511565aa1510900d6324957620d
Message-ID: <202306300534.of2isgVR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e48016b194ff7511565aa1510900d6324957620d  Merge branch 'acpi-bus' into bleeding-edge

elapsed time: 725m

configs tested: 106
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230629   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230629   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230629   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r034-20230629   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230629   gcc  
csky                 randconfig-r014-20230629   gcc  
csky                 randconfig-r031-20230629   gcc  
hexagon              randconfig-r041-20230629   clang
hexagon              randconfig-r045-20230629   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230629   gcc  
i386         buildonly-randconfig-r005-20230629   gcc  
i386         buildonly-randconfig-r006-20230629   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230629   gcc  
i386                 randconfig-i002-20230629   gcc  
i386                 randconfig-i003-20230629   gcc  
i386                 randconfig-i004-20230629   gcc  
i386                 randconfig-i005-20230629   gcc  
i386                 randconfig-i006-20230629   gcc  
i386                 randconfig-i011-20230629   clang
i386                 randconfig-i012-20230629   clang
i386                 randconfig-i013-20230629   clang
i386                 randconfig-i014-20230629   clang
i386                 randconfig-i015-20230629   clang
i386                 randconfig-i016-20230629   clang
i386                 randconfig-r022-20230629   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230629   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r005-20230629   gcc  
microblaze           randconfig-r032-20230629   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r012-20230629   gcc  
mips                 randconfig-r036-20230629   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r004-20230629   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r015-20230629   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r016-20230629   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230629   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230629   gcc  
s390                 randconfig-r044-20230629   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230629   gcc  
sh                   randconfig-r035-20230629   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r003-20230629   gcc  
sparc64              randconfig-r033-20230629   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230629   gcc  
x86_64       buildonly-randconfig-r002-20230629   gcc  
x86_64       buildonly-randconfig-r003-20230629   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230629   clang
x86_64               randconfig-x002-20230629   clang
x86_64               randconfig-x003-20230629   clang
x86_64               randconfig-x004-20230629   clang
x86_64               randconfig-x005-20230629   clang
x86_64               randconfig-x006-20230629   clang
x86_64               randconfig-x011-20230629   gcc  
x86_64               randconfig-x012-20230629   gcc  
x86_64               randconfig-x013-20230629   gcc  
x86_64               randconfig-x014-20230629   gcc  
x86_64               randconfig-x015-20230629   gcc  
x86_64               randconfig-x016-20230629   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230629   gcc  
xtensa               randconfig-r024-20230629   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
