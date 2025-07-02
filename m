Return-Path: <linux-acpi+bounces-14935-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E211DAF1615
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 14:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7A716B572
	for <lists+linux-acpi@lfdr.de>; Wed,  2 Jul 2025 12:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486672750F1;
	Wed,  2 Jul 2025 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CAV7bxes"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269DB274FEF;
	Wed,  2 Jul 2025 12:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751460638; cv=none; b=ECHOFW9cgyyDp9FrZqxM86GKRXWXEUAP3QmvjkE74eliczFUDyxIvsUQPoApiOGjneuPAKo56zxyKuz+vz4JAeLg9Opn+87/woFpiT+yXjfquyNlSookmzcxeaRUrTDWGrIQPl4f5ID0Ak6UzoZlMnWhBwqdZzUzx25djKodeVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751460638; c=relaxed/simple;
	bh=k/4MLllN69R+xjMZxq8j8APH8ytlW29jw6oqQSxzlYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhAnt1xQ2qJ8RknYuaMf2ocuA4uSMxrCs9VLURXeS8zc0BgTBljQX0EBq6rfNgvLBdpZUwOqRzvrVTD0FIkRKH1l32Xht/o9zdhNPXbYVDv9Lawix11K1ogXEEAY3CDHvcNg9e4rfFnZdWsSXY02zBXSdCCxISwliwSqHxRMpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CAV7bxes; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751460636; x=1782996636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k/4MLllN69R+xjMZxq8j8APH8ytlW29jw6oqQSxzlYA=;
  b=CAV7bxeszNFk4dSmoCITdCBJleMaMFj+gNZuNiVBubNmOBNMShRroIxa
   L67diduI3RZMEl9OU/yeiAMAXz+ENH6ID6r5MBN65TcFJ+nxh4nk644Xg
   Yzg5beuAuhtJBLlA809t7l7NXVMmfdErjvwhHSWe40NHi2Hwui9UNcAcd
   ynsmVZJ/qSAPZLCUEr/AlhgZe6lTbhA8wIrE/338MMZV8ArmQbqbZI2f+
   lShp5fVD/pP+pjpq2yFZCHgaJ5jJzOjINAg4ybr4s+lK2T5wCXYk8HPf3
   TcmoePIJ485mnoln3A1BTSpcj4CbpOCswE8dQbttSvVplAZ9HnSzvmbZi
   A==;
X-CSE-ConnectionGUID: 8yOgQikqSZ67Wri0OxGa1g==
X-CSE-MsgGUID: ovRrlOwXTzq0iy0+ywTCqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57560420"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57560420"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:50:35 -0700
X-CSE-ConnectionGUID: 2SXMN1wlSqaPTHE7KCqoTQ==
X-CSE-MsgGUID: PT5eXKRhSI68wWiVyTInkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153519699"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 05:50:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWwut-0000000BvBY-3cPP;
	Wed, 02 Jul 2025 15:50:23 +0300
Date: Wed, 2 Jul 2025 15:50:23 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Rahul Pathak <rpathak@ventanamicro.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 07/24] mailbox: Add RISC-V SBI message proxy (MPXY)
 based mailbox driver
Message-ID: <aGUrD2Ht1idIlDCd@smile.fi.intel.com>
References: <20250702051345.1460497-1-apatel@ventanamicro.com>
 <20250702051345.1460497-8-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702051345.1460497-8-apatel@ventanamicro.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 10:43:28AM +0530, Anup Patel wrote:
> Add a mailbox controller driver for the new SBI message proxy extension
> which is part of the SBI v3.0 specification.

...

> +#include <linux/cpu.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/mailbox/riscv-rpmi-message.h>

+ minmax.h

> +#include <linux/mm.h>
> +#include <linux/module.h>
> +#include <linux/msi.h>
> +#include <linux/of_irq.h>
> +#include <linux/percpu.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <asm/byteorder.h>
> +#include <asm/sbi.h>

...

