Return-Path: <linux-acpi+bounces-19036-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE13C6B1C8
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 19:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86C84344E70
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 18:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BA8330323;
	Tue, 18 Nov 2025 18:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NBQAwCHZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CAF23D7FD;
	Tue, 18 Nov 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489360; cv=none; b=PT3t5RrTyeDJJiv3ruh+UVpsl1BQstMm+LkNTi570E9L99s77T8z3DcfeoLTzDVjuvHAdGka7XOxmYcEA62niLlBSNShte3SEU2ZfhWKSaqGcfpcymF4nj9ZZs8XcqE/06q56OZsMzWQe3toLlvgdDd1vUCPfZq97xLvzLKKrsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489360; c=relaxed/simple;
	bh=A/Qsnsbcuwi6SD5kRqAXG7mJsfMqNARLrx48CwZXZL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgXdY5ZFkSs00b+M22/Jp/rQXeDYQJOBNfeaS0F73uhIVF/KpQY3TaNCrJckFhpbiLqmV6pSSSLGueJcVtdLAkiqrfhZMXuaIuvFij+Yqqg6PCNC9nrq5h65xbQaUbzieHWxfHu7d/hmox/d/2uR8yuE9xlbjdh1WBmygaYogVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NBQAwCHZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763489358; x=1795025358;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=A/Qsnsbcuwi6SD5kRqAXG7mJsfMqNARLrx48CwZXZL0=;
  b=NBQAwCHZhmfg5lnvjOPNzqu+lMWTJOZkHlnsCiyhpp6cXyHHwQat3ZI1
   YNO+Od0rIaoeb1/yQ+Mw9MbcMsK0nFtExFIYUUGfQ4/ArkpUEkG13XUrT
   UaipA69vBHEQSEQkuSU/2ra9ThpUahF4F0JdI54YQY0Am2fHVVFxT7S94
   gU5vkgNbBpPD9WZySP8d6gNF5q8wZa21kyxa7BENubfJKCXe9sOFboohP
   sHTzjDm2KnPdiL6ymdWhKpJtHINIEl2TmWzkHlcRDQwouvut+2+SxLeCa
   UnT+zwH0mm0NWpR2xG0OGIecP8WI0+kpztieImDHwxUSeAbPI34CV8XNN
   g==;
X-CSE-ConnectionGUID: 181sZoZVSKmxW3BXHb45jw==
X-CSE-MsgGUID: hlM6SCtqRbmi+ErCWUwvkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="69137296"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="69137296"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:09:18 -0800
X-CSE-ConnectionGUID: n9yZuGlRTIOgNQ8kDza3sA==
X-CSE-MsgGUID: iKznB/jzR5yksGFPWNEehA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="221733945"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.97])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:09:14 -0800
Date: Tue, 18 Nov 2025 20:09:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v6 8/8] reset: gpio: use software nodes to setup the GPIO
 lookup
Message-ID: <aRy2SJ-rwHnH43y0@ashevche-desk.local>
References: <20251106-reset-gpios-swnodes-v6-0-69aa852de9e4@linaro.org>
 <20251106-reset-gpios-swnodes-v6-8-69aa852de9e4@linaro.org>
 <0d251a35a438ebf3e14c6762df7ece079ee1d164.camel@pengutronix.de>
 <CAMRc=MfAw-HyofSL52PY0H57rBJZAo215gryxWyS8x-d+wcjRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfAw-HyofSL52PY0H57rBJZAo215gryxWyS8x-d+wcjRg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 18, 2025 at 06:08:17PM +0100, Bartosz Golaszewski wrote:
> On Tue, Nov 18, 2025 at 5:44 PM Philipp Zabel <p.zabel@pengutronix.de> wrote:
> > On Do, 2025-11-06 at 15:32 +0100, Bartosz Golaszewski wrote:

...

> > I'll apply this with the following patch squashed in:
> >
> > diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> > index 3edf04ae8a95..8a7b112a9a77 100644
> > --- a/drivers/reset/core.c
> > +++ b/drivers/reset/core.c
> > @@ -945,7 +945,7 @@ static int __reset_add_reset_gpio_device(const struct of_phandle_args *args)
> >         of_node_get(rgpio_dev->of_args.np);
> >
> >         rgpio_dev->swnode = fwnode_create_software_node(properties, NULL);
> > -       ret = PTR_ERR(rgpio_dev->swnode);
> > +       ret = PTR_ERR_OR_ZERO(rgpio_dev->swnode);
> >         if (ret)
> >                 goto err_put_of_node;
> 
> Huh? Why?

Hmm... Maybe we need a kernel-doc for fwnode_create_software_node() to be more
explicit on what it might return (and no, NULL is not there, Bart is correct).

-- 
With Best Regards,
Andy Shevchenko



