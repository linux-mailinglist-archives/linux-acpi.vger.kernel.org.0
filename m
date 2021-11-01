Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA566441814
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Nov 2021 10:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhKAJnB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 05:43:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:37760 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233875AbhKAJkj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 1 Nov 2021 05:40:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10154"; a="230836116"
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="230836116"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 02:33:28 -0700
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="499970131"
Received: from shiweiyu-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.221])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2021 02:33:24 -0700
Date:   Mon, 1 Nov 2021 17:33:20 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Aubrey Li <aubrey.li@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/4] drivers/acpi: Introduce Platform Firmware Runtime
 Update device driver
Message-ID: <20211101093320.GA18982@chenyu5-mobl1>
References: <cover.1635317102.git.yu.c.chen@intel.com>
 <a318e4edc13e5a3ff95b901871b8929746535715.1635317102.git.yu.c.chen@intel.com>
 <YXkn8aBvAVEXxgdp@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXkn8aBvAVEXxgdp@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Oct 27, 2021 at 01:20:33PM +0300, Andy Shevchenko wrote:
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
> 
> ...
> 
> > +static int get_image_type(struct efi_manage_capsule_image_header *img_hdr,
> > +			  struct pfru_device *pfru_dev)
> > +{
> > +	guid_t *image_type_id = &img_hdr->image_type_id;
> 
> efi_guid_t ?
>
efi_guid_t is a 32-bit aligned guid_t, which is for the case when
efi_guid_t* arguments are 32-bit aligned. And it is for 32-bit ARM.
Since this code injection is only for 64-bit, the guid is not required
to be strictly 32-bit aligned I suppose?
> > +	/* check whether this is a code injection or driver update */
> > +	if (guid_equal(image_type_id, &pfru_dev->code_uuid))
> > +		return CODE_INJECT_TYPE;
> > +
> > +	if (guid_equal(image_type_id, &pfru_dev->drv_uuid))
> > +		return DRIVER_UPDATE_TYPE;
> > +
> > +	return -EINVAL;
> > +}
> 
> ...
> 
> > +static bool valid_version(const void *data, struct pfru_update_cap_info *cap,
> > +			  struct pfru_device *pfru_dev)
> > +{
> > +	struct pfru_payload_hdr *payload_hdr;
> > +	efi_capsule_header_t *cap_hdr;
> > +	struct efi_manage_capsule_header *m_hdr;
> > +	struct efi_manage_capsule_image_header *m_img_hdr;
> > +	struct efi_image_auth *auth;
> > +	int type, size;
> > +
> > +	/*
> > +	 * Sanity check if the capsule image has a newer version
> > +	 * than current one.
> > +	 */
> > +	cap_hdr = (efi_capsule_header_t *)data;
> 
> Why casting?
> 
Will remove this in next version.
> > +	size = cap_hdr->headersize;
> > +	m_hdr = (struct efi_manage_capsule_header *)(data + size);
> > +	/*
> > +	 * Current data structure size plus variable array indicated
> > +	 * by number of (emb_drv_cnt + payload_cnt)
> > +	 */
> > +	size += sizeof(struct efi_manage_capsule_header) +
> > +		      (m_hdr->emb_drv_cnt + m_hdr->payload_cnt) * sizeof(u64);
> > +	m_img_hdr = (struct efi_manage_capsule_image_header *)(data + size);
> > +
> > +	type = get_image_type(m_img_hdr, pfru_dev);
> > +	if (type < 0)
> > +		return false;
> > +
> > +	size = adjust_efi_size(m_img_hdr, size);
> > +	if (size < 0)
> > +		return false;
> > +
> > +	auth = (struct efi_image_auth *)(data + size);
> > +	size += sizeof(u64) + auth->auth_info.hdr.len;
> > +	payload_hdr = (struct pfru_payload_hdr *)(data + size);
> > +
> > +	/* finally compare the version */
> > +	if (type == CODE_INJECT_TYPE)
> > +		return payload_hdr->rt_ver >= cap->code_rt_version;
> > +	else
> > +		return payload_hdr->rt_ver >= cap->drv_rt_version;
> > +}
> 
> ...
> 
> > +static long pfru_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> > +{
> > +	struct pfru_update_cap_info cap;
> > +	struct pfru_device *pfru_dev;
> > +	void __user *p;
> > +	int ret, rev;
> 
> > +	pfru_dev = to_pfru_dev(file);
> > +	p = (void __user *)arg;
> 
> Can be combined with definitions above. Ditto for the rest cases in the code.
>
Ok, will do. 
> > +}
> 
> ...
> 
> > +	phy_addr = (phys_addr_t)(info.addr_lo | (info.addr_hi << 32));
> 
> Does it compile without warnings for 32-bit target?
> 
> ...
>
The code injection depends on Kconfig 64-bit and is not supposed to work
on 32-bit AFAIK. 
> > +	ret = guid_parse(PFRU_UUID, &pfru_dev->uuid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = guid_parse(PFRU_CODE_INJ_UUID, &pfru_dev->code_uuid);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &pfru_dev->drv_uuid);
> > +	if (ret)
> > +		return ret;
> 
> Why do you need to keep zillions of copies of the data which seems
> is not going to be changed? Three global variables should be enough,
> no?
>
The guid information is embedded in each pfru_dev and only calculated
once during probe. I thought people try to avoid using global variables
if possible?
> > +	ret = ida_alloc(&pfru_ida, GFP_KERNEL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	pfru_dev->index = ret;
> 
> ...
> 
> > +	/* default rev id is 1 */
> 
> Shouldn't you rather define this magic and drop this doubtful comment?
> 
Ok, will do.
> > +	pfru_dev->rev_id = 1;
> 
> ...
> 
> > +failed:
> 
> Make you labeling consistent. The usual pattern is to explain what will be
> happened when goto to the certain label, for example, here is 'err_free_ida'.
> Also, add an empty line everywhere before labels.
> 
Ok, got it, will do.
> > +	ida_free(&pfru_ida, pfru_dev->index);
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +#define UUID_SIZE 16
> 
> It must not be here at all.
> Or it should be properly namespaced.
> 
Ok. Would __u8 uuid[16] applicable? There are some examples in uapi headers.

thanks,
Chenyu
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
