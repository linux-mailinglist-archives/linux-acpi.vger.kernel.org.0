Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49293FF238
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346549AbhIBRWb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Sep 2021 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346507AbhIBRW3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Sep 2021 13:22:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26E4C061757
        for <linux-acpi@vger.kernel.org>; Thu,  2 Sep 2021 10:21:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id q70so5244824ybg.11
        for <linux-acpi@vger.kernel.org>; Thu, 02 Sep 2021 10:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=On4+bwBZY2VHtzcK0y+sz7PPXSEz1i4XFGr/NoM2bik=;
        b=HRZoj2agLhRgT4gUkJKlLLg3Yve5/2+MX7OlCLbccLakwWEQnzQqBLvoKNQgiioT0/
         BzghiksK49NlmDTEsOY3px4DSk6yoX4ZzMD+EdW7rbfLnZqdFsE/9xGgJTo/0rGJhEEH
         SDTVpt9SlPMr3ZwFAJuVUxKI9N7jT1JiHSxTWRlSsVCAU0220Ofu72V0yVcRBFVtu7uh
         xymy9muR8zP4q+QaNxrS4cBITENokcBleYy4q2ioLIDGdkaxBM0UK/3xoiIX3pi+lfOL
         KvxK66VTZpkQbPdym4HzpNS+VlCwQk6a7RGDULWVATkyZP2t0LORoZpnqWD8vQYqIboD
         +bjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=On4+bwBZY2VHtzcK0y+sz7PPXSEz1i4XFGr/NoM2bik=;
        b=sU+OmgkvyBl2YG8yeYW3HUj/2L4xFr4R+0DczKsfbQnzNRP1lQlrUcCVBdKUQk46r0
         zWk/WHMiKFLwGxf7PsKbnH/OkkIYUZYRV97UubueGOpuwSXYWc5PzL0b/U2Kfxdydoi3
         WnljWiXJ8GqVzpNgqOF3GRvdpvSCDZgTwi0r2MLimUUURlgXx/ln9RWISoq4zmn1HfGz
         ophibVed318vuz5Tc7hOPHv/ixu3XWUfvbDs+Uk2004CAgFDA+Thxm77P+a4+mWytKdy
         sUW38aFE0D93vL5ClOH5HfekDu/LFzHY6+vJdUWmYQU7DsxNw14EdAaitkZ9wNsvSNZw
         2vhw==
X-Gm-Message-State: AOAM532zWt0az5HQiBDVhrs/zqU9WoqaRDDwDU/jAG2ljS4xqTVwdLgL
        g6F5IvxrbYQpQvHNQ0cO672nzcpJlZcZPXdT4GVWbg==
X-Google-Smtp-Source: ABdhPJyS+LxlE16Qm2mQyeB+Z3S3rI0rNtTM2yxEPw2WPNsSBoae9bcHgGafDM0op87STsqfvVtAAi/j1ASriI8aGuk=
X-Received: by 2002:a25:804:: with SMTP id 4mr5357925ybi.346.1630603289732;
 Thu, 02 Sep 2021 10:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210902025528.1017391-1-saravanak@google.com> <20210902025528.1017391-3-saravanak@google.com>
In-Reply-To: <20210902025528.1017391-3-saravanak@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 2 Sep 2021 10:20:53 -0700
Message-ID: <CAGETcx_6-2HSJuTqKtcLVUD89u6LntSJ-GDXM706ng7PLAba0A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 1, 2021 at 7:55 PM Saravana Kannan <saravanak@google.com> wrote:
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

This patch is wrong. This flag should have been FWNODE_FLAG_NEVER_PROBES.

-Saravana

> +
>         for_each_child_of_node(bus, child) {
>                 pr_debug("   create child: %pOF\n", child);
>                 rc = of_platform_bus_create(child, matches, lookup, &dev->dev, strict);
> --
> 2.33.0.259.gc128427fd7-goog
>
