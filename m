Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE163833B3
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 17:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbhEQPBr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 11:01:47 -0400
Received: from mail-oo1-f43.google.com ([209.85.161.43]:38508 "EHLO
        mail-oo1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbhEQO7p (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:59:45 -0400
Received: by mail-oo1-f43.google.com with SMTP id o66-20020a4a44450000b029020d44dea886so1526906ooa.5
        for <linux-acpi@vger.kernel.org>; Mon, 17 May 2021 07:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=atENKM8RHR2PmMdm0O+HISnGb/Iel+KVJ0/+xhHNr1c=;
        b=NUveB4eLY98NWNcLeokCFPlDvop6MWb4EfUnlD8aRNXTzVevL8Qvr1ILUReURnNLRm
         M2kM9BtctTFBDHoBKxTBRrvcJDp9EPub2GwHFhzXoFrWOGSu0G/GKOFFhphVNkFvEGzn
         j3WAdOL4xqXwMdgT9teP8GOo8ABzMl/LyTfOCR9NzHp4z3WDuSXjwsriglbM1QLwf2DU
         2RnXMfIu/UFo652dkLD7B/+euK7R7oW2BnJsJNQ17GfNQYXVMu3xZG+iuHmx1zkUzuT4
         IZyPzRrbKFyXv/p0xJ0P2GRaCzjvMQoGNTytEII6VnnUTxMbz/2OjxaR23FQvWbG8gMd
         0aSw==
X-Gm-Message-State: AOAM530OP66xz7HuKtC3KA0/9iCg1A54aW68myqHzat98M2MT3jpZfUG
        hpkJjeFIg+lU23MEAx5xwuEEz+QkBGX//Cn/GEY=
X-Google-Smtp-Source: ABdhPJz+YzUcKqIDs59d2nx3ni6DETB2lkdbqrNIXV3xpuTn2stBO2K3wquv5HzZK4F6uWFFPKzJtPquTvlCUumDf2M=
X-Received: by 2002:a4a:d781:: with SMTP id c1mr272158oou.44.1621263508264;
 Mon, 17 May 2021 07:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <31c6013e-1acd-4d2f-f0d6-baec208ff292@gmail.com>
In-Reply-To: <31c6013e-1acd-4d2f-f0d6-baec208ff292@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:58:17 +0200
Message-ID: <CAJZ5v0j1mohTLymU1ChU2jEW6S=PdsAV-gPiV+N4ej32ECbpEw@mail.gmail.com>
Subject: Re: [PATCH] pnp: Switch to dev_dbg
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 12:25 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Debug output in dmesg log may confuse users. Therefore let's restrict
> debug output to cases where DEBUG is defined or dynamic debug output
> is enabled for the respective code piece.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pnp/core.c     | 5 ++---
>  drivers/pnp/resource.c | 2 +-
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index ccdfbf397..4df5aa6a3 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -215,9 +215,8 @@ int pnp_add_device(struct pnp_dev *dev)
>         for (id = dev->id; id; id = id->next)
>                 len += scnprintf(buf + len, sizeof(buf) - len, " %s", id->id);
>
> -       dev_printk(KERN_DEBUG, &dev->dev, "%s device, IDs%s (%s)\n",
> -                  dev->protocol->name, buf,
> -                  dev->active ? "active" : "disabled");
> +       dev_dbg(&dev->dev, "%s device, IDs%s (%s)\n", dev->protocol->name, buf,
> +               dev->active ? "active" : "disabled");
>         return 0;
>  }
>
> diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
> index 70d4ba957..2fa0f7d55 100644
> --- a/drivers/pnp/resource.c
> +++ b/drivers/pnp/resource.c
> @@ -540,7 +540,7 @@ struct pnp_resource *pnp_add_irq_resource(struct pnp_dev *dev, int irq,
>         res->start = irq;
>         res->end = irq;
>
> -       dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
> +       dev_dbg(&dev->dev, "%pR\n", res);
>         return pnp_res;
>  }
>
> --

Applied as 5.14 material with edits in the subject and changelog, thanks!
