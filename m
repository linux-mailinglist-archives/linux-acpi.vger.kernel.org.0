Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1838E4DB55A
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 16:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239562AbiCPPyS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 11:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237471AbiCPPyR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:54:17 -0400
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A91323BC9;
        Wed, 16 Mar 2022 08:53:02 -0700 (PDT)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-2e592e700acso28308357b3.5;
        Wed, 16 Mar 2022 08:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IPhSmbGlMeJLkTs0ubRTFrwDM8Ff07MW9u5ZMeTGhaM=;
        b=7WMg1sUFQYrtnoPj9NKwUEUm3LSE45/iIaWBbm/Hvxnl9qd6/25INg6gCOgCFgP9AD
         XKhIiTVS2PaJSaAwEVbbGFt7U5x6FSBP6auRxdWWqRXsQrZ/G/NKtGxLaSfxnK+PrljH
         HAl27dFhzj4vwlYJN04quIeq3EgFKTLV6CsXERh3qiAmD919z0sthmqBTz+XQV7N1gxB
         IKmaa/seNztRsYY88Z6gZLh+mqZFVw6WpZrVWatL2zZ/wobvgxkrOMGeaV0BFogXP83P
         dWe61D+2/Pg86albHuL00+usbiXojYGbZ8lDjIjm0AUg+EcEVs78KYGfeNozLemBK0/d
         HN0w==
X-Gm-Message-State: AOAM533idfSf4t8FUowyNvF2MMb5hRq+RxWm+l2yBw7y8TINQfcjs5A+
        Lg8dxIJXAw2bwaixLdwssvNZQDY5hdf8wP9fVrABwEwz
X-Google-Smtp-Source: ABdhPJznLjjrhn/T/40aGYIcdsfA4Wza8nOfMZm1zZ2dTNQwXn/NEPR6eYDyeCmVRd0ImkxnI4p4g7Nr2k+ZYn1lTQ4=
X-Received: by 2002:a81:5cf:0:b0:2e5:7477:168e with SMTP id
 198-20020a8105cf000000b002e57477168emr747876ywf.149.1647445981450; Wed, 16
 Mar 2022 08:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com> <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com> <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
 <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com> <BL1PR12MB51571612A9594F5B759EDD81E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB51571612A9594F5B759EDD81E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 16:52:50 +0100
Message-ID: <CAJZ5v0jQKPS-jfRC17SOr_YS=MjZ7Fi62zDyOcgYT4GSzdg-sQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>,
        "Goswami, Sanket" <Sanket.Goswami@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 16, 2022 at 4:43 PM Limonciello, Mario
<Mario.Limonciello@amd.com> wrote:
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Rafael J. Wysocki <rafael@kernel.org>
> > Sent: Wednesday, March 16, 2022 10:35
> > To: Hans de Goede <hdegoede@redhat.com>; Limonciello, Mario
> > <Mario.Limonciello@amd.com>
> > Cc: Mark Gross <mgross@linux.intel.com>; Rafael J . Wysocki
> > <rjw@rjwysocki.net>; open list:X86 PLATFORM DRIVERS <platform-driver-
> > x86@vger.kernel.org>; linux-acpi@vger.kernel.org; S-k, Shyam-sundar
> > <Shyam-sundar.S-k@amd.com>; Goswami, Sanket
> > <Sanket.Goswami@amd.com>
> > Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
> >
> > On Wed, Mar 16, 2022 at 4:02 PM Rafael J. Wysocki <rafael@kernel.org>
> > wrote:
> > >
> > > On Mon, Mar 14, 2022 at 2:37 PM Hans de Goede
> > <hdegoede@redhat.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On 3/14/22 14:32, Limonciello, Mario wrote:
> > > > > [Public]
> > > > >
> > > > >>> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> > > > >>> +{
> > > > >>> +   struct lps0_callback_handler *handler;
> > > > >>> +
> > > > >>> +   if (!lps0_device_handle || sleep_no_lps0)
> > > > >>> +           return -ENODEV;
> > > > >>> +
> > > > >>> +   handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> > > > >>> +   if (!handler)
> > > > >>> +           return -ENOMEM;
> > > > >>> +   handler->prepare_late_callback = arg->prepare_late_callback;
> > > > >>> +   handler->restore_early_callback = arg->restore_early_callback;
> > > > >>> +   handler->context = arg->context;
> > > > >>> +
> > > > >>> +   mutex_lock(&lps0_callback_handler_mutex);
> > > > >>> +   list_add(&handler->list_node, &lps0_callback_handler_head);
> > > > >>> +   mutex_unlock(&lps0_callback_handler_mutex);
> > > > >>> +
> > > > >>> +   return 0;
> > > > >>> +}
> > > > >>> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> > > > >>
> > > > >> Typically with calls like these we simply let the caller own the struct
> > > > >> lps0_callback_handler
> > > > >> and only make the list_add() call here. Typically the struct
> > > > >> lps0_callback_handler will
> > > > >> be embedded in the driver_data of the driver registering the handler
> > and it
> > > > >> will
> > > > >> call the unregister function before free-ing its driver_data.
> > > > >>
> > > > >
> > > > > When I put this together I was modeling it off of `struct
> > acpi_wakeup_handler`
> > >
> > > The structure added by this patch is more like struct dev_pm_ops, though.
> > >
> > > > > which the handling and the use in the kernel doesn't seem to follow the
> > design pattern
> > > > > you describe.
> > > >
> > > > Ah, fair enough. Whatever Rafael prefers works for me.
> > >
> > > My preference at this point would be to use a notifier chain, unless
> > > that's not sufficient for some reason, because it appears to match the
> > > notifier usage model.
> >
> > Well, I'm actually not sure about that.
> >
> > > > I pointed this out, because making this change would also make 4/5 a bit
> > > > cleaner. You are recreating the same struct lps0_callback_handler on
> > > > stack twice there, which looked weird to me.
> > > >
> > > > Note if Rafael wants to stick with the approach from this v3, then
> > > > I guess that the approach in 4/5 is fine.
> > > > > Rafael - can you please confirm which direction you want to see here
> > for this?
> >
> > So the idea is that the PMC driver's "suspend" method needs to be
> > invoked from acpi_s2idle_prepare_late(), so it doesn't interfere with
> > the suspend of the other devices in the system and so it can take the
> > constraints into account.
>
> The reason to do nothing (besides a debug level message right now) with the constraints
> information is that at least on today's OEM platforms there are some instances constraints
> aren't met on Linux that need to be investigated and root caused.  These particular constraints
> don't actually cause problems reaching s0ix residency though.

Why are they useful at all, then?

> >
> > What is it going to do, in the future, depending on whether or not the
> > constraints are met?
>
> The idea was that if constraints were met that it would send the OS_HINT as part of
> amd_pmc_suspend/amd_pmc_resume, and if they aren't met then skip this step.
>
> It would effectively block the system from getting s0ix residency unless the constraints
> are all met.

Why do that?

> Given we know some OEM platforms have problems in current generations
> with constraints it would probably need to be restricted to this behavior only on a future
> SOC that we are confident of all drivers and firmware are doing the right thing.
>
> By passing the information to amd_pmc we can keep that logic restricting the behavior to
> only those platforms that we're confident on that behavior.

Honestly, I'm not quite sure why it is a good idea to prevent the
platform from attempting to get into S0ix via suspend-to-idle in any
case.

You know you have to suspend.  You don't know how much time you will
be suspended.  The constraints can only tell you what's the
lowest-power state you can achieve at this point, but why is it
relevant?
