Return-Path: <linux-acpi+bounces-21451-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDruFa7oqWnuHQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21451-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:33:50 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A818E21831F
	for <lists+linux-acpi@lfdr.de>; Thu, 05 Mar 2026 21:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9FFC30C667C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Mar 2026 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783933A031;
	Thu,  5 Mar 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kM36gVx3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D21FF7B3;
	Thu,  5 Mar 2026 20:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772742577; cv=none; b=QFYequoZvtck6AFJiwW51zRYTxayZZ9MSnWveIvjOUk0An7/1UNPpO3if5ll/4zHqR1ezZdlpeeJ/0hIO0orKWs/6w5ODTU8laqN5wU+D3tq375iICsrKAiRMUtTurZOs4vT+VhgUMPo1mO5G7p/yKsdwyIoD3lLVdJSfH8N+yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772742577; c=relaxed/simple;
	bh=ziGtucL7M4e6LU2C4HHhwkolvBS+6+KksO9rwe9mBuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAAi89L/3LGHdH9qK24KKxEDYWM6lwsfDb4TN81djKjr3W5L9oj/F5hleMifK+gNKaoijUQSPgrnTfKMVAGzn4we0XvlEfJJArHlKKzRb3r2QE/heP2YttrtYrANAd/3WqT9JeuqQF/mD6XscVk8jSnFoy/4SQUEm8gJZ+oewT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kM36gVx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A52C19422;
	Thu,  5 Mar 2026 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772742576;
	bh=ziGtucL7M4e6LU2C4HHhwkolvBS+6+KksO9rwe9mBuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kM36gVx3YZsXg07uloYpmFXg6n0UUOorc5SnkJmXsP2CIZ2C6vKX7bOPGpqZdND0f
	 TGq+HJwVxGwDwWNRZdmgjG9e2D+klm9UB8XUjnv5ORivMp0uNFoWQp2l+sGjOOP4Fz
	 dAjRc6EbLbdoQqDCT+9DkKBwOPA/jms31LHSm92PobCajnqZbU52SO2CqR2mj0l07T
	 //HGp3nZD+cs0e27x9Cne5uasdZ8XcjgpT56BFXSwb2GsT1/AhHLcM8ggN8RRBy3vD
	 iwYBsB1riGsGtIAmJmSHHiUKOUJ/dh7G4Bk/BW0tYXld+xasBQBTaiPOkxl0sHCRHH
	 ysP2iHkGu6EXQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>
Subject:
 [PATCH v1 2/9] ACPI: PAD: Rearrange notify handler installation and removal
Date: Thu, 05 Mar 2026 21:11:22 +0100
Message-ID: <2011993.taCxCBeP46@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <4505861.ejJDZkT8p0@rafael.j.wysocki>
References: <4505861.ejJDZkT8p0@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A818E21831F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21451-lists,linux-acpi=lfdr.de];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Use acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
for installing and removing the ACPI notify handler, respectively, which
allows acpi_pad_notify() and acpi_pad_remove() to be simplified quite a
bit.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pad.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index c9a0bcaba2e4..407a0d68525c 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -407,8 +407,7 @@ static void acpi_pad_handle_notify(acpi_handle handle)
 	mutex_unlock(&isolated_cpus_lock);
 }
 
-static void acpi_pad_notify(acpi_handle handle, u32 event,
-	void *data)
+static void acpi_pad_notify(acpi_handle handle, u32 event, void *data)
 {
 	struct acpi_device *adev = data;
 
@@ -427,30 +426,22 @@ static void acpi_pad_notify(acpi_handle handle, u32 event,
 static int acpi_pad_probe(struct platform_device *pdev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
-	acpi_status status;
 
 	strscpy(acpi_device_name(adev), ACPI_PROCESSOR_AGGREGATOR_DEVICE_NAME);
 	strscpy(acpi_device_class(adev), ACPI_PROCESSOR_AGGREGATOR_CLASS);
 
-	status = acpi_install_notify_handler(adev->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify, adev);
-
-	if (ACPI_FAILURE(status))
-		return -ENODEV;
-
-	return 0;
+	return acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					       acpi_pad_notify, adev);
 }
 
 static void acpi_pad_remove(struct platform_device *pdev)
 {
-	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
-
 	mutex_lock(&isolated_cpus_lock);
 	acpi_pad_idle_cpus(0);
 	mutex_unlock(&isolated_cpus_lock);
 
-	acpi_remove_notify_handler(adev->handle,
-		ACPI_DEVICE_NOTIFY, acpi_pad_notify);
+	acpi_dev_remove_notify_handler(ACPI_COMPANION(&pdev->dev),
+				       ACPI_DEVICE_NOTIFY, acpi_pad_notify);
 }
 
 static const struct acpi_device_id pad_device_ids[] = {
-- 
2.51.0





