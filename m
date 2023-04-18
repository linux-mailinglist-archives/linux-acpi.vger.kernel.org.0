Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51DF66E57A4
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Apr 2023 04:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjDRCy2 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 Apr 2023 22:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDRCy1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Apr 2023 22:54:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8D35272;
        Mon, 17 Apr 2023 19:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681786458; x=1713322458;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=0ES7cHpYP+fFxpqqYxns/vWYFGs0fsiXorQzlqOmbiU=;
  b=Pkfzs+iEKhfeCK/MnrZQQXKfkkdP6y6EEFbneZdHUDMWvaFHk6UjI1/Z
   ylzkYtWoO4Ifh6lKefVPWceFAeEcRr4Bzp9Zu20GewNGYPWzGii01Vr8E
   7Czc9HDxJMcCgEwExRpHWe7NTlc0MF0vRdmQ8UGlmlEDS+UFwii2GSx1h
   rBw34kgA818s+TagNGatCdraH16IFcU+xToMbMbbjdMCv3s46lP7Tes/9
   SzxwLTQUGHShevyTVHHl4+oTWlmXyvQ2t0LdUP+zrQj5DkcGmOp+nmiK9
   7HYECPcNhIekUA9oMPUhyjAF+Ip8l3sMvXNi8iJtTyiGYZMpz7Nw3wPoS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="410278547"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="410278547"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:54:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="937081851"
X-IronPort-AV: E=Sophos;i="5.99,205,1677571200"; 
   d="scan'208";a="937081851"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 Apr 2023 19:54:16 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pobTz-000csp-1A;
        Tue, 18 Apr 2023 02:54:15 +0000
Date:   Tue, 18 Apr 2023 10:54:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bc538c8be4bd17479f88f2e1a78d5b76b5523319
Message-ID: <643e0648.TOlAQF4jIw/+FzHL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bc538c8be4bd17479f88f2e1a78d5b76b5523319  Merge branches 'pm-core', 'pm-devfreq' and 'pm-tools' into linux-next

elapsed time: 729m

configs tested: 140
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230417   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230416   gcc  
alpha                randconfig-r021-20230416   gcc  
alpha                randconfig-r022-20230416   gcc  
alpha                randconfig-r025-20230417   gcc  
alpha                randconfig-r033-20230416   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230416   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r032-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230416   clang
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                            mps2_defconfig   gcc  
arm                  randconfig-r015-20230416   clang
arm                  randconfig-r022-20230417   gcc  
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm                         s3c6400_defconfig   gcc  
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r036-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r016-20230417   gcc  
hexagon      buildonly-randconfig-r006-20230416   clang
hexagon      buildonly-randconfig-r006-20230417   clang
hexagon              randconfig-r004-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r041-20230417   clang
hexagon              randconfig-r045-20230416   clang
hexagon              randconfig-r045-20230417   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230417   gcc  
i386                 randconfig-a002-20230417   gcc  
i386                 randconfig-a003-20230417   gcc  
i386                 randconfig-a004-20230417   gcc  
i386                 randconfig-a005-20230417   gcc  
i386                 randconfig-a006-20230417   gcc  
i386                 randconfig-a011-20230417   clang
i386                 randconfig-a012-20230417   clang
i386                 randconfig-a013-20230417   clang
i386                 randconfig-a014-20230417   clang
i386                 randconfig-a015-20230417   clang
i386                 randconfig-a016-20230417   clang
i386                 randconfig-r013-20230417   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r024-20230417   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230416   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r034-20230417   gcc  
microblaze           randconfig-r002-20230417   gcc  
microblaze           randconfig-r005-20230417   gcc  
microblaze           randconfig-r026-20230417   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
nios2        buildonly-randconfig-r003-20230416   gcc  
nios2                               defconfig   gcc  
openrisc             randconfig-r024-20230416   gcc  
parisc       buildonly-randconfig-r004-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230416   gcc  
parisc               randconfig-r026-20230416   gcc  
parisc               randconfig-r031-20230417   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      mgcoge_defconfig   gcc  
powerpc              randconfig-r001-20230417   gcc  
powerpc              randconfig-r031-20230416   clang
powerpc              randconfig-r033-20230417   gcc  
powerpc              randconfig-r036-20230416   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r023-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r006-20230416   clang
s390                 randconfig-r025-20230416   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                   randconfig-r002-20230416   gcc  
sh                   randconfig-r003-20230417   gcc  
sh                   randconfig-r006-20230417   gcc  
sh                   randconfig-r011-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230416   gcc  
sparc                randconfig-r012-20230417   gcc  
sparc64      buildonly-randconfig-r003-20230417   gcc  
sparc64              randconfig-r014-20230417   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230417   gcc  
x86_64               randconfig-a002-20230417   gcc  
x86_64               randconfig-a003-20230417   gcc  
x86_64               randconfig-a004-20230417   gcc  
x86_64               randconfig-a005-20230417   gcc  
x86_64               randconfig-a006-20230417   gcc  
x86_64               randconfig-a011-20230417   clang
x86_64               randconfig-a012-20230417   clang
x86_64               randconfig-a013-20230417   clang
x86_64               randconfig-a014-20230417   clang
x86_64               randconfig-a015-20230417   clang
x86_64               randconfig-a016-20230417   clang
x86_64               randconfig-r011-20230417   clang
x86_64               randconfig-r021-20230417   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r012-20230416   gcc  
xtensa               randconfig-r035-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
