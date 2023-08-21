Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77317826EE
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Aug 2023 12:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234608AbjHUKT6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 21 Aug 2023 06:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjHUKT5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Aug 2023 06:19:57 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E93D8;
        Mon, 21 Aug 2023 03:19:55 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3a7491aa219so527498b6e.1;
        Mon, 21 Aug 2023 03:19:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692613195; x=1693217995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1pwCQpskI0ZyDftxOYmx2IzrpxK27DB6PQlzOMS/Gw=;
        b=XklzuJKOgoo+Wz7TBJ6OA2iptC8tSRr09aL5VFrD6HgAf6o5gbHdJhf1FhyMeza0+z
         0+6ROOO+004bkEZeNT+fsXvB/8cPWH7OGNAxxF0J1PA/FhpQqcJQInSGUn/CDf5hEw0+
         eBSMEzE543i7Jo/x+ZNEteCprX1S2JG+2bq1qtZgJ7flT/Y5IAb8doz/k/JJvHkOhJuX
         jPD5u5ZycQeuecp0MalUNqC7eSI1N2Aq6wKhkfsOhyFHeNexLrNArOSlHNQwFsfaHtgY
         L0YF7MMN4820CHYcxdIyUiR8I6gCG5uTcPvoToQkQJ2yNQ59bhpXJ+kSBjH3TxFgKdy7
         wx7Q==
X-Gm-Message-State: AOJu0Yw5DMLPqH5BYMsFSAC1aT3swUi8t/Xp/m2F8cdMpFbCWiJ+ju3l
        0eACWasQZ1gLZTJc1a640L6RPpU6uHmNOsDJcUADWNVm
X-Google-Smtp-Source: AGHT+IFLHqhKOzDTcv0/YpBPc9VdHE75tGVBf/jfDGlim9JZmihkN4lQYf5NzjVkb5Y1RboG7Jr+IWJ30RIjwsRzjxM=
X-Received: by 2002:a4a:c3c8:0:b0:56e:487f:8caa with SMTP id
 e8-20020a4ac3c8000000b0056e487f8caamr5537476ooq.1.1692613194753; Mon, 21 Aug
 2023 03:19:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230821090927.305926-1-hdegoede@redhat.com>
In-Reply-To: <20230821090927.305926-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 21 Aug 2023 12:19:39 +0200
Message-ID: <CAJZ5v0hGkHE5mjoKweXeLUCzyGC-6DG+XQj0dY76dUDj8HrthQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Fix IRQ override quirk for PCSpecialist
 Elimina Pro 16 M
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org, All applicable <stable@vger.kernel.org>
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

On Mon, Aug 21, 2023 at 11:09 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> It turns out that some PCSpecialist Elimina Pro 16 M models
> have "GM6BGEQ" as DMI product-name instead of "Elimina Pro 16 M",
> causing the existing DMI quirk to not work on these models.
>
> The DMI board-name is always "GM6BGEQ", so match on that instead.
>
> Fixes: 56fec0051a69 ("ACPI: resource: Add IRQ override quirk for PCSpecialist Elimina Pro 16 M")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217394#c36
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index a4d9f149b48d..32cfa3f4efd3 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -501,9 +501,13 @@ static const struct dmi_system_id maingear_laptop[] = {
>  static const struct dmi_system_id pcspecialist_laptop[] = {
>         {
>                 .ident = "PCSpecialist Elimina Pro 16 M",
> +               /*
> +                * Some models have product-name "Elimina Pro 16 M",
> +                * others "GM6BGEQ". Match on board-name to match both.
> +                */
>                 .matches = {
>                         DMI_MATCH(DMI_SYS_VENDOR, "PCSpecialist"),
> -                       DMI_MATCH(DMI_PRODUCT_NAME, "Elimina Pro 16 M"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "GM6BGEQ"),
>                 },
>         },
>         { }
> --

Applied as 6.5-rc material, thanks!
