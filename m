Return-Path: <linux-acpi+bounces-15866-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E46DB2E0BF
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 17:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E4958443C
	for <lists+linux-acpi@lfdr.de>; Wed, 20 Aug 2025 15:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC9833472E;
	Wed, 20 Aug 2025 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gstSzdnx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985C63375A7;
	Wed, 20 Aug 2025 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702285; cv=none; b=rHfHGih5j4neuWTJE1jkLhzvrXtKAxhKtdenl02jMLOqUMX1+SBADkEJgkzsfImud/iX28kRK8WXEEqv6qUVoqRs6cWsWCn4TOrU/t7hpNwuZ1p/3vt9yzjVgKpOA+PhhG+KPMweGOOw/HCI47Hx1RE88y29/rO2+HNlbridoi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702285; c=relaxed/simple;
	bh=knRhTo5mE+LaEmMJM/79tvsjADnOoyT04yFSvVno0Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LjOKnLIz1ToLQf3aIbv7GVRtXt1tjG1Q5t6UuXkFN6cz7W5FiI2NLlHfHG3q2Shw8xOlMzcIDGw+0LhaAYzpm5KOcmFE4JwwgYZky0TnJcY1ospGEDaxCZ/pFCbFbDB+5hDfggZLE6c6WeaYqCXdVDTlC8NSLqeILtabZLCxVV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gstSzdnx; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755702283; x=1787238283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=knRhTo5mE+LaEmMJM/79tvsjADnOoyT04yFSvVno0Ho=;
  b=gstSzdnxajbzJVg+URdzqlCH9ER5uNJ/d5aknkdsgyv3Rywd82h3rlVk
   +VqGgmQeA3BcMl7vZ9Ye8RUeoTDrmodjaxK297SAagLvlAl2AyFig1bLf
   6hTQ73/uqsS4guhn//L4v6cYqER9WOGoxYAdKjEc21Wf9moVmSz1FXRmk
   xFQzkbmCztmmaxmVltgXTzKCtElBNnxIHwfq7ZDQkhCJlwAY28tGhX0bj
   8ECztEFchkmDpsyTEMTJOZgwMrsRIwKTjmKQwt6OR+5ksYaYqDBe3SBSX
   BZO3x5+W8EqdZ57fYhxW4H7BAaBPGKamkstosz5K6pocmXRGofYyDYgdx
   A==;
X-CSE-ConnectionGUID: FDVL4MvhQcaUKgdFBVld3g==
X-CSE-MsgGUID: VkN1ivthQpC/x+5S9/s3oA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57830366"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57830366"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:04:25 -0700
X-CSE-ConnectionGUID: QMkvW5Y3Tme3MW/UFsLy9g==
X-CSE-MsgGUID: QP3ybo4gREiJ+KdiB1TpIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="205309732"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:04:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uokMO-00000006xyi-04dV;
	Wed, 20 Aug 2025 18:04:20 +0300
Date: Wed, 20 Aug 2025 18:04:19 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mario Limonciello <superm1@kernel.org>, mario.limonciello@amd.com,
	westeri@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Program debounce when finding GPIO
Message-ID: <aKXj8wSbVlIeXSwg@smile.fi.intel.com>
References: <20250818015219.3604648-1-superm1@kernel.org>
 <20250818045538.GH476609@black.igk.intel.com>
 <08dd199e-0e7d-44b8-b980-5fde226cd636@kernel.org>
 <20250819061813.GJ476609@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819061813.GJ476609@black.igk.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 19, 2025 at 08:18:13AM +0200, Mika Westerberg wrote:
> On Mon, Aug 18, 2025 at 01:03:48PM -0500, Mario Limonciello wrote:
> > On 8/17/25 11:55 PM, Mika Westerberg wrote:
> > > On Sun, Aug 17, 2025 at 08:52:07PM -0500, Mario Limonciello (AMD) wrote:

...

> > > I was not sure but wanted to check that if it is left out, does ACPICA fill
> > > it with 0? If yes (I would expect so) then this is fine.
> > 
> > Yeah AFAICT you're right.  The ACPI resource is zero'ed out, so if the field
> > was empty it should default to zero.
> 
> Okay good.
> 
> Then from my perspective,
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Seems I came from vacation just in time :-)
Please, send v5 with all nits and tags and I will apply it.

-- 
With Best Regards,
Andy Shevchenko



