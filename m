Return-Path: <linux-acpi+bounces-21189-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eILOGItFoGmrhAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21189-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 14:07:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AC11A6161
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C96743013D49
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Feb 2026 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029E3019D9;
	Thu, 26 Feb 2026 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xg4W7SQk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EBD2BCF6C;
	Thu, 26 Feb 2026 13:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772110902; cv=none; b=MwKznwu66S388K1MaZU6nD+65bepA/Ndhw0Xq97ZoB/dzbJbLNpDLWQZFGhEeIKV8NlpvolfdzSoUP+u438LAdmc6QPd+GWCmNhse4pSYjW1tZgSXCixfeL9r5CCqZ4jU0hs/5oEUwqordvNlIakxiW2L2fhNQ4Fc50aJPH74Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772110902; c=relaxed/simple;
	bh=2pWog8lpZCEHEdP1o6GJY7uGCaGGAibTb0zWl+12Y+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP1z9Ebjvh0VC477lG/9TO5Fgh2cGYdcFr7e8iSf2rJZXtY3uobC6DHlDH2ec6fg9xtMM8NZl5Vbgz+wenWD54VXGu8bZTEJbCYeyn8aJpqipVCL6EwGcNib5355Ta+0KocOT84Q+Z4oR0etMwEWmV/taNL1Ke0hz3ZeAm9xhRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xg4W7SQk; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C034E1A1374;
	Thu, 26 Feb 2026 13:01:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 960805FDEB;
	Thu, 26 Feb 2026 13:01:37 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96DD510369367;
	Thu, 26 Feb 2026 14:01:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772110896; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=rQUDWq1dNhEE9RGk8XjDrcqNsZM4DRVnAsm9ZzB/kaQ=;
	b=xg4W7SQkq5IiM5XaweHk4qlCO1o7jxUzNrdn+/xXMh896pCxyiFL4GnEWslbU/plI5AaGT
	3nOgePQcxHW0S283gZPPQlPlhCFutZQYH0QuwD56IU94wvpsEOxLp3gaXuNA7eXmLfJCzV
	uXGOiKmyRElqkLgD6zzWlbTqq4IOLn8ttucsqNYerqWOcH7Bv5rbwXxqbCssRxPS0TG28f
	WAlq4S7yyrEVUO2ufWbK3tmFqcU0YEBlm87p8K0jrlR40keVuBDU7HuvnKyVicO0SXBo/X
	oOVhayya9A3yMclxceOhV9RY+8wn5CqDJatZheoSUMUa9PQem1WIBslts+vzNw==
Date: Thu, 26 Feb 2026 14:01:34 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for
 driver binding
Message-ID: <20260226130134aa75696e@mail.local>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
 <13969123.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13969123.uLZWGnKmhe@rafael.j.wysocki>
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
	TAGGED_FROM(0.00)[bounces-21189-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.local:mid,bootlin.com:dkim,bootlin.com:url,bootlin.com:email]
X-Rspamd-Queue-Id: B8AC11A6161
X-Rspamd-Action: no action

On 23/02/2026 16:30:21+0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Modify the rtc-cmos driver to bind to a platform device on systems with
> ACPI via acpi_match_table and advertise the CMOST RTC ACPI device IDs
> for driver auto-loading.  Note that adding the requisite device IDs to
> it and exposing them via MODULE_DEVICE_TABLE() is sufficient for this
> purpose.
> 
> Since the ACPI device IDs in question are the same as for the CMOS RTC
> ACPI scan handler, put them into a common header file and use the
> definition from there in both places.
> 
> Additionally, to prevent a PNP device from being created for the CMOS
> RTC if a platform one is present already, make is_cmos_rtc_device()
> check cmos_rtc_platform_device_present introduced previously.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/acpi/acpi_pnp.c     |  2 +-
>  drivers/acpi/x86/cmos_rtc.c |  5 +----
>  drivers/rtc/rtc-cmos.c      | 10 ++++++++++
>  include/linux/acpi.h        |  6 ++++++
>  4 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
> index 85d9f78619a2..4ad8f56d1a5d 100644
> --- a/drivers/acpi/acpi_pnp.c
> +++ b/drivers/acpi/acpi_pnp.c
> @@ -368,7 +368,7 @@ static int is_cmos_rtc_device(struct acpi_device *adev)
>  		{ "PNP0B02" },
>  		{""},
>  	};
> -	return !acpi_match_device_ids(adev, ids);
> +	return !cmos_rtc_platform_device_present && !acpi_match_device_ids(adev, ids);
>  }
>  
>  bool acpi_is_pnp_device(struct acpi_device *adev)
> diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
> index bdd66dfd4a44..a6df5b991c96 100644
> --- a/drivers/acpi/x86/cmos_rtc.c
> +++ b/drivers/acpi/x86/cmos_rtc.c
> @@ -18,10 +18,7 @@
>  #include "../internal.h"
>  
>  static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
> -	{ "PNP0B00" },
> -	{ "PNP0B01" },
> -	{ "PNP0B02" },
> -	{}
> +	ACPI_CMOS_RTC_IDS
>  };
>  
>  bool cmos_rtc_platform_device_present;
> diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
> index 0743c6acd6e2..7457f42fd6f0 100644
> --- a/drivers/rtc/rtc-cmos.c
> +++ b/drivers/rtc/rtc-cmos.c
> @@ -27,6 +27,7 @@
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
> @@ -1476,6 +1477,14 @@ static __init void cmos_of_init(struct platform_device *pdev)
>  #else
>  static inline void cmos_of_init(struct platform_device *pdev) {}
>  #endif
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
> +	ACPI_CMOS_RTC_IDS
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_cmos_rtc_ids);
> +#endif
> +
>  /*----------------------------------------------------------------*/
>  
>  /* Platform setup should have set up an RTC device, when PNP is
> @@ -1530,6 +1539,7 @@ static struct platform_driver cmos_platform_driver = {
>  		.name		= driver_name,
>  		.pm		= &cmos_pm_ops,
>  		.of_match_table = of_match_ptr(of_cmos_match),
> +		.acpi_match_table = ACPI_PTR(acpi_cmos_rtc_ids),
>  	}
>  };
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 2bdb801cee01..5ecdcdaf31aa 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -791,6 +791,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
>  int acpi_mrrm_max_mem_region(void);
>  #endif
>  
> +#define ACPI_CMOS_RTC_IDS	\
> +	{ "PNP0B00", },		\
> +	{ "PNP0B01", },		\
> +	{ "PNP0B02", },		\
> +	{ "", }
> +
>  extern bool cmos_rtc_platform_device_present;
>  
>  #else	/* !CONFIG_ACPI */
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

