Return-Path: <linux-acpi+bounces-21459-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qdSeFUsLqmnqKAEAu9opvQ
	(envelope-from <linux-acpi+bounces-21459-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:01:31 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 344B2219240
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 00:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14778301D97C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27C27AC54;
	Thu,  5 Mar 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W81u0WsB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296D189B84;
	Thu,  5 Mar 2026 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751688; cv=none; b=sLLBNv35dxkKT6+WypwKQXjeFWTtvkfTgw2+ABmq4jPPK8l3NU51ubR1phQbtWoIZn5m+ZtHWTy3Hgk0uKzVCiS+VYN56F4xrfF8YK1yNHE+5HXbwnvpgc1gdQ3xlAZsQk7zUCnI8jE4a3RhfUeUlQXO8wVqTyOMBhqhqVho6Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751688; c=relaxed/simple;
	bh=PHQYA+3ODj8Z0jhwDvxeCHGYytqRZCCsl9F3HYya9J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwqLl9paEN3qM02zjX3XZ4YwwiIsIXlmTCmSwOz3dI+aZwBDwR8/yrn71zTsBwkzz2T55JYyO2ngUvcvxalHjDVtYOC6jfa+ZkfPo9q4lpHbh3ckNSlwM3KkNj2hRfrCei9LKOUaNWHq6ng3oJRNWSY7t0h2577O7CpHSOgLgDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W81u0WsB; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772751686; x=1804287686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PHQYA+3ODj8Z0jhwDvxeCHGYytqRZCCsl9F3HYya9J4=;
  b=W81u0WsBzVd/r1u4mlmihcdb3EDDKjauPEbiungHh7XhOOty6VDhjYiB
   bFhhTtL06QoUywr1Yu5+1c79s6Q2rtnBMpI/boQEGbWGBdcNIkvJuMzCQ
   dBLIqUqVb7l1xkjiVko8I4TZxcRfqsZkujPgIJFcHqtD42SB2ypyU7it7
   G1jPeNarL39ZM3Q5b2uQBMxkZD5LV0A6Yp3W0hlWEHvvZc0IcDt1uIvH3
   t4/JbHrhV9W0z4/i7lW28L5tPop09/RSWeMjcSCjgUag3NjshiU5cVHqL
   WqozPAAK8/Z9Z4+58NmUiITipij/HHl2AYCAR5l+13FbuMAPBRy+o3Rxg
   Q==;
X-CSE-ConnectionGUID: xVOeLacBRTeD1P6HvJ9RYA==
X-CSE-MsgGUID: LGxbN0jsReuUQ1eOQaypzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="85203676"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="85203676"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 15:01:25 -0800
X-CSE-ConnectionGUID: MkLBjoWHTx2WDalC9yxBuA==
X-CSE-MsgGUID: BHdtxPvpQdyBhzegB1swIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="218777587"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 05 Mar 2026 15:01:22 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyHh0-00000000037-30Zz;
	Thu, 05 Mar 2026 23:01:18 +0000
Date: Fri, 6 Mar 2026 07:00:35 +0800
From: kernel test robot <lkp@intel.com>
To: Haifeng Xu <haifeng.xu@shopee.com>, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com
Cc: oe-kbuild-all@lists.linux.dev, dave@stgolabs.net, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Haifeng Xu <haifeng.xu@shopee.com>
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <202603060605.Fa8yGC4u-lkp@intel.com>
References: <20260304080647.169434-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304080647.169434-1-haifeng.xu@shopee.com>
X-Rspamd-Queue-Id: 344B2219240
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
	TAGGED_FROM(0.00)[bounces-21459-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,git-scm.com:url,01.org:url]
X-Rspamd-Action: no action

Hi Haifeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge cxl/next tip/x86/mm linus/master v7.0-rc2 next-20260305]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haifeng-Xu/ACPI-add-a-boot-parameter-to-disable-parsing-CFMWS-during-NUMA-init/20260304-160933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260304080647.169434-1-haifeng.xu%40shopee.com
patch subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
config: loongarch-randconfig-r134-20260306 (https://download.01.org/0day-ci/archive/20260306/202603060605.Fa8yGC4u-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060605.Fa8yGC4u-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060605.Fa8yGC4u-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/acpi/numa/srat.c:323:12: sparse: sparse: symbol 'cfmws_disabled' was not declared. Should it be static?

vim +/cfmws_disabled +323 drivers/acpi/numa/srat.c

   322	
 > 323	int __init cfmws_disabled(void)
   324	{
   325		return cfmws_numa < 0;
   326	}
   327	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

