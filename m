Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2A7259BA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jun 2023 11:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239894AbjFGJMS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Jun 2023 05:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239852AbjFGJLh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Jun 2023 05:11:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2001BF8;
        Wed,  7 Jun 2023 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686129056; x=1717665056;
  h=date:from:to:cc:subject:message-id;
  bh=mjJOaH+WPWdzG0n9ToOGyA9Qg+rLEDrmNmanJzJn0RM=;
  b=RQvA6MTLi4vQn6uwWYMYHQMLPcLqstJWkjjRmVPWIMUBH02mmdiiIVPF
   RkEh7bobHo3SjiwXgxIlZ/EH9rC4PrbqH3oHuIhYBtkR116a2MJkEd8Qv
   BhKbOcFfP7fB+BbIV5G2NdQdExYcOeBNMO/x6ViHkPo1VjgXGx3llhZJn
   pWvguKsZ4FH0yvVX+55Q8AbJW7lKruTxxsRmxtJfWODXeXsXGFQw1312n
   pHVElB//rwgzfy5QM9tMVwyLXNWpF+hMUzK9cANLYt7JeBE2NMRMAwGLi
   fREBZJ/P8SaezngNQrF2aTTfteKa+BwHKsXUoz3ah05tsu8C7sLOzrDcP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="359402704"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="359402704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2023 02:10:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="659856610"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="659856610"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2023 02:10:54 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6pBu-0006Qi-0D;
        Wed, 07 Jun 2023 09:10:54 +0000
Date:   Wed, 07 Jun 2023 17:10:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 dda1186b1b88e54cd40458ccf30c0fd3f9be5299
Message-ID: <20230607091018.bsGsl%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: dda1186b1b88e54cd40458ccf30c0fd3f9be5299  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 815m

configs tested: 119
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r031-20230606   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r013-20230606   gcc  
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r025-20230606   clang
csky                                defconfig   gcc  
csky                 randconfig-r022-20230606   gcc  
hexagon              randconfig-r041-20230606   clang
hexagon              randconfig-r045-20230606   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230606   gcc  
i386                 randconfig-i002-20230606   gcc  
i386                 randconfig-i003-20230606   gcc  
i386                 randconfig-i004-20230606   gcc  
i386                 randconfig-i005-20230606   gcc  
i386                 randconfig-i006-20230606   gcc  
i386                 randconfig-i011-20230606   clang
i386                 randconfig-i012-20230606   clang
i386                 randconfig-i013-20230606   clang
i386                 randconfig-i014-20230606   clang
i386                 randconfig-i015-20230606   clang
i386                 randconfig-i016-20230606   clang
i386                 randconfig-i051-20230606   gcc  
i386                 randconfig-i052-20230606   gcc  
i386                 randconfig-i053-20230606   gcc  
i386                 randconfig-i054-20230606   gcc  
i386                 randconfig-i055-20230606   gcc  
i386                 randconfig-i056-20230606   gcc  
i386                 randconfig-i061-20230606   gcc  
i386                 randconfig-i062-20230606   gcc  
i386                 randconfig-i063-20230606   gcc  
i386                 randconfig-i064-20230606   gcc  
i386                 randconfig-i065-20230606   gcc  
i386                 randconfig-i066-20230606   gcc  
i386                 randconfig-r033-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230606   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r026-20230606   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
microblaze           randconfig-r024-20230606   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r003-20230606   clang
mips                 randconfig-r001-20230606   clang
nios2                               defconfig   gcc  
nios2                randconfig-r011-20230606   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r021-20230606   clang
powerpc              randconfig-r032-20230606   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230606   clang
riscv        buildonly-randconfig-r006-20230606   clang
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230606   gcc  
riscv                randconfig-r015-20230606   clang
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230606   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230606   gcc  
s390                 randconfig-r014-20230606   clang
s390                 randconfig-r035-20230606   gcc  
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r005-20230606   gcc  
sh                   randconfig-r034-20230606   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r012-20230606   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230606   gcc  
x86_64               randconfig-a002-20230606   gcc  
x86_64               randconfig-a003-20230606   gcc  
x86_64               randconfig-a004-20230606   gcc  
x86_64               randconfig-a005-20230606   gcc  
x86_64               randconfig-a006-20230606   gcc  
x86_64               randconfig-a011-20230606   clang
x86_64               randconfig-a012-20230606   clang
x86_64               randconfig-a013-20230606   clang
x86_64               randconfig-a014-20230606   clang
x86_64               randconfig-a015-20230606   clang
x86_64               randconfig-a016-20230606   clang
x86_64               randconfig-r003-20230606   gcc  
x86_64               randconfig-x051-20230606   clang
x86_64               randconfig-x052-20230606   clang
x86_64               randconfig-x053-20230606   clang
x86_64               randconfig-x054-20230606   clang
x86_64               randconfig-x055-20230606   clang
x86_64               randconfig-x056-20230606   clang
x86_64               randconfig-x061-20230606   clang
x86_64               randconfig-x062-20230606   clang
x86_64               randconfig-x063-20230606   clang
x86_64               randconfig-x064-20230606   clang
x86_64               randconfig-x065-20230606   clang
x86_64               randconfig-x066-20230606   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
