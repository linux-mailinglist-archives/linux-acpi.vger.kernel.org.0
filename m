Return-Path: <linux-acpi+bounces-21395-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLniOT41qWlk3AAAu9opvQ
	(envelope-from <linux-acpi+bounces-21395-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:48:14 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 628A120CE30
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 08:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9ED4302F687
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 07:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBCB328608;
	Thu,  5 Mar 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pHaZPZDn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6530B53A;
	Thu,  5 Mar 2026 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772696888; cv=none; b=KlAHGN6+X0SDfwrF+ux3sHPK6V3covoDgIqEED31AzaBOrJgUA6QcU2DaPg7Nk8mAsdNZzwMqv6Rj/cAbFI9BLKYqjqWeQEfdTvVoQGueP9OIKH20CdOYuSFiHmZXJfeMfSWPi24dH7WEy8XYRDk5xKjDEh+M/fDy+KfcoYKEOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772696888; c=relaxed/simple;
	bh=Ovvh/6MYV2WSyqHB9xbSPCaYhmlv1JQ0NQT+k21dghI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPi5ypm7NV+9gU9u38tfec4y54wvPXGuvAr3USuixAVVANGXUu71hSP1u9/twRpuaasKHuf0CG+HYuNYFWC9PlpXUf7/TKS4wZZRQzrtB02ITe7W6rgmJAD9WsDbRJ6FfJa4HXPKVH1s7wMT49fsiF1vqmuR22fZmOQ29xpoKr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pHaZPZDn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E963FC40404;
	Thu,  5 Mar 2026 07:48:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F2A25FDEB;
	Thu,  5 Mar 2026 07:48:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 289351036981A;
	Thu,  5 Mar 2026 08:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772696882; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=hsyLDW4nJEH6PPZ0/VDK4H6ENav77uqw47Wi4VxY1J0=;
	b=pHaZPZDnb7mfsmgbqkqNhzzem8M6VyZFj3UsRfACQ8vnMcmpS6z5nolKpCw1+E1OWD3vlB
	SxEWRQbOeR22zWMd9uetQyHlCnm1yaI6aACAmbLK7rxFBAhszqmkgooVeFDYWMfU/UaigD
	yPIiitmqH+W7ssYSFE6DHQUsSCsu85o95g/P2CQ0YTQrSCR7Dr4YOhoPepM6tX+1EUZrFS
	EV31NWCs72eWs3hpg1gUqQ1kEiqk6KkC4eHJ2sF4TX6PiHnyFh22990+EI/sBOJ5a9W8m6
	mjNlIvR0A2LYLKQ4eAxvmvGPEHTXTkg01CzDMDdA93AgGUHcIk0v84lu7nI5Ow==
Date: Thu, 5 Mar 2026 08:48:01 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
	Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v1 6/7] ACPI: TAD: Add RTC class device interface
Message-ID: <20260305074801a04117a7@mail.local>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
 <2352027.iZASKD2KPV@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2352027.iZASKD2KPV@rafael.j.wysocki>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 628A120CE30
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21395-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:email,mail.local:mid]
X-Rspamd-Action: no action

On 04/03/2026 19:16:01+0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add an RTC class device interface allowing to read and set the real time
> value to the ACPI TAD driver.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
>  drivers/acpi/acpi_tad.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 76 insertions(+), 2 deletions(-)
> 
> --- a/drivers/acpi/acpi_tad.c
> +++ b/drivers/acpi/acpi_tad.c
> @@ -25,6 +25,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/rtc.h>
>  #include <linux/suspend.h>
>  
>  MODULE_DESCRIPTION("ACPI Time and Alarm (TAD) Device Driver");
> @@ -51,6 +52,7 @@ MODULE_AUTHOR("Rafael J. Wysocki");
>  
>  /* ACPI TAD RTC */
>  #define ACPI_TAD_TZ_UNSPEC	2047
> +#define ACPI_TAD_TIME_ISDST	3
>  
>  struct acpi_tad_driver_data {
>  	u32 capabilities;
> @@ -164,6 +166,8 @@ static int acpi_tad_get_real_time(struct
>  	return 0;
>  }
>  
> +/* sysfs interface */
> +
>  static char *acpi_tad_rt_next_field(char *s, int *val)
>  {
>  	char *p;
> @@ -579,6 +583,71 @@ static const struct attribute_group acpi
>  	.is_visible = acpi_tad_attr_is_visible,
>  };
>  
> +#ifdef CONFIG_RTC_CLASS
> +/* RTC class device interface */
> +
> +static int acpi_tad_rtc_set_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct acpi_tad_rt rt;
> +
> +	rt.year = tm->tm_year + 1900;
> +	rt.month = tm->tm_mon + 1;
> +	rt.day = tm->tm_mday;
> +	rt.hour = tm->tm_hour;
> +	rt.minute = tm->tm_min;
> +	rt.second = tm->tm_sec;
> +	rt.tz = ACPI_TAD_TZ_UNSPEC;
> +	rt.daylight = ACPI_TAD_TIME_ISDST * !!tm->tm_isdst;
> +
> +	return acpi_tad_set_real_time(dev, &rt);
> +}
> +
> +static int acpi_tad_rtc_read_time(struct device *dev, struct rtc_time *tm)
> +{
> +	struct acpi_tad_rt rt;
> +	int ret;
> +
> +	ret = acpi_tad_get_real_time(dev, &rt);
> +	if (ret)
> +		return ret;
> +
> +	tm->tm_year = rt.year - 1900;
> +	tm->tm_mon = rt.month - 1;
> +	tm->tm_mday = rt.day;
> +	tm->tm_hour = rt.hour;
> +	tm->tm_min = rt.minute;
> +	tm->tm_sec = rt.second;
> +	tm->tm_isdst = rt.daylight == ACPI_TAD_TIME_ISDST;
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops acpi_tad_rtc_ops = {
> +	.read_time = acpi_tad_rtc_read_time,
> +	.set_time = acpi_tad_rtc_set_time,
> +};
> +
> +static void acpi_tad_register_rtc(struct device *dev)
> +{
> +	struct rtc_device *rtc;
> +
> +	rtc = devm_rtc_allocate_device(dev);
> +	if (IS_ERR(rtc))
> +		return;
> +
> +	rtc->range_min = mktime64(1900,  1,  1,  0,  0,  0);
> +	rtc->range_max = mktime64(9999, 12, 31, 23, 59, 59);
> +
> +	rtc->ops = &acpi_tad_rtc_ops;
> +
> +	devm_rtc_register_device(rtc);
> +}
> +#else /* !CONFIG_RTC_CLASS */
> +static inline void acpi_tad_register_rtc(struct device *dev) {}
> +#endif /* !CONFIG_RTC_CLASS */
> +
> +/* Platform driver interface */
> +
>  static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
>  {
>  	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
> @@ -660,10 +729,15 @@ static int acpi_tad_probe(struct platfor
>  	pm_runtime_suspend(dev);
>  
>  	ret = sysfs_create_group(&dev->kobj, &acpi_tad_attr_group);
> -	if (ret)
> +	if (ret) {
>  		acpi_tad_remove(pdev);
> +		return ret;
> +	}
>  
> -	return ret;
> +	if (caps & ACPI_TAD_RT)
> +		acpi_tad_register_rtc(dev);
> +
> +	return 0;
>  }
>  
>  static const struct acpi_device_id acpi_tad_ids[] = {
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

