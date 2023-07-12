Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE45674FFC5
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Jul 2023 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGLG4L (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 02:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGLG4L (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 02:56:11 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFEFDC;
        Tue, 11 Jul 2023 23:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689144970; x=1720680970;
  h=date:from:to:cc:subject:message-id;
  bh=Aix+sebAr5d/cP/q9zYQR6XWltGXQhXYRkYcR4Ttjio=;
  b=Q7pWQIHmqIChPSPebqE6a7zXTlzFnod+T3yrNqIEGjbVEp4bU49N2Ar4
   Hi1z06nDFSD5RxO2WvlEQWw/ypuJxlgfX5fgL5SuWphQiUMU1MI6rXEbE
   1ghZTlAbROZKj0UMlALnYgIb/4y29ysmE4IIMED8761OkSLPkSLgL1a3D
   YLuUgU+3aSqtAg07m6N2QKm9kJsBRrm6fzgTWnSZPJ+sXWA2Dv/Y1tpyB
   7+LeRfMYtm+OtPkUB6OFUh7LU7CswqMo4dog9aplUReXjElNlPrufhjWj
   7oz5XsOgt92Gv56Q14AfIUTSHDTgzS3J10VWZh9Mg0eZujzn0GXU9hylG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="367437022"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="367437022"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 23:55:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10768"; a="715446531"
X-IronPort-AV: E=Sophos;i="6.01,199,1684825200"; 
   d="scan'208";a="715446531"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 11 Jul 2023 23:55:44 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJTlH-0005Tv-1e;
        Wed, 12 Jul 2023 06:55:43 +0000
Date:   Wed, 12 Jul 2023 14:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 d26e5b690e4be2f96d55bdcf5d80bb42c2d55cc6
Message-ID: <202307121441.LZ9vpvNt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: d26e5b690e4be2f96d55bdcf5d80bb42c2d55cc6  Merge branch 'powercap' into bleeding-edge

elapsed time: 726m

configs tested: 109
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230712   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                  randconfig-r024-20230710   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230710   gcc  
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230710   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230711   clang
i386         buildonly-randconfig-r005-20230711   clang
i386         buildonly-randconfig-r006-20230711   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i011-20230711   gcc  
i386                 randconfig-i012-20230711   gcc  
i386                 randconfig-i013-20230711   gcc  
i386                 randconfig-i014-20230711   gcc  
i386                 randconfig-i015-20230711   gcc  
i386                 randconfig-i016-20230711   gcc  
i386                 randconfig-r013-20230712   clang
i386                 randconfig-r032-20230711   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r022-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r026-20230710   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230712   gcc  
nios2                randconfig-r023-20230710   gcc  
openrisc             randconfig-r021-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230711   clang
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r034-20230711   clang
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r035-20230711   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r014-20230712   gcc  
sparc64              randconfig-r036-20230711   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r031-20230711   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230711   clang
x86_64       buildonly-randconfig-r002-20230711   clang
x86_64       buildonly-randconfig-r003-20230711   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r015-20230712   clang
x86_64               randconfig-r016-20230712   clang
x86_64               randconfig-x001-20230711   gcc  
x86_64               randconfig-x002-20230711   gcc  
x86_64               randconfig-x003-20230711   gcc  
x86_64               randconfig-x004-20230711   gcc  
x86_64               randconfig-x005-20230711   gcc  
x86_64               randconfig-x006-20230711   gcc  
x86_64               randconfig-x011-20230711   clang
x86_64               randconfig-x012-20230711   clang
x86_64               randconfig-x013-20230711   clang
x86_64               randconfig-x014-20230711   clang
x86_64               randconfig-x015-20230711   clang
x86_64               randconfig-x016-20230711   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r006-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
