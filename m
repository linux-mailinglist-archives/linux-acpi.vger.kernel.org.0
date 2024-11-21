Return-Path: <linux-acpi+bounces-9720-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFC9D54C5
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 22:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691F1B20B38
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Nov 2024 21:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640271CB50C;
	Thu, 21 Nov 2024 21:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="StjGwCVL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192CB1CB303;
	Thu, 21 Nov 2024 21:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732224837; cv=none; b=oIaM9plt2E6wbYdAb2HnslkoxGnugvxEFQjNOe+neImTA5vDZ74lDcTnKfuaBY8sRzjjBIeSOYI83JlZQhYSuieKIWyDVYqVrc9vxW+s8TWruWawPjgZNVi5BzM8sgR9+Rk3/6PoLm8VrDdUpwibhgSCfszea6fSfrVfPBdTVvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732224837; c=relaxed/simple;
	bh=ozEspz3IEG+axixI1DQw4xiQmDuXAVIcqEP4uJpx7/g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UVeu+LEZ0Zs9ztJa9d1KQ+anVnv2vrgDt4iOFTbHFjRA0qYEuW+/IwmOj/pnpeLwjH6RtOKb9dIY5mn7hYX31R313I9H2nD6YlaH7/7gSBBFRtqxoRaMS4f5cB/B5kNUE/NINFnjwwpkK10cq1C6IdgG3979aXb0PJpFivom9qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=StjGwCVL; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732224835; x=1763760835;
  h=date:from:to:cc:subject:message-id;
  bh=ozEspz3IEG+axixI1DQw4xiQmDuXAVIcqEP4uJpx7/g=;
  b=StjGwCVLOa1DKCyicyQQb9axism3Z2jWFzRDWrzITwHq2toPktsZp4+8
   3rDD4cxxGRqyasZHEvorqqYwnRL3nmnuDaWL7B0OKxhCwW21V5fJZyGQq
   fh7p3XEAwwBoqBvcp9LLl802KghHGgbgyam3XeoexNlduigvUATj+hfXV
   p2udxj35EOxf0bMCGyEv1F874Yc7CHWDN6150dcQFvf1CfDBff4iqSbgG
   9LIB48D7TGzRl9sh0Ah+wzLjwCplQ1pqFeBrBjjv1BPsS1jVXBWQAtoC/
   HAWASIuaeiMNc8WWwizFP42Il4VTOePcQRU4otKbNJ0XEdQ01Vr7J8q2y
   A==;
X-CSE-ConnectionGUID: SmQcZvQOSlCMT5OSOXqe4g==
X-CSE-MsgGUID: QTeiaR6IS2q0oduxP1gk1g==
X-IronPort-AV: E=McAfee;i="6700,10204,11263"; a="32421864"
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="32421864"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 13:33:55 -0800
X-CSE-ConnectionGUID: knciVBwzTvebIwTBuAqbdQ==
X-CSE-MsgGUID: 6RK/be4oRQi/s28i7Kaasg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,173,1728975600"; 
   d="scan'208";a="95323281"
Received: from lkp-server01.sh.intel.com (HELO 8122d2fc1967) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 21 Nov 2024 13:33:53 -0800
Received: from kbuild by 8122d2fc1967 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tEEoB-0003NO-0b;
	Thu, 21 Nov 2024 21:33:51 +0000
Date: Fri, 22 Nov 2024 05:33:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f758bb9e2ac09eb8a943af96ef8a74df07937f4d
Message-ID: <202411220511.oD5O4T6c-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f758bb9e2ac09eb8a943af96ef8a74df07937f4d  Merge branches 'acpi-processor' and 'pm-cpuidle' into linux-next

elapsed time: 1451m

