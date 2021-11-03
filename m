Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E1644484F
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 19:34:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhKCSgn (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 14:36:43 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:36522 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbhKCSgi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Nov 2021 14:36:38 -0400
Received: by mail-oi1-f179.google.com with SMTP id q124so5084269oig.3
        for <linux-acpi@vger.kernel.org>; Wed, 03 Nov 2021 11:34:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXTu6Za/FuuoD7ttB9RxdK84YfyIHC3vzA4pxKQJVv8=;
        b=RmQ+2ZCRZ/OOjTbDb3CMVA/w/Ggc8xkrIce+Gxyada8Cit6NlSAsHvqvuutnOoYNlf
         5o5Asfd59pfiIFZGtivXCksu6OfhsmQPL3GzJ1IIPNUrFEdggbGt0qxx91GCyuCqChZb
         0CbXhDqaErJo3/g5QYWdKCbTir+sA+q4wph5Wuc2iZ3jqpszIspYHh0kAY9w9w/fKY1d
         Bsar4yRlCMpujx2uuDToYS1diNrG99F0W234HIHU2yhrlW2oDMIx54Gh02JoJTHGe9h9
         3h81+NCK2Rfa386dMyVcA+PHTvNLz2366K64ENMEnHXcs47BH1/vOizU/tNYxxCvDEJV
         wN1Q==
X-Gm-Message-State: AOAM532lcwlrV62PqqYnQpHC5UqJ15n/78XacqwrOpFzabssZatPu6w+
        T2nQkfCOPDw/3Chak91YBi7PQLOxbE1PcT38i/I=
X-Google-Smtp-Source: ABdhPJxZ7rrIQaYDKEdF8ti3PyyOQuaY6Q7ROAXLMtQwGttlTIvwJosPNBlWix1r9gB0dTt7hG0n91Scjddx6X/XQRQ=
X-Received: by 2002:a05:6808:128d:: with SMTP id a13mr12324024oiw.51.1635964441055;
 Wed, 03 Nov 2021 11:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20211103142620.36480-1-hdegoede@redhat.com>
In-Reply-To: <20211103142620.36480-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 3 Nov 2021 19:33:50 +0100
Message-ID: <CAJZ5v0hgHc6jTdPj1+ZBAZkDc+APDgH0Q2BFRQkxhzFLQsiB+A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: video: Drop dmi_system_id.ident settings from video_detect_dmi_table[]
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tsuchiya Yuto <kitakar@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 3, 2021 at 3:26 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The .ident field of the dmi_system_id structs in the
> video_detect_dmi_table[] is not used by the code.
>
> Change all .ident = "..." assignments to comments, this reduces the
> size of video_detect.o / video.ko by about 1500 bytes.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/video_detect.c | 70 ++++++++++++++++++-------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
> index 33474fd96991..7a1f8e823208 100644
> --- a/drivers/acpi/video_detect.c
> +++ b/drivers/acpi/video_detect.c
> @@ -115,7 +115,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>          */
>         {
>          .callback = video_detect_force_vendor,
> -        .ident = "X360",
> +        /* X360 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "X360"),
> @@ -124,7 +124,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_vendor,
> -       .ident = "Asus UL30VT",
> +       /* Asus UL30VT */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "UL30VT"),
> @@ -132,7 +132,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_vendor,
> -       .ident = "Asus UL30A",
> +       /* Asus UL30A */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK Computer Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "UL30A"),
> @@ -140,7 +140,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_vendor,
> -       .ident = "GIGABYTE GB-BXBT-2807",
> +       /* GIGABYTE GB-BXBT-2807 */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "GIGABYTE"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GB-BXBT-2807"),
> @@ -148,7 +148,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_vendor,
> -       .ident = "Sony VPCEH3U1E",
> +       /* Sony VPCEH3U1E */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "VPCEH3U1E"),
> @@ -164,7 +164,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>          */
>         {
>          .callback = video_detect_force_video,
> -        .ident = "ThinkPad T420",
> +        /* ThinkPad T420 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T420"),
> @@ -172,7 +172,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_video,
> -        .ident = "ThinkPad T520",
> +        /* ThinkPad T520 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T520"),
> @@ -180,7 +180,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_video,
> -        .ident = "ThinkPad X201s",
> +        /* ThinkPad X201s */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201s"),
> @@ -188,7 +188,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_video,
> -        .ident = "ThinkPad X201T",
> +        /* ThinkPad X201T */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad X201T"),
> @@ -199,7 +199,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugs.freedesktop.org/show_bug.cgi?id=81515 */
>          .callback = video_detect_force_video,
> -        .ident = "HP ENVY 15 Notebook",
> +        /* HP ENVY 15 Notebook */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "HP ENVY 15 Notebook PC"),
> @@ -207,7 +207,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 870Z5E/880Z5E/680Z5E",
> +        /* SAMSUNG 870Z5E/880Z5E/680Z5E */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "870Z5E/880Z5E/680Z5E"),
> @@ -215,7 +215,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V",
> +        /* SAMSUNG 370R4E/370R4V/370R5E/3570RE/370R5V */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME,
> @@ -225,7 +225,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1186097 */
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 3570R/370R/470R/450R/510R/4450RV",
> +        /* SAMSUNG 3570R/370R/470R/450R/510R/4450RV */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME,
> @@ -235,7 +235,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1557060 */
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 670Z5E",
> +        /* SAMSUNG 670Z5E */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "670Z5E"),
> @@ -244,7 +244,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1094948 */
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 730U3E/740U3E",
> +        /* SAMSUNG 730U3E/740U3E */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "730U3E/740U3E"),
> @@ -253,7 +253,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugs.freedesktop.org/show_bug.cgi?id=87286 */
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D",
> +        /* SAMSUNG 900X3C/900X3D/900X3E/900X4C/900X4D */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME,
> @@ -263,7 +263,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1272633 */
>          .callback = video_detect_force_video,
> -        .ident = "Dell XPS14 L421X",
> +        /* Dell XPS14 L421X */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "XPS L421X"),
> @@ -272,7 +272,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1163574 */
>          .callback = video_detect_force_video,
> -        .ident = "Dell XPS15 L521X",
> +        /* Dell XPS15 L521X */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "XPS L521X"),
> @@ -281,7 +281,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.kernel.org/show_bug.cgi?id=108971 */
>          .callback = video_detect_force_video,
> -        .ident = "SAMSUNG 530U4E/540U4E",
> +        /* SAMSUNG 530U4E/540U4E */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "SAMSUNG ELECTRONICS CO., LTD."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "530U4E/540U4E"),
> @@ -290,7 +290,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         /* https://bugs.launchpad.net/bugs/1894667 */
>         {
>          .callback = video_detect_force_video,
> -        .ident = "HP 635 Notebook",
> +        /* HP 635 Notebook */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "HP 635 Notebook PC"),
> @@ -301,7 +301,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1201530 */
>          .callback = video_detect_force_native,
> -        .ident = "Lenovo Ideapad S405",
> +        /* Lenovo Ideapad S405 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_BOARD_NAME, "Lenovo IdeaPad S405"),
> @@ -310,7 +310,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1187004 */
>          .callback = video_detect_force_native,
> -        .ident = "Lenovo Ideapad Z570",
> +        /* Lenovo Ideapad Z570 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "102434U"),
> @@ -318,7 +318,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_native,
> -        .ident = "Lenovo E41-25",
> +        /* Lenovo E41-25 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "81FS"),
> @@ -326,7 +326,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_native,
> -        .ident = "Lenovo E41-45",
> +        /* Lenovo E41-45 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "82BK"),
> @@ -335,7 +335,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1217249 */
>          .callback = video_detect_force_native,
> -        .ident = "Apple MacBook Pro 12,1",
> +        /* Apple MacBook Pro 12,1 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "MacBookPro12,1"),
> @@ -343,7 +343,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_native,
> -        .ident = "Dell Vostro V131",
> +        /* Dell Vostro V131 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Vostro V131"),
> @@ -352,7 +352,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.redhat.com/show_bug.cgi?id=1123661 */
>          .callback = video_detect_force_native,
> -        .ident = "Dell XPS 17 L702X",
> +        /* Dell XPS 17 L702X */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Dell System XPS L702X"),
> @@ -360,7 +360,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_native,
> -        .ident = "Dell Precision 7510",
> +        /* Dell Precision 7510 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Precision 7510"),
> @@ -368,7 +368,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_native,
> -        .ident = "Acer Aspire 5738z",
> +        /* Acer Aspire 5738z */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "Aspire 5738"),
> @@ -378,7 +378,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         {
>          /* https://bugzilla.kernel.org/show_bug.cgi?id=207835 */
>          .callback = video_detect_force_native,
> -        .ident = "Acer TravelMate 5735Z",
> +        /* Acer TravelMate 5735Z */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate 5735Z"),
> @@ -387,7 +387,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_native,
> -       .ident = "ASUSTeK COMPUTER INC. GA401",
> +       /* ASUSTeK COMPUTER INC. GA401 */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GA401"),
> @@ -395,7 +395,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_native,
> -       .ident = "ASUSTeK COMPUTER INC. GA502",
> +       /* ASUSTeK COMPUTER INC. GA502 */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GA502"),
> @@ -403,7 +403,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>         .callback = video_detect_force_native,
> -       .ident = "ASUSTeK COMPUTER INC. GA503",
> +       /* ASUSTeK COMPUTER INC. GA503 */
>         .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "GA503"),
> @@ -416,7 +416,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>          */
>         {
>          .callback = video_detect_force_none,
> -        .ident = "Dell OptiPlex 9020M",
> +        /* Dell OptiPlex 9020M */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "OptiPlex 9020M"),
> @@ -424,7 +424,7 @@ static const struct dmi_system_id video_detect_dmi_table[] = {
>         },
>         {
>          .callback = video_detect_force_none,
> -        .ident = "MSI MS-7721",
> +        /* MSI MS-7721 */
>          .matches = {
>                 DMI_MATCH(DMI_SYS_VENDOR, "MSI"),
>                 DMI_MATCH(DMI_PRODUCT_NAME, "MS-7721"),
> --

Applied as 5.16-rc material along with the [2/2], thanks!
