Return-Path: <linux-acpi+bounces-21190-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KhzE6dFoGmrhAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21190-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 14:07:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B08EA1A6187
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C0B73034284
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 13:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F43019C3;
	Thu, 26 Feb 2026 13:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gihdlS6l"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570C72FF67F
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 13:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110948; cv=none; b=WrJH1kOwBltHGdYh7iUVFV0s37DiNQG3hLNYNznHHQ5oNm9HOLXlkwhecjSjiRVxnujDiPGyuKubMpZDlaVNy+6p0XjEbvKMswJBvlEqRBnp7h6G9wjMdhUTPtQQxOKnP2pI5tl+8/jNPj0cuufHmzJJFDShb6DP+q5p9uKtP/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110948; c=relaxed/simple;
	bh=kw541bxpgF/rKfWQrR6ntfjOLk52v4zoczqF0T808LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m827HMZODL+/N6iacYAKCGAUKPRrOavuCqHDlXCkVdknG2riA/B/ZFua/P/6Rfx4GE8tiNSgjXUf0YNweaNs/LmRxixaADxFuVrRpP2bZnu7yHnnMRUAkUJPgJ6sUgipqXlpoerI6+9MGW/BYswgy+igPBHvafn0P0MWKBsCnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gihdlS6l; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC1B11A1374
	for <linux-acpi@vger.kernel.org>; Thu, 26 Feb 2026 13:02:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FC475FDEB;
	Thu, 26 Feb 2026 13:02:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A548110369367;
	Thu, 26 Feb 2026 14:02:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772110941; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=lr5KpqXn1aCWYtDIDTJocioKw5pB+8vxpfEXxt0dPkw=;
	b=gihdlS6lR2l3DlIVIVnWEgATlK/h0sv0ofdSkYG7hah104CmC9uLI8w2zAeV5nDRysyIXK
	ei5A9UAUswR5QaBSxsAXNIdnZzC2nvgT8Kv/zWlcF2d7OvBee61AXQa9j7fkauQPrfIrOI
	mAScFI7xqsa/tXAdhi4BJ1QqdzYeXrhH+IMAut4x4IIIT0nTtILM/7NIRpywWgIgnXMQsx
	fHDudPDGmLOJP+b+isjfClKprBUDxiKGyZLcPcZPqzryyaL/8G1+HIugsbIVSfk1rTyCAr
	9/QCLpAZAPx1ZI8m3VOuifflO3L6ze07mL2M6iEf4CTiorPJ7PiG7OZd+Fzuww==
Date: Thu, 26 Feb 2026 14:02:20 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 7/8] rtc: cmos: Drop PNP device support
Message-ID: <20260226130220deafa22a@mail.local>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
 <2355012.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2355012.iZASKD2KPV@rafael.j.wysocki>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21190-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.local:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email,intel.com:email]
X-Rspamd-Queue-Id: B08EA1A6187
X-Rspamd-Action: no action

