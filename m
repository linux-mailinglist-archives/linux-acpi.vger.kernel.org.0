Return-Path: <linux-acpi+bounces-18209-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C19D0C07C8A
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B3E1C80A1D
	for <lists+linux-acpi@lfdr.de>; Fri, 24 Oct 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A834B400;
	Fri, 24 Oct 2025 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gChnC6gE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F99334A776;
	Fri, 24 Oct 2025 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761331121; cv=none; b=b6Pcl2kHtrZ9oNenHaagZBD1Xur9Xcu6d5nrCF16LIVDI6/Q9KN8y+EHMGdtOTMotFnlsC51pvEjMjnrOhTg8NoUlcAexcXkdku8+VG17Pj5qyQuoX7o5UhdmXcm9uprZwsip9tL193NqU3KXONNxiE9c6f958WEfT8gdPIVagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761331121; c=relaxed/simple;
	bh=2A1PlvROXJxuvTXphRZJjOdUQe9WUmSs/dXp8vOMRkM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jybjh8ufsLX2jlSE98nlfjIVdcaW79BeRDYrNwKVaRfAh2UD/ZIaqSOCPjidK2JkCz+v9gQRs791BfIZZ37tklF+79Ed2WnzTYLajt4pavB641pVbQxEU+NA8pY4aZgwJPXlpt0yfquEzANYb68S9KmKg4cH1gAFl0Gi7aznvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gChnC6gE; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761331117; x=1761935917; i=w_armin@gmx.de;
	bh=pj2YF+0Jdh5zYiCsFKazbgJOjW41CP8/TLCkIbqm/P8=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gChnC6gEk+EXfh2Pda2baZjGKfE1164irrdfgKvRVfkjPIA5V5jDdCe3N6PgF6+A
	 pYEQQWrBg+VPsUHnoIaHHsN6XskZeeeCy7PcvxGBfSeLBA7RfK3oMtiAsKoI7FNaE
	 rPfovZUrsUENxp0l/SWk2QAj+CH5R8V+1YZckDLm2y0CUuT5Ijr+aofdY+OCas0iP
	 IM28eJ9GJGV0lZpurSGwc6YWL50WAe4lG6GiI11mWzpNFzeYNC5ud6kBwBoKbeXra
	 QPqgqyRlSFLlC8/Du4AOFxGIJwpMjXiFe8DoJLLT7DgcK8cMdQAM8i62yFUguBlun
	 vVg8Sgm0C6u808Nt/A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([93.202.247.91]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MD9XF-1v3K7o1Qyv-008R7j; Fri, 24 Oct 2025 20:38:37 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ACPI: fan: Add hwmon notification support
Date: Fri, 24 Oct 2025 20:38:23 +0200
Message-Id: <20251024183824.5656-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251024183824.5656-1-W_Armin@gmx.de>
References: <20251024183824.5656-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LX3qo8teiYnycuk2TB4i728TIKcCCB6V3rttHfGrYBIDOkRl9p6
 JKS57ao++w88yh/ad8Yo3b9j7gqRMJu9wwE+6UtC2FJz+wdMpaJXjDDfBIupEDVhvE3jt3y
 KvqQs5i3cIOhRD4UScIS3uFP5DOIChEqGXGzyhE+hCQ/zz01c9eYluWbdZFwinEknQonzfQ
 FhSnNo+LszHDn1f9dYrEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OeZZF2jAvew=;WCZRf5ZBC1LjwPfk0Kch57+yKkl
 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
 +S+hg==

The platform firmware can notify the ACPI fan device that the fan
speed has changed. Relay this notification to the hwmon device if
present so that userspace applications can react to it.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/fan.h       |  5 +++++
 drivers/acpi/fan_core.c  |  1 +
 drivers/acpi/fan_hwmon.c | 15 +++++++++++----
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
index 0d73433c3889..dcc1ad3118ff 100644
=2D-- a/drivers/acpi/fan.h
+++ b/drivers/acpi/fan.h
@@ -56,6 +56,9 @@ struct acpi_fan {
 	struct acpi_fan_fif fif;
 	struct acpi_fan_fps *fps;
 	int fps_count;
+#if IS_REACHABLE(CONFIG_HWMON)
+	struct device *hdev;
+#endif
 	struct thermal_cooling_device *cdev;
 	struct device_attribute fst_speed;
 	struct device_attribute fine_grain_control;
@@ -99,8 +102,10 @@ void acpi_fan_delete_attributes(struct acpi_device *de=
vice);
=20
 #if IS_REACHABLE(CONFIG_HWMON)
 int devm_acpi_fan_create_hwmon(struct device *dev);
+void acpi_fan_notify_hwmon(struct device *dev);
 #else
 static inline int devm_acpi_fan_create_hwmon(struct device *dev) { return=
 0; };
+static inline void acpi_fan_notify_hwmon(struct device *dev) { };
 #endif
=20
 #endif
diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
index 9ee4ef2d6dbc..7be22c52670c 100644
=2D-- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -326,6 +326,7 @@ static void acpi_fan_notify_handler(acpi_handle handle=
, u32 event, void *context
 		if (ret < 0)
 			dev_err(dev, "Error retrieving current fan status: %d\n", ret);
=20
+		acpi_fan_notify_hwmon(dev);
 		acpi_bus_generate_netlink_event("fan", dev_name(dev), event, 0);
 		break;
 	default:
diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
index 47a02ef5a606..d3374f8f524b 100644
=2D-- a/drivers/acpi/fan_hwmon.c
+++ b/drivers/acpi/fan_hwmon.c
@@ -162,12 +162,19 @@ static const struct hwmon_chip_info acpi_fan_hwmon_c=
hip_info =3D {
 	.info =3D acpi_fan_hwmon_info,
 };
=20
+void acpi_fan_notify_hwmon(struct device *dev)
+{
+	struct acpi_fan *fan =3D dev_get_drvdata(dev);
+
+	hwmon_notify_event(fan->hdev, hwmon_fan, hwmon_fan_input, 0);
+}
+
 int devm_acpi_fan_create_hwmon(struct device *dev)
 {
 	struct acpi_fan *fan =3D dev_get_drvdata(dev);
-	struct device *hdev;
=20
-	hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan, &acp=
i_fan_hwmon_chip_info,
-						    NULL);
-	return PTR_ERR_OR_ZERO(hdev);
+	fan->hdev =3D devm_hwmon_device_register_with_info(dev, "acpi_fan", fan,
+							 &acpi_fan_hwmon_chip_info, NULL);
+
+	return PTR_ERR_OR_ZERO(fan->hdev);
 }
=2D-=20
2.39.5


