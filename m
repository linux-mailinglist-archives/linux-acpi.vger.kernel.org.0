Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3376DB7BD
	for <lists+linux-acpi@lfdr.de>; Sat,  8 Apr 2023 02:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjDHAUS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 7 Apr 2023 20:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjDHAUS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Apr 2023 20:20:18 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195A4E07F;
        Fri,  7 Apr 2023 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680913217; x=1712449217;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=qnbCF50f5vNQcF/ATvH97KNjmp4mXCzIUTwieY4775c=;
  b=L5MtOKJNwuFdKjj8kvFu/EJ8qcIIiC1eJZZbjQJ9k63aCYLFKidAFEbZ
   hwg73Rh3JJd65UEzys4XiR7DEP2j/pHV+niKjnTEaA+cVLwrpltc47jOI
   SHw/DIeO8eVuwZOEmSfXJZbeGzlb5XGOn8XWrf2OEd6M/YhYvL4X3hlyT
   OjEhod+L/f2xha9g+xwDXyGDMr2G/uWGKKtBh2M8MSfo7BndjfvKiBXDH
   ypyfP4yhb5ICDt+dXvles0n0HObh2otSpcDuwYFraeB7GdahG5lwDB88L
   ykdzypejGT94IjZF+Ob39dyx+4QGnokQpAzKZoibOWGb9uAkYDzsU6IIc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408227183"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="408227183"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 17:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="798850868"
X-IronPort-AV: E=Sophos;i="5.98,328,1673942400"; 
   d="scan'208";a="798850868"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Apr 2023 17:20:14 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkwJS-000T3A-08;
        Sat, 08 Apr 2023 00:20:14 +0000
Date:   Sat, 08 Apr 2023 08:19:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 6bbfb44e060f52b4cc75311b4766bb6c9a2ae1da
Message-ID: <6430b32e.WrZdtFSFSuKJJ0WV%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 6bbfb44e060f52b4cc75311b4766bb6c9a2ae1da  Merge branch 'pm-core' into bleeding-edge

elapsed time: 726m

configs tested: 139
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r033-20230406   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r011-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230407   clang
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230404   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r022-20230403   gcc  
csky         buildonly-randconfig-r004-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230403   gcc  
csky                 randconfig-r004-20230403   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r003-20230403   clang
hexagon      buildonly-randconfig-r006-20230403   clang
hexagon              randconfig-r003-20230403   clang
hexagon              randconfig-r004-20230403   clang
hexagon              randconfig-r015-20230406   clang
hexagon              randconfig-r035-20230403   clang
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
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230407   gcc  
loongarch            randconfig-r032-20230406   gcc  
loongarch            randconfig-r034-20230406   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230403   gcc  
m68k                 randconfig-r023-20230403   gcc  
m68k                 randconfig-r034-20230404   gcc  
m68k                 randconfig-r036-20230406   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r012-20230406   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230404   clang
mips                 randconfig-r014-20230406   gcc  
mips                 randconfig-r021-20230403   clang
mips                 randconfig-r024-20230403   clang
nios2                               defconfig   gcc  
nios2                randconfig-r013-20230406   gcc  
nios2                randconfig-r033-20230404   gcc  
openrisc             randconfig-r006-20230403   gcc  
openrisc             randconfig-r012-20230403   gcc  
parisc       buildonly-randconfig-r001-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230404   clang
riscv                               defconfig   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r031-20230406   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230403   clang
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r011-20230406   gcc  
sh                   randconfig-r015-20230403   gcc  
sh                   randconfig-r016-20230406   gcc  
sh                   randconfig-r031-20230403   gcc  
sparc        buildonly-randconfig-r002-20230403   gcc  
sparc        buildonly-randconfig-r003-20230404   gcc  
sparc        buildonly-randconfig-r004-20230404   gcc  
sparc        buildonly-randconfig-r005-20230404   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230403   gcc  
sparc                randconfig-r015-20230407   gcc  
sparc64              randconfig-r013-20230407   gcc  
sparc64              randconfig-r035-20230406   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r014-20230407   gcc  
xtensa               randconfig-r016-20230407   gcc  
xtensa               randconfig-r035-20230404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
