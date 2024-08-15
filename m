Return-Path: <linux-acpi+bounces-7603-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DDF953B14
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 21:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 894D72878FA
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Aug 2024 19:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5034770E8;
	Thu, 15 Aug 2024 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU/WzmPj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A67A5A7AA;
	Thu, 15 Aug 2024 19:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723751305; cv=none; b=HFUbpNQVtkHXJD/u5qtQwvcWw7nVuNWzzBpsfhdIHIv0mhwBC9Dcw4h1NfCyVZyZgb2JaT8Wfsqv7m5gQsbxVIrQEVLzADhMAolo8spkIZqUq6qD3H9DVTtm2QmwvMgP9rh2zKrTli5rR1MdSOgqaaPEkATOlAOzpH7CunnVnOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723751305; c=relaxed/simple;
	bh=8iJyPpgabudZsjLMzlOmJoVVV08LobvdknDHyVD64L4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tWWxn9aZl8rJy/x2IT2tDC9td22SeD8g8HGnZge2wkTzw15WbQIrPgPn5BmtyEk9Q/So1NHYndNHWqV+fkr0IQwquZA1Sn7JazK+W/Y6/QAV5FT4ZURaIh4dsYVcgA85mkvAAnp3BT3yJA1WDcBhk/Eo1Iawn6DfTppd4+zkRIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JU/WzmPj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723751304; x=1755287304;
  h=date:from:to:cc:subject:message-id;
  bh=8iJyPpgabudZsjLMzlOmJoVVV08LobvdknDHyVD64L4=;
  b=JU/WzmPj5kgTo7xqc+eSGRPCuWgJ7ATsp4wuTtQBJ9ZUew9gPn4S5KWG
   ZF0UmREzhWwQdbE9c3HBq2qhy08vZoC3/X5RNWDR5yDWDGKmJU9RLV+F9
   gUn/wmiDHI6fgfa65H46FCoMTvmHvl9jeRZj1OYEenhnYdmorleGKCwjF
   2NVxXkf2uTrXqeCeFwBdZMvdk4JM//NxuFecgOcbEoV6CTp5GTKTxgSiD
   lo0GomyDYgWhbCidaoMQ+mb02JNl64azPE9uJGjI8U7f282UTRnVZR8/h
   Xzo0VR+VMlmW4ToGlyP6zV0eupUgqJITFxR1RmGGRGyauQH5CO77FPHZJ
   w==;
X-CSE-ConnectionGUID: RaSIbONWRmmB+mJBKceRYg==
X-CSE-MsgGUID: 6DrPPXLvRbSGCLFXHhK28Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11165"; a="22177110"
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="22177110"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 12:48:23 -0700
X-CSE-ConnectionGUID: +si2ofDxTm2fjIxLdnmCpg==
X-CSE-MsgGUID: WriOhaQkREGQX1Eg1chlBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,149,1719903600"; 
   d="scan'208";a="64345670"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 15 Aug 2024 12:48:21 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1segSI-0005Xe-2g;
	Thu, 15 Aug 2024 19:48:18 +0000
Date: Fri, 16 Aug 2024 03:47:19 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 952e74cd01acff951b2373c9cd27cf34e79000af
Message-ID: <202408160316.PHAigmqB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 952e74cd01acff951b2373c9cd27cf34e79000af  Merge branch 'thermal-core-testing' into bleeding-edge

elapsed time: 1459m

configs tested: 140
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240815   gcc-13.2.0
arc                   randconfig-002-20240815   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                              allyesconfig   gcc-14.1.0
arm                   randconfig-001-20240815   gcc-14.1.0
arm                   randconfig-002-20240815   clang-16
arm                   randconfig-003-20240815   gcc-14.1.0
arm                   randconfig-004-20240815   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240815   clang-16
arm64                 randconfig-002-20240815   clang-17
arm64                 randconfig-003-20240815   clang-20
arm64                 randconfig-004-20240815   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240815   gcc-14.1.0
csky                  randconfig-002-20240815   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240815   clang-20
hexagon               randconfig-002-20240815   clang-20
i386                             allmodconfig   gcc-12
i386                              allnoconfig   gcc-12
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240815   gcc-12
i386         buildonly-randconfig-002-20240815   clang-18
i386         buildonly-randconfig-003-20240815   clang-18
i386         buildonly-randconfig-004-20240815   clang-18
i386         buildonly-randconfig-005-20240815   clang-18
i386         buildonly-randconfig-006-20240815   clang-18
i386                                defconfig   clang-18
i386                  randconfig-001-20240815   gcc-12
i386                  randconfig-002-20240815   clang-18
i386                  randconfig-003-20240815   clang-18
i386                  randconfig-004-20240815   gcc-12
i386                  randconfig-005-20240815   gcc-12
i386                  randconfig-006-20240815   gcc-12
i386                  randconfig-011-20240815   clang-18
i386                  randconfig-012-20240815   clang-18
i386                  randconfig-013-20240815   gcc-12
i386                  randconfig-014-20240815   clang-18
i386                  randconfig-015-20240815   clang-18
i386                  randconfig-016-20240815   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240815   gcc-14.1.0
loongarch             randconfig-002-20240815   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240815   gcc-14.1.0
nios2                 randconfig-002-20240815   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240815   gcc-14.1.0
parisc                randconfig-002-20240815   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc               randconfig-001-20240815   gcc-14.1.0
powerpc               randconfig-002-20240815   gcc-14.1.0
powerpc64             randconfig-001-20240815   clang-20
powerpc64             randconfig-002-20240815   gcc-14.1.0
powerpc64             randconfig-003-20240815   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                 randconfig-001-20240815   gcc-14.1.0
riscv                 randconfig-002-20240815   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                  randconfig-001-20240815   clang-17
s390                  randconfig-002-20240815   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240815   gcc-14.1.0
sh                    randconfig-002-20240815   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240815   gcc-14.1.0
sparc64               randconfig-002-20240815   gcc-14.1.0
um                               allmodconfig   clang-20
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                                  defconfig   clang-20
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240815   clang-16
um                    randconfig-002-20240815   gcc-12
um                           x86_64_defconfig   clang-15
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240815   gcc-12
x86_64       buildonly-randconfig-002-20240815   gcc-11
x86_64       buildonly-randconfig-003-20240815   clang-18
x86_64       buildonly-randconfig-004-20240815   gcc-12
x86_64       buildonly-randconfig-005-20240815   gcc-12
x86_64       buildonly-randconfig-006-20240815   gcc-12
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240815   clang-18
x86_64                randconfig-002-20240815   gcc-12
x86_64                randconfig-004-20240815   gcc-12
x86_64                randconfig-005-20240815   clang-18
x86_64                randconfig-006-20240815   gcc-12
x86_64                randconfig-011-20240815   clang-18
x86_64                randconfig-012-20240815   gcc-12
x86_64                randconfig-013-20240815   gcc-12
x86_64                randconfig-014-20240815   gcc-12
x86_64                randconfig-015-20240815   gcc-12
x86_64                randconfig-016-20240815   clang-18
x86_64                randconfig-071-20240815   clang-18
x86_64                randconfig-072-20240815   gcc-12
x86_64                randconfig-073-20240815   clang-18
x86_64                randconfig-074-20240815   gcc-12
x86_64                randconfig-075-20240815   clang-18
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240815   gcc-14.1.0
xtensa                randconfig-002-20240815   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

