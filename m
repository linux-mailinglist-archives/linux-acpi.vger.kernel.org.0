Return-Path: <linux-acpi+bounces-8555-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1F7990348
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 14:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998F61C216B9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Oct 2024 12:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA3A1E0B62;
	Fri,  4 Oct 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ioyRGsVl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520CC1E009C;
	Fri,  4 Oct 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046041; cv=none; b=vDmRoiUhOeeWWakd2tGdffCipqaI86U8KgawG8eilTZ3ZIOuPXKg0cF0C90qhVL9dqcofGXtvCO5pW6HZJoPmKCZqy7i3MYYWg81IvWDXMW61B+2SgDwVtnRKdqzwIC5eXjcDyaw7+gR/bQHTDu7XeFk2alHRrOe0hdT5rFW+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046041; c=relaxed/simple;
	bh=Lf7tndziwP/2RUETuDeNadBgxZOxN4CqYMiUDbETWDw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=iMhNoXX2+tHbCYbiwwWOpDGYCzxiy+vyzFVjY0HPVCt7UOnnB19SPscouVL+ByWU6qHI9n5c4AVtu8SyMZyLpWI61hnxRtKRbamHjmliPc5s7CyAUq/AwTUmJQM4oyybOaLnZYAugi5B+ko46bjyCq/l57S8Jd9pOb3uCBhtwiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ioyRGsVl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728046038; x=1759582038;
  h=date:from:to:cc:subject:message-id;
  bh=Lf7tndziwP/2RUETuDeNadBgxZOxN4CqYMiUDbETWDw=;
  b=ioyRGsVl84RlJzZ5wXdGlxlkcHMVrFJq4JCfgUm1PM7MuXhliqkwb15c
   /6ypBdiolIpvqZJTCU1IBR6ftGFAwZ4XyDOTQNnZBKfJljTm6W/KnN1UF
   3hwX+HSMYhxDQLFUOAwkQ+uUQSvvS5/EKDURFvqjjetVGTFWn8g/NNcRS
   TKJVJVCCV/fMANotrb4i+rPi4f2oJSIgFBXJGR97EY7OfcIQWPk0OwdDC
   kf1T+g6OVJa4TkZgk1EnO1xRi979fETnhkWVRSOHQb84/OFPtge4prMeK
   wUHXsVFx8P50mrVV/xqiIopu+MKUEo0ep00xuUSYDIxeokA4xhhwX6/Xw
   A==;
X-CSE-ConnectionGUID: +CSC//caROGAGOACYSsNGA==
X-CSE-MsgGUID: 45/U5QAXQsinbl0kLG71Fw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37833530"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37833530"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 05:47:18 -0700
X-CSE-ConnectionGUID: HFE+Dh1xTlO9v5wH9SnVYQ==
X-CSE-MsgGUID: daTNLjW0T56h6DfhrsqU3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="79122090"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 04 Oct 2024 05:47:17 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swhiE-0001cm-2A;
	Fri, 04 Oct 2024 12:47:14 +0000
Date: Fri, 04 Oct 2024 20:47:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, devel@acpica.org,
 linux-pm@vger.kernel.org
Subject: [rafael-pm:bleeding-edge] BUILD SUCCESS
 5771ba5175355725690a8886d4db7d2042a97a5b
Message-ID: <202410042048.Jczk61Du-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
branch HEAD: 5771ba5175355725690a8886d4db7d2042a97a5b  Merge branch 'thermal-core-experimental' into bleeding-edge

elapsed time: 1100m

configs tested: 81
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha            allnoconfig    gcc-14.1.0
alpha           allyesconfig    clang-20
alpha              defconfig    gcc-14.1.0
arc             allmodconfig    clang-20
arc              allnoconfig    gcc-14.1.0
arc             allyesconfig    clang-20
arc                defconfig    gcc-14.1.0
arm             allmodconfig    clang-20
arm              allnoconfig    gcc-14.1.0
arm             allyesconfig    clang-20
arm                defconfig    gcc-14.1.0
arm64           allmodconfig    clang-20
arm64            allnoconfig    gcc-14.1.0
arm64              defconfig    gcc-14.1.0
csky             allnoconfig    gcc-14.1.0
csky               defconfig    gcc-14.1.0
hexagon         allmodconfig    clang-20
hexagon          allnoconfig    gcc-14.1.0
hexagon         allyesconfig    clang-20
hexagon            defconfig    gcc-14.1.0
i386            allmodconfig    clang-18
i386             allnoconfig    clang-18
i386            allyesconfig    clang-18
i386               defconfig    clang-18
loongarch       allmodconfig    gcc-14.1.0
loongarch        allnoconfig    gcc-14.1.0
loongarch          defconfig    gcc-14.1.0
m68k            allmodconfig    gcc-14.1.0
m68k             allnoconfig    gcc-14.1.0
m68k            allyesconfig    gcc-14.1.0
m68k               defconfig    gcc-14.1.0
microblaze      allmodconfig    gcc-14.1.0
microblaze       allnoconfig    gcc-14.1.0
microblaze      allyesconfig    gcc-14.1.0
microblaze         defconfig    gcc-14.1.0
mips             allnoconfig    gcc-14.1.0
nios2            allnoconfig    gcc-14.1.0
nios2              defconfig    gcc-14.1.0
openrisc         allnoconfig    clang-20
openrisc         allnoconfig    gcc-14.1.0
openrisc        allyesconfig    gcc-14.1.0
openrisc           defconfig    gcc-12
parisc          allmodconfig    gcc-14.1.0
parisc           allnoconfig    clang-20
parisc           allnoconfig    gcc-14.1.0
parisc          allyesconfig    gcc-14.1.0
parisc             defconfig    gcc-12
parisc64           defconfig    gcc-14.1.0
powerpc         allmodconfig    gcc-14.1.0
powerpc          allnoconfig    clang-20
powerpc          allnoconfig    gcc-14.1.0
powerpc         allyesconfig    gcc-14.1.0
riscv           allmodconfig    gcc-14.1.0
riscv            allnoconfig    clang-20
riscv            allnoconfig    gcc-14.1.0
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
um               allnoconfig    clang-17
um               allnoconfig    clang-20
um              allyesconfig    clang-20
um                 defconfig    gcc-12
um            i386_defconfig    gcc-12
um          x86_64_defconfig    gcc-12
x86_64           allnoconfig    clang-18
x86_64          allyesconfig    clang-18
x86_64             defconfig    clang-18
x86_64                 kexec    clang-18
x86_64              rhel-8.3    gcc-12
x86_64         rhel-8.3-rust    clang-18
xtensa           allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

