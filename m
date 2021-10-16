Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE82430337
	for <lists+linux-acpi@lfdr.de>; Sat, 16 Oct 2021 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbhJPPSc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 16 Oct 2021 11:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237124AbhJPPSc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 16 Oct 2021 11:18:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D12161163;
        Sat, 16 Oct 2021 15:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634397383;
        bh=3YS8teLW08n2EUwaTSIS2sOOmbcA2kAK/cVlgSgcqCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUuQefnsQ+emdqvG2GKvUzserFrQpbYXo4H1lTMUeOPo6OZJpSCMMUIQckVBZcGFA
         uTUXtDs+gHYuSTQKPWLnelVJV/64pgPB9mx1yAtt1YWl/uHuq94TaAW1Dcsg716mzt
         x0aMBBgi3tTkLeR27ZTQTE0EDLe/6yvk+q+uAlxg=
Date:   Sat, 16 Oct 2021 17:16:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YWrswQ+ETMthZZVk@kroah.com>
References: <cover.1634310710.git.yu.c.chen@intel.com>
 <eadc25933400c71a52e7d176880df09a147a39b9.1634310710.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eadc25933400c71a52e7d176880df09a147a39b9.1634310710.git.yu.c.chen@intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Oct 16, 2021 at 06:40:51PM +0800, Chen Yu wrote:
