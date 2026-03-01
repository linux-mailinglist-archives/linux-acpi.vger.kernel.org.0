Return-Path: <linux-acpi+bounces-21287-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DJOGO48pGlnawUAu9opvQ
	(envelope-from <linux-acpi+bounces-21287-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:42 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D01EF1CFE1F
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87F61301BA5C
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 13:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21932AAA0;
	Sun,  1 Mar 2026 13:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/xQCccd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED032A3C8;
	Sun,  1 Mar 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371164; cv=none; b=mcgXSKGgOeIQr3CFpwiiS7Nc3QNjTqKSWdUkm42TdmoTYu9zIT14dmSnBVqpBwa+SbOJ65ppcf7GKSt6KJz/hYfWr6xFAeLs5REXSZwe85WT7Rwuvf0ckbTJIvMStLE4PrM8yagU4/sPC4ioP2sCI05qZ9P+pgbMjE0fVF7HAxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371164; c=relaxed/simple;
	bh=dKbSZWGkV+9YvBcXlPsY6rM8RsIlY+f96SCmMpS3KH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXGMFF+iZ+c4gI882+aA+wfDSgWvZ4TDnO7CAUqKQg6O7gy/A96pHOk2EGkrX0b6nyz9q8qkPPMdSHjaPJNeraAF7ruRGW5XRqXYeVefqFseAJwtLtkYyiFeu7CFOOIDFAr57vzusGacX1ON2BFwCMAI6a0Fa3EWvCYAB1LRS44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/xQCccd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66504C116C6;
	Sun,  1 Mar 2026 13:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371163;
	bh=dKbSZWGkV+9YvBcXlPsY6rM8RsIlY+f96SCmMpS3KH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T/xQCccdhf18cDC93RJdXFQKBHgBzSNsurLCp5NRTiEOC7BjQqYoAQaDZRPkXRRwE
	 2VP+cx9qOqaF/Vqo0CnkV6xI1vJOYNqTSeGG1tQbxHhg8Nx+PN6J8dG+97045pmNOc
	 7u54tQZFz6pU22L9ARdCY6J8AQ1dQkhlPkEi3fCNptX1LXTTLTR2AZh6DNnYs2YrXR
	 Kn8x+GAZx3lhssj2qgHutQD6ABbqTskhRBYesZ5MXLfs84yP5PUya5c1McjDOdUP1g
	 ECpBNH2Y+yZrSAZZ5QY/0J1G1RGku1bcmobK3H1horVVNwGH0NCdzf/VSEXPE/00xT
	 58wvq9hF2+hhg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-hwmon@vger.kernel.org
Subject:
 [PATCH v1 2/3] hwmon: (acpi_power_meter) Register ACPI notify handler
 directly
Date: Sun, 01 Mar 2026 14:18:05 +0100
Message-ID: <2405555.ElGaqSPkdT@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5974797.DvuYhMxLoT@rafael.j.wysocki>
References: <5974797.DvuYhMxLoT@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21287-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D01EF1CFE1F
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

To facilitate subsequent conversion of the driver to a platform one,
make it install an ACPI notify handler directly instead of using
a .notify() callback in struct acpi_driver.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/acpi_power_meter.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 49e57c20ef70..c010f55f7c7b 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -814,8 +814,9 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 }
 
 /* Handle ACPI event notifications */
-static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
+static void acpi_power_meter_notify(acpi_handle handle, u32 event, void *data)
 {
+	struct acpi_device *device = data;
 	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
 	int res;
 
@@ -936,9 +937,16 @@ static int acpi_power_meter_add(struct acpi_device *device)
 		goto exit_remove;
 	}
 
+	res = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
+					      acpi_power_meter_notify, device);
+	if (res)
+		goto exit_hwmon;
+
 	res = 0;
 	goto exit;
 
+exit_hwmon:
+	hwmon_device_unregister(resource->hwmon_dev);
 exit_remove:
 	remove_domain_devices(resource);
 exit_free_capability:
@@ -953,6 +961,9 @@ static void acpi_power_meter_remove(struct acpi_device *device)
 {
 	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
 
+	acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
+				       acpi_power_meter_notify);
+
 	if (!IS_ERR(resource->hwmon_dev))
 		hwmon_device_unregister(resource->hwmon_dev);
 
@@ -984,7 +995,6 @@ static struct acpi_driver acpi_power_meter_driver = {
 	.ops = {
 		.add = acpi_power_meter_add,
 		.remove = acpi_power_meter_remove,
-		.notify = acpi_power_meter_notify,
 		},
 	.drv.pm = pm_sleep_ptr(&acpi_power_meter_pm),
 };
-- 
2.51.0





