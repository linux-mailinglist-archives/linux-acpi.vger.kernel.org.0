Return-Path: <linux-acpi+bounces-17382-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A211BA7089
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 14:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662141895B99
	for <lists+linux-acpi@lfdr.de>; Sun, 28 Sep 2025 12:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9923C4EA;
	Sun, 28 Sep 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfEfCw51"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466B02253EE;
	Sun, 28 Sep 2025 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759063087; cv=none; b=SFfiocpPXz6XP9wQj4oYJWc9m1JxMocp1w8ilsSHUluPSookccCfTfth/FiJhTNFnT29kT3iw0e3YJqXN0NglT2VsQ88hAEiyQo83a8KxFSn9eyS9IGZGJvQUGFD/OSjZV3Ik/qYdOFYeLI9+iVRFtQHWY90HajiGAZpiZEF6DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759063087; c=relaxed/simple;
	bh=F+ulgsO9spSctRxlsM4Q8HSh4h0QoKP6pPsI/AWqKPA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L1QEuT/VC4M7TunWSUepiFmnqmRQ2apqu5Tt3b97GxqXYZFe6k50JtP0VUYpNfTs9T6hAOGJa2jd79Jnnc6EXPw/NqKP1nwYZiXDkr3nHsONTV/dmoAVOXg+iJzuj9cLSXN3PbBi6F7JEY33YYrdv9zYz9i+jFNOn8jy5re23zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfEfCw51; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759063086; x=1790599086;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F+ulgsO9spSctRxlsM4Q8HSh4h0QoKP6pPsI/AWqKPA=;
  b=NfEfCw519xVABgctiB5wNZzzf+z69A0Au6zdrJIkIK3aVht/s+wCPa4e
   3DkKSoGCH05gp5v9TZHcBgJc2bDur7yU3MpoG9TonriovcSpXM+ciyhsE
   7W78ffG60VSpfzek3otSqQjRDG4P1wDfXBBhmziy/pgtsD/NLzxNgXHF3
   PZ59ZhRcRazaXALQdvytS3vvot8VLO9at0IPtz6n1QfkAzG1C1wXncL02
   kdGC8NDAwZvA1POGQhsAJhfvswYsR3Ty/LXa7fZ0OB0wtzBsOfVtvJTVF
   5TeYtnJ2z53hqUMSLdbejGVEZmoBIKRqMTvSMsufVfgIgdkrMe2VkNwvt
   w==;
X-CSE-ConnectionGUID: 97QzFnPhQBaSW9/QjvCWmA==
X-CSE-MsgGUID: e0lyFie6TbOIjZWemE0h/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="86775368"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="86775368"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2025 05:38:05 -0700
X-CSE-ConnectionGUID: J+BcHAqoQ+6n4LIJV6Hu8w==
X-CSE-MsgGUID: 3e8t3BgHTfyFhNIz9v7dGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; 
   d="scan'208";a="178401125"
Received: from igk-lkp-server01.igk.intel.com (HELO 0e586ad5e7f7) ([10.91.175.65])
  by fmviesa008.fm.intel.com with ESMTP; 28 Sep 2025 05:38:04 -0700
Received: from kbuild by 0e586ad5e7f7 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1v2qfC-000000005eP-0iF5;
	Sun, 28 Sep 2025 12:38:02 +0000
Date: Sun, 28 Sep 2025 14:37:13 +0200
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>
Subject: [rafael-pm:bleeding-edge 205/213] warning: casting to the same type
 is unnecessary (`u32` -> `u32`)
Message-ID: <202509281454.ZTmjIs2S-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   11c0c0dd019710f162cd5d246a4efdbaefdac48b
commit: a11d30de57e312687d103e243f0ce6461ad9a5c0 [205/213] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20250928/202509281454.ZTmjIs2S-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
rustc: rustc 1.88.0 (6b00bc388 2025-06-23)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250928/202509281454.ZTmjIs2S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509281454.ZTmjIs2S-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: casting to the same type is unnecessary (`u32` -> `u32`)
   --> rust/kernel/cpufreq.rs:43:9
   |
   43 |         bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS as u32;
   |         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ help: try: `bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS`
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#unnecessary_cast
   = note: `-W clippy::unnecessary-cast` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::unnecessary_cast)]`

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