> Introduce the pfru_update driver which can be used for Platform Firmware
> Runtime code injection and driver update[1]. The user is expected to
> provide the update firmware in the form of capsule file, and pass it to
> the driver via ioctl. Then the driver would hand this capsule file to the
> Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> the low level Management Mode would do the firmware update.
> 
> [1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
> 
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> v4: Add Documentation/ABI/testing/pfru (Rafael J. Wysocki)
>     Change all pr_debug() to dev_dbg() (Greg Kroah-Hartman,
>     Rafael J. Wysocki)
>     Change the error code ENOIOCTLCMD to ENOTTY in ioctl.
>     (Greg Kroah-Hartman)
>     Remove compat ioctl. (Greg Kroah-Hartman)
>     Change /dev/pfru/update to /dev/acpi_pfru (Greg Kroah-Hartman)
>     Remove valid_cap_type() and do sanity check in query_capability().
>     (Rafael J. Wysocki)
>     Remove the loop in query_capability().
>     (Rafael J. Wysocki)
>     Do not fail if the package has more elements than expected,
>     and return error if the number of package elements is too
>     small. (Rafael J. Wysocki)
>     Return the type or a negative error code in get_image_type()
>     (Rafael J. Wysocki)
>     Put the comment inside the function rather than outside.
>     (Rafael J. Wysocki)
>     Return the size or a negative error code adjust_efi_size()
>     (Rafael J. Wysocki)
>     Return -EINVAL rather than -EFAULT if revison id is incorrect.
>     (Rafael J. Wysocki)
>     Move the an read() of pfru into ioctl(), and using read() for
>     the telemetry retrieval. So as to avoid the telemetry device
>     file, the write() will be the code injection/update, the read()
>     will be telemetry retrieval and all of the rest can be ioctl()s
>     under one special device file.
>     (Rafael J. Wysocki)
> v3: Use __u32 instead of int and __64 instead of unsigned long
>     in include/uapi/linux/pfru.h (Greg Kroah-Hartman)
>     Rename the structure in uapi to start with a prefix pfru so as
>     to avoid confusing in the global namespace. (Greg Kroah-Hartman)
> v2: Add sanity check for duplicated instance of ACPI device.
>     Update the driver to work with allocated pfru_device objects.
>     (Mike Rapoport)
>     For each switch case pair, get rid of the magic case numbers
>     and add a default clause with the error handling.
>     (Mike Rapoport)
>     Move the obj->type checks outside the switch to reduce redundancy.
>     (Mike Rapoport)
>     Parse the code_inj_id and drv_update_id at driver initialization time
>     to reduce the re-parsing at runtime.(Mike Rapoport)
>     Explain in detail how the size needs to be adjusted when doing
>     version check.(Mike Rapoport)
>     Rename parse_update_result() to dump_update_result()(Mike Rapoport)
>     Remove redundant return.(Mike Rapoport)
>     Do not expose struct capsulate_buf_info to uapi, since it is
>     not needed in userspace.(Mike Rapoport)
> ---
>  Documentation/ABI/testing/pfru                |  41 ++
>  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
>  drivers/acpi/Kconfig                          |   1 +
>  drivers/acpi/Makefile                         |   1 +
>  drivers/acpi/pfru/Kconfig                     |  16 +
>  drivers/acpi/pfru/Makefile                    |   2 +
>  drivers/acpi/pfru/pfru_update.c               | 567 ++++++++++++++++++
>  include/uapi/linux/pfru.h                     | 102 ++++
>  8 files changed, 731 insertions(+)
>  create mode 100644 Documentation/ABI/testing/pfru
>  create mode 100644 drivers/acpi/pfru/Kconfig
>  create mode 100644 drivers/acpi/pfru/Makefile
>  create mode 100644 drivers/acpi/pfru/pfru_update.c
>  create mode 100644 include/uapi/linux/pfru.h
> 
> diff --git a/Documentation/ABI/testing/pfru b/Documentation/ABI/testing/pfru
> new file mode 100644
> index 000000000000..b8bc81703f46
> --- /dev/null
> +++ b/Documentation/ABI/testing/pfru
> @@ -0,0 +1,41 @@
> +What:		/dev/acpi_pfru
> +Date:		October 2021
> +KernelVersion:	5.15
> +Contact:	Chen Yu <yu.c.chen@intel.com>
> +Description:
> +		The ioctl interface to drivers for platform firmware runtime
> +		update(PFRU). Following actions are supported:
> +
> +		* PFRU_IOC_QUERY_CAP: Read the PFRU Runtime Update capability.
> +		  The value is a structure of pfru_update_cap_info.
> +		  See include/uapi/linux/pfru.h for definition.
> +
> +		* PFRU_SET_REV: Set the Revision ID for PFRU Runtime Update.
> +		  It could be either 1 or 2.
> +
> +		* PFRU_IOC_STAGE: Stage a capsule image from communication
> +		  buffer and perform authentication.
> +
> +		* PFRU_IOC_ACTIVATE: Activate a previous staged capsule image.
> +
> +		* PFRU_IOC_STAGE_ACTIVATE: Perform both stage and activation
> +		  actions.
> +
> +		* PFRU_LOG_IOC_SET_INFO: set log information in Telemetry
> +		  Service. The input is a structure of pfru_log_info.
> +		  This structure includes log revision id(1 or 2),
> +		  log level(0 : Error Message, 1 : Warning Message,
> +		  2 : Informational Message, 4 : Verbose), log data type
> +		  (0 : Execution Log, 1 : History Information).
> +		  See include/uapi/linux/pfru.h for definition.
> +
> +		* PFRU_LOG_IOC_GET_INFO: get log information in Telemetry.
> +		  The output is a structure of pfru_log_info.
> +
> +		* PFRU_LOG_IOC_GET_DATA_INFO: get log data information in
> +		  Telemetry. The output is a structure of pfru_log_data_info.
> +		  See include/uapi/linux/pfru.h for definition.
> +
> +		Besides ioctl interface, write() and read() are supported on
> +		/dev/acpi_pfru. The write() will be the code injection/update,
> +		and the read() will be telemetry retrieval.

Do we normally describe ioctl interfaces in Documentation/ABI/?  Why not
just add this to the kernel doc with the structures you are creating?
Wouldn't that be easier?

Or are other acpi ioctl interfaces documented here already?

> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 2e8134059c87..6e5a82fff408 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -365,6 +365,7 @@ Code  Seq#    Include File                                           Comments
>                                                                       <mailto:aherrman@de.ibm.com>
>  0xE5  00-3F  linux/fuse.h
>  0xEC  00-01  drivers/platform/chrome/cros_ec_dev.h                   ChromeOS EC driver
> +0xEE  00-1F  uapi/linux/pfru.h                                       Platform Firmware Runtime Update and Telemetry

You are not using all of those values, right?

>  0xF3  00-3F  drivers/usb/misc/sisusbvga/sisusb.h                     sisfb (in development)
>                                                                       <mailto:thomas@winischhofer.net>
>  0xF6  all                                                            LTTng Linux Trace Toolkit Next Generation
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1da360c51d66..1d8d2e2cefac 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -482,6 +482,7 @@ source "drivers/acpi/nfit/Kconfig"
>  source "drivers/acpi/numa/Kconfig"
>  source "drivers/acpi/apei/Kconfig"
>  source "drivers/acpi/dptf/Kconfig"
> +source "drivers/acpi/pfru/Kconfig"
>  
>  config ACPI_WATCHDOG
>  	bool
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 3018714e87d9..9c2c5ddff6ec 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -102,6 +102,7 @@ obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc_acpi.o
>  obj-$(CONFIG_ACPI_SPCR_TABLE)	+= spcr.o
>  obj-$(CONFIG_ACPI_DEBUGGER_USER) += acpi_dbg.o
>  obj-$(CONFIG_ACPI_PPTT) 	+= pptt.o
> +obj-$(CONFIG_ACPI_PFRU)		+= pfru/
>  
>  # processor has its own "processor." module_param namespace
>  processor-y			:= processor_driver.o
> diff --git a/drivers/acpi/pfru/Kconfig b/drivers/acpi/pfru/Kconfig
> new file mode 100644
> index 000000000000..87388a46e760
> --- /dev/null
> +++ b/drivers/acpi/pfru/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +config ACPI_PFRU
> +	tristate "ACPI Platform Firmware Runtime Update (PFRU)"
> +	depends on 64BIT
> +	help
> +	  In order to reduce the system reboot times and update the platform firmware
> +	  in time, Platform Firmware Runtime Update is leveraged to patch the system
> +	  without reboot. This driver supports Platform Firmware Runtime Update,
> +	  which is composed of two parts: code injection and driver update. It also
> +	  allows telemetry data to be retrieved from the platform firmware.
> +
> +	  For more information, see:
> +	  <file:Documentation/ABI/testing/pfru>
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called pfru_update.
> diff --git a/drivers/acpi/pfru/Makefile b/drivers/acpi/pfru/Makefile
> new file mode 100644
> index 000000000000..098cbe80cf3d
> --- /dev/null
> +++ b/drivers/acpi/pfru/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_ACPI_PFRU) += pfru_update.o
> diff --git a/drivers/acpi/pfru/pfru_update.c b/drivers/acpi/pfru/pfru_update.c
> new file mode 100644
> index 000000000000..f57a39e79808
> --- /dev/null
> +++ b/drivers/acpi/pfru/pfru_update.c
> @@ -0,0 +1,567 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ACPI Platform Firmware Runtime Update Device Driver
> + *
> + * Copyright (C) 2021 Intel Corporation
> + * Author: Chen Yu <yu.c.chen@intel.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/efi.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/uaccess.h>
> +#include <linux/uio.h>
> +#include <linux/uuid.h>
> +#include <uapi/linux/pfru.h>
> +
> +enum cap_index {
> +	CAP_STATUS_IDX,
> +	CAP_UPDATE_IDX,
> +	CAP_CODE_TYPE_IDX,
> +	CAP_FW_VER_IDX,
> +	CAP_CODE_RT_VER_IDX,
> +	CAP_DRV_TYPE_IDX,
> +	CAP_DRV_RT_VER_IDX,
> +	CAP_DRV_SVN_IDX,
> +	CAP_PLAT_ID_IDX,
> +	CAP_OEM_ID_IDX,
> +	CAP_OEM_INFO_IDX,
> +	CAP_NR_IDX,
> +};
> +
> +enum buf_index {
> +	BUF_STATUS_IDX,
> +	BUF_EXT_STATUS_IDX,
> +	BUF_ADDR_LOW_IDX,
> +	BUF_ADDR_HI_IDX,
> +	BUF_SIZE_IDX,
> +	BUF_NR_IDX,
> +};
> +
> +enum update_index {
> +	UPDATE_STATUS_IDX,
> +	UPDATE_EXT_STATUS_IDX,
> +	UPDATE_AUTH_TIME_LOW_IDX,
> +	UPDATE_AUTH_TIME_HI_IDX,
> +	UPDATE_EXEC_TIME_LOW_IDX,
> +	UPDATE_EXEC_TIME_HI_IDX,
> +	UPDATE_NR_IDX,
> +};
> +
> +struct pfru_device {
> +	guid_t uuid, code_uuid, drv_uuid;
> +	int rev_id;
> +	struct device *dev;
> +};
> +
> +static struct pfru_device *pfru_dev;

