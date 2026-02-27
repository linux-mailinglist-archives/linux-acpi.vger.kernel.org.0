Return-Path: <linux-acpi+bounces-21199-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4K4aBvpzoWkPtQQAu9opvQ
	(envelope-from <linux-acpi+bounces-21199-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 11:37:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E43B1B610D
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 11:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F752301077C
	for <lists+linux-acpi@lfdr.de>; Fri, 27 Feb 2026 10:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E7B3939AA;
	Fri, 27 Feb 2026 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="w0TV0ZBz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DE3A1A23
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188660; cv=none; b=XF7jg3VsX8rC7r1srQShiv/hCKBhX0sbAqwxZfIvTDdQUI8wNaclVvJJbNWObUNwrb5v70h6mkfSB8tU3K1laspZqqysWOMFUcB4/PmItjqb2/EWEzR+CVP8GMk21H6bfCqyGbqh11Oybh3SB4LZx+GyGaw92f9RqZ+tHbwZOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188660; c=relaxed/simple;
	bh=FyfWSA3yMbotQyW/kydmCJpUichjMj/M/X1snlxlvvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W05kqocGr42qN/+nwj0M6gdidS5O32bxOrNaNf6Gg1gs/SfWn+4qVanlef/TEplNUJbb15p4KK0faMILi79N8Qm1vENma43/F7R46LkNqaCOuqeCPC0xHBwUZedw57hiilZiVjni3FgHQpTUn5NJ5UoGAD+P7x92v3cqXru3ERc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=w0TV0ZBz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BC7841A1A54
	for <linux-acpi@vger.kernel.org>; Fri, 27 Feb 2026 10:37:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 911565FE46;
	Fri, 27 Feb 2026 10:37:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99DA210368D57;
	Fri, 27 Feb 2026 11:37:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772188655; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=ohtriEmRdRFAOG5NOsPeDzSDBGb5/D2uWfF2TVYCHoo=;
	b=w0TV0ZBzUL5mLeSTvj+Od5e9VlnNrp+EfUrTXPSlIhQDpFdK8ZT4bhZQCn2w6sTqM494oX
	Ko2cgMYJuKx8BEuiJwNy0C9MAPbaupk/iSSE1x8PXkn6DIT95j6MGFy3Xbho5vAA8zh9Z3
	7F3KJBDzpmCQqRKBPmuD16RcbU/UG7soH/ZtitT+8TnOtscAxx43a6+4maVCkLJpbNPR5V
	5Ddzot71SbOgcTYG0XYzxi8lR9wfDye5fSTzkww8RazTWPv2qWcSouS0F1agZjfDI3xoYh
	m80bV1u9K/FMN6Wa6rwC7GcgAjUBACgLGSDrK3jDVcJExipctxAxDbBqzrTuFQ==
Date: Fri, 27 Feb 2026 11:37:34 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0 5/6] ACPI: TAD: Add RTC class device interface
Message-ID: <202602271037341ec1378a@mail.local>
References: <4727679.LvFx2qVVIh@rafael.j.wysocki>
 <10819001.nUPlyArG6x@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10819001.nUPlyArG6x@rafael.j.wysocki>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21199-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexandre.belloni@bootlin.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:url,bootlin.com:dkim,rt.tz:url]
X-Rspamd-Queue-Id: 2E43B1B610D
X-Rspamd-Action: no action

Hello,

On 22/02/2026 15:18:29+0100, Rafael J. Wysocki wrote:
> +static int acpi_tad_rtc_procfs(struct device *dev, struct seq_file *seq)
> +{
> +	struct acpi_tad_rt rt;
> +	int ret;
> +
> +	ret = acpi_tad_get_real_time(dev, &rt);
> +	if (ret)
> +		return ret;
> +
> +	seq_printf(seq,
> +		   "Time\t\t: %u:%u:%u\n"
> +		   "Date\t\t: %u-%u-%u\n"
> +		   "Daylight\t: %s\n",
> +		   rt.hour, rt.minute, rt.second,
> +		   rt.year, rt.month, rt.day,
> +		   str_yes_no(rt.daylight == ACPI_TAD_TIME_ISDST));
> +
> +	if (rt.tz == ACPI_TAD_TZ_UNSPEC)
> +		seq_puts(seq, "Timezone\t: unspecified\n");
> +	else
> +		seq_printf(seq, "Timezone\t: %d\n", rt.tz);
> +
> +	return 0;
> +}
> +
> +static const struct rtc_class_ops acpi_tad_rtc_ops = {
> +	.read_time = acpi_tad_rtc_read_time,
> +	.set_time = acpi_tad_rtc_set_time,
> +	.proc = acpi_tad_rtc_procfs,

I would avoid implementing .proc, it has been deprecated for a while and
doesn't bring much.

> +};
> +
> +/* Platform driver interface */
> +
>  static int acpi_tad_disable_timer(struct device *dev, u32 timer_id)
>  {
>  	return acpi_tad_wake_set(dev, "_STV", timer_id, ACPI_TAD_WAKE_DISABLED);
> @@ -655,10 +730,16 @@ static int acpi_tad_probe(struct platfor
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
> +		devm_rtc_device_register(dev, "acpi-tad-rtc", &acpi_tad_rtc_ops,
> +					 THIS_MODULE);
> +

Please use devm_rtc_allocate_device() and devm_rtc_register_device() so
you can set range_min and range_max. I get you don't need the rtc_device
later so we could have a helper that takes the range and registers the
rtc.

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

