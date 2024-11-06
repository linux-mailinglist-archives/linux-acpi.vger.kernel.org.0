Return-Path: <linux-acpi+bounces-9335-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE399BDAF3
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 02:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2B9B2355D
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Nov 2024 01:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE603174EF0;
	Wed,  6 Nov 2024 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f1jkwQoD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1AF13C918;
	Wed,  6 Nov 2024 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730855402; cv=none; b=ZfSEBhgPyj+vRbZjNwX0pH0D6IW3hoGlJko6xGqyHPgPIkRmSEjvSPJDhF0PNPwoCiMHCGtdjMkqT77hwRBuC6ThOfgAgCz0Dobdpos0R8glYkozNBVZ96Wxtmqam9pub8eU19jcgjKx3SkKJ3PbhJyLJWV7v+bsePa8JZTsFTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730855402; c=relaxed/simple;
	bh=8wkwyTaOOs9Q5NnvxbQhqZPtZs3GJ1PNsILlDFMD+Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEq4OGTe5xVIYATfV/ux+H37ztPUKT6xcq1AvWPhCGdCxmtA+8h7tsTAjfwSpIST27U5cjcf90W7TSVwwI2DgKJpytrCABznG0qgpWxeO508n4PvzPVK9u7Pt7nYqlWQmVKYIUp8J1taUmbMDGQGF+c8qmmpDOjPPLyGh+6VlmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f1jkwQoD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730855401; x=1762391401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8wkwyTaOOs9Q5NnvxbQhqZPtZs3GJ1PNsILlDFMD+Ic=;
  b=f1jkwQoDTBYlKXY8YTuAysaBWintcHbhfmuZqKioP1/mm7gANIVTVIXv
   ClRJoZCzSAJ09bQ3g1+hWTLF0OQaW49MVtMYcXjQsWVMHNSTqGq8lOGla
   aNJF6k35AFoeXC2vVd02mNFJ0CfSkq4kd/XRLL1PLaFbfnk7L543g894r
   q4cSQfMHGzg15iRfLFmvVgWsFW2AbxYQkTKZSj5ufxwsTYYKoctzyjtz6
   7KycIHm7wrv/HKy26ECV7tTv8N1v//TMGW26l3twjCtF8d5h5fVlTMNEl
   br9a1H8hGgfCf/tu5XHEcs4iyh+gf6ItKTOWybUDrDZDF20t1k8b8Gcm3
   A==;
X-CSE-ConnectionGUID: 2zVQhq9PSDithnQ/yf+5sw==
X-CSE-MsgGUID: cWE8+CeCQmmg2eoerDW4PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11247"; a="30740728"
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="30740728"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2024 17:10:00 -0800
X-CSE-ConnectionGUID: 8QkttW8lSlGJTh+nJBv2Tw==
X-CSE-MsgGUID: nvQubyb8SZOi3RncHdWtHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,261,1725346800"; 
   d="scan'208";a="89395669"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 05 Nov 2024 17:09:56 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t8UYS-000mgP-3B;
	Wed, 06 Nov 2024 01:09:52 +0000
Date: Wed, 6 Nov 2024 09:09:38 +0800
From: kernel test robot <lkp@intel.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Maximilian Luz <luzmaximilian@gmail.com>,
	Lee Chun-Yi <jlee@suse.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Corentin Chary <corentin.chary@gmail.com>,
	"Luke D . Jones" <luke@ljones.dev>,
	Ike Panhc <ike.pan@canonical.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Alexis Belmonte <alexbelm48@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:ACPI" <linux-acpi@vger.kernel.org>,
	"open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER" <platform-driver-x86@vger.kernel.org>,
	"open list:THINKPAD ACPI EXTRAS DRIVER" <ibm-acpi-devel@lists.sourceforge.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Matthew Schwartz <matthew.schwartz@linux.dev>,
	Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v4 11/20] ACPI: platform_profile: Add choices attribute
 for class interface
Message-ID: <202411060835.GlMKVSsy-lkp@intel.com>
References: <20241105153316.378-12-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105153316.378-12-mario.limonciello@amd.com>

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d68cb6023356af3bd3193983ad4ec03954a0b3e2]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/ACPI-platform-profile-Add-a-name-member-to-handlers/20241105-233922
base:   d68cb6023356af3bd3193983ad4ec03954a0b3e2
patch link:    https://lore.kernel.org/r/20241105153316.378-12-mario.limonciello%40amd.com
patch subject: [PATCH v4 11/20] ACPI: platform_profile: Add choices attribute for class interface
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20241106/202411060835.GlMKVSsy-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241106/202411060835.GlMKVSsy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411060835.GlMKVSsy-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/acpi/platform_profile.c:55: warning: Function parameter or struct member 'choices' not described in '_get_class_choices'


vim +55 drivers/acpi/platform_profile.c

    48	
    49	/**
    50	 * _get_class_choices - Get the available profile choices for a class device
    51	 * @dev: The class device
    52	 * Return: The available profile choices
    53	 */
    54	static int _get_class_choices(struct device *dev, unsigned long *choices)
  > 55	{
    56		struct platform_profile_handler *handler;
    57		int i;
    58	
    59		scoped_cond_guard(mutex_intr, return -ERESTARTSYS, &profile_lock) {
    60			handler = dev_get_drvdata(dev);
    61			for_each_set_bit(i, handler->choices, PLATFORM_PROFILE_LAST)
    62				*choices |= BIT(i);
    63		}
    64	
    65		return 0;
    66	}
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

