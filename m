Return-Path: <linux-acpi+bounces-323-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AED367B5068
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 12:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 62232282613
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487B110A0C
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Oct 2023 10:34:11 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837F9C2EB
	for <linux-acpi@vger.kernel.org>; Mon,  2 Oct 2023 09:57:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA072E0;
	Mon,  2 Oct 2023 02:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240640; x=1727776640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xkucgrf0Gku3sclZsNEmC/t2jO0YvL8B44d22Q1fSaQ=;
  b=mxhO8IHSTy4K6vDuEiB3qBkUavbLXi5VXnkwtEgxMzXoRPB4sUMe2TQG
   nEXqrvvPcb4gqahuA3UKqyS7+R5CztabmA91/lAcWL4ARkzqggZ/dDy2o
   823/5psLEDILq5NItKj4bNsu8cbUC7/d+bLfRZlQiIK9GY+UdGHqETUSe
   E889RxCfoezNuuWZUVfuYUPDJTfOX9V/obPc86sQBPB0UJUVBFZ8cnPXB
   Z1Upx54m4dKKbcc8oj6E8y9Wh+S6nAEMC34PcPe6dvG3dDBUVbFZDQNwZ
   0taBdXjoYrF7D8faxnL5uQhx1kj0WlPK+mUFzX0XjR6drZ9L62mNc93Ve
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372961768"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372961768"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:57:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="924221103"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="924221103"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:57:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1qnFfv-000000027od-18zE;
	Mon, 02 Oct 2023 12:57:15 +0300
Date: Mon, 2 Oct 2023 12:57:14 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 03/11] gpiolib: provide gpio_device_find()
Message-ID: <ZRqT+qZ+Xrz4x1IQ@smile.fi.intel.com>
References: <20230927142931.19798-1-brgl@bgdev.pl>
 <20230927142931.19798-4-brgl@bgdev.pl>
 <ZRqQbzbcNHOtJm7z@smile.fi.intel.com>
 <CAMRc=MffRnq2ABRGAL9zuQxytfE6E-cJWwUrourgY2k=RNv-Aw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MffRnq2ABRGAL9zuQxytfE6E-cJWwUrourgY2k=RNv-Aw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 11:52:52AM +0200, Bartosz Golaszewski wrote:
> On Mon, Oct 2, 2023 at 11:42 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Wed, Sep 27, 2023 at 04:29:23PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

...

> > >  struct gpio_chip *gpiochip_find(void *data,
> > >                               int (*match)(struct gpio_chip *gc,
> >
> > > +struct gpio_device *gpio_device_find(void *data,
> > > +                                  int (*match)(struct gpio_chip *gc,
> > > +                                               void *data))
> >
> > Why not
> >
> > typedef int (*gpio_chip_match_fn)(struct gpio_chip *gc, void *data);
> 
> Because gpiochip_find() will go away as soon as we convert all users.

And gpio_device_find() does not. So, I didn't get this argument.

-- 
With Best Regards,
Andy Shevchenko



