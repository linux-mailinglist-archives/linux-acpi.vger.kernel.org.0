Return-Path: <linux-acpi+bounces-21373-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LvkHzHIqGnhxAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21373-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:02:57 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8355420952E
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 01:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7CACC300BE3C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 00:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3AB42AA9;
	Thu,  5 Mar 2026 00:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WOwpa454"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAA70809;
	Thu,  5 Mar 2026 00:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772668972; cv=none; b=IZxgGTsuI2RN5sPdu2BHmP+zkyZGV8sNObbPa2S5ugrIirdy/Q5I3Kc6V4l0WUUhW8W/53cJBpcPcDAdtXVJ3NW2Hlb37E+KuFiup7ofo1URzrjCuBA/CI4LI4NJ6x6nyHWgxW7wWm9HQtj5wHmMR4lh6/unRlAe18vYlFhTCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772668972; c=relaxed/simple;
	bh=EvNQexAL85C3eOmkJAT7oc88RZq8E/bM2KOB2OJFNHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUk3yaoWACF7XtdHIZvY19n6PngJys/ymlMnENQUOQUFLNQz5ChM55T7auwtNGtFllZJchTuiFrAj/83rUcMhCg7wVvq1A0w/hX0gfv8/xM3dPLcaaJvyBccLuRihXauidKM/eTmXZlZWxHwXlsT6U8Adc272g8qK8UJcpcGJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WOwpa454; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772668968; x=1804204968;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EvNQexAL85C3eOmkJAT7oc88RZq8E/bM2KOB2OJFNHg=;
  b=WOwpa454B5RHJ3uaU4MqAO9F2p+6w/w5+rGxDpyY239N//KerXtPN6Js
   sLsJ80bxPHSlJJ45hNnv6i7/PZAmWbOnQdLjmbm+a71IJ8VCV66vC1vBN
   9Pi9tDzp6a39rVPjRR3ATGMbfkXPIcbzejNzLCsBN0KyUh/RDl6xAyGYQ
   VEyFdxs/Kl+59/pVBzf7GkTgbtfABif0ApDDItuo2K89Wnwyd9nls9mfo
   cGw/WVTP4L06M2HAoBG8NusapOPURIHK7eekbK7de7HOPtd6VRxJcnRmS
   3BQc4+kly/HNG62rqRXzFMh9Dz2qQ8+9YoJilOQslBSXe8UwNJ6d+iEIL
   Q==;
X-CSE-ConnectionGUID: 80RgpuyUQHKEqZnoNlmXnQ==
X-CSE-MsgGUID: lUAWLn5NTvmGQI1GwUS98A==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="76348793"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="76348793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:02:48 -0800
X-CSE-ConnectionGUID: tV70856wTSC3HyuYjAzjVg==
X-CSE-MsgGUID: oX55X8+ASqCsAM1tVN4aoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="256382620"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2026 16:02:44 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxwAr-000000004j3-1cRe;
	Thu, 05 Mar 2026 00:02:41 +0000
Date: Thu, 5 Mar 2026 08:02:18 +0800
From: kernel test robot <lkp@intel.com>
To: Chengwen Feng <fengchengwen@huawei.com>, linux-pci@vger.kernel.org,
	bhelgaas@google.com
Cc: oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
	rafael@kernel.org, lenb@kernel.org, wei.huang2@amd.com,
	Eric.VanTassell@amd.com, jonathan.cameron@huawei.com,
	wangzhou1@hisilicon.com, wanghuiqiang@huawei.com,
	liuyonglong@huawei.com, Chengwen Feng <fengchengwen@huawei.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
Message-ID: <202603050748.kO9QwTCh-lkp@intel.com>
References: <20260303003625.39035-1-fengchengwen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303003625.39035-1-fengchengwen@huawei.com>
X-Rspamd-Queue-Id: 8355420952E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21373-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,01.org:url,git-scm.com:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Chengwen,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v7.0-rc2 next-20260303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-get-cpu-steer-tag-fail-on-ARM64-platform/20260303-084305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260303003625.39035-1-fengchengwen%40huawei.com
patch subject: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
config: i386-randconfig-141-20260305 (https://download.01.org/0day-ci/archive/20260305/202603050748.kO9QwTCh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050748.kO9QwTCh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050748.kO9QwTCh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/processor_core.c:344:9: error: call to undeclared function 'cpu_acpi_id'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     344 |         return cpu_acpi_id(cpu);
         |                ^
   1 error generated.


vim +/cpu_acpi_id +344 drivers/acpi/processor_core.c

   337	
   338	#ifdef CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API
   339	unsigned int acpi_get_cpu_acpi_id(unsigned int cpu)
   340	{
   341		if (cpu >= nr_cpu_ids)
   342			return 0;
   343	#ifdef CONFIG_X86
 > 344		return cpu_acpi_id(cpu);
   345	#elif CONFIG_ARM64
   346		return get_acpi_id_for_cpu(cpu);
   347	#endif
   348	}
   349	#endif /* CONFIG_ARCH_HAS_GET_CPU_ACPI_ID_API */
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

