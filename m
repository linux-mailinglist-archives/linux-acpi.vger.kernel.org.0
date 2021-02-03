Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B183F30E588
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Feb 2021 23:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhBCWD0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Feb 2021 17:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232869AbhBCWC7 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Feb 2021 17:02:59 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B526CC0613D6;
        Wed,  3 Feb 2021 14:02:18 -0800 (PST)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1l7QDy-0000pI-NO; Wed, 03 Feb 2021 23:02:10 +0100
Date:   Wed, 3 Feb 2021 23:02:10 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Make fw_devlink=on more forgiving
Message-ID: <20210203220210.gm7j66cagcjd6g45@viti.kaiser.cx>
References: <20210202043345.3778765-1-saravanak@google.com>
 <20210202212231.g5tj3f7tv74gagm6@viti.kaiser.cx>
 <CAGETcx_cS_Y-1Bw3tNhZRckEQO=yB8UDzNRr+Khs_X2ym7tnwA@mail.gmail.com>
 <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWN4JA4w+6MUAc-ogRAE602G8KSgy+71dtx7QQ60t1XZQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thus wrote Geert Uytterhoeven (geert@linux-m68k.org):

> > The property you are using is not a standard GPIO binding (-gpios,
> > gpio, gpios) and I'm not surprised it's not working. The gpio1 is
> > probably getting probe deferred and ends up running after "my_driver".

> So my_driver doesn't support deferred probe,

I know that the gpio definition in the device-tree is non-standard (and
should have been done differently).

Apart from this, the driver uses module_platform_driver_probe. My
understanding is that this prevents probe deferral.

Does this mean that from now on, a driver which requests a gpio must not
use module_platform_driver_probe?

Thanks,
Martin