On 23/02/2026 16:32:29+0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Previous changes effectively prevented PNP devices from being created
> for the CMOS RTC on x86 with ACPI.
> 
> Although in principle a CMOS RTC PNP device may exist on an x86 system
> without ACPI (that is, an x86 system where there is no ACPI at all, not
> one booted with ACPI disabled), such systems were there in the field ~30
> years ago and most likely they would not be able to run a contemporary
> Linux kernel.
> 
> For the above reasons, drop the PNP device support from the rtc-cmos
> driver.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/rtc/rtc-cmos.c | 113 +++--------------------------------------
>  1 file changed, 8 insertions(+), 105 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 7457f42fd6f0..9ac5bab846c1 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -1370,85 +1370,6 @@ static int __maybe_unused cmos_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(cmos_pm_ops, cmos_suspend, cmos_resume);
>  
> -/*----------------------------------------------------------------*/
> -
> -/* On non-x86 systems, a "CMOS" RTC lives most naturally on platform_bus.
> - * ACPI systems always list these as PNPACPI devices, and pre-ACPI PCs
> - * probably list them in similar PNPBIOS tables; so PNP is more common.
> - *
> - * We don't use legacy "poke at the hardware" probing.  Ancient PCs that
> - * predate even PNPBIOS should set up platform_bus devices.
> - */
> -
> -#ifdef	CONFIG_PNP
> -
> -#include <linux/pnp.h>
> -
> -static int cmos_pnp_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> -{
> -	int irq;
> -
> -	if (pnp_port_start(pnp, 0) == 0x70 && !pnp_irq_valid(pnp, 0)) {
> -		irq = 0;
> -#ifdef CONFIG_X86
> -		/* Some machines contain a PNP entry for the RTC, but
> -		 * don't define the IRQ. It should always be safe to
> -		 * hardcode it on systems with a legacy PIC.
> -		 */
> -		if (nr_legacy_irqs())
> -			irq = RTC_IRQ;
> -#endif
> -	} else {
> -		irq = pnp_irq(pnp, 0);
> -	}
> -
> -	return cmos_do_probe(&pnp->dev, pnp_get_resource(pnp, IORESOURCE_IO, 0), irq);
> -}
> -
> -static void cmos_pnp_remove(struct pnp_dev *pnp)
> -{
> -	cmos_do_remove(&pnp->dev);
> -}
> -
> -static void cmos_pnp_shutdown(struct pnp_dev *pnp)
> -{
> -	struct device *dev = &pnp->dev;
> -	struct cmos_rtc	*cmos = dev_get_drvdata(dev);
> -
> -	if (system_state == SYSTEM_POWER_OFF) {
> -		int retval = cmos_poweroff(dev);
> -
> -		if (cmos_aie_poweroff(dev) < 0 && !retval)
> -			return;
> -	}
> -
> -	cmos_do_shutdown(cmos->irq);
> -}
> -
> -static const struct pnp_device_id rtc_ids[] = {
> -	{ .id = "PNP0b00", },
> -	{ .id = "PNP0b01", },
> -	{ .id = "PNP0b02", },
> -	{ },
> -};
> -MODULE_DEVICE_TABLE(pnp, rtc_ids);
> -
> -static struct pnp_driver cmos_pnp_driver = {
> -	.name		= driver_name,
> -	.id_table	= rtc_ids,
> -	.probe		= cmos_pnp_probe,
> -	.remove		= cmos_pnp_remove,
> -	.shutdown	= cmos_pnp_shutdown,
> -
> -	/* flag ensures resume() gets called, and stops syslog spam */
> -	.flags		= PNP_DRIVER_RES_DO_NOT_CHANGE,
> -	.driver		= {
> -			.pm = &cmos_pm_ops,
> -	},
> -};
> -
> -#endif	/* CONFIG_PNP */
> -
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_cmos_match[] = {
>  	{
> @@ -1543,45 +1464,27 @@ static struct platform_driver cmos_platform_driver = {
>  	}
>  };
>  
> -#ifdef CONFIG_PNP
> -static bool pnp_driver_registered;
> -#endif
>  static bool platform_driver_registered;
>  
>  static int __init cmos_init(void)
>  {
> -	int retval = 0;
> +	int retval;
>  
> -#ifdef	CONFIG_PNP
> -	retval = pnp_register_driver(&cmos_pnp_driver);
> -	if (retval == 0)
> -		pnp_driver_registered = true;
> -#endif
> +	if (cmos_rtc.dev)
> +		return 0;
>  
> -	if (!cmos_rtc.dev) {
> -		retval = platform_driver_probe(&cmos_platform_driver,
> -					       cmos_platform_probe);
> -		if (retval == 0)
> -			platform_driver_registered = true;
> -	}
> +	retval = platform_driver_probe(&cmos_platform_driver, cmos_platform_probe);
> +	if (retval)
> +		return retval;
>  
> -	if (retval == 0)
> -		return 0;
> +	platform_driver_registered = true;
>  
> -#ifdef	CONFIG_PNP
> -	if (pnp_driver_registered)
> -		pnp_unregister_driver(&cmos_pnp_driver);
> -#endif
> -	return retval;
> +	return 0;
>  }
>  module_init(cmos_init);
>  
>  static void __exit cmos_exit(void)
>  {
> -#ifdef	CONFIG_PNP
> -	if (pnp_driver_registered)
> -		pnp_unregister_driver(&cmos_pnp_driver);
> -#endif
>  	if (platform_driver_registered)
>  		platform_driver_unregister(&cmos_platform_driver);
>  }
> -- 
> 2.51.0
> 
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

