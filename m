Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44105797637
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Sep 2023 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjIGQEm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 Sep 2023 12:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbjIGQE0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Sep 2023 12:04:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF50461B2;
        Thu,  7 Sep 2023 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694101992; x=1725637992;
  h=date:from:to:cc:subject:message-id;
  bh=wGwPIDqT/fjSP0tlWKICZFczVXEYvufamL3QjFql4q0=;
  b=fu37YqkjQ2MmLz51XBDi/b/h7RXRVUBWpNp4zr+vr3UmpqZeT27z0Bjr
   QLDWHb4v3YZQHzJR7GoPgkwozVvwHn2DWmVCtCDzwe/n2jhZMMOKV2h71
   kUGAOiM6PoLP3sM2kEeUSkf3YjEwOPrpdLINWxWhiAwtlycYCHAh4nVv/
   zflF1XRXYxvvupwYlox6ASGzIflYplgZ84WXr67PMiKRVaKX7VUPr2Lq6
   AlFPKGCApXIZj06fe0lmDuRxHS09uccHCEA1DWlIrHJPdq3vDvZCThinC
   cr0OIo29i9bQWF++eyI3wYoI/Bw+WKHXw3my39cM7+BnYKphp+SiMHHaT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="356777574"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="356777574"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 01:38:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="988680123"
X-IronPort-AV: E=Sophos;i="6.02,234,1688454000"; 
   d="scan'208";a="988680123"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2023 01:38:56 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeAXO-000133-1N;
        Thu, 07 Sep 2023 08:38:54 +0000
Date:   Thu, 07 Sep 2023 16:38:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 3a0edc2c5c29630924b31f1ccc5f3378024d5354
Message-ID: <202309071619.ILDku2Js-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 3a0edc2c5c29630924b31f1ccc5f3378024d5354  Merge branch 'powercap' into linux-next

elapsed time: 732m

configs tested: 172
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230907   gcc  
arc                  randconfig-r004-20230907   gcc  
arc                  randconfig-r005-20230907   gcc  
arc                  randconfig-r026-20230907   gcc  
arc                  randconfig-r031-20230907   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230907   clang
arm                  randconfig-r004-20230907   gcc  
arm                  randconfig-r025-20230907   clang
arm                  randconfig-r034-20230907   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230907   clang
arm64                randconfig-r012-20230907   gcc  
arm64                randconfig-r013-20230907   gcc  
arm64                randconfig-r016-20230907   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230907   clang
hexagon               randconfig-002-20230907   clang
hexagon              randconfig-r032-20230907   clang
hexagon              randconfig-r035-20230907   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230907   clang
i386         buildonly-randconfig-002-20230907   clang
i386         buildonly-randconfig-003-20230907   clang
i386         buildonly-randconfig-004-20230907   clang
i386         buildonly-randconfig-005-20230907   clang
i386         buildonly-randconfig-006-20230907   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230907   clang
i386                  randconfig-002-20230907   clang
i386                  randconfig-003-20230907   clang
i386                  randconfig-004-20230907   clang
i386                  randconfig-005-20230907   clang
i386                  randconfig-006-20230907   clang
i386                  randconfig-011-20230907   gcc  
i386                  randconfig-012-20230907   gcc  
i386                  randconfig-013-20230907   gcc  
i386                  randconfig-014-20230907   gcc  
i386                  randconfig-015-20230907   gcc  
i386                  randconfig-016-20230907   gcc  
i386                 randconfig-r001-20230907   clang
i386                 randconfig-r003-20230907   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230907   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230907   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r012-20230907   gcc  
microblaze           randconfig-r036-20230907   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r011-20230907   clang
mips                 randconfig-r033-20230907   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230907   gcc  
nios2                randconfig-r023-20230907   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r002-20230907   gcc  
openrisc             randconfig-r013-20230907   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r016-20230907   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230907   clang
riscv                randconfig-r002-20230907   clang
riscv                randconfig-r014-20230907   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230907   gcc  
s390                 randconfig-r003-20230907   clang
s390                 randconfig-r022-20230907   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r005-20230907   gcc  
um                   randconfig-r015-20230907   clang
um                   randconfig-r021-20230907   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230907   clang
x86_64       buildonly-randconfig-002-20230907   clang
x86_64       buildonly-randconfig-003-20230907   clang
x86_64       buildonly-randconfig-004-20230907   clang
x86_64       buildonly-randconfig-005-20230907   clang
x86_64       buildonly-randconfig-006-20230907   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230907   gcc  
x86_64                randconfig-002-20230907   gcc  
x86_64                randconfig-003-20230907   gcc  
x86_64                randconfig-004-20230907   gcc  
x86_64                randconfig-005-20230907   gcc  
x86_64                randconfig-006-20230907   gcc  
x86_64                randconfig-011-20230907   clang
x86_64                randconfig-012-20230907   clang
x86_64                randconfig-013-20230907   clang
x86_64                randconfig-014-20230907   clang
x86_64                randconfig-015-20230907   clang
x86_64                randconfig-016-20230907   clang
x86_64                randconfig-071-20230907   clang
x86_64                randconfig-072-20230907   clang
x86_64                randconfig-073-20230907   clang
x86_64                randconfig-074-20230907   clang
x86_64                randconfig-075-20230907   clang
x86_64                randconfig-076-20230907   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r006-20230907   gcc  
xtensa               randconfig-r015-20230907   gcc  
xtensa               randconfig-r024-20230907   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
