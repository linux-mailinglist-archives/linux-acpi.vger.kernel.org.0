Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5AD369841
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 19:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242335AbhDWR0K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 13:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhDWR0J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Apr 2021 13:26:09 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86FBC06174A
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 10:25:30 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 82so56505941yby.7
        for <linux-acpi@vger.kernel.org>; Fri, 23 Apr 2021 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8hZDL1xA2e2FhQbADX4o3akbnImWISYvJ4gYV4hTDw=;
        b=QE34o8j979cX1BIZ77fuSaJFJASbd86yY/WiIZf/hGm3zAIrulu11rCYPdXZCPXmJp
         dw4Xfb99rfN8VIjOVxPvsDQvjqNyOah9xQTh0YB7Rhj9Um+Y31ErWk6WtIpAP/48tZxd
         KqxWDkBAgxxGs1bIBFnJJ1N7G+96HTwvTX7AZpH1y/hk93dVzZ+J55Ws35QFdWD2dGeG
         webPu3XuSDc6v0ErYT++1lSCc0+whj212QDZwdkbqFPuPOJKPRiofRQ/LbcZTLRb1Lli
         CLSIusitAEqZxhsPHFSvAgDovo+HdOl9codXeFbW8mzmsmMP8Kfm2mcytt8DLw7H27DL
         kAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8hZDL1xA2e2FhQbADX4o3akbnImWISYvJ4gYV4hTDw=;
        b=T41VBLatlQMqiPCQuZElJeY+fIbwnLGbDhIEVSgGZvMnv2oks4W1X71/3C2nLmh4Jp
         t0pXg16AoSe5+xiMBw6W0GXQiDLAFmtW6CI8SCm9UUeB65e2rMna0h/W8Y6nZyDnFufR
         UCdJYmZIXCBIg+GkGtCHgRZZRKauTku3au9fPS79k4ohDBf7XL6gKWjoIU0QCSG+XTTJ
         Koq+RC5eU3QLFnldCe33yF3ZCuwlwz/Q+PkxM9du7SdT6R6j2CbO/H/iNxSyosSf3LaP
         BpSEuubfqiJaAZhjqJCuY7MpZ12jkgG6/N4ZGuRua20sl16nb/q8xlMkauZxXJMSlMen
         mIIg==
X-Gm-Message-State: AOAM533Qv6qQG3dowctSod6bZbyCtKprPfcYwByIMTsySGEZrzO42Q60
        IruA+nUZKqX+jYk0Qq7n85EaO0psEOqXTjMkcpYaYQ==
X-Google-Smtp-Source: ABdhPJxFoVAvJGui3UN2oIAvxm+a7sAm6jmg01L2/sYpQx5YwJvUfenhyU0iY9IdZ6Rlj5GY+UENrXQypiXTNdleqKM=
X-Received: by 2002:a5b:ed2:: with SMTP id a18mr7083028ybs.466.1619198729910;
 Fri, 23 Apr 2021 10:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210423171335.262316-1-tudor.ambarus@microchip.com> <20210423171335.262316-2-tudor.ambarus@microchip.com>
In-Reply-To: <20210423171335.262316-2-tudor.ambarus@microchip.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 23 Apr 2021 10:24:54 -0700
Message-ID: <CAGETcx-81hPTW_EVexMWaxGSOknuK-zESqKdiuQvye=n3TaHkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: Do not register provider with a NULL dev->of_node
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, nsaenz@kernel.org,
        maxime@cerno.tech, gregkh@linuxfoundation.org, rafael@kernel.org,
        khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com,
        pavel@ucw.cz, robh+dt@kernel.org, frowand.list@gmail.com,
        maz@kernel.org, tglx@linutronix.de, geert@linux-m68k.org,
        nsaenzjulienne@suse.de, linux@roeck-us.net,
        guillaume.tucker@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        kernel-team@android.com, linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Apr 23, 2021 at 10:14 AM Tudor Ambarus
<tudor.ambarus@microchip.com> wrote:
>
> commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> revealed that clk/bcm/clk-raspberrypi.c driver calls
> devm_of_clk_add_hw_provider(), with a NULL dev->of_node.
>
> devm_of_clk_add_hw_provider() should not register the provider with
> a NULL dev->of_node, as there is no of_node. Apart of the NULL pointer
> dereference that will result when calling fwnode_dev_initialized() in
> of_clk_add_hw_provider(), another problem is that when two drivers calling
> of_clk_add_hw_provider() with np = NULL, their unregistration order is not
> guaranteed to be correct. Avoid all the problems and just return -ENODEV
> when the callers of devm_of_clk_add_hw_provider() use a NULL dev->of_node,
> which seems the natural way to do.
>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/clk/clk.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index e2ec1b745243..8b5077cc5e67 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4634,11 +4634,10 @@ static struct device_node *get_clk_provider_node(struct device *dev)
>   * @get: callback for decoding clk_hw
>   * @data: context pointer for @get callback
>   *
> - * Registers clock provider for given device's node. If the device has no DT
> - * node or if the device node lacks of clock provider information (#clock-cells)
> - * then the parent device's node is scanned for this information. If parent node
> - * has the #clock-cells then it is used in registration. Provider is
> - * automatically released at device exit.
> + * Registers clock provider for given device's node. If the device node lacks
> + * of clock provider information (#clock-cells) then the parent device's node is
> + * scanned for this information. If parent node has the #clock-cells then it is
> + * used in registration. Provider is automatically released at device exit.
>   *
>   * Return: 0 on success or an errno on failure.
>   */
> @@ -4650,6 +4649,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
>         struct device_node **ptr, *np;
>         int ret;
>
> +       if (!dev->of_node)
> +               return -ENODEV;
> +

Based on the other discussions, for now, just return 0. The error
might cause other issues in other drivers. We can clean this up later.

-Saravana

>         ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
>                            GFP_KERNEL);
>         if (!ptr)
> --
> 2.25.1
>
