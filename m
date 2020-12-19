Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC92DEC73
	for <lists+linux-acpi@lfdr.de>; Sat, 19 Dec 2020 01:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgLSAkN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 18 Dec 2020 19:40:13 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:50680 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLSAkN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 18 Dec 2020 19:40:13 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0482D180E;
        Sat, 19 Dec 2020 01:39:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1608338370;
        bh=Mwf0q0t0LMS6PGhWBpcj+B3EqmdyeuNAiT1SG6SpHqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EJ2cPSMkcWs8RgqA1zBGGIOT6d697PVsPE4YW+7vchJuUU83qS+8VUgnX8fDo0R6a
         LHqmo09Q1EzHrjfeEyPdp2qqXwUKPT8+4m+1vc2Q9pOSXlFwBSHrX6GUXC+I1DuQRQ
         FlS6Y4HW9T02cNxFS3RT1mHaoh12uWGyr7U/9xk4=
Date:   Sat, 19 Dec 2020 02:39:22 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Scally <djrscally@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-media@vger.kernel.org, devel@acpica.org, rjw@rjwysocki.net,
        lenb@kernel.org, gregkh@linuxfoundation.org, yong.zhi@intel.com,
        sakari.ailus@linux.intel.com, bingbu.cao@intel.com,
        tian.shu.qiu@intel.com, mchehab@kernel.org, robert.moore@intel.com,
        erik.kaneda@intel.com, pmladek@suse.com, rostedt@goodmis.org,
        sergey.senozhatsky@gmail.com, andriy.shevchenko@linux.intel.com,
        linux@rasmusvillemoes.dk,
        laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, kieran.bingham+renesas@ideasonboard.com,
        linus.walleij@linaro.org, heikki.krogerus@linux.intel.com,
        kitakar@gmail.com, jorhand@linux.microsoft.com
Subject: Re: [PATCH v2 12/12] ipu3-cio2: Add cio2-bridge to ipu3-cio2 driver
Message-ID: <X91Lum0ZPDjo1cTt@pendragon.ideasonboard.com>
References: <20201217234337.1983732-1-djrscally@gmail.com>
 <20201217234337.1983732-13-djrscally@gmail.com>
 <X9zehD1xtQP/bxXu@pendragon.ideasonboard.com>
 <5c0ae9f8-ba58-a26c-400b-7d85d01087a3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5c0ae9f8-ba58-a26c-400b-7d85d01087a3@gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Daniel,

