Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2D4427119
	for <lists+linux-acpi@lfdr.de>; Fri,  8 Oct 2021 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhJHTAS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 Oct 2021 15:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbhJHTAS (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Oct 2021 15:00:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E948C061570;
        Fri,  8 Oct 2021 11:58:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9296146F;
        Fri,  8 Oct 2021 20:58:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1633719498;
        bh=MHBiXZNJbPeFPmG29rwaw6VIy+Lb+40kRf3KLozS164=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ve3QkZ0wRysKeFMaDqFGb7JwEWPU6UDRYkfd9QJlUR3hVcOODY0lniKciKC/SfJwP
         TxFtjnKge5JGGkfFnZsYFg5BuHVHCB9uPDurNaNq//dm/2yAasRcvXOHPSDVgxxDJs
         z6rvYPs6sxCeKyCqmJz9lhhn0AE6ZTAAKlFlINGY=
Date:   Fri, 8 Oct 2021 21:58:07 +0300
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
Message-ID: <YWCUv+gEnfWnpRS6@pendragon.ideasonboard.com>
References: <20211008162121.6628-1-hdegoede@redhat.com>
 <20211008162121.6628-3-hdegoede@redhat.com>
 <YWCQ6/AMzP5Nfcyk@pendragon.ideasonboard.com>
 <39a85265-017e-f86d-619b-c1aa6a771a26@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39a85265-017e-f86d-619b-c1aa6a771a26@redhat.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Hans,

On Fri, Oct 08, 2021 at 08:48:18PM +0200, Hans de Goede wrote:
> On 10/8/21 8:41 PM, Laurent Pinchart wrote:
> > On Fri, Oct 08, 2021 at 06:21:11PM +0200, Hans de Goede wrote:
> >> The clk and regulator frameworks expect clk/regulator consumer-devices
> >> to have info about the consumed clks/regulators described in the device's
> >> fw_node.
> >>
> >> To work around cases where this info is not present in the firmware tables,
> >> which is often the case on x86/ACPI devices, both frameworks allow the
> >> provider-driver to attach info about consumers to the clks/regulators
> >> when registering these.
> >>
> >> This causes problems with the probe ordering of the ov8865 driver vs the
> >> drivers for these clks/regulators. Since the lookups are only registered
> >> when the provider-driver binds, trying to get these clks/regulators before
> >> then results in a -ENOENT error for clks and a dummy regulator for regs.
> >>
> >> On ACPI/x86 where this is a problem, the ov8865 ACPI fw-nodes have a _DEP
> >> dependency on the INT3472 ACPI fw-node which describes the hardware which
> >> provides the clks/regulators.
> >>
> >> The drivers/platform/x86/intel/int3472/ code dealing with these ACPI
> >> fw-nodes will call acpi_dev_clear_dependencies() to indicate that this
> >> _DEP has been "met" when all the clks/regulators have been setup.
> >>
> >> Call the has_unmet_acpi_deps() helper to check for unmet _DEPs
> >> and return -EPROBE_DEFER if this returns true, so that we wait for
> >> the clk/regulator setup to be done before continuing with probing.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>  drivers/media/i2c/ov8865.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/media/i2c/ov8865.c b/drivers/media/i2c/ov8865.c
> >> index ce4e0ae2c4d3..fd18d1256f78 100644
> >> --- a/drivers/media/i2c/ov8865.c
> >> +++ b/drivers/media/i2c/ov8865.c
> >> @@ -2978,6 +2978,9 @@ static int ov8865_probe(struct i2c_client *client)
> >>  	unsigned int i;
> >>  	int ret;
> >>  
> >> +	if (has_unmet_acpi_deps(dev))
> >> +		return -EPROBE_DEFER;
> >> +
> > 
> > We've worked hard to avoid adding ACPI-specific code such as this in
> > sensor drivers, as it would then spread like crazy, and also open the
> > door to more ACPI-specific support. I don't want to open this pandora's
> > box, I'd like to see this handled in another layer (the I2C core could
> > be a condidate for instance, but bonus points if it can be handled in
> > the ACPI subsystem itself).
> 
> The problem is that we do NOT want this check for all i2c devices,

Any of these sensors can be used on non-ACPI-based platforms, or on
ACPI-based platforms where integration has been done right. If it causes
an issue to call this function on those platforms, then this driver
won't work. If it causes no issue, why can't we call it in the I2C core
(or somewhere else) ?

> so doing
> it in any place other then the drivers means having some list of APCI-ids
> to which to apply this someplace else. And then for every sensor driver
> which needs this we need to update this list.
> 
> This is wht I've chosen to just put this check directly in the sensor
> drivers. It is only 2 lines, it is a no-op on kernels where ACPI
> is not enabled (without need a #ifdef) and it is a no-op if the
> sensor i2c-client is not instantiated through APCI even when ACPI
> support is enabled in the kernel.
> 
> I understand that you don't want a lot of ACPI specific code inside
> the drivers, which is why I've come up with this fix which consists
> of only 2 lines.  My previous attempts (which I never posted)
> where much worse then this.

So we only need to take one more step to remove just two lines :-)

This is all caused by Intel messing up their ACPI design badly. It's too
late to point and shame, it won't fix the problem, but I don't want this
to spread through drivers, neither for just those two lines (there are
dozens of sensors that would need the same treatment), nor for what the
next steps would be when someone else will want to add ACPI-specific
code and use this as a precedent. That's why we tried hard with Dan
Scally to isolate all the necessary quirks in a single place instead of
spreading them through drivers, which would have been easier to
implement.

I'd like to hear what Sakari thinks about this.

> >>  	sensor = devm_kzalloc(dev, sizeof(*sensor), GFP_KERNEL);
> >>  	if (!sensor)
> >>  		return -ENOMEM;

-- 
Regards,

Laurent Pinchart
