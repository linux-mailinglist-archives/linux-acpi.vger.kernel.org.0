Return-Path: <linux-acpi+bounces-52-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C02C7AAF85
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 12:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3AFC728112D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E01DA47
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Sep 2023 10:32:23 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E1B4416
	for <linux-acpi@vger.kernel.org>; Fri, 22 Sep 2023 08:41:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB5AE8;
	Fri, 22 Sep 2023 01:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695372095; x=1726908095;
  h=date:from:to:cc:subject:message-id;
  bh=sJWLQLh2FPCq3ZXbKOIjHJGyKcDbTKq1znkVP6NMVU4=;
  b=h+7aTtTAPABkTMJxARz+rAZWoCiXpcKHc7u2dEKBFs6NKCh0AI28OZH9
   4LJLKUy7shMSpvzUsc/6UDsP6dTX5jVrg+0/98f21unvHzuDzcPPB0c9R
   OEE9N4hNgvCukOIDN0acCbPW9vn0SX3OAiUoDqfwpGSsg3hoBr52nDuT5
   8HgVhMUqUcAHLLUBKWsN28WqhNYYb7NTQ5tSGh/tr/ZEeBvG7T9Dr1c05
   JzV7vcL0BHZFeKKUQEKHYlv6l4pnftlgqEAfPPHc5ewKP9QA+gkqJLR2g
   DjRMOmHG5KpuIKP/AgVRD5ARUvqPl0lVv6kZK/CONOdQTwd9UkD0jlO1s
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="467079316"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467079316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 01:41:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="724106901"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="724106901"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2023 01:41:33 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qjbj9-0000Ov-0u;
	Fri, 22 Sep 2023 08:41:31 +0000
Date: Fri, 22 Sep 2023 16:40:58 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 30c38047562cc1ee0ba3440e4a4ff9df136be7e1
Message-ID: <202309221655.YFCNBrjt-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 30c38047562cc1ee0ba3440e4a4ff9df136be7e1  Merge branch 'acpi-ec' into bleeding-edge

elapsed time: 744m

configs tested: 136
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230922   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230922   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-016-20230922   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230922   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230922   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230922   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230922   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-011-20230922   gcc  
x86_64                randconfig-012-20230922   gcc  
x86_64                randconfig-013-20230922   gcc  
x86_64                randconfig-014-20230922   gcc  
x86_64                randconfig-015-20230922   gcc  
x86_64                randconfig-016-20230922   gcc  
x86_64                randconfig-071-20230922   gcc  
x86_64                randconfig-072-20230922   gcc  
x86_64                randconfig-073-20230922   gcc  
x86_64                randconfig-074-20230922   gcc  
x86_64                randconfig-075-20230922   gcc  
x86_64                randconfig-076-20230922   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

