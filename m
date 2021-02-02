Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2B1730CE25
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 22:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhBBVnQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 2 Feb 2021 16:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhBBVmu (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Feb 2021 16:42:50 -0500
X-Greylist: delayed 1167 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 Feb 2021 13:42:10 PST
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6427BC061573
        for <linux-acpi@vger.kernel.org>; Tue,  2 Feb 2021 13:42:10 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1l7383-0008R3-Dn; Tue, 02 Feb 2021 22:22:31 +0100
Date:   Tue, 2 Feb 2021 22:22:31 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
Message-ID: <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx>
References: <20210202043345.3778765-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202043345.3778765-1-saravanak@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana,

Thus wrote Saravana Kannan (saravanak@google.com):

> Martin,

> If you tested this series, can you please give a Tested-by?

I tested this v2 series on top of next-20210202 (without the fsl,avic
patch).

If modules are enabled, the kernel doesn't boot on my imx25 board. This
is expected, I guess.

With modules disabled, the kernel boots but probe fails for some
(non-mainline) drivers in my tree. All of those drivers have a gpio in
their device-tree node, such as

my_driver {
   gpio_test1 = <&gpio1 0 0>;
   ...
};

with gpio1 from arch/arm/boot/dts/imx25.dtsi.

The probe function calls

of_get_named_gpio(np, "gpio_test1", 0);

to get the gpio. This fails with -EINVAL.

Best regards,
Martin
