Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEABF75145E
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Jul 2023 01:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjGLXSO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 Jul 2023 19:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjGLXSL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2023 19:18:11 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0918110D4;
        Wed, 12 Jul 2023 16:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689203891; x=1720739891;
  h=date:from:to:cc:subject:message-id;
  bh=2Ounp3OzKIAfcKRbE0X+fVZZzuJIsvfMNvBBRuKxW5U=;
  b=da9HLBTWGcp+tfo3KwW7SKVJwJRZlYTlGtAFR+dswaF3YCywr+BW8XH6
   Nv4m7b9LJv4hxC9fPMeO2JzF4t1lqvqJDw9c4pBeJonHM5h8M9X/dvuW4
   AFPnPyoi7x04TM7PAl2f+fxZoiYRn46kPlq91BYRij6CPMJUdsK/YdU4T
   KvUIBbGs203YQh7ERk7xG/2R5yKKeUpC3DbSAFidTF+VF7gbXfKzPtBDh
   4lyX6k35Ws0kCCajy5sGAYtyOvBsHU5zM9hlQnlttxWZ5u1PqGaWy2z9q
   v+Nd7p7G6n3pyw0e5ikMVd7HzguJ3NkDO10BBCsGBJDFEPDv9WkqvHQ8c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="354944272"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="354944272"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 16:18:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="725061987"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="725061987"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 16:18:08 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qJj60-00062G-15;
        Wed, 12 Jul 2023 23:18:08 +0000
Date:   Thu, 13 Jul 2023 07:17:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f56f47fd8f54ce29b240450f15d09bc13c76171a
Message-ID: <202307130753.V77k5rl2-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f56f47fd8f54ce29b240450f15d09bc13c76171a  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 722m

configs tested: 108
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r013-20230712   gcc  
arc                  randconfig-r036-20230712   gcc  
arc                  randconfig-r043-20230712   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                  randconfig-r003-20230712   clang
arm                  randconfig-r046-20230712   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230712   gcc  
arm64                randconfig-r005-20230712   gcc  
arm64                randconfig-r015-20230712   clang
csky                                defconfig   gcc  
hexagon              randconfig-r041-20230712   clang
hexagon              randconfig-r045-20230712   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230712   gcc  
i386         buildonly-randconfig-r005-20230712   gcc  
i386         buildonly-randconfig-r006-20230712   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230712   gcc  
i386                 randconfig-i002-20230712   gcc  
i386                 randconfig-i003-20230712   gcc  
i386                 randconfig-i004-20230712   gcc  
i386                 randconfig-i005-20230712   gcc  
i386                 randconfig-i006-20230712   gcc  
i386                 randconfig-i011-20230712   clang
i386                 randconfig-i012-20230712   clang
i386                 randconfig-i013-20230712   clang
i386                 randconfig-i014-20230712   clang
i386                 randconfig-i015-20230712   clang
i386                 randconfig-i016-20230712   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r022-20230712   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                 randconfig-r034-20230712   clang
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230712   gcc  
openrisc             randconfig-r024-20230712   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r035-20230712   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230712   clang
riscv                randconfig-r042-20230712   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r023-20230712   clang
s390                 randconfig-r044-20230712   clang
sh                               allmodconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r033-20230712   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r025-20230712   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230712   gcc  
x86_64       buildonly-randconfig-r002-20230712   gcc  
x86_64       buildonly-randconfig-r003-20230712   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r006-20230712   gcc  
x86_64               randconfig-r031-20230712   gcc  
x86_64               randconfig-x001-20230712   clang
x86_64               randconfig-x002-20230712   clang
x86_64               randconfig-x003-20230712   clang
x86_64               randconfig-x004-20230712   clang
x86_64               randconfig-x005-20230712   clang
x86_64               randconfig-x006-20230712   clang
x86_64               randconfig-x011-20230712   gcc  
x86_64               randconfig-x012-20230712   gcc  
x86_64               randconfig-x013-20230712   gcc  
x86_64               randconfig-x014-20230712   gcc  
x86_64               randconfig-x015-20230712   gcc  
x86_64               randconfig-x016-20230712   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230712   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
