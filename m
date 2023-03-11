Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 169966B58DF
	for <lists+linux-acpi@lfdr.de>; Sat, 11 Mar 2023 07:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCKGOr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 11 Mar 2023 01:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCKGOq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Mar 2023 01:14:46 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137131340F1;
        Fri, 10 Mar 2023 22:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678515285; x=1710051285;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=eWe1fb83b9mTT1dX/B9IPVcaOx5TuTeNbVK3V5DDwc0=;
  b=kikHjoiVL7Xc3GaYSAfrI9ouh/mrn3G8yzuUux17RhMOaiI4arIaK8gM
   iQ93IkHXnpimQwxdxpDAFq5O8LNp1YfNPbPwT3t9yt4s4pACltdJyJEjC
   GC/mpqMqgTnd5Kv8kGcjTVpoiwHWA2khRtkh5OizpzypzwDBbmUt3KYJN
   WRmgtPfOouoEyzCgMqRffTpsonvzpO5+TDqEaS6M14jTtF+E66RRGNzfh
   C2DYRlxXMFhP/TCdWb/Wa2rfwM2D0/q2v5y0NoMQzdQ8iBEJIl7MU1uKA
   l4De3Ylw1AHNPwW4+wqoDhFCvkjPquk1yIlJHIzWTFlGwSOG/I/4pRsA1
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320731299"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="320731299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 22:14:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="742256978"
X-IronPort-AV: E=Sophos;i="5.98,252,1673942400"; 
   d="scan'208";a="742256978"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 10 Mar 2023 22:14:43 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pasV8-0004Oj-1Q;
        Sat, 11 Mar 2023 06:14:42 +0000
Date:   Sat, 11 Mar 2023 14:14:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 687388eb09d318fb319b2771f1ee426afbf03bc3
Message-ID: <640c1c3a.9VrD8IZOvPI86e5s%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 687388eb09d318fb319b2771f1ee426afbf03bc3  Merge branch 'pm-cpuidle' into linux-next

elapsed time: 735m

configs tested: 135
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig   gcc  
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230310   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230310   gcc  
arc                  randconfig-r015-20230310   gcc  
arc                  randconfig-r026-20230310   gcc  
arc                  randconfig-r043-20230310   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230310   clang
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                  randconfig-r046-20230310   clang
arm                        realview_defconfig   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           sama7_defconfig   clang
arm                       spear13xx_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230310   gcc  
arm64                randconfig-r032-20230310   clang
csky                                defconfig   gcc  
csky                 randconfig-r001-20230310   gcc  
csky                 randconfig-r022-20230310   gcc  
hexagon              randconfig-r024-20230310   clang
hexagon              randconfig-r035-20230310   clang
hexagon              randconfig-r041-20230310   clang
hexagon              randconfig-r045-20230310   clang
i386                              allnoconfig   gcc  
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
ia64                                defconfig   gcc  
ia64                 randconfig-r016-20230310   gcc  
ia64                 randconfig-r036-20230310   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230310   gcc  
loongarch    buildonly-randconfig-r003-20230310   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230310   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230310   gcc  
m68k                           sun3_defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230310   gcc  
microblaze           randconfig-r006-20230310   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r006-20230310   gcc  
mips                      malta_kvm_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230310   gcc  
nios2                randconfig-r005-20230310   gcc  
openrisc     buildonly-randconfig-r004-20230310   gcc  
openrisc             randconfig-r003-20230310   gcc  
openrisc             randconfig-r005-20230310   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230310   gcc  
parisc               randconfig-r012-20230310   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      cm5200_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r006-20230310   clang
powerpc              randconfig-r034-20230310   clang
powerpc                     tqm8548_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230310   clang
riscv                randconfig-r003-20230310   clang
riscv                randconfig-r021-20230310   gcc  
riscv                randconfig-r042-20230310   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r033-20230310   clang
s390                 randconfig-r044-20230310   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230310   gcc  
sh           buildonly-randconfig-r005-20230310   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r002-20230310   gcc  
sh                   randconfig-r004-20230310   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230310   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r001-20230310   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
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
xtensa               randconfig-r002-20230310   gcc  
xtensa               randconfig-r006-20230310   gcc  
xtensa               randconfig-r013-20230310   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
