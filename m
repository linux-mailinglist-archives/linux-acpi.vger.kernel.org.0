Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9569FBAF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Feb 2023 20:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBVTGQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Feb 2023 14:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBVTGP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Feb 2023 14:06:15 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CAC39B91
        for <linux-acpi@vger.kernel.org>; Wed, 22 Feb 2023 11:06:14 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id ee7so19509180edb.2
        for <linux-acpi@vger.kernel.org>; Wed, 22 Feb 2023 11:06:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z/d1OEn1ywCwf97F81gUe4IIg1dIA/FaHEGY9qvhTho=;
        b=tY1fdJPGzc54/5FmfD0WkO9Ur8NBydWAg/JpO0GpbVN2t7foU5rzTlhTdbyZlS+8KD
         G8tEKy6d5c9NU30v3R63Vnh35QQy10Xi4OEuVvQSoRZ/ZwBWcpXUEo7uzci7H1Wd1fKo
         jnK/wLKqhAA62GYT60ZAhIOAXcv4J+QKKRQHyk+ssvfnEF9fRSqPdfEMst0jsKyhHlUv
         MKsIIe3fIJUa3oGAiFMGMa/2zwmTwopJcDd8Cli7WzbBX9FovnCcS9bOHRTMiN46DyhF
         +6Ni0sn045k+aO27ro6SHhuX8P2C3spCQfxgscnZaqRzoK7cF6IANVVPJPcVtD98hjFs
         Ampg==
X-Gm-Message-State: AO0yUKUAgroo1XBOeY5hKqGpIudm3loCXreoYMudRo46OTmgAmpdNQCy
        yN3IYrgw5HlGi2CyymyzneMki/OhWv4lVyZQzFg=
X-Google-Smtp-Source: AK7set9D0G6KrL3l+QBtvjr0g43BhC/pchGmgMb+O/XFM1ra4DmruYrhJMDEHK9YZuv13bD1AXXRAdPoUYPzVgZm8eA=
X-Received: by 2002:a05:6402:3216:b0:4ad:738b:66ff with SMTP id
 g22-20020a056402321600b004ad738b66ffmr6113129eda.2.1677092772613; Wed, 22 Feb
 2023 11:06:12 -0800 (PST)
MIME-Version: 1.0
References: <20230216080115.36485-1-hejsekvojtech@tutanota.com>
In-Reply-To: <20230216080115.36485-1-hejsekvojtech@tutanota.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Feb 2023 20:06:01 +0100
Message-ID: <CAJZ5v0gPVH1E5Hd8N8128nH0EVsZ-rJKOBP+UT_-tbmcWKY+gw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on Asus Expertbook B2402FBA
To:     Vojtech Hejsek <hejsekvojtech@gmail.com>
Cc:     rafael@kernel.org, linux-acpi@vger.kernel.org
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

On Thu, Feb 16, 2023 at 9:01 AM Vojtech Hejsek <hejsekvojtech@gmail.com> wrote:
>
> From: Vojtech Hejsek <hejsekvojtech@gmail.com>
>
> The Asus Expertbook B2502FBA has IRQ 1 described as Active_Low
> in its ACPI table. However, the kernel overrides this and sets it to
> Edge_High, which prevents the internal keyboard from working properly.
>
> Adding this laptop model to the override_table fixes the issue.
>
> Signed-off-by: Vojtech Hejsek <hejsekvojtech@gmail.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 192d1784e..950883799 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -439,6 +439,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "B2402CBA"),
>                 },
>         },
> +       {
> +               .ident = "Asus ExpertBook B2402FBA",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B2402FBA"),
> +               },
> +       },
>         {
>                 .ident = "Asus ExpertBook B2502",
>                 .matches = {
> --

Applied as 6.3-rc material, thanks!
