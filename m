Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9856C3797BF
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 21:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhEJThy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 15:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhEJThx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 10 May 2021 15:37:53 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72466C061574;
        Mon, 10 May 2021 12:36:48 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l6so16876867oii.1;
        Mon, 10 May 2021 12:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rfwM6aeV64dlStCtynVwqpYhrKx+20fvdPRxkUUNoPk=;
        b=mxmiFt5qvY4oygWWBZxPyrzPAzIDNPiRcZSHCSYNuvlWGg8DdQseRAuHq9FSY4Tulj
         rTPDmvc2kJn1gm/Rc5Oyhvk22cnWgQ6DwjLFryi8ks3TwScNLTffiDchRZYJGv7cU0Ho
         3cQ/72SWBHLm95nxpzNwLYuBEnTRnMg7Wjx7k1FQcwJ+yXpiErHlCMIU/wENp432qolY
         XsgfAxICnVrKS2y6S44pXIiBJoJZ+F13bL9LW3esNjjfCmViHQj55iiCYPRwZswAF4EO
         gIG6z/C2KJGqNXH2ElAzW9TWhgwYULSpttiV0EBleBsYBCgEjnYYioHiwotB8K0Rb37c
         uzJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=rfwM6aeV64dlStCtynVwqpYhrKx+20fvdPRxkUUNoPk=;
        b=hE0ItELCGgYlU4JX0txKaZQElbOT+i+fYQnIeX18Wg5rEdUdU08YNWCrNoV1BUT1Fz
         poZi8O6HsJVGYA90f0Ijh0ssHGpuK9S2LhgLriUD3SM6Cn7C7hhiTfseSVuei+VeEFe1
         w2URoWGAfO4SPPoj4VZtbk30jlMQMyjrnxfUUYvfUFqaP/peHOPbAT1XXeOprsZMzMRn
         Vxfp+HaDtYmVvaqzBdpsVikXjSYBOoCbjv+dSqSSdK52n2RNvoY8+hioUf7oQ563Zevl
         KEHCLP/cdmDNLbNkZp9jJKKYRkCwiwRmkHjK23BOLVVZmy1XX6DCeK9DyDjj31jUce5A
         AV4w==
X-Gm-Message-State: AOAM530OwcOcXZrZJPXLvVzEzQ8yj4ljIxkXQm+uKs4V0EqClhVATGdU
        CW2rHROXaTPnYPf6Vq000Yw=
X-Google-Smtp-Source: ABdhPJz99SSWF74iI7aVgrfSha6fpI7t5Ox7OPhvT9ZInZpyUwZvMG07nJMrZkS9zEDf/bXgZ7WPdQ==
X-Received: by 2002:aca:4004:: with SMTP id n4mr19028827oia.89.1620675407817;
        Mon, 10 May 2021 12:36:47 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g11sm288735oif.27.2021.05.10.12.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 12:36:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 10 May 2021 12:36:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, nsaenz@kernel.org,
        maxime@cerno.tech, khilman@kernel.org, ulf.hansson@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, robh+dt@kernel.org,
        frowand.list@gmail.com, maz@kernel.org, tglx@linutronix.de,
        saravanak@google.com, geert@linux-m68k.org, nsaenzjulienne@suse.de,
        guillaume.tucker@collabora.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        kernel-team@android.com, linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] clk: Skip clk provider registration when np is NULL
Message-ID: <20210510193645.GA3920948@roeck-us.net>
References: <20210426065618.588144-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210426065618.588144-1-tudor.ambarus@microchip.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 26, 2021 at 09:56:18AM +0300, Tudor Ambarus wrote:
> commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> revealed that clk/bcm/clk-raspberrypi.c driver calls
> devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted in a
> NULL pointer dereference in of_clk_add_hw_provider() when calling
> fwnode_dev_initialized().
> 
> Returning 0 is reducing the if conditions in driver code and is being
> consistent with the CONFIG_OF=n inline stub that returns 0 when CONFIG_OF
> is disabled. The downside is that drivers will maybe register clkdev lookups
> when they don't need to and waste some memory.
> 
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> Fixes: 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2:
> - s/return 0;/return; in void of_clk_del_provider()
> - add second fixes tag and Stephen's R-b tag
> The opinions on whether to return an error or zero were split. Returning 0
> and skipping the logic was considered safer as we don't know for sure if
> other drivers are affected. See:
> https://lore.kernel.org/lkml/d24bebc5-0f78-021f-293f-e58defa32531@samsung.com/
> https://lore.kernel.org/lkml/20210423171335.262316-1-tudor.ambarus@microchip.com/
> 
>  drivers/clk/clk.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index a3b30f7de2ef..b47460b40d14 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -4552,6 +4552,9 @@ int of_clk_add_provider(struct device_node *np,
>  	struct of_clk_provider *cp;
>  	int ret;
>  
> +	if (!np)
> +		return 0;
> +
>  	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>  	if (!cp)
>  		return -ENOMEM;
> @@ -4591,6 +4594,9 @@ int of_clk_add_hw_provider(struct device_node *np,
>  	struct of_clk_provider *cp;
>  	int ret;
>  
> +	if (!np)
> +		return 0;
> +
>  	cp = kzalloc(sizeof(*cp), GFP_KERNEL);
>  	if (!cp)
>  		return -ENOMEM;
> @@ -4688,6 +4694,9 @@ void of_clk_del_provider(struct device_node *np)
>  {
>  	struct of_clk_provider *cp;
>  
> +	if (!np)
> +		return;
> +
>  	mutex_lock(&of_clk_mutex);
>  	list_for_each_entry(cp, &of_clk_providers, link) {
>  		if (cp->node == np) {
> -- 
> 2.25.1
> 
