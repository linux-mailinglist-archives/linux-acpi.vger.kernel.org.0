Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B076837A066
	for <lists+linux-acpi@lfdr.de>; Tue, 11 May 2021 09:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEKHML (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 May 2021 03:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbhEKHML (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 May 2021 03:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C7EF261926;
        Tue, 11 May 2021 07:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620717065;
        bh=djMw+MkHqXSDFMuuNAj5hXKn0ROWz969fz0NJXZ2+Oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yzr6qHAPC4C2gAz9uxv2B3lxa6Hv0XWXup4Ed9z38Ulr70tmmu3RRYB0UtXg0wyOY
         CCmomC1i4VIPn8HdQulkOj4jrgzm+fj4JCtDVDx0qYy0rC5u8akRKGbkDvLzYRJ+mp
         GUpWxXJw7e6yYDuxnQBjpybVUUUbFlqQPe7Khp+k=
Date:   Tue, 11 May 2021 09:11:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>, rafael@kernel.org,
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
Message-ID: <YJouB/ZUOcadrokW@kroah.com>
References: <20210426065618.588144-1-tudor.ambarus@microchip.com>
 <20210510193645.GA3920948@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210510193645.GA3920948@roeck-us.net>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, May 10, 2021 at 12:36:45PM -0700, Guenter Roeck wrote:
> On Mon, Apr 26, 2021 at 09:56:18AM +0300, Tudor Ambarus wrote:
> > commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> > revealed that clk/bcm/clk-raspberrypi.c driver calls
> > devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted in a
> > NULL pointer dereference in of_clk_add_hw_provider() when calling
> > fwnode_dev_initialized().
> > 
> > Returning 0 is reducing the if conditions in driver code and is being
> > consistent with the CONFIG_OF=n inline stub that returns 0 when CONFIG_OF
> > is disabled. The downside is that drivers will maybe register clkdev lookups
> > when they don't need to and waste some memory.
> > 
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> > Fixes: 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/removed")
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> Tested-by: Guenter Roeck <linux@roeck-us.net>

Now applied to my tree, thanks and sorry for the delay, I thought this
was going through the clk tree.

greg k-h
