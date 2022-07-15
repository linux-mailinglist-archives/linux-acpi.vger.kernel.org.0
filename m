Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8495F57611E
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Jul 2022 14:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiGOMFt (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 15 Jul 2022 08:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOMFs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jul 2022 08:05:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E1804A7;
        Fri, 15 Jul 2022 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657886747; x=1689422747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V3vkPEC+zSZ3L2HSbO6cmV7tLXm2uvZR18LlJDZDves=;
  b=BUFflnBBrJsVms3ut3CUDlz0X3HOkz9CHG4+YED3GILlHNPXtCiUm8Kd
   X1kMBiyap9uzBCerZeeIc/eHgyXZUmiydc/tYYRhMPyI/EzrEsJsywUZm
   ZZCCLvS9bfx8mffbUtdos+V4ZtIawpp2oM9MN/f7E/JrJcPc1yD+0fQTi
   d7/COssrfsav0151CM9mzExUYBlDzDvMNVAGQLcvMgK7Z/ywDgoVBH2/b
   NJbESqKWc1zuWaI+HPqK3OT6qDfsYwHmCYjK4ELII/+396D/iFNmgVtDi
   9c1Fhz8eGC0I+HLgwzKq3OMllkGCeE26dC4bh4JqSLLGYbcd0xjYajm5S
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="283338228"
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="283338228"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 05:05:47 -0700
X-IronPort-AV: E=Sophos;i="5.92,273,1650956400"; 
   d="scan'208";a="600475182"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 05:05:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oCK4j-001IpI-1x;
        Fri, 15 Jul 2022 15:05:41 +0300
Date:   Fri, 15 Jul 2022 15:05:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] add support for bias pull-disable
Message-ID: <YtFYFbP+xqAUUHZa@smile.fi.intel.com>
References: <20220713131421.1527179-1-nuno.sa@analog.com>
 <YtAvHMmGay/3HACZ@smile.fi.intel.com>
 <e0638b02bdcd0ee452846b86ce83458173912ef1.camel@gmail.com>
 <YtBnIxh6rDJMwpEm@smile.fi.intel.com>
 <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d9f9272334177e3ea864467f50095a8709bc0d2.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 15, 2022 at 12:20:56PM +0200, Nuno Sá wrote:
