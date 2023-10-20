Return-Path: <linux-acpi+bounces-789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F318E7D0D7B
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93617B20433
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020BE17757
	for <lists+linux-acpi@lfdr.de>; Fri, 20 Oct 2023 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kyNUnbiw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2B718E04
	for <linux-acpi@vger.kernel.org>; Fri, 20 Oct 2023 10:36:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FBB10E2;
	Fri, 20 Oct 2023 03:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697798196; x=1729334196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6qScAHtvAY25k9RrO1FlJ14eXJKmDYR3dgfhkSHrBIU=;
  b=kyNUnbiwmc7DspkJeSNvs81j9+ZjlH1I5iKYWXAWZGMzuyMeW5vNcO5b
   qkJcpx2PIlu4IDrRA6G06sgAKb+FXQgKZsd5pgXpnxXKzZLLdv1Jte55s
   phBOT9su6sWsMJwB9FcRrrfyiIU5wXJ7BYSlntxO+cAL92iuF3l/Cdm36
   KZNVgTG0ZOHHAYL0cuhWjy62KJ9eA7uxqEA12NX9imrFwksMNh41Y/2RP
   M447CNytqSXEXrp3ek+ic88N39yWZyuA5aefDGPNqh4U3tYXORU0MWIEd
   ef9hN3IyZhU63f8dMd1gsKoCqaa1PZwRz+a7yhDU3IFJwwZvyvQHlLYPy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="8038643"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="8038643"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="707198783"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="707198783"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 03:36:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qtmrj-000000077eR-2GfU;
	Fri, 20 Oct 2023 13:36:27 +0300
Date: Fri, 20 Oct 2023 13:36:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 4/8] ACPI: utils: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTJYK02w8HZg26eI@smile.fi.intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
 <20231020084732.17130-5-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020084732.17130-5-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 20, 2023 at 02:17:28PM +0530, Raag Jadav wrote:
> Convert manual _UID references to use standard ACPI helpers.

Yes, while not so obvious this is the correct replacement.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



