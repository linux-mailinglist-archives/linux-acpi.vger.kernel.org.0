Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F607369946
	for <lists+linux-acpi@lfdr.de>; Fri, 23 Apr 2021 20:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243570AbhDWSWp (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 23 Apr 2021 14:22:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243555AbhDWSWp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 23 Apr 2021 14:22:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F90D6144D;
        Fri, 23 Apr 2021 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619202128;
        bh=WAdxlQGbugIz8yOmDLwAmcT5y8V9JXDkna8OjiDows4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qKD0GwbREW9E6GvZk+Hp9L5bLoqeLQx/MVgNcaoxEq6rfGcsrEFz3cwD4AE7M168m
         Pyc/VZY9lqIa0+LTVtq4OKM/tKo7ZQhjlZbYzpLEGGJ4TUO6e1BLc2JeAhLJllKkMZ
         nIJ0F601OVFCvC73tA89K0tVdjrFuYT0t8Y8s7SCqWowoe8Uk/b2z904QGxlA8ySJD
         +a9OXZItKyciwLZTRIWOxxdBKkhyP0WAEf5vtJFNX8lY++aIBlbPXVF1coUiIn9F4c
         eWG2vHZocJPuL04o9USW4zv5wRg7mQcsRzAZ+Nt24eH5i+l1TGMKYsZX2EFFTtLFVl
         sfmAeg0WPBDBQ==
Message-ID: <528ab89224ba27f6164135a8ac00a828e7113805.camel@kernel.org>
Subject: Re: [PATCH 1/2] clk: Do not register provider with a NULL
 dev->of_node
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Saravana Kannan <saravanak@google.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, maxime@cerno.tech,
        gregkh@linuxfoundation.org, rafael@kernel.org, khilman@kernel.org,
        ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz,
        robh+dt@kernel.org, frowand.list@gmail.com, maz@kernel.org,
        tglx@linutronix.de, geert@linux-m68k.org, nsaenzjulienne@suse.de,
        linux@roeck-us.net, guillaume.tucker@collabora.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com,
        linux-rpi-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 23 Apr 2021 20:21:59 +0200
In-Reply-To: <CAGETcx-81hPTW_EVexMWaxGSOknuK-zESqKdiuQvye=n3TaHkA@mail.gmail.com>
References: <20210423171335.262316-1-tudor.ambarus@microchip.com>
         <20210423171335.262316-2-tudor.ambarus@microchip.com>
         <CAGETcx-81hPTW_EVexMWaxGSOknuK-zESqKdiuQvye=n3TaHkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Saravana, Tudor,

On Fri, 2021-04-23 at 10:24 -0700, Saravana Kannan wrote:
> On Fri, Apr 23, 2021 at 10:14 AM Tudor Ambarus
> <tudor.ambarus@microchip.com> wrote:
> > 
> > commit 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> > revealed that clk/bcm/clk-raspberrypi.c driver calls
> > devm_of_clk_add_hw_provider(), with a NULL dev->of_node.
> > 
> > devm_of_clk_add_hw_provider() should not register the provider with
> > a NULL dev->of_node, as there is no of_node. Apart of the NULL pointer
> > dereference that will result when calling fwnode_dev_initialized() in
> > of_clk_add_hw_provider(), another problem is that when two drivers calling
> > of_clk_add_hw_provider() with np = NULL, their unregistration order is not
> > guaranteed to be correct. Avoid all the problems and just return -ENODEV
> > when the callers of devm_of_clk_add_hw_provider() use a NULL dev->of_node,
> > which seems the natural way to do.
> > 
> > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Fixes: 6579c8d97ad7 ("clk: Mark fwnodes when their clock provider is added")
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> >  drivers/clk/clk.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index e2ec1b745243..8b5077cc5e67 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -4634,11 +4634,10 @@ static struct device_node *get_clk_provider_node(struct device *dev)
> >   * @get: callback for decoding clk_hw
> >   * @data: context pointer for @get callback
> >   *
> > - * Registers clock provider for given device's node. If the device has no DT
> > - * node or if the device node lacks of clock provider information (#clock-cells)
> > - * then the parent device's node is scanned for this information. If parent node
> > - * has the #clock-cells then it is used in registration. Provider is
> > - * automatically released at device exit.
> > + * Registers clock provider for given device's node. If the device node lacks
> > + * of clock provider information (#clock-cells) then the parent device's node is
> > + * scanned for this information. If parent node has the #clock-cells then it is
> > + * used in registration. Provider is automatically released at device exit.
> >   *
> >   * Return: 0 on success or an errno on failure.
> >   */
> > @@ -4650,6 +4649,9 @@ int devm_of_clk_add_hw_provider(struct device *dev,
> >         struct device_node **ptr, *np;
> >         int ret;
> > 
> > +       if (!dev->of_node)
> > +               return -ENODEV;
> > +
> 
> Based on the other discussions, for now, just return 0. The error
> might cause other issues in other drivers. We can clean this up later.

+1, Let's return 0 and do nothing skip the logic in the driver.

Now, from what I read in devm_of_clk_add_hw_provider(), there is a use case for
entering with '!dev->of_node'. See get_clk_provider_node()'s usage. So I think
we should only bail if that function fails to provide a device_node.

Regards,
Nicolas


