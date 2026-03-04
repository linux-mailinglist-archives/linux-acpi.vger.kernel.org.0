Return-Path: <linux-acpi+bounces-21330-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLfpIZNOqGmvsgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21330-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 16:24:03 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25F20295B
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 144973003820
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 15:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D612126ED4F;
	Wed,  4 Mar 2026 15:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijg9bGZ2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9613B15539A;
	Wed,  4 Mar 2026 15:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772637157; cv=none; b=KORPrjYno4Mj0GMSS3SYj+V7qzzSBN2gRW4fcFgoGvq5VExp8SyaWXAfTt/8jkH4BhPmRU2abcA9LNdpk2GLDIKaU4+2YcCnNaC/ZxWBQ+72aW/corR5/HoRrH5I8Q7G3XCgg9S4l0yL2h3PHOGaJLPBUEAoesV3mXuNFVQOihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772637157; c=relaxed/simple;
	bh=j0cB9JI/3pBFDaTTSPAGIi8TfsKNqQ/pygSAUVmpmsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZxzM6hcxrVlE/xN5IbgnBoCFotaXyuOvTShpUSi6FHCRidEvdESKptaqAuydY6BOmmrlEZbTkey5UZzTnq+aAhNpdFCxjvWSGoXLavDdGLYdUyKqpz367tRUXMCivlQZJOq5RDUWNbrHR5d9+MmJli79LHpP+WlD9Aiq718//Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijg9bGZ2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772637154; x=1804173154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j0cB9JI/3pBFDaTTSPAGIi8TfsKNqQ/pygSAUVmpmsk=;
  b=ijg9bGZ2K4fYosLgsvgaPORz2/JLzfWF0ndocfRtaZSgclJH2k7wXAyr
   lBQN5K9sgNOJAFxnXZaBXjPkVNS4Ra0eDeO8Ei2rld0H4Kvp+qrN8EzyV
   BfzZppxkBBoZr6TAL9HNsBxB/GKjve7UZOf+N/NzUYo3Yv8Go/4VRlpUO
   rP2w6PTPToMcS1gFcvl84vEVImyrG5tz07b8k5BwyZs5bf5a9QZlLPIer
   cBpLYVjtQNJ8LqwBxvvvCTGZc+fCfY7motfUnWC8GdVnHQHn49z9Hu/te
   i+SGTCb9E5Z1bEsRie7JarcBd42kKiL2LW7CiMgDSgLRuZJK/kj+bZz+C
   A==;
X-CSE-ConnectionGUID: X4sMt7YwSRC9fOATwyHorQ==
X-CSE-MsgGUID: V1HIvr8LRd6aWDZOQBOgHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77569654"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="77569654"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 07:12:34 -0800
X-CSE-ConnectionGUID: HlA1aqOrRL+e2MqcXgKEnw==
X-CSE-MsgGUID: xKpDG5G4QoOsVnZC7XVPLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="223345674"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 04 Mar 2026 07:12:31 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxntk-000000001jd-2ZgE;
	Wed, 04 Mar 2026 15:12:28 +0000
Date: Wed, 4 Mar 2026 16:11:44 +0100
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
Message-ID: <202603041621.Ykqrqowb-lkp@intel.com>
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
X-Rspamd-Queue-Id: 8E25F20295B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21330-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,git-scm.com:url,intel.com:dkim,intel.com:email,intel.com:mid]
X-Rspamd-Action: no action

Hi Haifeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge cxl/next tip/x86/mm linus/master v7.0-rc2 next-20260303]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haifeng-Xu/ACPI-add-a-boot-parameter-to-disable-parsing-CFMWS-during-NUMA-init/20260304-160933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260304080647.169434-1-haifeng.xu%40shopee.com
patch subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260304/202603041621.Ykqrqowb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041621.Ykqrqowb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041621.Ykqrqowb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/numa/srat.c:323:12: warning: no previous prototype for 'cfmws_disabled' [-Wmissing-prototypes]
     323 | int __init cfmws_disabled(void)
         |            ^~~~~~~~~~~~~~


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

