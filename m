Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D5F694F58
	for <lists+linux-acpi@lfdr.de>; Mon, 13 Feb 2023 19:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjBMS1h (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 13 Feb 2023 13:27:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjBMS1Y (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Feb 2023 13:27:24 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7079E212B3
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 10:26:45 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id hx15so34034358ejc.11
        for <linux-acpi@vger.kernel.org>; Mon, 13 Feb 2023 10:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3E25IndkyuH98a664Ju0M71TjbJfS3JQDPKw8I+iwzY=;
        b=qT8CtxNUmJ9rKRtNwRVFfhSEdCJYoa5hW2l1zvVMSGDKwi089VLWTdLtW0uH+4GdtH
         smxfOuNeRAlBhHVF4wx8mmn99ADIvZMZhlOq2Syx/SeSN3k43nNM2ltLMoc4mZyesImN
         bMmNNr63v3eYPUQ2E9kR8q5pFeGkDNA8RrBsnx2wcdt1JMlhX3piu7msNqgPs2YwAdlz
         mxI31Mqmi9Tl0mqKh+9r+9xfVg97IoUqt4ufrrfjSnmiq70cONULENSuo3HW23rcQOIT
         4MKa8XFF3bI7gIqATIlqLVTXyROOQPYRG1Aa7OMF7r4ZzTAU2WeS+aWoKjDxezEVXJ2L
         m6lg==
X-Gm-Message-State: AO0yUKVxXLqLk6+YrD3lG/q3R+oS5A8t4h4fBpBNirB5jENsrkVfGH0X
        j3NKs7h3ukd+0D+JZNPnieIejFOIwsNxAWP+B0K/sios
X-Google-Smtp-Source: AK7set+OT7BC/nfynNSAKSkDXBiopl13dZTcCx5XICqoWKUrdRTTIFwL/FsYCWiZtiAqU/xBNV/zsEkKzM1y804sCWQ=
X-Received: by 2002:a17:907:7e82:b0:8ad:d366:54c4 with SMTP id
 qb2-20020a1709077e8200b008add36654c4mr6070971ejc.4.1676312803921; Mon, 13 Feb
 2023 10:26:43 -0800 (PST)
MIME-Version: 1.0
References: <20230211201333.369286-1-adam.niederer@gmail.com>
In-Reply-To: <20230211201333.369286-1-adam.niederer@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 13 Feb 2023 19:26:32 +0100
Message-ID: <CAJZ5v0hnfPAhbc6qSFESNPO8FnS8TjK56v_n783v+sHZGJtk7g@mail.gmail.com>
Subject: Re: [PATCH] Add IRQ overrides for MAINGEAR Vector Pro 2 models
To:     Adam Niederer <adam.niederer@gmail.com>
Cc:     linux-acpi@vger.kernel.org, lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Feb 11, 2023 at 9:14 PM Adam Niederer <adam.niederer@gmail.com> wrote:
>
> Fix a regression introduced by commit 9946e39fe8d0 ("ACPI: resource: skip
> IRQ override on AMD Zen platforms") on MAINGEAR Vector Pro 2 systems, which
> causes the built-in keyboard to not work. This restores the functionality
> by adding an IRQ override.
>
> No other IRQs were being overridden before, so this should be all that is
> needed for these systems. I have personally tested this on the 15" model
> (MG-VCP2-15A3070T), and I have confirmation that the issue is present on
> the 17" model (MG-VCP2-17A3070T).
>
> Signed-off-by: Adam Niederer <adam.niederer@gmail.com>
>
> ---
>  drivers/acpi/resource.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 192d1784e409..1d9d3364bc2b 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -478,6 +478,24 @@ static const struct dmi_system_id schenker_gm_rg[] = {
>         { }
>  };
>
> +static const struct dmi_system_id maingear_laptop[] = {
> +       {
> +               .ident = "MAINGEAR Vector Pro 2 15",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> +               }
> +       },
> +       {
> +               .ident = "MAINGEAR Vector Pro 2 17",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> +               },
> +       },
> +       { }
> +};
> +
>  struct irq_override_cmp {
>         const struct dmi_system_id *system;
>         unsigned char irq;
> @@ -493,7 +511,7 @@ static const struct irq_override_cmp override_table[] = {
>         { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>         { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
>         { schenker_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> +       { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>  };
>
>  static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> --

Applied as 6.3 material, thanks!
