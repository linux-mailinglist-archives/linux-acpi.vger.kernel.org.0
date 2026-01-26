Return-Path: <linux-acpi+bounces-20633-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPOCLmvId2lOkwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20633-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:02:51 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FBD8CDA5
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 21:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85FCE3012EB2
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 20:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7D2980A8;
	Mon, 26 Jan 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+sdBwra"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B502877DE;
	Mon, 26 Jan 2026 20:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769457768; cv=none; b=IOcbeTIrY14eJmjgt3YBsL1xOwb7tTjy/iYypoSkfqddALe2/Kx9BmRlSnR7p4cPXAUIBlSNSFuxUbmTfjDzqoj3tT1cJzhLGbQFiBYQ8fm6RuM5wGpzoAQMseBVPUr/bTh4c0cw8gB51vgWg9zLszsU2r36/gE3ARUAjfkuULo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769457768; c=relaxed/simple;
	bh=5fqLQlXhvk90yVheQPNcqn5k2uzKmq/uNH6lFCiBPsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZXU9zLQ6eK8iFkzRRcJDnpWFwMGycjWrA0EaoXH+un0atlXPA2macl5oKsMPreOZ6iKfYWWEyr/A/oUFR2QTubptI0WR7EmyjL/ahe2GR/gbBeNERzpvTUL5LMJcMZtfIm5JJYBPv0cnzApKPmbDR+zxdzgEoSrZhIWVx7r5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+sdBwra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E575BC19422;
	Mon, 26 Jan 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769457767;
	bh=5fqLQlXhvk90yVheQPNcqn5k2uzKmq/uNH6lFCiBPsI=;
	h=From:To:Cc:Subject:Date:From;
	b=O+sdBwraC8HD+KXEA5FWwNpADSBtD+6w2ktPdtzyf2noc2LEyhK+GPVoUyqtegN++
	 RnCtXr5XTg1aEXlkVogIkxhGtcMiIQAIfJW90Afcpgs08jqJMiUM/Fmj8SY69x0ohf
	 fmEapzidUq56uouj2MTAljE63kxZbBx3jisbAjyGA52oprMu8Z5kBhBAw4xJw3GXQm
	 E5l0HymFpJnMftOBMOjE5JhJkXV83GY2+QmZz0Z7vWHLvJZTgAO9aeX7FR3TE/mksf
	 g3dXWwAnshyNd5Fwl0rW5O9QixLK53fVY6gjFwTJct3R6g7/GSH1NNZJ6I+f5jrl8R
	 RAK2JW92CzyxA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Hans de Goede <hansg@kernel.org>,
 Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, platform-driver-x86@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject:
 [PATCH v1] platform/x86: classmate-laptop: Add missing NULL pointer checks
Date: Mon, 26 Jan 2026 21:02:40 +0100
Message-ID: <12825381.O9o76ZdvQC@rafael.j.wysocki>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	CTE_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20633-lists,linux-acpi=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rafael.j.wysocki:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 08FBD8CDA5
X-Rspamd-Action: no action

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In a few places in the Classmate laptop driver, code using the accel
object may run before that object's address is stored in the driver
data of the input device using it.

For example, cmpc_accel_sensitivity_store_v4() is the "show" method
of cmpc_accel_sensitivity_attr_v4 which is added in cmpc_accel_add_v4(),
before calling dev_set_drvdata() for inputdev->dev.  If the sysfs
attribute is accessed prematurely, the dev_get_drvdata(&inputdev->dev)
call in in cmpc_accel_sensitivity_store_v4() returns NULL which
leads to a NULL pointer dereference going forward.

Moreover, sysfs attributes using the input device are added before
initializing that device by cmpc_add_acpi_notify_device() and if one
of them is accessed before running that function, a NULL pointer
dereference will occur.

For example, cmpc_accel_sensitivity_attr_v4 is added before calling
cmpc_add_acpi_notify_device() and if it is read prematurely, the
dev_get_drvdata(&acpi->dev) call in cmpc_accel_sensitivity_show_v4()
returns NULL which leads to a NULL pointer dereference going forward.

Fix this by adding NULL pointer checks in all of the relevant places.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/platform/x86/classmate-laptop.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/drivers/platform/x86/classmate-laptop.c
+++ b/drivers/platform/x86/classmate-laptop.c
@@ -207,7 +207,12 @@ static ssize_t cmpc_accel_sensitivity_sh
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sysfs_emit(buf, "%d\n", accel->sensitivity);
 }
@@ -224,7 +229,12 @@ static ssize_t cmpc_accel_sensitivity_st
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &sensitivity);
 	if (r)
@@ -256,7 +266,12 @@ static ssize_t cmpc_accel_g_select_show_
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sysfs_emit(buf, "%d\n", accel->g_select);
 }
@@ -273,7 +288,12 @@ static ssize_t cmpc_accel_g_select_store
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &g_select);
 	if (r)
@@ -302,6 +322,8 @@ static int cmpc_accel_open_v4(struct inp
 
 	acpi = to_acpi_device(input->dev.parent);
 	accel = dev_get_drvdata(&input->dev);
+	if (!accel)
+		return -ENXIO;
 
 	cmpc_accel_set_sensitivity_v4(acpi->handle, accel->sensitivity);
 	cmpc_accel_set_g_select_v4(acpi->handle, accel->g_select);
@@ -549,7 +571,12 @@ static ssize_t cmpc_accel_sensitivity_sh
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	return sysfs_emit(buf, "%d\n", accel->sensitivity);
 }
@@ -566,7 +593,12 @@ static ssize_t cmpc_accel_sensitivity_st
 
 	acpi = to_acpi_device(dev);
 	inputdev = dev_get_drvdata(&acpi->dev);
+	if (!inputdev)
+		return -ENXIO;
+
 	accel = dev_get_drvdata(&inputdev->dev);
+	if (!accel)
+		return -ENXIO;
 
 	r = kstrtoul(buf, 0, &sensitivity);
 	if (r)




