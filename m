Return-Path: <linux-acpi+bounces-10537-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C16A0B0DD
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 09:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 663B03A4C51
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Jan 2025 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E83523237C;
	Mon, 13 Jan 2025 08:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B0YQetJb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C475231A56;
	Mon, 13 Jan 2025 08:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736756417; cv=none; b=ISCQfBcWkWQ2a+wVypGQnymnUsjrKcTO2bkQ04F8VtjLLbx76N2EpSL0UG8U1eQtZGL450upLG3a6IbHO0ZCP4fgmIqNmqgkTjw86xNUOSczVS4g3jINqfjulTprgxKucHmSXMnGf/jeieD4eNpy9XueidoSiB0MWxkgWixX7yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736756417; c=relaxed/simple;
	bh=5pLPcZ8yabrDbW3lp7BMwEn3TBAcxsnS1EE6kSEXj5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTuNHuF7PBq4LlPkZlxxockj2KIdEAdjQtKSgSeYSlVdWoQU+oe+MznPEHOTu5bdxSIncrRrT6ao0isFlBUBUq4Ebu0eSkAAa1JhkwblJGcfFWJfRGB+tY3SqogsXe7jtZBVuPvJ5CZU0caU9LXrbBG8wkBK5Rwsgbi7Flt+hr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B0YQetJb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736756416; x=1768292416;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pLPcZ8yabrDbW3lp7BMwEn3TBAcxsnS1EE6kSEXj5M=;
  b=B0YQetJbbQ2vYlebfX+aV7lcHZJJXVvH7WfP478ztnDjZ/PY0cxywiAV
   H3MF07nVKuSCdHwdETXDr27O01FMLYeBkczNDkmVSGhKrd0deClIFMjR0
   D1SCx6Resae9k9gIcleNobsQHqL0WNvxEC6F5Hr1cGWPXPdguta6jW+Vq
   pRSjEX4XkTMupOcm7MiD+NjscsTGItHdrFlVJwb97g4HNEkVwowuqTIWZ
   OVXmgZr5UvrmqDytiLQenqlliWAe5hRPYKheqhNvXwd4aqucLVOS1bvoj
   kS9cPSmJC3CKgtg7YtZ8F8xz/QED+Bxv++BXOsa06O3+1WRo6sWSOSc1B
   Q==;
X-CSE-ConnectionGUID: 5hC61WEiQUik60EEiCoGFQ==
X-CSE-MsgGUID: dY5RCiZKRTmoyCwX2uiqQQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="40939594"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40939594"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:20:14 -0800
X-CSE-ConnectionGUID: KCg7WpbAQcSYbAfxPDwFsA==
X-CSE-MsgGUID: 5WI2NzFVT5qU7omgEtNt/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109033681"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:20:10 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tXFg6-00000000NVQ-3uAn;
	Mon, 13 Jan 2025 10:20:06 +0200
Date: Mon, 13 Jan 2025 10:20:06 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Baojun Xu <baojun.xu@ti.com>, robh+dt@kernel.org, lgirdwood@gmail.com,
	perex@perex.cz, shenghao-ding@ti.com, navada@ti.com,
	13916275206@139.com, v-hampiholi@ti.com, v-po@ti.com,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	liam.r.girdwood@intel.com, yung-chuan.liao@linux.intel.com,
	broonie@kernel.org, antheas.dk@gmail.com,
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?iso-8859-1?B?IklscG8gSuRydmluZW4i?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v12] ALSA: hda/tas2781: Add tas2781 hda SPI driver
Message-ID: <Z4TMtilTTxbTnXNu@smile.fi.intel.com>
References: <20241216122008.15425-1-baojun.xu@ti.com>
 <87bjwnzw1i.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjwnzw1i.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Jan 03, 2025 at 05:44:57PM +0100, Takashi Iwai wrote:
