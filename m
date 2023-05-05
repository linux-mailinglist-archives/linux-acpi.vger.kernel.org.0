Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE136F7DBF
	for <lists+linux-acpi@lfdr.de>; Fri,  5 May 2023 09:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEEHZd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 May 2023 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjEEHZc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 May 2023 03:25:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B66417FD4;
        Fri,  5 May 2023 00:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683271525; x=1714807525;
  h=date:from:to:cc:subject:message-id;
  bh=3ztxBcgx4LiBQmX7pOrAqblQwgqlugbM0UjwSE3OCkw=;
  b=QiOS8lO/6dKgnG92XHQ03AldRuXzVshaQwR4+XF8bxw/5XsonvWk0oBz
   hiNqin7AwcTzwTUHc9qAG90hb0SvwT7kufjpxqKySL5mjCw5Chw3oTdKh
   6VE2BiB9swmwg+y89+9HudYmMIJmVQqlXYpKAUNN/e2g69PzworC6BuyH
   Wt6zzwYGM5Z5euiTcVQiQgMyXsNCa3LdCYJat5TB5TRrr8P9GzniK0yaR
   h+nV73gfvich7GGADmgCgSZaFyEGEQ1J4sWzF6B822HAryRJXHetVPUKE
   Qwn5YSgNvP2OU3cGm4n4s+fynkKw9M4mVylerhaCPHeL7TVorrZAA8QfU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="412376611"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="412376611"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 00:25:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="1027335628"
X-IronPort-AV: E=Sophos;i="5.99,251,1677571200"; 
   d="scan'208";a="1027335628"
Received: from lkp-server01.sh.intel.com (HELO fe5d646e317d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 May 2023 00:25:06 -0700
Received: from kbuild by fe5d646e317d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pupoP-0000LF-2j;
        Fri, 05 May 2023 07:25:05 +0000
Date:   Fri, 05 May 2023 15:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4b99907a5a3dc8b8bfa91bf4dbde0e59371cab64
Message-ID: <20230505072417.iXFCR%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4b99907a5a3dc8b8bfa91bf4dbde0e59371cab64  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 721m

configs tested: 162
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230501   gcc  
alpha                randconfig-r025-20230502   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230430   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arc                  randconfig-r036-20230504   gcc  
arc                  randconfig-r043-20230430   gcc  
arc                  randconfig-r043-20230501   gcc  
arc                  randconfig-r043-20230502   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                  randconfig-r002-20230430   clang
arm                  randconfig-r002-20230501   clang
arm                  randconfig-r011-20230501   gcc  
arm                  randconfig-r026-20230502   clang
arm                  randconfig-r046-20230430   gcc  
arm                  randconfig-r046-20230501   gcc  
arm                  randconfig-r046-20230502   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230501   gcc  
arm64                randconfig-r015-20230501   clang
csky         buildonly-randconfig-r002-20230430   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230502   gcc  
csky                 randconfig-r012-20230502   gcc  
csky                 randconfig-r023-20230502   gcc  
csky                 randconfig-r032-20230504   gcc  
hexagon      buildonly-randconfig-r005-20230430   clang
hexagon              randconfig-r001-20230430   clang
hexagon              randconfig-r005-20230502   clang
hexagon              randconfig-r006-20230501   clang
hexagon              randconfig-r015-20230430   clang
hexagon              randconfig-r015-20230502   clang
hexagon              randconfig-r041-20230430   clang
hexagon              randconfig-r041-20230501   clang
hexagon              randconfig-r041-20230502   clang
hexagon              randconfig-r045-20230430   clang
hexagon              randconfig-r045-20230501   clang
hexagon              randconfig-r045-20230502   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230501   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230501   gcc  
i386                 randconfig-a002-20230501   gcc  
i386                 randconfig-a003-20230501   gcc  
i386                 randconfig-a004-20230501   gcc  
i386                 randconfig-a005-20230501   gcc  
i386                 randconfig-a006-20230501   gcc  
i386                 randconfig-a011-20230501   clang
i386                 randconfig-a012-20230501   clang
i386                 randconfig-a013-20230501   clang
i386                 randconfig-a014-20230501   clang
i386                 randconfig-a015-20230501   clang
i386                 randconfig-a016-20230501   clang
i386                 randconfig-r012-20230501   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230502   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5275evb_defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                 randconfig-r006-20230430   gcc  
m68k                 randconfig-r013-20230501   gcc  
m68k                 randconfig-r016-20230502   gcc  
microblaze   buildonly-randconfig-r001-20230501   gcc  
microblaze   buildonly-randconfig-r006-20230430   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           gcw0_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r004-20230502   gcc  
mips                        vocore2_defconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230502   gcc  
nios2                randconfig-r035-20230502   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230502   gcc  
parisc               randconfig-r005-20230430   gcc  
parisc               randconfig-r013-20230502   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                    amigaone_defconfig   gcc  
powerpc                      bamboo_defconfig   gcc  
powerpc                       ebony_defconfig   clang
powerpc                      katmai_defconfig   clang
powerpc                     mpc512x_defconfig   clang
powerpc              randconfig-r013-20230430   clang
powerpc              randconfig-r014-20230430   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230430   clang
riscv        buildonly-randconfig-r003-20230501   clang
riscv        buildonly-randconfig-r004-20230430   clang
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230502   clang
riscv                randconfig-r033-20230504   clang
riscv                randconfig-r042-20230430   clang
riscv                randconfig-r042-20230501   clang
riscv                randconfig-r042-20230502   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230501   clang
s390                                defconfig   gcc  
s390                 randconfig-r011-20230502   gcc  
s390                 randconfig-r012-20230430   clang
s390                 randconfig-r014-20230501   clang
s390                 randconfig-r022-20230502   gcc  
s390                 randconfig-r032-20230502   clang
s390                 randconfig-r044-20230430   clang
s390                 randconfig-r044-20230501   clang
s390                 randconfig-r044-20230502   gcc  
sh                               allmodconfig   gcc  
sh                          r7780mp_defconfig   gcc  
sh                   randconfig-r004-20230430   gcc  
sh                   randconfig-r011-20230430   gcc  
sh                           se7619_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230430   gcc  
sparc                randconfig-r003-20230502   gcc  
sparc                randconfig-r035-20230504   gcc  
sparc64              randconfig-r005-20230501   gcc  
sparc64              randconfig-r016-20230430   gcc  
sparc64              randconfig-r016-20230501   gcc  
sparc64              randconfig-r031-20230504   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230501   gcc  
x86_64               randconfig-a002-20230501   gcc  
x86_64               randconfig-a003-20230501   gcc  
x86_64               randconfig-a004-20230501   gcc  
x86_64               randconfig-a005-20230501   gcc  
x86_64               randconfig-a006-20230501   gcc  
x86_64               randconfig-a011-20230501   clang
x86_64               randconfig-a012-20230501   clang
x86_64               randconfig-a013-20230501   clang
x86_64               randconfig-a014-20230501   clang
x86_64               randconfig-a015-20230501   clang
x86_64               randconfig-a016-20230501   clang
x86_64                               rhel-8.3   gcc  
xtensa                generic_kc705_defconfig   gcc  
xtensa               randconfig-r033-20230502   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
