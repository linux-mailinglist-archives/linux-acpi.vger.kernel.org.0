Return-Path: <linux-acpi+bounces-20953-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMdSBUXVjWlY7wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20953-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:27:33 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C2512DCBF
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 144CC30320E4
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2AC35C1A1;
	Thu, 12 Feb 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZhO8slt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0AD35B64D;
	Thu, 12 Feb 2026 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770902818; cv=none; b=CCdE1iwerB4EPrcLW07uIWJTWl6mjW1bWIfKUk430nvQzBG1ixmd7UuaffikwAdLnTBVJD7QMk5vmaoAV/9nyIRv/k0F++6/r9xfPvDWuSm3tBauQyazTNdiKYZC1MI+zyjOh0GhTrTM3lKOqdAoiU6o6y3qq/PDyA/i4vspc/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770902818; c=relaxed/simple;
	bh=BVbP9tjJ1eaIzs3O82dTv5Bx+kr/3kmkpoFA1alma8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nGmfEkPBfUsuZicYpJ5O4XbtwtQ+GeeHdyv6nDVODATLku18QXvOjFud62NpVbxhpodMtBkKjXZlLDjNd0IOK0oYt0NBaSmnbfYBlk0JbP/62Ub0qk+5z5wjL3avBEEuMxChcnl0ItJymHHdBD3pB36pt3HcP97poLHRH7pZxCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZhO8slt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1DDC19422;
	Thu, 12 Feb 2026 13:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770902818;
	bh=BVbP9tjJ1eaIzs3O82dTv5Bx+kr/3kmkpoFA1alma8c=;
	h=From:To:Cc:Subject:Date:From;
	b=GZhO8sltiqLo/OLIFgp3M3F9gqvMtiBUH0wdrbZjEmN2BSadcKTTLptXIm8YHhU6/
	 vA+2ElMDOTARCeyCYSzo/Flkm7gNYw/cLtoWGM53eFq534+TJJIOXQlqH/Q4PEx8QY
	 Yp7RSTKRbg9HkVDj/jlsaIUYAVH7gb8muSR3aoKXxzUQgJWhOb8879uN9L7NqKTSsE
	 WjTVKkjJ6GFDw1rLkFwqlwKJowoX/wFJHP2P9Msu8GuzhDe9EylWLR+XmwpxQpYsJT
	 EHS18RsKZOOsfAZ0Qe6SbvfuAOFqXMd+YKI9KvTot5AxZW5RSSXsuj7ZOYM7nD/3//
	 7oxuRPphbGVew==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1] ACPI: battery: Drop redundant checks from acpi_battery_remove()
Date: Thu, 12 Feb 2026 14:26:54 +0100
Message-ID: <12836976.O9o76ZdvQC@rafael.j.wysocki>
Organization: Linux Kernel Development
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20953-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 26C2512DCBF
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In acpi_battery_remove(), "battery" cannot be NULL because it is the
driver data of the platform device passed to that function and it has
been set by acpi_battery_probe(), so drop the redundant check of it
against NULL.

Moreover, getting the ACPI device pointer from battery->device is
slightly less overhead than using the ACPI_COMPANION() macro on the
platform device to retrieve it, so do that and drop the check of that
pointer against NULL which is also redundant.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of

https://web.git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=abbdf22e0a8f23207cedf9065512620971794ff5

---
 drivers/acpi/battery.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -1271,13 +1271,9 @@ fail:
 
 static void acpi_battery_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_battery *battery = platform_get_drvdata(pdev);
 
-	if (!device || !battery)
-		return;
-
-	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
+	acpi_dev_remove_notify_handler(battery->device, ACPI_ALL_NOTIFY,
 				       acpi_battery_notify);
 
 	device_init_wakeup(&pdev->dev, false);




