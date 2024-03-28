Return-Path: <linux-acpi+bounces-4517-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5355E88FE7F
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 13:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E69511F24A75
	for <lists+linux-acpi@lfdr.de>; Thu, 28 Mar 2024 12:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE707EF1B;
	Thu, 28 Mar 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cE5JLRU1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7687E58F;
	Thu, 28 Mar 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627273; cv=none; b=a3KM/7/dSUYpGN8Gy8du9BOuKuf9W7BqEOnNqdose1PXSa79pc7Ff+gBvDydjictVa0t98qP8yAoY/2cwCJlxrJObB/o9tmNSiAAa1O4oHn1NdzE7lLTVwtkgznhVTfPiHGA0AumJFPpPI9lIe05wk+IMMyzdjDIexu4P4aDi2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627273; c=relaxed/simple;
	bh=nffDaJVrBNsyAnwZsAeZUbVZ9WuEdxBLqM6rPP+Bab8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jCb22dvozA52izJHpmH2DeCNLTt2AKnzCgvq6tBGy1CCsfhD58MOVfRdzMv6jd0Co+TfNB9AQ5cVUrr16S99hVY3Npi629M8/rHhKWbk9CVYMzIG6C3XYVyEtWggScsRlGApqrIGQ8FiE7o3snCbyLWNVFHTkoWIP1B/zmhKI1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cE5JLRU1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711627269; x=1743163269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nffDaJVrBNsyAnwZsAeZUbVZ9WuEdxBLqM6rPP+Bab8=;
  b=cE5JLRU1AVT2PXYUdBWc6Kg3aU5i/KW9EoQp4QPAJY7Mv+uF6Buco5Uy
   aK0HnXpYPXdnUPq3duRZ/U/A9nHlLiCHQI0zRxIgDEji3HlCKQif7gtTH
   Nndyp5kA0/VRhRcxccmhr3HdRGVNxV9BSfgpEJ3bbOWFSffXnyv+9FMdh
   mwkEDdGfxrhkL+F9SffG0+rA7Nl7FzpTVgtywWpjaf0B+uIKqhqXgW9IR
   GcDiIqIlcadnejjTnz1tlB/vkFdY6nx77OMeoMYc1m53UagTropynR/1M
   Yg33vu1yHYmOaor8DOQQl2QaguHlBbjVKkdSTXbnSMvolDXGbAlWhOHvQ
   g==;
X-CSE-ConnectionGUID: B0WzBu+/TvC/LOv/OBDDdQ==
X-CSE-MsgGUID: H5JrIp2RTGu2GDZqJrlOJg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="9731495"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="9731495"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 05:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="54073874"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 28 Mar 2024 05:01:06 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpoRM-00026w-0r;
	Thu, 28 Mar 2024 12:01:04 +0000
Date: Thu, 28 Mar 2024 20:00:40 +0800
From: kernel test robot <lkp@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-acpi@vger.kernel.org, devel@acpica.org,
	linux-pm@vger.kernel.org
Subject: [rafael-pm:intel_pstate-testing 4/14]
 drivers/cpufreq/intel_pstate.c:1655:25: warning: variable 'cpudata' is
 uninitialized when used here
Message-ID: <202403281955.LhZVDhXg-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git intel_pstate-testing
head:   16303764deedb814defe7e69712edec6a09b50ad
commit: ac9f58c46515ad482d972d5a65c127241c4751b9 [4/14] cpufreq: intel_pstate: Get rid of unnecessary READ_ONCE() annotations
config: x86_64-rhel-8.3-bpf (https://download.01.org/0day-ci/archive/20240328/202403281955.LhZVDhXg-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240328/202403281955.LhZVDhXg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403281955.LhZVDhXg-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/intel_pstate.c:1655:25: warning: variable 'cpudata' is uninitialized when used here [-Wuninitialized]
    1655 |         schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
         |                                ^~~~~~~
   drivers/cpufreq/intel_pstate.c:1639:25: note: initialize the variable 'cpudata' to silence this warning
    1639 |         struct cpudata *cpudata;
         |                                ^
         |                                 = NULL
   1 warning generated.


vim +/cpudata +1655 drivers/cpufreq/intel_pstate.c

57577c996d731c Srinivas Pandruvada 2021-09-28  1635  
57577c996d731c Srinivas Pandruvada 2021-09-28  1636  void notify_hwp_interrupt(void)
57577c996d731c Srinivas Pandruvada 2021-09-28  1637  {
57577c996d731c Srinivas Pandruvada 2021-09-28  1638  	unsigned int this_cpu = smp_processor_id();
57577c996d731c Srinivas Pandruvada 2021-09-28  1639  	struct cpudata *cpudata;
57577c996d731c Srinivas Pandruvada 2021-09-28  1640  	unsigned long flags;
57577c996d731c Srinivas Pandruvada 2021-09-28  1641  	u64 value;
57577c996d731c Srinivas Pandruvada 2021-09-28  1642  
ac9f58c46515ad Rafael J. Wysocki   2024-03-25  1643  	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
57577c996d731c Srinivas Pandruvada 2021-09-28  1644  		return;
57577c996d731c Srinivas Pandruvada 2021-09-28  1645  
57577c996d731c Srinivas Pandruvada 2021-09-28  1646  	rdmsrl_safe(MSR_HWP_STATUS, &value);
57577c996d731c Srinivas Pandruvada 2021-09-28  1647  	if (!(value & 0x01))
57577c996d731c Srinivas Pandruvada 2021-09-28  1648  		return;
57577c996d731c Srinivas Pandruvada 2021-09-28  1649  
57577c996d731c Srinivas Pandruvada 2021-09-28  1650  	spin_lock_irqsave(&hwp_notify_lock, flags);
57577c996d731c Srinivas Pandruvada 2021-09-28  1651  
57577c996d731c Srinivas Pandruvada 2021-09-28  1652  	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
57577c996d731c Srinivas Pandruvada 2021-09-28  1653  		goto ack_intr;
57577c996d731c Srinivas Pandruvada 2021-09-28  1654  
57577c996d731c Srinivas Pandruvada 2021-09-28 @1655  	schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
57577c996d731c Srinivas Pandruvada 2021-09-28  1656  
57577c996d731c Srinivas Pandruvada 2021-09-28  1657  	spin_unlock_irqrestore(&hwp_notify_lock, flags);
57577c996d731c Srinivas Pandruvada 2021-09-28  1658  
57577c996d731c Srinivas Pandruvada 2021-09-28  1659  	return;
57577c996d731c Srinivas Pandruvada 2021-09-28  1660  
57577c996d731c Srinivas Pandruvada 2021-09-28  1661  ack_intr:
57577c996d731c Srinivas Pandruvada 2021-09-28  1662  	wrmsrl_safe(MSR_HWP_STATUS, 0);
57577c996d731c Srinivas Pandruvada 2021-09-28  1663  	spin_unlock_irqrestore(&hwp_notify_lock, flags);
57577c996d731c Srinivas Pandruvada 2021-09-28  1664  }
57577c996d731c Srinivas Pandruvada 2021-09-28  1665  

:::::: The code at line 1655 was first introduced by commit
:::::: 57577c996d731ce1e5a4a488e64e6e201b360847 cpufreq: intel_pstate: Process HWP Guaranteed change notification

:::::: TO: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
:::::: CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

