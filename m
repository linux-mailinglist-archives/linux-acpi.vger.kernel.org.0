Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60E63FEF69
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 16:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbhIBOZs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 10:25:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345318AbhIBOZl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 2 Sep 2021 10:25:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 35B16610A4;
        Thu,  2 Sep 2021 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630592682;
        bh=8Q26juGy7jduIrtBN/cCky6QYZFj3PapNW4w/N2c58A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MfSV52wFAuVERyUEr7ffSXU2OWRVhIHVwUF/DBjm6//ZPMP2omLe9EgMjfeybJoY9
         JxMBMKfrVfCJLRcXeO7r1Xq2jL/xRrCiEJZQQrBxLyIos/09gukp93iPF6GTtfpohX
         ymSe81lXKn/90vujjv2rzeszJP5oWVuGgAlSHPn3oHRRVtKsvJgkm3LFjbyGQ8so19
         ZtK6Mf9r4RPhM9GEV/QASooW1f5H+9z0Tzt4e7xptfrQuhRJL+GSqLkF6K5bvTjMwL
         m9ZEgP84FfrMGNTA/pqJSPne8/oWRkNK4x7+BVGOjy/GBXUi8JxYQn95XlgOqA7iJ+
         HwAGKsh2NwqQg==
Received: by mail-ej1-f49.google.com with SMTP id bt14so4819282ejb.3;
        Thu, 02 Sep 2021 07:24:42 -0700 (PDT)
X-Gm-Message-State: AOAM530FRted8ehtHP8Yjx7V6L+OCpD29ZC2K7E/9CYmx/VHmW8chsqo
        z6oVoDhs6YBADyvW2lE1h/Bflt6A6HXPeXIpkg==
X-Google-Smtp-Source: ABdhPJz9Tk3bwAY6hO392hOhhtrO5ROiJlUdHl3FFlHcLzA/kgLn0bakgc+4FtEgu5wnu4BPjOGkeSqX0QjO50Xt+0A=
X-Received: by 2002:a17:906:8cd:: with SMTP id o13mr4136037eje.341.1630592680828;
 Thu, 02 Sep 2021 07:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com> <20210902025528.1017391-3-saravanak@google.com>
In-Reply-To: <20210902025528.1017391-3-saravanak@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 2 Sep 2021 09:24:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
Message-ID: <CAL_JsqJOv7D5nHteGPDKC2+ns1caVNs-NFFJppLuK0OEB8dztQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:ACPI FOR ARM64 (ACPI/arm64)" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 1, 2021 at 9:55 PM Saravana Kannan <saravanak@google.com> wrote:
>
> We don't want fw_devlink creating device links for bus devices as
> they'll never probe. So mark those device node with this flag.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
>  drivers/of/platform.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 74afbb7a4f5e..42b3936d204a 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -392,6 +392,22 @@ static int of_platform_bus_create(struct device_node *bus,
>         if (!dev || !of_match_node(matches, bus))
>                 return 0;
>
> +       /*
> +        * If the bus node has only one compatible string value and it has
> +        * matched as a bus node, it's never going to get probed by a device
> +        * driver. So flag it as such so that fw_devlink knows not to create
> +        * device links with this device.
> +        *
> +        * This doesn't catch all devices that'll never probe, but this is good
> +        * enough for now.
> +        *
> +        * This doesn't really work for PPC because of how it uses
> +        * of_platform_bus_probe() to add normal devices. So ignore PPC cases.
> +        */
> +       if (!IS_ENABLED(CONFIG_PPC) &&
> +           of_property_count_strings(bus, "compatible") == 1)
> +               bus->fwnode.flags |= FWNODE_FLAG_NOT_DEVICE;

This looks fragile relying on 1 compatible string, and the DT flags in
this code have been fragile too. I'm pretty sure we have cases of
simple-bus or simple-mfd that also have another compatible.

Couldn't we solve this with a simple driver? Make 'simple-pm-bus'
driver work for other cases? BTW, this patch doesn't even work for
simple-pm-bus. A driver for simple-bus may cause issues if there's a
more specific driver to bind to as we don't handle that. It's simply
whichever matches first.

Rob
