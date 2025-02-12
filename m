Return-Path: <linux-acpi+bounces-11131-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3ECDA33092
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 21:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A3971673DF
	for <lists+linux-acpi@lfdr.de>; Wed, 12 Feb 2025 20:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999FF200138;
	Wed, 12 Feb 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ip5BuQtE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A702E271838;
	Wed, 12 Feb 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739391343; cv=none; b=fYBOh9flcUAaWrOVj7eypwsXxDHRgKQ3ukhJgsvSFA2fXfY1zFHpO67imKAMHvegCJTcck2Nh2ywVT+5WEEdxH1t55dOZQ/SGiLBCbZmAbiiDR65viEhCLQlw+hu1gUUlSt7wk5yDRo6G68jXoFfg1opKG0136cDhYv+r7go1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739391343; c=relaxed/simple;
	bh=5TWUc1TqlUGo8EItDPzOCw9PDp5Ko+1Uqiapoe4d6FY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=SceFd1ONn/HhyP6s02RNaAdqK2TqPp+TsRmVjfyfh+ciXRpEgg0OZqIj3b07HZAK6Ci31fagzmrv4ySSdzntXpaIvcru78fNmut/KWnoVcGnDUes8YlFvTQZPO9maRSvDTHqPmFLbMeIXvdAX9H8Gd8XLvJ7k4/6UsVqWtIX9Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ip5BuQtE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739391342; x=1770927342;
  h=date:from:to:cc:subject:message-id;
  bh=5TWUc1TqlUGo8EItDPzOCw9PDp5Ko+1Uqiapoe4d6FY=;
  b=ip5BuQtEuuj1Oi1RPAf6mgYLOiCfVvOReTMCIMX3/OoOxFDP+xz/J/rQ
   1NpJnBwt/C8J/syvUul69MG5hHabuGXeVlhRwIgGEzw7gAvISYBh6kN3W
   CxDcPIxiQ7mxPwhiOThdosLdF0y7IPbw/PjD6VjnR2AOOETYoXhDXCE63
   JwKJeH4OspQv/UklnlaXRp7Igp/+5xhnSHTWL4Vv3weqMeMxN3CrKwJ0q
   sd4DV1Cj1xi8WqanGPYoF69lNOG3HlW35BTMgN0cOO8NFAYZsuHHbQq3Y
   bBunDx8KtMKIGP+c1J7+G2p+/wh849Dy0p5hQeOKZMDL3Q/P/qLzjJuRc
   A==;
X-CSE-ConnectionGUID: L3b4Z6TBT1WcBLQOYCZt+w==
X-CSE-MsgGUID: 7628v0YOSG6EzZuCyfCHgw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="42908620"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="42908620"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 12:15:41 -0800
X-CSE-ConnectionGUID: lBOnTDddQCeraz1Lqar4Mg==
X-CSE-MsgGUID: 3OBcdcOhTO2+Ss6wVRvsDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="143766506"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 12 Feb 2025 12:15:38 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tiJ8y-00165d-1Q;
	Wed, 12 Feb 2025 20:15:36 +0000
Date: Thu, 13 Feb 2025 04:15:24 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 e1d9ee5852d14e91bf165fcf33d098f960edca4d
Message-ID: <202502130416.oxBtc5o8-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: e1d9ee5852d14e91bf165fcf33d098f960edca4d  Merge branch 'experimental/menu' into bleeding-edge

elapsed time: 1444m

configs tested: 78
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20250212    gcc-13.2.0
arc                  randconfig-002-20250212    gcc-13.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20250212    clang-18
arm                  randconfig-002-20250212    clang-16
arm                  randconfig-003-20250212    clang-21
arm                  randconfig-004-20250212    clang-16
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20250212    gcc-14.2.0
arm64                randconfig-002-20250212    gcc-14.2.0
arm64                randconfig-003-20250212    clang-16
arm64                randconfig-004-20250212    gcc-14.2.0
csky                 randconfig-001-20250212    gcc-14.2.0
csky                 randconfig-002-20250212    gcc-14.2.0
hexagon                         allmodconfig    clang-21
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20250212    clang-21
hexagon              randconfig-002-20250212    clang-21
i386                            allmodconfig    gcc-12
i386                             allnoconfig    gcc-12
i386                            allyesconfig    gcc-12
i386       buildonly-randconfig-001-20250212    clang-19
i386       buildonly-randconfig-002-20250212    gcc-12
i386       buildonly-randconfig-003-20250212    gcc-12
i386       buildonly-randconfig-004-20250212    gcc-12
i386       buildonly-randconfig-005-20250212    gcc-12
i386       buildonly-randconfig-006-20250212    gcc-12
i386                               defconfig    clang-19
loongarch            randconfig-001-20250212    gcc-14.2.0
loongarch            randconfig-002-20250212    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20250212    gcc-14.2.0
nios2                randconfig-002-20250212    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20250212    gcc-14.2.0
parisc               randconfig-002-20250212    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc              randconfig-001-20250212    gcc-14.2.0
powerpc              randconfig-002-20250212    clang-16
powerpc              randconfig-003-20250212    gcc-14.2.0
powerpc64            randconfig-001-20250212    clang-16
powerpc64            randconfig-002-20250212    gcc-14.2.0
powerpc64            randconfig-003-20250212    gcc-14.2.0
riscv                randconfig-001-20250212    clang-21
riscv                randconfig-002-20250212    clang-18
s390                            allmodconfig    clang-19
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20250212    clang-15
s390                 randconfig-002-20250212    clang-17
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20250212    gcc-14.2.0
sh                   randconfig-002-20250212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20250212    gcc-14.2.0
sparc                randconfig-002-20250212    gcc-14.2.0
sparc64              randconfig-001-20250212    gcc-14.2.0
sparc64              randconfig-002-20250212    gcc-14.2.0
um                              allmodconfig    clang-21
um                              allyesconfig    gcc-12
um                   randconfig-001-20250212    clang-16
um                   randconfig-002-20250212    gcc-12
x86_64                           allnoconfig    clang-19
x86_64                          allyesconfig    clang-19
x86_64     buildonly-randconfig-001-20250212    gcc-11
x86_64     buildonly-randconfig-002-20250212    clang-19
x86_64     buildonly-randconfig-003-20250212    clang-19
x86_64     buildonly-randconfig-004-20250212    clang-19
x86_64     buildonly-randconfig-005-20250212    gcc-12
x86_64     buildonly-randconfig-006-20250212    clang-19
x86_64                             defconfig    gcc-11
xtensa               randconfig-001-20250212    gcc-14.2.0
xtensa               randconfig-002-20250212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

