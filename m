Return-Path: <linux-acpi+bounces-8277-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624939777DC
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 06:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D09F2861B8
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 04:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3D41D2F5A;
	Fri, 13 Sep 2024 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWqy8FY5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B7C1B12C2;
	Fri, 13 Sep 2024 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726201598; cv=none; b=Ud4z/PflIZjOyhNama/n3PlCen07cVM4w2xGQoms3+QimjRtp0HbHrdg9XuAeSggbRwvI+fAsaORZiH0DwSmP7r4+jwLak31JAGnAqhEFDAiaBfz7WogNqAXzAc1k1UAIvEemGw5rzHtLrRbNreH1Bl2Kqb1R0gCISgTTyVFG98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726201598; c=relaxed/simple;
	bh=ikfu0jUIl1QO5dao+4jfag2G7nUn7DZ7SZ2tItyhK3I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NFRuK3yZGxfH/y9dUXNkENYTIZaS6Uf8jxtDNR+umdMtJjUSR8f6mQRh4O+xPBJBW3j8yTUe8MLzLHAkkJAabUlaSSF/yjnt+Bja7mpJZfsNvPnfGWqt7nTx4v8yxdq4YFcsfDnXsjwgXRHwHMB1zUs7DdmdCQCC34NbRdknrFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nWqy8FY5; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726201595; x=1757737595;
  h=date:from:to:cc:subject:message-id;
  bh=ikfu0jUIl1QO5dao+4jfag2G7nUn7DZ7SZ2tItyhK3I=;
  b=nWqy8FY5rIkygpXplgP6+aTzcHsv8ZlCZTygZlFxTF2FLmtQS3iiNlmR
   ZWkyi5goA+Db9jJHENyBQiAyjZDjruetA6kmUy+zJ5v4W/eOsXn9tX3rU
   IxAUw4DaHikU09nFpX9oSoGa0O+fi3yH5Mx4b6cVKDxO98DsID4T7cbqR
   WxZM8R8096njaXBEuNK/aYzeyZNx6ocuqJowEKYYs65lf6o6ZfcxLUIWa
   po2TegOAvpWiKJlWaruq1wllZO0oC21GPdX3x2Ta3GXu4U2177quRzouU
   2grjbwOhdI5zPGfqBELyh8OWzxNqBZe4lKpgMU0icuF3lmjHhIRpnH0qY
   g==;
X-CSE-ConnectionGUID: TwNPb2NSTRWb6EWT8ZcNxg==
X-CSE-MsgGUID: 1gdduJICQ2uW72vz8KRfZQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25213237"
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="25213237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 21:26:35 -0700
X-CSE-ConnectionGUID: C4LYo90iRyGy36ML5u/F9w==
X-CSE-MsgGUID: tjLFtrN/SEml7zMBkCmCrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,224,1719903600"; 
   d="scan'208";a="68176352"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 12 Sep 2024 21:26:33 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1soxt9-00060Y-1r;
	Fri, 13 Sep 2024 04:26:31 +0000
Date: Fri, 13 Sep 2024 12:25:41 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 de721583f482fcb4f81b12b88175ce155ebd881b
Message-ID: <202409131232.Ypy3qwcO-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: de721583f482fcb4f81b12b88175ce155ebd881b  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1877m

configs tested: 97
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
alpha                               defconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-13.2.0
arc                   randconfig-001-20240913    gcc-13.2.0
arc                   randconfig-002-20240913    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20240913    gcc-14.1.0
arm                   randconfig-002-20240913    gcc-14.1.0
arm                   randconfig-003-20240913    gcc-14.1.0
arm                   randconfig-004-20240913    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20240913    clang-15
arm64                 randconfig-002-20240913    clang-20
arm64                 randconfig-003-20240913    gcc-14.1.0
arm64                 randconfig-004-20240913    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20240913    gcc-14.1.0
csky                  randconfig-002-20240913    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20240913    clang-20
hexagon               randconfig-002-20240913    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20240913    clang-18
i386        buildonly-randconfig-002-20240913    gcc-12
i386        buildonly-randconfig-003-20240913    gcc-12
i386        buildonly-randconfig-004-20240913    gcc-12
i386        buildonly-randconfig-005-20240913    clang-18
i386        buildonly-randconfig-006-20240913    gcc-11
i386                                defconfig    clang-18
i386                  randconfig-001-20240913    gcc-12
i386                  randconfig-002-20240913    gcc-12
i386                  randconfig-003-20240913    gcc-12
i386                  randconfig-004-20240913    clang-18
i386                  randconfig-005-20240913    clang-18
i386                  randconfig-006-20240913    clang-18
i386                  randconfig-011-20240913    gcc-11
i386                  randconfig-012-20240913    gcc-12
i386                  randconfig-013-20240913    gcc-12
i386                  randconfig-014-20240913    gcc-12
i386                  randconfig-015-20240913    gcc-11
i386                  randconfig-016-20240913    gcc-12
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20240913    gcc-14.1.0
loongarch             randconfig-002-20240913    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20240913    gcc-14.1.0
nios2                 randconfig-002-20240913    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                              defconfig    gcc-14.1.0
parisc                randconfig-001-20240913    gcc-14.1.0
parisc                randconfig-002-20240913    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20240913    clang-17
powerpc64             randconfig-001-20240913    clang-20
powerpc64             randconfig-002-20240913    clang-20
powerpc64             randconfig-003-20240913    gcc-14.1.0
riscv                             allnoconfig    gcc-14.1.0
riscv                               defconfig    clang-20
riscv                 randconfig-001-20240913    gcc-14.1.0
riscv                 randconfig-002-20240913    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    clang-20
s390                  randconfig-001-20240913    clang-16
s390                  randconfig-002-20240913    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                                  defconfig    gcc-14.1.0
sh                    randconfig-001-20240913    gcc-14.1.0
sh                    randconfig-002-20240913    gcc-14.1.0
sparc64                             defconfig    gcc-14.1.0
sparc64               randconfig-001-20240913    gcc-14.1.0
sparc64               randconfig-002-20240913    gcc-14.1.0
um                                allnoconfig    clang-17
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20240913    gcc-12
um                    randconfig-002-20240913    clang-17
um                           x86_64_defconfig    clang-15
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64                              defconfig    gcc-11
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20240913    gcc-14.1.0
xtensa                randconfig-002-20240913    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

