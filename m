Return-Path: <linux-acpi+bounces-7730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61094958D56
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855101C234DA
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7B1C3797;
	Tue, 20 Aug 2024 17:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nxfhs43F"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB47B18C92C;
	Tue, 20 Aug 2024 17:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174921; cv=none; b=VCX9EkHg98nIKqyRJHe6xxvocK4d/6td5JbZUKVHb4JcTzZMLgp7GpcQV0UFEVY7U5OAr3sOu1LFwXQ/teF6pY5Am+w9pGoCEx6OUlyr+ozLK7mXHK2LeErYezHh85G7JfU3UjaNf58zEYGoRbQYJdtjJyMH0siDSF0yOThg8ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174921; c=relaxed/simple;
	bh=gxOpFPPyX4vEfDtz0VCkirxZGrDav49zs5925e143/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pH9oYVusEP3rSUtzrM/HBFVCdnI03uRzVMnv2gFGb9FZCloJo8B0Y6+fK1dcAamkTGJKFO0Am5EDRjI9SaPQ+oIrZrbamK8LzV/VP8c8janGxTUrqGvwdWUsZWJbXM2B6Ab0zbgzw343+5Tav+ZwwGF47fj9WqDCQvfB2MvQKuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nxfhs43F; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724174921; x=1755710921;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gxOpFPPyX4vEfDtz0VCkirxZGrDav49zs5925e143/I=;
  b=Nxfhs43F3qdOuJ0u7Ah47/pLroErI7FHovxi8vwTzBtRK4zcDKX8NE8v
   O+PPTT6FW6PgTpzT2l5mFfij2abPO0AEFj+ZK26AAdmyV/7aCh0FNxUUB
   k9MaFqVM5T26BIOce2RcEAMUFp2hOgxCV4S4Wa0MafoJdEZGGFb4iuqcZ
   VNP1dADDSJU3djZNIAJszGixgdYYIeZjaReL6Rfqq6/1J1/Kv4p56WDs5
   tAnCm/VgFY27J9DJj8w4xIAhd/08rkV+N3VFizyXMzEMP8ii1EPn7R75Y
   MIiyUDsY7l11uBjT8z9XOX0qNALRxBMNMqPh5SwWN4cboYf7PY/BPPK9+
   g==;
X-CSE-ConnectionGUID: e3TBLGKYRD+k0rqUSnzrkQ==
X-CSE-MsgGUID: h0hFxwV/Re+djyyVsDrL6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="22644748"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="22644748"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:28:08 -0700
X-CSE-ConnectionGUID: M1PnaZKjTxGoD5szJQWUeQ==
X-CSE-MsgGUID: o+OJD7p9Riqa+7SQuPBl6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="91523618"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:27:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgSeA-0000000HOGh-1rJT;
	Tue, 20 Aug 2024 20:27:54 +0300
Date: Tue, 20 Aug 2024 20:27:54 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, devicetree@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Pin-yen Lin <treapking@chromium.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Benson Leung <bleung@chromium.org>,
	Conor Dooley <conor+dt@kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
	David Airlie <airlied@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Guenter Roeck <groeck@chromium.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Lee Jones <lee@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashant Malani <pmalani@chromium.org>,
	Robert Foss <rfoss@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Daniel Scally <djrscally@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>, linux-acpi@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 05/17] usb: typec: Add device managed
 typec_switch_register()
Message-ID: <ZsTSGjdz2HbqcZkJ@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-6-swboyd@chromium.org>
 <ZsRs6d6uOMb4DqQQ@smile.fi.intel.com>
 <CAE-0n52O01UgrDT2=-JJpZj39BOJNyyQC4w_pgDUmKDmcN=8Yw@mail.gmail.com>
 <ZsTPeEsS1m4Y8imq@smile.fi.intel.com>
 <CAE-0n52FSUFictNQ9kotgFAZPYnJpy+3Ad__QeUN+EiJuBWGwQ@mail.gmail.com>
 <CAE-0n50uOcCHHaw=opEY089ymPBER2H7QLtORFzD6ypwHEKUJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n50uOcCHHaw=opEY089ymPBER2H7QLtORFzD6ypwHEKUJw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 10:23:06AM -0700, Stephen Boyd wrote:
> Quoting Stephen Boyd (2024-08-20 10:19:48)
> > Quoting Andy Shevchenko (2024-08-20 10:16:40)
> > > On Tue, Aug 20, 2024 at 10:01:07AM -0700, Stephen Boyd wrote:
> > > > Quoting Andy Shevchenko (2024-08-20 03:16:09)
> > > > > On Mon, Aug 19, 2024 at 03:38:19PM -0700, Stephen Boyd wrote:

...

> > > > > > +     ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
> > > > > > +     if (!ptr)
> > > > > > +             return ERR_PTR(-ENOMEM);
> > > > > > +
> > > > > > +     switch_dev = typec_switch_register(parent ,desc);
> > >
> > > (Side note: wrong location of the white space)
> >
> > Thanks.
> >
> > >
> > > > > > +     if (!IS_ERR(switch_dev)) {
> > >
> > > (Side note: positive conditional is okay)
> > >
> > > > > > +             *ptr = switch_dev;
> > > > > > +             devres_add(parent, ptr);
> > > > > > +     } else {
> > > > > > +             devres_free(ptr);
> > > > > > +     }
> > > > >
> > > > > devm_add_action_or_reset() ?
> > > >
> > > > No. We don't want to call the 'action' devm_typec_switch_unregister()
> > > > when it fails because that would unregister a switch that has never been
> > > > registered.
> > >
> > > Hmm... With devm_add_action_or_reset() we first do things and then try to add
> > > them to the managed resources. In that case it won't be like you described.
> > >
> > > What do I miss?
> >
> > I believe you've missed that this is a wrapper around struct device and
> > the error path is different (put_device() vs. device_unregister()).
> 
> Or you're suggesting devm_add_action_or_reset() after registering the
> switch? Sorry it wasn't clear to me.

Yes, after successful switch registration.

-- 
With Best Regards,
Andy Shevchenko



