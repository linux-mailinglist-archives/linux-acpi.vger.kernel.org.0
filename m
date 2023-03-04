Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E801D6AA95D
	for <lists+linux-acpi@lfdr.de>; Sat,  4 Mar 2023 12:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjCDL64 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 4 Mar 2023 06:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDL6z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Mar 2023 06:58:55 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704FB12BF7;
        Sat,  4 Mar 2023 03:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677931134; x=1709467134;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Ako5J9CYepDw5EwS9NbT0VXZwW1xRcZ6y7ksICdAAEc=;
  b=RFrXghSETiQX65mahoyeAaJ5tBHd9mKDs26JqiNgCDAkFREH9PZpTWS/
   9cT5BRh+tJ1wxAbUaF2GQvyzEOKt41ZnZ7CkZ4tC0izf1/lYbYpyJxC47
   BFtRl+hU+oEJMdMCVRH7YT1LmdZ4J51PG90kEs3POX9kKCQFCZc11emc7
   uU0mUg0UV5qJvSLNjpmoAjPwfsOwWrpbny6GmTsxyn8MUnNsdCMJQ6CA9
   k56MlJgHFvk1MxWu+Nxlx52+aMt1vfsaVEtybJxvXIG82uPvBALHRHRaJ
   ygtmoFQdyzl74hfMW+57toZeuuRabk3005wFpDcCXnw1O60D9oNLF66Yk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="323558299"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="323558299"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2023 03:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="744528169"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="744528169"
Received: from lkp-server01.sh.intel.com (HELO 776573491cc5) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2023 03:58:52 -0800
Received: from kbuild by 776573491cc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pYQXL-00027w-1Y;
        Sat, 04 Mar 2023 11:58:51 +0000
Date:   Sat, 04 Mar 2023 19:57:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, devel@acpica.org,
        linux-acpi@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 1362ac91d50346341026f84ff352f4b5504d07f9
Message-ID: <64033241.LbK0oUX3IXw8/o21%lkp@intel.com>
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
branch HEAD: 1362ac91d50346341026f84ff352f4b5504d07f9  Merge branch 'thermal-core' into bleeding-edge

elapsed time: 962m

configs tested: 110
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230302   gcc  
alpha        buildonly-randconfig-r006-20230302   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230302   gcc  
alpha                randconfig-r015-20230303   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r043-20230302   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r001-20230302   clang
arm                  randconfig-r013-20230303   clang
arm                  randconfig-r036-20230302   clang
arm                  randconfig-r046-20230302   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r021-20230302   clang
csky                                defconfig   gcc  
csky                 randconfig-r014-20230302   gcc  
hexagon              randconfig-r041-20230302   clang
hexagon              randconfig-r045-20230302   clang
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r004-20230302   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r023-20230302   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r016-20230303   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r011-20230303   gcc  
m68k                 randconfig-r016-20230302   gcc  
microblaze           randconfig-r032-20230302   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r034-20230302   gcc  
openrisc     buildonly-randconfig-r001-20230302   gcc  
openrisc             randconfig-r012-20230302   gcc  
openrisc             randconfig-r013-20230302   gcc  
openrisc             randconfig-r014-20230303   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r004-20230302   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r005-20230302   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r002-20230302   gcc  
riscv                randconfig-r022-20230302   clang
riscv                randconfig-r042-20230302   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r024-20230302   clang
s390                 randconfig-r031-20230302   gcc  
s390                 randconfig-r044-20230302   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r035-20230302   gcc  
sparc        buildonly-randconfig-r002-20230302   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230302   gcc  
sparc                randconfig-r011-20230302   gcc  
sparc                randconfig-r025-20230302   gcc  
sparc64              randconfig-r005-20230302   gcc  
sparc64              randconfig-r033-20230302   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
