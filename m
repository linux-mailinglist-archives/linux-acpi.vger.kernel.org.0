Return-Path: <linux-acpi+bounces-19920-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3144ACECCEA
	for <lists+linux-acpi@lfdr.de>; Thu, 01 Jan 2026 05:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3FED300797D
	for <lists+linux-acpi@lfdr.de>; Thu,  1 Jan 2026 04:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D021F5847;
	Thu,  1 Jan 2026 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bu7/NQ1R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47820134CF;
	Thu,  1 Jan 2026 04:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767242249; cv=none; b=H1YGFf8hAmo0iIXoSv04pb/pGyaDn6/vOCP6l/DFM8He4CST+QJHe79P1w4CFYe3ryVKNbV0nFGonVxwxoj6jtsnz1AKOtZcQnJb9MsqeOfTU5i630exYHUiboM29xDFKtstFVqWBddFtUOIo9Kleb5X3cY/aN9iBSVQ9ELPyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767242249; c=relaxed/simple;
	bh=snTPhWk/qdI/kankL3vZaNzcJgGI4jbD8ndWapClGB8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WTQ99kn5d7UAwN/JXsMfM15NUoYEIw9LVFANuqMMSPZv8GSgJxd78L4AHvw96G7Cwzv/9zaBTIYC2NCIIPKPRqppL39lfyLB/SoFzglCF6xDpTwBJxEYoWKKAaCnPsAYQbV6w3Z/7sa27zaKP5+0O1U74vzDMih3lmJEpw8XjI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bu7/NQ1R; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767242248; x=1798778248;
  h=date:from:to:cc:subject:message-id;
  bh=snTPhWk/qdI/kankL3vZaNzcJgGI4jbD8ndWapClGB8=;
  b=bu7/NQ1RKGH+taeBeIgPwpmUzBlZouVsxOqV72LKNahbtasIlKaEFpzD
   pZEdeGFT/emQ/b4QhQ0m1Abr4QjPnHXp99L0wELgZ9MuDXhgu+zKxePG4
   oPxXAndrUaUWu/C8PmAhqpZ1lQp4wTjohouqFKYd/6DLkkvcIcPtylRv1
   uYHKxRn18zqP/mTh9ohTwSUHM7pwa5gIpOGDC18zrlb9DdPAcL5iHVJjS
   6e1hrSEGWVJLWfpELQog73fOKzWUmBE3E2HDcq34cW1KotNqfwOrVxlwl
   kEGtO40sUCJ9Rr1OEY7BVqJhNtblsGn2MJuXm3GbAfRx7haoTdS3mvp5Y
   A==;
X-CSE-ConnectionGUID: ZKBhVaw6Q6OEWa3zljqIcg==
X-CSE-MsgGUID: mfLQNRHPQzWaULiejZCruw==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68688409"
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="68688409"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 20:37:27 -0800
X-CSE-ConnectionGUID: 1UVJIKhASf+caHDUgF/61Q==
X-CSE-MsgGUID: OzLI1Xn5SiuatvZ/ZdFx0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,193,1763452800"; 
   d="scan'208";a="206089765"
Received: from lkp-server01.sh.intel.com (HELO c9aa31daaa89) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 31 Dec 2025 20:37:27 -0800
Received: from kbuild by c9aa31daaa89 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vbARA-000000001gB-0hKZ;
	Thu, 01 Jan 2026 04:37:24 +0000
Date: Thu, 01 Jan 2026 12:36:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 8f58d533a8d8a3cc00a9a33cb24fc3f2d12bb59b
Message-ID: <202601011247.LYJTlWzP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 8f58d533a8d8a3cc00a9a33cb24fc3f2d12bb59b  Merge branch 'pm-runtime-cleanup' into bleeding-edge

elapsed time: 989m

configs tested: 55
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha         allnoconfig    gcc-15.1.0
alpha        allyesconfig    gcc-15.1.0
arc          allmodconfig    gcc-15.1.0
arc           allnoconfig    gcc-15.1.0
arc          allyesconfig    gcc-15.1.0
arm           allnoconfig    clang-22
arm          allyesconfig    gcc-15.1.0
arm64        allmodconfig    clang-19
arm64         allnoconfig    gcc-15.1.0
csky         allmodconfig    gcc-15.1.0
csky          allnoconfig    gcc-15.1.0
hexagon      allmodconfig    clang-17
hexagon       allnoconfig    clang-22
i386         allmodconfig    gcc-14
i386          allnoconfig    gcc-14
i386         allyesconfig    gcc-14
loongarch    allmodconfig    clang-19
loongarch     allnoconfig    clang-22
m68k         allmodconfig    gcc-15.1.0
m68k          allnoconfig    gcc-15.1.0
m68k         allyesconfig    gcc-15.1.0
microblaze    allnoconfig    gcc-15.1.0
microblaze   allyesconfig    gcc-15.1.0
mips         allmodconfig    gcc-15.1.0
mips          allnoconfig    gcc-15.1.0
mips         allyesconfig    gcc-15.1.0
nios2        allmodconfig    gcc-11.5.0
nios2         allnoconfig    gcc-11.5.0
openrisc     allmodconfig    gcc-15.1.0
openrisc      allnoconfig    gcc-15.1.0
parisc       allmodconfig    gcc-15.1.0
parisc        allnoconfig    gcc-15.1.0
parisc       allyesconfig    gcc-15.1.0
powerpc      allmodconfig    gcc-15.1.0
powerpc       allnoconfig    gcc-15.1.0
riscv        allmodconfig    clang-22
riscv         allnoconfig    gcc-15.1.0
riscv        allyesconfig    clang-16
s390         allmodconfig    clang-18
s390          allnoconfig    clang-22
s390         allyesconfig    gcc-15.1.0
sh           allmodconfig    gcc-15.1.0
sh            allnoconfig    gcc-15.1.0
sh           allyesconfig    gcc-15.1.0
sparc         allnoconfig    gcc-15.1.0
sparc64      allmodconfig    clang-22
um           allmodconfig    clang-19
um            allnoconfig    clang-22
um           allyesconfig    gcc-14
x86_64       allmodconfig    clang-20
x86_64        allnoconfig    clang-20
x86_64       allyesconfig    clang-20
x86_64      rhel-9.4-rust    clang-20
xtensa        allnoconfig    gcc-15.1.0
xtensa       allyesconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

