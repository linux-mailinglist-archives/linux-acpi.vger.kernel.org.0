Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD05778E5ED
	for <lists+linux-acpi@lfdr.de>; Thu, 31 Aug 2023 07:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240300AbjHaFrN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 31 Aug 2023 01:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHaFrK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Aug 2023 01:47:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D14E0;
        Wed, 30 Aug 2023 22:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693460826; x=1724996826;
  h=date:from:to:cc:subject:message-id;
  bh=CnOsyx8oq1YnERBwL/fXRx02nGiEL6rQEC37SWQfvP4=;
  b=GUXBbbA2Ra7aojangX0yulULUFxVWubBj1MxoNTPFsJViLc9z7nYHIOG
   nDlCxFTmEgQuB+zK3tvTv0+ugknScYqelnpAlov2B1Z39I/TaxYmHXDQ7
   VVsQgusUyPBl+vOCn7mlx3SU+zhziX7pO5sUcOjkHcvk2lbKhb4z724dL
   AIztAD3UjaV05DN2Hk11EsFrPu0/gFnX0wAfc5uq7dx2kj2K5PUMzHp7G
   4tzl2+PpQuTHdzPM9LgQavXpsPw2ngZriL+MRA+toZvgMaRZMG+sKg0R0
   omI+tZasiZ8Dr09eD/oe3+/hOrxppjp6XFxT4Rn4ePhlUdWWQpoKC0Oh0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="356136764"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="356136764"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 22:47:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="739346773"
X-IronPort-AV: E=Sophos;i="6.02,215,1688454000"; 
   d="scan'208";a="739346773"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 30 Aug 2023 22:47:04 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qbaWG-000AjM-0X;
        Thu, 31 Aug 2023 05:47:04 +0000
Date:   Thu, 31 Aug 2023 13:45:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 003894c19da3987667731ef1c6d4734b5632eeb6
Message-ID: <202308311317.ywzYDoZC-lkp@intel.com>
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
branch HEAD: 003894c19da3987667731ef1c6d4734b5632eeb6  Merge branch 'thermal-core' into linux-next

elapsed time: 969m