> On Mon, 16 Dec 2024 13:20:08 +0100,
> Baojun Xu wrote:
> > 
> > This patch was used to add TAS2781 devices on SPI support in sound/pci/hda.
> > It use ACPI node descript about parameters of TAS2781 on SPI, it like:
> >     Scope (_SB.PC00.SPI0)
> >     {
> >         Device (GSPK)
> >         {
> >             Name (_HID, "TXNW2781")  // _HID: Hardware ID
> >             Method (_CRS, 0, NotSerialized)
> >             {
> >                 Name (RBUF, ResourceTemplate ()
> >                 {
> >                     SpiSerialBusV2 (...)
> >                     SpiSerialBusV2 (...)
> >                 }
> >             }
> >         }
> >     }
> > 
> > And in platform/x86/serial-multi-instantiate.c, those spi devices will be
> > added into system as a single SPI device, so TAS2781 SPI driver will
> > probe twice for every single SPI device. And driver will also parser
> > mono DSP firmware binary and RCA binary for itself.
> > The code support Realtek as the primary codec.
> > In patch version-10, add multi devices firmware binary support,
> > to compatble with windows driver, they can share same firmware binary.

...

> So this series reached already v12, and we'd really like to take in
> some form.  Although the code is still much more complex than I
> wished, it's more or less readable and understandable in some level,
> so I'm fine about the sound/* part.
> 
> OTOH, this contains also the changes for drivers/acpi/scan.c and
> drivers/platform/x86/serial-multi-instantiate.c, and those need Acks
> from the corresponding people, but it missed Cc to them (and MLs).
> Now I put them to Cc.
> 
> Rafael, Hans, Ilpo, Andy, anyone else - could you guys check it?

From ACPI ID usage perspective the changes are fine.

> > diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> > index 74dcccdc6482..55a9a3d5afa8 100644
> > --- a/drivers/acpi/scan.c
> > +++ b/drivers/acpi/scan.c
> > @@ -1769,6 +1769,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
> >  		{"CSC3557", },
> >  		{"INT33FE", },
> >  		{"INT3515", },
> > +		{"TXNW2781", },
> >  		/* Non-conforming _HID for Cirrus Logic already released */
> >  		{"CLSA0100", },
> >  		{"CLSA0101", },
> > diff --git a/drivers/platform/x86/serial-multi-instantiate.c b/drivers/platform/x86/serial-multi-instantiate.c
> > index ed6b28505cd6..db030b0f176a 100644
> > --- a/drivers/platform/x86/serial-multi-instantiate.c
> > +++ b/drivers/platform/x86/serial-multi-instantiate.c
> > @@ -384,6 +384,17 @@ static const struct smi_node cs35l57_hda = {
> >  	.bus_type = SMI_AUTO_DETECT,
> >  };
> >  
> > +static const struct smi_node tas2781_hda = {
> > +	.instances = {
> > +		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
> > +		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
> > +		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
> > +		{ "tas2781-hda", IRQ_RESOURCE_AUTO, 0 },
> > +		{}
> > +	},
> > +	.bus_type = SMI_AUTO_DETECT,
> > +};
> > +
> >  /*
> >   * Note new device-ids must also be added to ignore_serial_bus_ids in
> >   * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
> > @@ -396,6 +407,7 @@ static const struct acpi_device_id smi_acpi_ids[] = {
> >  	{ "CSC3556", (unsigned long)&cs35l56_hda },
> >  	{ "CSC3557", (unsigned long)&cs35l57_hda },
> >  	{ "INT3515", (unsigned long)&int3515_data },
> > +	{ "TXNW2781", (unsigned long)&tas2781_hda },
> >  	/* Non-conforming _HID for Cirrus Logic already released */
> >  	{ "CLSA0100", (unsigned long)&cs35l41_hda },
> >  	{ "CLSA0101", (unsigned long)&cs35l41_hda },

-- 
With Best Regards,
Andy Shevchenko



