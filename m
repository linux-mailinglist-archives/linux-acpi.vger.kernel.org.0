Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0496C1F79
	for <lists+linux-acpi@lfdr.de>; Mon, 20 Mar 2023 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjCTSVd convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Mon, 20 Mar 2023 14:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCTSUi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Mar 2023 14:20:38 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35B28E72
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 11:14:01 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id t5so13492105edd.7
        for <linux-acpi@vger.kernel.org>; Mon, 20 Mar 2023 11:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679336003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCHZljsgpMOCce4Hd7OB03dpMt7CDZcJ8BgJ6E+UkS0=;
        b=1rsXLW+QtjJAJuHJluPb/gfgNYsLKlr/1fNRtmcGCOMe/MVMJcPSygTfsGfBB2KyRu
         cDi5Uayd58sYbzIg1EPVAzzyRdM9ZbzDCK+TCoujeezlJZtH5y2bFlyXPYb03MlpIvSH
         hhJOn9PdV4cbXOnGvXMC8gMAAMbovBfXrfA93a8gpZEh4Ci+QnOl3l5lq3bAocqAyYmJ
         FWWY3YeS0MucKrcY2cDw+rQzZbDo4vckchoGtsBF7zErm5LYkzFCKW57aZCxOCfcVDfq
         UXLPz2EqMPzc6N+SR4Gnuzf04KAPhffMNhFvLQ9JDw952XF6d8mM+wmowXpCf4hPEbMS
         WQ+w==
X-Gm-Message-State: AO0yUKXug8OJSUgbj7NRaprRqIuPNmXtlZtajZaaD5QlFWn8PxffSx0d
        s5gvPbx/ZXkucn21eLy2NbpOuAg74YmR72FX/PBfOgnl
X-Google-Smtp-Source: AK7set9ZjI9iEkoPX40/aErwI03rwtXxki3YLpfiJLRip/VLSGDE6Axzyo0TIyx380jEqbBzZMoZP8GrgqCMeS9MNHE=
X-Received: by 2002:a50:f683:0:b0:4fb:c8e3:1ae2 with SMTP id
 d3-20020a50f683000000b004fbc8e31ae2mr261972edn.3.1679336002729; Mon, 20 Mar
 2023 11:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230320155946.489863-1-hdegoede@redhat.com>
In-Reply-To: <20230320155946.489863-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Mar 2023 19:13:11 +0100
Message-ID: <CAJZ5v0ieEPxzkfUNvqx=Ao33fNBZ66MpuWYnLQ_qM3pC1-VpWQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Add backlight=native DMI quirk for Acer
 Aspire 3830TG
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Mon, Mar 20, 2023 at 4:59 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Acer Aspire 3830TG predates Windows 8, so it defaults to using
> acpi_video# for backlight control, but this is non functional on
> this model.
>
> Add a DMI quirk to use the native backlight interface which does
> work properly.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 710ac640267d..c69b42a60427 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -495,6 +495,14 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
>                 },
>         },
> +       {
> +        .callback = video_detect_force_native,
> +        /* Acer Aspire 3830TG */
> +        .matches = {
> +               DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
> +               DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 3830TG"),
> +               },
> +       },
>         {
>          .callback = video_detect_force_native,
>          /* Acer Aspire 4810T */
> --

Applied as 6.3-rc material, thanks!
