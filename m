Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9230175DCA4
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Jul 2023 14:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjGVMmc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 22 Jul 2023 08:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGVMmb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jul 2023 08:42:31 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1BBF10DE;
        Sat, 22 Jul 2023 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690029749; x=1721565749;
  h=date:from:to:cc:subject:message-id;
  bh=z0JWj68Br/Iy6F6tHdpJ2c2/bNOwCwUnte/SK+y06h8=;
  b=LNP+44BnTWbm/z7dTUDzwbSOBOV/rwP9RazP4f1ss6n5pQnWmBT0Ky7K
   F4iTlKJV6fgjjhmzYplnQP7WEBElqsZWdJAWNSVaSicGuvFgCVIyo5S20
   zHRgj1V3X6molTkGnArr/5YcDmMLfjEQwD+f1CPiAcknU8HNtXBbjUORB
   dwx4HgFVBTFVPTgbDThqoFa8mBerTnAH60OcVG3FT2YJnIIcZIIk/tSI8
   SEzSPu7mGcpTN420R2B7wtL+1/h++DRtZFEWc8XGa9k+isgBenbCy/Kc0
   swJucDYNdWmEX/ptwjhFfBLndmg9FvjSq41rnjaButT8OM3lOBAb219Ny
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="433423831"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="433423831"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2023 05:42:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="795276114"
X-IronPort-AV: E=Sophos;i="6.01,224,1684825200"; 
   d="scan'208";a="795276114"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Jul 2023 05:42:28 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qNBwJ-0008JT-3A;
        Sat, 22 Jul 2023 12:42:27 +0000
Date:   Sat, 22 Jul 2023 20:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 ec7d45e9a07db059dfc070680296ce2fbfef0e5d
Message-ID: <202307222041.TpN6xkkS-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ec7d45e9a07db059dfc070680296ce2fbfef0e5d  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 922m

configs tested: 112
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230720   gcc  
alpha                randconfig-r022-20230720   gcc  
alpha                randconfig-r024-20230720   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230720   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230720   gcc  
arm                  randconfig-r046-20230720   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230720   clang
csky                                defconfig   gcc  
csky                 randconfig-r004-20230720   gcc  
csky                 randconfig-r005-20230720   gcc  
csky                 randconfig-r021-20230720   gcc  
hexagon              randconfig-r041-20230720   clang
hexagon              randconfig-r045-20230720   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230721   clang
i386         buildonly-randconfig-r005-20230721   clang
i386         buildonly-randconfig-r006-20230721   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230720   gcc  
i386                 randconfig-i002-20230720   gcc  
i386                 randconfig-i003-20230720   gcc  
i386                 randconfig-i004-20230720   gcc  
i386                 randconfig-i005-20230720   gcc  
i386                 randconfig-i006-20230720   gcc  
i386                 randconfig-i011-20230720   clang
i386                 randconfig-i012-20230720   clang
i386                 randconfig-i013-20230720   clang
i386                 randconfig-i014-20230720   clang
i386                 randconfig-i015-20230720   clang
i386                 randconfig-i016-20230720   clang
i386                 randconfig-r002-20230720   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230720   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230720   gcc  
m68k                 randconfig-r023-20230720   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   clang
mips                 randconfig-r034-20230720   clang
nios2                               defconfig   gcc  
openrisc             randconfig-r013-20230720   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230720   gcc  
parisc               randconfig-r012-20230720   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r026-20230720   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r042-20230720   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230720   clang
s390                 randconfig-r044-20230720   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r015-20230720   gcc  
sh                   randconfig-r031-20230720   gcc  
sh                   secureedge5410_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r036-20230720   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230721   clang
x86_64       buildonly-randconfig-r002-20230721   clang
x86_64       buildonly-randconfig-r003-20230721   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-x001-20230720   clang
x86_64               randconfig-x002-20230720   clang
x86_64               randconfig-x003-20230720   clang
x86_64               randconfig-x004-20230720   clang
x86_64               randconfig-x005-20230720   clang
x86_64               randconfig-x006-20230720   clang
x86_64               randconfig-x011-20230720   gcc  
x86_64               randconfig-x012-20230720   gcc  
x86_64               randconfig-x013-20230720   gcc  
x86_64               randconfig-x014-20230720   gcc  
x86_64               randconfig-x015-20230720   gcc  
x86_64               randconfig-x016-20230720   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r032-20230720   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
