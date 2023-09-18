Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54637A525E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Sep 2023 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIRSxL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 18 Sep 2023 14:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjIRSxL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Sep 2023 14:53:11 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957CF7
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 11:53:05 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5711d5dac14so1206016eaf.0
        for <linux-acpi@vger.kernel.org>; Mon, 18 Sep 2023 11:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695063185; x=1695667985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/P/g/nuFM5ddHvqDFXHC7LPwjQ8Ix1wpoNgLWniDGM=;
        b=NDQV2XnCR9sqba3LySLJ5BUXBCATwLDdZtrL/FkUKn5D+EfBfZHoGF2sGrf4jChmr6
         kgsimpBDKhgVNfWMSsk83ED7bGGTmcs+jJHg366ZI46bARdgfCccF4oJuL1ZI/99vA/P
         B7EWsV4gm0xgY2XxcRV0UoKlJyJkXHMVCJAtiIVPR/ebdDKpjlOKq83QzbCXwD/puXDW
         WFKZZ6w0u9MqCMS7N5kAx+jMIqHO8DExjrGjAnaWQkFR2/D65rDedk34sAA9UzrElIig
         eRCukoaAQZR3rCYikCnunCJIpCjEEjb0uDq+68wHTJADsyFTZEtN6kdZ+xkcFfilgRcb
         gB/g==
X-Gm-Message-State: AOJu0Yxc0jPkYsTQR7WCF6WcbWGj8PKjz6a747dd4VRjtaWtTLBodSbS
        /RWkjrLTb+I4jA3JO3brXMkNiAeRoGOVqbIX6l4=
X-Google-Smtp-Source: AGHT+IFaNR8B3vJLwWyY4IYSlmisEoLuj11U1XDpsySxt1ccYVihAyc3pBFhl7xrjrzvymaXRLUvToiI5HOjEbvhnFc=
X-Received: by 2002:a4a:b483:0:b0:578:a06a:5d8f with SMTP id
 b3-20020a4ab483000000b00578a06a5d8fmr8841245ooo.1.1695063184931; Mon, 18 Sep
 2023 11:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230913111951.30414-1-hdegoede@redhat.com>
In-Reply-To: <20230913111951.30414-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 18 Sep 2023 20:52:54 +0200
Message-ID: <CAJZ5v0gnx7tK1nKb2LJFKf1ieYUYc2iw_q-0TEVuu4wCq81rcA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: resource: Consolidate IRQ trigger-type override
 DMI tables
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 13, 2023 at 1:20 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Before this patch there were 6 dmi_system_id tables. While looking at
> the override_table[] there are only 2 cases:
> 1. irq 1, level, active-low, not-shared, skip-override
> 2. irq 1, edge, activ-low, shared, force-override
>
> Merge the dmi_system_id tables for identical cases together,
> going from 6 dmi_system_id tables and 6 override_table[] entries
> to just 2, one for each case.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note this applies on top of my recent quirk submission for
> the ASUS ExpertBook B1402CBA:
> https://lore.kernel.org/linux-acpi/20230912100827.303590-1-hdegoede@redhat.com/
> ---
>  drivers/acpi/resource.c | 52 +++++++++++++++++------------------------
>  1 file changed, 21 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 8116b55b6c98..c6bb28db8f30 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -385,7 +385,12 @@ unsigned int acpi_dev_get_irq_type(int triggering, int polarity)
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_irq_type);
>
> -static const struct dmi_system_id medion_laptop[] = {
> +/*
> + * DMI matches for boards where the DSDT specifies the kbd IRQ as
> + * level active-low and using the override changes this to rising edge,
> + * stopping the keyboard from working.
> + */
> +static const struct dmi_system_id irq1_level_low_skip_override[] = {
>         {
>                 .ident = "MEDION P15651",
>                 .matches = {
> @@ -407,10 +412,6 @@ static const struct dmi_system_id medion_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
>                 },
>         },
> -       { }
> -};
> -
> -static const struct dmi_system_id asus_laptop[] = {
>         {
>                 .ident = "Asus Vivobook K3402ZA",
>                 .matches = {
> @@ -474,20 +475,28 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
>                 },
>         },
> +       {
> +               .ident = "LG Electronics 17U70P",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
> +               },
> +       },
>         { }
>  };
>
> -static const struct dmi_system_id tongfang_gm_rg[] = {
> +/*
> + * DMI matches for AMD Zen boards where the DSDT specifies the kbd IRQ
> + * as falling edge and this must be overridden to rising edge,
> + * to have a working keyboard.
> + */
> +static const struct dmi_system_id irq1_edge_low_force_override[] = {
>         {
>                 .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
>                 .matches = {
>                         DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>                 },
>         },
> -       { }
> -};
> -
> -static const struct dmi_system_id maingear_laptop[] = {
>         {
>                 .ident = "MAINGEAR Vector Pro 2 15",
>                 .matches = {
> @@ -502,10 +511,6 @@ static const struct dmi_system_id maingear_laptop[] = {
>                         DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
>                 },
>         },
> -       { }
> -};
> -
> -static const struct dmi_system_id pcspecialist_laptop[] = {
>         {
>                 .ident = "PCSpecialist Elimina Pro 16 M",
>                 /*
> @@ -520,17 +525,6 @@ static const struct dmi_system_id pcspecialist_laptop[] = {
>         { }
>  };
>
> -static const struct dmi_system_id lg_laptop[] = {
> -       {
> -               .ident = "LG Electronics 17U70P",
> -               .matches = {
> -                       DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> -                       DMI_MATCH(DMI_BOARD_NAME, "17U70P"),
> -               },
> -       },
> -       { }
> -};
> -
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -541,12 +535,8 @@ struct irq_override_cmp {
>  };
>
>  static const struct irq_override_cmp override_table[] = {
> -       { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -       { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -       { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -       { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -       { pcspecialist_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -       { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +       { irq1_level_low_skip_override, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> +       { irq1_edge_low_force_override, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied, along with the [2/2], as 6.7 material, thanks!
