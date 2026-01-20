Return-Path: <linux-acpi+bounces-20473-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGjjH9myb2nHMAAAu9opvQ
	(envelope-from <linux-acpi+bounces-20473-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:52:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D4F47FEF
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 17:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 46B5C8052E4
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Jan 2026 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6D643E9E1;
	Tue, 20 Jan 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XC9Ek4+i"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD0343E9D1;
	Tue, 20 Jan 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923910; cv=none; b=s3oVnf06V3qqk79l+H+yGhI3Li93KVGqV1vTEZ+DJayQIrZ60TaijJk9XUULebX4ez9+66+BSDUcujruAQOVxVc37q6fH5YDErb9GIPO8UiBxx0uAvg3ngL9XsG3xIqUN8PYnI/21EviC3EDfnL6bwMm9lxSFY1epftGcWdZ67U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923910; c=relaxed/simple;
	bh=zYqnFW/CLiGr0H6c7/xe0iWrLitk+h7B2gXsWzlbw4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ph7WIY/ZzvxCo9w3cUPUMWPA3i40n0Qpi7x8H6tPnI8sELA9ayTWFAuy0G3Vbk8sI59TNqNMPauB+BXqrGi+/msVnPjvAeQbijTWCWyID9rt7H9oDv1+/Ih1bjlWZszbwJPlHu++Xyyp0sqv13db5ZkgQ/yhrzkody/c4uDu47I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XC9Ek4+i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0173C16AAE;
	Tue, 20 Jan 2026 15:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768923909;
	bh=zYqnFW/CLiGr0H6c7/xe0iWrLitk+h7B2gXsWzlbw4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XC9Ek4+ils0lYUlIdnxpXQuJyNC0jM8WE3jG06Qx8uQEOzMi8UVv6I2GSM5t4Nh8u
	 OeSoKae3Gz+XN56IjzBH92mncAJ2CwuHLdQuUG79lQyfR9+GvRtJpiTu/V2AEyJElS
	 Fj+omA71AJD7pCiBo97dnKA1BDnNqSu8ToX/3CsErTHQ4LLuF0uf4Qp4naUmuQeo/e
	 +9O6dbk76XZlxAzes8GSEZznQJ42ZQyf1k28h26CLMxHi5Ykh4VqinrQnCLYwskkmT
	 entvwHIGx05iN9v50S/ZJ+M/Kf+/k1K332/oyF/2XcqrrRWyhgTBM7+ZrlQ6SFN3dX
	 yYqoy/AHm0uww==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Kenneth Chan <kenneth.t.chan@gmail.com>, platform-driver-x86@vger.kernel.org,
 Azael Avalos <coproscefalo@gmail.com>,
 Matthew Garrett <matthew.garrett@nebula.com>
Subject:
 [PATCH v1 1/2] platform/x86: panasonic-laptop: Fix sysfs group leak in error
 path
Date: Tue, 20 Jan 2026 16:43:44 +0100
Message-ID: <3398370.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <3026924.e9J7NaK4W3@rafael.j.wysocki>
References: <3026924.e9J7NaK4W3@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,nebula.com];
	TAGGED_FROM(0.00)[bounces-20473-lists,linux-acpi=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,rafael.j.wysocki:mid]
X-Rspamd-Queue-Id: 22D4F47FEF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The acpi_pcc_hotkey_add() error path leaks sysfs group pcc_attr_group
if platform_device_register_simple() fails for the "panasonic" platform
device.

Address this by making it call sysfs_remove_group() in that case for
the group in question.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/panasonic-laptop.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/platform/x86/panasonic-laptop.c
+++ b/drivers/platform/x86/panasonic-laptop.c
@@ -1089,7 +1089,7 @@ static int acpi_pcc_hotkey_add(struct ac
 			PLATFORM_DEVID_NONE, NULL, 0);
 		if (IS_ERR(pcc->platform)) {
 			result = PTR_ERR(pcc->platform);
-			goto out_backlight;
+			goto out_sysfs;
 		}
 		result = device_create_file(&pcc->platform->dev,
 			&dev_attr_cdpower);
@@ -1105,6 +1105,8 @@ static int acpi_pcc_hotkey_add(struct ac
 
 out_platform:
 	platform_device_unregister(pcc->platform);
+out_sysfs:
+	sysfs_remove_group(&device->dev.kobj, &pcc_attr_group);
 out_backlight:
 	backlight_device_unregister(pcc->backlight);
 out_input:




