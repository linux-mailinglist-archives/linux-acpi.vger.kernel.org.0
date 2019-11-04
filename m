Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E99AFEE567
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 18:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfKDRBa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 12:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfKDRBa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Nov 2019 12:01:30 -0500
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38D0214B2;
        Mon,  4 Nov 2019 17:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572886888;
        bh=+MtZPHtXKdsSw7Bm/k8kkH1yNhktHmkA+OzqMTB1qsw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TpQQFTR2EFY00egCJK1oAzh9DT7POr/CTY0WnCUAB/2BeMaio38vdV1yPDdJ7LNmt
         NJt/IMhJUhKdGJG7+aCn1qhhoFeAnvuKXgFCt9QkUW34dqfkPqMX3Az0KdbZttCrG0
         3Q/ZdoRCleOKx/JLAhfQoZedoB1dFhC/6hLxYWsE=
Received: by mail-qk1-f180.google.com with SMTP id m125so18267399qkd.8;
        Mon, 04 Nov 2019 09:01:28 -0800 (PST)
X-Gm-Message-State: APjAAAXhazfkjG9F8cx8ZCJKXjBWP9hSwnypZw8+w67wjXD4QB2xq3WG
        ETqWxS5Nq7F5I+A5K999YnC2RhWe2CHw1dP2jA==
X-Google-Smtp-Source: APXvYqwgsKbRtBwlM6IP+7Jb7jCD2qb6TrBglXZcYJiaKjk035Dt56BQa7exM3fo+NyU11adG6CGbyTwxp/LndrfMFY=
X-Received: by 2002:a37:4904:: with SMTP id w4mr17253854qka.119.1572886887790;
 Mon, 04 Nov 2019 09:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-5-saravanak@google.com>
In-Reply-To: <20191028220027.251605-5-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 11:01:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJQ9siUGgmGqZnF_Wk3mVau29yVZRL_3LxFKgD8=mccQQ@mail.gmail.com>
Message-ID: <CAL_JsqJQ9siUGgmGqZnF_Wk3mVau29yVZRL_3LxFKgD8=mccQQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] of: property: Make sure child dependencies don't
 block probing of parent
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Oct 28, 2019 at 5:00 PM Saravana Kannan <saravanak@google.com> wrote:
>
> When creating device links to proxy the sync_state() needs of child
> dependencies, create SYNC_STATE_ONLY device links so that children
> dependencies don't block probing of the parent.
>
> Also, differentiate between missing suppliers of parent device vs
> missing suppliers of child devices so that driver core doesn't block
> parent device probing when only child supplier dependencies are missing.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

One nit below:

>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 2808832b2e86..f16f85597ccc 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1032,10 +1032,10 @@ static bool of_is_ancestor_of(struct device_node *test_ancestor,
>   * - -EINVAL if the supplier link is invalid and should not be created
>   * - -ENODEV if there is no device that corresponds to the supplier phandle
>   */
> -static int of_link_to_phandle(struct device *dev, struct device_node *sup_np)
> +static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
> +                             u32 dl_flags)
>  {
>         struct device *sup_dev;
> -       u32 dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
>         int ret = 0;
>         struct device_node *tmp_np = sup_np;
>
> @@ -1195,13 +1195,20 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
>         unsigned int i = 0;
>         bool matched = false;
>         int ret = 0;
> +       u32 dl_flags;
> +
> +       if (dev->of_node == con_np)
> +               dl_flags = DL_FLAG_AUTOPROBE_CONSUMER;
> +       else
> +               dl_flags = DL_FLAG_SYNC_STATE_ONLY;
>
>         /* Do not stop at first failed link, link all available suppliers. */
>         while (!matched && s->parse_prop) {
>                 while ((phandle = s->parse_prop(con_np, prop_name, i))) {
>                         matched = true;
>                         i++;
> -                       if (of_link_to_phandle(dev, phandle) == -EAGAIN)
> +                       if (of_link_to_phandle(dev, phandle, dl_flags)
> +                                                               == -EAGAIN)

nit: I'd just keep this one line or at least move '==' up.

>                                 ret = -EAGAIN;
>                         of_node_put(phandle);
>                 }
> @@ -1219,10 +1226,10 @@ static int of_link_to_suppliers(struct device *dev,
>
>         for_each_property_of_node(con_np, p)
>                 if (of_link_property(dev, con_np, p->name))
> -                       ret = -EAGAIN;
> +                       ret = -ENODEV;
>
>         for_each_child_of_node(con_np, child)
> -               if (of_link_to_suppliers(dev, child))
> +               if (of_link_to_suppliers(dev, child) && !ret)
>                         ret = -EAGAIN;
>
>         return ret;
> --
> 2.24.0.rc0.303.g954a862665-goog
>
