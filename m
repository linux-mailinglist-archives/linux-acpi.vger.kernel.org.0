Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68774780620
	for <lists+linux-acpi@lfdr.de>; Fri, 18 Aug 2023 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358129AbjHRHH0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Aug 2023 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358146AbjHRHHX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Aug 2023 03:07:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D02730C5;
        Fri, 18 Aug 2023 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692342442; x=1723878442;
  h=date:from:to:cc:subject:message-id;
  bh=gny9Lr1v3l5aAZOlUUPwXb9PVQNuOpJ7OVQYneFXx9w=;
  b=Gt224bd/UEes8nPijl5xnoba5XxIjJkf6MsCCBYub7n9Px6S1UaoaUNX
   gtr4MurCLNHZ3MeX0H2YK9D3BrCr9ev+YXPtoCwPevEy4QyyDzAsPkCvo
   QPdZNKlHck1mlabPbe2O4RhDdsxTlci5Rvq4XWl5Pp4rOe6uPIqVdptw9
   SjH4NX9CyBeQG6ZHzhu73+s9D1/aQuvxS2uss0PRLR1LsbqTOTubJyOYy
   QEORokcfsorQWN5p7gkvKni3Z3gKMw9RpEYuHSitPzT2gb2q995zlisdO
   aVopvw8OiJPmkoyOKHDtTokW8Uy2PJ5XYWF1LLZz36T8rGEVeQT8NAtlR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="352621125"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="352621125"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 00:07:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065634224"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="1065634224"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2023 00:07:20 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWtZj-0002CI-3D;
        Fri, 18 Aug 2023 07:07:16 +0000
Date:   Fri, 18 Aug 2023 15:07:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dff4c74075fc899cfa79833db6de9a3253538b33
Message-ID: <202308181503.0nQdGd5j-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: dff4c74075fc899cfa79833db6de9a3253538b33  Merge branch 'acpi-tad' into bleeding-edge

elapsed time: 721m

configs tested: 108
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230818   gcc  
alpha                randconfig-r031-20230818   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230818   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230818   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r023-20230818   clang
hexagon              randconfig-r041-20230818   clang
hexagon              randconfig-r045-20230818   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230818   gcc  
i386         buildonly-randconfig-r005-20230818   gcc  
i386         buildonly-randconfig-r006-20230818   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230818   gcc  
i386                 randconfig-i002-20230818   gcc  
i386                 randconfig-i003-20230818   gcc  
i386                 randconfig-i004-20230818   gcc  
i386                 randconfig-i005-20230818   gcc  
i386                 randconfig-i006-20230818   gcc  
i386                 randconfig-i011-20230818   clang
i386                 randconfig-i012-20230818   clang
i386                 randconfig-i013-20230818   clang
i386                 randconfig-i014-20230818   clang
i386                 randconfig-i015-20230818   clang
i386                 randconfig-i016-20230818   clang
i386                 randconfig-r022-20230818   clang
i386                 randconfig-r036-20230818   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230818   gcc  
loongarch            randconfig-r015-20230818   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r024-20230818   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r003-20230818   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230818   gcc  
parisc               randconfig-r006-20230818   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       holly_defconfig   gcc  
powerpc                    sam440ep_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230818   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230818   gcc  
s390                 randconfig-r016-20230818   clang
s390                 randconfig-r044-20230818   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230818   gcc  
sparc                randconfig-r021-20230818   gcc  
sparc                randconfig-r026-20230818   gcc  
sparc64              randconfig-r025-20230818   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r032-20230818   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230818   gcc  
x86_64       buildonly-randconfig-r002-20230818   gcc  
x86_64       buildonly-randconfig-r003-20230818   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230818   clang
x86_64               randconfig-x002-20230818   clang
x86_64               randconfig-x003-20230818   clang
x86_64               randconfig-x004-20230818   clang
x86_64               randconfig-x005-20230818   clang
x86_64               randconfig-x006-20230818   clang
x86_64               randconfig-x011-20230818   gcc  
x86_64               randconfig-x012-20230818   gcc  
x86_64               randconfig-x013-20230818   gcc  
x86_64               randconfig-x014-20230818   gcc  
x86_64               randconfig-x015-20230818   gcc  
x86_64               randconfig-x016-20230818   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230818   gcc  
xtensa               randconfig-r034-20230818   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
