Return-Path: <linux-acpi+bounces-8334-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65BF697C456
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 08:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAB7F1F22B45
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Sep 2024 06:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA3318D63A;
	Thu, 19 Sep 2024 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OX+Bx7Xw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA36D7345B;
	Thu, 19 Sep 2024 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726727651; cv=none; b=EZSxmp4gyXnc1/+4280e0ihhPjRp4NvQZyBA8TEVEilbHpSCM/6AkznLgs0lD46+VaRXn5t6GrcdkPwIvAxwTrwgC3JmW+qAoDXKSy8N5hzk48w5Tt5WzPMtF4u6TYseekzL+vDuKgm4U0hEm/jtBigKJDKjR1niD4+oCHmdRMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726727651; c=relaxed/simple;
	bh=89cRcYvE1cRdyq3k7ZQ7ijDCs7yVlHDdxaRO+kFukN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1GJq79xC8gJxIJjAHqDJPhr4Dmq+EyfylcKhw0LNvfCga+WPi0MhoF+mO4MjNIn6CFZhzP3tdoVNbljH4dGLNfplIMOxl6HxxSagvvWoM59kNg/ea9Cw57zOaOIgP/6xqzkCMCIX3Ae5UgC9P5pzdTK+vWgthPusjQc0dEi3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OX+Bx7Xw; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726727630; x=1727332430; i=w_armin@gmx.de;
	bh=0TAOlCNSTaYIQfLLnbrxO4iE3HoqYpdFMBeupOI56GU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OX+Bx7XwpbV/fnwMJpHUaBV4RIa88HZu4ziHfsG/dwBgBG2cDOeknbn8Fll7BGat
	 VtuONILwv9kgRf9++OICv25LUYDlTRfXPerkRJLMqzMovXdF7q1svlQOh+wy+3lQD
	 vqAH9SbgKWaawKwkRPETDS6va2XofXF30oqZQFQxr76MpRO3wfoADLK5m3rmxPQPT
	 GD4Ah4UnQ+5QQfrBENsp3YZt0Wc2j1bUDAuF+ac93yuwm+Z/TczNx/vK6gJ8Jyatl
	 KdNOmov8V5Qy4kZQ0vc85ebDSrm6jzTb8H0Zf/glG+w9k9+0oMEd2k8O7csosWo5Y
	 JU/VA0U8tX9cbzc/rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mwwdf-1s1ZQ52O2F-00yNxW; Thu, 19 Sep 2024 08:33:50 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: mjg59@srcf.ucam.org,
	pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-laptop: Fix crash when unregistering battery hook
Date: Thu, 19 Sep 2024 08:33:32 +0200
Message-Id: <20240919063332.362201-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yNcooaYQb2R4h9fb1MmgCBjuE+BdHSrdZx/pB76/DldD36OLmx3
 FPqiJGbTU3MI/IflALFRwoV26RrvN3N89RvnW39rqRkCNz+BMdJ/qk+aKx43rUrpcyVRSUZ
 O8WtuqhGpGTwVmHP9CJ3thdDBdN4uFXEhCTpGkC5XouvkQyD4+MFVKGbrb3ivPk6pmictm7
 +ugbEoeog9PnuAVC9mmkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TVrXL/CWSjA=;WY41oLw9jEiXH8a0KOy2nNPh25C
 6q3EBk4LqYeqAjdVTHJ6R2b9f3hw642i9ak6onSCl1FVWrWKUuMOCHIkMgpeYdLJ3xF9CWdxR
 hQIN+G6KuSrGu6KQ/3LGr/sY8/pWLJMUDxiDig5Y7sZ+b8U4otM59E/vuZTzOPVIWgkFASkW9
 cVAmtt4Hoe0FBHQMLhIHEcJJoXvjg1AW3ezGrKNcT4jXxveHAnvozuu4GVCRSR5rzLaHm4s3G
 z6f0/s/9bMXrxxINy1Nut0EKqS4gp5ygxeAvOnN6iG/LuQLm/KBah8YR/02GulHHPnhN1pirf
 cEAhr+oFifTEFjLmTA0PQXCfWH5bN4VD+vf1GeXaPM7Rmi45J9lNHywzhGQp3DadLu0Q6Qp4t
 skBwQ8yccf3Vw03Y9+FZY9mHO4NvB39HwXJ4Dn05LGm/JGDu4HQND0HvbBcs5z0Iu+wiuWMIU
 k7qBXtePT7qxjF2XANXLkZqqZKi+//tGcBdkMjXJJD4Ksn9KryWAwjgpWReygOmamss9qXox6
 utxNT6W0hWNcvg5I3UHrd/sBs//8uCpsn4WdiAikAKtdRjGVsWmq+89v7d2DXrpAQzTvveopX
 8OkqrS0+IjA9nuAxgd9EJBGkMzc5IPkCJfbMb0+UqJLl/+6aWHpZIykLr/mJrALXlUL4wczgd
 wvk7C68lxw06gGsPqXIZ9cu/s/ZXD+CHWRDfCybovNNjzzrMbEu0dHDkF/17N5pW90qjeKJSs
 V7vM/TKvDHrsudeyfXPcXmhiv4Z/tDQDhIYyQZLmUDbaYAlEVfmNV881rxbeMwmU00N9GZmdV
 P3xDoo7doI2KuUksRGKCfM2A==

If the battery hook encounters a unsupported battery, it will
return an error. This in turn will cause the battery driver to
automatically unregister the battery hook.

However as soon as the driver itself attempts to unregister the
already unregistered battery hook, a crash occurs due to a
corrupted linked list.

Fix this by simply ignoring unsupported batteries.

Tested on a Dell Inspiron 3505.

Fixes: ab58016c68cc ("platform/x86:dell-laptop: Add knobs to change batter=
y charge settings")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
I CCed the maintainers of the ACPI battery driver since i believe
that this patch highlights a general issue inside the battery hook
mechanism.

This is because the same crash will be triggered should for example
device_add_groups() fail.

Any ideas on how to solve this problem?
=2D--
 drivers/platform/x86/dell/dell-laptop.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-laptop.c b/drivers/platform/x8=
6/dell/dell-laptop.c
index a3cd0505f282..5671bd0deee7 100644
=2D-- a/drivers/platform/x86/dell/dell-laptop.c
+++ b/drivers/platform/x86/dell/dell-laptop.c
@@ -2391,12 +2391,18 @@ static struct attribute *dell_battery_attrs[] =3D =
{
 };
 ATTRIBUTE_GROUPS(dell_battery);

+static bool dell_battery_supported(struct power_supply *battery)
+{
+	/* We currently only support the primary battery */
+	return strcmp(battery->desc->name, "BAT0") =3D=3D 0;
+}
+
 static int dell_battery_add(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
-	/* this currently only supports the primary battery */
-	if (strcmp(battery->desc->name, "BAT0") !=3D 0)
-		return -ENODEV;
+	/* Return 0 instead of an error to avoid being unloaded */
+	if (!dell_battery_supported(battery))
+		return 0;

 	return device_add_groups(&battery->dev, dell_battery_groups);
 }
@@ -2404,6 +2410,9 @@ static int dell_battery_add(struct power_supply *bat=
tery,
 static int dell_battery_remove(struct power_supply *battery,
 		struct acpi_battery_hook *hook)
 {
+	if (!dell_battery_supported(battery))
+		return 0;
+
 	device_remove_groups(&battery->dev, dell_battery_groups);
 	return 0;
 }
=2D-
2.39.5


