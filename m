Return-Path: <linux-acpi+bounces-21382-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLaNJLTcqGnGxwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21382-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:30:28 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26987209D45
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 02:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3756304EEC9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 01:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5E2459CF;
	Thu,  5 Mar 2026 01:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OypenRTl"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA04B1E1E16;
	Thu,  5 Mar 2026 01:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674204; cv=none; b=l2UJ3UlY5BYxW4ieO2cQvkow2ToRhm34odEluQw5p9h5jCzst9RYx7GbPcw4rkf0e42+/Icitz4DDeD4uEagK87zlj6/CgnrHlwlRNz5B2LooNClM+ZSJ89SOw5V+EnjgIeR1XDf8BC6jejHgKvAuLps3xI+uZUvX8j1xZMrlR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674204; c=relaxed/simple;
	bh=oNU/jaVVUf/SRNVN4crRULN++oHkeGDmQU+FnUaIOCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyyHvKmf4I10TR4WPqyZ7jZfYPi62qcXmng/YhhVdpjer5z/wF+Wl9aKBGFv4GE0rdsVc+tGwwF7Mxxsx8eqjhpsTdhJz29tO0KN+rPVEsdu6/otSnE1qx1T5F/fNc2zuhB5bwWG/yfHYhakXAtcnGNFB8VpntGotxszWdkw0js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OypenRTl; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772674203; x=1804210203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oNU/jaVVUf/SRNVN4crRULN++oHkeGDmQU+FnUaIOCo=;
  b=OypenRTlTYeP51hzCX4N9mCrbiZAwM8dFqec3rLzrSAFmawoW1YXQwhx
   jxdYPjXu4rwxlfTEfoqxEUIERDBWKbXkDOPdJIbL0yhQ9+rIjZ+OpkDge
   mPxLN0c1d1xlgcpwdEr21/USkhOue0iRNzJTS3KjFjsjU6KirF/Iu8YQq
   kY6bni6o61k+Vhy3QwScy/oFFoic8xxSyRabI/dsC8ZcrToUlHrtpx75x
   hcK3VOPcb9wZgqNl49mfpkD9N0HFQ/3p9LNlZRumyZ0z11en8tUQjV01J
   fXmavEunI5mGmtdPUSycy7qA9fS9XvahZMYQtbc1pcs3roPD1BnQC5c6y
   A==;
X-CSE-ConnectionGUID: h64QWw5LTAWnuuZ6Hsydbw==
X-CSE-MsgGUID: IgYYbAezRfy09DqTJnUmpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61324294"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="61324294"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 17:30:02 -0800
X-CSE-ConnectionGUID: ApuRj/gDTbm8wBpDlrHS9Q==
X-CSE-MsgGUID: dUdZd7y+RDSoxwR4pi0CbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215391454"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 04 Mar 2026 17:29:58 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxxXI-000000004wH-0Oif;
	Thu, 05 Mar 2026 01:29:56 +0000
Date: Thu, 5 Mar 2026 09:29:03 +0800
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
Message-ID: <202603050927.IVSflNry-lkp@intel.com>
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
X-Rspamd-Queue-Id: 26987209D45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21382-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Action: no action

