Return-Path: <linux-acpi+bounces-5437-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3220D8B43FB
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 05:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF87A28315A
	for <lists+linux-acpi@lfdr.de>; Sat, 27 Apr 2024 03:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898D13BBED;
	Sat, 27 Apr 2024 03:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EYPzr60M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308D3BBEC;
	Sat, 27 Apr 2024 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714189648; cv=none; b=tE5V94cWNzd+FbwckIXMSwlj5TEKOd8qijIfCsKHVP57O19P2tsU914RoIcoY3Acr8bSCFLEJZuxxBKGVqlKhyeJ6Ph9VW+e3jEIc7+fLAcL2xpqhG7Z+PTDj0bJDh6b2bk0IiWaG6iLqGGjSc6+mZOpzLOvdQsX4yhSZCNvQXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714189648; c=relaxed/simple;
	bh=Hci8UxeEl1DmkB61E3Z5Yin1Hdth1d+hleZAKN2chrw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fpXoxBToHgUBs32/y05QORtAEAxh49zeKw/IkWjlp7JVzq3UMAyjmeNwH5dAsFfY0VehNwgbwYtYZTUj/5tenmLBPjzDAhZCsaQSop2NmbRG52/bQyuop8BOaoAApfHlIeA5bpBHqZp6X5by5cPHx/V1LinrONX2Xpxg9W8v5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EYPzr60M; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714189645; x=1745725645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Hci8UxeEl1DmkB61E3Z5Yin1Hdth1d+hleZAKN2chrw=;
  b=EYPzr60MEc3hTXaXXjoYJn+Zoym1BxHy00f4w/OyjzxnTmt+mAwISJoR
   RLq1fOJgsrvSra9sRg2wy/b+Ni8syZ1E5Uf8PYNX60cDFVIp1zw5ozh8k
   6wBMQT6bo+x24k8q+YBvmnukTK+cR3ffwliMl+kHodhs37775tWg7Ltaa
   ePhztoCm2nE6Dpai+ytjKJfCfDOCuaJG19s6Yu4EXw/7H3KqODvf99Qqe
   GV5M0SKR3GC8Rj9RxviYQ4LQteZRw7eizXUMpLMLjqhJQ7nuNOFexXZfR
   uGtFofybL9LfpeIo3uMnxwjLzMItQRDuEUZ2dDC5VNIvthOfatxbiPFjx
   Q==;
X-CSE-ConnectionGUID: MvEspl0lTzWkAhSR1gnRHg==
X-CSE-MsgGUID: sI2ztvwfSfuLjvOzyKuHNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="20545857"
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="20545857"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 20:47:25 -0700
X-CSE-ConnectionGUID: 5T5vv9OpSs2omrdmY/ShbQ==
X-CSE-MsgGUID: FufmCqDuSHO0QVfWQUyB1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,234,1708416000"; 
   d="scan'208";a="25684067"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 26 Apr 2024 20:47:24 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s0Z20-0004d0-0j;
	Sat, 27 Apr 2024 03:47:20 +0000
Date: Sat, 27 Apr 2024 11:46:39 +0800
From: kernel test robot <lkp@intel.com>
To: Perry Yuan <perry.yuan@amd.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	devel@acpica.org, linux-pm@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-doc@vger.kernel.org
Subject: [rafael-pm:bleeding-edge 183/186] drivers/cpufreq/amd-pstate.c:760:
 warning: This comment starts with '/**', but isn't a kernel-doc comment.
 Refer Documentation/doc-guide/kernel-doc.rst
Message-ID: <202404271148.HK9yHBlB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   d9e98e7641ce1ef34d0c33dae1f27611bd1cbcf9
commit: 069a2bb8c48c43176f2f0e6cae5efe2f39f6bdf2 [183/186] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
config: i386-buildonly-randconfig-002-20240427 (https://download.01.org/0day-ci/archive/20240427/202404271148.HK9yHBlB-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240427/202404271148.HK9yHBlB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404271148.HK9yHBlB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/amd-pstate.c:760: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get pstate transition delay time from ACPI tables that firmware set
   drivers/cpufreq/amd-pstate.c:775: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get pstate transition latency value from ACPI tables that firmware
   drivers/cpufreq/amd-pstate.c:801: warning: Function parameter or struct member 'cpudata' not described in 'amd_pstate_init_freq'


vim +760 drivers/cpufreq/amd-pstate.c

   758	
   759	/**
 > 760	 * Get pstate transition delay time from ACPI tables that firmware set
   761	 * instead of using hardcode value directly.
   762	 */
   763	static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
   764	{
   765		u32 transition_delay_ns;
   766	
   767		transition_delay_ns = cppc_get_transition_latency(cpu);
   768		if (transition_delay_ns == CPUFREQ_ETERNAL)
   769			return AMD_PSTATE_TRANSITION_DELAY;
   770	
   771		return transition_delay_ns / NSEC_PER_USEC;
   772	}
   773	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

