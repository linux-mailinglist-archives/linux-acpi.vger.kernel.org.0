Return-Path: <linux-acpi+bounces-21328-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKNvCDM6qGkTqgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21328-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 14:57:07 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BCC200D2F
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 14:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72A653177235
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FC3A2548;
	Wed,  4 Mar 2026 13:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cTQetd8D"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099792848A0;
	Wed,  4 Mar 2026 13:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632237; cv=none; b=Q4I5GR5AkJVz5mDl1eNdJOsX0cQoWsGjmdT419PkdCFlCLvSmyDzOxIpA/hA+2Bxt15VxfmeMmPhzCAb/1x/wc+YJcZiUxmX3WgEQ45nyv1j6Gm5aYn+m264wGlNN6R/sCO1K2ktAuF2x2AN4bk1BnqOCNsrXs+hnBFPzM++3pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632237; c=relaxed/simple;
	bh=VPIbwl7qvJoAZJvI2vTr8h/by7c54vjlTr/7L55yv/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHBJkhwoV5VXnzEftrOR426oVwz2v4D2teuG3OiiFqNQ6uxODSsX4UvJi3G9ISGk4rU9gNoOSgyHmqQ909K3EYESHRj+AVXK28y2ZKfmhFCTETi9pRUvrOOfHD6LbXI0uMlqmakMEh8kHFpRjujwQl5BTUwai0piJH/HI7F2po8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cTQetd8D; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772632236; x=1804168236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VPIbwl7qvJoAZJvI2vTr8h/by7c54vjlTr/7L55yv/k=;
  b=cTQetd8Dy6rnOxQFpvWa3aoTrOD2TeFmZOWreSDXvf31MbdFrzQ0Udaz
   Cs00Zz/9qADwpa6BT6x4DBe6VKe9gbbMHPbf1uQctf03NeHCaLPDgOgK0
   fnGdF4+HbqnUyq4La6xI0tRzU39lZS21YnxJrv5NB8/gBwDyMpnqWTyQ6
   ciFutJc2Dts2KXYjaEa/bXqUaIaYaNNdROV6Z4O6ekB7HKFxwQP9TsbFG
   0CCbZQV1SpyMCoh0jWQFxcY/o9qOZRl6c93mAI8VcSuZyBsfk9SU2v545
   pE/jnUxDBkUDxeCfkJsU+7hmBmaZlvIvtlfNW8x/hdFH7sCCyBsje4+S/
   g==;
X-CSE-ConnectionGUID: ZfVBw0aTQteKHEoli5CmXA==
X-CSE-MsgGUID: jEnteu+wS3usO9RYm4jysA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72716445"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72716445"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 05:50:33 -0800
X-CSE-ConnectionGUID: IQyLqEp1QnC3Gzcds3GumQ==
X-CSE-MsgGUID: 6O0J0BxeQHqLkHzS6cSrEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="217502196"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa006.jf.intel.com with ESMTP; 04 Mar 2026 05:50:31 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxmcN-000000001iP-2nrn;
	Wed, 04 Mar 2026 13:50:27 +0000
Date: Wed, 4 Mar 2026 14:50:08 +0100
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
Message-ID: <202603041459.Mw33vD7S-lkp@intel.com>
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
X-Rspamd-Queue-Id: 80BCC200D2F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21328-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,01.org:url]
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
config: i386-randconfig-2006-20250804 (https://download.01.org/0day-ci/archive/20260304/202603041459.Mw33vD7S-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041459.Mw33vD7S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041459.Mw33vD7S-lkp@intel.com/

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

