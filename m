Return-Path: <linux-acpi+bounces-21269-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YAtFE6Yfo2mC9wQAu9opvQ
	(envelope-from <linux-acpi+bounces-21269-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:02:30 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D64C51C49E6
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 18:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C4B3730387D1
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070B230171C;
	Sat, 28 Feb 2026 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EVbJuoBi"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8EB2D8DDB
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298144; cv=none; b=ZEtw0nrCmo9Mw8k6Ytclm1kGCUIFp1qm0aBWesxIIN9qZFgABW2Kw8TcEyPBLmaxkPpkWeoGwpI67VeJHKQJctXjRCviJuz/7RiyEkBFpzD8qXosNF19A9cO4DNAbfp+i+GQPKWMdn8voNAjZHV9o9Ot5cgUrH0b2BApsa8MJ1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298144; c=relaxed/simple;
	bh=E3tyh57oOhLe/qbSqgIBwvufs0nNmS1nqN+6+tLdkUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqxUtw4ZdTomDJ74wQ0a9r2t6IzR6DFj5iFsxp4jypPGdJIBVcVdvVUCR9E32EKodLV3WggsQHIXJ34PEYVE2kT7w84FI5mYHl76s4sArq/Dfdl+0C4c1xMU2GPnzfU6O3QWlbJc6lI4CK4U8NHDu3cl/nnnZNL2Z04IPqIBkfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EVbJuoBi; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6da00c19-423f-4735-8cb4-b80c94cfd208@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772298141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pIQ7OHAbilr2QMHzf2op6gOeHt4JbJAlTPM85ZhRxbM=;
	b=EVbJuoBiRPJMx/Sb9HVJDcogOeFjzpypImY6YXqXBUhS3ZSAAnN8wSK6UBfaEj/XED4zkJ
	EmS4Sae3QMPrgwIuLlNOLseCrJNm/HDXaBucX86V88b8SSxw5sFQc1+dYy7tdTo0dL28U2
	DSNFeZxLZmVw14wjbuByUOrzhJdrgHg=
Date: Sat, 28 Feb 2026 18:02:13 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1 3/4] platform/x86: asus-wireless: Register ACPI notify
 handler directly
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Rechi_Vita?= <jprvita@gmail.com>
References: <5971620.DvuYhMxLoT@rafael.j.wysocki>
 <1949745.tdWV9SEqCh@rafael.j.wysocki>
Content-Language: en-US, it-IT, en-US-large
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <1949745.tdWV9SEqCh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,ljones.dev];
	TAGGED_FROM(0.00)[bounces-21269-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,linux.dev:email,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D64C51C49E6
X-Rspamd-Action: no action


On 2/28/26 16:12, Rafael J. Wysocki wrote:
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
>  drivers/platform/x86/asus-wireless.c | 20 ++++++++++++++++----
>  1 file changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
> index 41227bf95878..45d41875c515 100644
> --- a/drivers/platform/x86/asus-wireless.c
> +++ b/drivers/platform/x86/asus-wireless.c
> @@ -108,9 +108,10 @@ static void led_state_set(struct led_classdev *led, enum led_brightness value)
>  	queue_work(data->wq, &data->led_work);
>  }
>  
> -static void asus_wireless_notify(struct acpi_device *adev, u32 event)
> +static void asus_wireless_notify(acpi_handle handle, u32 event, void *context)
>  {
> -	struct asus_wireless_data *data = acpi_driver_data(adev);
> +	struct asus_wireless_data *data = context;
> +	struct acpi_device *adev = data->adev;
>  
>  	dev_dbg(&adev->dev, "event=%#x\n", event);
>  	if (event != 0x88) {
> @@ -166,8 +167,18 @@ static int asus_wireless_add(struct acpi_device *adev)
>  	data->led.default_trigger = "rfkill-none";
>  	err = devm_led_classdev_register(&adev->dev, &data->led);
>  	if (err)
> -		destroy_workqueue(data->wq);
> +		goto err;
> +
> +	err = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> +					      asus_wireless_notify, data);
> +	if (err) {
> +		devm_led_classdev_unregister(&adev->dev, &data->led);
> +		goto err;
> +	}
> +	return 0;
>  
> +err:
> +	destroy_workqueue(data->wq);
>  	return err;
>  }
>  
> @@ -175,6 +186,8 @@ static void asus_wireless_remove(struct acpi_device *adev)
>  {
>  	struct asus_wireless_data *data = acpi_driver_data(adev);
>  
> +	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> +				       asus_wireless_notify);
>  	if (data->wq) {
>  		devm_led_classdev_unregister(&adev->dev, &data->led);
>  		destroy_workqueue(data->wq);
> @@ -188,7 +201,6 @@ static struct acpi_driver asus_wireless_driver = {
>  	.ops = {
>  		.add = asus_wireless_add,
>  		.remove = asus_wireless_remove,
> -		.notify = asus_wireless_notify,
>  	},
>  };
>  module_acpi_driver(asus_wireless_driver);

