Return-Path: <linux-acpi+bounces-21059-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFPnN9F0nGlrHwQAu9opvQ
	(envelope-from <linux-acpi+bounces-21059-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:40:01 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AA7178DF2
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3916E309A2FB
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20822FE591;
	Mon, 23 Feb 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhjYLr5e"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9EA2EBBAF;
	Mon, 23 Feb 2026 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860851; cv=none; b=dPia8X+OquMyXceLxDVDdr4ocG1g+ie6yWzu5mMLEzM6kmAEkjNlX12DRLqF5WZDVs84+V8XSvst9bMS7F2nKDAhpegJgdBFawHnyavbJOo5guOcN7O9EoVuQ48obRyPEWI+8XKjYOVNsQMHLrDG+OGa7apT67n8WsHSOCLFm4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860851; c=relaxed/simple;
	bh=Rt5YZGru5ERpLmmQq9zPflnQZZel7uriPmrZZgtc/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aNo3L26QRNdkLjiTVL7bark9VuQsHzV8Ywc+qscGCdl3lONIFJAwdvT8FGACOlOCl/zkUqo172xn/QVBmejNhsWT8UOzAWPmVFwGGcHEdjZFZmBLJXXhHcjFrH53qMQHFWZdI0sKauONtLADilA+KLYdPvotDC7kVUtuP4jKLuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhjYLr5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4416DC116D0;
	Mon, 23 Feb 2026 15:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860851;
	bh=Rt5YZGru5ERpLmmQq9zPflnQZZel7uriPmrZZgtc/jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jhjYLr5ecKzBFxiQUIVqmbMUa3HRv1v/skP0qxGk6U6ok//sKXWPyAt1BDWYfc9L1
	 DWkQ8IgkpDpdbysVC3cp90YSKRxykfNYBQk3EvOlhPGRhLUMEDp2f4Vqwuy13RzSkU
	 33FKXNRlDAu9tBJzraMNIYB3u7We836v6hQkEMo2k4WX5MvhTu2b8WNa5y3pB3aly+
	 Fm4YLBGu97WxdPlCCyUOOzROotuvYmMTxQtgEJl0QN5DaXXHi16QS+OgqeoGNxjFq9
	 wetfcvFjLb+NsSAkeY4TNdHmwt1rdrH6Qy/S3Gw3craeWCJCWOlVSjs1e3xenZ969v
	 +r2kMI1lhfiIw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 1/8] ACPI: x86: cmos_rtc: Clean up address space handler driver
Date: Mon, 23 Feb 2026 16:28:15 +0100
Message-ID: <5094429.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5983325.DvuYhMxLoT@rafael.j.wysocki>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21059-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: A4AA7178DF2
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make multiple changes that do not alter functionality to the CMOS RTC
ACPI address space handler driver, including the following:

 - Drop the unused .detach() callback from cmos_rtc_handler.

 - Rename acpi_cmos_rtc_attach_handler() to acpi_cmos_rtc_attach().

 - Rearrange acpi_cmos_rtc_space_handler() to reduce the number of
   redundant checks and make white space follow the coding style.

 - Adjust an error message in acpi_install_cmos_rtc_space_handler()
   and make the white space follow the coding style.

 - Rearrange acpi_remove_cmos_rtc_space_handler() and adjust an error
   message in it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/x86/cmos_rtc.c | 61 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 51643ff6fe5f..977234da9fc1 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,31 +24,35 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
-static acpi_status
-acpi_cmos_rtc_space_handler(u32 function, acpi_physical_address address,
-		      u32 bits, u64 *value64,
-		      void *handler_context, void *region_context)
+static acpi_status acpi_cmos_rtc_space_handler(u32 function,
+					       acpi_physical_address address,
+					       u32 bits, u64 *value64,
+					       void *handler_context,
+					       void *region_context)
 {
-	int i;
+	unsigned int i, bytes = DIV_ROUND_UP(bits, 8);
 	u8 *value = (u8 *)value64;
 
 	if (address > 0xff || !value64)
 		return AE_BAD_PARAMETER;
 
-	if (function != ACPI_WRITE && function != ACPI_READ)
-		return AE_BAD_PARAMETER;
+	guard(spinlock_irq)(&rtc_lock);
+
+	if (function == ACPI_WRITE) {
+		for (i = 0; i < bytes; i++, address++, value++)
+			CMOS_WRITE(*value, address);
 
-	spin_lock_irq(&rtc_lock);
+		return AE_OK;
+	}
 
-	for (i = 0; i < DIV_ROUND_UP(bits, 8); ++i, ++address, ++value)
-		if (function == ACPI_READ)
+	if (function == ACPI_READ) {
+		for (i = 0; i < bytes; i++, address++, value++)
 			*value = CMOS_READ(address);
-		else
-			CMOS_WRITE(*value, address);
 
-	spin_unlock_irq(&rtc_lock);
+		return AE_OK;
+	}
 
-	return AE_OK;
+	return AE_BAD_PARAMETER;
 }
 
 int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
@@ -56,11 +60,11 @@ int acpi_install_cmos_rtc_space_handler(acpi_handle handle)
 	acpi_status status;
 
 	status = acpi_install_address_space_handler(handle,
-			ACPI_ADR_SPACE_CMOS,
-			&acpi_cmos_rtc_space_handler,
-			NULL, NULL);
+						    ACPI_ADR_SPACE_CMOS,
+						    acpi_cmos_rtc_space_handler,
+						    NULL, NULL);
 	if (ACPI_FAILURE(status)) {
-		pr_err("Error installing CMOS-RTC region handler\n");
+		pr_err("Failed to install CMOS-RTC address space handler\n");
 		return -ENODEV;
 	}
 
@@ -70,26 +74,25 @@ EXPORT_SYMBOL_GPL(acpi_install_cmos_rtc_space_handler);
 
 void acpi_remove_cmos_rtc_space_handler(acpi_handle handle)
 {
-	if (ACPI_FAILURE(acpi_remove_address_space_handler(handle,
-			ACPI_ADR_SPACE_CMOS, &acpi_cmos_rtc_space_handler)))
-		pr_err("Error removing CMOS-RTC region handler\n");
+	acpi_status status;
+
+	status = acpi_remove_address_space_handler(handle,
+						   ACPI_ADR_SPACE_CMOS,
+						   acpi_cmos_rtc_space_handler);
+	if (ACPI_FAILURE(status))
+		pr_err("Failed to remove CMOS-RTC address space handler\n");
 }
 EXPORT_SYMBOL_GPL(acpi_remove_cmos_rtc_space_handler);
 
-static int acpi_cmos_rtc_attach_handler(struct acpi_device *adev, const struct acpi_device_id *id)
+static int acpi_cmos_rtc_attach(struct acpi_device *adev,
+				const struct acpi_device_id *id)
 {
 	return acpi_install_cmos_rtc_space_handler(adev->handle);
 }
 
-static void acpi_cmos_rtc_detach_handler(struct acpi_device *adev)
-{
-	acpi_remove_cmos_rtc_space_handler(adev->handle);
-}
-
 static struct acpi_scan_handler cmos_rtc_handler = {
 	.ids = acpi_cmos_rtc_ids,
-	.attach = acpi_cmos_rtc_attach_handler,
-	.detach = acpi_cmos_rtc_detach_handler,
+	.attach = acpi_cmos_rtc_attach,
 };
 
 void __init acpi_cmos_rtc_init(void)
-- 
2.51.0





