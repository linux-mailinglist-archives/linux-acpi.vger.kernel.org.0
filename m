Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06568C553
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Feb 2023 19:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjBFSA0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Feb 2023 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjBFSAY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2023 13:00:24 -0500
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E7A2D14F
        for <linux-acpi@vger.kernel.org>; Mon,  6 Feb 2023 10:00:22 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id ee13so5930453edb.5
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2023 10:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rZFGdtC/ZYTZc24VP4JayyDcWEEzKF2fLRc+YRCWN8A=;
        b=LCN3AzqZ5yvOWURLA3ZyKiEL8tVVb7jC5ZMyj6WPxDfcawPzaB0rfr5zsQtUWXNMjR
         5jYueILU/Ub2gQTd5ZLNzTa0DRHlR4shj9iRFrb3NO9EH54k3b9T4BhrQRE+p5ELAr9W
         9vZQhQ9DQ0fXUtbV1DnHlSBRJgaOzyG4136GQbHqj8iVkHpqU0rOI9iwTYkByPkr1bYV
         kqp7uvPBWezHR43u3JJ0sFP56hoD8ueOYr2jrdpLNhiKhTSkcrMW6hbFdPGczLcNsc1b
         HEmS2igB7s+llBXto8DrpYIOsL5elAARW8usu5iznO2SLR3L24wjnMmR7mzhVdOgvktL
         lBAg==
X-Gm-Message-State: AO0yUKUv4pxm3R6zfHYjSTyD8txyUzkprp4ChdamwiJKCy4fN0QsWMMV
        +8eZZopEpfhoKgM9ErFs3O38h4UmtrKO6HQ1J7a+DsKM
X-Google-Smtp-Source: AK7set/t+knst3241qAl9tjBymf6DQh2nI/7rAJNbsmVkNBIcDFUTGpnDK5aKTNHYnz3Azz1x1hnTraKHuHXr7JuMuo=
X-Received: by 2002:a50:d654:0:b0:4aa:a0ee:7ed1 with SMTP id
 c20-20020a50d654000000b004aaa0ee7ed1mr121067edj.58.1675706420883; Mon, 06 Feb
 2023 10:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20230202124449.427651-1-hdegoede@redhat.com>
In-Reply-To: <20230202124449.427651-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 6 Feb 2023 19:00:09 +0100
Message-ID: <CAJZ5v0jtYBR_Fj3cajfXdj5susr4QFXVESQnNGh2kmSJTBscfQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Fix Lenovo Ideapad Z570 DMI match
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
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

On Thu, Feb 2, 2023 at 1:44 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Multiple Ideapad Z570 variants need acpi_backlight=native to force native
> use on these pre Windows 8 machines since acpi_video backlight control
> does not work here.
>
> The original DMI quirk matches on a product_name of "102434U" but other
> variants may have different product_name-s such as e.g. "1024D9U".
>
> Move to checking product_version instead as is more or less standard for
> Lenovo DMI quirks for similar reasons.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index a8c02608dde4..710ac640267d 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -434,7 +434,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>          /* Lenovo Ideapad Z570 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
> +               DMI_MATCH(DMI_PRODUCT_VERSION, "Ideapad Z570"),
>                 },
>         },
>         {
> --

Applied as 6.3 material, thanks!
