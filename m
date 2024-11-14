Return-Path: <linux-acpi+bounces-9575-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 062639C845E
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7171F214C6
	for <lists+linux-acpi@lfdr.de>; Thu, 14 Nov 2024 07:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60B61F5839;
	Thu, 14 Nov 2024 07:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pWKx2in4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E06E1EABAB;
	Thu, 14 Nov 2024 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570968; cv=none; b=X8cA9cZbBCxGkBbDCGHeBi31885Kh93q0Qil1s0/daRWArjsBBeTA3ke9hBJuxL322Z8xgxHi00oYlHpLm7CcpYrLYTg5BoDZYfCwClMkCQ7g9DT2LXEEb3fsEJJ36jzN1RILog63NK+f8vL/1lMFiHwSYC5OWvzWHaDUbtjKRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570968; c=relaxed/simple;
	bh=NsFz3bfePkeu9nWXYBLI0K00VvsKQ0aPkQZrmnvzB98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NC2Y/EMxhLEF44fjCoImc+CQLgt3amvU83NrdpOE7TyafnC/8ugRRtdKwP/5BOKHBQEapXd+CEiW7EN1F5s9fCkO180MegY2pPpSyowNINWgwqr7+EgEj25N5qFEQLcSl1Lir4Z1OOr2fb9hIDgE+dRpvh/qKvzt3bBm9BOsMRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pWKx2in4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5491E0009;
	Thu, 14 Nov 2024 07:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731570963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HGQfzvwZ4LhS+0JRtAIg20n5NDP4Kk7Tj1CHKPaD9oo=;
	b=pWKx2in4bHm+sIZktfqAhQ4CupdFLK5L3Gn5uvJtw0MI3w1hsf8tYYugjgEf+ODeOZ0AXx
	Z5EO9CTxmDNEAVD+vyOSjBL1DQjHd7+oltYDlw8naf4Tujw/3yo4ZqMyPhdPM0GfzlfIPE
	ICzH8HR/i5XpJA5eizLzOuMYL0NvIzi2CjAOJfOpcqDK2jmquo6n73brw8GX4i8+w7g0el
	aYScFNAN6/tvHQ5id/hgjOVBiUwtpxj+MLwlSB1q5LtGwHxM48QKYXTDN4rqAOoiPo911V
	5TlA79g0w1YxlN0qpnQwF6lI00MjPzfFOsFPCZ+EVlyfiK9LB8h2d6wVSjrYSg==
Date: Thu, 14 Nov 2024 08:56:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
Message-ID: <20241114075601f451d590@mail.local>
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
 <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
 <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079db1b6-0f95-452e-832b-7d392e130028@amd.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 14/11/2024 10:03:13+0530, Shyam Sundar S K wrote:
