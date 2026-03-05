Return-Path: <linux-acpi+bounces-21443-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL6bOHrlqWl+HQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21443-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:20:10 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 669DB21819E
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCB09305E33C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498DD328B7B;
	Thu,  5 Mar 2026 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oGNlDZ0V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3853B32D7FB;
	Thu,  5 Mar 2026 20:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742007; cv=none; b=C5XjvDe0+r85A1Oq4KaEYxkoXMbaxCQRVgi5jmlKiku+jlNLWpMO9h83GgDNA05PAwP7ZkJSz3gVOsmCBH7oY8Ktl0Y8GLbok4NitP6zlQ9aYrtfTcYzmQtWIEDM0jD6OHCf/s7vUJ5PQ/16jKDaoSsIQVCkuvoWCQkerjou+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742007; c=relaxed/simple;
	bh=b/aA0R2rkxsvdEpn9luZz6MliKLYCgptFmRmP/LpAyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucsuco0LZ4GUEx0ww2pc04VMEJNdUldLnb2XUTsQAd/Cba8RLutL+l3v1B5kkwJmGIgciU3O8GgQZ4p9+TJUoX145rgs8J6lHAz73SKg0k4JIS237gSNG6syZpWtgHwrFSz8L2n12qDBRgi9qhhQHXyXKyMvvNSenog4G4oJZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oGNlDZ0V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772742005; x=1804278005;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/aA0R2rkxsvdEpn9luZz6MliKLYCgptFmRmP/LpAyE=;
  b=oGNlDZ0VZ6ExuyRYK/jOCUuOiE30iZBHGU62TkxbpNirbDjdLjfC1vRX
   XcAMwb8JMrr2g3EGreBunnUT6d30SuY2BCxhizWXm5c8IO6lagAo2Wtht
   BPogSNljyF1dwlmSDZUFa0JXRF+PcYZcI55ufoQfW6QfunidVDQM+iCRC
   ucCQFYkrEhfT898j/1+ABQe0aVwj6Unaem3ll0qNCi3TDKYuGGxFzy8jm
   oJE5hkURgB0mzuHeJexw8kh1ZhRqKkgjaWHUBdNsyZFK3DBVhiBXftHBl
   Bh8hzS/LR+LOnvmwUcpMGH3asEP3fsQRhVBs0RyX5hMLJ9Pwa7z5jwtSg
   Q==;
X-CSE-ConnectionGUID: OH/OeSmgQBmxFx8p2VWZFA==
X-CSE-MsgGUID: TC44z7LuRoGuSHyG2bQBVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11720"; a="77714596"
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="77714596"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 12:20:04 -0800
X-CSE-ConnectionGUID: bC/qC8JjSe6l4ckthTlsNA==
X-CSE-MsgGUID: rwuba9+YRKeSqiYME3ysFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,103,1770624000"; 
   d="scan'208";a="218776277"
Received: from lkp-server01.sh.intel.com (HELO cadc4577a874) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Mar 2026 12:20:01 -0800
Received: from kbuild by cadc4577a874 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyFAr-000000001Bu-1fKc;
	Thu, 05 Mar 2026 20:19:57 +0000
Date: Fri, 6 Mar 2026 04:19:09 +0800
From: kernel test robot <lkp@intel.com>
To: Haifeng Xu <haifeng.xu@shopee.com>, rafael@kernel.org, lenb@kernel.org,
	dan.j.williams@intel.com, jonathan.cameron@huawei.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, dave@stgolabs.net,
	dave.jiang@intel.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: Re: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS
 during NUMA init
Message-ID: <202603060405.6xBosunB-lkp@intel.com>
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
X-Rspamd-Queue-Id: 669DB21819E
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
	TAGGED_FROM(0.00)[bounces-21443-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260306/202603060405.6xBosunB-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260306/202603060405.6xBosunB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603060405.6xBosunB-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/numa/srat.c:323:12: warning: no previous prototype for function 'cfmws_disabled' [-Wmissing-prototypes]
     323 | int __init cfmws_disabled(void)
         |            ^
   drivers/acpi/numa/srat.c:323:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     323 | int __init cfmws_disabled(void)
         | ^
         | static 
   1 warning generated.


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

