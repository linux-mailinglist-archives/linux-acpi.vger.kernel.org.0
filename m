Return-Path: <linux-acpi+bounces-8288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575D59788E8
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 21:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 911201C22B9D
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECC114658B;
	Fri, 13 Sep 2024 19:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VGWUeEDF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A164712DD90;
	Fri, 13 Sep 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726255525; cv=none; b=Uje05k+TvtadV8q0F63jh8HV2CzEA3NGmmirbyX8hUiCj+gw2pY0p7U7kFjK7XdB8XuFYb3nnfVpdVjAUPDh9jQiXp81jBZ/IhmyXa4dlUmZYlEezhUFWii/h8U5wj7yfhTXcReQfbqRbQ+mrFOQl0YqmGCHKbCUK1Re4oWHoJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726255525; c=relaxed/simple;
	bh=W4ftxM+Vy1qddWPmypN190iO08AqZXZ9CP4mAk6M7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lnaONMMdMPrvJHdfIAxvBo5bJgjUj7rOcjNoYko1u8IYbBE1YEdEKf2Ejq9F+k3kWjtP8ZHLcd9jc73gmfB8mvl1dk8khPT+7L9Bifw7DYlmCmOdlH/nKkeZ0Qf6zDeUENaZZIdFxSLdqpgs6w8qnXtFQoYUA4Y8PmZwpnQpm+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VGWUeEDF; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726255524; x=1757791524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W4ftxM+Vy1qddWPmypN190iO08AqZXZ9CP4mAk6M7Iw=;
  b=VGWUeEDFjwnZ8h/TC9sj/pG0/ombDqEZVAEreei3eLAojc4vQpq2RsH2
   PfQW1fGsYWl7uglf5Cu69RCQTmQw408f7nq6oXCUWFd3HAxFQ5hIBACsN
   kFRQ5ICW8kBhuI6oBZjLs6F/Qwq1qX8trh3kKyJZbRNIkBV1DSijx++oD
   NjsHiK3x2XFO51FZWiHkQOnVmsTRy2eRf8uuenLEFQYBu8l3Wt18+Zpfr
   +2Myly/AhJpV3LqNSy8KPup9caeq5dSerzn8BIo1qby6coqxXtyiaojDO
   sha+kCazRjMsWL+7sAbUs1NKL6jGo8hv/2tXzh2hpnLm8EEiJW47Zdf59
   g==;
X-CSE-ConnectionGUID: wG23mS7FSxOOO6oBplu8QQ==
X-CSE-MsgGUID: e4EAsfp5Re2W3fV3iFbmfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11194"; a="28082863"
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="28082863"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:25:23 -0700
X-CSE-ConnectionGUID: 3mkzHVNqQgCnJJDwKiI80g==
X-CSE-MsgGUID: XlM6aTHIRxKkCrVDcwDPEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,226,1719903600"; 
   d="scan'208";a="72538028"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2024 12:25:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1spBuw-00000008PAs-45m2;
	Fri, 13 Sep 2024 22:25:18 +0300
Date: Fri, 13 Sep 2024 22:25:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/1] software node: Simplify swnode_register() a bit
Message-ID: <ZuSRnoaUu-YCOX5L@smile.fi.intel.com>
References: <20240913110523.3584749-1-andriy.shevchenko@linux.intel.com>
 <2024091300-afford-tamper-1831@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024091300-afford-tamper-1831@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Sep 13, 2024 at 03:34:58PM +0200, Greg Kroah-Hartman wrote:
> On Fri, Sep 13, 2024 at 02:05:23PM +0300, Andy Shevchenko wrote:

...

> > +	struct kobject *kobj_parent = parent ? &parent->kobj : NULL;
> 
> I despise ?: use just so much, EXCEPT for when it's used in something
> like this:

> >  		ret = kobject_init_and_add(&swnode->kobj, &software_node_type,
> > -					   parent ? &parent->kobj : NULL,
> > -					   "%s", node->name);
> > +					   kobj_parent, "%s", node->name);
> 
> Which really is the only valid way I'd put up with it :)

I see your point!

> So can you rewrite the change above to be just:
> 
> 	struct kobject *kobj_parent = NULL;
> 
> 	...
> 
> 	if (parent)
> 		kobj_parent = &parent->kobj;
> 
> Which is much simpler to read, right?

Yeah, but the point of the patch seems to be diminished. Let's just not
continue with it for now. Maybe later it will make more sense.

Thank you for the review!

-- 
With Best Regards,
Andy Shevchenko



