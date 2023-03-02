Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5E96A7BA9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Mar 2023 08:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCBHNO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Mar 2023 02:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCBHNN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2023 02:13:13 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D75125A4;
        Wed,  1 Mar 2023 23:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677741189; x=1709277189;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qWpUn32unE2MmDexgZsuvz6IvmhGuAC408RmQ7LNQnE=;
  b=njLZXa5us4gwFcZcXGWicxonv+IkpI16h1nGTIdpaDBBS+n4BMaAHjhW
   W7wktVUQpLJ62DJ7xAAbYDgroMAlszL7L+3UysddLWoTRqfkeoif5525G
   QW/7FFNpA074u91irKnkYr6yw72V6bLfnJp4yaD3RjBUI0YKuUyyr93+q
   o5+FWeRntOnCn8Aj4IWseAV9vB+N30mgoIYhua062Od3EZyohgNhsqT6H
   Z3kFF6vArj2fWa1yVdqYNkotuPM0A4dICUrHX5rBATTPk1Rr/Soi0BKni
   vUVRKH7AfYot/aiEDCyrdQ1rCY8CamdCncNbkLJArR4szABFSp5GvUzKw
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="314303160"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="314303160"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 23:13:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="707310723"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="707310723"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 01 Mar 2023 23:13:06 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pXd7h-0000IH-26;
        Thu, 02 Mar 2023 07:13:05 +0000
Date:   Thu, 02 Mar 2023 15:12:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3a6fe66936a0761d48cf4f4c62885abebeafea22
Message-ID: <64004c47.poNPafX3eoj5dSFB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3a6fe66936a0761d48cf4f4c62885abebeafea22  Merge branch 'pm-cpufreq' into bleeding-edge

elapsed time: 728m

configs tested: 102
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230302   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230302   gcc  
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230302   clang
csky         buildonly-randconfig-r002-20230302   gcc  
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r036-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r004-20230302   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r004-20230302   gcc  
m68k                                defconfig   gcc  
microblaze   buildonly-randconfig-r001-20230302   gcc  
microblaze   buildonly-randconfig-r003-20230302   gcc  
microblaze           randconfig-r012-20230302   gcc  
microblaze           randconfig-r023-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r013-20230302   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230302   gcc  
nios2                randconfig-r031-20230302   gcc  
nios2                randconfig-r033-20230302   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r006-20230302   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230302   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230302   gcc  
sparc                randconfig-r021-20230302   gcc  
sparc64              randconfig-r003-20230302   gcc  
sparc64              randconfig-r011-20230302   gcc  
sparc64              randconfig-r022-20230302   gcc  
sparc64              randconfig-r035-20230302   gcc  
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
xtensa       buildonly-randconfig-r005-20230302   gcc  
xtensa               randconfig-r001-20230302   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
