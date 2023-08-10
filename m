Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7E2777B41
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Aug 2023 16:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjHJOtp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 10 Aug 2023 10:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbjHJOtp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Aug 2023 10:49:45 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49AF2106;
        Thu, 10 Aug 2023 07:49:44 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-56dd9ae2a5fso65171eaf.0;
        Thu, 10 Aug 2023 07:49:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678984; x=1692283784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMzgW+3jzEv/ecQrQa5Qs5BoMZYlUEy0gREGzAbobF4=;
        b=PcrPjuLds6y0oCV/wKDHaB/TeFYLuZGgJRzAO+smP3gFFtuZfZezUXtsMrAtlTSsaF
         yHLrXEPVnBy5j0aqQHzG1pcuVcW8e/t4a7TlWK92iOcxxufoGz6Ig1UwYF+lpJOIuENw
         28hG5daCFqd4GEyvL4dqHvrxg5MBb9BXuK0XoJokw7jsi0xSRc3mb4kCXKpkJnLGESeR
         /0HBTRcBvRspodFwzpRp0IF2R1QoJ1m+52L2Hw4DINClq2oyc8hzZBST03D0YMbnWkAb
         ZXiJKE4I+t+o1kiGwiB4xx2GfJw/EIgDUCt/fyNmcZ+cKdiCfJJ/Ao8KQw8tGqUciODS
         cO0g==
X-Gm-Message-State: AOJu0YwmM001FnPVv+SqajsKI6VUw5Y8fs3r5qeAihQ0NllBUAvKr1pl
        Qk0eeM+xra526muVSDJu2bM+DQ/w7Jx2QbE6d1M=
X-Google-Smtp-Source: AGHT+IHV+Te+ZF4lEDRo0HwOLd5Evjv0bTsSv5sNdWTyzooon9iztBBVQu0huihwds5RKBsy7qk8LjI+k7gEH/lG0ZM=
X-Received: by 2002:a05:6820:210a:b0:56d:6bd4:4db5 with SMTP id
 cd10-20020a056820210a00b0056d6bd44db5mr2065984oob.0.1691678983854; Thu, 10
 Aug 2023 07:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230810090011.104770-1-hdegoede@redhat.com>
In-Reply-To: <20230810090011.104770-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 10 Aug 2023 16:49:32 +0200
Message-ID: <CAJZ5v0h=gPsKVHJYN0PjVgqNp4BWND8Psi1y-cu3R-WYrK=45g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add IRQ override quirk for PCSpecialist
 Elimina Pro 16 M
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        August Wikerfors <git@augustwikerfors.se>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Aug 10, 2023 at 11:00 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The PCSpecialist Elimina Pro 16 M laptop model is a Zen laptop which
> needs to use the MADT IRQ settings override and which does not have
> an INT_SRC_OVR entry for IRQ 1 in its MADT.
>
> So this model needs a DMI quirk to enable the MADT IRQ settings override
> to fix its keyboard not working.
>
> Fixes: a9c4a912b7dc ("ACPI: resource: Remove "Zen" specific match and quirks")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c18
> Cc: Mario Limonciello <mario.limonciello@amd.com>
> Cc: Linux regressions mailing list <regressions@lists.linux.dev>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8e32dd5776f5..a4d9f149b48d 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -498,6 +498,17 @@ static const struct dmi_system_id maingear_laptop[] = {
>         { }
>  };
>
> +static const struct dmi_system_id pcspecialist_laptop[] = {
> +       {
> +               .ident = "PCSpecialist Elimina Pro 16 M",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
> +               },
> +       },
> +       { }
> +};
> +
>  static const struct dmi_system_id lg_laptop[] = {
>         {
>                 .ident = "LG Electronics 17U70P",
> @@ -523,6 +534,7 @@ static const struct irq_override_cmp override_table[] = {
>         { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>         { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +       { pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>         { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>  };
>
> --

Applied and added to the linux-next branch in linux-pm.git, thanks!
