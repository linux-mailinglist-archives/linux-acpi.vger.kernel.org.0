Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8F742078
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Jun 2023 08:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjF2Gib (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Jun 2023 02:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjF2GiV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2023 02:38:21 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A132D60;
        Wed, 28 Jun 2023 23:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688020700; x=1719556700;
  h=date:from:to:cc:subject:message-id;
  bh=buuQ0RXqokD5mzPNOSRnxPRVCM1qRESl8ZxW9HDM0jY=;
  b=a+4WAJqf34zB+zsDSeUgByn/6yMbYYhnF81EDIkMWMRVV9Vtj5E/+MtF
   gU8B6Jn7uNuM6L3BRyn67KcoB0UjCutY56NnAh6G2ZxAGNAFUg5iisz3/
   efxi6bowGJlTBpTxRvCx2jwSxb1U/kzI6uKALxQ4p7OOCOHNemF1aESS3
   UkHORm42uMmezguAedydSbvzdJcGASZczjeD6U5wFBWnde1HeX5eSjWgb
   SgtFN1gHYDfTq/qD9Qyj4UJLI11mDgsXKCS8Hbr/He1Knv8s6jr+gClg0
   8rTvXGgwWvVhPDbsc0QB6bAFiIud4tArbxdZrvmpgnxdZAjOnCQhyi/lq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="341618567"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="341618567"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2023 23:38:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10755"; a="782583356"
X-IronPort-AV: E=Sophos;i="6.01,167,1684825200"; 
   d="scan'208";a="782583356"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2023 23:38:13 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qElID-000DuX-0a;
        Thu, 29 Jun 2023 06:38:13 +0000
Date:   Thu, 29 Jun 2023 14:38:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9d05d0562d7a9d54117e68c262431378caae5b8e
Message-ID: <202306291401.kTLwM2YG-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9d05d0562d7a9d54117e68c262431378caae5b8e  Merge branch 'pm-cpuidle' into linux-next

elapsed time: 721m

configs tested: 128
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230628   gcc  
alpha                randconfig-r021-20230628   gcc  
alpha                randconfig-r031-20230628   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r006-20230628   gcc  
arc                  randconfig-r043-20230628   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          ixp4xx_defconfig   clang
arm                          pxa168_defconfig   clang
arm                  randconfig-r002-20230628   gcc  
arm                  randconfig-r032-20230628   gcc  
arm                  randconfig-r035-20230628   gcc  
arm                  randconfig-r046-20230628   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230628   clang
arm64                randconfig-r036-20230628   clang
csky                                defconfig   gcc  
hexagon              randconfig-r022-20230628   clang
hexagon              randconfig-r041-20230628   clang
hexagon              randconfig-r045-20230628   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230628   clang
i386         buildonly-randconfig-r005-20230628   clang
i386         buildonly-randconfig-r006-20230628   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230628   clang
i386                 randconfig-i002-20230628   clang
i386                 randconfig-i003-20230628   clang
i386                 randconfig-i004-20230628   clang
i386                 randconfig-i005-20230628   clang
i386                 randconfig-i006-20230628   clang
i386                 randconfig-i011-20230628   gcc  
i386                 randconfig-i012-20230628   gcc  
i386                 randconfig-i013-20230628   gcc  
i386                 randconfig-i014-20230628   gcc  
i386                 randconfig-i015-20230628   gcc  
i386                 randconfig-i016-20230628   gcc  
i386                 randconfig-r005-20230628   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230628   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r031-20230628   gcc  
m68k                 randconfig-r032-20230628   gcc  
microblaze           randconfig-r034-20230628   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230628   gcc  
openrisc             randconfig-r004-20230628   gcc  
openrisc             randconfig-r021-20230628   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230628   gcc  
parisc               randconfig-r011-20230628   gcc  
parisc               randconfig-r012-20230628   gcc  
parisc               randconfig-r016-20230628   gcc  
parisc               randconfig-r022-20230628   gcc  
parisc               randconfig-r023-20230628   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230628   gcc  
powerpc              randconfig-r026-20230628   gcc  
powerpc              randconfig-r034-20230628   clang
powerpc                     skiroot_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230628   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230628   gcc  
s390                 randconfig-r015-20230628   gcc  
s390                 randconfig-r036-20230628   clang
s390                 randconfig-r044-20230628   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230628   gcc  
sh                   randconfig-r024-20230628   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r013-20230628   gcc  
sparc64              randconfig-r006-20230628   gcc  
sparc64              randconfig-r025-20230628   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230628   clang
um                   randconfig-r023-20230628   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230628   clang
x86_64       buildonly-randconfig-r002-20230628   clang
x86_64       buildonly-randconfig-r003-20230628   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r001-20230628   clang
x86_64               randconfig-x001-20230628   gcc  
x86_64               randconfig-x002-20230628   gcc  
x86_64               randconfig-x003-20230628   gcc  
x86_64               randconfig-x004-20230628   gcc  
x86_64               randconfig-x005-20230628   gcc  
x86_64               randconfig-x006-20230628   gcc  
x86_64               randconfig-x011-20230628   clang
x86_64               randconfig-x012-20230628   clang
x86_64               randconfig-x013-20230628   clang
x86_64               randconfig-x014-20230628   clang
x86_64               randconfig-x015-20230628   clang
x86_64               randconfig-x016-20230628   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
