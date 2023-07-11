Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC97074E76E
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jul 2023 08:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbjGKGh6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jul 2023 02:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGKGhx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jul 2023 02:37:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A3A6;
        Mon, 10 Jul 2023 23:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689057472; x=1720593472;
  h=date:from:to:cc:subject:message-id;
  bh=ZneV9oBzod4xTR8TYQKRxAV5AqjiBL2c2OXBkIJhoDs=;
  b=cvAQD3h4R/xaCSGKopEGcW9JwQU4J0+2NgXp6+c9n6z1Jy/5C1wzb7nw
   4s7Tk0dhxu0Rb4ZhyplsNerzliURjyZaGYatHxzfUJeao0CA4WAu5yOXd
   tEzLU+lIy4ejOrEIRKefjYZ/cyXWWyzPOcmIjaMkGf6ax4bogEpH5p1vo
   JqJ454kIeopyxTcImxhnNMfW/wVRIbzdejsCthx5Rfrimp0aBv4BjejYe
   fSUR6OE0bABLF3NrurepvPaK5oaJ3NRfQKxGt9iQtJQbpt3tmdv6Ht+MK
   K+wAt0xPB8h7o9MJx78Hv+yHPkoAU8E+i0FzXJaLo2tXy4kmr/ED2vEO5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="450900793"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="450900793"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 23:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="967678022"
X-IronPort-AV: E=Sophos;i="6.01,196,1684825200"; 
   d="scan'208";a="967678022"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jul 2023 23:37:45 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJ70L-0004P0-0M;
        Tue, 11 Jul 2023 06:37:45 +0000
Date:   Tue, 11 Jul 2023 14:37:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 c530a7f1973b4c2eed7e71de3c74f26292a1e1a9
Message-ID: <202307111432.N81dy3Qw-lkp@intel.com>
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
branch HEAD: c530a7f1973b4c2eed7e71de3c74f26292a1e1a9  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 724m

configs tested: 127
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230710   gcc  
arc                              alldefconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230710   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                   milbeaut_m10v_defconfig   clang
arm                       netwinder_defconfig   clang
arm                  randconfig-r032-20230710   clang
arm                  randconfig-r033-20230710   clang
arm                  randconfig-r046-20230710   gcc  
arm                         s5pv210_defconfig   clang
arm                           sama5_defconfig   gcc  
arm                        spear3xx_defconfig   clang
arm                           stm32_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r013-20230710   gcc  
hexagon                             defconfig   clang
hexagon              randconfig-r003-20230710   clang
hexagon              randconfig-r005-20230710   clang
hexagon              randconfig-r031-20230710   clang
hexagon              randconfig-r035-20230710   clang
hexagon              randconfig-r041-20230710   clang
hexagon              randconfig-r045-20230710   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230710   gcc  
i386         buildonly-randconfig-r005-20230710   gcc  
i386         buildonly-randconfig-r006-20230710   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230711   clang
i386                 randconfig-i002-20230711   clang
i386                 randconfig-i003-20230711   clang
i386                 randconfig-i004-20230711   clang
i386                 randconfig-i005-20230711   clang
i386                 randconfig-i006-20230711   clang
i386                 randconfig-i011-20230710   clang
i386                 randconfig-i012-20230710   clang
i386                 randconfig-i013-20230710   clang
i386                 randconfig-i014-20230710   clang
i386                 randconfig-i015-20230710   clang
i386                 randconfig-i016-20230710   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230710   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r001-20230710   gcc  
microblaze           randconfig-r021-20230711   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                          ath25_defconfig   clang
mips                 randconfig-r034-20230710   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230710   gcc  
openrisc             randconfig-r015-20230710   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r023-20230711   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                       ppc64_defconfig   gcc  
powerpc              randconfig-r004-20230710   gcc  
powerpc              randconfig-r006-20230710   gcc  
powerpc                     sequoia_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230711   gcc  
riscv                randconfig-r042-20230710   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230710   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r016-20230710   gcc  
sh                   randconfig-r026-20230711   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230710   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r012-20230710   gcc  
um                   randconfig-r025-20230711   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230710   gcc  
x86_64       buildonly-randconfig-r002-20230710   gcc  
x86_64       buildonly-randconfig-r003-20230710   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r024-20230711   gcc  
x86_64               randconfig-x001-20230710   clang
x86_64               randconfig-x002-20230710   clang
x86_64               randconfig-x003-20230710   clang
x86_64               randconfig-x004-20230710   clang
x86_64               randconfig-x005-20230710   clang
x86_64               randconfig-x006-20230710   clang
x86_64               randconfig-x011-20230710   gcc  
x86_64               randconfig-x012-20230710   gcc  
x86_64               randconfig-x013-20230710   gcc  
x86_64               randconfig-x014-20230710   gcc  
x86_64               randconfig-x015-20230710   gcc  
x86_64               randconfig-x016-20230710   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa                  audio_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
