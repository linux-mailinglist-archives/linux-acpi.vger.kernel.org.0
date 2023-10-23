Return-Path: <linux-acpi+bounces-846-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE2997D3CB2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 18:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370E92804D1
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E646C2566
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Oct 2023 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ1bQVRq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AA714A84
	for <linux-acpi@vger.kernel.org>; Mon, 23 Oct 2023 14:43:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F1A19B0;
	Mon, 23 Oct 2023 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698072194; x=1729608194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c+vwHWtU4SYe45hCSutTEEchOiP/C8YWbfE6MM6PUfQ=;
  b=fZ1bQVRqMikzcZXly6+WJZ2mg0ZYLxZbXR2sCmPg4i18jIH6nYOfySei
   MGmuIBtV5LRIvXbUU493dbc30Unrecm0AVIDvGkq1kNU0Q5lE0AeY91ad
   dzUk1nTatYDkACZJRr+8g6HKkwh/F8idsuqZrVHRFBKIAtG3BdCXGQBcd
   b6HFW96G4dJGaU5GO9b+2sCcgVWjvHiaXJkjTMD3+eihCDTzP21JNnR3b
   nY3Po3BSPCk91ameJoBQX9oS4Md2SXaehB/4rzw5O+fXFqPR2blcAn3UT
   YdZ1EBHhIyl4SsdH+T80mRlHYKz5a0B9MMO5AP4vDnhtDvA08BgO5e5MZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="417985236"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="417985236"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793150451"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="793150451"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 07:42:51 -0700
Date: Mon, 23 Oct 2023 17:42:48 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
	mika.westerberg@linux.intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v2 2/6] pinctrl: intel: use acpi_dev_uid_match() for
 matching _UID
Message-ID: <ZTaGaDweYpBlxBez@black.fi.intel.com>
References: <20231023053530.5525-1-raag.jadav@intel.com>
 <20231023053530.5525-3-raag.jadav@intel.com>
 <ZTZacR86hSmV04M9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTZacR86hSmV04M9@smile.fi.intel.com>

On Mon, Oct 23, 2023 at 02:35:13PM +0300, Andy Shevchenko wrote:
> On Mon, Oct 23, 2023 at 11:05:26AM +0530, Raag Jadav wrote:
> > Convert manual _UID references to use the standard ACPI helper.
> 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> It has a hidden logic that is not aligned with acpi_dev_hid_uid_match().
> Or revert to your v1 I assume.

I don't see how this has to be aligned with acpi_dev_hid_uid_match() or
if acpi_dev_hid_uid_match() implementation concerns this specific change,
since that's not what we intend to do here.

Also, I think acpi_dev_uid_match() implementation in v2 is actually more
aligned with the previous logic that we're replacing here, since it gives
us a guaranteed match result as originally intended with strcmp in this
case. And the "hidden logic" in v1 implementation (match with @uid2 == NULL)
is what ends up breaking it in my opinion.

Regardless, for any version (v1 or v2) the usage still remains the same
in this case.

> As I asked you, please drop this one.

But okay, as you wish :(

Rafael, should I send a v3 with dropped tags?

Raag

