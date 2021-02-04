Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72230FC7E
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Feb 2021 20:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238905AbhBDTUc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Feb 2021 14:20:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbhBDTSs (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Feb 2021 14:18:48 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0CC061786
        for <linux-acpi@vger.kernel.org>; Thu,  4 Feb 2021 11:18:04 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id i6so4304230ybq.5
        for <linux-acpi@vger.kernel.org>; Thu, 04 Feb 2021 11:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1JzSELb4pc4aQnnwI2bcbtcLQTicwP2YL8nGY3wKCA=;
        b=efKrSjioXHaXuLl4l8z7BVxglWGws/GBLX7rdNZe6QAjb6O241+JhlAD9koy7qNr8V
         8ST3l75Cp0NvedUNDZUZ6Yp+7dZbXAOs7RMdHs1a6XvfdHX31D6MrM2tZKMOsE9ON0f4
         3XV5Wwkl8vfFXtnDvDX0puRN8aTTbIyAyXN08qRpQWeitloQcQMa9EaD4zyE/SlpLgrQ
         2W6Z4Hk3Numq2+uir5rTYfiO8p8mDuoTxLR8v5BATxJw0ADTIwkmvFrYjB4tBwOGcImQ
         GfyquAAEn+FvpLkOfRRv6Zuz9pj7vV7m53iMNGKPUmk7xysc3gbYjodEBpwMNOl2cl1W
         CKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1JzSELb4pc4aQnnwI2bcbtcLQTicwP2YL8nGY3wKCA=;
        b=O2pNgO+J3D6jcjLK31ZujRaI6bXohXteY/K2T9t9oJxT/27LN6DoaRkWDrm/zG8q9Y
         SlnsG3O0tjV1KRMV+zH1QVZiJhKfIT0IJbj9yd9Uzth/BaBEgPwdAm8sfdItJPRdSpD1
         xZTkl5b4TustkH/f1OuVdSh7vtDABtlxUc7Lpt5D8Ss9RNBi8OP26V1hKNm34GDE8Pak
         L22pP6w5tl7r6DYkon+SUa/cvfwAnYuwdzaS50zE3IiSoKddfi/KlOKu71F+LbSAHmkk
         sCPj7QxO+LnDrImx/RtJQ9gwQ2xX+k8kiexLDZOLS2N6xpHOgqgawxy4wqWNN2VAAV5m
         AjEA==
X-Gm-Message-State: AOAM532sHPKYOtFkhqFLhhwpvy3/0xvI/4CIQIAEZcOe3etZNBQS7agH
        t34DYTF+zwIlkpZfdBPMrhgYPL59sdkwOWvAKjlmHg==
X-Google-Smtp-Source: ABdhPJwlhb6alK+UFA4q6j/4796x+229EtmwiRPdj4AriY85G89neLwTo3eHgw3OuwSf6JrAYBoLNelnQZ9weCeg8as=
X-Received: by 2002:a25:718b:: with SMTP id m133mr1229246ybc.412.1612466283803;
 Thu, 04 Feb 2021 11:18:03 -0800 (PST)
MIME-Version: 1.0
References: <20210202043345.3778765-1-saravanak@google.com> <20210202043345.3778765-4-saravanak@google.com>
In-Reply-To: <20210202043345.3778765-4-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Feb 2021 11:17:27 -0800
Message-ID: <CAGETcx8H8axt7r=qrqauJCAuOmg5puR0Bp595yxh1CksjAkNeA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] of: property: Don't add links to absent suppliers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 8:33 PM Saravana Kannan <saravanak@google.com> wrote:
>
> If driver core marks a firmware node as not a device, don't add fwnode
> links where it's a supplier.
>
> Fixes: e590474768f1 ("driver core: Set fw_devlink=on by default")
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 6287c6d60bb7..53d163c8d39b 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1103,7 +1103,9 @@ static int of_link_to_phandle(struct device_node *con_np,
>          * created for them.
>          */
>         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> -       if (!sup_dev && of_node_check_flag(sup_np, OF_POPULATED)) {
> +       if (!sup_dev &&
> +           (of_node_check_flag(sup_np, OF_POPULATED) ||
> +            sup_np->fwnode.flags & FWNODE_FLAG_NOT_DEVICE)) {
>                 pr_debug("Not linking %pOFP to %pOFP - No struct device\n",
>                          con_np, sup_np);
>                 of_node_put(sup_np);
> --
> 2.30.0.365.g02bc693789-goog
>

Rob, Can I get an Ack or reviewed-by for this? I want to land this
patch and another one on driver-core.

Thanks,
Saravana
