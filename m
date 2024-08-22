Return-Path: <linux-acpi+bounces-7788-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5F195BD77
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2593F282C2F
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044C1CFECE;
	Thu, 22 Aug 2024 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="PzvImjcC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD16D1CF2AF;
	Thu, 22 Aug 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348343; cv=none; b=GvqxCm7QPsDxFEyGiKC26gQWUy+jL+GmtvRTS6HGmAoZjQViWaOlrHkFBTG8cuiLWRLWagdGhkdQYxNnnStMcE5IF8RmVhG1u4nOS3GGHq16A/XxaUIIkneGyy5XEJRswzdu6yNhVCOHmewzNxA+rieo+0NWwEziU1sInQIxghM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348343; c=relaxed/simple;
	bh=xk7GAhpuKOrsY1jPLtSS2k+JNdNZXKMod9/aywnPR6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ffl6TOaJYWlFJ3JJrWYxRul+Q8ARJf9Hkyr1BkhFMkFQYH5H5OQfXSR+rl+G65zT1SRnNObwxlDob8DalD9XxI1ld4wSu1jZo+BUIFF9sk4I/90DweS3MMLlq9LRv9PFOlX6ERrNv3GeeOSNZbfhyG+AiOwekwtKVtcAWO93CEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=PzvImjcC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348325; x=1724953125; i=w_armin@gmx.de;
	bh=OlDvB9yyiEHlxAZCtd5jRTJU/gPtXJkmhmn+Zzh0VPU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PzvImjcCNrM7gIkWOYpZGEadEey72tdQJX3vy9XGxQ2Q027oV7US9sp0RH80G1WO
	 LiTT2vUhlnVkKyreWTfjfVrCZHDwD+IomQcAHGLFgUUgSJcnBwg06vD50fJ12CozK
	 i1iQ/77rkTqcVUWOBvQ4blhzBcEpNC/yPFIksQ7aEQAimPyHLu15Mp7eWE1TuvX3G
	 ftI4/h3eheoa5ztSNzLBBHH4yubDQjG8fHBjg3lL2S1TPlmKlbeNd7EYnSkhhE640
	 9JcDxK05535aI043uhiDbvzmSDUf+csVIjUqRe4SnxlxV9P6NREwbwizb1nlPsL/b
	 TxNg2KJe7/KDyfTvrw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MO9z7-1sVpvQ2pyL-00InBv; Thu, 22 Aug 2024 19:38:45 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: wmi: Remove wmi_get_event_data()
Date: Thu, 22 Aug 2024 19:38:08 +0200
Message-Id: <20240822173810.11090-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240822173810.11090-1-W_Armin@gmx.de>
References: <20240822173810.11090-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:421ERWJKEQNrzoMK8H/fYXmW85Vs/C2H4ED8ImoitO6N77yX2qt
 Ha2JtDVDPcjbiBF23n+AkbfS0B+U6F/mmtdykED6t8Jieak3/Fmjd1A3SlaI2WCnNK2MALG
 OEyCj5wamaaT29kDRANKj1Em5zmGzJalYJay3pMlAv/fkGNOaKCtvwm0EEIv4YbnWRuBRzd
 SiKyOkcgQ/YXCT37e+IxA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hzxiQ+4jD8w=;aeYxhFJzEd0UM7e/j7F3ITa94BB
 giz2i67us2Y7cc0RC8wYcRT/vGKhogY+50+UDXop5JwDlwQ6J9o0BFQHQDD+bzW+JBVYC3j81
 2RaYggY0S4qrlgN6ueDB0Q0b34sI/EUoYuU37ZiiLqj/UeGn5+DuQNsCYMm845O73yHflzksK
 PZSe3jYXPcAfJSIhnM/TYlsu5ffXt/MHPDjiV7kU1iaTl0IlPVnI3FaDD9dcZ7f78LPemXI8t
 VZHkswy0+myEqe+vptT0exM/OXyc2eBOYDDuMxSTmZSkGHzQYz3CiasKfHwqonMympSeRRTL4
 CRJy2Sfr8kUy4DZwpdX81PFEd8TrNpRmkypJd5G97sG2WTkDhmJMLuGE/ew3Wl/60xpM8nP26
 XffpsgcfKXnU2Gxvs9JgyE5ZcPNpXIglEiY39dOkxw9kOF0WR/3Gv4wMYRcqvp6FjEM/HHYr+
 ciXJZd/GzBoIHcs5y8m12KjKDH7HiD3nAcp8Awv54nYUyFmjBOwO/4X6S5uj533ulcU7eHj5o
 GvudNBF7H12FyJ4nO2WpW8TH2C9zE+qk1HjIdmPzM0vlk1I+/G49aLXbnjRiGJllRT0qHsLE7
 o/hAlE2dKyhDrvuBmWk5Ei1O5PE+vvbx2ZHnl8kCZbxjpAyd/bFtgo95QfEQaVJtVeFvCdsto
 OGuJD/iKj5UoPxqTwHZYiyh4r8RUo93mcXQP0N9wC5BDTpSHGF+tP+T64SJdtf9kf97zw5mFi
 OvNZcYHVisfG+IcvXroezWIR6fSwWBB2Z6IYYGyf2Dzyv/j3wYZZNma/aaW/OF1azKx5K2rH6
 qB67TpbV1x/feiWdMjxh1DBw==

