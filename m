Return-Path: <linux-acpi+bounces-20530-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFZ+OQD/cWmvZwAAu9opvQ
	(envelope-from <linux-acpi+bounces-20530-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:42:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9275765693
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 11:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AAA776A27B3
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Jan 2026 10:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE337E31D;
	Thu, 22 Jan 2026 10:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rrkUvSIT"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0971AF0BB;
	Thu, 22 Jan 2026 10:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769077759; cv=none; b=oMGVV3ZlmB9SkLkhny3K37bttrF6ushr05Q6igtnConVXFySJVyz1XtZGo9cGq4J8SCluxALS6vepA5uIh2MG7A0IoR+MhZT1g7uhIfaxC5WIzLi3SZ08UE71P0OE4TVBi9anMYY3gLrZau75T/aZQWf8z6CvTNooSK5Xx6qkPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769077759; c=relaxed/simple;
	bh=uKRKux9iS3ROkkfKKUwwUwqJYfhukxH9PcpBbqJv6xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxWDi8W0EEWoaW5e/G2wqlPOU95y+tIM4YvRlFsxBTWozbXPM0aXxqQAGmydvNLpf4sd7xqnXunwHMiAzaGMfOfsS5Ie0VTRtenkONka0zB6ytttwS+s87r50/2WZfuSo/4ULPwclgr0wqUn8c/J5QHBNTSJx7PDBJGqVdtvoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rrkUvSIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EFAC116C6;
	Thu, 22 Jan 2026 10:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769077758;
	bh=uKRKux9iS3ROkkfKKUwwUwqJYfhukxH9PcpBbqJv6xE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rrkUvSIT8cVE/uNuxROhUecxxNK5GNNXVdlRCj+0HgYBSC/RlvJnWqCR+Cktq/E0I
	 2I2RLjPeaSlZZJYAcZGNfkzfxJuax/H2abVtyEty5V8W9woU7p3rhneP/DxRPboOg+
	 6fruH1rQcqoALVaMrBKR8nzJ7J6UOwdlqXagbZw4=
Date: Thu, 22 Jan 2026 11:29:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yicong Yang <yang.yicong@picoheart.com>
Cc: rafael@kernel.org, lenb@kernel.org, tglx@kernel.org, dakr@kernel.org,
	akpm@linux-foundation.org, apatel@ventanamicro.com, pjw@kernel.org,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr,
	geshijian@picoheart.com, weidong.wd@picoheart.com,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/2] ACPI: scan: Use async schedule function for
 acpi_scan_clear_dep_fn
Message-ID: <2026012214-dinginess-improper-9bc1@gregkh>
References: <20260122073446.45628-1-yang.yicong@picoheart.com>
 <20260122073446.45628-2-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122073446.45628-2-yang.yicong@picoheart.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-20530-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[picoheart.com:email,linuxfoundation.org:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 9275765693
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:34:45PM +0800, Yicong Yang wrote:
> The device object rescan in acpi_scan_clear_dep_fn is scheduled
> in the system workqueue which is not guaranteed to be finished
> before entering userspace. This will cause the problem that
> some key devices are missed when the init task try to find them,
> e.g. console devices and root devices (PCIe nvme, etc).
> This issues is more possbile to happen on RISCV since these
> devices using GSI interrupt may depend on APLIC and will be
> scanned in acpi_scan_clear_dep_queue() after APLIC initialized.
> 
> Fix this by scheduling the acpi_scan_clear_dep_queue() using async
> schedule function rather than the system workqueue. The deferred
> works will be synchronized by async_synchronize_full() before
> entering init task.
> 
> Update the comment as well.
> 
> Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
> ---
>  drivers/acpi/scan.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..bf0d8ba9ba19 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -5,6 +5,7 @@
>  
>  #define pr_fmt(fmt) "ACPI: " fmt
>  
> +#include <linux/async.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/slab.h>
> @@ -2365,39 +2366,35 @@ struct acpi_scan_clear_dep_work {
>  	struct acpi_device *adev;
>  };
>  
> -static void acpi_scan_clear_dep_fn(struct work_struct *work)
> +static void acpi_scan_clear_dep_fn(void *dev, async_cookie_t cookie)
>  {
> -	struct acpi_scan_clear_dep_work *cdw;
> -
> -	cdw = container_of(work, struct acpi_scan_clear_dep_work, work);
> +	struct acpi_device *adev = to_acpi_device(dev);
>  
>  	acpi_scan_lock_acquire();
> -	acpi_bus_attach(cdw->adev, (void *)true);
> +	acpi_bus_attach(adev, (void *)true);
>  	acpi_scan_lock_release();
>  
> -	acpi_dev_put(cdw->adev);
> -	kfree(cdw);
> +	acpi_dev_put(adev);
>  }
>  
>  static bool acpi_scan_clear_dep_queue(struct acpi_device *adev)
>  {
> -	struct acpi_scan_clear_dep_work *cdw;
> -
>  	if (adev->dep_unmet)
>  		return false;
>  
> -	cdw = kmalloc(sizeof(*cdw), GFP_KERNEL);
> -	if (!cdw)
> -		return false;
> -
> -	cdw->adev = adev;
> -	INIT_WORK(&cdw->work, acpi_scan_clear_dep_fn);
>  	/*
> -	 * Since the work function may block on the lock until the entire
> -	 * initial enumeration of devices is complete, put it into the unbound
> -	 * workqueue.
> +	 * Async schedule the deferred acpi_scan_clear_dep_fn() since:
> +	 * - acpi_bus_attach() needs to hold acpi_scan_lock which cannot
> +	 *   be acquired under acpi_dep_list_lock (held here)
> +	 * - the deferred work at boot stage is ensured to be finished
> +	 *   before entering init task by the async_synchronize_full()
> +	 *   barrier
> +	 *
> +	 * Use _nocall variant since it'll return on failure instead of
> +	 * run the function synchronously.
>  	 */
> -	queue_work(system_dfl_wq, &cdw->work);
> +	if (!async_schedule_dev_nocall(acpi_scan_clear_dep_fn, &adev->dev))
> +		return false;

This really feels wrong to me, you are taking a code path that has been
working for quite a while and changing it.  Perhaps your system ACPI
tables are the thing that is incorrect here?

What exactly is the problem that you are seeing?  Why not start with
that and then we can work out how to solve that issue?

thanks,

greg k-h