On Fri, Dec 18, 2020 at 11:57:54PM +0000, Daniel Scally wrote:
> Hi Laurent - thanks for the comments
> 
> On 18/12/2020 16:53, Laurent Pinchart wrote:
> >> +static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
> >> +{
> >> +	strscpy(sensor->prop_names.clock_frequency, "clock-frequency",
> >> +		sizeof(sensor->prop_names.clock_frequency));
> >> +	strscpy(sensor->prop_names.rotation, "rotation",
> >> +		sizeof(sensor->prop_names.rotation));
> >> +	strscpy(sensor->prop_names.bus_type, "bus-type",
> >> +		sizeof(sensor->prop_names.bus_type));
> >> +	strscpy(sensor->prop_names.data_lanes, "data-lanes",
> >> +		sizeof(sensor->prop_names.data_lanes));
> >> +	strscpy(sensor->prop_names.remote_endpoint, "remote-endpoint",
> >> +		sizeof(sensor->prop_names.remote_endpoint));
> >> +	strscpy(sensor->prop_names.link_frequencies, "link-frequencies",
> >> +		sizeof(sensor->prop_names.link_frequencies));
> > 
> > Just curious, was there anything not working correctly with the proposal
> > I made ?
> > 
> > static const struct cio2_property_names prop_names = {
> > 	.clock_frequency = "clock-frequency",
> > 	.rotation = "rotation",
> > 	.bus_type = "bus-type",
> > 	.data_lanes = "data-lanes",
> > 	.remote_endpoint = "remote-endpoint",
> > };
> > 
> > static void cio2_bridge_init_property_names(struct cio2_sensor *sensor)
> > {
> > 	sensor->prop_names = prop_names;
> > }
> > 
> > It generates a warning when the string is too long for the field size,
> > which should help catching issues at compilation time.
> 
> Yes, though I don't know how much of a real-world problem it would have
> been - if you recall we have the issue that the device grabs a reference
> to the software_nodes (after we stopped delaying until after the
> i2c_client is available), which means we can't safely free the
> cio2_bridge struct on module unload. That also means we can't rely on
> those pointers to string literals existing, because if the ipu3-cio2
> module gets unloaded they'll be gone.

But the strings above are not stored as literals in .rodata, they're
copied in prop_names (itself in .rodata), which is then copied to
sensor->prop_names.

> Shame, as it's way neater.
> 
> >> +static void cio2_bridge_init_swnode_names(struct cio2_sensor *sensor)
> >> +{
> >> +	snprintf(sensor->node_names.remote_port, 7, "port@%u", sensor->ssdb.link);
> >> +	strscpy(sensor->node_names.port, "port@0", sizeof(sensor->node_names.port));
> >> +	strscpy(sensor->node_names.endpoint, "endpoint@0", sizeof(sensor->node_names.endpoint));
> > 
> > I'd wrap lines, but maybe that's because I'm an old-school, 80-columns
> > programmer :-)
> 
> Heh sure, I'll wrap them.
> 
> >> +static int cio2_bridge_connect_sensors(struct cio2_bridge *bridge,
> >> +				       struct pci_dev *cio2)
> >> +{
> >> +	struct fwnode_handle *fwnode;
> >> +	struct cio2_sensor *sensor;
> >> +	struct acpi_device *adev;
> >> +	unsigned int i;
> >> +	int ret = 0;
> >> +
> >> +	for (i = 0; i < ARRAY_SIZE(cio2_supported_sensors); i++) {
> >> +		const struct cio2_sensor_config *cfg = &cio2_supported_sensors[i];
> >> +
> >> +		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> >> +			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
> >> +				dev_warn(&cio2->dev, "Exceeded available CIO2 ports\n");
> >> +				/* overflow i so outer loop ceases */
> >> +				i = ARRAY_SIZE(cio2_supported_sensors);
> >> +				break;
> > 
> > Or just
> > 
> > 				return 0;
> > 
> > ?
> 
> Derp, yes of course.
> 
> 
> >> +/* Data representation as it is in ACPI SSDB buffer */
> >> +struct cio2_sensor_ssdb {
> >> +	u8 version;				/* 0000 */
> >> +	u8 sku;					/* 0001 */
> >> +	u8 guid_csi2[16];			/* 0002 */
> >> +	u8 devfunction;				/* 0003 */
> >> +	u8 bus;					/* 0004 */
> >> +	u32 dphylinkenfuses;			/* 0005 */
> >> +	u32 clockdiv;				/* 0009 */
> >> +	u8 link;				/* 0013 */
> >> +	u8 lanes;				/* 0014 */
> >> +	u32 csiparams[10];			/* 0015 */
> >> +	u32 maxlanespeed;			/* 0019 */
> >> +	u8 sensorcalibfileidx;			/* 0023 */
> >> +	u8 sensorcalibfileidxInMBZ[3];		/* 0024 */
> >> +	u8 romtype;				/* 0025 */
> >> +	u8 vcmtype;				/* 0026 */
> >> +	u8 platforminfo;			/* 0027 */
> > 
> > Why stop at 27 ? :-) I'd either go all the way, or not at all. It's also
> > quite customary to represent offset as hex values, as that's what most
> > hex editors / viewers will show.
> 
> Oops - that was actually just me debugging...I guess I might actually
> finish it, converted to hex. It came in useful reading the DSDT to have
> that somewhere easy to refer to.
> 
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> Nice - thank you!

-- 
Regards,

Laurent Pinchart
