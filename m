Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588854DB3DC
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Mar 2022 16:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235064AbiCPPEV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Mar 2022 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbiCPPEU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2022 11:04:20 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BDDD1;
        Wed, 16 Mar 2022 08:03:05 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-2db2add4516so26819407b3.1;
        Wed, 16 Mar 2022 08:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T3SJ5YDfAg8vxk1lUsDwNCTnUNWTHuR0rmjK28qtH6A=;
        b=O1jvcTCZKE+RdBAVzuf2wkBlSPe7CjGnXjGauF7C9qyBFb6ADMe4vcHs9OJEUM7a4J
         bamEuV8o7QBVwwhfqV3J2roYgil3Ty/U8aLKN8kYWIInpFb5t7aDraVybZqcLV+ybPJs
         MCwi0PoOxPiOruJ7zU1cpkjoIUYKBnOU3NqW/J6BCIRR0UTsUf3XBRF7HaSs1rJb9ks3
         pMN0JBL6YggwgzM3rq0ZjHbU4HmnN7xEb7UWrkOZiXa0zX5mO1TjsPdMoJh1ejS8I3MP
         l3/wLHNHq64reyR9jp/9KsidZmqOr7u+FE7kOXIz+17ZqmTCMazqdRuB+VlVYXXvo+Jn
         KQhA==
X-Gm-Message-State: AOAM532yOi4Y//UuwII6hlnO9rb0mrp7/XvH7cT8s6iJJcTB+G4pk4/1
        r3dAdJzRuJjnIIEcCx7hYc6e1yYOD90+N71grWYn+Mbxye8=
X-Google-Smtp-Source: ABdhPJx8XwkPb1qcu9vvLsSY/8j8oi5nMsx+tdOnwwU214adK0Mui6x11R9aruJ0nRP2rnd7nNv7wBdA7ed1eIaDe1w=
X-Received: by 2002:a81:36cf:0:b0:2e5:2597:a026 with SMTP id
 d198-20020a8136cf000000b002e52597a026mr452477ywa.301.1647442984221; Wed, 16
 Mar 2022 08:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220314050340.1176-1-mario.limonciello@amd.com>
 <0101142d-3ea6-a47b-be26-76aaaac46b0a@redhat.com> <BL1PR12MB5157664C2AA7D80E7DF48EC9E20F9@BL1PR12MB5157.namprd12.prod.outlook.com>
 <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com>
In-Reply-To: <8841ecb6-6c2c-164f-76df-54c4410faa20@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Mar 2022 16:02:53 +0100
Message-ID: <CAJZ5v0gFzDAKHxDLf7Wq52fcGPx+jTWMqBb9oNWuqOSDJrgb1g@mail.gmail.com>
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

On Mon, Mar 14, 2022 at 2:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 3/14/22 14:32, Limonciello, Mario wrote:
> > [Public]
> >
> >>> +int acpi_register_lps0_callbacks(struct lps0_callback_handler *arg)
> >>> +{
> >>> +   struct lps0_callback_handler *handler;
> >>> +
> >>> +   if (!lps0_device_handle || sleep_no_lps0)
> >>> +           return -ENODEV;
> >>> +
> >>> +   handler = kmalloc(sizeof(*handler), GFP_KERNEL);
> >>> +   if (!handler)
> >>> +           return -ENOMEM;
> >>> +   handler->prepare_late_callback = arg->prepare_late_callback;
> >>> +   handler->restore_early_callback = arg->restore_early_callback;
> >>> +   handler->context = arg->context;
> >>> +
> >>> +   mutex_lock(&lps0_callback_handler_mutex);
> >>> +   list_add(&handler->list_node, &lps0_callback_handler_head);
> >>> +   mutex_unlock(&lps0_callback_handler_mutex);
> >>> +
> >>> +   return 0;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(acpi_register_lps0_callbacks);
> >>
> >> Typically with calls like these we simply let the caller own the struct
> >> lps0_callback_handler
> >> and only make the list_add() call here. Typically the struct
> >> lps0_callback_handler will
> >> be embedded in the driver_data of the driver registering the handler and it
> >> will
> >> call the unregister function before free-ing its driver_data.
> >>
> >
> > When I put this together I was modeling it off of `struct acpi_wakeup_handler`

The structure added by this patch is more like struct dev_pm_ops, though.

> > which the handling and the use in the kernel doesn't seem to follow the design pattern
> > you describe.
>
> Ah, fair enough. Whatever Rafael prefers works for me.

My preference at this point would be to use a notifier chain, unless
that's not sufficient for some reason, because it appears to match the
notifier usage model.

> I pointed this out, because making this change would also make 4/5 a bit
> cleaner. You are recreating the same struct lps0_callback_handler on
> stack twice there, which looked weird to me.
>
> Note if Rafael wants to stick with the approach from this v3, then
> I guess that the approach in 4/5 is fine.
> > Rafael - can you please confirm which direction you want to see here for this?

Done above.
