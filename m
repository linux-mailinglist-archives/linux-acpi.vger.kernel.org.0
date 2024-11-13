Return-Path: <linux-acpi+bounces-9547-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0279C7366
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 15:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0611A1F22D5F
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481E4136326;
	Wed, 13 Nov 2024 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gu2hrPpy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E507080F;
	Wed, 13 Nov 2024 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507712; cv=none; b=AcxQKicnFG7w2rw3rGUXkvFSfw0SsHfYqTzraNayCjAho71kmTUZGdMf3h+t9mT0mmgb9ysKFkLqEN29kcPQqxO3Q43SNZIY9y1xt9GgwK0XKDn8OZma9gb3+vY+XAau25P16Z6SOybMuZJi/OKdxFqUtngrU6J/JS3ZOmCpEr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507712; c=relaxed/simple;
	bh=3DG3pVyaEIXykT94bHXydQtHV5qXoL01zSxkhQQgd14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5zHBdZ9PSYXwOHVI9K+yPhsFEbfrl+PtuuGsMWqmfEZa2C5rI7ddIbBX0jWUlTzDVTfQ5ZGLBgu+mr7fUycPC0Fn52ZPxi4Eq9jd4Kb3HKwbWy0rFCHXCDa2L5lqo0atk3hco6xQTM7M1TvZAPQeOvsz3Vq48PTcNLvWFP7uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gu2hrPpy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731507711; x=1763043711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3DG3pVyaEIXykT94bHXydQtHV5qXoL01zSxkhQQgd14=;
  b=gu2hrPpyk1kKxXRp/0GV3u7puBfY7Hx6jUf1Y7ZLIQ/j/LTwRnytJHfw
   WjscwRShnedG3XoSda2N1GLa0+YR2g+52dAog0wuy8EOlcQuPUi7I3ozV
   Z1+oZuVulMRyGmrR+arzWzrgitV76yNNXdXbKrLAGjN1VQ4yUX16hm0l4
   gpKx/Soi20C+rVyLRClj5QXN3SLHOXqoZrQuiDxKh8EefdnSeXeMs3Fx8
   yqKE4uBZ7F1aQOXlKsLE3so4WXd3nWXTy+LnV/XRHSf0j/i35g4KpevtB
   gDRcIo6jOnb92gbn1shMxWgCFrfogNstRb8oZtzFocXyb6XbMH26JispH
   A==;
X-CSE-ConnectionGUID: RXb/XS0KTuCEKO3yrlOCfw==
X-CSE-MsgGUID: oF5P/h2WR3Gi4Iqh5tHBqg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31168886"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31168886"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:21:51 -0800
X-CSE-ConnectionGUID: zG5i5Y+xS82ELxp6o8cMUQ==
X-CSE-MsgGUID: Vth3UAT9QeiHxEQOl1OTXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="88282446"
Received: from kuha.fi.intel.com ([10.237.72.152])
  by orviesa007.jf.intel.com with SMTP; 13 Nov 2024 06:21:48 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 13 Nov 2024 16:21:46 +0200
Date: Wed, 13 Nov 2024 16:21:46 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
Message-ID: <ZzS1-nJMPiCp5jDi@kuha.fi.intel.com>
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>

Hi,

