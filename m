Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D18E44147E
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 08:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhKAH5O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 03:57:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:65128 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhKAH5B (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 03:57:01 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="230822113"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="230822113"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 00:54:25 -0700
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="499939057"
Received: from shiweiyu-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 00:54:21 -0700
Date:   Mon, 1 Nov 2021 15:54:17 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211101075417.GA14101@chenyu5-mobl1>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <a318e4edc13e5a3ff95b901871b8929746535715.1635317102.git.yu.c.chen@intel.com>
 <YXj+QaMcCeV71XbI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXj+QaMcCeV71XbI@kroah.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 09:22:41AM +0200, Greg Kroah-Hartman wrote:
> On Wed, Oct 27, 2021 at 03:07:51PM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update [1]. The user is expected to
> > provide the update firmware in the form of capsule file, and pass it to
> > the driver via ioctl. Then the driver would hand this capsule file to the
> > Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> > the low level Management Mode would do the firmware update.
> > 
> > The corresponding userspace tool and man page will be introduced at
> > tools/power/acpi/pfru.
> > 
> > Link: https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf # [1]
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
[snip...]
> > +struct pfru_device {
> > +	guid_t uuid, code_uuid, drv_uuid;
> > +	int rev_id, index;
> 
> shouldn't rev_id be a u32 as you are copying this to/from userspace?
> 
Ok, will do.
> > +	struct device *dev;
> 
> What device is this, the parent?  Child?  Sibling?  need a hint...
> 
It is the parent of the misc device, will add this hint.
> > +	struct miscdevice miscdev;
> > +};
> > +
> > +static DEFINE_IDA(pfru_ida);
> > +
> > +static inline struct pfru_device *to_pfru_dev(struct file *file)
> > +{
> > +	return container_of(file->private_data, struct pfru_device, miscdev);
> > +}
> > +
> > +
[snip...]
> > +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct pfru_update_cap_info cap;
> 
> You have a variable-length structure on the stack.  What ever could go
> wrong with that?
>
> {sigh}
> 
> How was this tested???
>
Ah, the risk of stack content overwrite. This symptom did not break out during
previous test because currently the code would not manipulate on this variable-length
array. I'll fix this in next version.
> > +	struct pfru_device *pfru_dev;
> > +	void __user *p;
> > +	int ret, rev;
> > +
> > +	pfru_dev = to_pfru_dev(file);
> > +	p = (void __user *)arg;
> > +
> > +	switch (cmd) {
> > +	case PFRU_IOC_QUERY_CAP:
> > +		ret = query_capability(&cap, pfru_dev);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (copy_to_user(p, &cap, sizeof(cap)))
> 
> But "sizeof" is not the real size of this structure, it's a variable
> length structure, right?
> 
> Again, how was this tested?
>
The variable length part was missing, and the userspace did not request
to retrieve that part for now, so the bug was not triggered. I'll fix it. 
> > +			return -EFAULT;
> > +
> > +		return 0;
> > +	case PFRU_IOC_SET_REV:
> > +		if (copy_from_user(&rev, p, sizeof(unsigned int)))
> 
> But this isn't an unsigned int, it's an "int" here.
> 
> So again, make this explicit, probably u32, right?
>
Ok, I'll change it to u32. 
> > +			return -EFAULT;
> > +
> > +		if (!pfru_valid_revid(rev))
> > +			return -EINVAL;
> > +
> > +		pfru_dev->rev_id = rev;
> 
> Why can't this just be a sysfs file?
> 
> Heck, why can't all of these be sysfs files, why do you need a char
> device at all?  Who is going to use this thing?
> 
>
The reason why char device mode was introduced is that, this use case needs
open/close/mmap/write and some extra actions(expose/adjust the parameters),
which fits well into the special device file model. And it brings low coupling
with other components.
It could be sysfs based, then the capsule file could be put in a fixed
path such as /lib/firmware/pfru, and load the capsule file from userspace
via request_firmware(). The firmware update will be triggered if user touches
/sys/firmware/acpi/pfru/start.
> > +
> > +		return 0;
> > +	case PFRU_IOC_STAGE:
> > +		return start_acpi_update(START_STAGE, pfru_dev);
> > +	case PFRU_IOC_ACTIVATE:
> > +		return start_acpi_update(START_ACTIVATE, pfru_dev);
> > +	case PFRU_IOC_STAGE_ACTIVATE:
> > +		return start_acpi_update(START_STAGE_ACTIVATE, pfru_dev);
> > +	default:
> > +		return -ENOTTY;
> > +	}
> > +}
> > +
> > +static int acpi_pfru_remove(struct platform_device *pdev)
> > +{
> > +	struct pfru_device *pfru_dev = platform_get_drvdata(pdev);
> > +
> > +	misc_deregister(&pfru_dev->miscdev);
> > +	ida_free(&pfru_ida, pfru_dev->index);
> > +
> > +	return 0;
> > +}
[snip]
> > +	.probe = acpi_pfru_probe,
> > +	.remove = acpi_pfru_remove,
> > +};
> > +module_platform_driver(acpi_pfru_driver);
> 
> Are you cleaning up your ida structure when the module is unloaded?
> 
The ida index is released in acpi_pfru_remove(), while the ida stricture is
a global variable, it should be cleared/invalid during module unload?
> > +
> > +MODULE_DESCRIPTION("Platform Firmware Runtime Update device driver");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/include/uapi/linux/pfru.h b/include/uapi/linux/pfru.h
> > new file mode 100644
> > index 000000000000..d6f57a75afd2
> > --- /dev/null
> > +++ b/include/uapi/linux/pfru.h
> > @@ -0,0 +1,186 @@
> > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > +/*
> > + * Platform Firmware Runtime Update header
> > + *
> > + * Copyright(c) 2021 Intel Corporation. All rights reserved.
> > + */
> > +
> > +/**
> > + * PFRU_IOC_SET_REV - _IOW(PFRU_MAGIC, 0x01, unsigned int)
> > + *
> > + * Return: 0 on success, -errno on failure
> > + *
> > + * Set the Revision ID for PFRU Runtime Update. It could be either 1 or 2.
> > + */
> > +#define PFRU_IOC_SET_REV _IOW(PFRU_MAGIC, 0x01, unsigned int)
> > +/**
> 
> Please use blank lines between these, it's hard to read.
> 
> 
Ok, will do.
> > + * PFRU_IOC_STAGE - _IOW(PFRU_MAGIC, 0x02, unsigned int)
> > + *
> > + * Return: 0 on success, -errno on failure
> 
> What -errno?
> 
> Same for all of these, be explicit please.
> 
Ok, will do.
> > + *
> > + * Stage a capsule image from communication buffer and perform authentication.
> > + */
> > +#define PFRU_IOC_STAGE _IOW(PFRU_MAGIC, 0x02, unsigned int)
> > +/**
> > + * PFRU_IOC_ACTIVATE - _IOW(PFRU_MAGIC, 0x03, unsigned int)
> > + *
> > + * Return: 0 on success, -errno on failure
> > + *
> > + * Activate a previous staged capsule image.
> > + */
> > +#define PFRU_IOC_ACTIVATE _IOW(PFRU_MAGIC, 0x03, unsigned int)
> > +/**
> > + * PFRU_IOC_STAGE_ACTIVATE - _IOW(PFRU_MAGIC, 0x04, unsigned int)
> > + *
> > + * Return: 0 on success, -errno on failure
> > + *
> > + * Perform both stage and activation actions.
> > + */
> > +#define PFRU_IOC_STAGE_ACTIVATE _IOW(PFRU_MAGIC, 0x04, unsigned int)
> > +/**
> > + * PFRU_IOC_QUERY_CAP - _IOR(PFRU_MAGIC, 0x05,
> > + *			     struct pfru_update_cap_info)
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + *
> > + * Retrieve information about the PFRU Runtime Update capability.
> > + * The information is a struct pfru_update_cap_info.
> > + */
> > +#define PFRU_IOC_QUERY_CAP _IOR(PFRU_MAGIC, 0x05, struct pfru_update_cap_info)
> > +
> > +static inline int pfru_valid_revid(int id)
> > +{
> > +	return id == REVID_1 || id == REVID_2;
> 
> Why is this in a uapi file?  You just poluted the global namespace of
> all userspace programs with this function :(
> 
I'll remove this function in uapi header.
> > +}
> > +
> > +/**
> > + * struct pfru_payload_hdr - Capsule file payload header.
> > + *
> > + * @sig: Signature of this capsule file.
> > + * @hdr_version: Revision of this header structure.
> > + * @hdr_size: Size of this header, including the OemHeader bytes.
> > + * @hw_ver: The supported firmware version.
> > + * @rt_ver: Version of the code injection image.
> > + * @platform_id: A platform specific GUID to specify the platform what
> > + *               this capsule image support.
> > + */
> > +struct pfru_payload_hdr {
> > +	__u32 sig;
> > +	__u32 hdr_version;
> > +	__u32 hdr_size;
> > +	__u32 hw_ver;
> > +	__u32 rt_ver;
> > +	__u8 platform_id[UUID_SIZE];
> > +};
> > +
> > +enum pfru_start_action {
> > +	START_STAGE,
> > +	START_ACTIVATE,
> > +	START_STAGE_ACTIVATE,
> > +};
> > +
> > +enum pfru_dsm_status {
> > +	DSM_SUCCEED,
> > +	DSM_FUNC_NOT_SUPPORT,
> > +	DSM_INVAL_INPUT,
> > +	DSM_HARDWARE_ERR,
> > +	DSM_RETRY_SUGGESTED,
> > +	DSM_UNKNOWN,
> > +	DSM_FUNC_SPEC_ERR,
> 
> Do you need to be explicit about the numbers here?  I never remember if
> this is guaranteed by all C compilers or not...
>
Ok, will set them explicitly. 
> > +};
> > +
> > +/**
> > + * struct pfru_update_cap_info - Runtime update capability information.
> > + *
> > + * @status: Indicator of whether this query succeed.
> > + * @update_cap: Bitmap to indicate whether the feature is supported.
> > + * @code_type: A buffer containing an image type GUID.
> > + * @fw_version: Platform firmware version.
> > + * @code_rt_version: Code injection runtime version for anti-rollback.
> > + * @drv_type: A buffer containing an image type GUID.
> > + * @drv_rt_version: The version of the driver update runtime code.
> > + * @drv_svn: The secure version number(SVN) of the driver update runtime code.
> > + * @platform_id: A buffer containing a platform ID GUID.
> > + * @oem_id: A buffer containing an OEM ID GUID.
> > + * @oem_info: A buffer containing the vendor specific information.
> > + */
> > +struct pfru_update_cap_info {
> > +	__u32 status;
> > +	__u32 update_cap;
> > +
> > +	__u8 code_type[UUID_SIZE];
> 
> Don't we have a uuid structure that crosses the user/kernel boundry?
>
If guid_t is used then the header linux/uuid.h is needed in kernel space,
while uuid/uuid.h is needed in the userspace. Then the include part in uAPI
header becomes:
#ifdef __KERNEL__
#include <linux/uuid.h>
#else
#include <uuid/uuid.h>
#endif
which looks more complicated than using the raw buffer.
> > +	__u32 fw_version;
> > +	__u32 code_rt_version;
> > +
> > +	__u8 drv_type[UUID_SIZE];
> > +	__u32 drv_rt_version;
> > +	__u32 drv_svn;
> > +
> > +	__u8 platform_id[UUID_SIZE];
> > +	__u8 oem_id[UUID_SIZE];
> > +
> > +	char oem_info[];
> 
> As mentioned above, this is variable length, right?  Where are you
> copying this extra data and how big do you know it is going to be?
>
Ah, right, will fix it in next version.

Thanks,
Chenyu 
