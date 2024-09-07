Return-Path: <linux-acpi+bounces-8200-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1048970430
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 23:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF632837AD
	for <lists+linux-acpi@lfdr.de>; Sat,  7 Sep 2024 21:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9EB15696E;
	Sat,  7 Sep 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HpyXOs9F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA5245014;
	Sat,  7 Sep 2024 21:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725745412; cv=none; b=IFEHFYtW1BEjWmvQERgnt6F9LlCPaBNcjy4tdv1Uk6SZVIE1P51n1BbYIWz1VF+7Ff8tx3WPuj8qkOcNyciTpsUxMEfE++LqlAks8yBIrvMYFoI1nGR7vvnmWtYhRPP8SaOOTteryREWAgXdHjxTXUU2kzATf3vh28Bjg0n4YJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725745412; c=relaxed/simple;
	bh=NhBq+HpdvAez9VKfaVCfbJGK/2jn9pImdKu3aKTa9ps=;
	h=Date:From:To:Cc:Subject:Message-ID; b=B6B4xleHa0PgkQQGQR3V5ukMUbADzOGXlU94Egcbi7VLIl0vgt2ybBFCAVu70w0xeSYQoNMYPs4tTE1zTevrbJQFa9kw40gu/6/6GL2k764VeVICZrpykRYQAB808yp9v9imVUnhj+YrH9B0Sq7PZ118Wvd3o3C6zLJ8LsNxzZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HpyXOs9F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725745410; x=1757281410;
  h=date:from:to:cc:subject:message-id;
  bh=NhBq+HpdvAez9VKfaVCfbJGK/2jn9pImdKu3aKTa9ps=;
  b=HpyXOs9FfTp17X8FxP/EGH4n6NgkdGX56LlUAHVwkvKynaMnsEXs2DHK
   MbC9iKuwOrZsN/fNG4rs2O5SE/GH+13L4DLejVR4qfuWYM4+ZdXuq403t
   Pa0RquJVgkZMQqLDmMQAD16KUDxybD/EdlnaQxw7+wOBJJrjXL5Ci5zZE
   z2OC9OiVOU9rO9MMpoKAenguMGx/M8Xk8KLl9LQCPDMnZZDxvlA30zY+m
   DkN4m2s+5JE5hQ/EWkKjyiPULmPyBTDIjwcthmyQM/StANdLCRVdNWkOJ
   ErJ6eCqUsi75P9gSpZPf2dKE2F00rPkBH418JiDbq/4qmUyEnBSClNZ21
   g==;
X-CSE-ConnectionGUID: W66ywsDHSHuuB49EqXh7hA==
X-CSE-MsgGUID: D6vp2FUMShmQWLKZ7dOWaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11188"; a="24637047"
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="24637047"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2024 14:43:29 -0700
X-CSE-ConnectionGUID: wJjai3EZT4+rYsVyfKKogA==
X-CSE-MsgGUID: CC0Jb5ReRzCOc+LIzYJVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,211,1719903600"; 
   d="scan'208";a="70870640"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Sep 2024 14:43:27 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sn3DJ-000D1n-1Z;
	Sat, 07 Sep 2024 21:43:25 +0000
Date: Sun, 08 Sep 2024 05:43:11 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f0ff0c80a1cf2da2f8e105ee1eff184193a094fa
Message-ID: <202409080508.wUeIPL0a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f0ff0c80a1cf2da2f8e105ee1eff184193a094fa  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1555m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240907   gcc-12
i386         buildonly-randconfig-002-20240907   gcc-12
i386         buildonly-randconfig-003-20240907   gcc-12
i386         buildonly-randconfig-004-20240907   gcc-12
i386         buildonly-randconfig-005-20240907   gcc-12
i386         buildonly-randconfig-006-20240907   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240907   gcc-12
i386                  randconfig-002-20240907   gcc-12
i386                  randconfig-003-20240907   gcc-12
i386                  randconfig-004-20240907   gcc-12
i386                  randconfig-005-20240907   gcc-12
i386                  randconfig-006-20240907   gcc-12
i386                  randconfig-011-20240907   gcc-12
i386                  randconfig-012-20240907   gcc-12
i386                  randconfig-013-20240907   gcc-12
i386                  randconfig-014-20240907   gcc-12
i386                  randconfig-015-20240907   gcc-12
i386                  randconfig-016-20240907   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                            defconfig   gcc-12
parisc                            allnoconfig   clang-20
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
riscv                             allnoconfig   clang-20
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240907   gcc-12
x86_64       buildonly-randconfig-002-20240907   gcc-12
x86_64       buildonly-randconfig-003-20240907   gcc-12
x86_64       buildonly-randconfig-004-20240907   gcc-12
x86_64       buildonly-randconfig-005-20240907   gcc-12
x86_64       buildonly-randconfig-006-20240907   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240907   gcc-12
x86_64                randconfig-002-20240907   gcc-12
x86_64                randconfig-003-20240907   gcc-12
x86_64                randconfig-004-20240907   gcc-12
x86_64                randconfig-005-20240907   gcc-12
x86_64                randconfig-006-20240907   gcc-12
x86_64                randconfig-011-20240907   gcc-12
x86_64                randconfig-012-20240907   gcc-12
x86_64                randconfig-013-20240907   gcc-12
x86_64                randconfig-014-20240907   gcc-12
x86_64                randconfig-015-20240907   gcc-12
x86_64                randconfig-016-20240907   gcc-12
x86_64                randconfig-071-20240907   gcc-12
x86_64                randconfig-072-20240907   gcc-12
x86_64                randconfig-073-20240907   gcc-12
x86_64                randconfig-074-20240907   gcc-12
x86_64                randconfig-075-20240907   gcc-12
x86_64                randconfig-076-20240907   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

