Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1754040A62D
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Sep 2021 07:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239873AbhINFuV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 14 Sep 2021 01:50:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:30591 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239813AbhINFuS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 14 Sep 2021 01:50:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="307440953"
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="307440953"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 22:49:00 -0700
X-IronPort-AV: E=Sophos;i="5.85,291,1624345200"; 
   d="scan'208";a="543692500"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.176])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 22:48:54 -0700
Date:   Tue, 14 Sep 2021 13:54:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Alexander Graf <graf@amazon.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andra Paraschiv <andraprs@amazon.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/5][RFC] drivers/acpi: Introduce Platform Firmware
 Runtime Update device driver
Message-ID: <20210914055447.GA78108@chenyu-desktop>
References: <cover.1631025237.git.yu.c.chen@intel.com>
 <9b2bd7d1e40633ce6f4845fb5c9e30a3faad5e7a.1631025237.git.yu.c.chen@intel.com>
 <YTh8mPOVv8T1Yhgy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTh8mPOVv8T1Yhgy@kernel.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Thank you very much and sorry for late response, Mike,
On Wed, Sep 08, 2021 at 12:04:24PM +0300, Mike Rapoport wrote:
> Hi,
> 
> On Tue, Sep 07, 2021 at 11:27:42PM +0800, Chen Yu wrote:
> > Introduce the pfru_update driver which can be used for Platform Firmware
> > Runtime code injection and driver update. The user is expected to provide
> > the update firmware in the form of capsule file, and pass it to the driver
> > via ioctl. Then the driver would hand this capsule file to the Platform
> > Firmware Runtime Update via the ACPI device _DSM method. At last the low
> > level Management Mode would do the firmware update.
> > 
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  .../userspace-api/ioctl/ioctl-number.rst      |   1 +
> >  drivers/acpi/Kconfig                          |   1 +
> >  drivers/acpi/Makefile                         |   1 +
> >  drivers/acpi/pfru/Kconfig                     |  15 +
> >  drivers/acpi/pfru/Makefile                    |   2 +
> >  drivers/acpi/pfru/pfru_update.c               | 544 ++++++++++++++++++
> >  include/uapi/linux/pfru.h                     | 106 ++++
> >  7 files changed, 670 insertions(+)
[cut]
> > +struct pfru_device {
> > +	guid_t uuid;
> > +	int rev_id;
> > +	struct device *dev;
> > +};
> > +
> > +static struct pfru_device pfru_dev;
> 
> Please don't presume a single instance and update the driver to work with
> allocated pfru_device objects.
> 
Okay, this global variable has been switched to a dynamic allocated pointer.
Since there would be only one instance of this ACPI device, more than one
instance would indicate a bogus BIOS. The duplication check logic was added
during driver initialization that, if more than than one instance was detected,
only the first instance would take effect.
> > +static struct pfru_device *get_pfru_dev(void)
> > +{
> > +	return &pfru_dev;
> > +}
> > +
[cut]
> > +	for (i = 0; i < out_obj->package.count; i++) {
> > +		union acpi_object *obj = &out_obj->package.elements[i];
> > +
> > +		switch (i) {
> > +		case 0:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->status = obj->integer.value;
> > +			break;
> > +		case 1:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->update_cap = obj->integer.value;
> > +			break;
> > +		case 2:
> > +			if (obj->type != ACPI_TYPE_BUFFER)
> > +				goto free_acpi_buffer;
> > +			memcpy(&cap->code_type, obj->buffer.pointer,
> > +			       obj->buffer.length);
> > +			break;
> > +		case 3:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->fw_version = obj->integer.value;
> > +			break;
> > +		case 4:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->code_rt_version = obj->integer.value;
> > +			break;
> > +		case 5:
> > +			if (obj->type != ACPI_TYPE_BUFFER)
> > +				goto free_acpi_buffer;
> > +			memcpy(&cap->drv_type, obj->buffer.pointer,
> > +			       obj->buffer.length);
> > +			break;
> > +		case 6:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->drv_rt_version = obj->integer.value;
> > +			break;
> > +		case 7:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			cap->drv_svn = obj->integer.value;
> > +			break;
> > +		case 8:
> > +			if (obj->type != ACPI_TYPE_BUFFER)
> > +				goto free_acpi_buffer;
> > +			memcpy(&cap->platform_id, obj->buffer.pointer,
> > +			       obj->buffer.length);
> > +			break;
> > +		case 9:
> > +			if (obj->type != ACPI_TYPE_BUFFER)
> > +				goto free_acpi_buffer;
> > +			memcpy(&cap->oem_id, obj->buffer.pointer,
> > +			       obj->buffer.length);
> > +			break;
> 
> Please get rid of the magic numbers and add a default clause with the error
> handling. Nothing guaranties that there will be exactly 10 fields in the
> out_obj.
> 
Okay, got it, changed in next version.
> Also, the obj->type checks could move outside the switch, with an if or a
> static mapping between the field number and the desired type.
> 
> 
Okay, changed in next version.
> > +		}
> > +	}
[cut]
> > +		case 4:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			info->buf_size = obj->integer.value;
> > +			break;
> 
> The same comments as for query_capability() functions apply here as well.
> 
Okay.
> > +		}
> > +	}
> > +	ret = 0;
> > +
> > +free_acpi_buffer:
> > +	ACPI_FREE(out_obj);
> > +
> > +	return ret;
> > +}
> > +
> > +static int get_image_type(efi_manage_capsule_image_header_t *img_hdr,
> > +			  int *type)
> > +{
> > +	int ret;
> > +	guid_t code_inj_id, drv_update_id, *image_type_id;
> > +
> > +	ret = guid_parse(PFRU_CODE_INJ_UUID, &code_inj_id);
> > +	if (ret)
> > +		return ret;
> > +	ret = guid_parse(PFRU_DRV_UPDATE_UUID, &drv_update_id);
> > +	if (ret)
> > +		return ret;
> 
> The code_inj_id and drv_update_id are "constant", they can be parsed once
> at driver initialization time. 
> 
Okay, changed in next version.
> > +	/* check whether this is a code injection or driver update */
> > +	image_type_id = &img_hdr->image_type_id;
> > +	if (guid_equal(image_type_id, &code_inj_id))
> > +		*type = CODE_INJECT_TYPE;
> > +	else if (guid_equal(image_type_id, &drv_update_id))
> > +		*type = DRIVER_UPDATE_TYPE;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/*
> > + * The (u64 hw_ins) was introduced in UEFI spec version 2,
> > + * and (u64 capsule_support) was introduced in version 3.
> > + * The size needs to be adjusted accordingly.
> 
> The comment here does not really explain how exactly the size needs to be
> adjusted.
> 
The comment has been refined in next version.
> > +
[cut]
> > +static void parse_update_result(struct updated_result *result)
> 
> I think dump_update_result() would be more appropriate.
> 
Okay, changed accordingly.
> > +{
> > +	pr_debug("Update result:\n");
> > +	pr_debug("Status:%d\n", result->status);
> > +	pr_debug("Extended Status:%d\n", result->ext_status);
> > +	pr_debug("Authentication Time Low:%ld\n", result->low_auth_time);
> > +	pr_debug("Authentication Time High:%ld\n", result->high_auth_time);
> > +	pr_debug("Execution Time Low:%ld\n", result->low_exec_time);
> > +	pr_debug("Execution Time High:%ld\n", result->high_exec_time);
> > +}
> > +
> > +		case 5:
> > +			if (obj->type != ACPI_TYPE_INTEGER)
> > +				goto free_acpi_buffer;
> > +			update_result.high_exec_time = obj->integer.value;
> > +			break;
> > +		}
> 
> The same comments as for query_capability() functions apply here as well.
>
Okay, changed in next version. 
> > +	}
> > +	parse_update_result(&update_result);
> > +	ret = 0;
> > +
> > +free_acpi_buffer:
> > +	ACPI_FREE(out_obj);
> > +
> > +	return ret;
> > +}
> > +
[cut]
> > +	case PFRU_IOC_STAGE_ACTIVATE:
> > +		ret = start_acpi_update(START_STAGE_ACTIVATE);
> > +		if (ret)
> > +			return ret;
> 
> These 
> 	if (ret)
> 		return ret;
> 
> seem redundant here.
> 
I see. Changed accordingly.
> > +		break;
> > +	default:
> > +		ret = -ENOIOCTLCMD;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +
[cut]
> > +struct com_buf_info {
> > +	enum dsm_status status;
> > +	enum dsm_status ext_status;
> > +	unsigned long addr_lo;
> > +	unsigned long addr_hi;
> > +	int buf_size;
> > +};
> > +
> > +struct capsulate_buf_info {
> > +	unsigned long src;
> > +	int size;
> > +};
> > +
> > +struct updated_result {
> > +	enum dsm_status status;
> > +	enum dsm_status ext_status;
> > +	unsigned long low_auth_time;
> > +	unsigned long high_auth_time;
> > +	unsigned long low_exec_time;
> > +	unsigned long high_exec_time;
> > +};
> 
> Are all these types need to be visible to userspace?
> If not, please move the driver internal types to pfru_update.c.
> 
The struct capsulate_buf_info is only usable in kernel space, so it
is moved into pfru_update.c in next version. While the other structures
are required by the userspace for customization.

thanks,
Chenyu
