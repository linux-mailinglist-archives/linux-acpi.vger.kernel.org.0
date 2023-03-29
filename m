Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0003B6CD376
	for <lists+linux-acpi@lfdr.de>; Wed, 29 Mar 2023 09:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2Hkt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 29 Mar 2023 03:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjC2Hks (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2023 03:40:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314B10DE;
        Wed, 29 Mar 2023 00:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680075643; x=1711611643;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=9oKYEcBp0CusUw/Kjrt4ftdMr9BFrOXO9Pmo09w2kCw=;
  b=j74151YH6MZmcV2dolbrq+Gltx78GGClMW3kMEmQyswll/LNqayska1S
   uyKNGsNKOfnPGzaaxclLwTpSXDK3yXOecPQNds69ssSgArfJfp/xbLAYS
   QKByjlLQb2eDBrYQVR9XrX+AVcSsKW1ZRMYfd+9uTBrYbY+zIUflXPjjS
   +87PvUprIPX6lV2AsZfCoVAZ8od//zePdjS7wgHTCxoT3WLpMECUlzZJ0
   74PtxiUodreDPHjyivhoLYd91orcVeyIvPBr2V0N9wqa3hDjmeByujRlN
   cwPyIZviNvElRaGR/U0lUtM8uLyvZTIjVmAi6E2+HYPyDOvquqp5jK83Y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="403428069"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="403428069"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 00:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10663"; a="858372648"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="858372648"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 00:40:41 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1phQQC-000JJi-2J;
        Wed, 29 Mar 2023 07:40:40 +0000
Date:   Wed, 29 Mar 2023 15:40:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8e76079c4ac1007cd5d09357f4cbab9b820f8e65
Message-ID: <6423eb70.Thn1ERBapZnTQb8c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8e76079c4ac1007cd5d09357f4cbab9b820f8e65  Merge branch 'thermal-core-fixes' into bleeding-edge

elapsed time: 724m

configs tested: 129
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230326   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r012-20230326   gcc  
arc                  randconfig-r034-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r031-20230327   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230327   gcc  
csky         buildonly-randconfig-r002-20230327   gcc  
csky         buildonly-randconfig-r003-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230326   gcc  
csky                 randconfig-r006-20230326   gcc  
csky                 randconfig-r034-20230326   gcc  
hexagon              randconfig-r013-20230327   clang
hexagon              randconfig-r041-20230326   clang
hexagon              randconfig-r041-20230327   clang
hexagon              randconfig-r045-20230326   clang
hexagon              randconfig-r045-20230327   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230327   gcc  
i386                 randconfig-a002-20230327   gcc  
i386                 randconfig-a003-20230327   gcc  
i386                 randconfig-a004-20230327   gcc  
i386                 randconfig-a005-20230327   gcc  
i386                 randconfig-a006-20230327   gcc  
i386                 randconfig-a011-20230327   clang
i386                 randconfig-a012-20230327   clang
i386                 randconfig-a013-20230327   clang
i386                 randconfig-a014-20230327   clang
i386                 randconfig-a015-20230327   clang
i386                 randconfig-a016-20230327   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230327   gcc  
loongarch            randconfig-r012-20230327   gcc  
loongarch            randconfig-r032-20230326   gcc  
loongarch            randconfig-r033-20230327   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r031-20230326   gcc  
m68k                 randconfig-r031-20230328   gcc  
microblaze           randconfig-r016-20230327   gcc  
microblaze           randconfig-r024-20230328   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230327   clang
mips                 randconfig-r001-20230326   gcc  
nios2        buildonly-randconfig-r001-20230326   gcc  
nios2        buildonly-randconfig-r002-20230326   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230326   gcc  
nios2                randconfig-r015-20230327   gcc  
nios2                randconfig-r036-20230328   gcc  
openrisc     buildonly-randconfig-r001-20230327   gcc  
openrisc             randconfig-r006-20230327   gcc  
parisc       buildonly-randconfig-r004-20230327   gcc  
parisc       buildonly-randconfig-r005-20230327   gcc  
parisc       buildonly-randconfig-r006-20230326   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230328   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r002-20230326   clang
powerpc              randconfig-r026-20230328   gcc  
powerpc              randconfig-r036-20230327   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r006-20230327   clang
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230326   gcc  
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230327   gcc  
sh                   randconfig-r033-20230328   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230326   gcc  
sparc64              randconfig-r001-20230327   gcc  
sparc64              randconfig-r003-20230327   gcc  
sparc64              randconfig-r034-20230328   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230327   gcc  
x86_64               randconfig-a002-20230327   gcc  
x86_64               randconfig-a003-20230327   gcc  
x86_64               randconfig-a004-20230327   gcc  
x86_64               randconfig-a005-20230327   gcc  
x86_64               randconfig-a006-20230327   gcc  
x86_64               randconfig-a011-20230327   clang
x86_64               randconfig-a012-20230327   clang
x86_64               randconfig-a013-20230327   clang
x86_64               randconfig-a014-20230327   clang
x86_64               randconfig-a015-20230327   clang
x86_64               randconfig-a016-20230327   clang
x86_64               randconfig-r014-20230327   clang
x86_64               randconfig-r035-20230327   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r004-20230327   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
