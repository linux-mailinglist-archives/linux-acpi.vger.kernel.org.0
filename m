Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE495369E59
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Apr 2021 03:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhDXBSV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 21:18:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhDXBSU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 21:18:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78CFF61207;
        Sat, 24 Apr 2021 01:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619227063;
        bh=By/NN3iKUDMMXc5KvREFSYtN3+1LHo46xXT/i+85luc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z55so2ptj24WKgL+MBpW1ZrgDMQw+QeK3hSf4UTuSOuQ8hERuzwfYYJhBeveDYg8Q
         RqJwuVSXGQm8knWyvYHOS5eFLGTo+xu+QCyVNM8/dJ25DGGPGUd5dR+B+EMuB28dy9
         WQVrt+Qx3LYF8IVnrpEkOJmu0hSWguy/fDZw/tNf+qzpjqMrrYZVUQDjxdRst/IupS
         1ymQbOeDbDsKpeGqxUNTOQhCo2RBXttoGOtzGTy4bHnrS3TW0tMWwFoS65jF31arnh
         t/qK+tcL56qVXCMS3+x+mHJ7gHxn8nWewaSf922r9MxTtCEH9ubm27os5pFSzV2vLh
         jtU+NkV0IRY7w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210423191236.265996-1-tudor.ambarus@microchip.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com> <20210423191236.265996-1-tudor.ambarus@microchip.com>
Subject: Re: [PATCH] clk: Skip clk provider registration when np is NULL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        linux-rpi-kernel@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        frowand.list@gmail.com, geert@linux-m68k.org,
        gregkh@linuxfoundation.org, guillaume.tucker@collabora.com,
        khilman@kernel.org, len.brown@intel.com, linux@roeck-us.net,
        maxime@cerno.tech, maz@kernel.org, mturquette@baylibre.com,
        nsaenz@kernel.org, nsaenzjulienne@suse.de, pavel@ucw.cz,
        rafael@kernel.org, robh+dt@kernel.org, saravanak@google.com,
        tglx@linutronix.de, ulf.hansson@linaro.org
Date:   Fri, 23 Apr 2021 18:17:42 -0700
Message-ID: <161922706225.4054253.6359310296431247310@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Quoting Tudor Ambarus (2021-04-23 12:12:36)
> commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is adde=
d")
> revealed that clk/bcm/clk-raspberrypi.c driver calls
> devm_of_clk_add_hw_provider(), with a NULL dev->of_node, which resulted i=
n a
> NULL pointer dereference in of_clk_add_provider() when calling
> fwnode_dev_initialized().
>=20
> Returning 0 is reducing the if conditions in driver code and is being
> consistent with the CONFIG_OF=3Dn inline stub that returns 0 when CONFIG_=
OF
> is disabled. The downside is that drivers will maybe register clkdev look=
ups
> when they don't need to and waste some memory.
>=20
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is adde=
d")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---

Please don't send patches as replies to previous threads. It makes it
harder to find the patch at a glance of all threads.

It also seems to be a

Fixes: 3c9ea42802a1 ("clk: Mark fwnodes when their clock provider is added/=
removed")

so can you please have both Fixes tags?

> This would be the second approach, where we don't return an error when
> one calls devm_of_clk_add_hw_provider with a NULL of_node, but instead
> we just return 0 and skip the logic in the core and the drivers.

With the Fixes tag updated please send To: gregkh@ to pick up as the
problematic patch (6579c8d97ad7) is in the driver tree and not the clk
tree, and add my tag

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
