Return-Path: <linux-acpi+bounces-20954-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCFWHaHWjWng7wAAu9opvQ
	(envelope-from <linux-acpi+bounces-20954-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:33:21 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C18A812DD24
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 14:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEA9430869E9
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Feb 2026 13:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4019539F;
	Thu, 12 Feb 2026 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJl4LyWY"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F6748F;
	Thu, 12 Feb 2026 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770903198; cv=none; b=PFh2EKYE4gEAjqjlDKtoBsxgW3RcUGUd+3EiCfBlUn77JU4d/DEMAj+RiCl59SrQkswNM9n+ZAf4B22YShlsSfjwHxjRoiZ5ElsTPyvRvWDboONHXhZ/A2DPi2onfWtlFULkdB00SW7gRPvCKl8T2rKWcZ88l14PNI/kD9P90Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770903198; c=relaxed/simple;
	bh=+KpPuJAQPI6tZ+eexHuBI3ipLgn3veZf1J6uzjG5gqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e9Nhv8h2fmv3qKvoDQszcWiUqaxN270s9AYesL/654HFlb2NVDsPXPg2VwcBrcwWpIRZ5poJt47N+BFZSzP1iuPaEnkXLoANe0l7hbiGPVMt/JYcZbwbMKKAQ0NkZt8vUlogi2wajgkmleO/pul3SKX1x4CL24x3EInHIicGRcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJl4LyWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE82EC4CEF7;
	Thu, 12 Feb 2026 13:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770903197;
	bh=+KpPuJAQPI6tZ+eexHuBI3ipLgn3veZf1J6uzjG5gqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nJl4LyWYIqVPtliM4QSPNOAWfwv9D+x84iE7KRfc+wUW2hOvDFerWhBKDaLG1SCqh
	 nNkvjGBhiS70bXIds2pZHPNcihs2ma3wJtAU9YPSTb+fsK8Xu9NgCK0K1CIDHf9cM7
	 /YzUAvpZfsx69nSJt+1pxk3OQWxKEwbAqjYohHeNzxkoAnIzEJNILDrTYYU8D/66hd
	 fdj4GwkfIr+uvSjWjqEwugk5d0Hs2IOf6137Hx5Zb3Tndtez8uLQKg18UBfdRnEF9b
	 n5085QO5ttMmpEP0xLV6/6t2GAHaPn9Rp8Bk6r4RwS/meU9n0YL4wr6ZrNbjqvmLGE
	 O/x9w3+dXOuOw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 2/2] ACPI: button: Tweak acpi_button_remove()
Date: Thu, 12 Feb 2026 14:33:00 +0100
Message-ID: <13948466.uLZWGnKmhe@rafael.j.wysocki>
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
	TAGGED_FROM(0.00)[bounces-20954-lists,linux-acpi=lfdr.de];
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
X-Rspamd-Queue-Id: C18A812DD24
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify acpi_button_remove() to get the ACPI device object pointer
from button->adev instead of retrieving it with the help of the
ACPI_COMPANION() macro to reduce overhead slightly.

While at it, rename the struct acpi_device pointer variable in
acpi_button_remove() to adev.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/button.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -672,10 +672,10 @@ err_free_button:
 
 static void acpi_button_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_button *button = platform_get_drvdata(pdev);
+	struct acpi_device *adev = button->adev;
 
-	switch (device->device_type) {
+	switch (adev->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		acpi_remove_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
 						acpi_button_event);
@@ -685,7 +685,7 @@ static void acpi_button_remove(struct pl
 						acpi_button_event);
 		break;
 	default:
-		acpi_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
+		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
 						acpi_button_notify);




