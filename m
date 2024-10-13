Return-Path: <linux-acpi+bounces-8740-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 676B199B961
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 14:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAC5E281D6F
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Oct 2024 12:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367CE13D279;
	Sun, 13 Oct 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kc4E0mFJ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D37D2FB;
	Sun, 13 Oct 2024 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728822710; cv=none; b=XjUrDvYPmxYQDFe40DvEBY02dYXQQ9HZF3VB2KFP+bBeYTkxCqD7Vt8h4MkmORso9J30y79mb990oGtdPnHa9sfXZOCeEUdCS+cxDUBCDcosBrAHLOzb++1rAhMXjB1xqyBnNS7eNQPDrziclytuhRy6/KU6dtemRmkBRdUTvpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728822710; c=relaxed/simple;
	bh=jeIPEaLkV/J5RjJDqYGH5s0Fx8kf2xSUhOrzMViEgtw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aUipNHAdNk9mMjfQ/LK94eRC6TdZAUtr00GzEMZuhFa/DFDmwNo7vRzBCCi/RZIg8hf+lcHJHy2ZgGRNXNazomuMEXAfvK+yOGOUk0vX31kDRZACOVhLaJQ/9e/QlBSAqN5aEuZjzKq9jiytxOPUgS6YAnMCZCkXJwQf1p8xP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kc4E0mFJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728822708; x=1760358708;
  h=date:from:to:cc:subject:message-id;
  bh=jeIPEaLkV/J5RjJDqYGH5s0Fx8kf2xSUhOrzMViEgtw=;
  b=Kc4E0mFJKk3cCzzb/mU+BJKJchDIW+5wzazsaS+w7Kt5Rb7z1gAnUcSa
   S7OKNhHiOh4haJjyTK3ErNA1BfkfxI4aAooLTEJvrWa4lqQ8BZI+iF8jQ
   5MgeqNNizQNZd9bTleqDFBQCMhtBUlwtVToGBmzv9Y/en20dI0ta2ELPZ
   LmCxIA+rJGWj6J+rD4j+jBIBPW8krTOjhYf91Su79kiLeS5L3lv2EzvtR
   1PQcs0wJN6oyoqO3FcMvBephDmX3YNy4Tq5gVV+U7a58ks0DdlOq1Xlt8
   sh4IpXV1mRxozt7YaYOQjb/tzbnv5BfGvo27g78RUh/q5OCZ1bUiauEH1
   w==;
X-CSE-ConnectionGUID: 7pQOHSjaRhmPpG4yU34A7A==
X-CSE-MsgGUID: Y2V89mzVTEq7bUxpN25iQw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="45652642"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="45652642"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2024 05:31:47 -0700
X-CSE-ConnectionGUID: ykYWoxsbR9C41w4oKK0rrw==
X-CSE-MsgGUID: YpX3taKsS5+DeT0h6IrVwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,200,1725346800"; 
   d="scan'208";a="77187215"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 13 Oct 2024 05:31:47 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1szxlA-000EMV-09;
	Sun, 13 Oct 2024 12:31:44 +0000
Date: Sun, 13 Oct 2024 20:31:08 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD REGRESSION
 c7d553cb161f03e4424c88bddc26fadcbbf4b6d5
Message-ID: <202410132058.VIShcV1a-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: c7d553cb161f03e4424c88bddc26fadcbbf4b6d5  Merge branch 'thermal-core-experimental' into bleeding-edge

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202410131909.OG5cXVR5-lkp@intel.com

    drivers/thermal/thermal_sysfs.c:726:17: error: label 'unlock' used but not defined

Error/Warning ids grouped by kconfigs:

recent_errors
`-- i386-buildonly-randconfig-002-20241013
    `-- drivers-thermal-thermal_sysfs.c:error:label-unlock-used-but-not-defined

elapsed time: 2435m

configs tested: 22
configs skipped: 0

tested configs:
i386      buildonly-randconfig-001-20241013    clang-18
i386      buildonly-randconfig-002-20241013    gcc-12
i386      buildonly-randconfig-003-20241013    clang-18
i386      buildonly-randconfig-004-20241013    gcc-12
i386      buildonly-randconfig-005-20241013    clang-18
i386      buildonly-randconfig-006-20241013    clang-18
i386                randconfig-001-20241013    clang-18
i386                randconfig-002-20241013    gcc-12
i386                randconfig-003-20241013    gcc-12
i386                randconfig-004-20241013    gcc-11
i386                randconfig-005-20241013    clang-18
i386                randconfig-006-20241013    clang-18
i386                randconfig-011-20241013    clang-18
i386                randconfig-012-20241013    gcc-12
openrisc                        allnoconfig    gcc-14.1.0
parisc                          allnoconfig    gcc-14.1.0
powerpc                         allnoconfig    gcc-14.1.0
riscv                           allnoconfig    gcc-14.1.0
s390                            allnoconfig    clang-20
um                              allnoconfig    clang-17
x86_64                                kexec    clang-18
x86_64                             rhel-8.3    gcc-12

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

