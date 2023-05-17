Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3522B705F0F
	for <lists+linux-acpi@lfdr.de>; Wed, 17 May 2023 07:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbjEQFE6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 17 May 2023 01:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjEQFE5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 17 May 2023 01:04:57 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE942136;
        Tue, 16 May 2023 22:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684299896; x=1715835896;
  h=date:from:to:cc:subject:message-id;
  bh=eOcgo1b2zgQqT4igFFBSPPk0tJ8cYJd1kXmVjA8LxzU=;
  b=CHy0QqtZwReyJKid6Kb9LfKa4vBvfYHW35DVekMSb01Bt3+RzNqG97lk
   5HAC43Wi+1YXftg6kaeZmcV29JurB0BFXTZvFSAaIDvL6xyvPAGtU8ZcT
   wyD10VMV/91NwVd7HC4sySquoIAp6A6J+CcA9E3U2HoAPYzyhfVWCybTZ
   JEF5DeshrewghHoWWbA7qBoyofRwg3HBcrtNLXBO26W/so+4zx4bBMIs1
   BznSrjVm7QDWVt8NinC4NarqvIxcsa6BLvzV7GjL3gctmFhUBr3koxQsm
   x2awTgCJEbgPlTdV4kIeK71JfVCrHErALryKmn0Z7VzdvGHyg4Alm+A1Q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="349164121"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="349164121"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 22:04:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="771334516"
X-IronPort-AV: E=Sophos;i="5.99,281,1677571200"; 
   d="scan'208";a="771334516"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 May 2023 22:04:54 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pz9LJ-0008G7-1R;
        Wed, 17 May 2023 05:04:53 +0000
Date:   Wed, 17 May 2023 13:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 2eb9db58cef824fd8c5b0107462478b80d4870a5
Message-ID: <20230517050425.Iaxjx%lkp@intel.com>
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

tree/branch: INFO setup_repo_specs: /db/releases/20230517121050/lkp-src/repo/*/rafael-pm
https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 2eb9db58cef824fd8c5b0107462478b80d4870a5  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 728m

configs tested: 169
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230515   gcc  
arc                  randconfig-r043-20230516   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                  randconfig-r022-20230516   gcc  
arm                  randconfig-r025-20230515   clang
arm                  randconfig-r046-20230515   clang
arm                  randconfig-r046-20230516   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230515   clang
arm64                               defconfig   gcc  
arm64                randconfig-r026-20230515   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230515   gcc  
csky                 randconfig-r031-20230515   gcc  
hexagon              randconfig-r021-20230515   clang
hexagon              randconfig-r023-20230515   clang
hexagon              randconfig-r041-20230515   clang
hexagon              randconfig-r041-20230516   clang
hexagon              randconfig-r045-20230515   clang
hexagon              randconfig-r045-20230516   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r001-20230515   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230515   clang
i386                 randconfig-a002-20230515   clang
i386                 randconfig-a003-20230515   clang
i386                 randconfig-a004-20230515   clang
i386                 randconfig-a005-20230515   clang
i386                 randconfig-a006-20230515   clang
i386                 randconfig-a011-20230515   gcc  
i386                 randconfig-a012-20230515   gcc  
i386                 randconfig-a013-20230515   gcc  
i386                 randconfig-a014-20230515   gcc  
i386                 randconfig-a015-20230515   gcc  
i386                 randconfig-a016-20230515   gcc  
i386                          randconfig-i051   gcc  
i386                          randconfig-i052   clang
i386                          randconfig-i053   gcc  
i386                          randconfig-i054   clang
i386                          randconfig-i055   gcc  
i386                          randconfig-i056   clang
i386                 randconfig-i061-20230515   clang
i386                 randconfig-i062-20230515   clang
i386                 randconfig-i063-20230515   clang
i386                 randconfig-i064-20230515   clang
i386                 randconfig-i065-20230515   clang
i386                 randconfig-i066-20230515   clang
i386                 randconfig-i081-20230515   gcc  
i386                 randconfig-i082-20230515   gcc  
i386                 randconfig-i083-20230515   gcc  
i386                 randconfig-i084-20230515   gcc  
i386                 randconfig-i085-20230515   gcc  
i386                 randconfig-i086-20230515   gcc  
i386                 randconfig-i091-20230515   clang
i386                 randconfig-i092-20230515   clang
i386                 randconfig-i093-20230515   clang
i386                 randconfig-i094-20230515   clang
i386                 randconfig-i095-20230515   clang
i386                 randconfig-i096-20230515   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230515   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r025-20230516   gcc  
microblaze           randconfig-r006-20230515   gcc  
microblaze           randconfig-r013-20230515   gcc  
microblaze           randconfig-r024-20230515   gcc  
microblaze           randconfig-r026-20230516   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230515   clang
mips                 randconfig-r035-20230515   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r003-20230515   gcc  
openrisc             randconfig-r036-20230515   gcc  
parisc       buildonly-randconfig-r006-20230515   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230515   clang
riscv                randconfig-r004-20230515   clang
riscv                randconfig-r042-20230515   gcc  
riscv                randconfig-r042-20230516   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r012-20230515   gcc  
s390                 randconfig-r023-20230516   clang
s390                 randconfig-r044-20230515   gcc  
s390                 randconfig-r044-20230516   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r033-20230515   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r015-20230515   gcc  
sparc                randconfig-r024-20230516   gcc  
sparc                randconfig-r032-20230515   gcc  
sparc                randconfig-r034-20230515   gcc  
sparc64              randconfig-r011-20230515   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230515   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230515   clang
x86_64               randconfig-a002-20230515   clang
x86_64               randconfig-a003-20230515   clang
x86_64               randconfig-a004-20230515   clang
x86_64               randconfig-a005-20230515   clang
x86_64               randconfig-a006-20230515   clang
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-r016-20230515   gcc  
x86_64               randconfig-x051-20230515   gcc  
x86_64               randconfig-x052-20230515   gcc  
x86_64               randconfig-x053-20230515   gcc  
x86_64               randconfig-x054-20230515   gcc  
x86_64               randconfig-x055-20230515   gcc  
x86_64               randconfig-x056-20230515   gcc  
x86_64               randconfig-x061-20230515   gcc  
x86_64               randconfig-x062-20230515   gcc  
x86_64               randconfig-x063-20230515   gcc  
x86_64               randconfig-x064-20230515   gcc  
x86_64               randconfig-x065-20230515   gcc  
x86_64               randconfig-x066-20230515   gcc  
x86_64               randconfig-x071-20230515   clang
x86_64               randconfig-x072-20230515   clang
x86_64               randconfig-x073-20230515   clang
x86_64               randconfig-x074-20230515   clang
x86_64               randconfig-x075-20230515   clang
x86_64               randconfig-x076-20230515   clang
x86_64               randconfig-x081-20230515   clang
x86_64               randconfig-x082-20230515   clang
x86_64               randconfig-x083-20230515   clang
x86_64               randconfig-x084-20230515   clang
x86_64               randconfig-x085-20230515   clang
x86_64               randconfig-x086-20230515   clang
x86_64                        randconfig-x091   clang
x86_64                        randconfig-x092   gcc  
x86_64                        randconfig-x093   clang
x86_64                        randconfig-x094   gcc  
x86_64                        randconfig-x095   clang
x86_64                        randconfig-x096   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230515   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
