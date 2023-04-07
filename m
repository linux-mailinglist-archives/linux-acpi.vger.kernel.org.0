Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB86DA91D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Apr 2023 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjDGGwk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 02:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjDGGwj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 02:52:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6767AA0;
        Thu,  6 Apr 2023 23:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680850357; x=1712386357;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bblOKHgLgzcxci/+70+IMRpI5HnZ8tzUg8G9DDXE6C8=;
  b=kfGKEFvYrKxa3xjFRYiRXGiBQ1JtZETaG7y+h1Nd8p9FcH2HKBi19baK
   cu6KB7qT2AlBWt97v3yEQl/jgidUvROHKwTC0a44gLF7FndUi4gFaV1SU
   uzeWqvLp5ekOp+XBDYvWWgmA3auecFtmlzugGPfAY7fhirNPcITfemPjq
   iwQoWSpRKP8NRACAbymynz3CnrxhZQzoPpeZJs7XYb6K79iXaKGpLfnwK
   YBCPyA5fgK71d111uCogNWMcRiib03sQ59cMkIj5jtSm9/mOyA6ibmDHT
   53+f6RTTYVYPN8Mm+dUseXF6V8/GWJaBNCEtgrsqMOI0o+P/xkVoJbbRG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="342945253"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="342945253"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 23:52:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="687435133"
X-IronPort-AV: E=Sophos;i="5.98,326,1673942400"; 
   d="scan'208";a="687435133"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Apr 2023 23:52:32 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkfxX-000SD4-1R;
        Fri, 07 Apr 2023 06:52:31 +0000
Date:   Fri, 07 Apr 2023 14:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bc6e567b38e395dae5fd5ff4b6be06c11a7d3edd
Message-ID: <642fbd8d.Qcu6nYsxz7nS1qQv%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bc6e567b38e395dae5fd5ff4b6be06c11a7d3edd  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 723m

configs tested: 152
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r031-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arc                  randconfig-r043-20230406   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230403   clang
arm                  randconfig-r031-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                  randconfig-r046-20230406   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230404   gcc  
arm64        buildonly-randconfig-r006-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r033-20230403   clang
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r001-20230405   clang
hexagon      buildonly-randconfig-r003-20230404   clang
hexagon      buildonly-randconfig-r004-20230404   clang
hexagon      buildonly-randconfig-r005-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r041-20230406   clang
hexagon              randconfig-r045-20230403   clang
hexagon              randconfig-r045-20230406   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230403   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                          randconfig-a011   clang
i386                 randconfig-a012-20230403   gcc  
i386                          randconfig-a012   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                          randconfig-a013   clang
i386                 randconfig-a014-20230403   gcc  
i386                          randconfig-a014   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                          randconfig-a015   clang
i386                 randconfig-a016-20230403   gcc  
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230403   gcc  
ia64         buildonly-randconfig-r004-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r024-20230403   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r032-20230403   gcc  
loongarch            randconfig-r036-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r035-20230403   gcc  
microblaze   buildonly-randconfig-r002-20230404   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230405   gcc  
mips         buildonly-randconfig-r005-20230403   gcc  
mips         buildonly-randconfig-r006-20230405   gcc  
mips                 randconfig-r011-20230403   clang
mips                 randconfig-r023-20230403   clang
mips                 randconfig-r033-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230403   gcc  
openrisc     buildonly-randconfig-r002-20230405   gcc  
openrisc             randconfig-r035-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230403   gcc  
powerpc                          g5_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                 mpc8315_rdb_defconfig   clang
powerpc                      pcm030_defconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r006-20230403   clang
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r034-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv        buildonly-randconfig-r004-20230405   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                randconfig-r042-20230406   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230404   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230403   clang
s390                 randconfig-r044-20230403   gcc  
s390                 randconfig-r044-20230406   clang
sh                               allmodconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r003-20230403   gcc  
sparc        buildonly-randconfig-r006-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230403   gcc  
sparc                randconfig-r034-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
sparc64              randconfig-r036-20230403   gcc  
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
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230403   gcc  
xtensa       buildonly-randconfig-r003-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
