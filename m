Return-Path: <linux-acpi+bounces-11569-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09BA486F8
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 18:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C4163A8E46
	for <lists+linux-acpi@lfdr.de>; Thu, 27 Feb 2025 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488231E521C;
	Thu, 27 Feb 2025 17:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Up8hxUD2"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B7A1D5CD3;
	Thu, 27 Feb 2025 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740678556; cv=none; b=AeZP92reg7dX6/u2fv8032wFxr77WvYBJLmfP3neLAhDC1MgrzRUrgd0m6aC9ra5Xqtb0mN30tgw9L0Uxu0zBlBsKIqyq0z/QQsensGLaH/g5MenCkmPHlruLe4WcjkGO5LTE8Exn99FYw2FqDAvZBWfE0jvLfby2244fyY8Qzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740678556; c=relaxed/simple;
	bh=ez8brVd0JnnAlkQbw2j67F0woWc/khO90+OnRBROpyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZ6Gi9oXAFNUzPu+y7IzjBuOTC4p2OkxUcrveGl8cCJmSgEGE1BHyK2wzL6W6lkdMelAQDFqxEH9GZKc2FeUyaWskBfZTZdY2hiAJMV4e46jL7FQ+ty2q08Iu/tGyDZjPFCgc7Pppr39CE5Fb9HuN7MuLGgNAPgJuC3ckxWLfJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Up8hxUD2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740678554; x=1772214554;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ez8brVd0JnnAlkQbw2j67F0woWc/khO90+OnRBROpyw=;
  b=Up8hxUD2oWi8alur3SKKqZrmauPCZuEXmOqLPJS0uk9AHyoHmyCSc0Hv
   jjjlWWwnjp9H1dGKPRyI5/C0ZVEcisHf2S4w+GBmXMqnSgrkMYK0/2Ufs
   Lxnxdfb92cJSViKO6EbYdu+dAjJlM21BoDN1/SAcqhnsfhpMz+6kaJh0+
   LwS8df+7UYa68J+6l5bUjpwZKuMDr8tjxhE2XLPYecpKpJPx/H3pd1IcW
   lkym7QCiTBgxZROI8XNfhFOmCJoOGmv1S78dIASOd31K+d6I9G1EuKMHi
   8sAvjmvBKYAqJsXgc0rc5kkFZGDCFzC7jUQyJ63rW/hFksCskj0L8Pr5z
   w==;
X-CSE-ConnectionGUID: EMBQ//g/TzO0zYFAUgvztQ==
X-CSE-MsgGUID: 79nJrxn5RXC06bkNqmhpmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45498987"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45498987"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 09:49:13 -0800
X-CSE-ConnectionGUID: b/1sFD2SSWqbRg1BOPQzhg==
X-CSE-MsgGUID: hJH0vHKbTMuTqTWqf5o/Lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117118264"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 27 Feb 2025 09:49:09 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tni0R-000DnF-0k;
	Thu, 27 Feb 2025 17:49:07 +0000
Date: Fri, 28 Feb 2025 01:48:50 +0800
From: kernel test robot <lkp@intel.com>
To: Antheas Kapenekakis <lkml@antheas.dev>, mario.limonciello@amd.com,
	mpearson-lenovo@squebb.ca
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	ilpo.jarvinen@linux.intel.com, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, rafael@kernel.org,
	hdegoede@redhat.com, me@kylegospodneti.ch,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: Re: [PATCH 3/3] ACPI: platform_profile: Do not hide options missing
 in secondary handlers
Message-ID: <202502280150.DkqQsO8C-lkp@intel.com>
References: <20250224195059.10185-4-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224195059.10185-4-lkml@antheas.dev>

Hi Antheas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.14-rc4 next-20250227]
[cannot apply to rafael-pm/linux-next rafael-pm/bleeding-edge]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antheas-Kapenekakis/ACPI-platform_profile-Add-support-for-secondary-handlers/20250225-035455
base:   linus/master
patch link:    https://lore.kernel.org/r/20250224195059.10185-4-lkml%40antheas.dev
patch subject: [PATCH 3/3] ACPI: platform_profile: Do not hide options missing in secondary handlers
config: i386-buildonly-randconfig-003-20250227 (https://download.01.org/0day-ci/archive/20250228/202502280150.DkqQsO8C-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250228/202502280150.DkqQsO8C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502280150.DkqQsO8C-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/platform_profile.c:248: warning: Function parameter or struct member 'secondary' not described in '_aggregate_choices'


vim +248 drivers/acpi/platform_profile.c

77be5cacb2c2d8 Mario Limonciello   2024-12-05  239  
06ec24388f1de6 Mario Limonciello   2024-12-05  240  /**
06ec24388f1de6 Mario Limonciello   2024-12-05  241   * _aggregate_choices - Aggregate the available profile choices
06ec24388f1de6 Mario Limonciello   2024-12-05  242   * @dev: The device
06ec24388f1de6 Mario Limonciello   2024-12-05  243   * @data: The available profile choices
06ec24388f1de6 Mario Limonciello   2024-12-05  244   *
06ec24388f1de6 Mario Limonciello   2024-12-05  245   * Return: 0 on success, -errno on failure
06ec24388f1de6 Mario Limonciello   2024-12-05  246   */
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  247  static int _aggregate_choices(struct device *dev, void *data, bool secondary)
06ec24388f1de6 Mario Limonciello   2024-12-05 @248  {
06ec24388f1de6 Mario Limonciello   2024-12-05  249  	struct platform_profile_handler *handler;
06ec24388f1de6 Mario Limonciello   2024-12-05  250  	unsigned long *aggregate = data;
06ec24388f1de6 Mario Limonciello   2024-12-05  251  
06ec24388f1de6 Mario Limonciello   2024-12-05  252  	lockdep_assert_held(&profile_lock);
d960f14800b581 Kurt Borja          2025-01-15  253  	handler = to_pprof_handler(dev);
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  254  
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  255  	if (handler->ops->secondary != secondary)
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  256  		return 0;
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  257  
06ec24388f1de6 Mario Limonciello   2024-12-05  258  	if (test_bit(PLATFORM_PROFILE_LAST, aggregate))
06ec24388f1de6 Mario Limonciello   2024-12-05  259  		bitmap_copy(aggregate, handler->choices, PLATFORM_PROFILE_LAST);
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  260  	else if (handler->ops->secondary)
724b0dfe3faddb Antheas Kapenekakis 2025-02-24  261  		bitmap_or(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
06ec24388f1de6 Mario Limonciello   2024-12-05  262  	else
06ec24388f1de6 Mario Limonciello   2024-12-05  263  		bitmap_and(aggregate, handler->choices, aggregate, PLATFORM_PROFILE_LAST);
06ec24388f1de6 Mario Limonciello   2024-12-05  264  
06ec24388f1de6 Mario Limonciello   2024-12-05  265  	return 0;
06ec24388f1de6 Mario Limonciello   2024-12-05  266  }
06ec24388f1de6 Mario Limonciello   2024-12-05  267  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

