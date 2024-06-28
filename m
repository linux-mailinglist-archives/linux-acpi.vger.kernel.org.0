Return-Path: <linux-acpi+bounces-6673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F339C91C9B7
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 02:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51551C21C42
	for <lists+linux-acpi@lfdr.de>; Sat, 29 Jun 2024 00:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0221DD531;
	Sat, 29 Jun 2024 00:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2ibkQyr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBCA29;
	Sat, 29 Jun 2024 00:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719619256; cv=none; b=b8l5SCYreliGdIRJfN4G52EPHJxdrB0Sr77V5Tni1p+akTj7x9XkhdzCvrVLuhFjEaHXC7ThplYiwEcUYYluHDQ0+bKpyCTJ4ERvr0ery+WqXmXwBN/jq7dg7NnDc0jU2lBKR8f5x9NUZ+V3kS6MfPpvbNSIxcoPebDps+qDZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719619256; c=relaxed/simple;
	bh=Nbl4J3KojcNERXf8DqGTMaks/dV501rpS3C0AUKcXo0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=IZGTyMAMeBrmdPLUzoCLy7Yjjw0J1cgvsNtt4j3SLw+mJ2095RZyHtpAWtipHLKm+T//JsyI1aov/mk/V7+7KkUpa6mwUXQJKkbXoilt3UdzSWtmcSncAMVGAGICdZyx1iAB+mnRA1VK3qr+DiqISV+0t6IrM4emkFpWCzJY+hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2ibkQyr; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719619255; x=1751155255;
  h=date:from:to:cc:subject:message-id;
  bh=Nbl4J3KojcNERXf8DqGTMaks/dV501rpS3C0AUKcXo0=;
  b=g2ibkQyr8OxAPM41qTyGYXK5pTl6ggY7mNMTLF7V10zrRJc7W5Wc9DeE
   8w8qsU6xarrBF1ap3PcJEA7DyrMq5mTR3dhc9uVEET5ZXyTrtxq8Mkjfk
   RS4abFQv6dyKAT9YQRdSGCgVGFmAfU59XTrZrqz2a44NHUp5nOKs1bfKG
   R1/JGivk9ZeEdUGWBRQ982VAMA3lSU2Oi437HEl6CFgAXTSjOoxbATYOL
   p+cFVfASS9NFQcAL2G6z1wTPIJ/TEwJpawK1p5ytl/qTF/EDUQLlGUDHQ
   6/2oMsvFF8IFWKlzHRQlTVV26/dXlzwwt5vZ4wlLsPWk58G4+OmKL/7vq
   g==;
X-CSE-ConnectionGUID: 5UfisB81SSuMs7Asf3k9jg==
X-CSE-MsgGUID: hX2Jk0+SS5KbPcn6L/kjLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="16640949"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="16640949"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 17:00:54 -0700
X-CSE-ConnectionGUID: bkPb3D32SWiGpoRN3OCeAg==
X-CSE-MsgGUID: 7WOHwJ4sQGuMT2yKfq/7ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="76076545"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 28 Jun 2024 17:00:52 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNLWM-000Ihu-1p;
	Sat, 29 Jun 2024 00:00:50 +0000
Date: Sat, 29 Jun 2024 07:59:59 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 f7cd54956dc7b353eb7511054620cf02f9ae5027
Message-ID: <202406290757.5LTsrMbE-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: f7cd54956dc7b353eb7511054620cf02f9ae5027  Merge branch 'pm-cpufreq' into linux-next

elapsed time: 1687m

configs tested: 67
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386         buildonly-randconfig-001-20240628   gcc-10
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-002-20240628   gcc-10
i386         buildonly-randconfig-002-20240628   gcc-13
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-003-20240628   gcc-10
i386         buildonly-randconfig-003-20240628   gcc-13
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-004-20240628   gcc-10
i386         buildonly-randconfig-004-20240628   gcc-13
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-005-20240628   clang-18
i386         buildonly-randconfig-005-20240628   gcc-10
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-006-20240628   gcc-10
i386         buildonly-randconfig-006-20240628   gcc-13
i386         buildonly-randconfig-006-20240629   gcc-7
i386                  randconfig-001-20240628   gcc-10
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-002-20240628   gcc-10
i386                  randconfig-002-20240628   gcc-13
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-003-20240628   clang-18
i386                  randconfig-003-20240628   gcc-10
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-004-20240628   gcc-10
i386                  randconfig-004-20240628   gcc-13
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-005-20240628   clang-18
i386                  randconfig-005-20240628   gcc-10
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-006-20240628   gcc-10
i386                  randconfig-006-20240628   gcc-13
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-011-20240628   clang-18
i386                  randconfig-011-20240628   gcc-10
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-012-20240628   gcc-10
i386                  randconfig-012-20240628   gcc-9
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-013-20240628   gcc-10
i386                  randconfig-013-20240628   gcc-13
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-014-20240628   clang-18
i386                  randconfig-014-20240628   gcc-10
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-015-20240628   gcc-10
i386                  randconfig-015-20240628   gcc-13
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-016-20240628   gcc-10
i386                  randconfig-016-20240628   gcc-7
i386                  randconfig-016-20240629   gcc-7
nios2                            allmodconfig   gcc-13.2.0
nios2                            allyesconfig   gcc-13.2.0
openrisc                         allmodconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
sparc                            allyesconfig   gcc-13.2.0
sparc64                          allmodconfig   gcc-13.2.0
sparc64                          allyesconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0
xtensa                           allyesconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