> On Thu, 2022-07-14 at 21:57 +0300, Andy Shevchenko wrote:
> > On Thu, Jul 14, 2022 at 05:43:41PM +0200, Nuno Sá wrote:
> > > On Thu, 2022-07-14 at 17:58 +0300, Andy Shevchenko wrote:
> > > > On Wed, Jul 13, 2022 at 03:14:17PM +0200, Nuno Sá wrote:
> > > > > The gpio core looks at 'FLAG_BIAS_DISABLE' in preparation of
> > > > > calling the
> > > > > gpiochip 'set_config()' hook. However, AFAICT, there's no way
> > > > > that
> > > > > this
> > > > > flag is set because there's no support for it in firwmare code.
> > > > > Moreover,
> > > > > in 'gpiod_configure_flags()', only pull-ups and pull-downs are
> > > > > being
> > > > > handled.
> > > > > 
> > > > > On top of this, there are some users that are looking at
> > > > > 'PIN_CONFIG_BIAS_DISABLE' in the 'set_config()' hook. So,
> > > > > unless
> > > > > I'm
> > > > > missing something, it looks like this was never working for
> > > > > these
> > > > > chips.
> > > > > 
> > > > > Note that the ACPI case is only compiled tested. At first
> > > > > glance,
> > > > > it seems
> > > > > the current patch is enough but i'm not really sure...
> > > > 
> > > > So, I looked closer to the issue you are trying to describe here.
> > > > 
> > > > As far as I understand we have 4 state of BIAS in the hardware:
> > > > 1/ AS IS (defined by firnware)
> > > > 2/ Disabled (neither PU, not PD)
> > > > 3/ PU
> > > > 4/ PD
> > > > 
> > > > The case when the default of bias is not disabled (for example
> > > > specific, and I
> > > > think very special, hardware may reset it to PD or PU), it's a
> > > > hardware driver
> > > > responsibility to inform the framework about the real state of
> > > > the
> > > > lines and
> > > > synchronize it.
> > > > 
> > > > Another case is when the firmware sets the line in non-disabled
> > > > state
> > > > and
> > > > by some reason you need to disable it. The question is, why?
> > > 
> > > Not getting this point... 
> > 
> > I understand that in your case "firmware" is what DTB provides.
> > So taking into account that the default of hardware is PU, it needs
> > a mechanism to override that, correct?
> > 
> 
> Exactly...
> 
> > > > > As a side note, this came to my attention during this patchset
> > > > > [1]
> > > > > (and, ofr OF,  was tested with it).
> > > > > 
> > > > > [1]:
> > > > > https://lore.kernel.org/linux-input/20220708093448.42617-5-nuno.sa@analog.com/
> > > > 
> > > > Since this provides a GPIO chip, correct?, it's responsibility of
> > > > the
> > > > driver to
> > > > synchronize it, no? Basically if you really don't trust firmware,
> > > > you
> > > > may
> > > 
> > > What do you mean by synchronize?
> > 
> > Full duplex sync, i.e. setting flag to PU for the pins that should
> > stay PU:ed
> > and disabling bias for the ones, that want it to be disabled. (PD
> > accordingly)
> > 
> > > > go via all GPIO lines and switch them to the known (in software)
> > > > state. This
> > > > approach on the other hand is error prone, because firmware
> > > > should
> > > > know better
> > > > which pin is used for which purpose, no? If you don't trust
> > > > firwmare
> > > > (in some
> > > > cases), then it's a matter of buggy platform that has to be
> > > > quirked
> > > > out.
> > > 
> > > I'm not getting what you mean by "firmware should know better"? So,
> > > basically, and let's take OF as example, you can request a GPIO in
> > > OF
> > > by doing something like:
> > > 
> > >         foo-gpios = <&gpio 1 GPIO_PULL_UP>;
> > > 
> > > In this way, when the consumer driver gets the gpio, all the flags
> > > will
> > > be properly set so that when we set a direction (for example) the
> > > gpiochip's 'set_config()' will be called and the driver does what
> > > it
> > > needs to setup the pull-up. If we want BIAS_DISABLED on the pin,
> > > there's no way to the same as the above. So basically, this can
> > > ever
> > > happen:
> > > 
> > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2227
> > > 
> > > (only possible from the gpiochip cdev interface)
> > > 
> > > So, what I'm proposing is to be possible to do from OF:
> > > 
> > >         foo-gpios = <&gpio 1 GPIO_PULL_DISABLE>;
> > > 
> > > And then we will get into the gpiochip's 'set_config()' to disable
> > > the
> > > pull-up or pull-down.
> > > 
> > > As I said, my device is an input keymap that can export pins as
> > > GPIOs
> > > (to be consumed by gpio_keys). The pins by default have pull-ups
> > > that
> > > can be disabled by doing a device i2c write. I'm just trying to use
> > > the
> > > infrastructure that already exists in gpiolib (for pull-up|down) to
> > > accomplish this. There's no pinctrl driver controlling the pins.
> > > The
> > > device itself controls them and having this device as a pinctrl one
> > > is
> > > not really applicable.
> > 
> > Yes, I have got it eventually. The root cause is that after reset you
> > have a
> > hardware that doesn't disable bias.
> > 
> > Now, we have DT properties for PD and PU, correct?
> > For each requested pin you decide either to leave the state as it is,
> > or
> > apply bias.
> > 
> > in ->probe() of your GPIO you reset hardware and for each GPIO
> > descriptor you
> > set PU flag.
> > In ->request(), don;t know the name by heart, you disable BIAS based
> > on absence
> > of flags, it can be done without an additional properties, purely in
> > the GPIO
> > OF code. Do I understand this correctly?
> > 
> 
> Alright, I think now you got it and we are on the same page. If I
> understood your suggestion, users would just use GPIO_PULL_UP in dtb if
> wanting the default behavior. I would then use the gpiochip 'request()'
> callback to test the for pull-up flag right?

Something like this, yes.

> If I'm getting this right, there's a problem with it...
> gpiod_configure_flags() is called after gpiod_request() which means
> that the gpiod descriptor won't still have the BIAS flags set. And I
> don't think there's a way (at least clean and easy) to get the firmware
> lookup flags from the request callback?
> 
> So, honestly the only option I see to do it without changing gpioblib
> would be to hook this change in output/input callbacks which is far
> from being optimal...
> 
> So, in the end having this explicitly like this feels the best option
> to me. Sure, I can find some workaround in my driver but that does not
> change this...

Ok, let me think about it. Meanwhile, maybe others have better ideas already?

> "
> git grep "PIN_CONFIG_BIAS_DISABLE" drivers/gpio/

Hint: `git grep -lw "PIN_CONFIG_BIAS_DISABLE" -- drivers/gpio`

> drivers/gpio/gpio-aspeed.c:963: else if (param ==
> PIN_CONFIG_BIAS_DISABLE ||
> drivers/gpio/gpio-merrifield.c:197:     if
> ((pinconf_to_config_param(config) == PIN_CONFIG_BIAS_DISABLE) ||
> drivers/gpio/gpio-omap.c:903:   case PIN_CONFIG_BIAS_DISABLE:
> drivers/gpio/gpio-pca953x.c:573:        if (config ==
> PIN_CONFIG_BIAS_DISABLE)
> drivers/gpio/gpio-pca953x.c:592:        case PIN_CONFIG_BIAS_DISABLE:
> "
> 
> AFAICT, the only way this path is possible for these drivers is through
> gpiolib cdev which might not be what the authors of the drivers were
> expecting...

gpio-merrifield is bad example, it has a pin control.
gpio-pca953x as I said should effectively be a pin control driver.

For the two left it might be the case.

-- 
With Best Regards,
Andy Shevchenko


