Return-Path: <linux-acpi+bounces-9501-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3CF9C5C18
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 16:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C754DB60A05
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Nov 2024 15:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B3A1FF046;
	Tue, 12 Nov 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3PythOP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFCF1FF7BF;
	Tue, 12 Nov 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731424667; cv=none; b=CLFsp4pbSRtPbLUaBpXjvL3NzSAa8A5hyeH8O5hSWWqfGE4MJMXTGlxQNOofK4/Loe7HBJoIIRCrqs3x/vbZ0kR3tw6oi4Xbw4b9XUyNJpdIcmJkV2DKmBfz7bSkE9rsEfqhqW3mgQqk73IvNtL0mEzujU1QwiVhcW3pfybHpms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731424667; c=relaxed/simple;
	bh=Iuhdp4YW1PKIzpegGZtWZUYGQeghO6KfqFIt7ql1ZwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EWCApxG9R5gb/mewej5+uUNv4Z1jJk1DbweBWgIkxeIkp0LecbbXYRQdztHhR0zVY93I807QW5LKBbWbseQgUZyfN3SEj66BVCP9mudLu8mA1fZBM9suIDQ0rfO4+CgRW7j0euR47O9I64gqNVwD+liGE0cD5sxybiuNNystIpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3PythOP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731424666; x=1762960666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Iuhdp4YW1PKIzpegGZtWZUYGQeghO6KfqFIt7ql1ZwA=;
  b=A3PythOPsVJpR395d1MVvQMCQ8AtDN+TiK45UwFOMTjXBASBRsToqizw
   RgENDy8nRsfRWEdRBPvyIJAeghZGXnrNOeAdjS13sLH4JxTH/PSJRKJAx
   gVkVW8iFEDE3O/Ocu/OKd64+2vK0SyE0IPhtUfwMuvimQN2HOMKqe35Ss
   BIBL2NfSxlRvMfTwhAAHg+h86r0Wh1cjazyo6aMvPOC7M9rnHqLK2Yk9L
   V19sItL5ALc1GHInWujxB73h03nAnyBgbXUsQ6kSOY/N2e3uAYyI1ZAh0
   fyW4HtqmvvdVHWMuP0Y+cV/qozmGK6/W3CKWbHTkJ/aDw65Oqm8pH1+18
   w==;
X-CSE-ConnectionGUID: Vb3q/ThURFmCIzXW5JIfHw==
X-CSE-MsgGUID: 2OB35yaaQAyLVazhEPxesw==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41891067"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41891067"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 07:17:45 -0800
X-CSE-ConnectionGUID: 5/1F43/yQlOFxHRxk7tXcg==
X-CSE-MsgGUID: L1NR3vMQSQeS+M+mDoFdTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87673925"
Received: from mylly.fi.intel.com (HELO [10.237.72.151]) ([10.237.72.151])
  by orviesa006.jf.intel.com with ESMTP; 12 Nov 2024 07:17:43 -0800
Message-ID: <0e0f7ac2-d97d-41b3-9239-2daabe395d4a@linux.intel.com>
Date: Tue, 12 Nov 2024 17:17:42 +0200
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
To clarify: The DSDT example I mentioned in the previous version I meant 
it would be good to have in the patch/series itself. It helps both 
reviewing the patchset and future documentation.

First I was thinking commit log itself but I guess a full DSDT example 
showing SDP target devices becomes too large and e.g. 
Documentation/firmware-guide/acpi/enumeration.rst is better?

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

These are bit confusing. One could think these are commands while 
I3C_GET_PID is a shift and I3C_GET_ADDR is a mask in the code below.

Since these are actually defines for the ACPI _ADR I tried to find are 
there already similar defines in ACPI headers but could not find and 
e.g. drivers/ata/libata-acpi.c is interpreting itself so I guess it's ok 
to define here?

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

slv_addr/static_addr > I3C_MAX_ADDR test is needless due masking above.

> +		boardinfo->pid = val >> I3C_GET_PID;
> +		if ((boardinfo->pid & GENMASK_ULL(63, 48)) ||
> +		    I3C_PID_RND_LOWER_32BITS(boardinfo->pid))
> +			return -EINVAL;
> +

Bit shifting makes PID and also test incorrect?

