Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332D74270E5
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 20:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbhJHSn4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 14:43:56 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:55780 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhJHSnz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 14:43:55 -0400
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 30482146F;
        Fri,  8 Oct 2021 20:41:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633718518;
        bh=X6pK5WZ7QQHsePVXVcQyefpC0KmEQLZeMJIq+1gqhqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q3c+eR8HxDUKULXnjiyDdmt4OqVKzMIWw2kS2Ex95FG8QYMn/vSim/fJQcYzMtroH
         jRjguikOO2MQn9KC0SbQpJ40GCLNJc3xagSXQjuW/23JnjBqDb6kPN/11n0UUaGcN3
         MgQimbv+Q2ggaZTAoh0TaGULWHQDYcJnypymQQAA=
Date:   Fri, 8 Oct 2021 21:41:47 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Kate Hsuan <hpa@redhat.com>, linux-media@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 02/12] media: i2c: ov8865: Add an has_unmet_acpi_deps()
 check
Message-ID: <YWCQ6/AMzP5Nfcyk@pendragon.ideasonboard.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211008162121.6628-3-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

Thank you for the patch.

On Fri, Oct 08, 2021 at 06:21:11PM +0200, Hans de Goede wrote:
> The clk and regulator frameworks expect clk/regulator consumer-devices
> to have info about the consumed clks/regulators described in the device's
> fw_node.
> 
> To work around cases where this info is not present in the firmware tables,
> which is often the case on x86/ACPI devices, both frameworks allow the
> provider-driver to attach info about consumers to the clks/regulators
> when registering these.
> 
> This causes problems with the probe ordering of the ov8865 driver vs the
> drivers for these clks/regulators. Since the lookups are only registered
> when the provider-driver binds, trying to get these clks/regulators before
> then results in a -ENOENT error for clks and a dummy regulator for regs.
> 
> On ACPI/x86 where this is a problem, the ov8865 ACPI fw-nodes have a _DEP
> dependency on the INT3472 ACPI fw-node which describes the hardware which
> provides the clks/regulators.
> 
> The drivers/platform/x86/intel/int3472/ code dealing with these ACPI
> fw-nodes will call acpi_dev_clear_dependencies() to indicate that this
> _DEP has been "met" when all the clks/regulators have been setup.
> 
> Call the has_unmet_acpi_deps() helper to check for unmet _DEPs
> and return -EPROBE_DEFER if this returns true, so that we wait for
> the clk/regulator setup to be done before continuing with probing.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/media/i2c/ov8865.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> index ce4e0ae2c4d3..fd18d1256f78 100644
> --- a/drivers/media/i2c/ov8865.c
> +++ b/drivers/media/i2c/ov8865.c
> @@ -2978,6 +2978,9 @@ static int ov8865_probe(struct i2c_client *client)
>  	unsigned int i;
>  	int ret;
>  
> +	if (has_unmet_acpi_deps(dev))
> +		return -EPROBE_DEFER;
> +

We've worked hard to avoid adding ACPI-specific code such as this in
sensor drivers, as it would then spread like crazy, and also open the
door to more ACPI-specific support. I don't want to open this pandora's
box, I'd like to see this handled in another layer (the I2C core could
be a condidate for instance, but bonus points if it can be handled in
the ACPI subsystem itself).

>  	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
>  	if (!sensor)
>  		return -ENOMEM;

-- 
Regards,

Laurent Pinchart
