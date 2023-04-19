Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AC96E744D
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Apr 2023 09:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjDSHtu (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Apr 2023 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjDSHtq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Apr 2023 03:49:46 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2370E132;
        Wed, 19 Apr 2023 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681890585; x=1713426585;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1JAl5eOMO9iDI3YtcwnQJ7Ut9F3DDr//yESFeU4hB9M=;
  b=Pnjjl/rp4x8seUoUOK2Im94M4KnhdZu6j3r0ycUY6/4Nwga+qAiqclJg
   lh5E6JuP/snhKOsU7t1c0FNrKBaAJwn3npNeFlPXp+IGz3/41HNQSG2cf
   L3GJhIBLMm2H1YYwYOlQQ0zoRoDxDU4+pSJjmOBEUY2SQUX8gA5Nif+rj
   4KFE+IhiBBo1EVcwdwVsOiElCE3XJfK15PtNEJDTzBqg3ypt4pkwWd5T7
   4kd+4kw3za7wRX9eKkYCDLu2RPnz2dCSgKZBlq3CVSSYeNLytKRKpaONB
   dVZCT4EipIstf0Jw8Q39yDO1oQ3MOhpe0Sja1K86+CUdLSMYI39X3ruHX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="431659652"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="431659652"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 00:49:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="684893831"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="684893831"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 19 Apr 2023 00:49:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pp2ZR-000eh8-1i;
        Wed, 19 Apr 2023 07:49:41 +0000
Date:   Wed, 19 Apr 2023 15:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 7124d7671af0facf115d70f9d1fadde0d768d325
Message-ID: <643f9cf4.MyQvn+pKrx4qQMmJ%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: 7124d7671af0facf115d70f9d1fadde0d768d325  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 727m

configs tested: 134
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230416   gcc  
alpha                randconfig-r023-20230416   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230416   gcc  
arc                  randconfig-r043-20230416   gcc  
arc                  randconfig-r043-20230417   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230417   gcc  
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r026-20230416   clang
arm                  randconfig-r046-20230416   clang
arm                  randconfig-r046-20230417   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230416   clang
arm64                randconfig-r012-20230416   gcc  
arm64                randconfig-r014-20230417   clang
arm64                randconfig-r016-20230416   gcc  
arm64                randconfig-r032-20230416   clang
arm64                randconfig-r036-20230417   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230416   gcc  
hexagon              randconfig-r014-20230416   clang
hexagon              randconfig-r025-20230416   clang
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
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r005-20230418   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230417   gcc  
ia64                 randconfig-r031-20230416   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230417   gcc  
loongarch            randconfig-r013-20230416   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r006-20230418   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r024-20230416   gcc  
m68k                 randconfig-r035-20230416   gcc  
microblaze           randconfig-r001-20230417   gcc  
microblaze           randconfig-r003-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230419   clang
mips                 randconfig-r005-20230416   gcc  
mips                 randconfig-r012-20230417   gcc  
mips                 randconfig-r016-20230417   gcc  
mips                 randconfig-r026-20230417   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230417   gcc  
openrisc             randconfig-r015-20230417   gcc  
openrisc             randconfig-r033-20230417   gcc  
openrisc             randconfig-r034-20230416   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230419   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230418   gcc  
powerpc      buildonly-randconfig-r003-20230418   gcc  
powerpc              randconfig-r032-20230417   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230419   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                randconfig-r042-20230417   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230416   gcc  
s390                 randconfig-r044-20230417   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r001-20230419   gcc  
sh                   randconfig-r013-20230417   gcc  
sh                   randconfig-r024-20230417   gcc  
sh                   randconfig-r033-20230416   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r002-20230419   gcc  
sparc                randconfig-r004-20230417   gcc  
sparc                randconfig-r021-20230416   gcc  
sparc                randconfig-r031-20230417   gcc  
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
x86_64               randconfig-r025-20230417   clang
x86_64               randconfig-r035-20230417   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r003-20230417   gcc  
xtensa               randconfig-r006-20230416   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
