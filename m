Return-Path: <linux-acpi+bounces-8034-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 401FC967456
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7BC5B20800
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F104AEF6;
	Sun,  1 Sep 2024 03:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="XugCvM2b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A91381BE;
	Sun,  1 Sep 2024 03:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160316; cv=none; b=KJzLdm/ZFmv9bXbuQDHJASGBt/G1SyeLgeo+F3OsQLDBx9pfYzMqFQDboKxNX0WfDPceM+J4USIDQ4Vglemvd1qynYSz9Rr+i61nmweMUqAcUrn3MAHE87Id6lXj1LRc2wjx5ocfPJm5vTIA+bSnamC8qlWtBFtLZI/8z6RoPqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160316; c=relaxed/simple;
	bh=al9iIx7sg7Fe/w5XRrgpXWBu78w/jKFbm1wkMOmqMJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BGN0tL/lJBwBemlgDYLhJv/0oQLHwe2aJi5pcfLbH0/D5kPsIr4oVsgCzY0Hw6sZ3cQVtu4XzlW1FtHSEpMK0m8kUI0GIHTEcXqhDBu45eVu4LYDs5Av0tD6wcpd6830TlUqHWrrQXg69YHKpX+no6fjcs1YZMIuKQqEVBbHfEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=XugCvM2b; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160285; x=1725765085; i=w_armin@gmx.de;
	bh=KaCyQtW/XfmUGIxt14OAfBRRg6d1YDSK1q5z/XEQjLI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=XugCvM2bvCSBCmiSgNa3Db1aLLHzC27wVjTcpminv+nKo0jVa9Jmn1/eq7qGQ33W
	 lbhWkj6cAhkqBsXC4MzLrEWrk7vZDfdNmImExmakq3jE0izcBrsvbHrWKk0Q5TiYa
	 KuASyYqmzMCCC4NFYcZp1t5BIGa+JVfz5RylWn1EAIiPaF8J1hvfJrjViQAfwlsVg
	 lE1HmYh2ZDCoohH63UmVj0Iy3yTFLY+nbiSD4oYVxm4RgdU8ee3KGVtPbiMheEQBS
	 Z42I0HoB/lYEjJxN95j/Zrr70oaXAAFMPH/L4jvYbWXdx4uJAG9J4IdreTQxNQiRm
	 AQ/OYkvwYVviicYAag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M2wKq-1sntJY49bI-004gnz; Sun, 01 Sep 2024 05:11:25 +0200
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
Subject: [PATCH v2 4/5] platform/x86: wmi: Merge get_event_data() with wmi_get_notify_data()
Date: Sun,  1 Sep 2024 05:10:54 +0200
Message-Id: <20240901031055.3030-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240901031055.3030-1-W_Armin@gmx.de>
References: <20240901031055.3030-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sKr4i9MYti8tEQ113XL0z8KTHo/eDpcJW0zPngsUwmilquKVhgw
 /kGz5h1lXYdxAsC3M09U1GtQvJY+ic6/UGPYt3Iqb04jk58YXW2a4BHQghKLjOmbD2SOsPd
 EzdE6TXk2bslQQSS1V5Cevq7hEXH4xz+ZWaxSsdeflSXwnWQrgNQhMfMrQ+5PMlJ+thvt4H
 1rst4Q1Uo3Q1Pqo+OSSIA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Rgf4R2Yuz8=;IhwF/acb0aAhdGakE8sbh1BKMlS
 IzxTGtBWlLdAsgn7FXEHEGcFV5EP6U6RZMlVnO1LVTHscctLv34YcYIRoO4opzvJpV3xEjmFm
 pJWoSMWfYQB5UHCHoa3itC246/+TVhSyP3YPddZJehiP6LL8YpQnmZD4JZkmvJYvjiqAgPo4w
 7/i1vQFRR2QwCJS+gciWPC9/Fgoys7Ylp98RncJOymHkIy7sBcKCOAoJ4WmOjn+ToWYJg1j8A
 rlrVmLAQG/BT8KZ5j91/K989GG+S0V5xtNzLyaYgj41cYpVlIAe7jWX5ic5aKr4DlbPMMvJBH
 HFJaOhkux2d5P1wlp/eSnvkr4QGuTgpJCp+HGrsCnJIiYgzoZ6WTXjZvguY7Tii6IGDwsKzRB
 Xl8I8rMaSBz2JfC9KT30nw14iTUCEo9WFnIe3ddIanagJpbxLs+2TIfs2cmNFszfZFhp8yyQB
 mY0KAuqEVUUirdFNXsgUR7tAN6q1Tb2MoM3ujOc6nzXHRZMkKllYpMeTce/QBI/Rv3esX6/4d
 q6IaDM70n6qqJkKOKvvuUSQyw9ArlRAa86JQYMieuXRNb+P9iF3AZJBV5Ok4xfMM8PfIC9295
 vGxex3R8uct+4etTeTFHvT2RI19z0VoUfNcfGsYqy8xGSbLLsvKgGVSUE3uXJHBt83YFbASp1
 7esBrZuPd7FmaBaRsBtnRKie4JXeQgmG722vyjp444T0PpY6fTNhs8rWsIai5kouUQEz/ehKs
 OCgoAgDH7p3463mY4OCGVvofCaXBVEY3wm3yq4NTHFOgaAN06jQcLWSza9V4gmxFXdj8Ni9Ew
 8WBZdUEY9EsOGXjoxvlxTp8g==

Since get_event_data() is only called by wmi_get_notify_data(), it
makes sense to merge both functions.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


