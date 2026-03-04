Return-Path: <linux-acpi+bounces-21329-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLwABBlBqGn8rgAAu9opvQ
	(envelope-from <linux-acpi+bounces-21329-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 15:26:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06CB201688
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 15:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 834783075CD0
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 14:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7153B3BEF;
	Wed,  4 Mar 2026 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iT3l74AI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1645B3A5E6A;
	Wed,  4 Mar 2026 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772633495; cv=none; b=PrrV3TqEieR+SpX+ktQ4OOcY/f2T4n1sfhZ0z9pVkz7uoDBa0NvaECQDXVAM8gBcwX+y3teDfbu8KZtEo/yplFiL05MJ4kkyKLNo+rAqc86MQnbRX4lLfKfJNdCSuN+gT9dk5T9x5LoaH9yTu+FiIdv5TQPdmMv41c1gj83FWDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772633495; c=relaxed/simple;
	bh=Qhu/NXTZvVS1GxryVXLFlGmYcFLtCfndr8DGcuJYgYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu2oNfk4KiZx40r9QNneaWoqtuiSZaGtkeiLTQtL72c2k9ktiIBwZUeckfv3aL8kpa4w981Szpf8ohrZbvbcA/sEVW3itWcO7kMSyTyvCgQjA6R2jbt7pYe0Rx7t2dNIxoeNzkPWPGQQo5U8O72Oy/w5ZjPUijEA1l69FAgIEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iT3l74AI; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772633494; x=1804169494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qhu/NXTZvVS1GxryVXLFlGmYcFLtCfndr8DGcuJYgYI=;
  b=iT3l74AIHQfyfF0qxJE0kQz2lb/qodu9LAFqj96abaygr9qgUMoEcaXj
   Y/9BzWSoQ8ZZnEjao8iBhQtykDbwcODV+A5gX9XLbQ/B0BxEweBI86EIs
   yxqdvnmmGc6N0bJMDPMD1s4lTv6ymQ/QOe5S+nF9PK6Ii52Af3YQYh4+c
   mvbla1UATOn7Ndwl0KzAmtp8OKh9cv7Va47KxKis5f4r+EFWZdt+Z+/3O
   9bLn9P4tV2+YQ3wSNKARq7RhOXe2HvYMsbVUltyZsaIZowq14SuoHr0h5
   WXNc1Diktr5a6rRH1D9MuTA8dFVwhURjW2e0yxT0TfkoxwmBrXwcL6YZ1
   A==;
X-CSE-ConnectionGUID: ITquhhrlTAOMt9fJQcH5Tw==
X-CSE-MsgGUID: Ku+DrJ8/T4KWOv7mZwY1zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="72719120"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="72719120"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 06:11:34 -0800
X-CSE-ConnectionGUID: sn0c9hXNQyCVJos/qzygtA==
X-CSE-MsgGUID: deoFyIJNTl+N5bf243+/rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="218302275"
Received: from igk-lkp-server01.igk.intel.com (HELO 9958d990ccf2) ([10.211.93.152])
  by orviesa009.jf.intel.com with ESMTP; 04 Mar 2026 06:11:31 -0800
Received: from kbuild by 9958d990ccf2 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxmwh-000000001ir-4Afg;
	Wed, 04 Mar 2026 14:11:27 +0000
Date: Wed, 4 Mar 2026 15:10:46 +0100
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
Message-ID: <202603041550.t2wIMeDy-lkp@intel.com>
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
X-Rspamd-Queue-Id: A06CB201688
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
	TAGGED_FROM(0.00)[bounces-21329-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,intel.com:dkim,intel.com:email,intel.com:mid,git-scm.com:url]
X-Rspamd-Action: no action

Hi Haifeng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/bleeding-edge cxl/next tip/x86/mm linus/master v6.16-rc1 next-20260303]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haifeng-Xu/ACPI-add-a-boot-parameter-to-disable-parsing-CFMWS-during-NUMA-init/20260304-160933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260304080647.169434-1-haifeng.xu%40shopee.com
patch subject: [PATCH] ACPI: add a boot parameter to disable parsing CFMWS during NUMA init
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260304/202603041550.t2wIMeDy-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260304/202603041550.t2wIMeDy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603041550.t2wIMeDy-lkp@intel.com/

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

