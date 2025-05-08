Return-Path: <linux-acpi+bounces-13642-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F18AAFD88
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 16:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA257BEB96
	for <lists+linux-acpi@lfdr.de>; Thu,  8 May 2025 14:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EA91275116;
	Thu,  8 May 2025 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBlbgbQr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4B626FA52;
	Thu,  8 May 2025 14:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715333; cv=none; b=YsoLJih8m1QHzGwwQmO+4eR4qRRLQCn/fUU1EdAWMTaCDAWvRly0/+bs62hkV92y6nf8vBKpf41ktHsa1fUVQzmfBR6gkUxGVOkVQyJKuXNs8HcdjCs2/2imNA4AqW94EW+waMUrT9JZ9G5XEIj1blb9hPL5VI+0x6Pvad78cU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715333; c=relaxed/simple;
	bh=8zV6u8tx07CqcHqmDmKrAtlHNIv/lQZc4E1pyw9imxY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mg7iaQwZI2UZGKAFuJyZeOnXy8woPn2p9xnFPFQRI9MZ/64dpPjY+osVyTqQmnl4tvv0jsYGz9IftRMb3EjoVKrCSJza5hya7Y3eOCMctIwIfh/erMYuqZZhbEatJxls/T/Z1EU2P0DUaOkwin6c+C4qMtKntIwilh+4x1Ug0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBlbgbQr; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746715331; x=1778251331;
  h=date:from:to:cc:subject:message-id;
  bh=8zV6u8tx07CqcHqmDmKrAtlHNIv/lQZc4E1pyw9imxY=;
  b=BBlbgbQryvxCPXW+MPv6ffE3PfNzQ4682y+gjz4fES6KdSGygWJiR2zb
   lRvBeCvhoYBHvwFG2wK/9ivhQYSHqV4Oa/LtOny8Ur1g9LcmPp1OChewk
   8pBNz2wnmGyiED8lGa0rOpci8/5NYQD0A5lh6eRFGzqJaCZSkW7b0ULWT
   jP66Av/Zjc/+4LrvfwadmbU8GGsXXCld2NJtRulQslv1pJyRI/7LTMB0Y
   t89TmTqSdMb6Yo8b1EJamhjFKcB3traZwDeJDrgp8xgHCz9gaQgjkChEJ
   NRbMtGVr8/dl4EfQ+G4n2YDIzVPIx8MHPL5/NxTLvlg5ltlRz1rUgSCTK
   w==;
X-CSE-ConnectionGUID: Bhl6ZFLUQDi2YJ+fFKKObQ==
X-CSE-MsgGUID: flcnDz45Qeesv9XdGcC9zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48370731"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="48370731"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 07:42:09 -0700
X-CSE-ConnectionGUID: E8dgZIx7RF+dVU8qnKh9OQ==
X-CSE-MsgGUID: OH363qekQ0q+NR4M979XPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167260732"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 08 May 2025 07:42:08 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uD2Rp-000B44-2b;
	Thu, 08 May 2025 14:42:05 +0000
Date: Thu, 08 May 2025 22:41:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 60952b6fc7ad90c84cc9b02f0ffa67c39ea5250b
Message-ID: <202505082214.c1qS551x-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 60952b6fc7ad90c84cc9b02f0ffa67c39ea5250b  Merge branch 'acpi-tables' into bleeding-edge

elapsed time: 1072m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha          allnoconfig    gcc-14.2.0
alpha         allyesconfig    clang-19
alpha            defconfig    gcc-14.2.0
arc           allmodconfig    clang-19
arc            allnoconfig    gcc-14.2.0
arc           allyesconfig    clang-19
arc              defconfig    gcc-14.2.0
arm           allmodconfig    clang-19
arm            allnoconfig    clang-21
arm            allnoconfig    gcc-14.2.0
arm           allyesconfig    clang-19
arm              defconfig    gcc-14.2.0
arm64         allmodconfig    clang-19
arm64          allnoconfig    gcc-14.2.0
arm64            defconfig    gcc-14.2.0
csky           allnoconfig    gcc-14.2.0
csky             defconfig    gcc-14.2.0
hexagon       allmodconfig    clang-19
hexagon        allnoconfig    clang-21
hexagon        allnoconfig    gcc-14.2.0
hexagon       allyesconfig    clang-19
hexagon          defconfig    gcc-14.2.0
i386          allmodconfig    clang-20
i386           allnoconfig    clang-20
i386          allyesconfig    clang-20
i386             defconfig    clang-20
loongarch     allmodconfig    gcc-14.2.0
loongarch      allnoconfig    gcc-14.2.0
loongarch        defconfig    gcc-14.2.0
m68k          allmodconfig    gcc-14.2.0
m68k           allnoconfig    gcc-14.2.0
m68k          allyesconfig    gcc-14.2.0
m68k             defconfig    gcc-14.2.0
microblaze    allmodconfig    gcc-14.2.0
microblaze     allnoconfig    gcc-14.2.0
microblaze    allyesconfig    gcc-14.2.0
microblaze       defconfig    gcc-14.2.0
mips           allnoconfig    gcc-14.2.0
nios2          allnoconfig    gcc-14.2.0
nios2            defconfig    gcc-14.2.0
openrisc       allnoconfig    clang-21
openrisc       allnoconfig    gcc-14.2.0
openrisc      allyesconfig    gcc-14.2.0
parisc        allmodconfig    gcc-14.2.0
parisc         allnoconfig    clang-21
parisc         allnoconfig    gcc-14.2.0
parisc        allyesconfig    gcc-14.2.0
parisc64         defconfig    gcc-14.2.0
powerpc       allmodconfig    gcc-14.2.0
powerpc        allnoconfig    clang-21
powerpc        allnoconfig    gcc-14.2.0
powerpc       allyesconfig    gcc-14.2.0
riscv         allmodconfig    gcc-14.2.0
riscv          allnoconfig    clang-21
riscv          allnoconfig    gcc-14.2.0
riscv         allyesconfig    gcc-14.2.0
s390          allmodconfig    gcc-14.2.0
s390           allnoconfig    clang-21
s390          allyesconfig    gcc-14.2.0
sh            allmodconfig    gcc-14.2.0
sh             allnoconfig    gcc-14.2.0
sh            allyesconfig    gcc-14.2.0
sparc         allmodconfig    gcc-14.2.0
sparc          allnoconfig    gcc-14.2.0
um            allmodconfig    clang-19
um             allnoconfig    clang-21
um            allyesconfig    clang-19
x86_64         allnoconfig    clang-20
x86_64        allyesconfig    clang-20
x86_64           defconfig    clang-20
x86_64               kexec    clang-20
x86_64            rhel-9.4    clang-20
x86_64        rhel-9.4-bpf    gcc-12
x86_64      rhel-9.4-kunit    gcc-12
x86_64        rhel-9.4-ltp    gcc-12
x86_64       rhel-9.4-rust    clang-20
xtensa         allnoconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

