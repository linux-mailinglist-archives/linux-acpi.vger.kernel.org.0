Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688D4787601
	for <lists+linux-acpi@lfdr.de>; Thu, 24 Aug 2023 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbjHXQu6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 24 Aug 2023 12:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242725AbjHXQub (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Aug 2023 12:50:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E981B9;
        Thu, 24 Aug 2023 09:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692895828; x=1724431828;
  h=date:from:to:cc:subject:message-id;
  bh=OSzNcZLK/IfiQx721ODEPw23HRPuIfmyddt8B9DSw/c=;
  b=cT8Yp3JFh1V53UKV6GVzmJ7xicqiBIPj2zTlwntmS3zlOWlZfB9UHT05
   mir/ElULmE3v3wuUs25+t5BVRuqELDFgXiFgC+nGGM/vzvsE05A+1RxXM
   OQ5BwWVM9s5BxxFrbIAmS9ZI3nUcB6vDP1FjKXnHenuvaNOO6pdzYTZ/Z
   svOItUob/RtRqqHaiVeXp05z/NjTlBtUwNiol8/lKq/+UShXHvIdVwQWO
   hNMMp0FkEDA34I7mtxhBYOZ+JFaxvVuNxgOHWenZfvm0Do3lv7G3NFeLV
   YSBULoEOZHjYhJTw1mkZQCH7OMbXYxB65ew3YR143oCgyle3i8SZPEG4U
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="359496413"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359496413"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 09:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="714026687"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="714026687"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 24 Aug 2023 09:50:25 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qZDXM-0002rn-17;
        Thu, 24 Aug 2023 16:50:24 +0000
Date:   Fri, 25 Aug 2023 00:49:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 b7dde0aa86616fe65545c48835feb4182f34a0c1
Message-ID: <202308250020.x5UJ8pRT-lkp@intel.com>
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
branch HEAD: b7dde0aa86616fe65545c48835feb4182f34a0c1  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 1460m

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
arc                   randconfig-001-20230824   gcc  
arc                  randconfig-r012-20230824   gcc  
arc                  randconfig-r032-20230824   gcc  
arc                  randconfig-r035-20230824   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230824   gcc  
arm                  randconfig-r024-20230824   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230824   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r036-20230824   gcc  
hexagon                             defconfig   clang
hexagon               randconfig-001-20230824   clang
hexagon               randconfig-002-20230824   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230824   gcc  
i386         buildonly-randconfig-002-20230824   gcc  
i386         buildonly-randconfig-003-20230824   gcc  
i386         buildonly-randconfig-004-20230824   gcc  
i386         buildonly-randconfig-005-20230824   gcc  
i386         buildonly-randconfig-006-20230824   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230824   gcc  
i386                  randconfig-002-20230824   gcc  
i386                  randconfig-003-20230824   gcc  
i386                  randconfig-004-20230824   gcc  
i386                  randconfig-005-20230824   gcc  
i386                  randconfig-006-20230824   gcc  
i386                  randconfig-011-20230824   clang
i386                  randconfig-012-20230824   clang
i386                  randconfig-013-20230824   clang
i386                  randconfig-014-20230824   clang
i386                  randconfig-015-20230824   clang
i386                  randconfig-016-20230824   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230824   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r015-20230824   gcc  
m68k                 randconfig-r021-20230824   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230824   gcc  
microblaze           randconfig-r002-20230824   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                          malta_defconfig   clang
mips                      malta_kvm_defconfig   clang
mips                 randconfig-r006-20230824   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230824   gcc  
nios2                randconfig-r005-20230824   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r011-20230824   gcc  
openrisc             randconfig-r014-20230824   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      pasemi_defconfig   gcc  
powerpc                     powernv_defconfig   clang
powerpc64            randconfig-r013-20230824   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230824   gcc  
riscv                randconfig-r026-20230824   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230824   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r022-20230824   gcc  
sh                   randconfig-r031-20230824   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r025-20230824   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r016-20230824   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r023-20230824   gcc  
um                   randconfig-r033-20230824   clang
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230824   gcc  
x86_64       buildonly-randconfig-002-20230824   gcc  
x86_64       buildonly-randconfig-003-20230824   gcc  
x86_64       buildonly-randconfig-004-20230824   gcc  
x86_64       buildonly-randconfig-005-20230824   gcc  
x86_64       buildonly-randconfig-006-20230824   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230824   clang
x86_64                randconfig-002-20230824   clang
x86_64                randconfig-003-20230824   clang
x86_64                randconfig-004-20230824   clang
x86_64                randconfig-005-20230824   clang
x86_64                randconfig-006-20230824   clang
x86_64                randconfig-011-20230824   gcc  
x86_64                randconfig-012-20230824   gcc  
x86_64                randconfig-013-20230824   gcc  
x86_64                randconfig-014-20230824   gcc  
x86_64                randconfig-015-20230824   gcc  
x86_64                randconfig-016-20230824   gcc  
x86_64                randconfig-071-20230824   gcc  
x86_64                randconfig-072-20230824   gcc  
x86_64                randconfig-073-20230824   gcc  
x86_64                randconfig-074-20230824   gcc  
x86_64                randconfig-075-20230824   gcc  
x86_64                randconfig-076-20230824   gcc  
x86_64               randconfig-r034-20230824   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                              defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
