Return-Path: <linux-acpi+bounces-20955-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPiLLsjWjWng7wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20955-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:34:00 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170ED12DD47
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1BED30C6D65
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60388314D03;
	Thu, 12 Feb 2026 13:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCUv5Zkn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398E619539F;
	Thu, 12 Feb 2026 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903202; cv=none; b=GpzK/Gsdj74vcW7ddlX2cTL/jO7U5ns2DX6LmBe6/szVPSBM/056xminnKaedgluQ6vjUb+/rpsRR3VIhk+/2it27GY3f50TEBh2qMbwkQ7SXF9mZlOfPGRKDyDcexIRg/E2W4C1sOoLC1vJpg8odTVk+Q4lEeQN6AJ/BpZJg9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903202; c=relaxed/simple;
	bh=TfeLDyjh76B5gHlyu1/g7M1dogaQ16YXqXL5NlJ0v80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pY5YghV/ZrLlwppwbg4oCPYbeEllcvdIdxH5qLu3WE6QCb3hKCLxIPNvNSizym1jeFMdpe3yA2GeD+1i/BG10m97PSSZ8RJB+8EfUh0UpaPIu4zwKWGxWvcUVDPi3+7HFltT4YVKtjg29awn94eL6Cm8dcJYAC6orxK8SJY9VJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCUv5Zkn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A90CC4CEF7;
	Thu, 12 Feb 2026 13:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770903201;
	bh=TfeLDyjh76B5gHlyu1/g7M1dogaQ16YXqXL5NlJ0v80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vCUv5ZknltQEH0mBq8eg08VwZUiQMVBodgUVm6hwok1t5odzR9DQszJKEDgjFS6PG
	 p6Mlu6//We1zouYVJDGY4ZR7fEWYpgaoKYUSTPUgRStWa3G9YVHfYPRJZl7fo4THIr
	 S2P91wr2cRgIVsZT7tstI4391XY9UmWla1eFDh+kWNkH4YA0rSHbBvzwxInv/1rHnt
	 2c4UzvJWT7GZ2gFq/Nu6cKo12xQJozPfwPfLeONR+J6R+27lR4CKyUVIE5R5+YsK5G
	 kY/A5CxCUzviUdaPfyT3bNmZZqxWeLlzaXworYNzW3KEfCaO94F1TtoYxAT+VACMI+
	 f4DzhsC9Zbc2w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 1/2] ACPI: button: Tweak system wakeup handling
Date: Thu, 12 Feb 2026 14:31:33 +0100
Message-ID: <1948258.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2400697.ElGaqSPkdT@rafael.j.wysocki>
References: <2400697.ElGaqSPkdT@rafael.j.wysocki>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20955-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 170ED12DD47
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify struct acpi_button to hold a struct device pointer instead
of a struct platform_device one to avoid unnecessary pointer
dereferences and use that pointer consistently for system wakeup
initialization, handling and cleanup.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -170,7 +170,7 @@ static struct platform_driver acpi_butto
 
 struct acpi_button {
 	struct acpi_device *adev;
-	struct platform_device *pdev;
+	struct device *dev;		/* physical button device */
 	unsigned int type;
 	struct input_dev *input;
 	char phys[32];			/* for input device */
@@ -398,7 +398,7 @@ static int acpi_lid_update_state(struct
 		return state;
 
 	if (state && signal_wakeup)
-		acpi_pm_wakeup_event(&button->pdev->dev);
+		acpi_pm_wakeup_event(button->dev);
 
 	return acpi_lid_notify_state(button, state);
 }
@@ -455,7 +455,7 @@ static void acpi_button_notify(acpi_hand
 		return;
 	}
 
-	acpi_pm_wakeup_event(&button->pdev->dev);
+	acpi_pm_wakeup_event(button->dev);
 
 	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
@@ -550,7 +550,7 @@ static int acpi_button_probe(struct plat
 
 	platform_set_drvdata(pdev, button);
 
-	button->pdev = pdev;
+	button->dev = &pdev->dev;
 	button->adev = device;
 	button->input = input = input_allocate_device();
 	if (!input) {
@@ -625,7 +625,7 @@ static int acpi_button_probe(struct plat
 		goto err_remove_fs;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
+	device_init_wakeup(button->dev, true);
 
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
@@ -661,7 +661,7 @@ static int acpi_button_probe(struct plat
 	return 0;
 
 err_input_unregister:
-	device_init_wakeup(&pdev->dev, false);
+	device_init_wakeup(button->dev, false);
 	input_unregister_device(input);
 err_remove_fs:
 	acpi_button_remove_fs(button);
@@ -693,7 +693,7 @@ static void acpi_button_remove(struct pl
 	}
 	acpi_os_wait_events_complete();
 
-	device_init_wakeup(&pdev->dev, false);
+	device_init_wakeup(button->dev, false);
 
 	acpi_button_remove_fs(button);
 	input_unregister_device(button->input);