configs tested: 227
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230831   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230830   gcc  
arc                   randconfig-001-20230831   gcc  
arc                  randconfig-r001-20230831   gcc  
arc                  randconfig-r006-20230830   gcc  
arc                  randconfig-r026-20230831   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230830   clang
arm                   randconfig-001-20230831   gcc  
arm                  randconfig-r013-20230831   gcc  
arm                  randconfig-r025-20230831   gcc  
arm                  randconfig-r031-20230831   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r012-20230830   gcc  
arm64                randconfig-r033-20230831   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon               randconfig-001-20230830   clang
hexagon               randconfig-001-20230831   clang
hexagon               randconfig-002-20230830   clang
hexagon               randconfig-002-20230831   clang
hexagon              randconfig-r024-20230830   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230830   clang
i386         buildonly-randconfig-001-20230831   gcc  
i386         buildonly-randconfig-002-20230830   clang
i386         buildonly-randconfig-002-20230831   gcc  
i386         buildonly-randconfig-003-20230830   clang
i386         buildonly-randconfig-003-20230831   gcc  
i386         buildonly-randconfig-004-20230830   clang
i386         buildonly-randconfig-004-20230831   gcc  
i386         buildonly-randconfig-005-20230830   clang
i386         buildonly-randconfig-005-20230831   gcc  
i386         buildonly-randconfig-006-20230830   clang
i386         buildonly-randconfig-006-20230831   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230830   clang
i386                  randconfig-001-20230831   gcc  
i386                  randconfig-002-20230830   clang
i386                  randconfig-002-20230831   gcc  
i386                  randconfig-003-20230830   clang
i386                  randconfig-003-20230831   gcc  
i386                  randconfig-004-20230830   clang
i386                  randconfig-004-20230831   gcc  
i386                  randconfig-005-20230830   clang
i386                  randconfig-005-20230831   gcc  
i386                  randconfig-006-20230830   clang
i386                  randconfig-006-20230831   gcc  
i386                  randconfig-011-20230830   gcc  
i386                  randconfig-011-20230831   clang
i386                  randconfig-012-20230830   gcc  
i386                  randconfig-012-20230831   clang
i386                  randconfig-013-20230830   gcc  
i386                  randconfig-013-20230831   clang
i386                  randconfig-014-20230830   gcc  
i386                  randconfig-014-20230831   clang
i386                  randconfig-015-20230830   gcc  
i386                  randconfig-015-20230831   clang
i386                  randconfig-016-20230830   gcc  
i386                  randconfig-016-20230831   clang
i386                 randconfig-r013-20230830   gcc  
i386                 randconfig-r016-20230830   gcc  
i386                 randconfig-r026-20230830   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230830   gcc  
loongarch            randconfig-r002-20230831   gcc  
loongarch            randconfig-r011-20230831   gcc  
loongarch            randconfig-r014-20230830   gcc  
loongarch            randconfig-r036-20230830   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230830   gcc  
m68k                 randconfig-r015-20230830   gcc  
m68k                 randconfig-r035-20230830   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230830   gcc  
microblaze           randconfig-r023-20230830   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r032-20230831   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230831   gcc  
nios2                randconfig-r022-20230831   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r036-20230831   gcc  
powerpc64            randconfig-r003-20230830   clang
powerpc64            randconfig-r006-20230831   gcc  
powerpc64            randconfig-r012-20230831   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230830   clang
riscv                 randconfig-001-20230831   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230830   gcc  
s390                  randconfig-001-20230831   clang
s390                 randconfig-r003-20230831   gcc  
s390                 randconfig-r032-20230830   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r021-20230831   gcc  
sh                   randconfig-r034-20230830   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r004-20230830   gcc  
sparc                randconfig-r004-20230831   gcc  
sparc                randconfig-r005-20230830   gcc  
sparc                randconfig-r031-20230830   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r033-20230830   gcc  
sparc64              randconfig-r035-20230831   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r014-20230831   gcc  
um                   randconfig-r015-20230831   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230830   clang
x86_64       buildonly-randconfig-002-20230830   clang
x86_64       buildonly-randconfig-003-20230830   clang
x86_64       buildonly-randconfig-004-20230830   clang
x86_64       buildonly-randconfig-005-20230830   clang
x86_64       buildonly-randconfig-006-20230830   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230830   gcc  
x86_64                randconfig-001-20230831   clang
x86_64                randconfig-002-20230830   gcc  
x86_64                randconfig-002-20230831   clang
x86_64                randconfig-003-20230830   gcc  
x86_64                randconfig-003-20230831   clang
x86_64                randconfig-004-20230830   gcc  
x86_64                randconfig-004-20230831   clang
x86_64                randconfig-005-20230830   gcc  
x86_64                randconfig-005-20230831   clang
x86_64                randconfig-006-20230830   gcc  
x86_64                randconfig-006-20230831   clang
x86_64                randconfig-011-20230830   clang
x86_64                randconfig-011-20230831   gcc  
x86_64                randconfig-012-20230830   clang
x86_64                randconfig-012-20230831   gcc  
x86_64                randconfig-013-20230830   clang
x86_64                randconfig-013-20230831   gcc  
x86_64                randconfig-014-20230830   clang
x86_64                randconfig-014-20230831   gcc  
x86_64                randconfig-015-20230830   clang
x86_64                randconfig-015-20230831   gcc  
x86_64                randconfig-016-20230830   clang
x86_64                randconfig-016-20230831   gcc  
x86_64                randconfig-071-20230830   clang
x86_64                randconfig-071-20230831   gcc  
x86_64                randconfig-072-20230830   clang
x86_64                randconfig-072-20230831   gcc  
x86_64                randconfig-073-20230830   clang
x86_64                randconfig-073-20230831   gcc  
x86_64                randconfig-074-20230830   clang
x86_64                randconfig-074-20230831   gcc  
x86_64                randconfig-075-20230830   clang
x86_64                randconfig-075-20230831   gcc  
x86_64                randconfig-076-20230830   clang
x86_64                randconfig-076-20230831   gcc  
x86_64               randconfig-r016-20230831   clang
x86_64               randconfig-r022-20230830   gcc  
x86_64               randconfig-r024-20230831   clang
x86_64               randconfig-r025-20230830   gcc  
x86_64               randconfig-r034-20230831   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230830   gcc  
xtensa               randconfig-r021-20230830   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