configs tested: 93
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                   allnoconfig    gcc-14.2.0
alpha                  allyesconfig    gcc-14.2.0
arc                    allmodconfig    gcc-13.2.0
arc                     allnoconfig    gcc-13.2.0
arc                    allyesconfig    gcc-13.2.0
arc         randconfig-001-20241121    gcc-13.2.0
arc         randconfig-002-20241121    gcc-13.2.0
arm                    allmodconfig    gcc-14.2.0
arm                     allnoconfig    clang-20
arm                    allyesconfig    gcc-14.2.0
arm         randconfig-001-20241121    clang-20
arm         randconfig-002-20241121    gcc-14.2.0
arm         randconfig-003-20241121    clang-20
arm         randconfig-004-20241121    gcc-14.2.0
arm64                  allmodconfig    clang-20
arm64                   allnoconfig    gcc-14.2.0
arm64       randconfig-001-20241121    clang-20
arm64       randconfig-002-20241121    clang-20
arm64       randconfig-003-20241121    gcc-14.2.0
arm64       randconfig-004-20241121    gcc-14.2.0
csky                    allnoconfig    gcc-14.2.0
csky        randconfig-001-20241121    gcc-14.2.0
csky        randconfig-002-20241121    gcc-14.2.0
hexagon                allmodconfig    clang-20
hexagon                 allnoconfig    clang-20
hexagon                allyesconfig    clang-20
hexagon     randconfig-001-20241121    clang-20
hexagon     randconfig-002-20241121    clang-15
i386                   allmodconfig    gcc-12
i386                    allnoconfig    gcc-12
i386                   allyesconfig    gcc-12
i386                      defconfig    clang-19
loongarch              allmodconfig    gcc-14.2.0
loongarch               allnoconfig    gcc-14.2.0
loongarch   randconfig-001-20241121    gcc-14.2.0
loongarch   randconfig-002-20241121    gcc-14.2.0
m68k                   allmodconfig    gcc-14.2.0
m68k                    allnoconfig    gcc-14.2.0
m68k                   allyesconfig    gcc-14.2.0
microblaze             allmodconfig    gcc-14.2.0
microblaze              allnoconfig    gcc-14.2.0
microblaze             allyesconfig    gcc-14.2.0
mips                    allnoconfig    gcc-14.2.0
nios2                   allnoconfig    gcc-14.2.0
nios2       randconfig-001-20241121    gcc-14.2.0
nios2       randconfig-002-20241121    gcc-14.2.0
openrisc                allnoconfig    gcc-14.2.0
openrisc               allyesconfig    gcc-14.2.0
parisc                 allmodconfig    gcc-14.2.0
parisc                  allnoconfig    gcc-14.2.0
parisc                 allyesconfig    gcc-14.2.0
parisc      randconfig-001-20241121    gcc-14.2.0
parisc      randconfig-002-20241121    gcc-14.2.0
powerpc                allmodconfig    gcc-14.2.0
powerpc                 allnoconfig    gcc-14.2.0
powerpc                allyesconfig    clang-20
powerpc     randconfig-001-20241121    clang-15
powerpc     randconfig-002-20241121    gcc-14.2.0
powerpc     randconfig-003-20241121    clang-20
powerpc64   randconfig-001-20241121    gcc-14.2.0
powerpc64   randconfig-002-20241121    clang-20
powerpc64   randconfig-003-20241121    clang-20
riscv                  allmodconfig    clang-20
riscv                   allnoconfig    gcc-14.2.0
riscv                  allyesconfig    clang-20
riscv       randconfig-001-20241121    gcc-14.2.0
riscv       randconfig-002-20241121    gcc-14.2.0
s390                   allmodconfig    clang-20
s390                    allnoconfig    clang-20
s390                   allyesconfig    gcc-14.2.0
s390        randconfig-001-20241121    gcc-14.2.0
s390        randconfig-002-20241121    clang-20
sh                     allmodconfig    gcc-14.2.0
sh                      allnoconfig    gcc-14.2.0
sh                     allyesconfig    gcc-14.2.0
sh          randconfig-001-20241121    gcc-14.2.0
sh          randconfig-002-20241121    gcc-14.2.0
sparc                  allmodconfig    gcc-14.2.0
sparc64     randconfig-001-20241121    gcc-14.2.0
sparc64     randconfig-002-20241121    gcc-14.2.0
um                     allmodconfig    clang-20
um                      allnoconfig    clang-17
um                     allyesconfig    gcc-12
um          randconfig-001-20241121    gcc-12
um          randconfig-002-20241121    gcc-12
x86_64                  allnoconfig    clang-19
x86_64                 allyesconfig    clang-19
x86_64                    defconfig    gcc-11
x86_64                        kexec    clang-19
x86_64                     rhel-9.4    gcc-12
xtensa                  allnoconfig    gcc-14.2.0
xtensa      randconfig-001-20241121    gcc-14.2.0
xtensa      randconfig-002-20241121    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

