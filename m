Return-Path: <linux-acpi+bounces-9539-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60139C6BA6
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 10:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C5284497
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Nov 2024 09:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8955B1F80B1;
	Wed, 13 Nov 2024 09:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnYBbn3J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A3178CC8;
	Wed, 13 Nov 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731490966; cv=none; b=I2ziBbk0mNF7uALQRyQNCa0azdFxLqr9mP+l76ghaatfB09ZI2b3oK7fnatk9oaX06hidVa+Ey2WU0XEGr6amaUvOGkg6IoqIrEk6Ij5risLHURQj2I9TtyIe7/7wZaR3fO1h5+dtHEZ8GGHzMsbGqalFwg6X56qLJouGvTt7TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731490966; c=relaxed/simple;
	bh=CnTg97obo1Lsr06BXYdZdsStwzIsiBw+tlILjkvdR+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PCfe1aW8tcrQ2/HK7kLVn/yISFHg5X7/dOlfuHJS5xagEMtVeUFh75E/P/3GvKYwYzpuurfb1Bxv4+6H/5l4Yp6pL+hmsoYyof/29q4pN3O7MH2kySo1iVMhrTOSOtMtinwVE3Y3fUmAWID8DMwsaEWxDPXowep5mQgz9fZRNt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnYBbn3J; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731490965; x=1763026965;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CnTg97obo1Lsr06BXYdZdsStwzIsiBw+tlILjkvdR+U=;
  b=WnYBbn3JREPgm3n7im0EyTp2LuAY4jg3/VlhrYEhxPxvjYuJbUC+86jW
   gFFuAqv4TLbYRAKsi0e9+y0fTsdKBiLhu5Ig9ipQqDSH4mKgCGGm35skI
   c5ehiGNdyuFamQsTH15GdgmEY8l8SwTe0rdkWahN52a1N6d1mRkwSYOyi
   IhT/Dqt+L/Y2o8bc4BQ65BRsmUZpG04o0Hw/bhedrvANlqoSfyXDjqWfo
   krWBi9R5jSztjHUPL7X3O9/3KM87urRKvyg3wN2V8yL4s35exUqbY50SP
   tM3svzlcgctdUu3ruxIucNvHawY/TCk0bjdy3AclOWgliLe/3Qxvi2pCU
   g==;
X-CSE-ConnectionGUID: 18q78WdBRiqcY8VqVRGgrg==
X-CSE-MsgGUID: ThCdVxE3RTe1ekI3H8n71Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31229446"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31229446"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 01:42:36 -0800
X-CSE-ConnectionGUID: ZJXmawWEQXSXDgxWFRqoHg==
X-CSE-MsgGUID: 7sstyEgHRHO20zrSlRz5BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="92751496"
Received: from mylly.fi.intel.com (HELO [10.237.72.58]) ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP; 13 Nov 2024 01:42:35 -0800
Message-ID: <1ad5f698-725a-4779-ad5d-936ae8cbab14@linux.intel.com>
Date: Wed, 13 Nov 2024 11:42:33 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] i3c: master: Add ACPI support to i3c subsystem
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Sanket.Goswami@amd.com, linux-i3c@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20241108073323.523805-1-Shyam-sundar.S-k@amd.com>
 <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
In-Reply-To: <20241108073323.523805-3-Shyam-sundar.S-k@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi

On 11/8/24 9:33 AM, Shyam Sundar S K wrote:
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
>   drivers/i3c/internals.h            |  3 ++
>   drivers/i3c/master.c               | 84 ++++++++++++++++++++++++++++++
>   drivers/i3c/master/dw-i3c-master.c |  7 +++
>   include/linux/i3c/master.h         |  1 +
>   4 files changed, 95 insertions(+)
> 
> diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> index 433f6088b7ce..178bc0ebe6b6 100644
> --- a/drivers/i3c/internals.h
> +++ b/drivers/i3c/internals.h
> @@ -10,6 +10,9 @@
>   
>   #include <linux/i3c/master.h>
>   
> +#define I3C_GET_PID		0x08
> +#define I3C_GET_ADDR		0x7F
> +
>   void i3c_bus_normaluse_lock(struct i3c_bus *bus);
>   void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
>   
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 6f3eb710a75d..0ceef2aa9161 100644
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
I didn't notice earlier these cause host controller registration to fail 
and thus regression on platforms where DSDT doesn't have these optional 
information for the host controller.

