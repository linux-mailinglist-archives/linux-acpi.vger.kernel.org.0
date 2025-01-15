Return-Path: <linux-acpi+bounces-10696-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9FDA12DA7
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CAA416501D
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F301DA11B;
	Wed, 15 Jan 2025 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOsN1ZFp"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64064D599;
	Wed, 15 Jan 2025 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976321; cv=none; b=E5Dwge+NsN2hpX01upR9zu/GACVTEOMLHf6RbKHLMt73vqFzXyu4u+57xAQsvv1qdnab4vSTm0k9jMTuN7xCY1JTkfH3XlynVmUeIZvr6HY0F2/UZ2hX+M0U0zwDklFSfOOOmLKa/Y63+C5+l5H7MP+PQHJzG+wj1rVc+XHGGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976321; c=relaxed/simple;
	bh=m9nJQqERMKg5m3Pxsql/wxZ+KZl851quFKfjIZ4MJ6U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FSE/MqZI4liwG/DgWHfxEaWv5r5nwbeeObVl1Xp0oDC1aJtsbR60Gb4w1oYRTgticDpRnRlHQJ8arud1czU6fNSnU5++Mzo43KcKXIj0f5zBsD6lgK2W1+FJxqIWkmZ40jM+o0WpkbBSUT/FlPgQsiZZ5GH53tGj/TjreRu+or0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOsN1ZFp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736976319; x=1768512319;
  h=date:from:to:cc:subject:message-id;
  bh=m9nJQqERMKg5m3Pxsql/wxZ+KZl851quFKfjIZ4MJ6U=;
  b=ZOsN1ZFph1FxXsIl5Ks4ps+dzhuohWKpCbxIIXrXCoz9zTVOr079pmo2
   /6Wb8fS3hUShMXjJFVOUZQvmBc20kG3K2/5ZNVBmXVYje2PT6ueQIsVbd
   VzoK0KlcUn5rN8P+SDoTMfT84qAdwBQ9j6/cDNvbgN1rS81ik7/tfRqmN
   CsqGlX9sHcZDBR3c2gox1DufcabV2y865ogAn0HpCOFIxrMgDPPaPWf4H
   GJ7YNONJ4eFeGj31b5+AJesVsWxGp/povQJOsOClMfoNWwXPRKQd1DKhp
   t+zaFD/f0Ozi6C7GNfE+sFlJGQz4EW5At2SGwxpl0qFurXW1CFX6IIkxN
   w==;
X-CSE-ConnectionGUID: 2h6q5UZzRTS1Cz99Xz2P0g==
X-CSE-MsgGUID: Z3dReZcfSyKcEgGqNkiBNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="41097749"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="41097749"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 13:25:18 -0800
X-CSE-ConnectionGUID: XWprjLp4TeGGSMOeo95HDg==
X-CSE-MsgGUID: 9tLW6O+4T0OhiGfF8dpoag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128530632"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 15 Jan 2025 13:25:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYAt0-000Quu-1p;
	Wed, 15 Jan 2025 21:25:14 +0000
Date: Thu, 16 Jan 2025 05:24:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 e2046b72e9797df8569a79b839b6bfaedd6377fe
Message-ID: <202501160522.9WTK2Qg3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: e2046b72e9797df8569a79b839b6bfaedd6377fe  Merge branch 'pm-cpufreq-fixes' into fixes

elapsed time: 1455m

configs tested: 64
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                   randconfig-001-20250115    gcc-13.2.0
arm                               allnoconfig    clang-17
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-002-20250115    gcc-14.2.0
csky                  randconfig-001-20250115    gcc-14.2.0
csky                  randconfig-002-20250115    gcc-14.2.0
hexagon               randconfig-001-20250115    clang-20
hexagon               randconfig-002-20250115    clang-19
i386        buildonly-randconfig-001-20250115    clang-19
i386        buildonly-randconfig-002-20250115    gcc-12
i386        buildonly-randconfig-003-20250115    gcc-12
i386        buildonly-randconfig-004-20250115    gcc-12
i386        buildonly-randconfig-005-20250115    gcc-12
i386        buildonly-randconfig-006-20250115    gcc-12
loongarch             randconfig-001-20250115    gcc-14.2.0
loongarch             randconfig-002-20250115    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250115    gcc-14.2.0
nios2                 randconfig-002-20250115    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250115    gcc-14.2.0
parisc                randconfig-002-20250115    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250115    gcc-14.2.0
powerpc               randconfig-002-20250115    gcc-14.2.0
powerpc               randconfig-003-20250115    gcc-14.2.0
powerpc64             randconfig-001-20250115    gcc-14.2.0
powerpc64             randconfig-002-20250115    gcc-14.2.0
powerpc64             randconfig-003-20250115    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250115    gcc-14.2.0
riscv                 randconfig-002-20250115    clang-16
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250115    clang-20
s390                  randconfig-002-20250115    clang-15
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250115    gcc-14.2.0
sh                    randconfig-002-20250115    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250115    gcc-14.2.0
sparc                 randconfig-002-20250115    gcc-14.2.0
sparc64               randconfig-001-20250115    gcc-14.2.0
sparc64               randconfig-002-20250115    gcc-14.2.0
um                                allnoconfig    clang-18
um                    randconfig-001-20250115    clang-18
um                    randconfig-002-20250115    gcc-12
x86_64                            allnoconfig    clang-19
x86_64      buildonly-randconfig-001-20250115    gcc-12
x86_64      buildonly-randconfig-002-20250115    gcc-12
x86_64      buildonly-randconfig-006-20250115    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250115    gcc-14.2.0
xtensa                randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

