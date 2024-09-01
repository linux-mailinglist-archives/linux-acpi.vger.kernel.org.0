Return-Path: <linux-acpi+bounces-8033-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A9D967450
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 05:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 400E11C20FC4
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Sep 2024 03:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEAE3DBBF;
	Sun,  1 Sep 2024 03:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="uQgqLYgr"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656102E651;
	Sun,  1 Sep 2024 03:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725160315; cv=none; b=qub65kFPmu6s5okEeSmLj1GqsWqQWkuBWSReAoSOhfbsvW1WprZvge3pOk1kovBM3DOVCrgIWOneUCo71nFyc3X+XLAsU5PbkXLTrct95y77HwTnk1/EVQEGad/7hRz4Z2/7juwhLfuJw5i0wbn4f/8GKIcr8zr+WO8WYi+GAtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725160315; c=relaxed/simple;
	bh=s4TW1WtAdPg+owGssuVS48Y+lQP34Pd+ooOIJCkz478=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDAiAZhU8KgGzqGtIU6eFR6krXXeJR/0dpHPr3jwRtSLY0QHRSgOgqgS+cqgSLOaSDgY4+OFejHbSf3zpTT3K9bMD6K433nSCYP+9A4Rc9wA3JbkHBBxYy29SwBTEsV+OFWE8n9ZLazfkwt2QaE29TtB5782RJkDJFmbZEDJ/ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=uQgqLYgr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725160283; x=1725765083; i=w_armin@gmx.de;
	bh=hg6S4gplBMMEaLxRK4ARyTK8NSLWEHkbdxC8ofXgSL4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uQgqLYgrYAfVLfnmB3oikKJLWtDSuv0LAvij2R2DUoYC9vzR5OAgtJJDKPR152xn
	 7la8ea8+9B6xlIX1qAlunLwhMrFivh3sTTlX+/Plc8XyVa0AmWzpunfaauRPTidBq
	 jq/HgpXbRgBo8vWGPpqKQfzQNiv9vHu5ty/cDk98RixkXj4lCsPCU+52ywl6xZMEw
	 PYE+ACgZuyQQBja/PIUCdZohmrU1nFIHVFdKp577tB5dnjRdmFiNbB603jXJ3CZwf
	 /xUg0CKPevpVkVqgnzw5R6R+BD7jea6MVNvTunvtfpxUjP5PAca/rI8jKRe/yfy7p
	 N8zPVuQYG6I7B9N5/w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MhU5R-1s612u0rJb-00cIHE; Sun, 01 Sep 2024 05:11:23 +0200
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
Subject: [PATCH v2 3/5] platform/x86: wmi: Remove wmi_get_event_data()
Date: Sun,  1 Sep 2024 05:10:53 +0200
Message-Id: <20240901031055.3030-4-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:UlBrZM6/pwbag7fZm4yy57Y1UPyF+5BH1FMiWU8TLKyAePsF5oA
 PEwXEkolr20/jEJI/FL0Go0PoTPXbKTEG2m1Nbr5s1po3cJ1ImAHOyhPcAmmMKYUS4d7b8x
 uB2M/AnBrrt87NPhaYwyvXzXzb4eKTximvDyGF34d37MxViHpZ8PrxPaCTla86apiDlH5w2
 FCxw8WUBPrRKzmtK/h2dQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KrPx1r+J56U=;SbcQqkaFSnmx8NkFzWjTvo3l5Jq
 QE3b/dtDPXKyQKDjTzDgMvu/qqMVQVlMFZmxqFzqX6EbXNOm094Eu7fKtQNHpRAyysQrarQm9
 w8v3gomzYRpV4w3rLcojgmQk3F+G6xP8h0J8R1VX4QwmP4fL34AGA7Z/3IA5KiiC5pgjjzVWR
 9zZ2ttsaOM/yaxq8/0r2MCOykI8i4nvCuTIqAAvQJU2PUekXrx7j/E+190RgiCZYIsWYwf6dx
 sa72dEtbC61jsGLRr/bzEKfZmTQTju4AJ4t7daKQKjE7IiBNC8VaYMjwS9YQEeW7hxy7BhuOT
 bN7IsbpeI93ak0JLZqM8HgKlV3vxn4rHzf2Af0PsMfmxjTrJmV2FSd6P69GEygwjkXAyq7Ble
 pp2bBeoMHD+B9UMBJyDaDcGqOCtvgsxatXnPrygSVWubkcYJwzLPjx5/lC7ZDJ82BAuSiwPoo
 nBuVdFlBjepopQaieiy7AEzvcHRygLfZ/jNsjgVCRdJZoMddFBne8Q4Wzeeo4f5KL+Uxp1jCk
 ClW9eGN6On9x0TuVt9l1yU6JxnKK4dpimL+yxXxq2jwoI5ThnumLc/sg+rM4xJi1qlvfka477
 70k9uKJNsaX+X9lv6Khsfl4R5R2uHRKwugOTal8jPs5acYOTFrruAU0ISsBGxGUNBFd7lbRc2
 FtZYYmcDWOwY/fcT1OAjgIXA46gHoyDt/hXdIbh8gx/51mje7S/PW9o0UrQzc7+O1h760XNB9
 VqVNOwqB/4EqdWXCx4zXBAxQaO+npS9waUy2S/1XKq3RrslGPSl5I5NrTBZPJ33M2/69WpYLW
 zltYtKF7IsgXuwtITwTcOj1w==

Since the WMI driver core now takes care of retrieving the
WMI event data even for legacy WMI notify handlers, this
function is no longer used.

Remove it to prevent WMI drivers from messing up the ACPI
firmware on some machines.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
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


