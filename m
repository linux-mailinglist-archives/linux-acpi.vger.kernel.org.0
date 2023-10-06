Return-Path: <linux-acpi+bounces-460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3F37BBA55
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925B62822A9
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0419472
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Oct 2023 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHs3BHjT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970BDC157
	for <linux-acpi@vger.kernel.org>; Fri,  6 Oct 2023 12:40:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5D1C6;
	Fri,  6 Oct 2023 05:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696596031; x=1728132031;
  h=date:from:to:cc:subject:message-id;
  bh=6jZLY4X7c35eZmWOM3DcspNKv5MPPxqbmNjH+W3XY6I=;
  b=XHs3BHjTUpUC6wrfxAxXuG6hS0j75LFn2arknKpLrKcGyFKQnGOqbl00
   q6WaCk35HBhFYiVZ6Ix6JS49W7L3Vh2nbBqJbfmyQ2cPBWswZp09N8Pz+
   XLvqjPyxDf40Qt/KBbPI5xD3K483kIZMkvLMwddemuUocojry3Ar3vn2x
   mRNVUGRogixZrLaZJlcfuVJorc1fggM59+pFiRTcyvDo6k7Fl/5jJx2k4
   ZKIVtHRuqnn21OqxPZ6CFM+91O9NqscF+HSbzjJEDEcTRwgQVzv/Ztyrz
   W8++xZTEEIctDnMT+Kr7pU5FHNetOXFefb/pahfPUsVoBS33G1M3KY0RQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470010674"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470010674"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 05:40:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="868330182"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="868330182"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 06 Oct 2023 05:40:29 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qok83-00005L-0E;
	Fri, 06 Oct 2023 12:40:27 +0000
Date: Fri, 06 Oct 2023 20:39:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS WITH WARNING
 ef7625d78dd079600f642d5875c08e059b002b52
Message-ID: <202310062051.w2AF7pu6-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: ef7625d78dd079600f642d5875c08e059b002b52  Merge branch 'thermal-core-next' into bleeding-edge

Warning reports:

https://lore.kernel.org/oe-kbuild-all/202310060618.FJ4z229a-lkp@intel.com

Warning: (recently discovered and may have been fixed)

drivers/thermal/gov_power_allocator.c:127:13: warning: unused variable 'ret' [-Wunused-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm64-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- arm64-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- arm64-defconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- i386-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- i386-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- mips-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- mips-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- powerpc-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- powerpc-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- riscv-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- riscv-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- sparc-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- sparc-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- sparc64-allmodconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
|-- sparc64-allyesconfig
|   `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret
`-- x86_64-allyesconfig
    `-- drivers-thermal-gov_power_allocator.c:warning:unused-variable-ret

elapsed time: 1013m

configs tested: 118
configs skipped: 2

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231006   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                          moxart_defconfig   clang
arm                        multi_v5_defconfig   clang
arm                         nhk8815_defconfig   gcc  
arm                   randconfig-001-20231006   gcc  
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
i386         buildonly-randconfig-001-20231006   gcc  
i386         buildonly-randconfig-002-20231006   gcc  
i386         buildonly-randconfig-003-20231006   gcc  
i386         buildonly-randconfig-004-20231006   gcc  
i386         buildonly-randconfig-005-20231006   gcc  
i386         buildonly-randconfig-006-20231006   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231006   gcc  
i386                  randconfig-002-20231006   gcc  
i386                  randconfig-003-20231006   gcc  
i386                  randconfig-004-20231006   gcc  
i386                  randconfig-005-20231006   gcc  
i386                  randconfig-006-20231006   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231006   gcc  
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
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                    mvme5100_defconfig   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231006   gcc  
x86_64                randconfig-002-20231006   gcc  
x86_64                randconfig-003-20231006   gcc  
x86_64                randconfig-004-20231006   gcc  
x86_64                randconfig-005-20231006   gcc  
x86_64                randconfig-006-20231006   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

