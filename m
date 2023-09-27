Return-Path: <linux-acpi+bounces-199-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B417B06ED
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 16:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 785A3282710
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6026838F99
	for <lists+linux-acpi@lfdr.de>; Wed, 27 Sep 2023 14:33:26 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD17D26E19
	for <linux-acpi@vger.kernel.org>; Wed, 27 Sep 2023 13:48:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7D121;
	Wed, 27 Sep 2023 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695822513; x=1727358513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iNqkbzBKdsM1K2XrkEqjYDoPQ/oFpePtITJItg0KYTA=;
  b=mqHLCKnzZ8xjDmTamvHmZlSX3s8wr7X5tGZk5PUcY69a3qFdLY1roorY
   k05RE/l6GyyaK0ukgCSroEyqj4P1W3OqjahzGIBJfKrgRwRkC1ob0zhy+
   fUYUk7yxUO9b0uWPCevgXIn3jEo4Jn8H3YkB2nsdZ5b9q1EJ/ZuMmcfO9
   cUw1eR7CCIdyeBUaMjEoE78+SSL0Ji5H57/ZAygCLI/C3gImCJ+zL1db0
   UG+hoU7t4IPexAA6Oh0F0xx0Pw1ADI6FWrbvQwitMCtADDhRAvbg0zbL7
   y6sSGMMre//mg9154hDqriIVjuJvEiu1fG9IuLDrPPQn1OidS2fDBMvct
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366888121"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="366888121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:48:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="749212402"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="749212402"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:48:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qlUtv-00000000tvO-3DF4;
	Wed, 27 Sep 2023 16:48:27 +0300
Date: Wed, 27 Sep 2023 16:48:27 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 04/11] gpiolib: provide gpio_device_find_by_label()
Message-ID: <ZRQyqw/YWbSeQcJc@smile.fi.intel.com>
References: <20230915150327.81918-1-brgl@bgdev.pl>
 <20230915150327.81918-5-brgl@bgdev.pl>
 <ZQf6E+itll3dmCnU@smile.fi.intel.com>
 <CAMRc=Mcq-0yWcYp6ksDF5RP-B+7b+r2KYh5onEMKx1tpS9O4hQ@mail.gmail.com>
 <ZRQhIqpb6Ho9ifgz@smile.fi.intel.com>
 <CAMRc=Mck9R8LB6_g9O54ZhRDewx99aOs9g-bExR3yC+GJ-8gYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mck9R8LB6_g9O54ZhRDewx99aOs9g-bExR3yC+GJ-8gYQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 02:42:28PM +0200, Bartosz Golaszewski wrote:
> On Wed, Sep 27, 2023 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 27, 2023 at 01:22:36PM +0200, Bartosz Golaszewski wrote:
> > > On Mon, Sep 18, 2023 at 9:19 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Fri, Sep 15, 2023 at 05:03:19PM +0200, Bartosz Golaszewski wrote:
> > > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

...

> > > > > +static int gpio_chip_match_by_label(struct gpio_chip *gc, void *label)
> > > > > +{
> > > > > +     return gc->label && !strcmp(gc->label, label);
> > > > > +}
> > > >
> > > > I am still wondering if we can oblige providers to have label to be non-empty.
> > >
> > > Of course we can. Just bail out of gpiochip_add_data_with_key() if it
> > > is. But that's material for a different patch.
> >
> > Yes, but my point here is that
> > 1) the current users are already following this requirement;
> > 2) the enforcement can be done explicitly somewhere (in the register function).
> >
> > Is the 1) incorrect assumption?
> 
> I remember doing a quick glance over GPIO providers and it looks like
> ALL of them set the label. But I may have missed something. I would
> start with a warning.

For now I would drop the NULL check. We will have a few weeks to see
if somebody screams about. Meanwhile we can add the real error message
patch if no-one complains.

-- 
With Best Regards,
Andy Shevchenko



