Return-Path: <linux-acpi+bounces-21349-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKAzNvt+qGmYvAAAu9opvQ
	(envelope-from <linux-acpi+bounces-21349-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:50:35 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7AA0206A47
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AAD193032D5B
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4A03D301B;
	Wed,  4 Mar 2026 18:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL6sVOwx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DC83D75C5;
	Wed,  4 Mar 2026 18:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649996; cv=none; b=W/zWA1eTlc2fB3Thr+Hw6elQ7inSDGH8NKn3bCYCr+aOyyQ1ZnwJFZJHQrRnsKY/6wKz7QD8c7y79uqg8224W/q8/7SscVHBqlLxoKO7UUyyGScWQcDD6XoxrMMEeHiv080QQsQvHiWZP+4Z5F8jO8TK9cFOqWmnUdyYMF033iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649996; c=relaxed/simple;
	bh=Zzg0bOZHWxlJWNWw5GOGW2tm/fvqitcMJCaOKp1J/44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lfi2R4YsEpKC7oLTPYaZZzX2WMW8JQRsW7afpiKMKTQaglvPizv0YNtmkC6Yjz04nuehREdU2hFbDzT0xzJlA6FzAEtjeziBcaiBzSmDTnXbHHPf9JKzJWCWmq6anoAm+KQp5LJG36C/4ITnhbF5BEwkCe/VszpHpKJAeaRDSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL6sVOwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEF0C2BC9E;
	Wed,  4 Mar 2026 18:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649996;
	bh=Zzg0bOZHWxlJWNWw5GOGW2tm/fvqitcMJCaOKp1J/44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vL6sVOwxXg3I4ohjCPGYP6qpI6DUXRkLIjrpV8rorJdzt0Ed2ea4g/MPZhe7cqQGD
	 PNa3I+DGQ9F6oC4Y7bA3u9IxAC7x31ya0fzGexmxLYpNTm1HzswhQhtrL4DDu+eRsE
	 HjuEkJRcSk7rJJlc/pBgHYPSKMA+ds3I+D21E78BF7SGIF7KSa8hHdvLjbkwj/NO+f
	 03iG4oB9Z1z2ACrsdwWjSfCUehlQr54dvQ+pOiwcDjSe1ob/3few5v6CVKdpNVfRC6
	 xwpQQCej6Cro7I4cUPDCNDfOv8bZGAu+Sj7i0kYZBEyUU6pb/WRN2+wD28rn6+PXQp
	 YHInbzUynKSAQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: chrome-platform@lists.linux.dev
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject:
 [PATCH v1 3/6] platform/chrome: chromeos_tbmc: Register ACPI notify handler
Date: Wed, 04 Mar 2026 19:43:44 +0100
Message-ID: <2277362.Icojqenx9y@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
References: <2274474.Mh6RI2rZIc@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E7AA0206A47
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21349-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/chrome/chromeos_tbmc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index e248567c0a18..9c988e697d09 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -45,8 +45,10 @@ static __maybe_unused int chromeos_tbmc_resume(struct device *dev)
 	return chromeos_tbmc_query_switch(adev, adev->driver_data);
 }
 
-static void chromeos_tbmc_notify(struct acpi_device *adev, u32 event)
+static void chromeos_tbmc_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *adev = data;
+
 	acpi_pm_wakeup_event(&adev->dev);
 	switch (event) {
 	case 0x80:
@@ -92,11 +94,22 @@ static int chromeos_tbmc_add(struct acpi_device *adev)
 		return ret;
 	}
 	device_init_wakeup(dev, true);
+
+	ret = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+					      chromeos_tbmc_notify, adev);
+	if (ret) {
+		dev_err(dev, "cannot install ACPI notify handler\n");
+		device_init_wakeup(dev, false);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void chromeos_tbmc_remove(struct acpi_device *adev)
 {
+	acpi_dev_remove_notify_handler(adev, ACPI_DEVICE_NOTIFY,
+				       chromeos_tbmc_notify);
 	device_init_wakeup(&adev->dev, false);
 }
 
@@ -116,7 +129,6 @@ static struct acpi_driver chromeos_tbmc_driver = {
 	.ops = {
 		.add = chromeos_tbmc_add,
 		.remove = chromeos_tbmc_remove,
-		.notify = chromeos_tbmc_notify,
 	},
 	.drv.pm = &chromeos_tbmc_pm_ops,
 };
-- 
2.51.0





