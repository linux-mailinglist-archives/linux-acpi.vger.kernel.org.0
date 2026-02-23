Return-Path: <linux-acpi+bounces-21056-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEBJIrpznGmcGAQAu9opvQ
	(envelope-from <linux-acpi+bounces-21056-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:35:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C425C178CB7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D76AE302CC27
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BC2F28E3;
	Mon, 23 Feb 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNPA5X4v"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6562EAB72;
	Mon, 23 Feb 2026 15:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860841; cv=none; b=AQ8aVj26AkoXP4qfDNzutsMR+OCdUVixXqmw+Nrjwk4FnX/tt4sZpfc+q3c0riuVZ4rZDRkJBoh31plf36CxdnyXAvjKUTjjXXHCDSBvyaxjLZWGs+O5YN1RfjWSd8u77ZcW3fd8UTX6IIwaiTt0p5K+OWKwg8av5o9r1YTe59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860841; c=relaxed/simple;
	bh=PJVMTnYCsK7M4ZNWVcZ9K240qBRGEtoibgHHQw8BGpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qEYUyXyfWrh25nh6FRe/aUC3ioqurFsw18HGm3Fm8je839lh06I2fijmqyzNFP1NRFTL+haVuxgNh2jcL51RUZsCDxK4dcFuScCIKOB5ATPYfyyiD62Bbfk15radPVtpoImBpTZbH/ZHB7IZjEBImvc4maryHEmzl7U42O6h6rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNPA5X4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3FE0C116D0;
	Mon, 23 Feb 2026 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860841;
	bh=PJVMTnYCsK7M4ZNWVcZ9K240qBRGEtoibgHHQw8BGpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tNPA5X4vDpDr7kJxf/auwK6iVSkzeoJ9CaIWppNW5jrols91b2ur8dVfBvN0yX2Hw
	 QYD91KocQFsTrlhER2kt1PaVtw3fThHmdJN6WSXf7w3Dy5GGg7RyqIPOn00/XZgE5Q
	 jheuImZVsXw2tjfbJnC90CuUtHw7DvMsPt27kxucCfTx7fSnhLW92LhR1KJ6X1p0nH
	 DPxZt4/hnqeKt3UwHEDFwjt6Qu4hiptsybRuUxkDor9xNyp039EjytrqiAQZb1JtDC
	 soZcBQO7FZ2kRsCVWFy4eyNgng29D+7tJOJs9qFYuFLXVPvR5QRaplCcycIkgCx9W1
	 1T28WgdCOmQ4Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject:
 [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for driver binding
Date: Mon, 23 Feb 2026 16:30:21 +0100
Message-ID: <13969123.uLZWGnKmhe@rafael.j.wysocki>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21056-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,rafael.j.wysocki:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C425C178CB7
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Modify the rtc-cmos driver to bind to a platform device on systems with
ACPI via acpi_match_table and advertise the CMOST RTC ACPI device IDs
for driver auto-loading.  Note that adding the requisite device IDs to
it and exposing them via MODULE_DEVICE_TABLE() is sufficient for this
purpose.

Since the ACPI device IDs in question are the same as for the CMOS RTC
ACPI scan handler, put them into a common header file and use the
definition from there in both places.

Additionally, to prevent a PNP device from being created for the CMOS
RTC if a platform one is present already, make is_cmos_rtc_device()
check cmos_rtc_platform_device_present introduced previously.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_pnp.c     |  2 +-
 drivers/acpi/x86/cmos_rtc.c |  5 +----
 drivers/rtc/rtc-cmos.c      | 10 ++++++++++
 include/linux/acpi.h        |  6 ++++++
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 85d9f78619a2..4ad8f56d1a5d 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -368,7 +368,7 @@ static int is_cmos_rtc_device(struct acpi_device *adev)
 		{ "PNP0B02" },
 		{""},
 	};
-	return !acpi_match_device_ids(adev, ids);
+	return !cmos_rtc_platform_device_present && !acpi_match_device_ids(adev, ids);
 }
 
 bool acpi_is_pnp_device(struct acpi_device *adev)
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index bdd66dfd4a44..a6df5b991c96 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -18,10 +18,7 @@
 #include "../internal.h"
 
 static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
-	{ "PNP0B00" },
-	{ "PNP0B01" },
-	{ "PNP0B02" },
-	{}
+	ACPI_CMOS_RTC_IDS
 };
 
 bool cmos_rtc_platform_device_present;
diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 0743c6acd6e2..7457f42fd6f0 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -27,6 +27,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -1476,6 +1477,14 @@ static __init void cmos_of_init(struct platform_device *pdev)
 #else
 static inline void cmos_of_init(struct platform_device *pdev) {}
 #endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
+	ACPI_CMOS_RTC_IDS
+};
+MODULE_DEVICE_TABLE(acpi, acpi_cmos_rtc_ids);
+#endif
+
 /*----------------------------------------------------------------*/
 
 /* Platform setup should have set up an RTC device, when PNP is
@@ -1530,6 +1539,7 @@ static struct platform_driver cmos_platform_driver = {
 		.name		= driver_name,
 		.pm		= &cmos_pm_ops,
 		.of_match_table = of_match_ptr(of_cmos_match),
+		.acpi_match_table = ACPI_PTR(acpi_cmos_rtc_ids),
 	}
 };
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2bdb801cee01..5ecdcdaf31aa 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -791,6 +791,12 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 int acpi_mrrm_max_mem_region(void);
 #endif
 
+#define ACPI_CMOS_RTC_IDS	\
+	{ "PNP0B00", },		\
+	{ "PNP0B01", },		\
+	{ "PNP0B02", },		\
+	{ "", }
+
 extern bool cmos_rtc_platform_device_present;
 
 #else	/* !CONFIG_ACPI */
-- 
2.51.0





