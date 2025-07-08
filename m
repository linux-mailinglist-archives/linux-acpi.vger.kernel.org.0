Return-Path: <linux-acpi+bounces-15070-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A45EAFD7A3
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 21:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9F51896B68
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Jul 2025 19:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370A723AB95;
	Tue,  8 Jul 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vy9Zq8kd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6921DDA24;
	Tue,  8 Jul 2025 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004312; cv=none; b=ca4pfbSC5Ze1RHC8HaiX1OI+aZN/auSCi8a3p5gdQQeU9BO1QjfN9tOkqmvxFuSHyMRVvbRZMjoC5UuKqyW1gS0x+CgM/lI/DJhqMkus1CvRucNV0P8vayLqJjJJztuVlHDs2B2myzi0xQKe5/F+nUC5mDCifEG5DFIkbwGB+1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004312; c=relaxed/simple;
	bh=yTr2Lf6OzbgYuYzMP6Xk0nLwlLvEYoyDrhjaU0F+Y9I=;
	h=Date:From:To:Cc:Subject:Message-ID; b=h0wWwYb5wu5JeN+dBydELgKV/EUT40unLzTif9VGQ9ayTeXtl/m+VljZBsp6KjgEKcRFKTcp27iUFLpIZSDTpfwiYbkV/GqHaFUjo++Hfi0EHdiijd0Oer7XfRJhO4BrpkI6tvi9Ictpzw1ni/3CQ380aoNoKwBn17/B8qkwZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vy9Zq8kd; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752004311; x=1783540311;
  h=date:from:to:cc:subject:message-id;
  bh=yTr2Lf6OzbgYuYzMP6Xk0nLwlLvEYoyDrhjaU0F+Y9I=;
  b=Vy9Zq8kdq/yjkTlSNIUljGMRqTlsyuGFC8JDRJ0fhE2i04obylfirioa
   q9L4OCBD+CKGVM8j8g0OoKieMgc2J+ixyAGsJLxutOtGkMLyVGqri3msL
   6svL8xsQHViA86x5Kvq/wKVhOo9u99kVLepVZxsUqZVr+V9acoiCtyZxW
   rNSQOWtLGBJv95hNhMA6d01eZQYPvtZHVA9CH/5rENJKEoyChFlsf3dcG
   us1ztYNWpS9j7NNS+nIcWfsvcTFOr8V5kKc17lwz0s+Dk5fpAusGA8k9K
   Nk4f3Wz6GfQ13/Pj/AoRI+tAedl7YV8PrEZQFdNjI/AHf4GNqazdmhj1Y
   Q==;
X-CSE-ConnectionGUID: kbLkTwhzTFmGdnj+yuTCEw==
X-CSE-MsgGUID: PlFAp+t2T92bBJ8xiFsvgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="64951998"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="64951998"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 12:51:50 -0700
X-CSE-ConnectionGUID: PqruNcHvTAeMHX3Yug7l5g==
X-CSE-MsgGUID: wyBvPltBRuuxPQpRO2P3pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161136258"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 08 Jul 2025 12:51:48 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uZELx-0002hq-2q;
	Tue, 08 Jul 2025 19:51:45 +0000
Date: Wed, 09 Jul 2025 03:50:48 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 133eb9f50b0fea3a4a19b95d3207f793ca5aa77a
Message-ID: <202507090335.IEivsA0f-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 133eb9f50b0fea3a4a19b95d3207f793ca5aa77a  Merge branch 'pm-misc' into bleeding-edge

elapsed time: 1452m

configs tested: 112
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                   randconfig-001-20250708    gcc-13.4.0
arc                   randconfig-002-20250708    gcc-8.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                           imxrt_defconfig    clang-21
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250708    clang-21
arm                   randconfig-002-20250708    clang-17
arm                   randconfig-003-20250708    gcc-10.5.0
arm                   randconfig-004-20250708    clang-21
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250708    gcc-9.5.0
arm64                 randconfig-002-20250708    clang-19
arm64                 randconfig-003-20250708    clang-21
arm64                 randconfig-004-20250708    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250708    gcc-13.4.0
csky                  randconfig-002-20250708    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250708    clang-21
hexagon               randconfig-002-20250708    clang-21
i386        buildonly-randconfig-001-20250708    clang-20
i386        buildonly-randconfig-002-20250708    clang-20
i386        buildonly-randconfig-003-20250708    clang-20
i386        buildonly-randconfig-004-20250708    gcc-12
i386        buildonly-randconfig-005-20250708    clang-20
i386        buildonly-randconfig-006-20250708    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250708    clang-21
loongarch             randconfig-002-20250708    clang-21
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250708    gcc-8.5.0
nios2                 randconfig-002-20250708    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250708    gcc-9.3.0
parisc                randconfig-002-20250708    gcc-14.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc               randconfig-001-20250708    gcc-8.5.0
powerpc               randconfig-002-20250708    clang-19
powerpc               randconfig-003-20250708    clang-21
powerpc64             randconfig-001-20250708    clang-21
powerpc64             randconfig-002-20250708    clang-21
powerpc64             randconfig-003-20250708    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-21
riscv                 randconfig-001-20250708    clang-16
riscv                 randconfig-002-20250708    gcc-11.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-21
s390                  randconfig-001-20250708    gcc-14.3.0
s390                  randconfig-002-20250708    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                         ecovec24_defconfig    gcc-15.1.0
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250708    gcc-11.5.0
sh                    randconfig-002-20250708    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250708    gcc-13.4.0
sparc                 randconfig-002-20250708    gcc-13.4.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250708    clang-21
sparc64               randconfig-002-20250708    gcc-15.1.0
um                               alldefconfig    clang-21
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    clang-21
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250708    clang-21
um                    randconfig-002-20250708    clang-17
um                           x86_64_defconfig    clang-21
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250708    gcc-12
x86_64      buildonly-randconfig-002-20250708    gcc-12
x86_64      buildonly-randconfig-003-20250708    clang-20
x86_64      buildonly-randconfig-004-20250708    gcc-12
x86_64      buildonly-randconfig-005-20250708    clang-20
x86_64      buildonly-randconfig-006-20250708    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250708    gcc-8.5.0
xtensa                randconfig-002-20250708    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

