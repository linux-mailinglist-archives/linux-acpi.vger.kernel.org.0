Return-Path: <linux-acpi+bounces-20023-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0152BD001D4
	for <lists+linux-acpi@lfdr.de>; Wed, 07 Jan 2026 22:14:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9033032A81
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Jan 2026 21:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C65F299944;
	Wed,  7 Jan 2026 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/fSelmj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFC22097;
	Wed,  7 Jan 2026 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767820325; cv=none; b=EIYx3hCvPdbzdDWnnI+jBDBmxFJVdj9qzb8Xe/Y62CsdOjsztx+SX8Ll10ywedP4lNziS3KDXDjhZD5W7HB6/QOHPZBjpZ/fumbHqY4NtWJi4sFZzbNStU7SQ+KXIR4UIyuEbkIydNHrKTxDSdF6uUkvBhf9rPDCFYDUGxHARI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767820325; c=relaxed/simple;
	bh=vU/Y2pefRyJ+jQDO9QdGjxnQJ/MzStethzjBgPfzTLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpaKFBPwozYa0T6DmDOP+0KPq4dEyaw/MELcxCJy+5RKqCPvmSqRggpQ/b9pWxlTpd0qLymAdwLtGBR35FioEPQjDV5QEi2br83woarflvgiPjRwqLMxx+AeLgeykpg+p3XML2fDwE/RtDzHsaS/W1eUvOzLiKADdd3PP/HOuns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/fSelmj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767820324; x=1799356324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vU/Y2pefRyJ+jQDO9QdGjxnQJ/MzStethzjBgPfzTLY=;
  b=S/fSelmjzvfubHDAwNXauSJWFeQjFCOaLD+Mr+N6Wi/WJGWlHrexgm51
   Lp2qQA6wVlWPsA1V6xAbW7auTJ0hXl9TTgqb5ZBwXA4iB43R42pBb++3e
   n2VHjYHY++zOWi3hvsoILBPkZLC0bYHynhfK0qUGDKMfXxetXlcAc8mmi
   Vb0CLIGNN52PugDxYXSbqkp0PnXVBsD+GMeAWciKsPmhuVQI4zCrE2ntb
   w1BZzFh38CJT90p5+PsA3p4FTADg4OwNOnWVSoQPq2e8RzIwWsHuJ4OFO
   H3kBu+ewyFW9Brgl8dRN6Ik8BCuj0sSa47CCQYjIWGvEZX+qpiiwdKTCR
   w==;
X-CSE-ConnectionGUID: Elzr7yWlTrOZ95s8SjkKDg==
X-CSE-MsgGUID: l0oPOvtmSd6BhIPzUV2EYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="80558861"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="80558861"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:12:03 -0800
X-CSE-ConnectionGUID: hiV6ib5fRMOPr5wSLxDCzg==
X-CSE-MsgGUID: eC/gqlvTQ5Gj56Y++knxlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207503017"
Received: from igk-lkp-server01.igk.intel.com (HELO 92b2e8bd97aa) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 07 Jan 2026 13:12:01 -0800
Received: from kbuild by 92b2e8bd97aa with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vdaow-000000001cS-340E;
	Wed, 07 Jan 2026 21:11:58 +0000
Date: Wed, 7 Jan 2026 22:11:01 +0100
From: kernel test robot <lkp@intel.com>
To: Kartik Rajput <kkartik@nvidia.com>, lenb@kernel.org,
	sakari.ailus@linux.intel.com, mika.westerberg@linux.intel.com,
	andriy.shevchenko@linux.intel.com, thierry.reding@gmail.com,
	jonathanh@nvidia.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Kartik Rajput <kkartik@nvidia.com>, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
Message-ID: <202601072231.MPkHMWgN-lkp@intel.com>
References: <20260107062453.10893-1-kkartik@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107062453.10893-1-kkartik@nvidia.com>

Hi Kartik,

kernel test robot noticed the following build errors:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on rafael-pm/bleeding-edge westeri-thunderbolt/next linus/master v6.16-rc1 next-20260107]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kartik-Rajput/ACPI-bus-Use-OF-match-data-for-PRP0001-matched-devices/20260107-142543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20260107062453.10893-1-kkartik%40nvidia.com
patch subject: [PATCH] ACPI: bus: Use OF match data for PRP0001 matched devices
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20260107/202601072231.MPkHMWgN-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260107/202601072231.MPkHMWgN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601072231.MPkHMWgN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/acpi/bus.c:1034:21: error: expected identifier or '('
    1034 |         struct acpi_device = ACPI_COMPANION(dev);
         |                            ^
>> drivers/acpi/bus.c:1036:53: error: use of undeclared identifier 'adev'; did you mean 'dev'?
    1036 |         if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
         |                                                            ^~~~
         |                                                            dev
   drivers/acpi/bus.c:1030:61: note: 'dev' declared here
    1030 | const void *acpi_device_get_match_data(const struct device *dev)
         |                                                             ^
>> drivers/acpi/bus.c:1037:3: error: expected ')'
    1037 |                 return acpi_of_device_get_match_data(dev);
         |                 ^
   drivers/acpi/bus.c:1036:5: note: to match this '('
    1036 |         if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
         |            ^
   3 errors generated.


vim +1034 drivers/acpi/bus.c

  1029	
  1030	const void *acpi_device_get_match_data(const struct device *dev)
  1031	{
  1032		const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
  1033		const struct acpi_device_id *match;
> 1034		struct acpi_device = ACPI_COMPANION(dev);
  1035	
> 1036		if (!strcmp(ACPI_DT_NAMESPACE_HID, acpi_device_hid(adev))
> 1037			return acpi_of_device_get_match_data(dev);
  1038	
  1039		match = acpi_match_device(acpi_ids, dev);
  1040		if (!match)
  1041			return NULL;
  1042	
  1043		return (const void *)match->driver_data;
  1044	}
  1045	EXPORT_SYMBOL_GPL(acpi_device_get_match_data);
  1046	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

