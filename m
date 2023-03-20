Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADF6C1F55
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Mar 2023 19:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjCTSRD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 20 Mar 2023 14:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjCTSQj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 14:16:39 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F6033CF0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 11:10:34 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id i5so3347077eda.0
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 11:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679335758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDl1etOZgUoefBUpnn/XUGFBuw7sKmRqtJivVKeq0h4=;
        b=iT8C2P4XI0jnGO50M8KKQ1dlE8BcBZ2a6DM9EaLBZzXhf12HFGfONnP5wic7J0+Kf7
         WJ0wMfTWA4x/9YyQ8l17iJ9wEc8n5tSp+aMoO7bwl3eMe0Awa3E/quqSThsz9Fg6kMYT
         W+gXjB4Hdse7qWYUrHuzwZ6ny34OfHP4UokJXU7hO1+mQz7DB7DguVRNey223CBXhp7N
         6ApYofySYSisIqYb6NXMwirNB8u8jG8g/LmUCXhhG9hmngyD6fdUqqLZPawY7XQPBWrU
         qliEsKnqnZeMvcAkGy0xzDuNI18KLB4fX35pTNr0Bv/Q8+BPtW06Smex934L5RXGIEkR
         NWJg==
X-Gm-Message-State: AO0yUKU6uKjllSefyTx67umCNNw07o3FzZkWC8vNVk51pVbEXErXfT8V
        LP2v/iDrATKhSN+rJ0xn2WEdh8lo5up5ME7B8HMssXFL
X-Google-Smtp-Source: AK7set+ew1RUh3hLQjcIjINL0seq79UukE/C0J2hr4cmo6dLSpzFn+BPzrgbK4hVDmXcfkZer3PdGtpGxIMNHGYatjQ=
X-Received: by 2002:a17:907:86a9:b0:934:b5d6:14d0 with SMTP id
 qa41-20020a17090786a900b00934b5d614d0mr2219166ejc.2.1679335758547; Mon, 20
 Mar 2023 11:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAN8-kNUhnWxLoAGF7tXsknxRKztNT_fSBUgULLhDyyp4388yBg@mail.gmail.com>
In-Reply-To: <CAN8-kNUhnWxLoAGF7tXsknxRKztNT_fSBUgULLhDyyp4388yBg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 19:09:07 +0100
Message-ID: <CAJZ5v0gwy7cUuCewySuQusMYJ5ntccKTcue6iDNF_gAEjhFDNQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add Medion S17413 to IRQ override quirk
To:     obiwac <obiwac@gmail.com>
Cc:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sun, Mar 19, 2023 at 3:12 AM obiwac <obiwac@gmail.com> wrote:
>
> Add DMI info of the Medion S17413 (board M1xA) to the IRQ override
> quirk table. This fixes the keyboard not working on these laptops.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> Signed-off-by: Aymeric Wibo <obiwac@gmail.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 192d1784e..9e1ab01d4 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -400,6 +400,13 @@ static const struct dmi_system_id medion_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "M17T"),
>                 },
>         },
> +       {
> +               .ident = "MEDION S17413",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied 6.3-rc material, but please teach your email client to
preserve white space.

Thanks!
