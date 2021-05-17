Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB96F38337D
	for <lists+linux-acpi@lfdr.de>; Mon, 17 May 2021 17:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhEQO6j (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 17 May 2021 10:58:39 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:43584 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbhEQO4j (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 May 2021 10:56:39 -0400
Received: by mail-oi1-f177.google.com with SMTP id j75so6701684oih.10
        for <linux-acpi@vger.kernel.org>; Mon, 17 May 2021 07:55:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gXpQytpzWg8xvjan3Elb6dc+ZGlZ19M8HZX9QyM+Dsc=;
        b=M2iJnSlLUZGct0lDmMj1bvfdPvTkRu5ZBFlEnwEFKmMTWDiOWve+h3EPfporKEaQRY
         I9R/JPUAxFArGQQTSDfPYGW2e7YqqULTAI1PU4NCD2BWjzTTZjPA4GVFiDX53qSOA5F/
         te8/rF+FOTV35ak0N/eJrQJTuAcKN+TVFTue+L3jzNCS4UseVrQKkO1EQDxotBSaoieG
         zB9DDj/a8+IO2PLsKd/6A/LsQttLa5hCko6EzA+iKtF/I3qtkZ0KaHBQephGsSo49vjd
         SV9mOJnRt5MbnMS7QJyqtcwxDr82SUdoFYWfqd7bIfxPu6CUIDUZvuRdNcqbHElsu+z5
         0Zow==
X-Gm-Message-State: AOAM5312ySwjdDJqRvKtGSPiMZ2QwdZhULGPBavE47AY7m01JIWBUdBl
        taZecUiEtFCC2OijsNDTiM9x0XrhMhCFH9mEmiU=
X-Google-Smtp-Source: ABdhPJwTLJcijh5XF+trA+k3DtKBtTqMKDgIJAfB+vWMz7WiYCzzTQTZjnEbwfyhtp487wtdvc2RqoHSQ3MZvRYMQ2I=
X-Received: by 2002:a05:6808:90d:: with SMTP id w13mr136815oih.71.1621263322657;
 Mon, 17 May 2021 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <2c94aae5-2dd5-0046-bacb-c09770bf5d82@gmail.com>
In-Reply-To: <2c94aae5-2dd5-0046-bacb-c09770bf5d82@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 17 May 2021 16:55:11 +0200
Message-ID: <CAJZ5v0i_v70Siq_RYoxsu2bsks4bL2gsAuHOHGv5pOUFsFJ9jA@mail.gmail.com>
Subject: Re: [PATCH] pnp: Remove pnp_alloc
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 12:25 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> Kernel will complain anyway if it runs out of memory. Therefore we
> don't need the error message in pnp_alloc() and hence can remove it
> and use kzalloc() directly.
>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/pnp/base.h      |  1 -
>  drivers/pnp/card.c      |  2 +-
>  drivers/pnp/core.c      | 12 ------------
>  drivers/pnp/interface.c |  4 ++--
>  4 files changed, 3 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
> index cdcfa39cf..e74a0f6a3 100644
> --- a/drivers/pnp/base.h
> +++ b/drivers/pnp/base.h
> @@ -6,7 +6,6 @@
>
>  extern struct mutex pnp_lock;
>  extern const struct attribute_group *pnp_dev_groups[];
> -void *pnp_alloc(long size);
>
>  int pnp_register_protocol(struct pnp_protocol *protocol);
>  void pnp_unregister_protocol(struct pnp_protocol *protocol);
> diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
> index c2464ee08..2430c14f4 100644
> --- a/drivers/pnp/card.c
> +++ b/drivers/pnp/card.c
> @@ -80,7 +80,7 @@ static int card_probe(struct pnp_card *card, struct pnp_card_driver *drv)
>         if (!id)
>                 return 0;
>
> -       clink = pnp_alloc(sizeof(*clink));
> +       clink = kzalloc(sizeof(*clink), GFP_KERNEL);
>         if (!clink)
>                 return 0;
>         clink->card = card;
> diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
> index a50ab002e..ccdfbf397 100644
> --- a/drivers/pnp/core.c
> +++ b/drivers/pnp/core.c
> @@ -31,18 +31,6 @@ DEFINE_MUTEX(pnp_lock);
>  int pnp_platform_devices;
>  EXPORT_SYMBOL(pnp_platform_devices);
>
> -void *pnp_alloc(long size)
> -{
> -       void *result;
> -
> -       result = kzalloc(size, GFP_KERNEL);
> -       if (!result) {
> -               printk(KERN_ERR "pnp: Out of Memory\n");
> -               return NULL;
> -       }
> -       return result;
> -}
> -
>  static void pnp_remove_protocol(struct pnp_protocol *protocol)
>  {
>         mutex_lock(&pnp_lock);
> diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
> index 602c46893..44efcdb87 100644
> --- a/drivers/pnp/interface.c
> +++ b/drivers/pnp/interface.c
> @@ -214,7 +214,7 @@ static ssize_t options_show(struct device *dmdev, struct device_attribute *attr,
>         int ret, dep = 0, set = 0;
>         char *indent;
>
> -       buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
> +       buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>         if (!buffer)
>                 return -ENOMEM;
>
> @@ -257,7 +257,7 @@ static ssize_t resources_show(struct device *dmdev,
>         if (!dev)
>                 return -EINVAL;
>
> -       buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
> +       buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
>         if (!buffer)
>                 return -ENOMEM;
>
> --

Applied as 5.14 material with edits in the subject and changelog, thanks!
