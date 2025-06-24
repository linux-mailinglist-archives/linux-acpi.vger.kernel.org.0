Return-Path: <linux-acpi+bounces-14575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 372D9AE711F
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 22:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B182A1794E9
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 20:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794322E6112;
	Tue, 24 Jun 2025 20:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lEwiR0ix"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD4A2512C8;
	Tue, 24 Jun 2025 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750798569; cv=none; b=lqmUJNCvPR1cBSNIFo2cvyqRp0WhaMsgT3Jo1X1igrP6awC8WhLOtZ+OvsAqea62E6tkX9qGESVC/8ocoYeqY4Xhi9+fg+HKQtf37qGJJ4iUqWC000BZ10eGG/e6m0vvWv8hg9vym7FJSeBbmoFnsiGjBUenh7USZv950RK4wLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750798569; c=relaxed/simple;
	bh=d64+DaWb+tdPST9nu/yS3Xo2gDHDw/JM2uwUbEEhyl8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PNI4pJ/eW4D2Upz2aLOhaROYpN3kqteoWW7H/7+YejQgpIGaormNQAHoBDv7AcAcyiHDnWI3SIK1nhE+/ThwmEkq6Hh6tPY9zrj5Fw0UJqsrzS76q4QHOkgtYpC5VRb5fLuL7jqihyq0d3sekGz0V0obEMdAZqX8hKQBrtwroK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lEwiR0ix; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750798568; x=1782334568;
  h=date:from:to:cc:subject:message-id;
  bh=d64+DaWb+tdPST9nu/yS3Xo2gDHDw/JM2uwUbEEhyl8=;
  b=lEwiR0ixmQikeG5cCePi6+0C0myA1G93HcMoVSNscrnSjwUENAv3MU9N
   3v7YPRusGWfjMR1CKUEsH2KPGS5IimLHGpnsoN/VB2fFAjYd43UAxGUIl
   KiRFDcbE0QQCHxlRDim4kd18f7iluTZT4LcPh9LD3NS7AWETWPuRAw+Qa
   djg1TTwlzPFbHfFRwcYSYU2k70GNN/ki5/FIbIN/9mbVkMfSTLXlELmF4
   3X6G91Mc5qQxiHCs+eVkLJFOBe3W1kgZRXPa5vkreO2ci0eF2EpDHx7i8
   BoGDonjhgbTv4YMwN5NG7TNzq3r0ZLh3sijy+HI50/MPgPXmrpw4CpXe7
   A==;
X-CSE-ConnectionGUID: J1WDfIcIT/Ov0BRx65dlkw==
X-CSE-MsgGUID: AR+mmRl0SIKQHnXjj69TNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="64487854"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="64487854"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 13:56:07 -0700
X-CSE-ConnectionGUID: T5rMI44QQL2tVqCk7vFUxg==
X-CSE-MsgGUID: o4hlWKvHTJ+dvgMwgaIqjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; 
   d="scan'208";a="189213061"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Jun 2025 13:56:06 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUAgV-000SVc-2S;
	Tue, 24 Jun 2025 20:56:03 +0000
Date: Wed, 25 Jun 2025 04:55:21 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 214e5f60b0342a6bea4a3e761883c3f154b31bd9
Message-ID: <202506250411.rAhN6hM3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 214e5f60b0342a6bea4a3e761883c3f154b31bd9  Merge branch 'pm-sleep-testing' into bleeding-edge

elapsed time: 1454m

configs tested: 52
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

