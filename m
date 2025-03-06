Return-Path: <linux-acpi+bounces-11893-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE92A54F61
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 16:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C0B169DA9
	for <lists+linux-acpi@lfdr.de>; Thu,  6 Mar 2025 15:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB020E337;
	Thu,  6 Mar 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LnU8vas2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E1148FF5;
	Thu,  6 Mar 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741275725; cv=none; b=INTHvbE4aB7yFlGkVK/yE5MWwOoVK2xJidd9crL98bqSK3Z/2LfB8hfaJSuv8jNZJhbObgoex//PPXxflFUVxh3CcUMy3Xd5Z5rygrvXDb8hY/TDN5KddFddqNhPMSXLQ42rQosqXNYg1OtDHN6rRMVooEmhYKhExiVL4T3GYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741275725; c=relaxed/simple;
	bh=P0tUfjIjCs87Zlh7lJS0itIdMdK/i5HsXGug2oQc29E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EbvwNCXZOsi+yZzmIL2AWDYGoKE1R6RBwYAvfEHq/TGaOq1eXnqqE1NIZDwisduOVOYGg9s9mLoJZt5r5eSFC/FfwaZFj++UhaTfGWWUPwoMwf0hr/NLzy/90tk0Kr2NG0B5zs+FznMCaVFVJQv5Jp5C2f76+2vLNbxJLuS3eaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LnU8vas2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741275723; x=1772811723;
  h=date:from:to:cc:subject:message-id;
  bh=P0tUfjIjCs87Zlh7lJS0itIdMdK/i5HsXGug2oQc29E=;
  b=LnU8vas2QrgbPUWPwZgtf/GJzpbchH9qrRzVbtyBYDE7R2qcnhWTNVAQ
   LKsTZIOUkFLeRqzlsIkv4/2dxG1z//cu2MtmHgfM3WBWBc/J9EhjSDkVo
   7KD1qqvYvgRohzn6ZqK3GAonMkzoNWULgjatAFUtPdB3x/CbzxTxL8N3W
   jo1o8N1Znl24kaZwzSUfppDBCEdMeW25nof2Vq2cXQjFaJGVTB/f1xSDh
   x2toqBhXRyHrDPeToIPRD239KKXPcFXnbNxpPviX7uu0DxKUuYhgGeEOt
   gCI+OrrAhg9uv1wuz1o1YO7oykoIroazZ+BMyc1fjcogqYv3wTg+lKgQI
   w==;
X-CSE-ConnectionGUID: ba5gU+H8Q8+veLIKYhMQWQ==
X-CSE-MsgGUID: y3Y+JpOKR/WmG0FbQQuT9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42532278"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="42532278"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 07:42:02 -0800
X-CSE-ConnectionGUID: 2/Q5DHQvTLOOoapCKc6YYA==
X-CSE-MsgGUID: JM9d/jVWTlma2fitr3nWLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149987876"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Mar 2025 07:42:01 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tqDMF-000NEH-0M;
	Thu, 06 Mar 2025 15:41:59 +0000
Date: Thu, 06 Mar 2025 23:41:45 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 96791086aa226b85fe090573b9e3668ac53d5364
Message-ID: <202503062338.c04KgICA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 96791086aa226b85fe090573b9e3668ac53d5364  Merge branch 'pm-sleep-testing' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202503061203.vRnwilWZ-lkp@intel.com

    drivers/powercap/dtpm_cpu.c:83:29: error: implicit declaration of function 'sched_cpu_util' [-Wimplicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- sh-allyesconfig
|   `-- drivers-powercap-dtpm_cpu.c:error:implicit-declaration-of-function-sched_cpu_util
`-- um-allyesconfig
    `-- drivers-powercap-dtpm_cpu.c:error:implicit-declaration-of-function-sched_cpu_util

elapsed time: 1446m

configs tested: 79
configs skipped: 1

tested configs:
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250306    gcc-13.2.0
arc                   randconfig-002-20250306    gcc-13.2.0
arm                              allyesconfig    gcc-14.2.0
arm                   randconfig-001-20250306    gcc-14.2.0
arm                   randconfig-002-20250306    gcc-14.2.0
arm                   randconfig-003-20250306    gcc-14.2.0
arm                   randconfig-004-20250306    clang-18
arm64                            allmodconfig    clang-18
arm64                 randconfig-001-20250306    gcc-14.2.0
arm64                 randconfig-002-20250306    gcc-14.2.0
arm64                 randconfig-003-20250306    gcc-14.2.0
arm64                 randconfig-004-20250306    gcc-14.2.0
csky                  randconfig-001-20250306    gcc-14.2.0
csky                  randconfig-002-20250306    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250306    clang-21
hexagon               randconfig-002-20250306    clang-19
i386        buildonly-randconfig-001-20250306    clang-19
i386        buildonly-randconfig-002-20250306    clang-19
i386        buildonly-randconfig-003-20250306    clang-19
i386        buildonly-randconfig-004-20250306    gcc-12
i386        buildonly-randconfig-005-20250306    gcc-12
i386        buildonly-randconfig-006-20250306    clang-19
loongarch             randconfig-001-20250306    gcc-14.2.0
loongarch             randconfig-002-20250306    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250306    gcc-14.2.0
nios2                 randconfig-002-20250306    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                randconfig-001-20250306    gcc-14.2.0
parisc                randconfig-002-20250306    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc               randconfig-001-20250306    clang-21
powerpc               randconfig-002-20250306    clang-18
powerpc               randconfig-003-20250306    gcc-14.2.0
powerpc64             randconfig-001-20250306    clang-18
powerpc64             randconfig-002-20250306    clang-21
powerpc64             randconfig-003-20250306    clang-18
riscv                             allnoconfig    gcc-14.2.0
riscv                 randconfig-001-20250306    clang-18
riscv                 randconfig-002-20250306    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250306    gcc-14.2.0
s390                  randconfig-002-20250306    clang-19
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                    randconfig-001-20250306    gcc-14.2.0
sh                    randconfig-002-20250306    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250306    gcc-14.2.0
sparc                 randconfig-002-20250306    gcc-14.2.0
sparc64               randconfig-001-20250306    gcc-14.2.0
sparc64               randconfig-002-20250306    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250306    gcc-12
um                    randconfig-002-20250306    clang-16
x86_64      buildonly-randconfig-001-20250306    gcc-11
x86_64      buildonly-randconfig-002-20250306    clang-19
x86_64      buildonly-randconfig-003-20250306    clang-19
x86_64      buildonly-randconfig-004-20250306    clang-19
x86_64      buildonly-randconfig-005-20250306    clang-19
x86_64      buildonly-randconfig-006-20250306    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250306    gcc-14.2.0
xtensa                randconfig-002-20250306    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

