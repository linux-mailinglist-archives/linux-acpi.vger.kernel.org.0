Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6CD7788FDE
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Aug 2023 22:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230117AbjHYUbh (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Aug 2023 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjHYUbY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Aug 2023 16:31:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F51BE6;
        Fri, 25 Aug 2023 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692995481; x=1724531481;
  h=date:from:to:cc:subject:message-id;
  bh=++TkEGbsL0jK4oH5knq3rKGZEabvttSthN1xc9pKCxA=;
  b=Qz24A7QQ1j3n4eTxCL/CrPBRXTNDYrSBcJmPc2PCr/RMputeAMzzy4ei
   86v3pin0NPg4eybMNhfECcqg9opdzkaZUQE6jeVsJdrIt0SeDM0eAA+Vk
   HxmV9u29V5zmxiXZN4YS7AgJbLblfYIn3fF5vIhZQDSbJUsI+Su/kVlSs
   fjsJKCDpDNntms6D3Bd8Ru321FZ9UzFQ+CUpuz4CsxgM+GPDsDCnwa8ZL
   UCxP1eNIKboFkTDlW1+gAFjNUGXap+4rbLwzXq917PZC9KFaf/6dG29Bp
   YLzhoGFcemzagknCMy69BZK1aeVk3OufOz+o3HEs4++9R5/uvYNH83/uJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="438737588"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="438737588"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 13:31:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="1068351824"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="1068351824"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 25 Aug 2023 13:31:18 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZdSf-0003z9-1H;
        Fri, 25 Aug 2023 20:31:17 +0000
Date:   Sat, 26 Aug 2023 04:30:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1d5e1321ead0b6172df55d47f190742f7a614bfd
Message-ID: <202308260426.wCSfRBBP-lkp@intel.com>
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
branch HEAD: 1d5e1321ead0b6172df55d47f190742f7a614bfd  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 1533m

configs tested: 165
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r014-20230825   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230825   gcc  
arc                  randconfig-r006-20230825   gcc  
arc                  randconfig-r034-20230825   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230825   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230825   gcc  
csky                 randconfig-r025-20230825   gcc  
hexagon               randconfig-001-20230825   clang
hexagon               randconfig-002-20230825   clang
i386         buildonly-randconfig-001-20230825   clang
i386         buildonly-randconfig-002-20230825   clang
i386         buildonly-randconfig-003-20230825   clang
i386         buildonly-randconfig-004-20230825   clang
i386         buildonly-randconfig-005-20230825   clang
i386         buildonly-randconfig-006-20230825   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20230825   clang
i386                  randconfig-002-20230825   clang
i386                  randconfig-003-20230825   clang
i386                  randconfig-004-20230825   clang
i386                  randconfig-005-20230825   clang
i386                  randconfig-006-20230825   clang
i386                  randconfig-011-20230825   gcc  
i386                  randconfig-012-20230825   gcc  
i386                  randconfig-013-20230825   gcc  
i386                  randconfig-014-20230825   gcc  
i386                  randconfig-015-20230825   gcc  
i386                  randconfig-016-20230825   gcc  
i386                 randconfig-r032-20230825   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230825   gcc  
loongarch            randconfig-r011-20230825   gcc  
loongarch            randconfig-r016-20230825   gcc  
loongarch            randconfig-r031-20230825   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230825   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                            gpr_defconfig   gcc  
mips                           ip28_defconfig   clang
mips                     loongson2k_defconfig   clang
mips                 randconfig-r015-20230825   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r026-20230825   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
openrisc             randconfig-r033-20230825   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230825   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      obs600_defconfig   clang
powerpc              randconfig-r036-20230825   clang
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230825   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230825   gcc  
s390                 randconfig-r012-20230825   gcc  
s390                 randconfig-r023-20230825   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230825   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r002-20230825   gcc  
sparc64              randconfig-r021-20230825   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230825   clang
x86_64       buildonly-randconfig-002-20230825   clang
x86_64       buildonly-randconfig-003-20230825   clang
x86_64       buildonly-randconfig-004-20230825   clang
x86_64       buildonly-randconfig-005-20230825   clang
x86_64       buildonly-randconfig-006-20230825   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230825   gcc  
x86_64                randconfig-002-20230825   gcc  
x86_64                randconfig-003-20230825   gcc  
x86_64                randconfig-004-20230825   gcc  
x86_64                randconfig-005-20230825   gcc  
x86_64                randconfig-006-20230825   gcc  
x86_64                randconfig-011-20230825   clang
x86_64                randconfig-012-20230825   clang
x86_64                randconfig-013-20230825   clang
x86_64                randconfig-014-20230825   clang
x86_64                randconfig-015-20230825   clang
x86_64                randconfig-016-20230825   clang
x86_64                randconfig-071-20230825   clang
x86_64                randconfig-072-20230825   clang
x86_64                randconfig-073-20230825   clang
x86_64                randconfig-074-20230825   clang
x86_64                randconfig-075-20230825   clang
x86_64                randconfig-076-20230825   clang
x86_64               randconfig-r022-20230825   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r004-20230825   gcc  
xtensa               randconfig-r013-20230825   gcc  
xtensa               randconfig-r035-20230825   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
