Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71347430330
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236691AbhJPPMo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 11:12:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:44654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237173AbhJPPMl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 11:12:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 354846101E;
        Sat, 16 Oct 2021 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634397031;
        bh=mU5Y9vlLzip55WzliGBSLv/7GAhweEs2Izw8C2YXQdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlgKzBH9Q763oiwHasgZZHvZNV4fgij5sZA6VK2lYubyOWDisz1zQCMIYqK3KThk3
         CBb2f4w/F5E5K2jbbuBadgPCY8W0HlPe5X/GxnkuXnbHgufcby/R/a/Frl4pq8zy+/
         mR0nwnrAQVAHHdTg14qxb1VjC5Yqu534yiTwFWcM=
Date:   Sat, 16 Oct 2021 17:10:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: [PATCH v4 3/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update Telemetry
Message-ID: <YWrrYWeW7uaiJ51u@kroah.com>
References: <cover.1634310710.git.yu.c.chen@intel.com>
 <838245e376c7e6fd0fe1ef55d004ed53763846a2.1634310710.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <838245e376c7e6fd0fe1ef55d004ed53763846a2.1634310710.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 16, 2021 at 06:44:31PM +0800, Chen Yu wrote:
> Platform Firmware Runtime Update(PFRU) Telemetry Service is part of RoT
> (Root of Trust), which allows PFRU handler and other PFRU drivers to
> produce telemetry data to upper layer OS consumer at runtime.
> 
> The linux provides interfaces for the user to query the parameters of
> telemetry data, and the user could read out the telemetry data
> accordingly.

What type of interface is this?  How does userspace interact with it?

> 
> Also add the ABI documentation.

Add it where?

> 
> Typical log looks like:
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> ProcessSmmRuntimeUpdate = START, Action = 2
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> FwVersion = 0, CodeInjectionVersion = 1
> [ShadowSmmRuntimeUpdateImage]
> Image = 0x74D9B000, ImageSize = 0x1172
> [ProcessSmmRuntimeUpdate]
> ShadowSmmRuntimeUpdateImage.Status = Success
> [ValidateSmmRuntimeUpdateImage]
> CapsuleHeader.CapsuleGuid = 6DCBD5ED-E82D-4C44-BDA1-7194199AD92A
> [ValidateSmmRuntimeUpdateImage]
> FmpCapHeader.Version = 1
> [ValidateSmmRuntimeUpdateImage]
> FmpCapImageHeader.UpdateImageTypeId = B2F84B79-7B6E-4E45-885F-3FB9BB185402
> [ValidateSmmRuntimeUpdateImage]
> SmmRuntimeUpdateVerifyImageWithDenylist.Status = Success
> [ValidateSmmRuntimeUpdateImage]
> SmmRuntimeUpdateVerifyImageWithAllowlist.Status = Success
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.Signature = 0x31494353
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.PlatformId = 63462139-A8B1-AA4E-9024-F2BB53EA4723
> [SmmCodeInjectionVerifyPayloadHeader]
> PayloadHeader.SupportedSmmFirmwareVersion = 0,
> PayloadHeader.SmmCodeInjectionRuntimeVersion = 1
> [ProcessSmmRuntimeUpdate]
> ValidateSmmRuntimeUpdateImage.Status = Success
> CPU CSR[0B102D28] Before = 7FBF830E
> CPU CSR[0B102D28] After = 7FBF8310
> [ProcessSmmRuntimeUpdate] ProcessSmmCodeInjection.Status = Success
> [SmmRuntimeUpdateHandler.ProcessSmmRuntimeUpdate]
> ProcessSmmRuntimeUpdate = End, Status = Success

This log does not make any sense to me, where is it from?  Why the odd
line-wrapping?

> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v4: Remove the telemetry kernel Kconfig and combine it with pfru
>     (Rafael J. Wysocki)
>     Remove redundant parens. (Rafael J. Wysocki)
> v3: Use __u32 instead of int and __64 instead of unsigned long
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Rename the structure in uapi to start with a prefix pfru so as
>     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> v2: Do similar clean up as pfru_update driver:
>     Add sanity check for duplicated instance of ACPI device.
>     Update the driver to work with allocated telem_device objects.
>     (Mike Rapoport)
>     For each switch case pair, get rid of the magic case numbers
>     and add a default clause with the error handling.
>     (Mike Rapoport)
> ---
>  drivers/acpi/pfru/pfru_update.c | 380 +++++++++++++++++++++++++++++++-
>  include/uapi/linux/pfru.h       |  43 ++++
>  2 files changed, 421 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
> index f57a39e79808..fe5b1bf0aeb3 100644
> --- a/drivers/acpi/pfru/pfru_update.c
> +++ b/drivers/acpi/pfru/pfru_update.c
> @@ -55,6 +55,27 @@ enum update_index {
>  	UPDATE_NR_IDX,
>  };
>  
> +enum log_index {
> +	LOG_STATUS_IDX,
> +	LOG_EXT_STATUS_IDX,
> +	LOG_MAX_SZ_IDX,
> +	LOG_CHUNK1_LO_IDX,
> +	LOG_CHUNK1_HI_IDX,
> +	LOG_CHUNK1_SZ_IDX,
> +	LOG_CHUNK2_LO_IDX,
> +	LOG_CHUNK2_HI_IDX,
> +	LOG_CHUNK2_SZ_IDX,
> +	LOG_ROLLOVER_CNT_IDX,
> +	LOG_RESET_CNT_IDX,
> +	LOG_NR_IDX,
> +};
> +
> +struct pfru_log_device {
> +	struct device *dev;
> +	guid_t uuid;
> +	struct pfru_log_info info;
> +};
> +
>  struct pfru_device {
>  	guid_t uuid, code_uuid, drv_uuid;
>  	int rev_id;
> @@ -62,6 +83,299 @@ struct pfru_device {
>  };
>  
>  static struct pfru_device *pfru_dev;
> +static struct pfru_log_device *pfru_log_dev;
> +
> +static int get_pfru_log_data_info(struct pfru_log_data_info *data_info,
> +				  int log_type)
> +{
> +	union acpi_object *out_obj, in_obj, in_buf;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	handle = ACPI_HANDLE(pfru_log_dev->dev);
> +
> +	memset(&in_obj, 0, sizeof(in_obj));
> +	memset(&in_buf, 0, sizeof(in_buf));
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = 1;
> +	in_obj.package.elements = &in_buf;
> +	in_buf.type = ACPI_TYPE_INTEGER;
> +	in_buf.integer.value = log_type;
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
> +					  pfru_log_dev->info.log_revid, FUNC_GET_DATA,
> +					  &in_obj, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return ret;
> +
> +	if (out_obj->package.count < LOG_NR_IDX)
> +		goto free_acpi_buffer;
> +
> +	if (out_obj->package.elements[LOG_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->ext_status =
> +		out_obj->package.elements[LOG_EXT_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_MAX_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->max_data_size =
> +		out_obj->package.elements[LOG_MAX_SZ_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK1_LO_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk1_addr_lo =
> +		out_obj->package.elements[LOG_CHUNK1_LO_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK1_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk1_addr_hi =
> +		out_obj->package.elements[LOG_CHUNK1_HI_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK1_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk1_size =
> +		out_obj->package.elements[LOG_CHUNK1_SZ_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK2_LO_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk2_addr_lo =
> +		out_obj->package.elements[LOG_CHUNK2_LO_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK2_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk2_addr_hi =
> +		out_obj->package.elements[LOG_CHUNK2_HI_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_CHUNK2_SZ_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->chunk2_size =
> +		out_obj->package.elements[LOG_CHUNK2_SZ_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->rollover_cnt =
> +		out_obj->package.elements[LOG_ROLLOVER_CNT_IDX].integer.value;
> +
> +	if (out_obj->package.elements[LOG_RESET_CNT_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	data_info->reset_cnt =
> +		out_obj->package.elements[LOG_RESET_CNT_IDX].integer.value;
> +
> +	ret = 0;
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static int set_pfru_log_level(int level)
> +{
> +	union acpi_object *out_obj, *obj, in_obj, in_buf;
> +	enum pfru_dsm_status status;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	handle = ACPI_HANDLE(pfru_log_dev->dev);
> +
> +	memset(&in_obj, 0, sizeof(in_obj));
> +	memset(&in_buf, 0, sizeof(in_buf));
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = 1;
> +	in_obj.package.elements = &in_buf;
> +	in_buf.type = ACPI_TYPE_INTEGER;
> +	in_buf.integer.value = level;
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
> +					  pfru_log_dev->info.log_revid, FUNC_SET_LEV,
> +					  &in_obj, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	obj = &out_obj->package.elements[0];
> +	status = obj->integer.value;
> +	if (status)
> +		goto free_acpi_buffer;
> +
> +	obj = &out_obj->package.elements[1];
> +	status = obj->integer.value;
> +	if (status)
> +		goto free_acpi_buffer;
> +
> +	ret = 0;
> +
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static int get_pfru_log_level(int *level)
> +{
> +	union acpi_object *out_obj, *obj;
> +	enum pfru_dsm_status status;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	handle = ACPI_HANDLE(pfru_log_dev->dev);
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_log_dev->uuid,
> +					  pfru_log_dev->info.log_revid, FUNC_GET_LEV,
> +					  NULL, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	obj = &out_obj->package.elements[0];
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	status = obj->integer.value;
> +	if (status)
> +		goto free_acpi_buffer;
> +
> +	obj = &out_obj->package.elements[1];
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	status = obj->integer.value;
> +	if (status)
> +		goto free_acpi_buffer;
> +
> +	obj = &out_obj->package.elements[2];
> +	if (obj->type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	*level = obj->integer.value;
> +	ret = 0;
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static int valid_log_level(int level)
> +{
> +	return level == LOG_ERR || level == LOG_WARN ||
> +		level == LOG_INFO || level == LOG_VERB;
> +}
> +
> +static int valid_log_type(int type)
> +{
> +	return type == LOG_EXEC_IDX || type == LOG_HISTORY_IDX;
> +}
> +
> +long pfru_log_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pfru_log_data_info data_info;
> +	struct pfru_log_info info;
> +	void __user *p;
> +	int ret = 0;
> +
> +	if (!pfru_log_dev)
> +		return -ENODEV;
> +
> +	p = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case PFRU_LOG_IOC_SET_INFO:
> +		if (copy_from_user(&info, p, sizeof(info)))
> +			return -EFAULT;
> +
> +		if (pfru_valid_revid(info.log_revid))
> +			pfru_log_dev->info.log_revid = info.log_revid;
> +
> +		if (valid_log_level(info.log_level)) {
> +			ret = set_pfru_log_level(info.log_level);
> +			if (ret)
> +				return ret;
> +			pfru_log_dev->info.log_level = info.log_level;
> +		}
> +
> +		if (valid_log_type(info.log_type))
> +			pfru_log_dev->info.log_type = info.log_type;
> +
> +		break;
> +	case PFRU_LOG_IOC_GET_INFO:
> +		ret = get_pfru_log_level(&info.log_level);
> +		if (ret)
> +			return ret;
> +
> +		info.log_type = pfru_log_dev->info.log_type;
> +		info.log_revid = pfru_log_dev->info.log_revid;
> +		if (copy_to_user(p, &info, sizeof(info)))
> +			ret = -EFAULT;
> +
> +		break;
> +	case PFRU_LOG_IOC_GET_DATA_INFO:
> +		ret = get_pfru_log_data_info(&data_info, pfru_log_dev->info.log_type);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &data_info, sizeof(struct pfru_log_data_info)))
> +			ret = -EFAULT;
> +
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +		break;
> +	}
> +	return ret;
> +}
> +
> +ssize_t pfru_log_read(struct file *filp, char __user *ubuf,
> +		      size_t size, loff_t *off)
> +{
> +	struct pfru_log_data_info info;
> +	phys_addr_t base_addr;
> +	int buf_size, ret;
> +	char *buf_ptr;
> +
> +	if (!pfru_log_dev)
> +		return -ENODEV;
> +
> +	if (*off < 0)
> +		return -EINVAL;
> +
> +	ret = get_pfru_log_data_info(&info, pfru_log_dev->info.log_type);
> +	if (ret)
> +		return ret;
> +
> +	base_addr = (phys_addr_t)(info.chunk2_addr_lo | (info.chunk2_addr_hi << 32));
> +	/* pfru update has not been launched yet.*/
> +	if (!base_addr)
> +		return -EBUSY;
> +
> +	buf_size = info.max_data_size;
> +	if (*off >= buf_size)
> +		return 0;
> +
> +	buf_ptr = memremap(base_addr, buf_size, MEMREMAP_WB);
> +	if (IS_ERR(buf_ptr))
> +		return PTR_ERR(buf_ptr);
> +
> +	size = min_t(size_t, size, buf_size - *off);
> +	if (copy_to_user(ubuf, buf_ptr + *off, size))
> +		ret = -EFAULT;
> +	else
> +		ret = 0;

As all you are doing is mapping some memory and reading from it, why do
you need a read() file operation at all?  Why not just use mmap?

thanks,

greg k-h
