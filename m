Return-Path: <linux-acpi+bounces-10695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D250A12DA4
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 22:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72712165362
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Jan 2025 21:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7481DA11B;
	Wed, 15 Jan 2025 21:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mC1O4zFy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006894D599;
	Wed, 15 Jan 2025 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976199; cv=none; b=PaiqhchN9LyBAMt/xudD12G+J9ElByN7sbTtJuwTvro7JLxyLBlD4YwO6shGesz+Go6qV/589VXsoquc5URdXKOgb7Tf7BupbWAXN1NjQw7u8FuyAJg5w05EUFhGvWlN9kFu+R0HfQwtXHFIzL3bwIjWbuvelgbNigHN1qf9pM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976199; c=relaxed/simple;
	bh=buQ6yhU4umw32VgNSvpomDQoppikaE+rCZLX3s5iooY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B+yZMbXzwW+lM84bSq4S4tLXf546xfKLIPFXEb6W4lOqWn006nRGIvTOK1kJSAscoWCjoQNmpL6yumKYrpmuqW3z0bIM5/nDYMLvtf2hDbE6HlhC2N/K2rxw8vyFIuqbIjKml4pYmxG+qxhJvyLc70AsGVmuqA0ahXzpNClLy7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mC1O4zFy; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736976198; x=1768512198;
  h=date:from:to:cc:subject:message-id;
  bh=buQ6yhU4umw32VgNSvpomDQoppikaE+rCZLX3s5iooY=;
  b=mC1O4zFysenZ2pNs76buN0TcMvV2Zt7l1yiGepobRYe1FKCB3fquRJwe
   Ggp4R+zntCadwnfkhEXPuVBoAwrxrAIPfuXHdIb49cQIpmDjYAm6g1Vfq
   rOofBrdFKevSOliEv9YhgsCnBH4izMw5B//tLoKfBVvJwIP+W1xuiTduL
   QLMP03z56lBM73Ak9X4PUsyun/kj0BsOAihf5gzPFzXPuhEo3lZsjppsU
   rnYsOY5LpqlZbObfj+zpETTI2O1D0k/huYcAcw2Rabpt39jsrv63CLYmS
   QODtpTlmimirfpG+s62Gl6K27EuUCK7ugu+dp7inbI+dccVyhj4zOUZh4
   Q==;
X-CSE-ConnectionGUID: 8FMbcslQQWewf0Ys6DPFuw==
X-CSE-MsgGUID: 6g++hlNkTQWKM/4Omm4ynw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48726125"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="48726125"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 13:23:18 -0800
X-CSE-ConnectionGUID: CqXOZdNYSYy38gi6Q7ZeIg==
X-CSE-MsgGUID: mhTRMZ6aTne6NuQprt4tTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="136110455"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 15 Jan 2025 13:23:16 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYAr4-000QuV-0j;
	Wed, 15 Jan 2025 21:23:14 +0000
Date: Thu, 16 Jan 2025 05:22:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 bba4f2ac76f605f6f8b62c5dae11103ceb20ad60
Message-ID: <202501160545.aaMR9yed-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: bba4f2ac76f605f6f8b62c5dae11103ceb20ad60  Merge branch 'pm-sleep' into bleeding-edge

elapsed time: 1454m

configs tested: 62
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
arc                  randconfig-001-20250115    gcc-13.2.0
arc                  randconfig-002-20250115    gcc-13.2.0
arm                  randconfig-001-20250115    clang-16
arm                  randconfig-002-20250115    clang-20
arm                  randconfig-003-20250115    clang-20
arm                  randconfig-004-20250115    clang-20
arm64                randconfig-001-20250115    clang-20
arm64                randconfig-002-20250115    gcc-14.2.0
arm64                randconfig-003-20250115    clang-18
arm64                randconfig-004-20250115    gcc-14.2.0
csky                 randconfig-001-20250115    gcc-14.2.0
csky                 randconfig-002-20250115    gcc-14.2.0
hexagon              randconfig-001-20250115    clang-20
hexagon              randconfig-002-20250115    clang-19
i386       buildonly-randconfig-001-20250115    clang-19
i386       buildonly-randconfig-002-20250115    gcc-12
i386       buildonly-randconfig-003-20250115    gcc-12
i386       buildonly-randconfig-004-20250115    gcc-12
i386       buildonly-randconfig-005-20250115    gcc-12
i386       buildonly-randconfig-006-20250115    gcc-12
loongarch            randconfig-001-20250115    gcc-14.2.0
loongarch            randconfig-002-20250115    gcc-14.2.0
nios2                randconfig-001-20250115    gcc-14.2.0
nios2                randconfig-002-20250115    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc               randconfig-001-20250115    gcc-14.2.0
parisc               randconfig-002-20250115    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20250115    gcc-14.2.0
powerpc              randconfig-002-20250115    gcc-14.2.0
powerpc              randconfig-003-20250115    gcc-14.2.0
powerpc64            randconfig-001-20250115    gcc-14.2.0
powerpc64            randconfig-002-20250115    gcc-14.2.0
powerpc64            randconfig-003-20250115    clang-18
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20250115    gcc-14.2.0
riscv                randconfig-002-20250115    clang-16
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250115    clang-20
s390                 randconfig-002-20250115    clang-15
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250115    gcc-14.2.0
sh                   randconfig-002-20250115    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250115    gcc-14.2.0
sparc                randconfig-002-20250115    gcc-14.2.0
sparc64              randconfig-001-20250115    gcc-14.2.0
sparc64              randconfig-002-20250115    gcc-14.2.0
um                   randconfig-001-20250115    clang-18
um                   randconfig-002-20250115    gcc-12
x86_64                           allnoconfig    clang-19
x86_64     buildonly-randconfig-001-20250115    gcc-12
x86_64     buildonly-randconfig-002-20250115    gcc-12
x86_64     buildonly-randconfig-003-20250115    clang-19
x86_64     buildonly-randconfig-004-20250115    clang-19
x86_64     buildonly-randconfig-005-20250115    gcc-12
x86_64     buildonly-randconfig-006-20250115    clang-19
xtensa               randconfig-001-20250115    gcc-14.2.0
xtensa               randconfig-002-20250115    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

