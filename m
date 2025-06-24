Return-Path: <linux-acpi+bounces-14576-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AEBAE7122
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4866518977F6
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98502E62A1;
	Tue, 24 Jun 2025 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VzqKWyne"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71903074B5;
	Tue, 24 Jun 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798629; cv=none; b=m2QIeKPIpH6MWetGb9fHKf8+aLR65iQPhK4Jjj2agTGDRFUGn13NinEKLKVQKq455VUStp1qRaR0/QnwO8Kh9S++RSbvHaooISf4MwOrBfdBQYl0O9dlw7YkUoyS4NiysxyiSpDL2fXk8nX75pH2QAL1CG4vhS3TBrW9mPZ5u9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798629; c=relaxed/simple;
	bh=NVRbdWPgjAjB+vKGBYs4kIWx7AC0RFWpkJbxUYfBLbE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=CWMIFdj067C2iRyZNKC8Zzn6evdo0ED3lyj4zJC8iVZ+qcSvTzwBuFeHkVz6BRM2TY8cVaVKFmCmeDkOW2rOswho8S9EwK7f9ERVA0+Qrh/YU5/KNT1iniJGvwexZzzPZpBqZk1X3xvPfVVbkAZqFOjnJCdhB1DVOr3VkfQUEtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VzqKWyne; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750798628; x=1782334628;
  h=date:from:to:cc:subject:message-id;
  bh=NVRbdWPgjAjB+vKGBYs4kIWx7AC0RFWpkJbxUYfBLbE=;
  b=VzqKWynea4fbSs4SkmO8vYFDS1OsnUfi7YkW8HNddmFWbvONGxHI6K7H
   qtQHZ2xEZ0bixxaZWjiiwaicV/OTaGyQiKzi4dmyimFDwEq1wIier/Z9I
   J6zBDtXR7L607RhjndRshbo/UKpa7W7Ar/AeQqgZx5TtvXBT02sN2qQEF
   q3dTymcYF/DNzELksq1UW+UT4cpvcwd78vB84wM6CKzTVZRtQyo2LMgfS
   2RKsbxI3u3PwUGC3XYNMNaFhirK+YvT4oU1P2B329M80tQQwnw0Gr58Ep
   JPNTGNY3DwoDcM0SzGeDVgeE0VXBNL3/ptrIJKEnVES2SlyScU3JVqzl/
   Q==;
X-CSE-ConnectionGUID: XTz1OGsHR5egyV9xaBMMRA==
X-CSE-MsgGUID: Ilp331OOTVKsCiFK3wzZiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64111906"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64111906"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 13:57:07 -0700
X-CSE-ConnectionGUID: 33IbqZZTQXifKCetQRcrzw==
X-CSE-MsgGUID: rddQ6VJ4R0CK5zFHlHibRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="156307668"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 24 Jun 2025 13:57:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUAhT-000SVi-2k;
	Tue, 24 Jun 2025 20:57:03 +0000
Date: Wed, 25 Jun 2025 04:56:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:fixes] BUILD SUCCESS
 3516b6fb15377f4c3bc8c6d422e96cc1fcf4267a
Message-ID: <202506250459.BHohnwZE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git fixes
branch HEAD: 3516b6fb15377f4c3bc8c6d422e96cc1fcf4267a  Merge branch 'acpi-pci' into fixes

elapsed time: 1455m

configs tested: 53
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250624    gcc-12.4.0
arc                   randconfig-002-20250624    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                   randconfig-001-20250624    gcc-13.3.0
arm                   randconfig-002-20250624    gcc-8.5.0
arm                   randconfig-003-20250624    gcc-12.4.0
arm                   randconfig-004-20250624    clang-17
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250624    clang-21
arm64                 randconfig-002-20250624    gcc-10.5.0
arm64                 randconfig-003-20250624    clang-21
arm64                 randconfig-004-20250624    clang-21
csky                              allnoconfig    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
i386        buildonly-randconfig-001-20250624    clang-20
i386        buildonly-randconfig-002-20250624    gcc-12
i386        buildonly-randconfig-003-20250624    clang-20
i386        buildonly-randconfig-004-20250624    clang-20
i386        buildonly-randconfig-005-20250624    clang-20
i386        buildonly-randconfig-006-20250624    gcc-12
loongarch                         allnoconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250624    clang-20
x86_64      buildonly-randconfig-002-20250624    gcc-12
x86_64      buildonly-randconfig-003-20250624    clang-20
x86_64      buildonly-randconfig-004-20250624    clang-20
x86_64      buildonly-randconfig-005-20250624    clang-20
x86_64      buildonly-randconfig-006-20250624    gcc-12
xtensa                            allnoconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

