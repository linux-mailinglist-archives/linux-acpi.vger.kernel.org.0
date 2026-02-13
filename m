Return-Path: <linux-acpi+bounces-20980-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8EoCO/Bsj2mNQwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20980-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 19:26:56 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243C5138EA0
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 19:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4881F3003802
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Feb 2026 18:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F01027A904;
	Fri, 13 Feb 2026 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cDWe5rIO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEED3EBF34;
	Fri, 13 Feb 2026 18:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771007212; cv=none; b=cmc5/HyTfcQJ9VJOtz1b1Kp85idPaKwtuugcaEjRl9ns5dnpxEobzxSEsH/FUx38GQa0QMztT0HpCH84515CGBL37GdlqcK1XUn3dZKsPppojvdAE82FaK0uQ+TTMQfK/qHHMVvJ0tiyuXMOcGLi5a2FYeB53Pk8W6VerQR13h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771007212; c=relaxed/simple;
	bh=LhWQeJ5UHFUjtOBx++pMgeujWlK/vtYqU+pzDyFBVyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FbkQ++wgxHoGqKxDe8hYICridTpvvOoaL401TJuxWQM+qoKERg+nwqzBBTKLNg4gbd3X5TZ1sgTfCKIcaD44Ut9390gz85zIo4hQuRRx4JXgy8a9qhCBKMWWvSPr0ajBsofeqIcv8jQQilkIB6SoZuuV70kDHuDbkEsQ7Qqoxec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cDWe5rIO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BE5C19425;
	Fri, 13 Feb 2026 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771007211;
	bh=LhWQeJ5UHFUjtOBx++pMgeujWlK/vtYqU+pzDyFBVyU=;
	h=From:To:Cc:Subject:Date:From;
	b=cDWe5rIOA+jQUiwKGBvdvg+tw6Ovl5RNwfXPnJmWzTSEWy+DdbGdtZo+mku+2x1PD
	 TIIJ4rn9bykuipcwmSaOc+NWahIsrsIwz2E0ZZ3UkT58JrIm6pK03HzmhDdIQBvvsi
	 17TBAVRbdZMkrpvbKl4jozWosvm8OZQug8eDjqg8qjYHWcJH1qGxPGi7jXci4DM14o
	 FLdc6NqSEPK30Ub+RKkWHC/9YmSr+Kd1KtKV6T921Ed87rVrUDGdJdClwmF7MZNTMU
	 /+rJfKRlRR7ule999AI1ZHjhg8VnFl0Y4d1rRa9bYl0atfTQrjrLucG1R10ywo7qZ+
	 psw2BqtUMedhQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject:
 [PATCH v1] ACPI: driver: Drop driver_data pointer clearing from two drivers
Date: Fri, 13 Feb 2026 19:26:48 +0100
Message-ID: <6242843.lOV4Wx5bFT@rafael.j.wysocki>
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
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-20980-lists,linux-acpi=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 243C5138EA0
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

It is not necessary to clear the driver_data pointer in the ACPI
companion device object on driver remove in the EC and SMBUS HC
ACPI drivers because that pointer is not used there any more after
recent changes.

Drop the unnecessary statements.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of the current mainline.

---
 drivers/acpi/ec.c    |    2 --
 drivers/acpi/sbshc.c |    2 --
 2 files changed, 4 deletions(-)

--- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1754,12 +1754,10 @@ err:
 
 static void acpi_ec_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_ec *ec = platform_get_drvdata(pdev);
 
 	release_region(ec->data_addr, 1);
 	release_region(ec->command_addr, 1);
-	device->driver_data = NULL;
 	if (ec != boot_ec) {
 		ec_remove_handlers(ec);
 		acpi_ec_free(ec);
--- a/drivers/acpi/sbshc.c
+++ b/drivers/acpi/sbshc.c
@@ -275,13 +275,11 @@ static int acpi_smbus_hc_probe(struct pl
 
 static void acpi_smbus_hc_remove(struct platform_device *pdev)
 {
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
 	struct acpi_smb_hc *hc = platform_get_drvdata(pdev);
 
 	acpi_ec_remove_query_handler(hc->ec, hc->query_bit);
 	acpi_os_wait_events_complete();
 	kfree(hc);
-	device->driver_data = NULL;
 }
 
 module_platform_driver(acpi_smb_hc_driver);




