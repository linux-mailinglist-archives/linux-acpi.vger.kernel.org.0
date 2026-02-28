Return-Path: <linux-acpi+bounces-21260-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +OwPBvoJo2nY9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21260-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:30:02 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AD24C1C3F1A
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4CCDC30834F5
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A227747B41D;
	Sat, 28 Feb 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6H4tH7c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1AF4657E8;
	Sat, 28 Feb 2026 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292509; cv=none; b=ecz903ox6L5rbQ9adD/DySbUbZglFNP2DxYz73zqsAoSh+5wZxhrCoPs+Jpx5okwgJo9bXt6/bngh+u1eLXDZWE0pfY/8lwJTflLtt0M425FdPZwedjc0hglcXVhd59KynXobvrqOw3+W/kY88EpGSNKlgFxG7N8o8ER3uZFV2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292509; c=relaxed/simple;
	bh=PqsHVriJG2y4k84mt+nShq24fHU0P2YcBGu3dv7USAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HcoU4udTJ9rU7vp1KG4E9emR5bsC2020FFCFGl3uQHo4OmTmpoW6aVW+q2iqwDm+kwCHsSTI8MyMBKMruEmsR1iJVGIPu9Dnky01c9Znl+EL4kWV/wdRPA5fZaRrk+zFGhkNFo2I0RU6l78bRe+UONiTlSZOSPqtuqwvKq7VXpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6H4tH7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369B6C116D0;
	Sat, 28 Feb 2026 15:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292509;
	bh=PqsHVriJG2y4k84mt+nShq24fHU0P2YcBGu3dv7USAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s6H4tH7cZUWSjVIVACgjkBcjWJa7+0fa0RUDH3l+gEd7XNI2BP1ojeluIYEymfcQB
	 +71LBN2rXYkdEjrLRujhrl28RLp+arApH7w9CDupkJcSMD8ozxheCEYeToORtoJoq9
	 5uKOzjBYALeN9INkB7GmBvYN99UyNLoIOZZb4NQ2nnK84IymkgH1SYO8NIN1gFF+1r
	 VrOyJDmAu/JSuCQHQpCwCG1XbqFe/apnYSy+Apbq0XTk8B/SVKygr7l0F5fzW3nt4O
	 89tr0zfHY15lc3BOVLBBxh6Po6gM1DeW/2yKi00gmuWQHUnFx5SfrzGYRVWgvgXIUd
	 F93a61SPzt9QQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject:
 [PATCH v1 2/2] platform/x86: intel/smartconnect: Convert ACPI driver to a
 platform one
Date: Sat, 28 Feb 2026 16:28:19 +0100
Message-ID: <24282289.6Emhk5qWAg@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <8692017.NyiUUSuA9g@rafael.j.wysocki>
References: <8692017.NyiUUSuA9g@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21260-lists,linux-acpi=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: AD24C1C3F1A
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the Intel Smart Connect disabling ACPI
driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/intel/smartconnect.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/intel/smartconnect.c b/drivers/platform/x86/intel/smartconnect.c
index 31019a1a6d5e..4d866b6366d6 100644
--- a/drivers/platform/x86/intel/smartconnect.c
+++ b/drivers/platform/x86/intel/smartconnect.c
@@ -5,22 +5,24 @@
 
 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 
 MODULE_DESCRIPTION("Intel Smart Connect disabling driver");
 MODULE_LICENSE("GPL");
 
-static int smartconnect_acpi_init(struct acpi_device *acpi)
+static int smartconnect_acpi_probe(struct platform_device *pdev)
 {
+	acpi_handle handle = ACPI_HANDLE(&pdev->dev);
 	unsigned long long value;
 	acpi_status status;
 
-	status = acpi_evaluate_integer(acpi->handle, "GAOS", NULL, &value);
+	status = acpi_evaluate_integer(handle, "GAOS", NULL, &value);
 	if (ACPI_FAILURE(status))
 		return -EINVAL;
 
 	if (value & 0x1) {
-		dev_info(&acpi->dev, "Disabling Intel Smart Connect\n");
-		status = acpi_execute_simple_method(acpi->handle, "SAOS", 0);
+		dev_info(&pdev->dev, "Disabling Intel Smart Connect\n");
+		status = acpi_execute_simple_method(handle, "SAOS", 0);
 	}
 
 	return 0;
@@ -32,13 +34,12 @@ static const struct acpi_device_id smartconnect_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, smartconnect_ids);
 
-static struct acpi_driver smartconnect_driver = {
-	.name = "intel_smart_connect",
-	.class = "intel_smart_connect",
-	.ids = smartconnect_ids,
-	.ops = {
-		.add = smartconnect_acpi_init,
+static struct platform_driver smartconnect_driver = {
+	.probe = smartconnect_acpi_probe,
+	.driver = {
+		.name = "intel_smart_connect",
+		.acpi_match_table = smartconnect_ids,
 	},
 };
 
-module_acpi_driver(smartconnect_driver);
+module_platform_driver(smartconnect_driver);
-- 
2.51.0





