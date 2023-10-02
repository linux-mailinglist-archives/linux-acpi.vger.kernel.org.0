Return-Path: <linux-acpi+bounces-324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5B17B5069
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 508D72828D6
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389E310A04
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:16 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87DDC2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:58:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4A21704;
	Mon,  2 Oct 2023 02:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240703; x=1727776703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=keZzMkcN0PISim8T5Z34Kx47RiqtJkzIs5J68O3vTQw=;
  b=J6anhFzYr6GLXhEzUkJIWWOJBgD01V/x3LX55iImTkRVrOrUohYWYBhi
   36JDhtMWYI04PuNaq1CR9N+hWFCxtrLBiQfwZ+hTt9wlTgxwdIF58/lS8
   kXTunY6P7D0zIR5XYTFRVbIzcoLG6uBPz2fMkkL54Ya/OqCGjVrK7m2jO
   rwWoXY3nH0Neb1P14gfdh6gPgFSY29AT2LH3EBoE0ifIv2V4x89PDnYBh
   kDb+P6v2Ibd6x6Sbq2C93rCM2IyCI+a/wdpzn1DQpUq0Chr3k25+ZHygd
   w2q5jci1anT5QEmmku32kDozYR2AkLcM9EK89QERd57Vk+QbwVKVNmew4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382518536"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="382518536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="1081595040"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="1081595040"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:58:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFgv-000000027pr-25Ck;
	Mon, 02 Oct 2023 12:58:17 +0300
Date: Mon, 2 Oct 2023 12:58:17 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 05/11] gpiolib: provide gpio_device_get_desc()
Message-ID: <ZRqUOcssSyTgPJno@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-6-brgl@bgdev.pl>
 <ZRqRfss5oI+xcS3o@smile.fi.intel.com>
 <CAMRc=MesApEwEQxesBkodtB_4Zu4ubf3XScJ4iNLwn7sWBEcEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MesApEwEQxesBkodtB_4Zu4ubf3XScJ4iNLwn7sWBEcEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 11:54:40AM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 2, 2023 at 11:46 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 27, 2023 at 04:29:25PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Getting the GPIO descriptor directly from the gpio_chip struct is
> > > dangerous as we don't take the reference to the underlying GPIO device.
> > > In order to start working towards removing gpiochip_get_desc(), let's
> > > provide a safer variant that works with an existing reference to struct
> > > gpio_device.

...

> > > +EXPORT_SYMBOL_GPL(gpiochip_get_desc);
> >
> > > +struct gpio_desc *
> > > +gpio_device_get_desc(struct gpio_device *gdev, unsigned int hwnum)
> >
> > I'm wondering if you move this to be upper than gpiochip_get_desc() and
> > diff will look better...
> 
> There's a limit to bikeshedding in my book and "making the diff look
> better" is definitely it. :)

Right, but if you are going to send a new version it might makes sense
to try, no?

-- 
With Best Regards,
Andy Shevchenko



