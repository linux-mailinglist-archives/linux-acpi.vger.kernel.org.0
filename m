Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05D379ADCE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Sep 2023 01:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbjIKVSb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Sep 2023 17:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbjIKM4w (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Sep 2023 08:56:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE4FCD7;
        Mon, 11 Sep 2023 05:56:48 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="375425742"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="375425742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:56:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="772577626"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="772577626"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 05:56:45 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1qfgT4-008KW5-2E;
        Mon, 11 Sep 2023 15:56:42 +0300
Date:   Mon, 11 Sep 2023 15:56:42 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 6/8] platform/x86: x86-android-tablets: Stop using
 gpiolib private APIs
Message-ID: <ZP8OiuhvgLxAzmVE@smile.fi.intel.com>
References: <20230909141816.58358-1-hdegoede@redhat.com>
 <20230909141816.58358-7-hdegoede@redhat.com>
 <CAHp75Ve888X7xJ0VrQfswaStL8C3SHXjnJV35O2ajZVq6=KfMQ@mail.gmail.com>
 <afda7862-3c36-98d8-43a3-dd67538de923@redhat.com>
 <CAMRc=MdmzPWeZ7CtFe2b6xZFAges2cD-ckq4vn-+52CG=tVRSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdmzPWeZ7CtFe2b6xZFAges2cD-ckq4vn-+52CG=tVRSA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Sep 11, 2023 at 02:49:44PM +0200, Bartosz Golaszewski wrote:
> On Sun, Sep 10, 2023 at 1:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
> > On 9/10/23 10:24, Andy Shevchenko wrote:
> > > On Sat, Sep 9, 2023 at 5:18 PM Hans de Goede <hdegoede@redhat.com> wrote:

...

> > >> +       gpiod = devm_gpiod_get(&x86_android_tablet_device->dev, con_id, dflags);

^^^

> > >> -       *desc = gpiod;
> > >> +       if (desc)
> > >> +               *desc = gpiod;
> > >
> > > Are we expecting that callers may not want the GPIO descriptor out of
> > > this function?
> > > Sounds a bit weird if so.
> >
> > Yes specifically the Charge-enable and OTG (Vboost enable) pins on the
> > bq25892 charger on the Lenovo Yoga Tab 3 just need to be set to a fixed
> > value, so we request the pins with GPIOD_OUT_LOW / _HIGH and then
> > leave them at that value.
> 
> You mean you leak the descriptor? It would warrant either a comment or
> storing the descriptor somewhere and cleaning it up if the device can
> be unbound (I guess it can since the driver can be built as module).

Note devm_*() above.

-- 
With Best Regards,
Andy Shevchenko


