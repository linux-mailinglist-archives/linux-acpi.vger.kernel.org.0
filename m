Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C736C822
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Apr 2021 16:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236943AbhD0O6X (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 27 Apr 2021 10:58:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236173AbhD0O6X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 27 Apr 2021 10:58:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C49760FDB;
        Tue, 27 Apr 2021 14:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619535459;
        bh=IC/cBF67bAQkQJea+wXRX+PkxeJ9br/yn1UuwM/SBRQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jmNiLztt2E/Vn/QBmGbMJbeK8FfWWYI438idwUCHKmX9ijedQvc9V4V0DVdXk8wQT
         n890w17w8y2p+hwT6SDAv2S3ZQgvbS1SX4kPI5h5oOzw7FUgI0WjNd1zAA9FhPCjyB
         U6wibuNGaypvDnXv4tOzlU+VO8yHUiWUyzUPTXgm8su0SbI6+5IjCJVfh8gpMdmPgl
         0GSteCRoQnfSHqWyPvhTW35Z2RqngYPh9AvS7fdBr3h/JRsFHN4Oilj1u9fAOBDaem
         wIqNygkCji+fROnI4BCiLFPI/VjKKMt/5n62Ub8+PsWPAAhihL1jD+leLlBEITVwtG
         0V4Wpu1pEcwvA==
Message-ID: <19c1c262382d73dbf3ec37b7651c5ab05253e0f9.camel@kernel.org>
Subject: Re: [PATCH v2] clk: Skip clk provider registration when np is NULL
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, maxime@cerno.tech,
        khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com,
        pavel@ucw.cz, robh+dt@kernel.org, frowand.list@gmail.com,
        maz@kernel.org, tglx@linutronix.de, saravanak@google.com,
        geert@linux-m68k.org, nsaenzjulienne@suse.de, linux@roeck-us.net,
        guillaume.tucker@collabora.com
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 27 Apr 2021 16:57:30 +0200
In-Reply-To: <20210426065618.588144-1-tudor.ambarus@microchip.com>
References: <20210426065618.588144-1-tudor.ambarus@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2021-04-26 at 09:56 +0300, Tudor Ambarus wrote:
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
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenz@kernel.org>

Regards,
Nicolas

