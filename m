Return-Path: <linux-acpi+bounces-7789-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C495BD7C
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 19:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CAD52829FA
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Aug 2024 17:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39E1D048A;
	Thu, 22 Aug 2024 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="NW9uBl4+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53FA1CEACC;
	Thu, 22 Aug 2024 17:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348344; cv=none; b=n42zbRcYR89Zhp4YxFcGkczYQ0bzeFPuT5KulqXSIE6ZSbPLoiboiHddEb7ZduOPSGSZGRnqGODqmOM24X9rt3hSNHIO9fXDnhxXQhM4CTa4aDYM+qBpLpUQbGE2YCL3O+OC6OJXnnmVgGCrS32tSFC3MCru2r7KfL6VC8WgtiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348344; c=relaxed/simple;
	bh=Zx6VLkyJnlwRkWyPWUrI7rYgqbSUFqf6kLgkivSXUIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpiUfZtQH+eQ7OIQVgwUPeOPcoXL53+mcXKMlWSreSXxQp2//wr6Rl4EIG5FgU/v2w63oxBMRY7IpbEP9822DyffO3E+kpTeqxJGcQgy2dQZmGjznW3JtvamA5/fG50FcoTJJ0rDzgRlqcHzBLHj92+1NG/7tVxBkEwrDlcfnLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=NW9uBl4+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1724348327; x=1724953127; i=w_armin@gmx.de;
	bh=yp72eb20PMYV+rHiupjM7lbpqXmjLCrxRfHSyP3Ato0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NW9uBl4+GGIEcSCOpMUCJdaT9TxEMNggIYav0wLsUCUykRhMqa//OAEBKriyD7sa
	 3BexpMkJHIHeoSjYN7pNUPtIvr4P7nhcQqBNoipkPWoB4ppF8JiCyB2qU1wHJwFYk
	 vw9VG1PpPRwwnuox2+RfxcHG6H40p6639vnAiUQ0M7jUpY3+LyPKl/jiENgIXRd/6
	 3zGNa+ojNwP4zUHvdRRknwUO8xnmeCvrERJJDeVy5bN5nQEf/kRoFX3SjsyKdRzZw
	 CQxPMWPWroQCkW1pfn1jSudKRTGXaXCQQwkxhnT7TXmy+S8VNrBaLa0vLwtjKyPac
	 I9w0xN/FUSnb65Ce+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mqb1c-1sLH9D11yi-00lleD; Thu, 22 Aug 2024 19:38:47 +0200
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
Subject: [PATCH 4/5] platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
Date: Thu, 22 Aug 2024 19:38:09 +0200
Message-Id: <20240822173810.11090-5-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:gsHzByznMkS8JUj2/L9W5/v1Nu6RgXOa/xvoH5wfjlGxNITsASe
 aSLkjCBUyK4nqVO5kNNknHFX0WL6gO6Fgs89Am+aWexYe/gfAMfoVAsUyid8WocL+JdL6KC
 KucdwbnTwMeMHmMc+gi1hnKml3VtnQ4o9NXj/beuJwUvRvayd88nuPr52eHeVJk/Nwxm9dP
 JF3p0QdTNcWfxOF4u+yXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q6Jiengjsp4=;FFrXC6z7twiLHOmpBxoVGb6UHyd
 syNhVdYuOzGtLfgbTv2WRXkFy441+SAs/iJOKZYMgXJIpxYzqKcER/X/p8CR3s/XmMRQrEeIw
 R145mAmrLYFfwNNh0Qcy5ptqxcsT0Ccz13kjfFu8rCByUSMucCI/wE3zOukoXOfmU0jbku5KD
 xRVXbwMohUbaqo4QizK3hpACTxhef0sI0W5gSIuojRVdAktIEFqRy1+SIVa0yHlyxdmGQ/N/U
 7h9z0ZhcPUdlwpjo4nXA2gzYxcxGfTUkLsK0j89AosLQsRLIdxKDJMugeJ4Arb0F8g5Uuz+8h
 Y7tAkAXUO4Esl7CFJ8t09rnbkR62jDRrPkyIuE36u29ew0mTfSbybp8UP6tPIyLjRD+Um9sxN
 70/sSM1lYizaskLLyIl8/40/bmD76ppoo+DiErHOBeN8DVOc3zVaRHLz7TnszHXjz7ekUA3wy
 jDMSF5PPSJpQP5gezL+zCSjzWUhe9kKln0E3TUHed9EZWLHOq2J2rhRwo3Nx1PLNzolEbdvy4
 ds7RglC7+pPhI6ePiyWffOYyO0UdODjG/Gp34DlB2dDhImDqN/6iXMKuV8z96LzKQELzp5vJx
 1/HEFgdbOXVe+Qr29mfky0Gf651h/u4qM7Nb9y2VMGShgltd9T9oOhTtMXYmQRv4+n9KSta1w
 lMATK5KxSg3VVmEoRNMeJg7GWjQVw27/bfiiIlHx12C64CRgWhPZyLtQKANF9gTe60QTYIwcu
 ETBt8SebLx3Ix8ObzuJXm3LwdyOQ/KIOg6GUaUQ7A5MBTWCgUNNeQ6cbgfPjx0CV60uVukKG7
 IfEib6m+5VoYZ5QlBrqcQW4hjwZs6rUX2GFuBV9WuqmSw=