Since the WMI driver core now takes care of retrieving the
WMI event data even for legacy WMI notify handlers, this
function is no longer used.

Remove it to prevent WMI drivers from messing up the ACPI
firmware on some machines.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 57 --------------------------------------
 include/linux/acpi.h       |  1 -
 2 files changed, 58 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6ab181dd94ab..c7f0754f74b4 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -199,23 +199,6 @@ static int wmidev_match_guid(struct device *dev, cons=
t void *data)
 	return 0;
 }

-static int wmidev_match_notify_id(struct device *dev, const void *data)
-{
-	struct wmi_block *wblock =3D dev_to_wblock(dev);
-	const u32 *notify_id =3D data;
-
-	/* Legacy GUID-based functions are restricted to only see
-	 * a single WMI device for each GUID.
-	 */
-	if (test_bit(WMI_GUID_DUPLICATED, &wblock->flags))
-		return 0;
-
-	if (wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *notify_id)
-		return 1;
-
-	return 0;
-}
-
 static const struct bus_type wmi_bus_type;

 static struct wmi_device *wmi_find_device_by_guid(const char *guid_string=
)
@@ -235,17 +218,6 @@ static struct wmi_device *wmi_find_device_by_guid(con=
st char *guid_string)
 	return dev_to_wdev(dev);
 }

-static struct wmi_device *wmi_find_event_by_notify_id(const u32 notify_id=
)
-{
-	struct device *dev;
-
-	dev =3D bus_find_device(&wmi_bus_type, NULL, &notify_id, wmidev_match_no=
tify_id);
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	return to_wmi_device(dev);
-}
-
 static void wmi_device_put(struct wmi_device *wdev)
 {
 	put_device(&wdev->dev);
@@ -649,35 +621,6 @@ acpi_status wmi_remove_notify_handler(const char *gui=
d)
 }
 EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);

-/**
- * wmi_get_event_data - Get WMI data associated with an event (deprecated=
)
- *
- * @event: Event to find
- * @out: Buffer to hold event data
- *
- * Get extra data associated with an WMI event, the caller needs to free =
@out.
- *
- * Return: acpi_status signaling success or error.
- */
-acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)
-{
-	struct wmi_block *wblock;
-	struct wmi_device *wdev;
-	acpi_status status;
-
-	wdev =3D wmi_find_event_by_notify_id(event);
-	if (IS_ERR(wdev))
-		return AE_NOT_FOUND;
-
-	wblock =3D container_of(wdev, struct wmi_block, dev);
-	status =3D get_event_data(wblock, out);
-
-	wmi_device_put(wdev);
-
-	return status;
-}
-EXPORT_SYMBOL_GPL(wmi_get_event_data);
-
 /**
  * wmi_has_guid - Check if a GUID is available
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index eed105b1fbfb..3cbe4b57bc73 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -401,7 +401,6 @@ extern acpi_status wmi_set_block(const char *guid, u8 =
instance,
 extern acpi_status wmi_install_notify_handler(const char *guid,
 					wmi_notify_handler handler, void *data);
 extern acpi_status wmi_remove_notify_handler(const char *guid);
-extern acpi_status wmi_get_event_data(u32 event, struct acpi_buffer *out)=
;
 extern bool wmi_has_guid(const char *guid);
 extern char *wmi_get_acpi_device_uid(const char *guid);

=2D-
2.39.2


