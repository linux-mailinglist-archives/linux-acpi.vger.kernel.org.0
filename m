Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44EF6D904F
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Apr 2023 09:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbjDFHPI (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 6 Apr 2023 03:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjDFHPG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 6 Apr 2023 03:15:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902761BCD;
        Thu,  6 Apr 2023 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680765303; x=1712301303;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=k50dQYG6PE8iLGXoQVKiCdg87HJIiyCBTiTGyqpsi6I=;
  b=ZgTPhefnW7ZHRofkARMbLeqHVOgW5nfEF2M/LOeOUNvNypmbEgNxAWDa
   xJv9gXMV9WnOwSQ53DPEsrf//7IuHdgNazhFame9Va26fkzruDhihevQs
   VpAntz9YxnXxRTPJ5RqkBF/xZ+6IfiLG0vKo0uUyEVZR2+9NKi8b/2hZR
   Ed64Qb5kLxsMJpGepLZg1gkKzKD6YcgCFSrYj3QOhKRxt2fWKwbfh87Vy
   3UGne8rk/gn/+8t61/w82wSvU0sY8GjgdcLy6FlznH+ubm0WUrIWX5PRB
   0YPQLlpwFLBVZmOEwsA/vJLW4DpaypCPpOIiikaHWp/G9aH2QPBuBwbTg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="331276445"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="331276445"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 00:15:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10671"; a="830649148"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="830649148"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Apr 2023 00:13:42 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkJoT-000R9x-2Q;
        Thu, 06 Apr 2023 07:13:41 +0000
Date:   Thu, 06 Apr 2023 15:13:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 a7f01d6bfe2bccdd4ecbd2a662b6b56bfff50b2d
Message-ID: <642e7105.fhmm75qZXry+LBM7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: a7f01d6bfe2bccdd4ecbd2a662b6b56bfff50b2d  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 721m

configs tested: 99
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230403   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230403   clang
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r021-20230404   gcc  
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r022-20230403   gcc  
ia64                 randconfig-r023-20230403   gcc  
ia64                 randconfig-r026-20230404   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r025-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r003-20230403   gcc  
nios2        buildonly-randconfig-r006-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
openrisc             randconfig-r012-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r035-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230403   gcc  
sparc                randconfig-r004-20230403   gcc  
sparc                randconfig-r014-20230403   gcc  
sparc                randconfig-r022-20230404   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r002-20230403   gcc  
sparc64              randconfig-r001-20230403   gcc  
sparc64              randconfig-r021-20230403   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r005-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r024-20230404   gcc  
xtensa               randconfig-r026-20230403   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