Hi Chengwen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus rafael-pm/linux-next rafael-pm/bleeding-edge linus/master v7.0-rc2 next-20260303]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chengwen-Feng/PCI-TPH-Fix-get-cpu-steer-tag-fail-on-ARM64-platform/20260303-084305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20260303003625.39035-1-fengchengwen%40huawei.com
patch subject: [PATCH] PCI/TPH: Fix get cpu steer-tag fail on ARM64 platform
config: loongarch-randconfig-002-20260305 (https://download.01.org/0day-ci/archive/20260305/202603050927.IVSflNry-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050927.IVSflNry-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050927.IVSflNry-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/tph.c:92:20: warning: 'tph_invoke_dsm' defined but not used [-Wunused-function]
      92 | static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
         |                    ^~~~~~~~~~~~~~
>> drivers/pci/tph.c:56:12: warning: 'tph_extract_tag' defined but not used [-Wunused-function]
      56 | static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
         |            ^~~~~~~~~~~~~~~


vim +/tph_invoke_dsm +92 drivers/pci/tph.c

d2e8a34876ce69b Wei Huang 2024-10-02   55  
d2e8a34876ce69b Wei Huang 2024-10-02  @56  static u16 tph_extract_tag(enum tph_mem_type mem_type, u8 req_type,
d2e8a34876ce69b Wei Huang 2024-10-02   57  			   union st_info *info)
d2e8a34876ce69b Wei Huang 2024-10-02   58  {
d2e8a34876ce69b Wei Huang 2024-10-02   59  	switch (req_type) {
d2e8a34876ce69b Wei Huang 2024-10-02   60  	case PCI_TPH_REQ_TPH_ONLY: /* 8-bit tag */
d2e8a34876ce69b Wei Huang 2024-10-02   61  		switch (mem_type) {
d2e8a34876ce69b Wei Huang 2024-10-02   62  		case TPH_MEM_TYPE_VM:
d2e8a34876ce69b Wei Huang 2024-10-02   63  			if (info->vm_st_valid)
d2e8a34876ce69b Wei Huang 2024-10-02   64  				return info->vm_st;
d2e8a34876ce69b Wei Huang 2024-10-02   65  			break;
d2e8a34876ce69b Wei Huang 2024-10-02   66  		case TPH_MEM_TYPE_PM:
d2e8a34876ce69b Wei Huang 2024-10-02   67  			if (info->pm_st_valid)
d2e8a34876ce69b Wei Huang 2024-10-02   68  				return info->pm_st;
d2e8a34876ce69b Wei Huang 2024-10-02   69  			break;
d2e8a34876ce69b Wei Huang 2024-10-02   70  		}
d2e8a34876ce69b Wei Huang 2024-10-02   71  		break;
d2e8a34876ce69b Wei Huang 2024-10-02   72  	case PCI_TPH_REQ_EXT_TPH: /* 16-bit tag */
d2e8a34876ce69b Wei Huang 2024-10-02   73  		switch (mem_type) {
d2e8a34876ce69b Wei Huang 2024-10-02   74  		case TPH_MEM_TYPE_VM:
d2e8a34876ce69b Wei Huang 2024-10-02   75  			if (info->vm_xst_valid)
d2e8a34876ce69b Wei Huang 2024-10-02   76  				return info->vm_xst;
d2e8a34876ce69b Wei Huang 2024-10-02   77  			break;
d2e8a34876ce69b Wei Huang 2024-10-02   78  		case TPH_MEM_TYPE_PM:
d2e8a34876ce69b Wei Huang 2024-10-02   79  			if (info->pm_xst_valid)
d2e8a34876ce69b Wei Huang 2024-10-02   80  				return info->pm_xst;
d2e8a34876ce69b Wei Huang 2024-10-02   81  			break;
d2e8a34876ce69b Wei Huang 2024-10-02   82  		}
d2e8a34876ce69b Wei Huang 2024-10-02   83  		break;
d2e8a34876ce69b Wei Huang 2024-10-02   84  	default:
d2e8a34876ce69b Wei Huang 2024-10-02   85  		return 0;
d2e8a34876ce69b Wei Huang 2024-10-02   86  	}
d2e8a34876ce69b Wei Huang 2024-10-02   87  
d2e8a34876ce69b Wei Huang 2024-10-02   88  	return 0;
d2e8a34876ce69b Wei Huang 2024-10-02   89  }
d2e8a34876ce69b Wei Huang 2024-10-02   90  
d2e8a34876ce69b Wei Huang 2024-10-02   91  #define TPH_ST_DSM_FUNC_INDEX	0xF
d2e8a34876ce69b Wei Huang 2024-10-02  @92  static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
d2e8a34876ce69b Wei Huang 2024-10-02   93  				  union st_info *st_out)
d2e8a34876ce69b Wei Huang 2024-10-02   94  {
d2e8a34876ce69b Wei Huang 2024-10-02   95  	union acpi_object arg3[3], in_obj, *out_obj;
d2e8a34876ce69b Wei Huang 2024-10-02   96  
d2e8a34876ce69b Wei Huang 2024-10-02   97  	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 7,
d2e8a34876ce69b Wei Huang 2024-10-02   98  			    BIT(TPH_ST_DSM_FUNC_INDEX)))
d2e8a34876ce69b Wei Huang 2024-10-02   99  		return AE_ERROR;
d2e8a34876ce69b Wei Huang 2024-10-02  100  
d2e8a34876ce69b Wei Huang 2024-10-02  101  	/* DWORD: feature ID (0 for processor cache ST query) */
d2e8a34876ce69b Wei Huang 2024-10-02  102  	arg3[0].integer.type = ACPI_TYPE_INTEGER;
d2e8a34876ce69b Wei Huang 2024-10-02  103  	arg3[0].integer.value = 0;
d2e8a34876ce69b Wei Huang 2024-10-02  104  
d2e8a34876ce69b Wei Huang 2024-10-02  105  	/* DWORD: target UID */
d2e8a34876ce69b Wei Huang 2024-10-02  106  	arg3[1].integer.type = ACPI_TYPE_INTEGER;
d2e8a34876ce69b Wei Huang 2024-10-02  107  	arg3[1].integer.value = cpu_uid;
d2e8a34876ce69b Wei Huang 2024-10-02  108  
d2e8a34876ce69b Wei Huang 2024-10-02  109  	/* QWORD: properties, all 0's */
d2e8a34876ce69b Wei Huang 2024-10-02  110  	arg3[2].integer.type = ACPI_TYPE_INTEGER;
d2e8a34876ce69b Wei Huang 2024-10-02  111  	arg3[2].integer.value = 0;
d2e8a34876ce69b Wei Huang 2024-10-02  112  
d2e8a34876ce69b Wei Huang 2024-10-02  113  	in_obj.type = ACPI_TYPE_PACKAGE;
d2e8a34876ce69b Wei Huang 2024-10-02  114  	in_obj.package.count = ARRAY_SIZE(arg3);
d2e8a34876ce69b Wei Huang 2024-10-02  115  	in_obj.package.elements = arg3;
d2e8a34876ce69b Wei Huang 2024-10-02  116  
d2e8a34876ce69b Wei Huang 2024-10-02  117  	out_obj = acpi_evaluate_dsm(handle, &pci_acpi_dsm_guid, 7,
d2e8a34876ce69b Wei Huang 2024-10-02  118  				    TPH_ST_DSM_FUNC_INDEX, &in_obj);
d2e8a34876ce69b Wei Huang 2024-10-02  119  	if (!out_obj)
d2e8a34876ce69b Wei Huang 2024-10-02  120  		return AE_ERROR;
d2e8a34876ce69b Wei Huang 2024-10-02  121  
d2e8a34876ce69b Wei Huang 2024-10-02  122  	if (out_obj->type != ACPI_TYPE_BUFFER) {
d2e8a34876ce69b Wei Huang 2024-10-02  123  		ACPI_FREE(out_obj);
d2e8a34876ce69b Wei Huang 2024-10-02  124  		return AE_ERROR;
d2e8a34876ce69b Wei Huang 2024-10-02  125  	}
d2e8a34876ce69b Wei Huang 2024-10-02  126  
d2e8a34876ce69b Wei Huang 2024-10-02  127  	st_out->value = *((u64 *)(out_obj->buffer.pointer));
d2e8a34876ce69b Wei Huang 2024-10-02  128  
d2e8a34876ce69b Wei Huang 2024-10-02  129  	ACPI_FREE(out_obj);
d2e8a34876ce69b Wei Huang 2024-10-02  130  
d2e8a34876ce69b Wei Huang 2024-10-02  131  	return AE_OK;
d2e8a34876ce69b Wei Huang 2024-10-02  132  }
d2e8a34876ce69b Wei Huang 2024-10-02  133  #endif
d2e8a34876ce69b Wei Huang 2024-10-02  134  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