Why is this a single variable?  Shouldn't this be per-device as the bus
provides it to you?

> +
> +static int query_capability(struct pfru_update_cap_info *cap)
> +{
> +	union acpi_object *out_obj;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	handle = ACPI_HANDLE(pfru_dev->dev);
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +					  pfru_dev->rev_id,
> +					  FUNC_QUERY_UPDATE_CAP,
> +					  NULL, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return ret;
> +
> +	if (out_obj->package.count < CAP_NR_IDX)
> +		goto free_acpi_buffer;
> +
> +	if (out_obj->package.elements[CAP_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->status = out_obj->package.elements[CAP_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_UPDATE_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->update_cap = out_obj->package.elements[CAP_UPDATE_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_CODE_TYPE_IDX].type != ACPI_TYPE_BUFFER)
> +		goto free_acpi_buffer;
> +
> +	memcpy(&cap->code_type,
> +	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.pointer,
> +	       out_obj->package.elements[CAP_CODE_TYPE_IDX].buffer.length);
> +
> +	if (out_obj->package.elements[CAP_FW_VER_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->fw_version =
> +		out_obj->package.elements[CAP_FW_VER_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_CODE_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->code_rt_version =
> +		out_obj->package.elements[CAP_CODE_RT_VER_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_DRV_TYPE_IDX].type != ACPI_TYPE_BUFFER)
> +		goto free_acpi_buffer;
> +
> +	memcpy(&cap->drv_type,
> +	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.pointer,
> +	       out_obj->package.elements[CAP_DRV_TYPE_IDX].buffer.length);
> +
> +	if (out_obj->package.elements[CAP_DRV_RT_VER_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->drv_rt_version =
> +		out_obj->package.elements[CAP_DRV_RT_VER_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_DRV_SVN_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	cap->drv_svn =
> +		out_obj->package.elements[CAP_DRV_SVN_IDX].integer.value;
> +
> +	if (out_obj->package.elements[CAP_PLAT_ID_IDX].type != ACPI_TYPE_BUFFER)
> +		goto free_acpi_buffer;
> +
> +	memcpy(&cap->platform_id,
> +	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.pointer,
> +	       out_obj->package.elements[CAP_PLAT_ID_IDX].buffer.length);
> +
> +	if (out_obj->package.elements[CAP_OEM_ID_IDX].type != ACPI_TYPE_BUFFER)
> +		goto free_acpi_buffer;
> +
> +	memcpy(&cap->oem_id,
> +	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.pointer,
> +	       out_obj->package.elements[CAP_OEM_ID_IDX].buffer.length);
> +	ret = 0;
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static int query_buffer(struct pfru_com_buf_info *info)
> +{
> +	union acpi_object *out_obj;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	handle = ACPI_HANDLE(pfru_dev->dev);
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +					  pfru_dev->rev_id, FUNC_QUERY_BUF,
> +					  NULL, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return ret;
> +
> +	if (out_obj->package.count < BUF_NR_IDX)
> +		goto free_acpi_buffer;
> +
> +	if (out_obj->package.elements[BUF_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	info->status = out_obj->package.elements[BUF_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[BUF_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	info->ext_status =
> +		out_obj->package.elements[BUF_EXT_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[BUF_ADDR_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	info->addr_lo =
> +		out_obj->package.elements[BUF_ADDR_LOW_IDX].integer.value;
> +
> +	if (out_obj->package.elements[BUF_ADDR_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	info->addr_hi =
> +		out_obj->package.elements[BUF_ADDR_HI_IDX].integer.value;
> +
> +	if (out_obj->package.elements[BUF_SIZE_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	info->buf_size = out_obj->package.elements[BUF_SIZE_IDX].integer.value;
> +
> +	ret = 0;
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static int get_image_type(efi_manage_capsule_image_header_t *img_hdr)
> +{
> +	guid_t *image_type_id = &img_hdr->image_type_id;
> +
> +	/* check whether this is a code injection or driver update */
> +	if (guid_equal(image_type_id, &pfru_dev->code_uuid))
> +		return CODE_INJECT_TYPE;
> +	else if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
> +		return DRIVER_UPDATE_TYPE;
> +	else
> +		return -EINVAL;
> +}
> +
> +static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
> +			   int size)
> +{
> +	/*
> +	 * The (u64 hw_ins) was introduced in UEFI spec version 2,
> +	 * and (u64 capsule_support) was introduced in version 3.
> +	 * The size needs to be adjusted accordingly. That is to
> +	 * say, version 1 should subtract the size of hw_ins+capsule_support,
> +	 * and version 2 should sbstract the size of capsule_support.
> +	 */
> +	size += sizeof(efi_manage_capsule_image_header_t);
> +	switch (img_hdr->ver) {
> +	case 1:
> +		size -= 2 * sizeof(u64);
> +		break;
> +	case 2:
> +		size -= sizeof(u64);
> +		break;
> +	default:
> +		/* only support version 1 and 2 */
> +		return -EINVAL;
> +	}
> +
> +	return size;
> +}
> +
> +static bool valid_version(const void *data, struct pfru_update_cap_info *cap)
> +{
> +	struct pfru_payload_hdr *payload_hdr;
> +	efi_capsule_header_t *cap_hdr;
> +	efi_manage_capsule_header_t *m_hdr;
> +	efi_manage_capsule_image_header_t *m_img_hdr;
> +	efi_image_auth_t *auth;
> +	int type, size;
> +
> +	/*
> +	 * Sanity check if the capsule image has a newer version
> +	 * than current one.
> +	 */
> +	cap_hdr = (efi_capsule_header_t *)data;
> +	size = cap_hdr->headersize;
> +	m_hdr = (efi_manage_capsule_header_t *)(data + size);
> +	/*
> +	 * Current data structure size plus variable array indicated
> +	 * by number of (emb_drv_cnt + payload_cnt)
> +	 */
> +	size += sizeof(efi_manage_capsule_header_t) +
> +		      (m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
> +	m_img_hdr = (efi_manage_capsule_image_header_t *)(data + size);
> +
> +	type = get_image_type(m_img_hdr);
> +	if (type < 0)
> +		return false;
> +
> +	size = adjust_efi_size(m_img_hdr, size);
> +	if (size < 0)
> +		return false;
> +
> +	auth = (efi_image_auth_t *)(data + size);
> +	size += sizeof(u64) + auth->auth_info.hdr.len;
> +	payload_hdr = (struct pfru_payload_hdr *)(data + size);
> +
> +	/* Finally, compare the version. */
> +	if (type == CODE_INJECT_TYPE)
> +		return payload_hdr->rt_ver >= cap->code_rt_version;
> +	else
> +		return payload_hdr->rt_ver >= cap->drv_rt_version;
> +}
> +
> +static void dump_update_result(struct pfru_updated_result *result)
> +{
> +	dev_dbg(pfru_dev->dev, "Update result:\n");
> +	dev_dbg(pfru_dev->dev, "Status:%d\n", result->status);
> +	dev_dbg(pfru_dev->dev, "Extended Status:%d\n", result->ext_status);
> +	dev_dbg(pfru_dev->dev, "Authentication Time Low:%lld\n",
> +		result->low_auth_time);
> +	dev_dbg(pfru_dev->dev, "Authentication Time High:%lld\n",
> +		result->high_auth_time);
> +	dev_dbg(pfru_dev->dev, "Execution Time Low:%lld\n",
> +		result->low_exec_time);
> +	dev_dbg(pfru_dev->dev, "Execution Time High:%lld\n",
> +		result->high_exec_time);
> +}
> +
> +static int start_acpi_update(int action)
> +{
> +	union acpi_object *out_obj, in_obj, in_buf;
> +	struct pfru_updated_result update_result;
> +	acpi_handle handle;
> +	int ret = -EINVAL;
> +
> +	memset(&in_obj, 0, sizeof(in_obj));
> +	memset(&in_buf, 0, sizeof(in_buf));
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = 1;
> +	in_obj.package.elements = &in_buf;
> +	in_buf.type = ACPI_TYPE_INTEGER;
> +	in_buf.integer.value = action;
> +
> +	handle = ACPI_HANDLE(pfru_dev->dev);
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pfru_dev->uuid,
> +					  pfru_dev->rev_id, FUNC_START,
> +					  &in_obj, ACPI_TYPE_PACKAGE);
> +	if (!out_obj)
> +		return ret;
> +
> +	if (out_obj->package.count < UPDATE_NR_IDX)
> +		goto free_acpi_buffer;
> +
> +	if (out_obj->package.elements[UPDATE_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.status =
> +		out_obj->package.elements[UPDATE_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[UPDATE_EXT_STATUS_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.ext_status =
> +		out_obj->package.elements[UPDATE_EXT_STATUS_IDX].integer.value;
> +
> +	if (out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.low_auth_time =
> +		out_obj->package.elements[UPDATE_AUTH_TIME_LOW_IDX].integer.value;
> +
> +	if (out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.high_auth_time =
> +		out_obj->package.elements[UPDATE_AUTH_TIME_HI_IDX].integer.value;
> +
> +	if (out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.low_exec_time =
> +		out_obj->package.elements[UPDATE_EXEC_TIME_LOW_IDX].integer.value;
> +
> +	if (out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].type != ACPI_TYPE_INTEGER)
> +		goto free_acpi_buffer;
> +
> +	update_result.high_exec_time =
> +		out_obj->package.elements[UPDATE_EXEC_TIME_HI_IDX].integer.value;
> +
> +	dump_update_result(&update_result);
> +	ret = 0;
> +
> +free_acpi_buffer:
> +	ACPI_FREE(out_obj);
> +
> +	return ret;
> +}
> +
> +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pfru_update_cap_info cap;
> +	void __user *p;
> +	int ret = 0, rev;
> +
> +	if (!pfru_dev)
> +		return -ENODEV;
> +
> +	p = (void __user *)arg;
> +
> +	switch (cmd) {
> +	case PFRU_IOC_QUERY_CAP:
> +		ret = query_capability(&cap);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &cap, sizeof(cap)))
> +			return -EFAULT;
> +
> +		break;
> +	case PFRU_IOC_SET_REV:
> +		if (copy_from_user(&rev, p, sizeof(unsigned int)))
> +			return -EFAULT;
> +
> +		if (!pfru_valid_revid(rev))
> +			return -EINVAL;
> +
> +		pfru_dev->rev_id = rev;
> +		break;
> +	case PFRU_IOC_STAGE:
> +		ret = start_acpi_update(START_STAGE);
> +		break;
> +	case PFRU_IOC_ACTIVATE:
> +		ret = start_acpi_update(START_ACTIVATE);
> +		break;
> +	case PFRU_IOC_STAGE_ACTIVATE:
> +		ret = start_acpi_update(START_STAGE_ACTIVATE);
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static ssize_t pfru_write(struct file *file, const char __user *buf,
> +			  size_t len, loff_t *ppos)
> +{
> +	struct pfru_update_cap_info cap;
> +	struct pfru_com_buf_info info;
> +	phys_addr_t phy_addr;
> +	struct iov_iter iter;
> +	struct iovec iov;
> +	char *buf_ptr;
> +	int ret;
> +
> +	if (!pfru_dev)
> +		return -ENODEV;
> +
> +	ret = query_buffer(&info);
> +	if (ret)
> +		return ret;
> +
> +	if (len > info.buf_size)
> +		return -EINVAL;
> +
> +	iov.iov_base = (void __user *)buf;
> +	iov.iov_len = len;
> +	iov_iter_init(&iter, WRITE, &iov, 1, len);
> +
> +	/* map the communication buffer */
> +	phy_addr = (phys_addr_t)(info.addr_lo | (info.addr_hi << 32));
> +	buf_ptr = memremap(phy_addr, info.buf_size, MEMREMAP_WB);
> +	if (IS_ERR(buf_ptr))
> +		return PTR_ERR(buf_ptr);
> +
> +	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
> +		ret = -EINVAL;
> +		goto unmap;
> +	}
> +
> +	/* Check if the capsule header has a valid version number. */
> +	ret = query_capability(&cap);
> +	if (ret)
> +		goto unmap;
> +
> +	if (cap.status != DSM_SUCCEED)
> +		ret = -EBUSY;
> +	else if (!valid_version(buf_ptr, &cap))
> +		ret = -EINVAL;
> +unmap:
> +	memunmap(buf_ptr);
> +
> +	return ret ?: len;
> +}
> +
> +static const struct file_operations acpi_pfru_fops = {
> +	.owner		= THIS_MODULE,
> +	.write		= pfru_write,
> +	.unlocked_ioctl = pfru_ioctl,
> +	.llseek		= noop_llseek,
> +};
> +
> +static struct miscdevice pfru_misc_dev = {
> +	.minor = MISC_DYNAMIC_MINOR,
> +	.name = "pfru",
> +	.nodename = "acpi_pfru",
> +	.fops = &acpi_pfru_fops,
> +};
> +
> +static int acpi_pfru_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

You do not free any of your memory???

> +
> +static int acpi_pfru_probe(struct platform_device *pdev)
> +{
> +	acpi_handle handle;
> +	int ret;
> +
> +	/* Only one instance is allowed. */
> +	if (pfru_dev)
> +		return 0;

Why is only one instance allowed?  Why add extra work to do this when it
really is not needed at all?  It is simpler and less code to make it so
that there is no restriction like this at all.

Also, the return value is incorrect, so your implementaion of trying to
keep only one instance does not work properly :(

> +	pfru_dev = kzalloc(sizeof(*pfru_dev), GFP_KERNEL);
> +	if (!pfru_dev)
> +		return -ENOMEM;
> +
> +	ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
> +	if (ret)
> +		goto out;
> +
> +	ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
> +	if (ret)
> +		goto out;
> +
> +	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
> +	if (ret)
> +		goto out;
> +
> +	/* default rev id is 1 */
> +	pfru_dev->rev_id = 1;
> +	pfru_dev->dev = &pdev->dev;
> +	handle = ACPI_HANDLE(pfru_dev->dev);
> +	if (!acpi_has_method(handle, "_DSM")) {
> +		dev_dbg(&pdev->dev, "Missing _DSM\n");
> +		ret = -ENODEV;
> +		goto out;
> +	}
> +
> +	return 0;
> +out:
> +	kfree(pfru_dev);
> +	pfru_dev = NULL;
> +
> +	return ret;
> +}
> +
> +static const struct acpi_device_id acpi_pfru_ids[] = {
> +	{"INTC1080", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_pfru_ids);
> +
> +static struct platform_driver acpi_pfru_driver = {
> +	.driver = {
> +		.name = "pfru_update",
> +		.acpi_match_table = acpi_pfru_ids,
> +	},
> +	.probe = acpi_pfru_probe,
> +	.remove = acpi_pfru_remove,
> +};
> +
> +static int __init pfru_init(void)
> +{
> +	int ret;
> +
> +	ret = misc_register(&pfru_misc_dev);
> +	if (ret)
> +		return ret;
> +

Why register this here, BEFORE you have a real device?  That looks like
a big race condition here :(

Register it per device you have in the system please.

thanks,

greg k-h
