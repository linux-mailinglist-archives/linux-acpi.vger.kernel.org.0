Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B0237983D
	for <lists+linux-acpi@lfdr.de>; Mon, 10 May 2021 22:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbhEJUVz (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 10 May 2021 16:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:43348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229566AbhEJUVx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 10 May 2021 16:21:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94A36613C4;
        Mon, 10 May 2021 20:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620678048;
        bh=NnI6Jar/M7IdxLtxsAWt4IwLrWaSY6o6+asG73lwypk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p2hJI9M83cDG45oqbIlVUmrDpuGSgTqB+rZgiTLQy5ADDbE7geoZmjUIYljGm50RU
         9gd5JGSGKWBoSz8eqe/8nso7itp0CL1VLUdZVpFJbtUwUsRTRWMTfTYgZwfNxxllNc
         StwmKEjeAsTcOFbJvKO0TQRH86N2tlNuoBX98XpgLV5KDfPYLIkssGqez7lQ/dLqn8
         t4vUQ4KtvWWxucZOLo1aQfy+YnSFI8f0XUkPTGjnt4IwpYdznHXj9I2TWF7VUoLaNT
         bFRwIZy6GyhzjWr8KCS63nd6m8DxWLwP9kJ2mbA7EkhKyFYVTD5Tso8Vb90VC/NTsi
         9DANZXpaUwlDA==
Date:   Mon, 10 May 2021 13:20:39 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, nsaenz@kernel.org,
        maxime@cerno.tech, khilman@kernel.org, ulf.hansson@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, robh+dt@kernel.org,
        frowand.list@gmail.com, maz@kernel.org, tglx@linutronix.de,
        saravanak@google.com, geert@linux-m68k.org, nsaenzjulienne@suse.de,
        linux@roeck-us.net, guillaume.tucker@collabora.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v2] clk: Skip clk provider registration when np is NULL
Message-ID: <YJmVlwu4swD1upym@archlinux-ax161>
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

Tested-by: Nathan Chancellor <nathan@kernel.org>

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
