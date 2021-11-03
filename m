Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4A44472B
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Nov 2021 18:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhKCRfF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 3 Nov 2021 13:35:05 -0400
Received: from mga14.intel.com ([192.55.52.115]:14859 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhKCRfE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 3 Nov 2021 13:35:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10157"; a="231805864"
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="231805864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:32:27 -0700
X-IronPort-AV: E=Sophos;i="5.87,206,1631602800"; 
   d="scan'208";a="667610236"
Received: from smile.fi.intel.com ([10.237.72.184])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2021 10:32:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1miK7O-003KJV-5N;
        Wed, 03 Nov 2021 19:32:10 +0200
Date:   Wed, 3 Nov 2021 19:32:09 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <YYLHmcQMR/XFOuVX@smile.fi.intel.com>
References: <cover.1635953446.git.yu.c.chen@intel.com>
 <01f8f7d23926dcdb054e5ac170ddcbbdb0aed560.1635953446.git.yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01f8f7d23926dcdb054e5ac170ddcbbdb0aed560.1635953446.git.yu.c.chen@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Nov 03, 2021 at 11:43:50PM +0800, Chen Yu wrote:
> Introduce the pfru_update driver which can be used for Platform Firmware
> Runtime code injection and driver update [1]. The user is expected to
> provide the update firmware in the form of capsule file, and pass it to
> the driver via ioctl. Then the driver would hand this capsule file to the
> Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> the low level Management Mode would do the firmware update.
> 
> The corresponding userspace tool and man page will be introduced at
> tools/power/acpi/pfru.

...

> +#define PFRU_UUID		"ECF9533B-4A3C-4E89-939E-C77112601C6D"
> +#define PFRU_CODE_INJ_UUID		"B2F84B79-7B6E-4E45-885F-3FB9BB185402"
> +#define PFRU_DRV_UPDATE_UUID		"4569DD8C-75F1-429A-A3D6-24DE8097A0DF"

What stops you to have these being binaries?
GUID_INIT() / EFI_GUID_INIT()

...

> +enum cap_index {
> +	CAP_STATUS_IDX = 0,
> +	CAP_UPDATE_IDX = 1,
> +	CAP_CODE_TYPE_IDX = 2,
> +	CAP_FW_VER_IDX = 3,
> +	CAP_CODE_RT_VER_IDX = 4,
> +	CAP_DRV_TYPE_IDX = 5,
> +	CAP_DRV_RT_VER_IDX = 6,
> +	CAP_DRV_SVN_IDX = 7,
> +	CAP_PLAT_ID_IDX = 8,
> +	CAP_OEM_ID_IDX = 9,
> +	CAP_OEM_INFO_IDX = 10,

> +	CAP_NR_IDX = 11

Assignment here doesn't make any sense (it just adds unneeded churn and
burden). Same to the rest of similar cases below.

> +};

...

> +struct pfru_device {
> +	guid_t uuid, code_uuid, drv_uuid;

You don't need these. At least for now.

> +	u32 rev_id, index;
> +	struct device *parent_dev;
> +	struct miscdevice miscdev;
> +};

...

> +	m_hdr = (struct efi_manage_capsule_header *)(data + size);

Do you need this casting?

...

> +	m_img_hdr = (struct efi_manage_capsule_image_header *)(data + size);

Ditto.

...

> +	auth = (struct efi_image_auth *)(data + size);

Ditto.

...

> +	ACPI_FREE(out_obj);

Recently with Hans we realised that this (ACPI_FREE() API) is mostly
for ACPICA use. We may use simple kfree(). Sorry for getting back and
forward.

...

> +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +	struct pfru_update_cap_info cap_hdr;
> +	struct pfru_device *pfru_dev = to_pfru_dev(file);
> +	void __user *p = (void __user *)arg;
> +	u32 rev;
> +	int ret;
> +
> +	switch (cmd) {
> +	case PFRU_IOC_QUERY_CAP:
> +		ret = query_capability(&cap_hdr, pfru_dev);
> +		if (ret)
> +			return ret;
> +
> +		if (copy_to_user(p, &cap_hdr, sizeof(cap_hdr)))

I'm wondering what will happen if p has less _real data_ than sizeof(cap_hdr)?

> +			return -EFAULT;
> +
> +		return 0;

> +	case PFRU_IOC_SET_REV:
> +		if (copy_from_user(&rev, p, sizeof(u32)))

sizeof(rev)

> +			return -EFAULT;
> +
> +		if (!pfru_valid_revid(rev))
> +			return -EINVAL;
> +
> +		pfru_dev->rev_id = rev;
> +
> +		return 0;
> +	case PFRU_IOC_STAGE:
> +		return start_acpi_update(START_STAGE, pfru_dev);
> +	case PFRU_IOC_ACTIVATE:
> +		return start_acpi_update(START_ACTIVATE, pfru_dev);
> +	case PFRU_IOC_STAGE_ACTIVATE:
> +		return start_acpi_update(START_STAGE_ACTIVATE, pfru_dev);
> +	default:
> +		return -ENOTTY;
> +	}
> +}

...

> +	/* map the communication buffer */
> +	phy_addr = (phys_addr_t)(buf_info.addr_lo | (buf_info.addr_hi << 32));

It's better to read if you start from MSB part to LSB.

...

> +	ret = ida_alloc(&pfru_ida, GFP_KERNEL);
> +	if (ret < 0)
> +		return ret;

(1)

...

> +	pfru_dev->miscdev.name = kasprintf(GFP_KERNEL,
> +					   "pfru%d", pfru_dev->index);

devm_kasprinf()

...

> +	pfru_dev->miscdev.nodename = kasprintf(GFP_KERNEL,
> +					       "acpi_pfru%d", pfru_dev->index);

Ditto.

Yep, I know about (1), but do your homework and see how you can satisfy both
comments.

...

> +static const struct acpi_device_id acpi_pfru_ids[] = {
> +	{"INTC1080", 0},

0 is redundant.

> +	{}
> +};

...

> +#include <linux/types.h>
> +#include <linux/ioctl.h>

Order?

...

> +#define PFRU_MAGIC 0xEE

Perhaps PFRU_MAGIC_FOR_IOCTL.

-- 
With Best Regards,
Andy Shevchenko


