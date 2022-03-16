Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3EC4DB4FC
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 16:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbiCPPgX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 11:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240167AbiCPPgW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:36:22 -0400
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D226D1B0;
        Wed, 16 Mar 2022 08:35:08 -0700 (PDT)
Received: by mail-yb1-f170.google.com with SMTP id u103so5062950ybi.9;
        Wed, 16 Mar 2022 08:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qc81KKqu2vXutMpBv4wQyiqcwsmSDYyxERClEbxTJg=;
        b=4YAhS2v4H3yVDgk//pNKXoMOmX9SK61OJYUfypuKzjpgF0GNWvXbnQIzcl5Af/qT0U
         6Axm38iRgD2cWDygJq/5YzMuLAEwFzoZSo/RitphPEKe38kd6+BzlgaZxY1FBvYPnPM7
         U/lr9CCA98Rdk/aWmeOh+eIp8Br2UPxlGWqBRkfRG3bULUARlXVudTufmXEJI3h8BgH5
         3UMIvfguw5svAfO94rD9oEVePl2W5j9p5MR4tyhU+0ehSTklpJ18hdsUXatH/69P8KA4
         SPPWhibNpGxrogLJmdSHqa85XttUE5DsB8ftHFTwrretTFG/G+OK1ytCN3kmFt+kQJYs
         CY7g==
X-Gm-Message-State: AOAM533Whuu2CpKLGK8XIsGB4rmb92sZQafAT649rcRmTg25vCpBrdBE
        GghOYnMk3/OERTRor+sMNJsZDO4e6kFZnhBG4Ro=
X-Google-Smtp-Source: ABdhPJxD6K+oAJRuaepuEhRjKpugRM9Fl4EzENwZS4o6XqW65C5AMYXdeC7V0RS+76YoZvM61ECe7bNhRVqkcr9E2Ts=
X-Received: by 2002:a25:9d8a:0:b0:633:9668:c48a with SMTP id
 v10-20020a259d8a000000b006339668c48amr431771ybp.153.1647444907570; Wed, 16
 Mar 2022 08:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com> <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com> <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
In-Reply-To: <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 16:34:56 +0100
Message-ID: <CAJZ5v0jArF+J7UnpAkF-qzS1EqVxuaf7UZYYQV7T_XR3T5tTHw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] ACPI / x86: Add support for LPS0 callback handler
To:     Hans de Goede <hdegoede@redhat.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     Mark Gross <mgross@linux.intel.com>,
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

On Wed, Mar 16, 2022 at 4:02 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Mar 14, 2022 at 2:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi,
> >
> > On 3/14/22 14:32, Limonciello, Mario wrote:
> > > [Public]
> > >
> > >>> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> > >>> +{
> > >>> +   struct lps0_callback_handler *handler;
> > >>> +
> > >>> +   if (!lps0_device_handle || sleep_no_lps0)
> > >>> +           return -ENODEV;
> > >>> +
> > >>> +   handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> > >>> +   if (!handler)
> > >>> +           return -ENOMEM;
> > >>> +   handler->prepare_late_callback = arg->prepare_late_callback;
> > >>> +   handler->restore_early_callback = arg->restore_early_callback;
> > >>> +   handler->context = arg->context;
> > >>> +
> > >>> +   mutex_lock(&lps0_callback_handler_mutex);
> > >>> +   list_add(&handler->list_node, &lps0_callback_handler_head);
> > >>> +   mutex_unlock(&lps0_callback_handler_mutex);
> > >>> +
> > >>> +   return 0;
> > >>> +}
> > >>> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> > >>
> > >> Typically with calls like these we simply let the caller own the struct
> > >> lps0_callback_handler
> > >> and only make the list_add() call here. Typically the struct
> > >> lps0_callback_handler will
> > >> be embedded in the driver_data of the driver registering the handler and it
> > >> will
> > >> call the unregister function before free-ing its driver_data.
> > >>
> > >
> > > When I put this together I was modeling it off of `struct acpi_wakeup_handler`
>
> The structure added by this patch is more like struct dev_pm_ops, though.
>
> > > which the handling and the use in the kernel doesn't seem to follow the design pattern
> > > you describe.
> >
> > Ah, fair enough. Whatever Rafael prefers works for me.
>
> My preference at this point would be to use a notifier chain, unless
> that's not sufficient for some reason, because it appears to match the
> notifier usage model.

Well, I'm actually not sure about that.

> > I pointed this out, because making this change would also make 4/5 a bit
> > cleaner. You are recreating the same struct lps0_callback_handler on
> > stack twice there, which looked weird to me.
> >
> > Note if Rafael wants to stick with the approach from this v3, then
> > I guess that the approach in 4/5 is fine.
> > > Rafael - can you please confirm which direction you want to see here for this?

So the idea is that the PMC driver's "suspend" method needs to be
invoked from acpi_s2idle_prepare_late(), so it doesn't interfere with
the suspend of the other devices in the system and so it can take the
constraints into account.

What is it going to do, in the future, depending on whether or not the
constraints are met?
