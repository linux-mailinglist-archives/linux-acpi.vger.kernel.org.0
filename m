Return-Path: <linux-acpi+bounces-21359-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mM6xDxq+qGmXwwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21359-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:19:54 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA51208ECE
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 00:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 986133018C34
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 23:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5844192D97;
	Wed,  4 Mar 2026 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NZpKkk5S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC2481B1;
	Wed,  4 Mar 2026 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772666389; cv=none; b=CGt1LLJnoXwd9U36ZFFnY6FxRuMd8xnEz8Y73m7b70tFsFvhG0qiWiD6pJEg2637ASOxu9X91nvVaKTYZnrmHFlIukhH2Ft6JVnXog1U1PuVbWuuTtFiWlGKrMcoS7A/g0bmJcPJNjz+aHU3s0L6iJwWRIAMBWoeE9sw+fr/ulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772666389; c=relaxed/simple;
	bh=bcqb7+4Nl2dEF2pVEob9OM4sCf3lXXZ7uBV46iRTyjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQYsANYOQqyTmXKJ4paef2t4OiWVoNrMStlmHW/E0g7cSx1ZgE3Cwddq6xXYm13U2XYxkG3ApSZzjfFve8QiSKMkqQ8rDUOxZlI+FIrfPwgyURRBxMxwYiGIuzM9D/Jj4GoEVIiqGYueUWTriLrta3YZAp6eGRNRWTJ9lweQbIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NZpKkk5S; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772666386; x=1804202386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bcqb7+4Nl2dEF2pVEob9OM4sCf3lXXZ7uBV46iRTyjc=;
  b=NZpKkk5SC2aAHiW0hIpuw8HFbWnmdzRUiLnuUEhIHXL9z/mgqey4qDF4
   0dZ2nK1USQH5ZByqZgpshjti1upRE/HqbhAQNVc48TR8N0aYbCtrz/kMw
   T4c2H5zH86pmPACyrzNoOK2jC4rTyc9jVK+/BvTQvnDSC3GQ6wD434KfW
   Zo/1PHuXqoedPxiVyvsu6meXzDAEiE7KFJPNpptFuPE4xEjhnJOGU/8jb
   NE7dmwzXd7/hfn2V04gdjWOXL1bADLQ55SXDxN6Wra6pJpDcjokBTfzsJ
   C7AKGK4090wfghWk/eugeWli8aX0KLYaFfE79mx9dneQ/4dyhCXtxmEvt
   w==;
X-CSE-ConnectionGUID: 88iUueHrTxisYOddFxpJnQ==
X-CSE-MsgGUID: prAJXIgIRW+M/6Gy4kypKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73649268"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="73649268"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:19:45 -0800
X-CSE-ConnectionGUID: 0b0UzEUCRhyaKCw7/s+V5A==
X-CSE-MsgGUID: YtNESRb3S9K7ARbWcgyH5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="245061401"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 Mar 2026 15:19:42 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxvVD-000000004fd-0K0L;
	Wed, 04 Mar 2026 23:19:39 +0000
Date: Thu, 5 Mar 2026 07:18:49 +0800
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
Message-ID: <202603050711.whqDobKh-lkp@intel.com>
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
X-Rspamd-Queue-Id: AAA51208ECE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21359-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[git-scm.com:url,01.org:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Chengwen,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v7.0-rc2 next-20260304]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-get-cpu-steer-tag-fail-on-ARM64-platform/20260303-084305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260303003625.39035-1-fengchengwen%40huawei.com
patch subject: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
config: x86_64-randconfig-r072-20260305 (https://download.01.org/0day-ci/archive/20260305/202603050711.whqDobKh-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050711.whqDobKh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050711.whqDobKh-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/acpi/processor_core.c: In function 'acpi_get_cpu_acpi_id':
>> drivers/acpi/processor_core.c:344:16: error: implicit declaration of function 'cpu_acpi_id' [-Wimplicit-function-declaration]
     344 |         return cpu_acpi_id(cpu);
         |                ^~~~~~~~~~~


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