On Fri, Nov 08, 2024 at 01:03:20PM +0530, Shyam Sundar S K wrote:
> As of now, the I3C subsystem only has ARM-specific initialization, and
> there is no corresponding ACPI plumbing present. To address this, ACPI
> support needs to be added to both the I3C core and DW driver.
> 
> Add support to get the ACPI handle from the _HID probed and parse the apci
> object to retrieve the slave information from BIOS.
> 
> Based on the acpi object information propogated via BIOS, build the i3c
> board information so that the same information can be used across the
> driver to handle the slave requests.
> 
> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
> Cc: linux-acpi@vger.kernel.org
> 
>  drivers/i3c/internals.h            |  3 ++
>  drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
>  drivers/i3c/master/dw-i3c-master.c |  7 +++
>  include/linux/i3c/master.h         |  1 +
>  4 files changed, 95 insertions(+)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 433f6088b7ce..178bc0ebe6b6 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -10,6 +10,9 @@
>  
>  #include <linux/i3c/master.h>
>  
> +#define I3C_GET_PID		0x08
> +#define I3C_GET_ADDR		0x7F
> +
>  void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>  void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>  
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6f3eb710a75d..0ceef2aa9161 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_ACPI)
> +static int i3c_acpi_configure_master(struct i3c_master_controller *master)
> +{
> +	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
> +	enum i3c_addr_slot_status addrstatus;
> +	struct i3c_dev_boardinfo *boardinfo;
> +	struct device *dev = &master->dev;
> +	struct fwnode_handle *fwnode;
> +	struct acpi_device *adev;
> +	u32 slv_addr, num_dev;
> +	acpi_status status;
> +	u64 val;
> +
> +	status = acpi_evaluate_object_typed(master->ahandle, "_DSD", NULL, &buf, ACPI_TYPE_PACKAGE);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(&master->dev, "Error reading _DSD:%s\n", acpi_format_exception(status));
> +		return -ENODEV;
> +	}

Why do you need to do that?

> +	num_dev = device_get_child_node_count(dev);
> +	if (!num_dev) {
> +		dev_err(&master->dev, "Error: no child node present\n");
> +		return -EINVAL;
> +	}

I think Jarkko already pointed out the problem with that. The whole
check should be dropped.

> +	device_for_each_child_node(dev, fwnode) {
> +		adev = to_acpi_device_node(fwnode);
> +		if (!adev)
> +			return -ENODEV;
> +
> +		status = acpi_evaluate_integer(adev->handle, "_ADR", NULL, &val);
> +		if (ACPI_FAILURE(status)) {
> +			dev_err(&master->dev, "Error: eval _ADR failed\n");
> +			return -EINVAL;
> +		}

val = acpi_device_adr(adev);

> +		slv_addr = val & I3C_GET_ADDR;
> +
> +		boardinfo = devm_kzalloc(dev, sizeof(*boardinfo), GFP_KERNEL);
> +		if (!boardinfo)
> +			return -ENOMEM;
> +
> +		if (slv_addr) {
> +			if (slv_addr > I3C_MAX_ADDR)
> +				return -EINVAL;
> +
> +			addrstatus = i3c_bus_get_addr_slot_status(&master->bus, slv_addr);
> +			if (addrstatus != I3C_ADDR_SLOT_FREE)
> +				return -EINVAL;
> +		}
> +
> +		boardinfo->static_addr = slv_addr;
> +		if (boardinfo->static_addr > I3C_MAX_ADDR)
> +			return -EINVAL;
> +
> +		addrstatus = i3c_bus_get_addr_slot_status(&master->bus,	boardinfo->static_addr);
> +		if (addrstatus != I3C_ADDR_SLOT_FREE)
> +			return -EINVAL;
> +
> +		boardinfo->pid = val >> I3C_GET_PID;
> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
> +			return -EINVAL;
> +
> +		/*
> +		 * According to the specification, SETDASA is not supported for DIMM slaves
> +		 * during device discovery. Therefore, BIOS will populate same initial
> +		 * dynamic address as the static address.
> +		 */
> +		boardinfo->init_dyn_addr = boardinfo->static_addr;
> +		list_add_tail(&boardinfo->node, &master->boardinfo.i3c);
> +	}
> +
> +	return 0;
> +}
> +#else
> +static int i3c_acpi_configure_master(struct i3c_master_controller *master) { return 0; }
> +#endif

I think this code should be placed into a separate file.

If the goal is to add ACPI support for code that is written for DT
only, then I think the first thing to do before that really should be
to convert the existing code to use the unified device property
interface, and move all the DT-only parts to a separate file(s).

thanks,

-- 
heikki

