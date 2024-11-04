Return-Path: <linux-acpi+bounces-9274-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613A19BB715
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 15:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C3E1C21EF6
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Nov 2024 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA987083E;
	Mon,  4 Nov 2024 14:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KiVBb0TH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567C79FD;
	Mon,  4 Nov 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730729194; cv=none; b=DaicDse2DQeLhJwdF3bSkj0q2u2KRwgkt1a4gmzW683X6Diwh+o2Yz9PKCZgUL3R3TVoZaqqrb6l+SvDcRP8+fMa5JlQHNnretfrz9iGAIYMwvFnNN72K8/flkIbLgyMj2tnfhwi64G2VwlZromQpD7rJrL8cex2+fAxirk8HbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730729194; c=relaxed/simple;
	bh=VXAcHtL5x5ge/VyyxMeQg5COdO2jV9c/IRLXzuvE+c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMtfxdTvLl8OywW9RlzKYQUvZa3ZKP6dyGBDOs9Z6N95lS/bxuSQdYgDg7NXyJQWmoh8Nw7uUfUeXhKFj/d6S2DzhwHx/Vh6/aYrEIEgBjCuWJSEXUDhIijFO8/tDlNNbDDltD6GDpErfmgnY0QmfOrEUMxO6VhdRSU88wTDAxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KiVBb0TH; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730729193; x=1762265193;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VXAcHtL5x5ge/VyyxMeQg5COdO2jV9c/IRLXzuvE+c8=;
  b=KiVBb0THZAaz7EG1U2XJ5szOKmD/Ia/tA6ikdG0+YCjVpOlcXSjcWgx2
   D2We99iXJFxDd8oIwvkdJp5TTsJrrMcxghJHfsKgsNyLxbRiGxn+2D0gy
   oJ/FMu9h/v7rb2Vy7kN5C9aZ/R0kYQxvh5zMysPwBvHpEpQB9aWoSvfZ1
   0d4v0G8rYzmVkm8TtKRAIJ928DGJuj5CJeRwv704pFtYHp2z9lE3h1nfI
   lCdCT4PRZwoLsCIKP3E7Vki24Li45oyMYu1+Sy2KeG0lwzknqH9AARtEI
   yjFKy5mxMKzW2h+KiXCl+a3xh+/Xc+QZznybHRtB/3XHgYPxWLB/CTNN2
   A==;
X-CSE-ConnectionGUID: uvkF+/FwRsaUS/uyPCdcuA==
X-CSE-MsgGUID: 8rbqfVjuTaus33Kwvv3fkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11246"; a="33263930"
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="33263930"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 06:06:32 -0800
X-CSE-ConnectionGUID: 4k40pCOPSUyyQkBY1mEzew==
X-CSE-MsgGUID: l5TnZGeFQBKZVeeSYLgNBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,257,1725346800"; 
   d="scan'208";a="83775755"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2024 06:06:30 -0800
Message-ID: <7cfc1f2a-cb4a-4ddc-af0a-df7793ad4487@linux.intel.com>
Date: Mon, 4 Nov 2024 16:06:29 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] i3c: master: Add ACPI support to i3c subsystem
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20241023055118.1400286-1-Shyam-sundar.S-k@amd.com>
 <20241023055118.1400286-4-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241023055118.1400286-4-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

+ linux-acpi

On 10/23/24 8:51 AM, Shyam Sundar S K wrote:
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
I think it would be good to have a DSDT example here?

> Co-developed-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> ---
>   drivers/i3c/internals.h            |  2 +
>   drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
>   drivers/i3c/master/dw-i3c-master.c |  7 +++
>   include/linux/i3c/master.h         |  1 +
>   4 files changed, 94 insertions(+)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 433f6088b7ce..d2d6c69b19dd 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -10,6 +10,8 @@
>   
>   #include <linux/i3c/master.h>
>   
> +#define AMD_I3C_GET_SLAVE_ADDR		0x30
> +
>   void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>   void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>   
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6f3eb710a75d..7d23c32e1c0f 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2251,6 +2251,84 @@ static int of_i3c_master_add_dev(struct i3c_master_controller *master,
>   	return ret;
>   }
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
> +
> +	num_dev = device_get_child_node_count(dev);
> +	if (!num_dev) {
> +		dev_err(&master->dev, "Error: no child node present\n");
> +		return -EINVAL;
> +	}
> +
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
> +		slv_addr = val >> AMD_I3C_GET_SLAVE_ADDR;

This doesn't seem to match with ACPI 6.5 spec [1] chapter 6.1.1 _ADR 
(Address)? Address encoding for I3C says:

Bits [63:52] - Reserved
Bits [51:48] - Master Instance
Bits [47:0] - I3C Device Provisional ID, following encoding defined in 
the MIPI
Specification for I3C.
If an I3C device supports a static address instead of a Provisional ID, 
then bits
[47:7] are Reserved (zero), and bits [6:0] are the 7-bit static address.

1. https://uefi.org/sites/default/files/resources/ACPI_Spec_6_5_Aug29.pdf

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
> +		boardinfo->pid = (val & GENMASK(47, 0));
> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
> +			return -EINVAL;
> +
> +		/*
> +		 * According to the specification, SETDASA is not supported for DIMM slaves
> +		 * during device discovery. Therefore, AMD BIOS will populate same initial
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
> +
>   static int of_populate_i3c_bus(struct i3c_master_controller *master)
>   {
>   	struct device *dev = &master->dev;
> @@ -2771,6 +2849,12 @@ int i3c_master_register(struct i3c_master_controller *master,
>   	master->dev.coherent_dma_mask = parent->coherent_dma_mask;
>   	master->dev.dma_parms = parent->dma_parms;
>   
> +	if (has_acpi_companion(master->dev.parent)) {
> +		ret = i3c_acpi_configure_master(master);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>   	ret = of_populate_i3c_bus(master);
>   	if (ret)
>   		goto err_put_dev;
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index fd58a95ae1c3..f683e2a398ad 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1602,6 +1602,13 @@ int dw_i3c_common_probe(struct dw_i3c_master *master,
>   	master->maxdevs = ret >> 16;
>   	master->free_pos = GENMASK(master->maxdevs - 1, 0);
>   
> +#if IS_ENABLED(CONFIG_ACPI)
> +	ACPI_COMPANION_SET(&master->base.dev, ACPI_COMPANION(&pdev->dev));
> +	master->base.ahandle = acpi_device_handle(ACPI_COMPANION(&pdev->dev));
> +	if (!master->base.ahandle)
> +		dev_err(&pdev->dev, "Failed to get acpi device handle\n");
> +#endif
> +
>   	INIT_WORK(&master->hj_work, dw_i3c_hj_work);
>   	ret = i3c_master_register(&master->base, &pdev->dev,
>   				  &dw_mipi_i3c_ops, false);
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 2a1ed05d5782..367faf7c4bf3 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -523,6 +523,7 @@ struct i3c_master_controller {
>   	} boardinfo;
>   	struct i3c_bus bus;
>   	struct workqueue_struct *wq;
> +	acpi_handle ahandle;
>   };
>   
>   /**


