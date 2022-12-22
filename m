Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFFC65455C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Dec 2022 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLVQpy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Dec 2022 11:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235065AbiLVQpx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Dec 2022 11:45:53 -0500
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673410AF;
        Thu, 22 Dec 2022 08:45:53 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id q10so1569556qvt.10;
        Thu, 22 Dec 2022 08:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3V+V/RxVzQmiAleBn5pDq7PcTx4x79d2e+VRXiuewIo=;
        b=D0Kh2D33rA08h9oAtpZLyXEDdC2mi8q/UKV7VdsOZqXgHEVaLilqTcZM4KvlVHQksR
         i611FhtWnF7QAMVWQ/axWBL4hj5Rar7V8QU8xtYqr+a91NpZI/o+i7Ps8O39//6zC5Xv
         c71wNHerxwm6LTTnumT2y4LfTJPDTbmr9jsC4RolxBc1l8MEzROQkNVP5CrzgLF6MVuC
         I4CiZRFE5dpy6j3aIWN5hXWopMU2gKGOgyZ4B2SRNIqXscy1kMSe1D9f5PgtAWrSn+To
         a09/gYHNtggRAbUIcq5AThuRkeFRfguREW6y4uKiMqTX1VHB/4TL1cl5d5OGwr1aPKuk
         xKYQ==
X-Gm-Message-State: AFqh2kpKYOtYqLDcaNmUNL/U4Sb1hFu9cxnAJBmctoXPZKfBa287ItEP
        xV7mDhS8B1H3YVJkj6jDw/960Hn5r/cJ0mXLKe4=
X-Google-Smtp-Source: AMrXdXufR5CWNI5qpC1KftZBMF/jf+zlhokSALHiyd6CDSS5P2DLg6WV4GE/jdMvuZ2GiL9jIR0eA6+r974Ga1yrOic=
X-Received: by 2002:a05:6214:328f:b0:4b1:8429:a8a7 with SMTP id
 mu15-20020a056214328f00b004b18429a8a7mr365563qvb.52.1671727552188; Thu, 22
 Dec 2022 08:45:52 -0800 (PST)
MIME-Version: 1.0
References: <20221215094443.7466-1-hdegoede@redhat.com>
In-Reply-To: <20221215094443.7466-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Dec 2022 17:45:41 +0100
Message-ID: <CAJZ5v0hrqca-fqSqGDXXKBonsCTOjHHBgOtjqv85oxQQ1hkVyA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Add Asus ExpertBook B2502 to Asus quirks
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org
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

On Thu, Dec 15, 2022 at 10:45 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Asus ExpertBook B2502 has the same keyboard issue as Asus Vivobook
> K3402ZA/K3502ZA. The kernel overrides IRQ 1 to Edge_High when it
> should be Active_Low.
>
> This patch adds the ExpertBook B2502 model to the existing
> quirk list of Asus laptops with this issue.
>
> Fixes: b5f9223a105d ("ACPI: resource: Skip IRQ override on Asus Vivobook S5602ZA")
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2142574
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index f27914aedbd5..e721f2ec014f 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -432,6 +432,13 @@ static const struct dmi_system_id asus_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "S5602ZA"),
>                 },
>         },
> +       {
> +               .ident = "Asus ExpertBook B2502",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B2502CBA"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 6.2-rc material, thanks!
