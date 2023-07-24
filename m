Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7C7600CF
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Jul 2023 23:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjGXVBk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 24 Jul 2023 17:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjGXVBj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2023 17:01:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99214E42;
        Mon, 24 Jul 2023 14:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690232498; x=1721768498;
  h=date:from:to:cc:subject:message-id;
  bh=rkS2qus9+yLJvVtHVcLGwMppjODXPLv4/nN/Bp36wV0=;
  b=BQKe+r/dpfEQanIvtTsagWRhxIx45vF0n4rkJnGw6m84T3L2yEsE4lU7
   FWOmg5AyVCQN3uFJT7xpU0r2cL8Xk9I5kBKEleH+svoaB2yJCV45sQuM2
   XHDR81EyX3kP4EX3pNHWrETyo9UMOyfH3+yC1qpV+5Nj5xV7IqDvklvUf
   KYJUzAXivw4XDgIJk3JMvJQskSveJeY2peEC3YV+EktL7ngBW/Ha1tydZ
   brbY4h4uaZCMLej1skbaL0lethpkJkH1+J+5tkLMq8m6FUlBs3bxHCmzs
   QHnNimYbwhGA11+G77tfhWeAJOO8owi7MzoTZ/DLNhx3D/ujXBZppBM1G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="347825866"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="347825866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 14:01:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="725843145"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="725843145"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Jul 2023 14:01:36 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qO2gR-000A2R-22;
        Mon, 24 Jul 2023 21:01:35 +0000
Date:   Tue, 25 Jul 2023 05:00:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6d6069648add84ffa0eeeadad79342c75c66d15c
Message-ID: <202307250537.cq2trgWC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6d6069648add84ffa0eeeadad79342c75c66d15c  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 724m

configs tested: 107
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230724   gcc  
alpha                randconfig-r015-20230724   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230724   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r046-20230724   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230724   clang
csky                                defconfig   gcc  
hexagon              randconfig-r002-20230724   clang
hexagon              randconfig-r041-20230724   clang
hexagon              randconfig-r045-20230724   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230724   gcc  
i386         buildonly-randconfig-r005-20230724   gcc  
i386         buildonly-randconfig-r006-20230724   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230724   gcc  
i386                 randconfig-i002-20230724   gcc  
i386                 randconfig-i003-20230724   gcc  
i386                 randconfig-i004-20230724   gcc  
i386                 randconfig-i005-20230724   gcc  
i386                 randconfig-i006-20230724   gcc  
i386                 randconfig-i011-20230724   clang
i386                 randconfig-i012-20230724   clang
i386                 randconfig-i013-20230724   clang
i386                 randconfig-i014-20230724   clang
i386                 randconfig-i015-20230724   clang
i386                 randconfig-i016-20230724   clang
i386                 randconfig-r011-20230724   clang
i386                 randconfig-r033-20230724   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230724   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r023-20230724   gcc  
microblaze           randconfig-r004-20230724   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r031-20230724   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r012-20230724   gcc  
openrisc             randconfig-r014-20230724   gcc  
openrisc             randconfig-r021-20230724   gcc  
openrisc             randconfig-r026-20230724   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r032-20230724   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r024-20230724   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230724   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230724   clang
sh                               allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230724   gcc  
sparc64              randconfig-r013-20230724   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r003-20230724   clang
um                   randconfig-r006-20230724   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230724   gcc  
x86_64       buildonly-randconfig-r002-20230724   gcc  
x86_64       buildonly-randconfig-r003-20230724   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r035-20230724   gcc  
x86_64               randconfig-x001-20230724   clang
x86_64               randconfig-x002-20230724   clang
x86_64               randconfig-x003-20230724   clang
x86_64               randconfig-x004-20230724   clang
x86_64               randconfig-x005-20230724   clang
x86_64               randconfig-x006-20230724   clang
x86_64               randconfig-x011-20230724   gcc  
x86_64               randconfig-x012-20230724   gcc  
x86_64               randconfig-x013-20230724   gcc  
x86_64               randconfig-x014-20230724   gcc  
x86_64               randconfig-x015-20230724   gcc  
x86_64               randconfig-x016-20230724   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r036-20230724   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
