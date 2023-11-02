Return-Path: <linux-acpi+bounces-1167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777047DF9F9
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D312810F3
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 18:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7AF2134E
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 18:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TbQf778m"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B026FAE
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 16:47:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B940112F;
	Thu,  2 Nov 2023 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698943629; x=1730479629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=keUkf/0Fj5YvzCz3WPOw4pxTYOzAGfxcc6hlW6v/KW0=;
  b=TbQf778mKnGhxEs8kJv2WViWC0z9nxTAuUUqK6IvwNuVnjMfo+zAfAVZ
   uSYsETvgU8NcxfiWIK18xgolX6ssf+z9Wq9Tu/eHi86HFjcaI6irIretb
   FEbFZx/x+juAq086C9LBN05TGg7FJQLHmaSo1IAauqIjy8EV92K5MhR80
   3/f4FtHK+j+l4lgQy1+L5SD39mWX403bfHKCiaKCttODVw/SjF6xexwW3
   xEtEs3iJ4KbhtwYKmgWoBZp8qhAuaTNZrDwaJJdzBlMIBG2JTTlmOMY1P
   3cZY7BvFzJY90ZO5tEyBP5E7KYmsjDo68Zs85d71qxk8w3MjCamPc4sSu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="387635404"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="387635404"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:47:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831741469"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="831741469"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 09:47:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qyaqV-0000000AkFB-1mqR;
	Thu, 02 Nov 2023 18:47:03 +0200
Date: Thu, 2 Nov 2023 18:47:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <ZUPSh6xV7a8K9zOg@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <2023110235-viewless-postage-9832@gregkh>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110235-viewless-postage-9832@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Nov 02, 2023 at 04:58:53PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 02, 2023 at 05:33:40PM +0200, Andy Shevchenko wrote:
> > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > Some users want to use the struct device pointer to see if the
> > > > > device is big endian in terms of Open Firmware specifications,
> > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > > 
> > > > > Provide inline helper for the users.
> > > > 
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > 
> > > Thank you, Greg.
> > > 
> > > Bart, would it be still possible to take this into next?
> > > I would like to have at least this patch applied (with the first user)
> > > to allow conversion of others (I have some more users of new API).
> > 
> > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > branch / tag with this, so other maintainers can pull in case it's needed?
> > (I have something against tty already and perhaps something else, let's
> >  see.)
> 
> After -rc1 is out, I'll look into it, can't do anything until then,
> sorry...

No problem, this is actually a great news!


-- 
With Best Regards,
Andy Shevchenko



