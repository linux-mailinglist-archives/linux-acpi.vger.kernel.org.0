Return-Path: <linux-acpi+bounces-10123-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 698CA9EE698
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 13:25:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A4F164E45
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 12:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82CA212FB2;
	Thu, 12 Dec 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJXSxxVY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAAD20E339;
	Thu, 12 Dec 2024 12:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734006326; cv=none; b=HcfncyttHt5IzdL3rU9evtRBrVN5iF21cZjrAmP+ML0+T6i1KtPLS97btLiHbiROo/amJhsP+kDQ2G6FuZPkV2Xi2b1nA2RvOLSaAGT1fjPWr05y6S2RtADsTWFLPdvNkoBhjck95tMk167mcAmSl5PTIdiE8ON+JN7h8E0VhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734006326; c=relaxed/simple;
	bh=TX2+QvPqDpO+jay8TIwgEnTtFZtdEhXqRgMKYofMheY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mLbvWIJV4zcLzvc/XBgyN0gDwG80VFuWu5ror35UjSLjGIhrhZGCgOA/RWbwOgr25AvcB3rk/9xs7zFZlxuqQmqXo1hnrgYzrfVF3chI5i563dRCzyUFbDZsw+nAj+3LFFYG/XnbGVDtMNvoyZc0zB+DJT+PcLHBBlrtyPhS+3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJXSxxVY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734006324; x=1765542324;
  h=date:from:to:cc:subject:message-id;
  bh=TX2+QvPqDpO+jay8TIwgEnTtFZtdEhXqRgMKYofMheY=;
  b=AJXSxxVYUAMg62wNhtgrqW2smzgTGB+f6vF///IaFhcuWtlJ8ZnkXhK3
   NlrrBet0lPwaZRlMrZRrCPFDzq6/llm7uWku8hZ5DdZBxCcrmqq92/QnX
   +KaW/1jDWyB7uGiZkaIR29CQJY2ag6152/v1WPxhM/ZFcH/2StBbkLR/m
   YZVBD8e68lXIF8WrT05W2fSsUONipmFpvt+EjbXDy8J398kV4ifey7w6X
   pUyFAw7nhWntSZD8YouLvH2PaIKJIwvS+mzumyVzAt1LmO2w9yaU1K7hF
   C6mBy+wYoOVr/s8VeBX69qzd8KH6OpHlWmr7JE7R2YiJG3CL6F2Nw/+yH
   g==;
X-CSE-ConnectionGUID: amaiQve6QvCBYIveXpZ1hw==
X-CSE-MsgGUID: +62wPAt1QDmyz0rGC8GaKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="37264008"
X-IronPort-AV: E=Sophos;i="6.12,228,1728975600"; 
   d="scan'208";a="37264008"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 04:25:24 -0800
X-CSE-ConnectionGUID: wmVoHCABR2y1sr1rsbfd6w==
X-CSE-MsgGUID: xd9AxA+wSde1HzVzhGctxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97007914"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Dec 2024 04:25:23 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLiFs-0007pD-1G;
	Thu, 12 Dec 2024 12:25:20 +0000
Date: Thu, 12 Dec 2024 20:25:15 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 462078d3965b3550c1b4f7d01f0f80e142b55550
Message-ID: <202412122009.Oh3E0ywX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 462078d3965b3550c1b4f7d01f0f80e142b55550  Merge branch 'experimental/intel_pstate-testing' into bleeding-edge

elapsed time: 1465m

configs tested: 70
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allnoconfig    gcc-14.2.0
arc                              allnoconfig    gcc-13.2.0
arc                  randconfig-001-20241212    gcc-13.2.0
arc                  randconfig-002-20241212    gcc-13.2.0
arm                              allnoconfig    clang-17
arm                  randconfig-001-20241212    gcc-14.2.0
arm                  randconfig-002-20241212    clang-20
arm                  randconfig-003-20241212    clang-19
arm                  randconfig-004-20241212    clang-20
arm64                            allnoconfig    gcc-14.2.0
arm64                randconfig-002-20241212    clang-15
csky                             allnoconfig    gcc-14.2.0
csky                 randconfig-001-20241212    gcc-14.2.0
csky                 randconfig-002-20241212    gcc-14.2.0
hexagon              randconfig-001-20241212    clang-14
hexagon              randconfig-002-20241212    clang-16
i386       buildonly-randconfig-001-20241212    clang-19
i386       buildonly-randconfig-002-20241212    clang-19
i386       buildonly-randconfig-003-20241212    clang-19
i386       buildonly-randconfig-004-20241212    clang-19
i386       buildonly-randconfig-005-20241212    clang-19
i386       buildonly-randconfig-006-20241212    gcc-12
loongarch            randconfig-001-20241212    gcc-14.2.0
loongarch            randconfig-002-20241212    gcc-14.2.0
m68k                            allmodconfig    gcc-14.2.0
m68k                            allyesconfig    gcc-14.2.0
nios2                randconfig-001-20241212    gcc-14.2.0
nios2                randconfig-002-20241212    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20241212    gcc-14.2.0
parisc               randconfig-002-20241212    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc              randconfig-001-20241212    gcc-14.2.0
powerpc              randconfig-002-20241212    clang-20
powerpc              randconfig-003-20241212    clang-15
powerpc64            randconfig-001-20241212    clang-20
powerpc64            randconfig-002-20241212    gcc-14.2.0
powerpc64            randconfig-003-20241212    gcc-14.2.0
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241212    clang-17
riscv                randconfig-002-20241212    clang-20
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241212    clang-18
s390                 randconfig-002-20241212    clang-20
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241212    gcc-14.2.0
sh                   randconfig-002-20241212    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241212    gcc-14.2.0
sparc                randconfig-002-20241212    gcc-14.2.0
sparc64              randconfig-001-20241212    gcc-14.2.0
sparc64              randconfig-002-20241212    gcc-14.2.0
um                               allnoconfig    clang-18
um                   randconfig-001-20241212    gcc-12
um                   randconfig-002-20241212    clang-20
x86_64     buildonly-randconfig-001-20241212    clang-19
x86_64     buildonly-randconfig-002-20241212    gcc-12
x86_64     buildonly-randconfig-003-20241212    clang-19
x86_64     buildonly-randconfig-004-20241212    clang-19
x86_64     buildonly-randconfig-005-20241212    gcc-11
x86_64     buildonly-randconfig-006-20241212    clang-19
xtensa               randconfig-001-20241212    gcc-14.2.0
xtensa               randconfig-002-20241212    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

