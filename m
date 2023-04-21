Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58B86EA361
	for <lists+linux-acpi@lfdr.de>; Fri, 21 Apr 2023 07:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjDUFxd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Apr 2023 01:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDUFxa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Apr 2023 01:53:30 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9EE2109;
        Thu, 20 Apr 2023 22:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682056409; x=1713592409;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=iiFEuZ0HpktGv4SCrxmMQaPmKn1zuDXgF3AL7K5QDSs=;
  b=JMZLkeuBaJxY2uqpZapOhcRCYPQHuxb36nWsXE7Rho0j8vwWoo7LVi8I
   dGcOdeFGv7UvJdvwJAT5ZRQr/5Im4w40nfd26w3BnihgWnHP2WAT9bhRU
   zNbOvmJgIdaUbGP3zgQ1lBn5f4kqnTU+aZLZ51O2lWeyQkxso9AqVlBVZ
   gzj5frGBnVkTCoh8FBFQU0jJ/Ck8K8O1uKlyXe21HJ2fHZRQi92cAJvVq
   nA4XXO2VMEzlV7yI59OXIdXi8nmVAg4LAaB34iQx7Et/IWAaR2g7+VRU+
   orbaQQHgck5eRkkavP1IkicHB2i77QF12HzRRm8ipCjeJVQRCeGCNTGc1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="348715211"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="348715211"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 22:53:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="836056786"
X-IronPort-AV: E=Sophos;i="5.99,214,1677571200"; 
   d="scan'208";a="836056786"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 20 Apr 2023 22:53:05 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ppjhg-000gMG-0y;
        Fri, 21 Apr 2023 05:53:04 +0000
Date:   Fri, 21 Apr 2023 13:52:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5f58939ec8cdd93a31e4bf832448a82d4782bdd6
Message-ID: <64422486.FQmHxjuDxrtBcblc%lkp@intel.com>
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
branch HEAD: 5f58939ec8cdd93a31e4bf832448a82d4782bdd6  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 725m

configs tested: 141
configs skipped: 11

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230416   gcc  
alpha                randconfig-r035-20230416   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230416   gcc  
arc                  randconfig-r011-20230416   gcc  
arc                  randconfig-r021-20230416   gcc  
arc                  randconfig-r033-20230420   gcc  
arc                  randconfig-r043-20230416   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230416   clang
arm                  randconfig-r022-20230416   clang
arm                  randconfig-r031-20230416   gcc  
arm                  randconfig-r046-20230416   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230416   clang
arm64                randconfig-r016-20230416   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230417   gcc  
csky                 randconfig-r002-20230417   gcc  
csky                 randconfig-r003-20230417   gcc  
csky                 randconfig-r032-20230416   gcc  
csky                 randconfig-r033-20230416   gcc  
csky                 randconfig-r034-20230417   gcc  
hexagon              randconfig-r004-20230417   clang
hexagon              randconfig-r015-20230416   clang
hexagon              randconfig-r022-20230417   clang
hexagon              randconfig-r024-20230417   clang
hexagon              randconfig-r041-20230416   clang
hexagon              randconfig-r045-20230416   clang
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
ia64         buildonly-randconfig-r005-20230420   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r013-20230417   gcc  
ia64                 randconfig-r034-20230420   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r023-20230417   gcc  
loongarch            randconfig-r031-20230417   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230420   gcc  
microblaze           randconfig-r036-20230416   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230420   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r025-20230417   gcc  
mips                 randconfig-r026-20230416   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230416   gcc  
nios2                randconfig-r032-20230417   gcc  
nios2                randconfig-r032-20230420   gcc  
openrisc             randconfig-r015-20230417   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230416   gcc  
parisc               randconfig-r035-20230420   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        icon_defconfig   clang
powerpc                      makalu_defconfig   gcc  
powerpc              randconfig-r006-20230420   clang
powerpc              randconfig-r036-20230417   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230420   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r003-20230420   clang
riscv                randconfig-r014-20230416   gcc  
riscv                randconfig-r042-20230416   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230420   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230416   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r006-20230420   gcc  
sh                   randconfig-r012-20230417   gcc  
sh                   randconfig-r013-20230416   gcc  
sh                   randconfig-r014-20230417   gcc  
sh                          rsk7201_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230420   gcc  
sparc                randconfig-r011-20230417   gcc  
sparc                randconfig-r016-20230417   gcc  
sparc                randconfig-r033-20230417   gcc  
sparc64      buildonly-randconfig-r004-20230420   gcc  
sparc64              randconfig-r003-20230416   gcc  
sparc64              randconfig-r006-20230417   gcc  
sparc64              randconfig-r025-20230416   gcc  
sparc64              randconfig-r031-20230420   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r023-20230416   gcc  
xtensa               randconfig-r024-20230416   gcc  
xtensa               randconfig-r035-20230417   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
