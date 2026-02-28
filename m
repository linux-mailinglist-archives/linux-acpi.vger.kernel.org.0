Return-Path: <linux-acpi+bounces-21267-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOMVAgEfo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21267-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:59:45 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0771E1C4929
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 31A213031885
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F95D2D47F1;
	Sat, 28 Feb 2026 16:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZasrOEIx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2289283FD4
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772297978; cv=none; b=s7Tvu7UOMSBJpHn3etfEWlCLw/8knKxMcLgnp2H73whcnCp1yBFgXXoQzb5iUOipnezSypUnJEPtj9zLULO2H8hy61rIVZta/4KeWXlGGrQ5jqs6emRSE6ypEsYHaLomtXDvBPqsgGRzM4mSaKoEri1o7sBRStIlSdAJwMwJfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772297978; c=relaxed/simple;
	bh=lnM5u9m7cpcDnp2jhMP/qXb2+noJHrb9I2tKHR/BGQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0qDt1++D+AkA8BhCC/Zb93Zs6w+UsSN9lEdf0KwQyGd3tjWx2ZTikYcCUJQd3VDMREclPSId30ZkDifTpS6ex0Qw4pdy76jmHomXF2uzHZnO7RjQLmeh8kaUpeRiJqw4k8MOpjtGTcWCLOXmBRgDOvU9XGLOvtVEE/sW0Qi3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZasrOEIx; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f55a6814-862e-46a9-91ca-f7bbf6921dde@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772297964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GmODGzsAeskH3T4/uB7uCNYyQELuBh/kkleAtup5VNQ=;
	b=ZasrOEIxSAf2eCPzIUTnCYqnBazHtwlj+3FKwq8LsS3TJYJIf95MVo0U2K+5YotRFEW3vb
	Qo77ohneYa9hti3Iscy1h+En9YQUU6ZcCYrrnvfdsioDMSk0vc2iXGhqp7MY5I1Urc1yCp
	UzK86ZgHwYp05+bnFi0R9SVw8vJ3hL0=
Date: Sat, 28 Feb 2026 17:59:16 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/4] platform/x86: asus-laptop: Register ACPI notify
 handler directly
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
 <5082508.31r3eYUQgx@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <5082508.31r3eYUQgx@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TAGGED_FROM(0.00)[bounces-21267-lists,linux-acpi=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[denis.benato@linux.dev,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:mid,linux.dev:dkim,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0771E1C4929
X-Rspamd-Action: no action


On 2/28/26 16:10, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
>
> No intentional functional impact.
Reviewed-by: Denis Benato <denis.benato@linux.dev>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/asus-laptop.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-laptop.c b/drivers/platform/x86/asus-laptop.c
> index d96f6af26ff7..c927665dfa96 100644
> --- a/drivers/platform/x86/asus-laptop.c
> +++ b/drivers/platform/x86/asus-laptop.c
> @@ -1517,9 +1517,9 @@ static void asus_input_exit(struct asus_laptop *asus)
>  /*
>   * ACPI driver
>   */
> -static void asus_acpi_notify(struct acpi_device *device, u32 event)
> +static void asus_acpi_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct asus_laptop *asus = acpi_driver_data(device);
> +	struct asus_laptop *asus = data;
>  	u16 count;
>  
>  	/* TODO Find a better way to handle events count. */
> @@ -1881,6 +1881,11 @@ static int asus_acpi_add(struct acpi_device *device)
>  	if (result && result != -ENODEV)
>  		goto fail_pega_rfkill;
>  
> +	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> +						 asus_acpi_notify, asus);
> +	if (result)
> +		goto fail_pega_rfkill;
> +
>  	asus_device_present = true;
>  	return 0;
>  
> @@ -1906,6 +1911,7 @@ static void asus_acpi_remove(struct acpi_device *device)
>  {
>  	struct asus_laptop *asus = acpi_driver_data(device);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY, asus_acpi_notify);
>  	asus_backlight_exit(asus);
>  	asus_rfkill_exit(asus);
>  	asus_led_exit(asus);
> @@ -1932,7 +1938,6 @@ static struct acpi_driver asus_acpi_driver = {
>  	.ops = {
>  		.add = asus_acpi_add,
>  		.remove = asus_acpi_remove,
> -		.notify = asus_acpi_notify,
>  		},
>  };
>  

