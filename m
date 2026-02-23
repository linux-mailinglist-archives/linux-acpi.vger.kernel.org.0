Return-Path: <linux-acpi+bounces-21055-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOBGOGB0nGmcGAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21055-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:38:08 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 613DF178D63
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6915130C57EA
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A92F12CF;
	Mon, 23 Feb 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Of/uO+lt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996A2EAB72;
	Mon, 23 Feb 2026 15:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860837; cv=none; b=CWmYkUSDI2a4ipTtxCBmtsDewSUb3Yxf3JxseR7Yj6UTaeFpVad5gpd2yc5SpU6YU+5XzYMDDLZCF3/Rs79qJ/Rms/KlJQA1X9C1r11+l8IH7tTc3btI9mGinnPkFyGOkvatMc7TNFvbIx+RmYIIyXFJyCJCRPWXuLtm0llGJhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860837; c=relaxed/simple;
	bh=BsaiQBR7+aghcgAvorr6U09qtFoCVRXsyoXDRtpWr5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UzceLueMpj3pNZ6muqP5vPplgPYvxOwP8X4D7kXjz23wSAyoEDRrdct7l7j/KU/BGA9K2lPYjD9oxI1AxIHsuX5BnDjkZv+Kla5Eex5CI45y0LSsh05KnEBJ/ggo4BPHDoOCuw+w8DVwFg11+N87i4TvGJw8fubmF4fSs+zXGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Of/uO+lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ADC8C19423;
	Mon, 23 Feb 2026 15:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860837;
	bh=BsaiQBR7+aghcgAvorr6U09qtFoCVRXsyoXDRtpWr5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Of/uO+lt0CIRM8l33hHHhw03sq47brsVrI0GJ518a5Ep71eg6lecnNG8PZanb9Vlt
	 RBfIgvrNQQrsXJi7dkw5WgDWcX6A3/Cq0vDcxmAgEhVBgWwDgZ+8zHrTCtsS6czA5u
	 73ipF8fb1IFo3B6Uj60ogkn2vt7LDPkbYi6XvVWPH9WnuOziwhbg3AYf8OIOfIhcdk
	 9rxd9tqzTDwEgL/rqNw9FWsFAZMz7LJp0lQVZcZSORhbKksVbce77sBTLwV6VLEUXf
	 1cCOnALu/zb6iqO+UVqtOC4GRZpaYnsUjocoHVQiwMBxtHvTX38vfQx5tEnveu0GLA
	 bdZNQqmq+mdGA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 5/8] ACPI: PNP: Drop CMOS RTC PNP device support
Date: Mon, 23 Feb 2026 16:31:03 +0100
Message-ID: <3411834.aeNJFYEL58@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21055-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 613DF178D63
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

A previous change updated is_cmos_rtc_device() to effectively never
allow PNP devices to be created for the CMOS RTC on x86 with ACPI
and the PNP bus type is only used on x86, so the CMOS RTC device IDs
can be dropped from acpi_pnp_device_ids[] and is_cmos_rtc_device() can
go away completely.

Update the code accordingly.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pnp.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 4ad8f56d1a5d..da886923b008 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -125,10 +125,6 @@ static const struct acpi_device_id acpi_pnp_device_ids[] = {
 	{"PNP0401"},		/* ECP Printer Port */
 	/* apple-gmux */
 	{"APP000B"},
-	/* rtc_cmos */
-	{"PNP0b00"},
-	{"PNP0b01"},
-	{"PNP0b02"},
 	/* c6xdigio */
 	{"PNP0400"},		/* Standard LPT Printer Port */
 	{"PNP0401"},		/* ECP Printer Port */
@@ -355,25 +351,9 @@ static struct acpi_scan_handler acpi_pnp_handler = {
 	.attach = acpi_pnp_attach,
 };
 
-/*
- * For CMOS RTC devices, the PNP ACPI scan handler does not work, because
- * there is a CMOS RTC ACPI scan handler installed already, so we need to
- * check those devices and enumerate them to the PNP bus directly.
- */
-static int is_cmos_rtc_device(struct acpi_device *adev)
-{
-	static const struct acpi_device_id ids[] = {
-		{ "PNP0B00" },
-		{ "PNP0B01" },
-		{ "PNP0B02" },
-		{""},
-	};
-	return !cmos_rtc_platform_device_present && !acpi_match_device_ids(adev, ids);
-}
-
 bool acpi_is_pnp_device(struct acpi_device *adev)
 {
-	return adev->handler == &acpi_pnp_handler || is_cmos_rtc_device(adev);
+	return adev->handler == &acpi_pnp_handler;
 }
 EXPORT_SYMBOL_GPL(acpi_is_pnp_device);
 
-- 
2.51.0





