Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0F96BAAF4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Mar 2023 09:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjCOIlg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Mar 2023 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjCOIlf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Mar 2023 04:41:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5D96B945;
        Wed, 15 Mar 2023 01:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678869694; x=1710405694;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=EOW+A8ObFwtJACF4mHpNjo0UR1ukaCOyOm2iZsvaGu4=;
  b=azHzO2MsyojJNVjuCBjm4MGwixcfM4sEIdyI5s3epZqKT5pldODkPU7W
   uVIEEBrIJPQQtohYKshmOuL4RtZ2Xdc8kFXV9U2Zr9aoF1ewRyxQKYT9w
   EuEcktByjmNvLp9Zuxuew0RHIoyjY4TAbvEmnPvSQ89H6BL1RTpPGvI6g
   zTDbwDI1NyEME7pmlKOoFW7yLxWLz4X6GEfGnRtBwSz/29QqS/x2aEbJe
   q8b0mww9gNEX3vZMzUEDuO0j+JJ4aM7ubab2rOSMOU1AoMQCdxeCx8t6O
   Qa9equdPoYup0MnhLwfwaVzcKA5OzerOE34Mq/8vi4wi8fvuzOgi7soXF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340010066"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340010066"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 01:41:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="656681962"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="656681962"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2023 01:41:31 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pcMhK-0007Xw-16;
        Wed, 15 Mar 2023 08:41:26 +0000
Date:   Wed, 15 Mar 2023 16:41:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 45b1e9aa507403b52aac7044eecaa770a23e5ae0
Message-ID: <641184aa./iOTK5Qu348Veftk%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 45b1e9aa507403b52aac7044eecaa770a23e5ae0  Merge branch 'acpi-tools' into bleeding-edge

elapsed time: 729m

configs tested: 121
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230314   gcc  
alpha                randconfig-r002-20230314   gcc  
alpha                randconfig-r004-20230314   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r015-20230312   gcc  
arc                  randconfig-r043-20230312   gcc  
arc                  randconfig-r043-20230313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r011-20230313   gcc  
arm                  randconfig-r046-20230312   clang
arm                  randconfig-r046-20230313   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r014-20230313   gcc  
hexagon              randconfig-r023-20230313   clang
hexagon              randconfig-r041-20230312   clang
hexagon              randconfig-r041-20230313   clang
hexagon              randconfig-r045-20230312   clang
hexagon              randconfig-r045-20230313   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230313   gcc  
i386                 randconfig-a002-20230313   gcc  
i386                 randconfig-a003-20230313   gcc  
i386                 randconfig-a004-20230313   gcc  
i386                 randconfig-a005-20230313   gcc  
i386                 randconfig-a006-20230313   gcc  
i386                 randconfig-a011-20230313   clang
i386                 randconfig-a012-20230313   clang
i386                 randconfig-a013-20230313   clang
i386                 randconfig-a014-20230313   clang
i386                 randconfig-a015-20230313   clang
i386                 randconfig-a016-20230313   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230312   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230312   gcc  
loongarch            randconfig-r032-20230312   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230314   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r022-20230313   gcc  
mips                 randconfig-r023-20230312   clang
mips                 randconfig-r025-20230312   clang
nios2        buildonly-randconfig-r001-20230313   gcc  
nios2        buildonly-randconfig-r006-20230313   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r025-20230313   gcc  
nios2                randconfig-r036-20230312   gcc  
openrisc             randconfig-r026-20230312   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230312   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r014-20230312   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230312   gcc  
riscv                randconfig-r026-20230313   clang
riscv                randconfig-r042-20230312   gcc  
riscv                randconfig-r042-20230313   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230312   gcc  
s390         buildonly-randconfig-r002-20230312   gcc  
s390         buildonly-randconfig-r003-20230312   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r016-20230313   clang
s390                 randconfig-r044-20230312   gcc  
s390                 randconfig-r044-20230313   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r002-20230313   gcc  
sh           buildonly-randconfig-r003-20230313   gcc  
sh           buildonly-randconfig-r005-20230313   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r006-20230314   gcc  
sparc                randconfig-r024-20230312   gcc  
sparc64              randconfig-r012-20230313   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r004-20230313   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230313   gcc  
x86_64               randconfig-a002-20230313   gcc  
x86_64               randconfig-a003-20230313   gcc  
x86_64               randconfig-a004-20230313   gcc  
x86_64               randconfig-a005-20230313   gcc  
x86_64               randconfig-a006-20230313   gcc  
x86_64               randconfig-a011-20230313   clang
x86_64               randconfig-a012-20230313   clang
x86_64               randconfig-a013-20230313   clang
x86_64               randconfig-a014-20230313   clang
x86_64               randconfig-a015-20230313   clang
x86_64               randconfig-a016-20230313   clang
x86_64               randconfig-r024-20230313   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r004-20230312   gcc  
xtensa               randconfig-r003-20230314   gcc  
xtensa               randconfig-r021-20230313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