Since get_event_data() is only called by wmi_get_notify_data(), it
makes sense to merge both functions.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 43 +++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index c7f0754f74b4..6b27833ba5d9 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -166,22 +166,6 @@ static inline acpi_object_type get_param_acpi_type(co=
nst struct wmi_block *wbloc
 		return ACPI_TYPE_BUFFER;
 }

-static acpi_status get_event_data(const struct wmi_block *wblock, struct =
acpi_buffer *out)
-{
-	union acpi_object param =3D {
-		.integer =3D {
-			.type =3D ACPI_TYPE_INTEGER,
-			.value =3D wblock->gblock.notify_id,
-		}
-	};
-	struct acpi_object_list input =3D {
-		.count =3D 1,
-		.pointer =3D &param,
-	};
-
-	return acpi_evaluate_object(wblock->acpi_device->handle, "_WED", &input,=
 out);
-}
-
 static int wmidev_match_guid(struct device *dev, const void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
@@ -1129,14 +1113,19 @@ static int parse_wdg(struct device *wmi_bus_dev, s=
truct platform_device *pdev)
 static int wmi_get_notify_data(struct wmi_block *wblock, union acpi_objec=
t **obj)
 {
 	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	union acpi_object param =3D {
+		.integer =3D {
+			.type =3D ACPI_TYPE_INTEGER,
+			.value =3D wblock->gblock.notify_id,
+		}
+	};
+	struct acpi_object_list input =3D {
+		.count =3D 1,
+		.pointer =3D &param,
+	};
 	acpi_status status;

-	if (test_bit(WMI_NO_EVENT_DATA, &wblock->flags)) {
-		*obj =3D NULL;
-		return 0;
-	}
-
-	status =3D get_event_data(wblock, &data);
+	status =3D acpi_evaluate_object(wblock->acpi_device->handle, "_WED", &in=
put, &data);
 	if (ACPI_FAILURE(status)) {
 		dev_warn(&wblock->dev.dev, "Failed to get event data\n");
 		return -EIO;
@@ -1163,7 +1152,7 @@ static void wmi_notify_driver(struct wmi_block *wblo=
ck, union acpi_object *obj)
 static int wmi_notify_device(struct device *dev, void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
-	union acpi_object *obj;
+	union acpi_object *obj =3D NULL;
 	u32 *event =3D data;
 	int ret;

@@ -1179,9 +1168,11 @@ static int wmi_notify_device(struct device *dev, vo=
id *data)
 	 * WMI driver core stops evaluating _WED due to missing
 	 * WMI event consumers.
 	 */
-	ret =3D wmi_get_notify_data(wblock, &obj);
-	if (ret < 0)
-		return -EIO;
+	if (!test_bit(WMI_NO_EVENT_DATA, &wblock->flags)) {
+		ret =3D wmi_get_notify_data(wblock, &obj);
+		if (ret < 0)
+			return -EIO;
+	}

 	down_read(&wblock->notify_lock);
 	/* The WMI driver notify handler conflicts with the legacy WMI handler.
=2D-
2.39.2


