Return-Path: <linux-acpi+bounces-9695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DC99D3C6C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 14:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E50B220AE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Nov 2024 13:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE825158DD8;
	Wed, 20 Nov 2024 13:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8dAF5nB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFCC433B3;
	Wed, 20 Nov 2024 13:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732108566; cv=none; b=oOj8MZPAOdjB7pEFTsAINb1foVuN4yKc3Y0/GjV55Pz6n0Q01VVt0N1Ga9XVaqAvNFRMqYpc6hvmYLTHsoIxZkP3hvgleIQbsPljNld+QOTXNgzZvqrvhZtwaWPWxTVCZrRpRwMXQmTvIAQYr2ZDPCdhK5owsq4LMlhFNAf2Qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732108566; c=relaxed/simple;
	bh=HUwMob+y4W+gCTiu7k2ZYrkM0ig1T9b1rSuMzlzH8W8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=q0ovxifX09XqCvvwmPkeeabb9jGk+RVi/cMI+GCcepfw9e+sLwoldxjpY4DVss4eBnRZBE9+uNB30EnOF5GafXvIH5ocAoXVLeadD0SLsv6IyE06IKlFURVe+2f8/tsp1fjX3Izxd6lMjhZ+mnE2z9V4dLzhU4YOWLWXFv0Hprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8dAF5nB; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732108565; x=1763644565;
  h=date:from:to:cc:subject:message-id;
  bh=HUwMob+y4W+gCTiu7k2ZYrkM0ig1T9b1rSuMzlzH8W8=;
  b=a8dAF5nBMr3n+yz5V+P4BQbk5Cst/dw6Z4GyNQbEiZRvkWv9ktZM/LCC
   JFYGSxpGP8U4Z9VS6qLFdKAO4IMF6Jn3+flBNb5CL8wLZIYEvMOE0U8M8
   Q0lUr35I4UJg4vw4gjQUcF78KgTvUJvSW+o7wmrIXTzzF30N3PtfG50CH
   6NEGCTUmN+iFa8mvwVbg0rMBV5vCviEkjy6mvyLHW9o7Ue8kOoUgiPoJk
   oYiElJ4OrMSMWjaY4OmN1QcO1x7CPgKT4vpCQxRLe00gnAxy4waJ5Vdkr
   S4d6/qk+2gzyrlPt6Cec993air+nvR1IzAAe3rlVhxExy6ps77ugfaqeU
   w==;
X-CSE-ConnectionGUID: +dhWa+iLQKKlBfNdC8SGvQ==
X-CSE-MsgGUID: PnUresv4RF+EJp4s9XW09Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11262"; a="31559738"
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="31559738"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2024 05:16:04 -0800
X-CSE-ConnectionGUID: GqcTgT7oSQyRHlLhLBoAQQ==
X-CSE-MsgGUID: QDcYySZkQz2jMnLoWoD3Ig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,169,1728975600"; 
   d="scan'208";a="89904533"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 20 Nov 2024 05:13:50 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tDkWh-0000sf-1l;
	Wed, 20 Nov 2024 13:13:47 +0000
Date: Wed, 20 Nov 2024 21:12:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 4a4b4f7985c54e5859ce87cc2fd79681c8511d5a
Message-ID: <202411202140.zer1DB5Y-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 4a4b4f7985c54e5859ce87cc2fd79681c8511d5a  Merge branch 'pm-cpuidle' into bleeding-edge

elapsed time: 726m

configs tested: 94
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241120    gcc-13.2.0
arc                   randconfig-002-20241120    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20241120    clang-20
arm                   randconfig-002-20241120    clang-20
arm                   randconfig-003-20241120    gcc-14.2.0
arm                   randconfig-004-20241120    gcc-14.2.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241120    gcc-14.2.0
arm64                 randconfig-002-20241120    clang-17
arm64                 randconfig-003-20241120    gcc-14.2.0
arm64                 randconfig-004-20241120    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241120    gcc-14.2.0
csky                  randconfig-002-20241120    gcc-14.2.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241120    clang-20
hexagon               randconfig-002-20241120    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386        buildonly-randconfig-001-20241120    clang-19
i386        buildonly-randconfig-002-20241120    gcc-12
i386        buildonly-randconfig-003-20241120    gcc-12
i386        buildonly-randconfig-004-20241120    gcc-12
i386        buildonly-randconfig-005-20241120    clang-19
i386        buildonly-randconfig-006-20241120    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241120    gcc-12
i386                  randconfig-002-20241120    gcc-12
i386                  randconfig-003-20241120    gcc-12
i386                  randconfig-004-20241120    gcc-12
i386                  randconfig-005-20241120    gcc-12
i386                  randconfig-006-20241120    gcc-12
i386                  randconfig-011-20241120    clang-19
i386                  randconfig-012-20241120    clang-19
i386                  randconfig-013-20241120    clang-19
i386                  randconfig-014-20241120    gcc-11
i386                  randconfig-015-20241120    gcc-12
i386                  randconfig-016-20241120    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241120    gcc-14.2.0
loongarch             randconfig-002-20241120    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241120    gcc-14.2.0
nios2                 randconfig-002-20241120    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                randconfig-001-20241120    gcc-14.2.0
parisc                randconfig-002-20241120    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc               randconfig-001-20241120    gcc-14.2.0
powerpc               randconfig-002-20241120    gcc-14.2.0
powerpc               randconfig-003-20241120    gcc-14.2.0
powerpc64             randconfig-001-20241120    clang-20
powerpc64             randconfig-002-20241120    clang-20
powerpc64             randconfig-003-20241120    clang-20
riscv                            allmodconfig    clang-20
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20241120    gcc-14.2.0
riscv                 randconfig-002-20241120    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20241120    clang-20
s390                  randconfig-002-20241120    clang-20
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20241120    gcc-14.2.0
sh                    randconfig-002-20241120    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc64               randconfig-001-20241120    gcc-14.2.0
sparc64               randconfig-002-20241120    gcc-14.2.0
um                    randconfig-001-20241120    gcc-12
um                    randconfig-002-20241120    clang-20
x86_64                            allnoconfig    clang-19
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20241120    gcc-14.2.0
xtensa                randconfig-002-20241120    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

