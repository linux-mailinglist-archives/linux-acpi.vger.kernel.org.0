Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6F5746839
	for <lists+linux-acpi@lfdr.de>; Tue,  4 Jul 2023 06:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjGDEDj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 4 Jul 2023 00:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGDEDh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Jul 2023 00:03:37 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05B68F;
        Mon,  3 Jul 2023 21:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688443416; x=1719979416;
  h=date:from:to:cc:subject:message-id;
  bh=93bctGz3z4Pl8tWVaQiQyK6jagRtQvBMLyhBC1LE5QE=;
  b=gnutP5vhsAStMhOqwG6ec5/L9azqMczz+B58YKCpqhPgljoKim7phKDZ
   pPscXeEFUiJekcfqeDTTy0flvu4ca35SjLW4AmFWHxN3J5SBXDkKYN0b+
   43n4IOMwpF/m7oZ3lXJoh7uHiRl7utZD/Kl3FnAhXF4LnrwgZ9yjevude
   suQS9v83EKMV78IGUuSIXv0SPdsGUNtU93CmfT7BBdPZQOlN9kRqhIRKn
   d0M8qqhllISHEOi+/7YmGdknoCMbRzwWnpBHQOGPhLNGzfMwxj5E31WgT
   c9Y+5LZxesqh2mbrGeqIxbazHULuAPuEOMkn3RRAbbPDsLvfhyNu64eiX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="363062945"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="363062945"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2023 21:03:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="718777623"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="718777623"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 03 Jul 2023 21:03:34 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qGXGG-000Hrq-0M;
        Tue, 04 Jul 2023 04:03:32 +0000
Date:   Tue, 04 Jul 2023 12:03:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e7c5bd3ce61586cf170d9e3511b715d8c90c694e
Message-ID: <202307041213.khfpOdFO-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e7c5bd3ce61586cf170d9e3511b715d8c90c694e  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 739m

configs tested: 151
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230703   gcc  
alpha                randconfig-r032-20230703   gcc  
alpha                randconfig-r033-20230703   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r025-20230703   gcc  
arc                  randconfig-r043-20230703   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                        mvebu_v5_defconfig   clang
arm                  randconfig-r001-20230703   clang
arm                  randconfig-r012-20230703   gcc  
arm                  randconfig-r026-20230703   gcc  
arm                  randconfig-r032-20230703   clang
arm                  randconfig-r046-20230703   gcc  
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230703   clang
arm64                randconfig-r031-20230703   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r022-20230703   gcc  
hexagon              randconfig-r011-20230703   clang
hexagon              randconfig-r023-20230703   clang
hexagon              randconfig-r031-20230703   clang
hexagon              randconfig-r041-20230703   clang
hexagon              randconfig-r045-20230703   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230703   gcc  
i386         buildonly-randconfig-r005-20230703   gcc  
i386         buildonly-randconfig-r006-20230703   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230703   gcc  
i386                 randconfig-i002-20230703   gcc  
i386                 randconfig-i003-20230703   gcc  
i386                 randconfig-i004-20230703   gcc  
i386                 randconfig-i005-20230703   gcc  
i386                 randconfig-i006-20230703   gcc  
i386                 randconfig-i011-20230703   clang
i386                 randconfig-i012-20230703   clang
i386                 randconfig-i013-20230703   clang
i386                 randconfig-i014-20230703   clang
i386                 randconfig-i015-20230703   clang
i386                 randconfig-i016-20230703   clang
i386                 randconfig-r035-20230703   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230703   gcc  
loongarch            randconfig-r003-20230703   gcc  
loongarch            randconfig-r023-20230703   gcc  
loongarch            randconfig-r034-20230703   gcc  
loongarch            randconfig-r035-20230703   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r026-20230703   gcc  
microblaze           randconfig-r034-20230703   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r001-20230703   clang
mips                 randconfig-r004-20230703   clang
mips                 randconfig-r006-20230703   clang
mips                 randconfig-r036-20230703   clang
mips                          rm200_defconfig   clang
nios2                               defconfig   gcc  
nios2                randconfig-r001-20230703   gcc  
nios2                randconfig-r005-20230703   gcc  
nios2                randconfig-r012-20230703   gcc  
nios2                randconfig-r021-20230703   gcc  
nios2                randconfig-r022-20230703   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r022-20230703   gcc  
parisc               randconfig-r024-20230703   gcc  
parisc               randconfig-r032-20230703   gcc  
parisc               randconfig-r033-20230703   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r015-20230703   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r033-20230703   gcc  
riscv                randconfig-r036-20230703   gcc  
riscv                randconfig-r042-20230703   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r005-20230703   gcc  
s390                 randconfig-r006-20230703   gcc  
s390                 randconfig-r021-20230703   clang
s390                 randconfig-r044-20230703   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r003-20230703   gcc  
sh                   randconfig-r026-20230703   gcc  
sh                   randconfig-r034-20230703   gcc  
sh                   randconfig-r035-20230703   gcc  
sh                   randconfig-r036-20230703   gcc  
sh                           se7751_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230703   gcc  
sparc                randconfig-r004-20230703   gcc  
sparc                randconfig-r014-20230703   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r024-20230703   gcc  
sparc64              randconfig-r031-20230703   gcc  
sparc64              randconfig-r036-20230703   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r025-20230703   gcc  
um                   randconfig-r036-20230703   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230703   gcc  
x86_64       buildonly-randconfig-r002-20230703   gcc  
x86_64       buildonly-randconfig-r003-20230703   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r015-20230703   clang
x86_64               randconfig-r031-20230703   gcc  
x86_64               randconfig-x001-20230703   clang
x86_64               randconfig-x002-20230703   clang
x86_64               randconfig-x003-20230703   clang
x86_64               randconfig-x004-20230703   clang
x86_64               randconfig-x005-20230703   clang
x86_64               randconfig-x006-20230703   clang
x86_64               randconfig-x011-20230703   gcc  
x86_64               randconfig-x012-20230703   gcc  
x86_64               randconfig-x013-20230703   gcc  
x86_64               randconfig-x014-20230703   gcc  
x86_64               randconfig-x015-20230703   gcc  
x86_64               randconfig-x016-20230703   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r013-20230703   gcc  
xtensa               randconfig-r016-20230703   gcc  
xtensa               randconfig-r026-20230703   gcc  
xtensa               randconfig-r035-20230703   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
