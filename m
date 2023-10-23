Return-Path: <linux-acpi+bounces-844-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFBD7D36E7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 14:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70589B20BE1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783018E20
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b12uDo+x"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE415E83
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 11:36:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EB21A4;
	Mon, 23 Oct 2023 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698060997; x=1729596997;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hNtJkrhOMeQ/kBhDBZ7GUWDWrwRTz6hQAoZ3cKYKLo=;
  b=b12uDo+xxDFlwb14aPqOdrsOH26FD3/2bC0JvlOiU0VLTsO/WecVCZHN
   vgn8C0epmY0puDHYeIAk1HxolWCZ0jGoW/MbxvAmFC+ybJP919DpEm6RO
   mbW4Gey6r4JuHdqQGPsqrBa/IpOTZl/aEG+XLqROfRJDxO4dOmvASeqGR
   uvh0rC9knaaS+oe8Y+4iF5pXliEafxqG+47OdW2FT8j1/Dx/W4adAWnIa
   GmpjhxzmFObICcR5auXWEsAngXc3rbBOYNr7IP+PknRT6qpQXvAsS4Oh0
   x/4V6qvmMh8qqtntADVW2rkQkAfCJZtlQ3w/SgYTNqB4Ta916zsqxGB/c
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8375803"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8375803"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:36:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="758120931"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="758120931"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 04:36:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qutE9-00000007vHP-3msa;
	Mon, 23 Oct 2023 14:36:09 +0300
Date: Mon, 23 Oct 2023 14:36:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 4/6] ACPI: x86: use acpi_dev_uid_match() for matching
 _UID
Message-ID: <ZTZaqf6Y+kDJOWK6@smile.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-5-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023053530.5525-5-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Oct 23, 2023 at 11:05:28AM +0530, Raag Jadav wrote:
> Convert manual _UID references to use the standard ACPI helper.

> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Please, drop this tag, since I disagree with patch 1 implementation.

-- 
With Best Regards,
Andy Shevchenko



