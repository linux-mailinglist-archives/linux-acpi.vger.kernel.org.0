Return-Path: <linux-acpi+bounces-21339-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HZEIZN6qGl0uwAAu9opvQ
	(envelope-from <linux-acpi+bounces-21339-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:31:47 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62920661D
	for <lists+linux-acpi@lfdr.de>; Wed, 04 Mar 2026 19:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD33230927D6
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2026 18:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588CE3DBD4D;
	Wed,  4 Mar 2026 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0JH/C8N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349E63DBD41;
	Wed,  4 Mar 2026 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648240; cv=none; b=tDLJcrwTnkPR14Gtksq4sHVgiPoTnUAVZgGswupd7kDf2djKFBCRUDRDBHSMcsn/q+eYBfFPpOASFPNNqhMPAZvQnsEYbvTqPO/99wX+i85b1thzImORa+mtxXEyAPeJuox9N3WCiOuxbkYbEnN9t6jts+qCHrMClloL/08MVxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648240; c=relaxed/simple;
	bh=uWlpGK9U3ouo4G9mwInsFbZUkz8j38CHepOPXEu5dkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YNm3c5k7f8ttb666JcXEvnYhU064/7CY+5IBLsEetr+ljOuK0bgUp2YgPJ4jwmbnJwzuPxCv0Q161zxa3IRDvA7AFZe+japUEsobDAC0q5Gu227MkeezBmkLWfenTMtlXJ+X8YGXx+DvPvB9eZfgyptJRBLamlmXcGKJAQj/2Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0JH/C8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB65C4CEF7;
	Wed,  4 Mar 2026 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772648239;
	bh=uWlpGK9U3ouo4G9mwInsFbZUkz8j38CHepOPXEu5dkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n0JH/C8Nn8KhpahHKdbZMs5IFC2Gc/mQPUYhsh+l669Otjn0OCbddNSY5JeqA/ejR
	 IvHXhXbq4/pg/nNkNYFWZyN0qNN4a0fB4hAnQ+Cdsi8l2A9Xv7U4bwPq14OtQZbnKT
	 H4Us/xq8xZZKTtqr2OtDnn3HCJ1Layt84JFxzQ4iyJliN+fDJbSPXSDnT5nPMOQk7T
	 v1H3KeUEmtf9DhK8AH60DPXxkEAEa6iDm60seZ5exT34uNK8UKddE4qVR0my9XDVSb
	 AxnBKXFk7N+U3drRl1bymYXQ/kIk2NgP6cZTztbSuH6GrMG79SAlym6KwqGiG1Srar
	 Q462xM7yqlKeg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, linux-rtc@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v1 2/7] ACPI: TAD: Support RTC without wakeup
Date: Wed, 04 Mar 2026 19:13:15 +0100
Message-ID: <1959268.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5092662.31r3eYUQgx@rafael.j.wysocki>
References: <5092662.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8B62920661D
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
	TAGGED_FROM(0.00)[bounces-21339-lists,linux-acpi=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,rafael.j.wysocki:mid]
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI TAD can provide a functional RTC without wakeup capabilities,
so stop failing probe if AC wakeup is not supported.

Also, if _PRW is missing, do not fail probe, but clear the wakeup bits
in capabilities.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/acpi_tad.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/acpi/acpi_tad.c
+++ b/drivers/acpi/acpi_tad.c
@@ -546,8 +546,9 @@ static umode_t acpi_tad_attr_is_visible(
 	if (a == &dev_attr_caps.attr)
 		return a->mode;
 
-	if (a == &dev_attr_ac_alarm.attr || a == &dev_attr_ac_policy.attr ||
-	    a == &dev_attr_ac_status.attr)
+	if ((dd->capabilities & ACPI_TAD_AC_WAKE) &&
+	    (a == &dev_attr_ac_alarm.attr || a == &dev_attr_ac_policy.attr ||
+	     a == &dev_attr_ac_status.attr))
 		return a->mode;
 
 	if ((dd->capabilities & ACPI_TAD_DC_WAKE) &&
@@ -581,8 +582,10 @@ static void acpi_tad_remove(struct platf
 	sysfs_remove_group(&dev->kobj, &acpi_tad_attr_group);
 
 	scoped_guard(pm_runtime_noresume, dev) {
-		acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
-		acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+		if (dd->capabilities & ACPI_TAD_AC_WAKE) {
+			acpi_tad_disable_timer(dev, ACPI_TAD_AC_TIMER);
+			acpi_tad_clear_status(dev, ACPI_TAD_AC_TIMER);
+		}
 		if (dd->capabilities & ACPI_TAD_DC_WAKE) {
 			acpi_tad_disable_timer(dev, ACPI_TAD_DC_TIMER);
 			acpi_tad_clear_status(dev, ACPI_TAD_DC_TIMER);
@@ -612,14 +615,9 @@ static int acpi_tad_probe(struct platfor
 		return -ENODEV;
 	}
 
-	if (!(caps & ACPI_TAD_AC_WAKE)) {
-		dev_info(dev, "Unsupported capabilities\n");
-		return -ENODEV;
-	}
-
 	if (!acpi_has_method(handle, "_PRW")) {
 		dev_info(dev, "Missing _PRW\n");
-		return -ENODEV;
+		caps &= ~(ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE);
 	}
 
 	dd = devm_kzalloc(dev, sizeof(*dd), GFP_KERNEL);
@@ -635,9 +633,11 @@ static int acpi_tad_probe(struct platfor
 	 * runtime suspend.  Everything else should be taken care of by the ACPI
 	 * PM domain callbacks.
 	 */
-	device_init_wakeup(dev, true);
-	dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
-				     DPM_FLAG_MAY_SKIP_RESUME);
+	if (ACPI_TAD_AC_WAKE | ACPI_TAD_DC_WAKE) {
+		device_init_wakeup(dev, true);
+		dev_pm_set_driver_flags(dev, DPM_FLAG_SMART_SUSPEND |
+					     DPM_FLAG_MAY_SKIP_RESUME);
+	}
 
 	/*
 	 * The platform bus type layer tells the ACPI PM domain powers up the




