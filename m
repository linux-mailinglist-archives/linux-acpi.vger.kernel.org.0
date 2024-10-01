Return-Path: <linux-acpi+bounces-8524-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 245E098C79D
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0ED283408
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 21:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3DA1CEE95;
	Tue,  1 Oct 2024 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="MRbHqekI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254431CBEB8;
	Tue,  1 Oct 2024 21:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818141; cv=none; b=bQQf6Y5rnv0dbhoE1/Pb/wxY0WWPsun07LgqkAjy3lEWr0CloIwLD+Mfxyrof7eiV38dLcAfD8IFi7jet3WMJB6yL2MDVP7bjDTz0UxEgQ4kMHyT1fpV+yILK54l+MfRDFpH59RgikRkvwYF8qXAswyfyM+rujakNHHE9Zza6Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818141; c=relaxed/simple;
	bh=zRrK5MFLc1JOcsvDvNeBvZ62OTjh8GMAY70UPMH4h+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QzsvqpLDJcau3M1Hm93FPYjbaQrM2Ftxvv9ea57ICkS4FNWY5q2RqsJJ/wSJBBAiX3bEGzDW5+ru9PHBM8cyySrzhJfP3sDwWkYtAIruHpc/XwhDe6nf6w2OmDUTRoi3O++rv5txilpD/7NN6xX8cGipYbWhn3FGzvwT47wlMR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=MRbHqekI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727818123; x=1728422923; i=w_armin@gmx.de;
	bh=5R8P7uAwF3AYond08GKx/BPQQKEFJ8KK25PxVprj+Uk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=MRbHqekIhkgl1p0KFvuEjh8v6yVVAnGjgy1f5CK3MGHzfvw+WJ/fT2Dlt4xXurB4
	 CR91ZrVQB41qrrDa7LX/YTy/GeMT6X9ldHO/czDGLV7GmsrewaOLHhcaSw/FGYmeR
	 WKbK8Ds2l1+erlumrs6qF5F2LWWIvj0gqmbF91JYkFkDfIrAJDijelhJOyMC02C7b
	 jhZlFvNFNvjHfVgWd0Fz3N3lgJbsUjpDvzGyojr+k8v73NLAOCBWbs2fCcXoHl0Fd
	 0I2bJSs8HqkilVfWXNkeNgo9U905NzaHvgQ87HT6fjeTKpeXSpJ/EZ08IyJiKdUum
	 h7WFor/FoIoTgSV0yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mf07E-1sGeFF36uA-00fEWm; Tue, 01 Oct 2024 23:28:43 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: pali@kernel.org,
	dilinger@queued.net
Cc: rafael@kernel.org,
	lenb@kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 1/3] ACPI: battery: Simplify battery hook locking
Date: Tue,  1 Oct 2024 23:28:33 +0200
Message-Id: <20241001212835.341788-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001212835.341788-1-W_Armin@gmx.de>
References: <20241001212835.341788-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Trhycs4U/GeqUTO44q2sziMLm9j9fSCuEUkg0p6zxkXd+uMA7c
 HK26uINFVUTRZJPwTfKq1Vxs1lIWGOXkjp9SST8Mc0lQnKn85kWAQNkl0Gx6k37VnMntwOF
 kykLTjGvV+Wz8PoAeXbEwrVpV322CfwRzPwwytRCAdx6BNJ0kx2g8rs6Hg5bG5nAsrKAqu1
 sAAbRX7tfKZaSpdRWl+bg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1VcvCWkHb20=;oHmGt4fIoIJxHInZNupLg94rCNK
 2ftDnU5nD5ngaAOKy0Aa4ouYwcZm1gL9oJlBKWxfCa1/hFuwPb1/qa+4L7pU3WRaTGtG6WIyL
 LNky2lXmuOZ47BqDm6Pnrumg1EiaBHP3evQPAxVcDCSQ8kAKSpMfMOdCi9Bl6OORtI3hktAUi
 yShEuq4/mlI0oZsBhaA9QhTo6i9SopirIF9weUweEeLby1BpbYpVssCQlzvoq4Y8pyy+TYFmW
 HW5BWnTMdwGpBwUEP15q1AczFM13RFT2WNTT/1xUr4LTdBHExP34oWl1fScdts4fvF3DL6smm
 kfTAxk7fjb3CPS7As2GwNKJfuLMt89MWmvsZYwFNiaaZJRyiTPVGs/m3V+BzSGZiS1Z3QKxk7
 W0MF/LuHtBoXYTCI12wWuhaJlHCz7zImlln88bVvHBLsBGAhNuaejKxw3nEZe4IYctXn8pkvc
 Wf5LEFKpLmIcFKWsv5+rL7uEdM0VPWRD0jzXpVK7jR/vjwb9jgHQ5rXN5hWM0nzyPg9tBFAxA
 FpxQQObQuNAbhGd28pionxh1DZwXLa6z7NZ/T2S0xLcnsyBgGGi/OZUVHse8z/2+5wkSjPXlr
 d2bpR5zkiBEmAOelGb01hfMn7Mgg+HxPjdyh+yenRTp8jCARGRCJRiZ0kQ1yjmcc16BQIJlA1
 jiatrA92QS9l7bWQUcHaUZxUE6w6m9T8iwf3WWUlT2qpqB94Nj7//xbuaF1Ky3zYGR38fQAi4
 RYhieMgzbIfbaqZUloQLiPXgtfUl5Z1dyHdHhXR94HfyYpb5E4UIKPjIkGOGx1+BAfe6+S+8r
 VhhQzAtrxRgTFGftjYa/qu9A==

Move the conditional locking from __battery_hook_unregister()
into battery_hook_unregister() and rename the low-level function
to simplify the locking during battery hook removal.

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Pali Roh=C3=A1r <pali@kernel.org>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index f4599261cfc3..dda59ee5a11e 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -703,28 +703,28 @@ static LIST_HEAD(acpi_battery_list);
 static LIST_HEAD(battery_hook_list);
 static DEFINE_MUTEX(hook_mutex);

-static void __battery_hook_unregister(struct acpi_battery_hook *hook, int=
 lock)
+static void battery_hook_unregister_unlocked(struct acpi_battery_hook *ho=
ok)
 {
 	struct acpi_battery *battery;
+
 	/*
 	 * In order to remove a hook, we first need to
 	 * de-register all the batteries that are registered.
 	 */
-	if (lock)
-		mutex_lock(&hook_mutex);
 	list_for_each_entry(battery, &acpi_battery_list, list) {
 		if (!hook->remove_battery(battery->bat, hook))
 			power_supply_changed(battery->bat);
 	}
 	list_del(&hook->list);
-	if (lock)
-		mutex_unlock(&hook_mutex);
+
 	pr_info("extension unregistered: %s\n", hook->name);
 }

 void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
-	__battery_hook_unregister(hook, 1);
+	mutex_lock(&hook_mutex);
+	battery_hook_unregister_unlocked(hook);
+	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);

@@ -750,7 +750,7 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)
 			 * hooks.
 			 */
 			pr_err("extension failed to load: %s", hook->name);
-			__battery_hook_unregister(hook, 0);
+			battery_hook_unregister_unlocked(hook);
 			goto end;
 		}

@@ -804,7 +804,7 @@ static void battery_hook_add_battery(struct acpi_batte=
ry *battery)
 			 */
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
-			__battery_hook_unregister(hook_node, 0);
+			battery_hook_unregister_unlocked(hook_node);
 		}
 	}
 	mutex_unlock(&hook_mutex);
@@ -837,7 +837,7 @@ static void __exit battery_hook_exit(void)
 	 * need to remove the hooks.
 	 */
 	list_for_each_entry_safe(hook, ptr, &battery_hook_list, list) {
-		__battery_hook_unregister(hook, 1);
+		battery_hook_unregister(hook);
 	}
 	mutex_destroy(&hook_mutex);
 }
=2D-
2.39.5


