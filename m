Return-Path: <linux-acpi+bounces-7724-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE63958CF3
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 19:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141A61F24198
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 17:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4066E1BB69B;
	Tue, 20 Aug 2024 17:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aDgDPDlG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9746A18A928;
	Tue, 20 Aug 2024 17:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174215; cv=none; b=GTgAHGj9NLJZm4Ms3yIgJeXCDGc2SK6CWVNcj+UxWaTsrg5hf+H1IzIs51sqZ+s3aPJxsAODxxg90+OmqAr/BhwDYaR+zrDrEWvgbsOLYStAVggzzKRT3dKxu1yQdn145MedA3/TFwgDP4GYmbake1xpJQoXxOc9NcLoDvxl7M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174215; c=relaxed/simple;
	bh=1WOCN1hQxUm1krY7hl5MD+NIzVYaTnsupZFCAJLrYTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJh4rMjGwg90GHvlV2MaA+RexSmO0W+6tSJKX+mOqGOCSnrYmy0+8vU/X+uVeS9K8aMea1LRxBgSNxaV0FzoKbP25V/ubyy4PeBA5oq5hR7LxlSjvXUhrGF/GGEGCJpqzyfrkA2NWRdXKNq+382x8PW5KyYMjHpL4z+hhzvFCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aDgDPDlG; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724174214; x=1755710214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1WOCN1hQxUm1krY7hl5MD+NIzVYaTnsupZFCAJLrYTs=;
  b=aDgDPDlGBOBVdExNqWfPQoUWA10BQbJwJu3meocUxnJ+DUn8wtf60SdT
   4uzqA6rDnVIxXKbnES5lI2kLDNbwwXMa8tO6HSO2wNsNhfdUkfxrx9qp8
   WKnm0KJTPhvM7SZ4V0ckZLgyU7/BFu0OldlO3FXnEza6n30q32btnI/wA
   zxmWgfSFazTwjb1inhFdJ2Jj47CUqI6NLlwMJW+6QAIsn10j4Tmu+3tVZ
   4r5e+/QaAhrfsorGFa6qdDvfHuR95ktF5cP8MuoinkYr44SsJRgQ2467t
   thTeLjIvs0T/0Vyxrn0rso60UtGOSUrgZAYW/rbGZ9AEtPHWHfEFUyFqb
   A==;
X-CSE-ConnectionGUID: DUhOeT6wR4SY8q6WJuK3pg==
X-CSE-MsgGUID: 3P4EXWVmQYmZcpijna41yQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="26363978"
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="26363978"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:16:53 -0700
X-CSE-ConnectionGUID: 9kKj3Zq/Rcak+WCW+VHNBQ==
X-CSE-MsgGUID: YxLX6qvOT+uBQrS9ly4vBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,162,1719903600"; 
   d="scan'208";a="65650227"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 10:16:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sgSTI-0000000HNl0-2L24;
	Tue, 20 Aug 2024 20:16:40 +0300
Date: Tue, 20 Aug 2024 20:16:40 +0300
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
Message-ID: <ZsTPeEsS1m4Y8imq@smile.fi.intel.com>
References: <20240819223834.2049862-1-swboyd@chromium.org>
 <20240819223834.2049862-6-swboyd@chromium.org>
 <ZsRs6d6uOMb4DqQQ@smile.fi.intel.com>
 <CAE-0n52O01UgrDT2=-JJpZj39BOJNyyQC4w_pgDUmKDmcN=8Yw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n52O01UgrDT2=-JJpZj39BOJNyyQC4w_pgDUmKDmcN=8Yw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Aug 20, 2024 at 10:01:07AM -0700, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-08-20 03:16:09)
> > On Mon, Aug 19, 2024 at 03:38:19PM -0700, Stephen Boyd wrote:
> > > +     ptr = devres_alloc(devm_typec_switch_unregister, sizeof(*ptr), GFP_KERNEL);
> > > +     if (!ptr)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     switch_dev = typec_switch_register(parent ,desc);

(Side note: wrong location of the white space)

> > > +     if (!IS_ERR(switch_dev)) {

(Side note: positive conditional is okay)

> > > +             *ptr = switch_dev;
> > > +             devres_add(parent, ptr);
> > > +     } else {
> > > +             devres_free(ptr);
> > > +     }
> >
> > devm_add_action_or_reset() ?
> 
> No. We don't want to call the 'action' devm_typec_switch_unregister()
> when it fails because that would unregister a switch that has never been
> registered.

Hmm... With devm_add_action_or_reset() we first do things and then try to add
them to the managed resources. In that case it won't be like you described.

What do I miss?

-- 
With Best Regards,
Andy Shevchenko



