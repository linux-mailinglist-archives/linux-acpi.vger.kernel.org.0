Return-Path: <linux-acpi+bounces-879-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5937D4FE0
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 14:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8771C20B34
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E562273C5
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Oct 2023 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OVTqXZ9p"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609B7498
	for <linux-acpi@vger.kernel.org>; Tue, 24 Oct 2023 11:01:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD8712C;
	Tue, 24 Oct 2023 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698145267; x=1729681267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=75KjUTqZS/fnnT7oRhWogkQjn6g67+ZS64Oru9+MmVU=;
  b=OVTqXZ9pp95xjiBXRzhrbaV7HNWBCvOGuY24b7tfKXFGm1sCQWg9bzb7
   2aooeQKN3o3ImrclTd9wZ5UT80sLLYDtWENwfFscV70fbyFSlNLI4HAbT
   nG3D21rVAlmfLhx364LaluN8VtE9NE3kNT+2jSZvwmWzjMkSJAJYUkyEf
   trwLe6qbVUBLpCUiu0be35wq5gN2Cd8WwQgKMgaOwvDEjFzBOpgb8mSkE
   REW8B7YLG8o/J17L/DOLfsuz9j1+erfv7Logx0vqXWGmiyiHkHa7kYHTB
   56lykVIcR3Uud24GvGj/422LDaYNLTqSRv1X0BAb2Sq1sy6d5f/v9zp4O
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="453491329"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="453491329"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="875034670"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="875034670"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 04:01:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qvF9f-00000008Bp9-0sdU;
	Tue, 24 Oct 2023 14:00:59 +0300
Date: Tue, 24 Oct 2023 14:00:58 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Raag Jadav <raag.jadav@intel.com>, rafael@kernel.org,
	len.brown@intel.com, robert.moore@intel.com, mark.rutland@arm.com,
	will@kernel.org, linux@roeck-us.net, Jonathan.Cameron@huawei.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
	mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v3 0/6] Refine _UID references across kernel
Message-ID: <ZTej6hlCCYFRCNtl@smile.fi.intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
 <20231024093010.GF3208943@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024093010.GF3208943@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Oct 24, 2023 at 12:30:10PM +0300, Mika Westerberg wrote:
> On Tue, Oct 24, 2023 at 11:50:12AM +0530, Raag Jadav wrote:
> > This series refines _UID references across kernel by:

...

> >  drivers/pinctrl/intel/pinctrl-intel.c |  2 +-
> 
> This pinctrl one is also fine by me so if Andy does not have objections,
> feel free to add my,

TL;DR: I had, but Rafael seems wanted your opinion. Whatever, I'm not
preventing this from happening, but I still consider that the uid check
for NULL in the helper should mimic the same logic as in
acpi_dev_hid_uid_match(). That's why I asked to drop my tags from this
series.

-- 
With Best Regards,
Andy Shevchenko



