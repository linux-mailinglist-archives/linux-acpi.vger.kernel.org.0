Return-Path: <linux-acpi+bounces-21057-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOCpHMtznGnuHgQAu9opvQ
	(envelope-from <linux-acpi+bounces-21057-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:35:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98821178CD7
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 16:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 202EE303E309
	for <lists+linux-acpi@lfdr.de>; Mon, 23 Feb 2026 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54802F5321;
	Mon, 23 Feb 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a831mw6W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD72EDD7D;
	Mon, 23 Feb 2026 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771860844; cv=none; b=GJtM6yAeGQ+xDQZ3CJp/+NKoLou3VGznJobHVjbEfaXJzC+lTJk61alD2ijJ7yUdYe9uFgE+/kBZqUfC6THqwR3oGWWSJTGmHZCYcrpp3/oNbiEWPr1dung6JpId3q2EoI257fGkUhNyNqxpwD0ZAxg9djvX+3MJSayEJ9e75M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771860844; c=relaxed/simple;
	bh=1P6a0/lYu7VTCktfcaeO7oH0q+boqRyuVN3mhuLyv+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kgBys7D1llGht0zoPp/HCSEpG9v+OjpIvDX8oFju4/nZN+uSKZ0Y2kQ89uSNr0K5ShjkdrUuZOTZXzy3QsFCwMsS78WF2PGX/xraee/Nyh22VVfAjrFx/VOFpLSKHE7HBI5QnF552d7bdz6Zg/44siRorXFAJkLbRfKOnpsvjU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a831mw6W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EF5C116C6;
	Mon, 23 Feb 2026 15:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771860844;
	bh=1P6a0/lYu7VTCktfcaeO7oH0q+boqRyuVN3mhuLyv+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a831mw6WaD/pMWsKssEfBVdLc/R1uo593RErJsmy8AvGBcIUd4Bc4guKmGHu5JE3o
	 gRhOXb9jOiBMvYNIwbbwD8t6//0xfoxPMr8PInGHbdOHG/bsHG7jrxiiwUJbaJPmKb
	 fDcOcwD8bau0YVyBq6crCmGTMBjf8P6L1MtjttlNDH2uVqDeErq1tOPfzM13JTmcrl
	 B9q/1qW3jn9LgJT52NpJ/qo5DYzDTSkkCx1MbyT5kyjWSlFftNnNOtKW5gpjIueYXS
	 scOwmGqmTrx0evx3oY1mOt1zWyCYj9QkgDkfkKhz1g5q71j0CVMXgthbPg//OWBiOY
	 CFzPxZ5fVtA5g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86 Maintainers <x86@kernel.org>,
 linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v1 3/8] ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
Date: Mon, 23 Feb 2026 16:29:37 +0100
Message-ID: <1962427.tdWV9SEqCh@rafael.j.wysocki>
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
	TAGGED_FROM(0.00)[bounces-21057-lists,linux-acpi=lfdr.de];
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
X-Rspamd-Queue-Id: 98821178CD7
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Make the CMOS RTC ACPI scan handler create a platform device that will
be used subsequently by rtc-cmos for driver binding on x86 systems with
ACPI and update add_rtc_cmos() to skip registering a fallback platform
device for the CMOS RTC when the above one has been registered.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 arch/x86/kernel/rtc.c       | 4 ++++
 drivers/acpi/x86/cmos_rtc.c | 8 ++++++++
 include/linux/acpi.h        | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index 51a849a79c98..b112178e8185 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -2,6 +2,7 @@
 /*
  * RTC related functions
  */
+#include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/mc146818rtc.h>
 #include <linux/export.h>
@@ -146,6 +147,9 @@ static __init int add_rtc_cmos(void)
 		}
 	}
 #endif
+	if (cmos_rtc_platform_device_present)
+		return 0;
+
 	if (!x86_platform.legacy.rtc)
 		return -ENODEV;
 
diff --git a/drivers/acpi/x86/cmos_rtc.c b/drivers/acpi/x86/cmos_rtc.c
index 45db7e51cbe6..bdd66dfd4a44 100644
--- a/drivers/acpi/x86/cmos_rtc.c
+++ b/drivers/acpi/x86/cmos_rtc.c
@@ -24,6 +24,8 @@ static const struct acpi_device_id acpi_cmos_rtc_ids[] = {
 	{}
 };
 
+bool cmos_rtc_platform_device_present;
+
 static bool cmos_rtc_space_handler_present __read_mostly;
 
 static acpi_status acpi_cmos_rtc_space_handler(u32 function,
@@ -103,6 +105,12 @@ static int acpi_cmos_rtc_attach(struct acpi_device *adev,
 	if (ret < 0)
 		return ret;
 
+	if (IS_ERR_OR_NULL(acpi_create_platform_device(adev, NULL))) {
+		pr_err("Failed to create CMOS-RTC platform device\n");
+		return 0;
+	} else {
+		cmos_rtc_platform_device_present = true;
+	}
 	return 1;
 }
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4d2f0bed7a06..2bdb801cee01 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -791,6 +791,8 @@ const char *acpi_get_subsystem_id(acpi_handle handle);
 int acpi_mrrm_max_mem_region(void);
 #endif
 
+extern bool cmos_rtc_platform_device_present;
+
 #else	/* !CONFIG_ACPI */
 
 #define acpi_disabled 1
@@ -1116,6 +1118,8 @@ static inline int acpi_mrrm_max_mem_region(void)
 	return 1;
 }
 
+#define cmos_rtc_platform_device_present	false
+
 #endif	/* !CONFIG_ACPI */
 
 #ifdef CONFIG_ACPI_HMAT
-- 
2.51.0





