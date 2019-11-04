Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEBEEE37D
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2019 16:18:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfKDPSx (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 4 Nov 2019 10:18:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:37206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728701AbfKDPSw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 4 Nov 2019 10:18:52 -0500
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB5521850;
        Mon,  4 Nov 2019 15:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572880732;
        bh=/ilrDL5VFaGpvPXs/d5mauxhkJ0VKGY7RHd5Pe6j8b0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wTywLaNuB1HoB+eHGZmmElU4pQpLJ/PV5mF36CJuy/1bQfcipZr84T1PqmiUIArU5
         ftG3HQxRIspAdhGGux+9pRkRszRercjMzWg7Mvc2qjLl6LUTu+M5u63eWY+9Ngmmt8
         pHfzfEv5zhebUS6m4ity8kDROsNzhpnJln/zzRKM=
Received: by mail-qt1-f177.google.com with SMTP id r22so14367995qtt.2;
        Mon, 04 Nov 2019 07:18:52 -0800 (PST)
X-Gm-Message-State: APjAAAVquLknXXRDybn1jwG9xNDYI+E4KCEnfhOkhaqTRY6Zai/m8vuH
        ftEfSknEPkom2mr3j34sf/8yX+PH79Vt8Ji5Wg==
X-Google-Smtp-Source: APXvYqz6VOGe10++SnT2O1uuLn6+9WTHPod7Ohdefkb2HVUrRipukxsh2BWWbxVhlbAuqfj5fPwaTiEMADzf53iiCnc=
X-Received: by 2002:a05:6214:8e5:: with SMTP id dr5mr21902677qvb.79.1572880731365;
 Mon, 04 Nov 2019 07:18:51 -0800 (PST)
MIME-Version: 1.0
References: <20191028220027.251605-1-saravanak@google.com> <20191028220027.251605-6-saravanak@google.com>
In-Reply-To: <20191028220027.251605-6-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 4 Nov 2019 09:18:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
Message-ID: <CAL_Jsq+obCEeaNjpvJ6VvO6b2F6A5oHcRD8PYAifUvBQHbQ_Og@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] of: property: Skip adding device links to
 suppliers that aren't devices
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
> Some devices need to be initialized really early and can't wait for
> driver core or drivers to be functional.  These devices are typically
> initialized without creating a struct device for their device nodes.
>
> If a supplier ends up being one of these devices, skip trying to add
> device links to them.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index f16f85597ccc..21c9d251318a 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1038,6 +1038,7 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>         struct device *sup_dev;
>         int ret = 0;
>         struct device_node *tmp_np = sup_np;
> +       int is_populated;
>
>         of_node_get(sup_np);
>         /*
> @@ -1062,9 +1063,10 @@ static int of_link_to_phandle(struct device *dev, struct device_node *sup_np,
>                 return -EINVAL;
>         }
>         sup_dev = get_dev_from_fwnode(&sup_np->fwnode);
> +       is_populated = of_node_check_flag(sup_np, OF_POPULATED);
>         of_node_put(sup_np);
>         if (!sup_dev)
> -               return -EAGAIN;
> +               return is_populated ? 0 : -EAGAIN;

You're only using the flag in one spot and a comment would be good
here, so I'd just do:

if (of_node_check_flag(sup_np, OF_POPULATED))
        return 0; /* Early device without a struct device */

>         if (!device_link_add(dev, sup_dev, dl_flags))
>                 ret = -EAGAIN;
>         put_device(sup_dev);
> --
> 2.24.0.rc0.303.g954a862665-goog
>
