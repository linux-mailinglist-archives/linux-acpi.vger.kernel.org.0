Return-Path: <linux-acpi+bounces-8035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A1F967458
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8760E2815E1
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862FD7345B;
	Sun,  1 Sep 2024 03:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Mjl0aqus"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E1161FCF;
	Sun,  1 Sep 2024 03:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160320; cv=none; b=GR+ZQzjEyLAEbNnhK2Igukj9kcs4g6R5tS4FQMHDFoG9gwYljoQSnMDgdmeI0G72EYMEJ+cdNiuRYjX8WYA0fXGD2+xCbOu038VduIygMWPlr0AFwjiQ4Ypzrn7Iu95T3t+bQgVdMtC70NdkjEDYwqh12dVxsdpaEq8RlWY1G+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160320; c=relaxed/simple;
	bh=N1SRxLIMiaHEWQcXmpZUWs7IxLXL+xAMhqICn9t2VOY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNdpI51LJDxNaBW860K4vm7javYWumxQjgGVtmfMKZM9MqTvLiE88T7x4G0QttIw53mROzpxMkIIcvv4h9DYwKxrD9pRYhlIgf2ycMpJ6XjKhA4pvVMRfEhR+PRglYlHYMJHwABJZAA4cq0ZThwevUmtmKIZha0P2TqTanpYHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Mjl0aqus; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160287; x=1725765087; i=w_armin@gmx.de;
	bh=Fh+NRxC7VdSPBTxoHvz8oXusb/Km1qqXvRO90lsQ+bY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Mjl0aqusaFE6B4ajtDRJ+J/vCGAfF8aze8sRMLciQXVuC3JWTl49F0iplfmn0iSS
	 e7pHxH9t8vXhIyy6xCTKAWUH4dIPfyk6nUKWUg53laJZ5VZtJBh7XAT3mVv03P9jt
	 7ETxFKPp0vFJNBkLkrKIs32xOY48oV+D2mBvYFEaPgCXRS9JLTb/kj/MFu/I5mvvo
	 rfArt5G/DAsL/WY5zm/IZ3fVRyuBXUschMR8u7TguqLn2lUrCykK+84bNSZPAbrS6
	 I1Xzx/1BarrwaaNgrQ4LAj36YnDGgm+JuIvbxCG+C7PUmpCG9fUumF0lRBqLHT+K/
	 cVKhoVKrx9t/H1dZdw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N4z6q-1s3X0E3jgS-013fiD; Sun, 01 Sep 2024 05:11:26 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	jlee@suse.com,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	matan@svgalib.org,
	coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux@roeck-us.net,
	jdelvare@suse.com,
	rafael@kernel.org,
	lenb@kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] platform/x86: wmi: Call both legacy and WMI driver notify handlers
Date: Sun,  1 Sep 2024 05:10:55 +0200
Message-Id: <20240901031055.3030-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901031055.3030-1-W_Armin@gmx.de>
References: <20240901031055.3030-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8iapphxleB0wEpmapMSDOSsrBZf3Tuc6vg2za1AvOK0/PAerH7
 gETG8EHGDBFVe/mSiSAGpjOwiDkzQFeVx5HY6x+mpOB2e5oFGXfxPDo5ixAoLqWEXnfOBp5
 syANV0+Okd5jIcGZp7QCTPV4N7xOXoWdfMTuWR4N+obWm/gcjdNCOfe1j1q0QiTB62YWnt1
 RpysFHd2cp8njXU0KZS9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5GzjSi1jG/E=;a7fjHAiFAoEAM5Mt1Ki5bigJWza
 sM5wGwL2rEazra1oD7bSgzHUtDm/obKvcbmzP16SLCn75yRjco1/Rf0khfF4gwYhqdcz4izQP
 ILp+Q7AZCShuqPWgbtZi8JI3TPCR2PZBxxwMBLZkr7smpE4+wUUsYy8XU5bL3lWP71QhxYjvU
 2OWkuRe+y+vl8TgB99yeQ+OMmp5o0gEAsIxPy76HNgyfzKV+WB5+a0V2QB2WuYPiiutbq/W5m
 CWKo4zANdzVBOmS1zT7mdRMC0fFWieJaWrXtxnfGx+Zg2YAnM46GLb5GuHDTsCyp1A2iJfPz8
 lbxNP32n9xkqPIxLM31nNW3h37Kl0CizDNps6ZqPTzrJDc95tYwvBCdUcas0yP3Ujnq5o08Be
 YlW+kTIftN+jymw2AnexkBi5FtV5qsygk05iQ29EqskZRhMbNZNCRWYhxLHNWCXvAw5UfwXqf
 3c0qWaGEpVG23gliF0juu7cfmLt0xRGiEy9d0p8tt/r8hXa2tYRfzML/Ms2BPV41187zr/Lfu
 IyCOzvUemqUiuYhBTGpPrAm+wSJgB8vm6tGWsvR/H177QMSdvtpXKRJF1CCJCoqqFyDs37QPT
 FND8veLznMXscD4TILdlMEj874l4i6vsHh63xOOhMlPu1op7Tg4ArWrrTUvsnvFwdEV0uJP1D
 QQkT9Ffyd45q3nj1z4pSAJcWcuLEeEiPM4mwD27562AHBClhpC1/RFzw0PrajziVxKlEAk8P7
 QsWbNwZesJBId45TKStbyjsygklsF37v92FwIE5EefpxPTBacEflL/MzZn5PvENeve0US2gRN
 nABUesSbSXm4TV5SI01mf1eA==

Since the legacy WMI notify handlers are now using the WMI event data
provided by the WMI driver core, they can coexist with modern WMI
driver notify handlers.

Remove the precedence of WMI driver notify handlers and call both
when receiving an event.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6b27833ba5d9..3cbe180c3fc0 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -1175,15 +1175,13 @@ static int wmi_notify_device(struct device *dev, v=
oid *data)
 	}

 	down_read(&wblock->notify_lock);
-	/* The WMI driver notify handler conflicts with the legacy WMI handler.
-	 * Because of this the WMI driver notify handler takes precedence.
-	 */
-	if (wblock->dev.dev.driver && wblock->driver_ready) {
+
+	if (wblock->dev.dev.driver && wblock->driver_ready)
 		wmi_notify_driver(wblock, obj);
-	} else {
-		if (wblock->handler)
-			wblock->handler(obj, wblock->handler_data);
-	}
+
+	if (wblock->handler)
+		wblock->handler(obj, wblock->handler_data);
+
 	up_read(&wblock->notify_lock);

 	kfree(obj);
=2D-
2.39.2


