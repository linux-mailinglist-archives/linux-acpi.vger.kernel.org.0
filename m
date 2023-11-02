Return-Path: <linux-acpi+bounces-1165-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF447DF7CB
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 17:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0E4281A97
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 16:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1661DDEC
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Nov 2023 16:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7sY14BR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1391CF80
	for <linux-acpi@vger.kernel.org>; Thu,  2 Nov 2023 15:33:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C226196;
	Thu,  2 Nov 2023 08:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698939231; x=1730475231;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GolcTWF8+9TZeA5NDO2NrUBUnlZIS5zC0TJQcmHoZUU=;
  b=I7sY14BRvWPHuvCqzaHTVwPh28pnE8cZPhvdaSxnpGtYVT+U2cZBVJr+
   PKNu6LbSErlovbBXZ9Ma0lpqWV0RD2xmrPNgzFqJrThNYCO1U3gKqjB6r
   sgaCCkcELLpCwAig4vKtAazMMtLD0UdX0eCC8UvvELlOG5yVL4s6XZris
   07CStc+LVCajzxZq79gq979SY57a6xsw/WQThg+yMTlO+tZ75DBMJtzb1
   GNSgtGnRU8ZQVDs8pY8BAVF2MN5CIFSYMsm3Mxv0X22InKqfB//u77BSj
   mSZgRdoEnT8DXqMB0ZsOkVXLCPub/N2GyTfTnwoDbVvPEwD8Ix1itcKqZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="385915858"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="385915858"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:33:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="831719098"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="831719098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 08:33:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qyZhV-0000000Aj1Z-02qV;
	Thu, 02 Nov 2023 17:33:41 +0200
Date: Thu, 2 Nov 2023 17:33:40 +0200
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
Message-ID: <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > Some users want to use the struct device pointer to see if the
> > > device is big endian in terms of Open Firmware specifications,
> > > i.e. if it has a "big-endian" property, or if the kernel was
> > > compiled for BE *and* the device has a "native-endian" property.
> > > 
> > > Provide inline helper for the users.
> > 
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Thank you, Greg.
> 
> Bart, would it be still possible to take this into next?
> I would like to have at least this patch applied (with the first user)
> to allow conversion of others (I have some more users of new API).

Okay, seems we missed v6.7 with this, can you then prepare an immutable
branch / tag with this, so other maintainers can pull in case it's needed?
(I have something against tty already and perhaps something else, let's
 see.)

-- 
With Best Regards,
Andy Shevchenko



