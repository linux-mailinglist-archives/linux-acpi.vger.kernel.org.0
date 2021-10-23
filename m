Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A924383BE
	for <lists+linux-acpi@lfdr.de>; Sat, 23 Oct 2021 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhJWNSV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 23 Oct 2021 09:18:21 -0400
Received: from mga02.intel.com ([134.134.136.20]:24063 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229699AbhJWNSU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sat, 23 Oct 2021 09:18:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10145"; a="216615872"
X-IronPort-AV: E=Sophos;i="5.87,175,1631602800"; 
   d="scan'208";a="216615872"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 06:16:01 -0700
X-IronPort-AV: E=Sophos;i="5.87,175,1631602800"; 
   d="scan'208";a="485037247"
Received: from yli135-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.249.169.195])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2021 06:15:58 -0700
Date:   Sat, 23 Oct 2021 21:15:55 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211023131555.GA28269@chenyu5-mobl1>
References: <cover.1634899519.git.yu.c.chen@intel.com>
 <545536e714c32c905fd3614bf4fec65d11fb6541.1634899519.git.yu.c.chen@intel.com>
 <YXMZoz5vfwsawN49@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXMZoz5vfwsawN49@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Andy,
On Fri, Oct 22, 2021 at 11:05:55PM +0300, Andy Shevchenko wrote:
> On Sat, Oct 23, 2021 at 01:09:51AM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update[1]. The user is expected to
> > provide the update firmware in the form of capsule file, and pass it to
> > the driver via ioctl. Then the driver would hand this capsule file to the
> > Platform Firmware Runtime Update via the ACPI device _DSM method. At last
> > the low level Management Mode would do the firmware update.
> > 
> > The corresponding userspace tool and man page will be introduced at
> > tools/power/acpi/pfru.
> > 
> > [1] https://uefi.org/sites/default/files/resources/Intel_MM_OS_Interface_Spec_Rev100.pdf
> 
> Instead use Link: tag ?
>
Yes, will fix it. 
> > +enum cap_index {
> > +	CAP_STATUS_IDX,
> > +	CAP_UPDATE_IDX,
> > +	CAP_CODE_TYPE_IDX,
> > +	CAP_FW_VER_IDX,
> > +	CAP_CODE_RT_VER_IDX,
> > +	CAP_DRV_TYPE_IDX,
> > +	CAP_DRV_RT_VER_IDX,
> > +	CAP_DRV_SVN_IDX,
> > +	CAP_PLAT_ID_IDX,
> > +	CAP_OEM_ID_IDX,
> > +	CAP_OEM_INFO_IDX,
> 
> > +	CAP_NR_IDX,
> 
> Is it terminator entry? Drop comma then. Same for all other similar cases.
> 
Ok, will remove the comma.
> > +};
> 
> ...
> 
> > +static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
> > +			  struct pfru_device *pfru_dev)
> > +{
> > +	guid_t *image_type_id = &img_hdr->image_type_id;
> > +
> > +	/* check whether this is a code injection or driver update */
> > +	if (guid_equal(image_type_id, &pfru_dev->code_uuid))
> > +		return CODE_INJECT_TYPE;
> 
> > +	else if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
> > +		return DRIVER_UPDATE_TYPE;
> > +	else
> > +		return -EINVAL;
> 
> In both cases redundant 'else'.
> 
Ok.
> > +}
> 
> ...
> 
> > +static int adjust_efi_size(efi_manage_capsule_image_header_t *img_hdr,
> > +			   int size)
> > +{
> > +	/*
> > +	 * The (u64 hw_ins) was introduced in UEFI spec version 2,
> > +	 * and (u64 capsule_support) was introduced in version 3.
> > +	 * The size needs to be adjusted accordingly. That is to
> > +	 * say, version 1 should subtract the size of hw_ins+capsule_support,
> > +	 * and version 2 should sbstract the size of capsule_support.
> > +	 */
> > +	size += sizeof(efi_manage_capsule_image_header_t);
> > +	switch (img_hdr->ver) {
> > +	case 1:
> > +		size -= 2 * sizeof(u64);
> > +		break;
> > +	case 2:
> > +		size -= sizeof(u64);
> > +		break;
> > +	default:
> > +		/* only support version 1 and 2 */
> > +		return -EINVAL;
> > +	}
> 
> > +	return size;
> 
> Perhaps directly return this from the cases?
> 
Ok, will do.
> > +}
> 
> ...
> 
> > +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct pfru_update_cap_info cap;
> > +	struct pfru_device *pfru_dev;
> > +	void __user *p;
> 
> > +	int ret = 0, rev;
> 
> return 0;  (see below)?
> 
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
> > +			return -EFAULT;
> > +
> > +		break;
> > +	case PFRU_IOC_SET_REV:
> > +		if (copy_from_user(&rev, p, sizeof(unsigned int)))
> > +			return -EFAULT;
> > +
> > +		if (!pfru_valid_revid(rev))
> > +			return -EINVAL;
> > +
> > +		pfru_dev->rev_id = rev;
> > +		break;
> > +	case PFRU_IOC_STAGE:
> > +		ret = start_acpi_update(START_STAGE, pfru_dev);
> > +		break;
> > +	case PFRU_IOC_ACTIVATE:
> > +		ret = start_acpi_update(START_ACTIVATE, pfru_dev);
> > +		break;
> > +	case PFRU_IOC_STAGE_ACTIVATE:
> > +		ret = start_acpi_update(START_STAGE_ACTIVATE, pfru_dev);
> > +		break;
> > +	default:
> > +		ret = -ENOTTY;
> > +		break;
> > +	}
> 
> > +	return ret;
> 
> You may return 0 here and directly return from the cases above.
> 
I think we can remove the 'return ret' completely, by returning from the cases above.
> > +}
> 
> ...
> 
> > +	/* map the communication buffer */
> 
> Comment style inconsistency. Compare to...
> 
> > +	/* Check if the capsule header has a valid version number. */
> 
> ...this one. However, here, since it's one line, no period is needed.
> 
>
Ok, will fix it. 
> ...
> 
> > +out:
> > +	devm_kfree(&pdev->dev, pfru_dev);
> 
> What is this? WHy?!
> 
The devm resource is expected to be released during driver de-attach. 
devm_kfree() is used to free the resource explicitly at the earliest
time. But it is ok to remove the devm_kfree() and leverage the devm
to deal with it.
> > +}
> 
> ...
> 
> 
> > +static int __init pfru_init(void)
> > +{
> > +	return platform_driver_register(&acpi_pfru_driver);
> > +}
> > +
> > +static void __exit pfru_exit(void)
> > +{
> > +	platform_driver_unregister(&acpi_pfru_driver);
> > +}
> > +
> > +module_init(pfru_init);
> > +module_exit(pfru_exit);
> 
> NIH module_platform_driver().
>
There would be more than one platform driver to be loaded in this
file, so module_platform_driver() might not work here. 
> ...
> 
> > +#include <linux/uuid.h>
> 
> This is wrong. Please, use raw buffers.
> 
Ok, will remove this.
> ...
> 
> Missed types.h.
> 
Ok, will add it.
> ...
> 
> > +struct pfru_payload_hdr {
> > +	__u32	sig;
> > +	__u32	hdr_version;
> > +	__u32	hdr_size;
> > +	__u32	hw_ver;
> > +	__u32	rt_ver;
> 
> > +	uuid_t	platform_id;
> 
> No way. Use __u8[16].
> uuid_t is internal type for kernel.
> 
Ok, will change it.
> > +};
> 
> ...
> 
> > +struct pfru_update_cap_info {
> > +	enum pfru_dsm_status status;
> > +	__u32 update_cap;
> > +
> > +	uuid_t code_type;
> 
> Ditto.
> 
> > +	__u32 fw_version;
> > +	__u32 code_rt_version;
> 
> > +	uuid_t drv_type;
> 
> Ditto.
> 
> > +	__u32 drv_rt_version;
> > +	__u32 drv_svn;
> 
> > +	uuid_t platform_id;
> > +	uuid_t oem_id;
> 
> Ditto.
> 
> > +	char oem_info[];
> > +};
> 
> ...
> 
> > +struct pfru_updated_result {
> 
> > +	enum pfru_dsm_status status;
> > +	enum pfru_dsm_status ext_status;
> 
> What?! Are you sure enum is the same size on all possible architectures?
> 
Ok, changed then to __u32 in next version.

thanks,
Chenyu
