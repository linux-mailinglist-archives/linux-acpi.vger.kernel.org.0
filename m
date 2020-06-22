Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29717203BB4
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 18:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgFVQAH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 12:00:07 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41243 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgFVQAG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 12:00:06 -0400
Received: by mail-oi1-f196.google.com with SMTP id a21so16057071oic.8
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jun 2020 09:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ynhz7R9uBmWyPKJa8dbkfW9fP2C4gLLxZ62QNi9gHKg=;
        b=fzMc4n9SVnHcDTUDdRqG3jYx6Wt8OHoO+heRSak0xC88Ab6oFWSEYjCVC5p27zTXyC
         VNpO6rFwagZXc/MTKvgDqeSh+ctV3H8UW1CED8oD1XLMP0geOeu0l1/wQiiIRPkng66h
         5ypeeEK+aPvzqRdJNlIy4ptBMJ0nv5xPfWbjK3Nu33bo8RK4z1Ir6sLRmP3dav+OXUQZ
         klbPeBvki6MbfSM4ah0t6c2fjB01qY5nGJQSa2YBqs/+2JDKB9TumZ6csvfX9yAhthig
         4V2Wtmn+1AAS5rWfaxsy1/Yyyl9BC41c6+N84Z8MWY3d8Q5pJGirPxOr973l0PVC9JZ5
         bgGg==
X-Gm-Message-State: AOAM531fopjkwPO+Myg2r6pNoppyTvN02UoVm+I4vuGuAphs8eL09hsf
        a6mEJnJ5v33A6XM5HfuH82xrW/5w3NWiYtwG70k=
X-Google-Smtp-Source: ABdhPJyBwd2MAi/3MeXFVKNkKMSWs0KKruTBRFqUg6uwLqB9BodXKOIGy1Oe3avjUH4nUnkWoARQkQFik8TJlwnGP2U=
X-Received: by 2002:aca:4cd0:: with SMTP id z199mr13503873oia.110.1592841605200;
 Mon, 22 Jun 2020 09:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <83d51ff2-a359-9a67-10d6-53c9c2287bf8@virtuozzo.com>
In-Reply-To: <83d51ff2-a359-9a67-10d6-53c9c2287bf8@virtuozzo.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 22 Jun 2020 17:59:54 +0200
Message-ID: <CAJZ5v0gQD_T9WmoF4gv-eDpmKto4_c0pJGiy_7FPiipSGOTrQQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI / hotplug / PCI: lost acpiphp_put_context in acpiphp_grab_context()
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jun 13, 2020 at 9:41 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> Fixes: edf5bf34d408 ("ACPI / dock: Use callback pointers from devices' ACPI hotplug contexts")

Thanks for the fix ->

> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index b386995..e49ec95 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -124,6 +124,8 @@ static struct acpiphp_context *acpiphp_grab_context(struct acpi_device *adev)
>         acpi_lock_hp_context();
>         context = acpiphp_get_context(adev);
>         if (!context || context->func.parent->is_going_away) {
> +               if (context)
> +                       acpiphp_put_context(context);

-> but I'd prefer:

        if (context && context->func.parent->is_going_away) {
                      acpiphp_put_context(context);
                      context = NULL;
       }
       if (!context) {

>                 acpi_unlock_hp_context();
>                 return NULL;
>         }
> --

Thanks!
