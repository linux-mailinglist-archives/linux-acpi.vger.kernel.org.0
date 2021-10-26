Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6543B346
	for <lists+linux-acpi@lfdr.de>; Tue, 26 Oct 2021 15:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbhJZNlr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 26 Oct 2021 09:41:47 -0400
Received: from mail-oo1-f48.google.com ([209.85.161.48]:34798 "EHLO
        mail-oo1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJZNlr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2021 09:41:47 -0400
Received: by mail-oo1-f48.google.com with SMTP id e200-20020a4a55d1000000b002b8bedf08cdso548562oob.1
        for <linux-acpi@vger.kernel.org>; Tue, 26 Oct 2021 06:39:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sPdpNdhEgQr3XZkAlGj/1U68Yz/1DqZ+lK3d/3Do1kI=;
        b=3ZHZy89YQ3T9SXXC3qxHrxrKLDlzgwkKrM3IVXF3PIzEtGiTYtixuUuS6Gq++4JbiT
         3YruFwSo3wN+yIdh3XwQecQTQId7SMb3acIynWcmevXynXdJdQ7iTEsgA2LukOAWe34X
         zdrWxS+KyWRdL+2I7eMY9y5J9v49oW+IfsD9YxDxTgeH7FIc26TdgpMDsOAcXnFdtR4a
         f4UlsyvkIbM4RLyJxQczg/9R5lK6jvfHFDi+sL4jYgAl8o/sg8hTkQ6FjLupBWhWGEN8
         KjbCUlerJrlari8FlvWXvACUDS4OW/1WVf3GAn/YpMCnBjhRmrfRkqW2G3+PWt0o3DY9
         EyTA==
X-Gm-Message-State: AOAM533CtixdxwQf9F2kDzIqgDeuK65PjmvZZcuujvGyTFfDa98+1zEn
        cWAvNMFK2x7x61CC9iVxMA8LAg3Cmo4VDOOBuqI=
X-Google-Smtp-Source: ABdhPJx/wqEGTePFMFclpkmPhcdNxkJpkFyOT3v/Ix+jneaEdSd4e/S8SpbjP7gXT7eS+S+DVMibjypgCk5QOmwYxZM=
X-Received: by 2002:a05:6820:54e:: with SMTP id n14mr17353382ooj.89.1635255563223;
 Tue, 26 Oct 2021 06:39:23 -0700 (PDT)
MIME-Version: 1.0
References: <20211025061601.7866-1-hui.wang@canonical.com>
In-Reply-To: <20211025061601.7866-1-hui.wang@canonical.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Oct 2021 15:39:06 +0200
Message-ID: <CAJZ5v0jeK8TJ7fnD8ZLXUKhCSQiDt=DG669jx8CzfK_NRwzUpQ@mail.gmail.com>
Subject: Re: [RESEND][For 5.16][PATCH] ACPI: resources: Add one more Medion
 model in IRQ override quirk
To:     Hui Wang <hui.wang@canonical.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>, dirksche@posteo.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 25, 2021 at 8:16 AM Hui Wang <hui.wang@canonical.com> wrote:
>
> The Medion s17 series laptops have the same issue on the keyboard
> as the s15 series, if skipping to call acpi_get_override_irq(), the
> keyboard could work well. So put the DMI info of s17 series in the
> IRQ override quirk table as well.
>
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
> Tested-by: dirksche <dirksche@posteo.de>
> Signed-off-by: Hui Wang <hui.wang@canonical.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 7bf38652e6ac..3c25ce8c95ba 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -389,6 +389,13 @@ static const struct dmi_system_id medion_laptop[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "M15T"),
>                 },
>         },
> +       {
> +               .ident = "MEDION S17405",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "M17T"),
> +               },
> +       },
>         { }
>  };
>
> --

Applied as 5.16 material, thanks!
