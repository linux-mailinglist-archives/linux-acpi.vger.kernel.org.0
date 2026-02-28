Return-Path: <linux-acpi+bounces-21271-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDc7L/Ufo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21271-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:03:49 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EF91C4A8E
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42A61303838B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137832E4274;
	Sat, 28 Feb 2026 17:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pZ25Q6Zt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A852DCF7D
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 17:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298216; cv=none; b=VOcZcDjMIyD0Wus7/9AWIjqEXihl45Ud+5oaAT03E2dJCI/XKh0PFCaWx+OwqXIducjHycpDXUjzVIDkLo7aSSug5iNageo7ASJVa8tykB0qra4fh+xdV+wMKBLU0wwVgHAiOEcP7NYulKYVh/8Gx4sJRCwN1Jp/+gYKDwwdb4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298216; c=relaxed/simple;
	bh=HFHzuN43YGXOqLuZUD8tNeeTC+An9Tvzwvq8WDr1XTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bY/M2I12Uw0wMdJvYFoKEmIDCiy08F3zw84/3oz5pqq1mOyf4DvARYgZlFSnIT41z9PvmnCrdy65vS1p0jEAKPkloDhPsk7Tn2XpqQINYjb3M0eiFk1TvYoDGRYa0rfr13U2oxxKmVBvXaoIZz5q1km3dT8DQOztG78vKyu4hR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pZ25Q6Zt; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <49543dcc-fba8-4b38-a5ae-6016d6bd1dc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772298212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2LSpfNro1AxAuS62WBgnj1G7BRWwKfxIjzv145J6yIY=;
	b=pZ25Q6ZtAbHAzYUPwbPmGKnrTew59rxC9rvDTS0r0ZVulKTm3PBANERM28YTJiTws5Yd0O
	3H9VT0651uC5yKNeRDjha/SM+TXC6Yi9FDlDyT5B0iDJd/vP32nHrzcxMxH7pc2d+ZXGQL
	i/j02KRJ5UNmCPbwJpOF3XjCYSie5jw=
Date: Sat, 28 Feb 2026 18:03:22 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 1/2] platform/x86: eeepc-laptop: Register ACPI notify
 handler directly
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>
References: <7916328.EvYhyI6sBW@rafael.j.wysocki>
 <3681264.iIbC2pHGDl@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <3681264.iIbC2pHGDl@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TAGGED_FROM(0.00)[bounces-21271-lists,linux-acpi=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 67EF91C4A8E
X-Rspamd-Action: no action


On 2/28/26 16:22, Rafael J. Wysocki wrote:
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
>  drivers/platform/x86/eeepc-laptop.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
> index 974f55e0b36f..626a99a71fce 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -1204,9 +1204,10 @@ static void eeepc_input_notify(struct eeepc_laptop *eeepc, int event)
>  		pr_info("Unknown key %x pressed\n", event);
>  }
>  
> -static void eeepc_acpi_notify(struct acpi_device *device, u32 event)
> +static void eeepc_acpi_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct eeepc_laptop *eeepc = acpi_driver_data(device);
> +	struct eeepc_laptop *eeepc = data;
> +	struct acpi_device *device = eeepc->device;
>  	int old_brightness, new_brightness;
>  	u16 count;
>  
> @@ -1422,9 +1423,16 @@ static int eeepc_acpi_add(struct acpi_device *device)
>  	if (result)
>  		goto fail_rfkill;
>  
> +	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
> +						 eeepc_acpi_notify, eeepc);
> +	if (result)
> +		goto fail_acpi_notifier;
> +
>  	eeepc_device_present = true;
>  	return 0;
>  
> +fail_acpi_notifier:
> +	eeepc_rfkill_exit(eeepc);
>  fail_rfkill:
>  	eeepc_led_exit(eeepc);
>  fail_led:
> @@ -1444,6 +1452,7 @@ static void eeepc_acpi_remove(struct acpi_device *device)
>  {
>  	struct eeepc_laptop *eeepc = acpi_driver_data(device);
>  
> +	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY, eeepc_acpi_notify);
>  	eeepc_backlight_exit(eeepc);
>  	eeepc_rfkill_exit(eeepc);
>  	eeepc_input_exit(eeepc);
> @@ -1464,11 +1473,9 @@ static struct acpi_driver eeepc_acpi_driver = {
>  	.name = EEEPC_LAPTOP_NAME,
>  	.class = EEEPC_ACPI_CLASS,
>  	.ids = eeepc_device_ids,
> -	.flags = ACPI_DRIVER_ALL_NOTIFY_EVENTS,
>  	.ops = {
>  		.add = eeepc_acpi_add,
>  		.remove = eeepc_acpi_remove,
> -		.notify = eeepc_acpi_notify,
>  	},
>  };
>  

