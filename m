Return-Path: <linux-acpi+bounces-20893-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MABKK/VchmlfMQQAu9opvQ
	(envelope-from <linux-acpi+bounces-20893-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 22:28:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAAC71036D2
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Feb 2026 22:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 86E153003BD3
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Feb 2026 21:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCD3101A7;
	Fri,  6 Feb 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QWADoqms"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC25168BD;
	Fri,  6 Feb 2026 21:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770413296; cv=none; b=hMsNEDuz0KiM8lnbDIooOYDWX6AgQD5xrpMEr96afFQ3j/PSqUu88tHxgao7MQXOkezLlpElnOOUw3kzQur8Rv4gUIfehbLOeOxzj6BAxT8nTvZYv8Bw5iXnHRxDKyPaauo+EMrNeUa4ITf7DmSCyKRUXNelLz67J7BznSR0Yk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770413296; c=relaxed/simple;
	bh=BP0j86oF6FGrScGP7Gc/REVCvGgOfR1g3kgF5Q/9h84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJSNF9RhPcYMnsREHzns2MRxpbBTy9M+qJ2F2yGTZ7OrbWVQbdlSVAGJNY0hIYtPGB8FGe9NLQ++pcsTTcQeX859ND70/haGtXhWLkBEgXDnCtTpmYAu2uULSnc9gICn4EWaQQ+RQjkIV0JiI91Ssr5jdXhME2HWqeRYGVOoUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QWADoqms; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31B1C116C6;
	Fri,  6 Feb 2026 21:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770413296;
	bh=BP0j86oF6FGrScGP7Gc/REVCvGgOfR1g3kgF5Q/9h84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QWADoqms39iOUCCq7OIyNOVFptYQBA4EVrLMCOCWwOnVPCrH8w+pNb4OFuwMH7I58
	 nRl6LHkyR9dZ6Gkgyq1BGXNYbklxcNQYiHaDwDViWcC28cxXlg5g6Zaf73BF7Un4w0
	 vvQIRir30f6dJdart3viA7e0z/qWYAQRybubo6Uy+8f2hjH64XOvCiaDPrTHVhIU0Q
	 89I2Fs62UTQLNgbAGnIej4f9NmpUV/tdk8PblPXU7vrNl33aY/nwMCstZmMPU62Mtj
	 X1xPxVl/H1QDrkbeQ65Hjmp0sKqOk5rrp+F8SqTa1jase3XaVTjzSkvo4A0ZcUjxxy
	 VLdja9mWtIXww==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] ACPI: battery: Drop redundant check from acpi_battery_notify()
Date: Fri, 06 Feb 2026 22:28:12 +0100
Message-ID: <5981321.DvuYhMxLoT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <aYXvS1h3Bxf_5sCj@stanley.mountain>
References: <aYXvS1h3Bxf_5sCj@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20893-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: BAAC71036D2
X-Rspamd-Action: no action

On Friday, February 6, 2026 2:40:27 PM CET Dan Carpenter wrote:
> [ Smatch checking is paused while we raise funding.  #SadFace
>   https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]
> 
> 
> Hello Rafael J. Wysocki,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> Commit 08b54fd57782 ("ACPI: battery: Adjust event notification
> routine") from Dec 15, 2025, leads to the following Smatch complaint:
> 
>     drivers/acpi/battery.c:1062 acpi_battery_notify()
>     warn: variable dereferenced before check 'battery' (see line 1059)
> 
> drivers/acpi/battery.c
>   1058		struct acpi_battery *battery = data;
>   1059		struct acpi_device *device = battery->device;
>                                              ^^^^^^^^^^^^^^^
> The patch adds a dereference.
> 
>   1060		struct power_supply *old;
>   1061	
>   1062		if (!battery)
>                     ^^^^^^^^
> Checked too late.
> 
>   1063			return;
>   1064	

Thanks for the report, but the check above is redundant.

For the reason explained in the changelog of the patch below, the
battery pointer above cannot be NULL.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] ACPI: battery: Drop redundant check from acpi_battery_notify()

The battery pointer check against NULL in acpi_battery_notify() is
redundant because the value of that pointer is the one passed to
acpi_dev_install_notify_handler() in acpi_battery_probe() as the
last argument which is not NULL.

Drop the redundant check.

No intentional functional impact.

Closes: https://lore.kernel.org/linux-acpi/aYXvS1h3Bxf_5sCj@stanley.mountain/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/battery.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1066,9 +1066,6 @@ static void acpi_battery_notify(acpi_han
 	struct acpi_device *device = battery->device;
 	struct power_supply *old;
 
-	if (!battery)
-		return;
-
 	guard(mutex)(&battery->update_lock);
 
 	old = battery->bat;




