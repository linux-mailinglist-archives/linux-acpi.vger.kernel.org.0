Return-Path: <linux-acpi+bounces-8722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1226899A94F
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 18:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE1D282FF3
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BE19F11B;
	Fri, 11 Oct 2024 16:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q7eTRUzD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22577F9;
	Fri, 11 Oct 2024 16:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665971; cv=none; b=Xu1d6BwpUBdyc+ZZr8HjZJUod8jKs/RAMj8CS57e80Y2yAmVr2bNJ5kfJjI4SQorSq4tmiLidYFlmFw3V2BYd5QMhcBlRTs3jmsottg59HwNY9+2D6gJgCaqRQX12Mbham+qW5MILsS9j0nD1Lyf4VwJnRnXAZ5J94/GY6Jf1IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665971; c=relaxed/simple;
	bh=0bEaUbP5pxv2hiicfcPV9gdJhdDYsTu7CZu1IuYMxF0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GNCuMkfNoDAqgmBT4uDwoNVSqlFfgWNkSYd9g1CEKV/LRMYNRSD8Q+xrw/7W/URC2ngIDw4a+3hte/ayDU7+DCCBWKDaRAwqaur32RqxqqEY9m5IubXiNMgVYm+da2Qs7MRpF3wURoJn7G09Cz2Ik6DctE/iSuaNp/aPC43Yk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q7eTRUzD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728665970; x=1760201970;
  h=date:from:to:cc:subject:message-id;
  bh=0bEaUbP5pxv2hiicfcPV9gdJhdDYsTu7CZu1IuYMxF0=;
  b=Q7eTRUzDomcyxodv949J0/SUsHEC2MubP2+Q+LtuUiivPvl0cKJT3D/2
   DDB1akV2rT80QSpjUFmz3m5G0aaVlU9NTi92XjsOOxXIpwk5205FcvpuR
   dy3ajBZb8GbRljUGDRBP6WyDQ0HnB9mN+B0DDrYHrGY1l+BnBM/zD0xvH
   LWWV2AvW2f78x67hU/zrx8F7dlJKpoGfgU903Rt2O36RU6r/Kko5A9KIf
   nfYcYtb9TO5FgWaM+lSfZ+dVZfebCLFm5mnOYTBRiGcazkHU8ilDnhE6k
   ieYfQFKh+5OE7bMZlcAB/m9AVzotBgRrEBlRsKdmmq2jVFzTrjx416oOs
   w==;
X-CSE-ConnectionGUID: a/PnXuBIQgOeyPP8aOtErQ==
X-CSE-MsgGUID: fD0MtB51RQ+NY9QbwOn19Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="27963352"
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="27963352"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 09:59:30 -0700
X-CSE-ConnectionGUID: oZjb1cOiTlitnJN5DWtw6w==
X-CSE-MsgGUID: Sh+FbtyiRNCUx6JkxuXXFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,196,1725346800"; 
   d="scan'208";a="81963334"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 11 Oct 2024 09:59:28 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szIz7-000CWX-2A;
	Fri, 11 Oct 2024 16:59:25 +0000
Date: Sat, 12 Oct 2024 00:58:27 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 9b8e59244dc48920c1a58d8185cf83550ddb68b8
Message-ID: <202410120013.SuyZF9d4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 9b8e59244dc48920c1a58d8185cf83550ddb68b8  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1129m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv           allyesconfig    gcc-14.1.0
riscv              defconfig    gcc-12
s390            allmodconfig    gcc-14.1.0
s390             allnoconfig    clang-20
s390            allyesconfig    gcc-14.1.0
s390               defconfig    gcc-12
sh              allmodconfig    gcc-14.1.0
sh               allnoconfig    gcc-14.1.0
sh              allyesconfig    gcc-14.1.0
sh                 defconfig    gcc-12
sparc           allmodconfig    gcc-14.1.0
sparc64            defconfig    gcc-12
um              allmodconfig    clang-20
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    gcc-12
x86_64              rhel-8.3    gcc-12
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

