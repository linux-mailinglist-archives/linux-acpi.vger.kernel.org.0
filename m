Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C648E653217
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Dec 2022 14:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLUNz4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Dec 2022 08:55:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiLUNzz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Dec 2022 08:55:55 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D8C2711
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:55:54 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id i20so13634465qtw.9
        for <linux-acpi@vger.kernel.org>; Wed, 21 Dec 2022 05:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lcgzCV5wGY7yDKITjAxh4gHL95Gn4MOOx5OeTmqN3uM=;
        b=hvpWyBbZancMoHPVJKcSsbqm0S/abWW3JmYEBh8jirAJPlTqgvXkwTMuofvzB8WzsV
         KS7OP2lMkTNJK9rBAKmCYAGGyHqvO8z41jAGurbTQ2ItmRa0GzpECCa3yvpmx+pb84yW
         v30II3ASdei39U7PdgajUA3ziYmBWQtlfz7DMoILwZKs97E84Dfv64Oc/Arq4msr9Zp/
         EeMSdnFGm4XK4tluQkb/FZtnk1ygarSExdDIA2eo5zQMAHmmt6QgHslro6ZHOm4/QJ+u
         752/vA3HNK0CXin4s/ATa7IxrNmmzIilnVK3EgDBXzm/r0prVtboCg3eo66FpXwja2zD
         1/eQ==
X-Gm-Message-State: AFqh2kpU798D0KLr3EkTGBrz7ji2xRjZvD3ztzLVBSofHisAcCu/y5fJ
        yfvoCJ7buY6FP8RK0IbzTtbii0wDwFplCSQ2UFY=
X-Google-Smtp-Source: AMrXdXvixvgTJFMyj78+hXXReGnBTQfwzQnMapn0dnRgqCadvqg25YgOYun9qAxYeNPps5UMmG8I76b9CaMr7FP7zkE=
X-Received: by 2002:ac8:6d2:0:b0:3a7:eaad:3367 with SMTP id
 j18-20020ac806d2000000b003a7eaad3367mr67701qth.153.1671630953685; Wed, 21 Dec
 2022 05:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20221214212447.4058-1-hdegoede@redhat.com>
In-Reply-To: <20221214212447.4058-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 21 Dec 2022 14:55:40 +0100
Message-ID: <CAJZ5v0jDyar7vwgavgcSnW5kHrhWjBy-KC57Xq=S0N-5JUURQw@mail.gmail.com>
Subject: Re: [PATCH] x86/rtc: Simplify PNP ids check
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>, x86@kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Dec 14, 2022 at 10:25 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> compare_pnp_id() already iterates over the single linked pnp_ids list
> starting with the id past to it.
>
> So there is no need for add_rtc_cmos() to call compare_pnp_id()
> for each id on the list.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/rtc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
> index 349046434513..1309b9b05338 100644
> --- a/arch/x86/kernel/rtc.c
> +++ b/arch/x86/kernel/rtc.c
> @@ -138,15 +138,12 @@ static __init int add_rtc_cmos(void)
>         static const char * const ids[] __initconst =
>             { "PNP0b00", "PNP0b01", "PNP0b02", };
>         struct pnp_dev *dev;
> -       struct pnp_id *id;
>         int i;
>
>         pnp_for_each_dev(dev) {
> -               for (id = dev->id; id; id = id->next) {
> -                       for (i = 0; i < ARRAY_SIZE(ids); i++) {
> -                               if (compare_pnp_id(id, ids[i]) != 0)
> -                                       return 0;
> -                       }
> +               for (i = 0; i < ARRAY_SIZE(ids); i++) {
> +                       if (compare_pnp_id(dev->id, ids[i]) != 0)
> +                               return 0;
>                 }
>         }
>  #endif
> --
> 2.38.1
>
