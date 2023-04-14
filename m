Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1B6E1C85
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Apr 2023 08:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjDNGTV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Apr 2023 02:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjDNGTV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Apr 2023 02:19:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7615271;
        Thu, 13 Apr 2023 23:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681453160; x=1712989160;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=uk/FzkAIAgMA0FAxo0UpL+fehTJ6HC9vQAE33yQT3YE=;
  b=Yj7roD9ddMjIvxo6FNPX/JZ1QB7iU5G/m2KqPSsV0c0bi8wEG+2G4L1b
   MEcDdUCOQjoxziCn/W/D4z2IvtHqux3TWaHUJ5OcdwAPOAOJKjYs/1L+O
   K+g6nIPzT4K2W73UMiTmmZfmwyPagEZto4+qx+y4XZJR/uyrNwqIma/HP
   h4w9LcjWzhU/ua7iQQNX6UTUvRXoggP3l2eYN622R6xp9rnlPOejyod1f
   fRSrT3hxdflmX2hDz1bRshF7qB8UNzic0EHt+BPcFpex3kWpbe1EzunyU
   pyKsEtss23RPHg/LQlPdTRNtYH3FQXx1+nt6OJhY0n1QipvKRevDrlCii
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="372256672"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="372256672"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 23:19:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="689674885"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="689674885"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Apr 2023 23:19:17 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnCmD-000ZHq-0J;
        Fri, 14 Apr 2023 06:19:17 +0000
Date:   Fri, 14 Apr 2023 14:18:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 0962c5df83b088fad0c531257744fb7a1e83221c
Message-ID: <6438f03f.hJG2K8Dso2ZlCkIN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 0962c5df83b088fad0c531257744fb7a1e83221c  Merge branch 'thermal/bleeding-edge' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux into bleeding-edge

elapsed time: 725m

configs tested: 78
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230409   gcc  
alpha        buildonly-randconfig-r004-20230410   gcc  
alpha        buildonly-randconfig-r005-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r021-20230409   gcc  
alpha                randconfig-r025-20230410   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230410   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230409   gcc  
arc                  randconfig-r033-20230410   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r006-20230410   clang
arm                                 defconfig   gcc  
arm                  randconfig-r026-20230409   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r002-20230409   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230410   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r003-20230410   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230409   gcc  
ia64                 randconfig-r023-20230410   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230409   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230410   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230410   gcc  
m68k                 randconfig-r022-20230409   gcc  
microblaze   buildonly-randconfig-r001-20230409   gcc  
microblaze           randconfig-r032-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r025-20230409   clang
mips                 randconfig-r026-20230410   clang
mips                 randconfig-r032-20230409   gcc  
mips                 randconfig-r034-20230409   gcc  
nios2                               defconfig   gcc  
openrisc     buildonly-randconfig-r004-20230409   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r022-20230410   gcc  
powerpc              randconfig-r035-20230409   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r002-20230410   gcc  
sparc                               defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r036-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