> +static void mpxy_mbox_send_rpmi_data(struct mpxy_mbox_channel *mchan,
> +				     struct rpmi_mbox_message *msg)
> +{
> +	int rc = 0;

Is it useful? I mean can you assign msg.error directly in each case?
(Just asking)

> +	switch (msg->type) {
> +	case RPMI_MBOX_MSG_TYPE_GET_ATTRIBUTE:
> +		switch (msg->attr.id) {
> +		case RPMI_MBOX_ATTR_SPEC_VERSION:
> +			msg->attr.value = mchan->attrs.msg_proto_version;
> +			break;
> +		case RPMI_MBOX_ATTR_MAX_MSG_DATA_SIZE:
> +			msg->attr.value = mchan->max_xfer_len;
> +			break;
> +		case RPMI_MBOX_ATTR_SERVICEGROUP_ID:
> +			msg->attr.value = mchan->rpmi_attrs.servicegroup_id;
> +			break;
> +		case RPMI_MBOX_ATTR_SERVICEGROUP_VERSION:
> +			msg->attr.value = mchan->rpmi_attrs.servicegroup_version;
> +			break;
> +		case RPMI_MBOX_ATTR_IMPL_ID:
> +			msg->attr.value = mchan->rpmi_attrs.impl_id;
> +			break;
> +		case RPMI_MBOX_ATTR_IMPL_VERSION:
> +			msg->attr.value = mchan->rpmi_attrs.impl_version;
> +			break;
> +		default:
> +			rc = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	case RPMI_MBOX_MSG_TYPE_SET_ATTRIBUTE:
> +		/* None of the RPMI linux mailbox attributes are writeable */
> +		rc = -EOPNOTSUPP;
> +		break;
> +	case RPMI_MBOX_MSG_TYPE_SEND_WITH_RESPONSE:
> +		if ((!msg->data.request && msg->data.request_len) ||
> +		    (msg->data.request &&
> +		     msg->data.request_len > mchan->max_xfer_len) ||
> +		    (!msg->data.response && msg->data.max_response_len)) {
> +			rc = -EINVAL;
> +			break;
> +		}
> +		if (!(mchan->attrs.capability & SBI_MPXY_CHAN_CAP_SEND_WITH_RESP)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		rc = mpxy_send_message_with_resp(mchan->channel_id,
> +						 msg->data.service_id,
> +						 msg->data.request,
> +						 msg->data.request_len,
> +						 msg->data.response,
> +						 msg->data.max_response_len,
> +						 &msg->data.out_response_len);
> +		break;
> +	case RPMI_MBOX_MSG_TYPE_SEND_WITHOUT_RESPONSE:
> +		if ((!msg->data.request && msg->data.request_len) ||
> +		    (msg->data.request &&
> +		     msg->data.request_len > mchan->max_xfer_len)) {
> +			rc = -EINVAL;
> +			break;
> +		}
> +		if (!(mchan->attrs.capability & SBI_MPXY_CHAN_CAP_SEND_WITHOUT_RESP)) {
> +			rc = -EIO;
> +			break;
> +		}
> +		rc = mpxy_send_message_without_resp(mchan->channel_id,
> +						    msg->data.service_id,
> +						    msg->data.request,
> +						    msg->data.request_len);
> +		break;
> +	default:
> +		rc = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	msg->error = rc;
> +}

...

> +static void mpxy_mbox_peek_rpmi_data(struct mbox_chan *chan,
> +				     struct mpxy_mbox_channel *mchan,
> +				     struct sbi_mpxy_notification_data *notif,
> +				     unsigned long events_data_len)
> +{
> +	struct rpmi_notification_event *event;
> +	unsigned long pos = 0, event_size;
> +	struct rpmi_mbox_message msg;
> +
> +	while ((pos < events_data_len) && !(pos & 0x3) &&

0x3 looks like a magic used for the non-aligned data.

> +	       ((events_data_len - pos) <= sizeof(*event))) {
> +		event = (struct rpmi_notification_event *)(notif->events_data + pos);
> +
> +		msg.type = RPMI_MBOX_MSG_TYPE_NOTIFICATION_EVENT;
> +		msg.notif.event_datalen = le16_to_cpu(event->event_datalen);
> +		msg.notif.event_id = event->event_id;
> +		msg.notif.event_data = event->event_data;
> +		msg.error = 0;
> +
> +		event_size = sizeof(*event) + msg.notif.event_datalen;

Do you trust the source? This may wrap-around...

> +		if (event_size > (events_data_len - pos)) {
> +			event_size = events_data_len - pos;
> +			goto skip_event;
> +		}
> +		if (event_size & 0x3)
> +			goto skip_event;

...and these checks be skipped. Is it a problem?

> +		mbox_chan_received_data(chan, &msg);

> +skip_event:

I think this may be replaced by a continue inside if you make a loop to be
do {} while (). But it's just a thought, you can check if it gives a better
readability after all.

> +		pos += event_size;
> +	}
> +}

...

> +static int mpxy_mbox_probe(struct platform_device *pdev)
> +{
> +	u32 i, *channel_ids __free(kfree) = NULL;

It's not recommended. Can you split channel_ids to the actual scope where it's
used? Somewhere...

> +	struct device *dev = &pdev->dev;
> +	struct mpxy_mbox_channel *mchan;
> +	struct mpxy_mbox *mbox;
> +	int msi_idx, rc;
> +
> +	/*
> +	 * Initialize MPXY shared memory only once. This also ensures
> +	 * that SBI MPXY mailbox is probed only once.
> +	 */
> +	if (mpxy_shmem_init_done) {
> +		dev_err(dev, "SBI MPXY mailbox already initialized\n");
> +		return -EALREADY;
> +	}
> +
> +	/* Probe for SBI MPXY extension */
> +	if (sbi_spec_version < sbi_mk_version(1, 0) ||
> +	    sbi_probe_extension(SBI_EXT_MPXY) <= 0) {
> +		dev_info(dev, "SBI MPXY extension not available\n");
> +		return -ENODEV;
> +	}
> +
> +	/* Find-out shared memory size */
> +	rc = mpxy_get_shmem_size(&mpxy_shmem_size);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get MPXY shared memory size\n");
> +
> +	/*
> +	 * Setup MPXY shared memory on each CPU
> +	 *
> +	 * Note: Don't cleanup MPXY shared memory upon CPU power-down
> +	 * because the RPMI System MSI irqchip driver needs it to be
> +	 * available when migrating IRQs in CPU power-down path.
> +	 */
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "riscv/sbi-mpxy-shmem",
> +			  mpxy_setup_shmem, NULL);
> +
> +	/* Mark as MPXY shared memory initialization done */
> +	mpxy_shmem_init_done = true;
> +
> +	/* Allocate mailbox instance */
> +	mbox = devm_kzalloc(dev, sizeof(*mbox), GFP_KERNEL);
> +	if (!mbox)
> +		return -ENOMEM;
> +	mbox->dev = dev;
> +	platform_set_drvdata(pdev, mbox);
> +
> +	/* Find-out of number of channels */
> +	rc = mpxy_get_channel_count(&mbox->channel_count);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get number of MPXY channels\n");
> +	if (!mbox->channel_count)
> +		dev_err_probe(dev, -ENODEV, "no MPXY channels available\n");
> +
> +	/* Allocate and fetch all channel IDs */
> +	channel_ids = kcalloc(mbox->channel_count, sizeof(*channel_ids), GFP_KERNEL);

...here.

> +	if (!channel_ids)
> +		return -ENOMEM;
> +	rc = mpxy_get_channel_ids(mbox->channel_count, channel_ids);
> +	if (rc)
> +		return dev_err_probe(dev, rc, "failed to get MPXY channel IDs\n");
> +
> +	/* Populate all channels */
> +	mbox->channels = devm_kcalloc(dev, mbox->channel_count,
> +				      sizeof(*mbox->channels), GFP_KERNEL);
> +	if (!mbox->channels)
> +		return -ENOMEM;
> +	for (i = 0; i < mbox->channel_count; i++) {
> +		mchan = &mbox->channels[i];
> +		mchan->mbox = mbox;
> +		mchan->channel_id = channel_ids[i];
> +
> +		rc = mpxy_read_attrs(mchan->channel_id, SBI_MPXY_ATTR_MSG_PROT_ID,
> +				     sizeof(mchan->attrs) / sizeof(u32),
> +				     (u32 *)&mchan->attrs);
> +		if (rc) {
> +			return dev_err_probe(dev, rc,
> +					     "MPXY channel 0x%x read attrs failed\n",
> +					     mchan->channel_id);
> +		}
> +
> +		if (mchan->attrs.msg_proto_id == SBI_MPXY_MSGPROTO_RPMI_ID) {
> +			rc = mpxy_mbox_read_rpmi_attrs(mchan);
> +			if (rc) {
> +				return dev_err_probe(dev, rc,
> +						     "MPXY channel 0x%x read RPMI attrs failed\n",
> +						     mchan->channel_id);
> +			}
> +		}
> +
> +		mchan->notif = devm_kzalloc(dev, mpxy_shmem_size, GFP_KERNEL);
> +		if (!mchan->notif)
> +			return -ENOMEM;
> +
> +		mchan->max_xfer_len = min(mpxy_shmem_size, mchan->attrs.msg_max_len);
> +
> +		if ((mchan->attrs.capability & SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS) &&
> +		    (mchan->attrs.capability & SBI_MPXY_CHAN_CAP_EVENTS_STATE))
> +			mchan->have_events_state = true;
> +
> +		if ((mchan->attrs.capability & SBI_MPXY_CHAN_CAP_GET_NOTIFICATIONS) &&
> +		    (mchan->attrs.capability & SBI_MPXY_CHAN_CAP_MSI))
> +			mchan->msi_index = mbox->msi_count++;
> +		else
> +			mchan->msi_index = U32_MAX;
> +		mchan->msi_irq = U32_MAX;
> +	}
> +
> +	/* Initialize mailbox controller */
> +	mbox->controller.txdone_irq = false;
> +	mbox->controller.txdone_poll = false;
> +	mbox->controller.ops = &mpxy_mbox_ops;
> +	mbox->controller.dev = dev;
> +	mbox->controller.num_chans = mbox->channel_count;
> +	mbox->controller.fw_xlate = mpxy_mbox_fw_xlate;
> +	mbox->controller.chans = devm_kcalloc(dev, mbox->channel_count,
> +					      sizeof(*mbox->controller.chans),
> +					      GFP_KERNEL);
> +	if (!mbox->controller.chans)
> +		return -ENOMEM;
> +	for (i = 0; i < mbox->channel_count; i++)
> +		mbox->controller.chans[i].con_priv = &mbox->channels[i];
> +
> +	/* Set the MSI domain if not available */
> +	if (!dev_get_msi_domain(dev)) {
> +		/*
> +		 * The device MSI domain for OF devices is only set at the
> +		 * time of populating/creating OF device. If the device MSI
> +		 * domain is discovered later after the OF device is created
> +		 * then we need to set it explicitly before using any platform
> +		 * MSI functions.
> +		 */

> +		if (dev_of_node(dev))

Do you really need this check? What about ACPI?

> +			of_msi_configure(dev, dev_of_node(dev));
> +	}
> +
> +	/* Setup MSIs for mailbox (if required) */
> +	if (mbox->msi_count) {
> +		mbox->msi_index_to_channel = devm_kcalloc(dev, mbox->msi_count,
> +							  sizeof(*mbox->msi_index_to_channel),
> +							  GFP_KERNEL);
> +		if (!mbox->msi_index_to_channel)
> +			return -ENOMEM;
> +
> +		for (msi_idx = 0; msi_idx < mbox->msi_count; msi_idx++) {
> +			for (i = 0; i < mbox->channel_count; i++) {
> +				mchan = &mbox->channels[i];
> +				if (mchan->msi_index == msi_idx) {
> +					mbox->msi_index_to_channel[msi_idx] = mchan;
> +					break;
> +				}
> +			}
> +		}
> +
> +		rc = platform_device_msi_init_and_alloc_irqs(dev, mbox->msi_count,
> +							     mpxy_mbox_msi_write);
> +		if (rc) {
> +			return dev_err_probe(dev, rc, "Failed to allocate %d MSIs\n",
> +					     mbox->msi_count);
> +		}
> +
> +		for (i = 0; i < mbox->channel_count; i++) {
> +			mchan = &mbox->channels[i];
> +			if (mchan->msi_index == U32_MAX)
> +				continue;
> +			mchan->msi_irq = msi_get_virq(dev, mchan->msi_index);
> +		}
> +	}
> +
> +	/* Register mailbox controller */
> +	rc = devm_mbox_controller_register(dev, &mbox->controller);
> +	if (rc) {
> +		dev_err_probe(dev, rc, "Registering SBI MPXY mailbox failed\n");
> +		if (mbox->msi_count)
> +			platform_device_msi_free_irqs_all(dev);
> +		return rc;
> +	}

> +	dev_info(dev, "mailbox registered with %d channels\n",
> +		 mbox->channel_count);

Working driver doesn't need to issue a message.

> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



