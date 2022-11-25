Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7462B638FF8
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Nov 2022 19:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiKYSiZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Nov 2022 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiKYSiZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Nov 2022 13:38:25 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B4E65D9
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 10:38:24 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id fz10so2997819qtb.3
        for <linux-acpi@vger.kernel.org>; Fri, 25 Nov 2022 10:38:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vxm4AL5YznX9sZH4XFaCWz3qfLoNKm0V3Njv0cCQsiA=;
        b=rTKpolXi79GCCpyYEvMobGfypp+jycnH0ruuo5SsZTdEMnROIU7mTai/935mGIROv8
         hHkloaH+oZl94E+bu7c3lEkv/YxXZsxkVMtsnWrk421bhmuDCLdaRaDzLcyuW6FR3eve
         49KABL9WEalCyZmVoReuArtrr0g+p8XaRDkME2YtE2hBTlyWv56HG45Dzcwkt8bkYb6H
         kJbjOkNntbWBObVbWpDjKhUu6a9kO4E563L4wVEh8bc4xpyOBUMrSJvNAl57dsdDi5XN
         I5+oLvT200XD2Fc9kVtdH89OsY2wDRRsdaahajQlLa3CYZQRP94T8fEi/kavlwLQfY+y
         HP7w==
X-Gm-Message-State: ANoB5pmplYHMtk7+s2uqJYRDHLwpafIsrpJIq7UAyaaRmeLx6ohR7Sxa
        lwRWKezhnrztlZIl1kbUXX7VJWnbVTgpK+SjmiM=
X-Google-Smtp-Source: AA0mqf4qSR32h6edboe76Fg+y/Sd43mKjbDbroUik0QlsZmLI70tBdIPiQAbxWSpARGwVLJbsYS1EfjcBCF/Vh6Z4ZQ=
X-Received: by 2002:ac8:73c4:0:b0:3a5:a53d:a102 with SMTP id
 v4-20020ac873c4000000b003a5a53da102mr37111623qtp.153.1669401503698; Fri, 25
 Nov 2022 10:38:23 -0800 (PST)
MIME-Version: 1.0
References: <20221124105305.13214-1-hdegoede@redhat.com>
In-Reply-To: <20221124105305.13214-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Nov 2022 19:38:12 +0100
Message-ID: <CAJZ5v0iO1xdBwTcJv8hg7-nbnCpMAfxyoxOmxVHbfUC-WrEWaQ@mail.gmail.com>
Subject: Re: [PATCH] PNP: Do not disable devices on suspend when they cannot
 be re-enabled on resume
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 24, 2022 at 11:53 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> On an Advantech MICA-071 tablet, with a builtin barcode scanner connected
> to ttyS0, the following message is shown on suspend:
>
> serial 00:02: disabled
>
> And after suspend/resume trying to use the barcode scanner / ttyS0 shows:
>
> serial 00:02: LSR safety check engaged!
>
> Indicating that the UARTs io-ports are no longer reachable.
>
> This is caused by __pnp_bus_suspend() calling pnp_stop_dev() on the "00:02"
> pnp device on suspend (this outputs the disabled message).
>
> The problem is that pnp_can_write() returns false for the "00:02" pnp
> device, so after disabling it (disabling its decoding of IO addresses)
> during suspend, it cannot be re-enabled.
>
> Add a pnp_can_write() check to the suspend path and only disable devices
> which can actually be re-enabled on resume.
>
> This fixes the Advantech MICA-071's ttyS0 no longer working after
> a suspend/resume.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pnp/driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index c02e7bf643a6..46c534f6b1c9 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -182,7 +182,8 @@ static int __pnp_bus_suspend(struct device *dev, pm_message_t state)
>                         return error;
>         }
>
> -       if (pnp_can_disable(pnp_dev)) {
> +       /* can_write is necessary to be able to re-start the device on resume */
> +       if (pnp_can_disable(pnp_dev) && pnp_can_write(pnp_dev)) {
>                 error = pnp_stop_dev(pnp_dev);
>                 if (error)
>                         return error;
> --

Applied as 6.2 material, thanks!
