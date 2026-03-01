Return-Path: <linux-acpi+bounces-21288-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH0gA/48pGlnawUAu9opvQ
	(envelope-from <linux-acpi+bounces-21288-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:58 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 411981CFE37
	for <lists+linux-acpi@lfdr.de>; Sun, 01 Mar 2026 14:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 151B73003815
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Mar 2026 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D6432AAA0;
	Sun,  1 Mar 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJKUFcYk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E812D97BA;
	Sun,  1 Mar 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371168; cv=none; b=seIzJHli+bcebmmeWSTkPl/8yFXlMcHU3jd8qGesO81fIPnxKxUnNNo9tF85FS0LKhRthRekj7dnBhUXo5BHPvUOm7vfauB0ozFS7nKCxY8gSaG1KFXP0qA6nY9gzQUD+DytGS/RNgoLKCqKorjWgt6UrCCvZgUdA5vp5cFfOIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371168; c=relaxed/simple;
	bh=PP4bpZpdIuvgF+e3wTm941JlTDMsXhgQul3e3sRZuMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkkBYUy9kxzUirjqZ1cv2+lUfFq0XqGw8agAninHUvqgQLtQ+MZetqPMgRtJNfy8p0iCzl21nLgw3I3PQS62NFl3obqnyEDt40mnk/tmY33GFXtJbvKhpYW5XXAAZFi0xSyM3xgsYz45GRDYd8f/6xgbpNwUZTi13Nn6AKCZEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJKUFcYk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4FFC19422;
	Sun,  1 Mar 2026 13:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371168;
	bh=PP4bpZpdIuvgF+e3wTm941JlTDMsXhgQul3e3sRZuMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oJKUFcYkggaA6whnNweZ+sTxVHy7yZtJczI/hdmsgs3e0UaTuvqfzu3aqQHOe3VRK
	 1Ml2ag9DSTQfCmiCgnrETOo7+A1TL3M20FqfPJMLKDbVnFLnbjSTbZ271APQDuT7Oo
	 oc+vSGkYFhucbngVwg3SgC8znXq/fUJAmL+jIb6Bqwm6DeNoITFPRLsr0qul9A1YdG
	 yCBJ1pbz1qQovhUnx/S4XuJ3O6b24mnst62qkYHWZPGj6kVl6Za75vqTQeuh43/0c6
	 mk1as3U76TFlQsw1wzHD7NJPagvakaHBWdmGTe1tymYDv2XtvnwEmSb1TCvCMWKhM5
	 p+HsnzXSk1mJQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jaroslav Pulchart <jaroslav.pulchart@gooddata.com>,
 LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>,
 linux-hwmon@vger.kernel.org
Subject:
 [PATCH v1 1/3] hwmon: (acpi_power_meter) Drop redundant checks from three
 functions
Date: Sun, 01 Mar 2026 14:17:19 +0100
Message-ID: <5085645.31r3eYUQgx@rafael.j.wysocki>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21288-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 411981CFE37
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Since acpi_power_meter_notify() and acpi_power_meter_remove() are
.notify() and .remove() callback functions of an ACPI driver,
respectively, the first argument of the former and the only argument
of the latter cannot be NULL.  Likewise, the acpi_power_meter_resume()
argument cannot be NULL because it is a system resume callback
function.

Moreover, since all of these functions can only run after
acpi_power_meter_add() has returned 0, the driver_data field in the
struct acpi_device object used by them cannot be NULL either.

Accordingly, drop the redundant "device" checks against NULL from
acpi_power_meter_notify() and acpi_power_meter_remove(), drop the
redundant "dev" check against NULL from acpi_power_meter_resume(),
and drop the redundant acpi_driver_data() checks against NULL from
all of these functions.

Additionally, combine the initialization of the "resource" local
variable in acpi_power_meter_notify() and acpi_power_meter_remove()
with its declaration.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/hwmon/acpi_power_meter.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 1e3fab5f7946..49e57c20ef70 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -816,14 +816,9 @@ static int read_capabilities(struct acpi_power_meter_resource *resource)
 /* Handle ACPI event notifications */
 static void acpi_power_meter_notify(struct acpi_device *device, u32 event)
 {
-	struct acpi_power_meter_resource *resource;
+	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
 	int res;
 
-	if (!device || !acpi_driver_data(device))
-		return;
-
-	resource = acpi_driver_data(device);
-
 	guard(mutex)(&acpi_notify_lock);
 
 	switch (event) {
@@ -956,12 +951,8 @@ static int acpi_power_meter_add(struct acpi_device *device)
 
 static void acpi_power_meter_remove(struct acpi_device *device)
 {
-	struct acpi_power_meter_resource *resource;
+	struct acpi_power_meter_resource *resource = acpi_driver_data(device);
 
-	if (!device || !acpi_driver_data(device))
-		return;
-
-	resource = acpi_driver_data(device);
 	if (!IS_ERR(resource->hwmon_dev))
 		hwmon_device_unregister(resource->hwmon_dev);
 
@@ -975,12 +966,7 @@ static int acpi_power_meter_resume(struct device *dev)
 {
 	struct acpi_power_meter_resource *resource;
 
-	if (!dev)
-		return -EINVAL;
-
 	resource = acpi_driver_data(to_acpi_device(dev));
-	if (!resource)
-		return -EINVAL;
 
 	free_capabilities(resource);
 	read_capabilities(resource);
-- 
2.51.0





