Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8C26CB904
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Mar 2023 10:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjC1ID6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 Mar 2023 04:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjC1ID5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Mar 2023 04:03:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7156112F;
        Tue, 28 Mar 2023 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679990635; x=1711526635;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=FTGwNGzijGJCqATKP+okRhp4Vfwze7JXPSmB0/lUcEU=;
  b=YCjXprhNs5K0bsrDt5qFOA12jboY/CObfJwIEMUVL+sVZdKzNE7xqOwF
   oQss+ZJFj5URjcqZRX15BgFk+Fk88nhXKq5CgZ3nCOeBQmSSLfe/8Rcfg
   ioDM+jCee6jb5lef53dEiXjomq5oKOH3lGJ2iCW++0Cy63wbdecUE9BvK
   QsrW2vtpsBGEIuFM5UC7IoZr+nkaUeOJYCXKhQ1WlP2vRVbRRAbps1Yh7
   jp785pIPXQ/TfY/k8nNqz40qqQ/Bw0L8P5awZTYkC9nFhcWxMUKDN169S
   TM36zWBjIJODfUNKGUxEhX6kAXN8slrp7GPhodUb5bIw5nFE+O6wK85rA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="342086242"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="342086242"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 01:03:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="677272803"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="677272803"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2023 01:02:55 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ph4IA-000INT-1L;
        Tue, 28 Mar 2023 08:02:54 +0000
Date:   Tue, 28 Mar 2023 16:02:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 af4c888b39b5eae0ade70aae0eb5533f5e579bfa
Message-ID: <64229f05.F9EjuTqjjdvGE3rs%lkp@intel.com>
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
branch HEAD: af4c888b39b5eae0ade70aae0eb5533f5e579bfa  Merge branch 'acpi-tables' into bleeding-edge

elapsed time: 733m

configs tested: 132
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r006-20230327   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230326   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r032-20230327   gcc  
arc                  randconfig-r043-20230326   gcc  
arc                  randconfig-r043-20230327   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r025-20230326   clang
arm                  randconfig-r046-20230326   clang
arm                  randconfig-r046-20230327   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230326   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r003-20230327   gcc  
csky                 randconfig-r013-20230327   gcc  
csky                 randconfig-r031-20230326   gcc  
hexagon              randconfig-r006-20230326   clang
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
i386                 randconfig-r014-20230327   clang
i386                 randconfig-r022-20230327   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r003-20230326   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r033-20230326   gcc  
loongarch            randconfig-r036-20230327   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r003-20230327   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r005-20230327   gcc  
microblaze   buildonly-randconfig-r002-20230327   gcc  
microblaze   buildonly-randconfig-r003-20230326   gcc  
microblaze           randconfig-r004-20230327   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2        buildonly-randconfig-r006-20230326   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230327   gcc  
nios2                randconfig-r033-20230327   gcc  
nios2                randconfig-r034-20230327   gcc  
openrisc             randconfig-r004-20230326   gcc  
parisc       buildonly-randconfig-r001-20230327   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230327   gcc  
parisc               randconfig-r005-20230326   gcc  
parisc               randconfig-r016-20230326   gcc  
parisc               randconfig-r026-20230326   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r024-20230326   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r015-20230326   gcc  
riscv                randconfig-r016-20230327   clang
riscv                randconfig-r024-20230327   clang
riscv                randconfig-r042-20230326   gcc  
riscv                randconfig-r042-20230327   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230326   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230327   clang
s390                 randconfig-r022-20230326   gcc  
s390                 randconfig-r035-20230326   clang
s390                 randconfig-r044-20230326   gcc  
s390                 randconfig-r044-20230327   clang
sh                               allmodconfig   gcc  
sparc        buildonly-randconfig-r004-20230327   gcc  
sparc        buildonly-randconfig-r005-20230326   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230327   gcc  
sparc                randconfig-r012-20230327   gcc  
sparc                randconfig-r014-20230326   gcc  
sparc                randconfig-r021-20230326   gcc  
sparc                randconfig-r025-20230327   gcc  
sparc                randconfig-r031-20230327   gcc  
sparc64              randconfig-r026-20230327   gcc  
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
x86_64               randconfig-r002-20230327   gcc  
x86_64               randconfig-r021-20230327   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r002-20230326   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
