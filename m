Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0339DEB0
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFGO15 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 10:27:57 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38809 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGO14 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 10:27:56 -0400
Received: by mail-oi1-f181.google.com with SMTP id z3so18210725oib.5;
        Mon, 07 Jun 2021 07:25:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01tad8DeUT+MW2RPlFJpkVgZxwLL8mDg2ApJ3H11UwU=;
        b=ga/R+0MHmG/PR0lE4zs3q+D1kThfcSJmWPXX9Dd8kkRHyqh734lqc2dVZAFccxrSTH
         I0JSHOoJv18XxN8dlOHhli8R97Kn9z6B1D+Mm3wRE9N8wWk9p2JuExx1QDunK9BKLgqx
         GfM7ikbEj+BVPzn3NLIIAKdfIge3u8jEztfNyrjDNQ5gf1RKYfp7ppoRTME7PXH1HdW+
         SOJr/PsH31ZilwO1lAhoOQjadnwGPEeyUFKRk8CGYvlz2w7ZkBEYh6XNzZFV5BsflAU0
         DwlekLxcg5CTufQFmnWjau2cti6y10hw96ZaXXcLyV0VBXXHX76Q++zsAx9L0w7SpJmx
         8phg==
X-Gm-Message-State: AOAM532TKRDu7yyyU+cKSZTAhEM64Kv982QwTPNXBjfLrhDiTbZh9QzF
        8iRCQQ4Xl2nng1zTalXrhXr6eSlRz5RsJRh2YSY=
X-Google-Smtp-Source: ABdhPJzo8+gXZ/nQ+qpeh2p1BmTOXD9NotFUfNj06gnmS3qHFIDWKIk+FxTJCHiwaIw7QEm4ncgAZJxkIiC3Y+oysIY=
X-Received: by 2002:aca:1910:: with SMTP id l16mr10918949oii.69.1623075949182;
 Mon, 07 Jun 2021 07:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210602081546.11170-1-thunder.leizhen@huawei.com>
In-Reply-To: <20210602081546.11170-1-thunder.leizhen@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 16:25:38 +0200
Message-ID: <CAJZ5v0hNOOc5unkfbN6NHz4U4S8RzoQB2QJJTt3bLmW63zitUQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PNP: use DEVICE_ATTR_RO macro
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi <linux-acpi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 2, 2021 at 10:15 AM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> Use DEVICE_ATTR_RO macro helper instead of plain DEVICE_ATTR, which makes
> the code a bit shorter and easier to read.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  drivers/pnp/card.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
> index 2430c14f472d26a..d40ed8621571b0a 100644
> --- a/drivers/pnp/card.c
> +++ b/drivers/pnp/card.c
> @@ -181,8 +181,8 @@ struct pnp_card *pnp_alloc_card(struct pnp_protocol *protocol, int id, char *pnp
>         return card;
>  }
>
> -static ssize_t pnp_show_card_name(struct device *dmdev,
> -                                 struct device_attribute *attr, char *buf)
> +static ssize_t name_show(struct device *dmdev,
> +                        struct device_attribute *attr, char *buf)
>  {
>         char *str = buf;
>         struct pnp_card *card = to_pnp_card(dmdev);
> @@ -191,10 +191,10 @@ static ssize_t pnp_show_card_name(struct device *dmdev,
>         return (str - buf);
>  }
>
> -static DEVICE_ATTR(name, S_IRUGO, pnp_show_card_name, NULL);
> +static DEVICE_ATTR_RO(name);
>
> -static ssize_t pnp_show_card_ids(struct device *dmdev,
> -                                struct device_attribute *attr, char *buf)
> +static ssize_t card_id_show(struct device *dmdev,
> +                           struct device_attribute *attr, char *buf)
>  {
>         char *str = buf;
>         struct pnp_card *card = to_pnp_card(dmdev);
> @@ -207,7 +207,7 @@ static ssize_t pnp_show_card_ids(struct device *dmdev,
>         return (str - buf);
>  }
>
> -static DEVICE_ATTR(card_id, S_IRUGO, pnp_show_card_ids, NULL);
> +static DEVICE_ATTR_RO(card_id);
>
>  static int pnp_interface_attach_card(struct pnp_card *card)
>  {
> --

Applied as 5.14 material, thanks!