> 
> 
> On 11/13/2024 19:51, Heikki Krogerus wrote:
> > Hi,
> > 
> > On Fri, Nov 08, 2024 at 01:03:20PM +0530, Shyam Sundar S K wrote:
> >> As of now, the I3C subsystem only has ARM-specific initialization, and
> >> there is no corresponding ACPI plumbing present. To address this, ACPI
> >> support needs to be added to both the I3C core and DW driver.
> >>
> >> Add support to get the ACPI handle from the _HID probed and parse the apci
> >> object to retrieve the slave information from BIOS.
> >>
> >> Based on the acpi object information propogated via BIOS, build the i3c
> >> board information so that the same information can be used across the
> >> driver to handle the slave requests.
> >>
> >> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> >> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> >> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >> ---
> >> Cc: linux-acpi@vger.kernel.org
> >>
> >>  drivers/i3c/internals.h            |  3 ++
> >>  drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
> >>  drivers/i3c/master/dw-i3c-master.c |  7 +++
> >>  include/linux/i3c/master.h         |  1 +
> >>  4 files changed, 95 insertions(+)
> >>
> >> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> >> index 433f6088b7ce..178bc0ebe6b6 100644
> >> --- a/drivers/i3c/internals.h
> >> +++ b/drivers/i3c/internals.h
> >> @@ -10,6 +10,9 @@
> >>  
> >>  #include <linux/i3c/master.h>
> >>  
> >> +#define I3C_GET_PID		0x08
> >> +#define I3C_GET_ADDR		0x7F
> >> +
> >>  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
> >>  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
> >>  
> >> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> >> index 6f3eb710a75d..0ceef2aa9161 100644
> >> --- a/drivers/i3c/master.c
> >> +++ b/drivers/i3c/master.c
> >> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
> >>  	return ret;
> >>  }
> >>  
> >> +#if IS_ENABLED(CONFIG_ACPI)
> >> +static int i3c_acpi_configure_master(struct i3c_master_controller *master)
> >> +{
> >> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
> >> +	enum i3c_addr_slot_status addrstatus;
> >> +	struct i3c_dev_boardinfo *boardinfo;
> >> +	struct device *dev = &master->dev;
> >> +	struct fwnode_handle *fwnode;
> >> +	struct acpi_device *adev;
> >> +	u32 slv_addr, num_dev;
> >> +	acpi_status status;
> >> +	u64 val;
> >> +
> >> +	status = acpi_evaluate_object_typed(master->ahandle, "_DSD", NULL, &buf, ACPI_TYPE_PACKAGE);
> >> +	if (ACPI_FAILURE(status)) {
> >> +		dev_err(&master->dev, "Error reading _DSD:%s\n", acpi_format_exception(status));
> >> +		return -ENODEV;
> >> +	}
> > 
> > Why do you need to do that?
> > 
> >> +	num_dev = device_get_child_node_count(dev);
> >> +	if (!num_dev) {
> >> +		dev_err(&master->dev, "Error: no child node present\n");
> >> +		return -EINVAL;
> >> +	}
> > 
> > I think Jarkko already pointed out the problem with that. The whole
> > check should be dropped.
> > 
> >> +	device_for_each_child_node(dev, fwnode) {
> >> +		adev = to_acpi_device_node(fwnode);
> >> +		if (!adev)
> >> +			return -ENODEV;
> >> +
> >> +		status = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &val);
> >> +		if (ACPI_FAILURE(status)) {
> >> +			dev_err(&master->dev, "Error: eval _ADR failed\n");
> >> +			return -EINVAL;
> >> +		}
> > 
> > val = acpi_device_adr(adev);
> > 
> >> +		slv_addr = val & I3C_GET_ADDR;
> >> +
> >> +		boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
> >> +		if (!boardinfo)
> >> +			return -ENOMEM;
> >> +
> >> +		if (slv_addr) {
> >> +			if (slv_addr > I3C_MAX_ADDR)
> >> +				return -EINVAL;
> >> +
> >> +			addrstatus = i3c_bus_get_addr_slot_status(&master->bus, slv_addr);
> >> +			if (addrstatus != I3C_ADDR_SLOT_FREE)
> >> +				return -EINVAL;
> >> +		}
> >> +
> >> +		boardinfo->static_addr = slv_addr;
> >> +		if (boardinfo->static_addr > I3C_MAX_ADDR)
> >> +			return -EINVAL;
> >> +
> >> +		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,	boardinfo->static_addr);
> >> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> >> +			return -EINVAL;
> >> +
> >> +		boardinfo->pid = val >> I3C_GET_PID;
> >> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
> >> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
> >> +			return -EINVAL;
> >> +
> >> +		/*
> >> +		 * According to the specification, SETDASA is not supported for DIMM slaves
> >> +		 * during device discovery. Therefore, BIOS will populate same initial
> >> +		 * dynamic address as the static address.
> >> +		 */
> >> +		boardinfo->init_dyn_addr = boardinfo->static_addr;
> >> +		list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +#else
> >> +static int i3c_acpi_configure_master(struct i3c_master_controller *master) { return 0; }
> >> +#endif
> > 
> > I think this code should be placed into a separate file.
> > 
> > If the goal is to add ACPI support for code that is written for DT
> > only, then I think the first thing to do before that really should be
> > to convert the existing code to use the unified device property
> > interface, and move all the DT-only parts to a separate file(s).
> > 
> 
> Thank you Jarkko and Heikki. Let me work and these remarks and come
> back with a new version.
> 
> Jarkko, will you be able to pick 1/5 and 5/5 without a separate series
> or do you want me to send one?

Please send a new series.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

