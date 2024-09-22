Return-Path: <linux-acpi+bounces-8362-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F6C97E053
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 08:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA31428141C
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 06:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D5619307B;
	Sun, 22 Sep 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="I0m1gSCQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F79336C;
	Sun, 22 Sep 2024 06:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987249; cv=none; b=ZacmaX+S4HpfI39kcEU5xWDrb3jUXw2mQ7kBObUAjqhqzYuFHq+B59Wzu7iv5ovvS5ts5xf6DiupesxwF8QzWBfkBB8YpUJGHI80ShCaSP9vGCiHhPoWC4jdakBSGXACaEz3lWZen3v/SWtNzD5PZ4FQ1AfEedo97DBn6uFuNJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987249; c=relaxed/simple;
	bh=Z+4Ro6PqO14eV0eK7NAetUAnbu4ylAFI7iOIXIh90bE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=To1HwC98zTUUNOK8IZ94TLLAReD2Uv1qF4Y+pDjKRfhDToVdjoWzsLkKAhaFPVMDxS/A8bCql/OVQ4SESi8oZWCn3+6q6FxfLm9ygq5ePNoRUi8CWULJ4OGMu8gUSHv7m9VWNV0gflw1DtpK39n929F94cUHW4JUbOXwqMBtaqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=I0m1gSCQ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726987232; x=1727592032; i=w_armin@gmx.de;
	bh=Oq6agqHzSfOQAvgj22C78dYAyUDRZmpPUD+MVlr2AwA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=I0m1gSCQWChjmVinMLTSX8lGdM01E+dzAXxbLSyIBUfWYiS3jwsNh4HAVu4BHm5P
	 xqd4btJ+7txheyaLIVyws4pCtyMzalk/FkmKCaiH56AXTSSFvtVoDITJcKc9KyIKU
	 S4dHezVa4/aTMSzx2ZOFZQvEDV7kD2hvjE/QplyuuDtTVrvcoEJsUd5SUrOsYLvWF
	 r3tsobyof1+aA3NvIXNu978sOyPorafVLkNSbJVZGNATdpJ5g/yOYutr45nRaJ+X7
	 XwPFFDhhuEUiW3jCSluLLw8bexKVT1cgwAoWaaZKMmKgGyeHRv/qO2fL1EGlHwHa/
	 cQFNU4IlGTHwlgvi7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1McY8T-1sFLUD0hiv-00i2UN; Sun, 22 Sep 2024 08:40:32 +0200
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
Subject: [PATCH v2 1/3] ACPI: battery: Simplify battery hook locking
Date: Sun, 22 Sep 2024 08:40:24 +0200
Message-Id: <20240922064026.496422-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20240922064026.496422-1-W_Armin@gmx.de>
References: <20240922064026.496422-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T7np9KYag3uEbNY7iVclFrnqk1x+1dhOU3DbnPXnBJljhRCJ7+q
 IEMhKTXD4W+uZTtiwW96CRCbzXu6MpbMkwkbQR7Ll+2XWDynM66Y83svwX3zWxNvr/usmK5
 lnxI7tZBoSVVMId2dh1MqWX15sIEXXoS5QeGKuI84DqdgL6eXCr1rcTXFl3WREwuoz9BGa9
 HPmDKacLnmaO2IBkpsspA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3fLpkX8iGE0=;CmWOcmyxk+8UxNgvk2jox2fkHuP
 DH9oBlYzG+cNvCUQhOHQsojURWgWgnQboKsUlJVUKEszFOJCAmzg/pGZoII0bOMqGU0mUihIK
 p4tORM+3Ab3fbUy0gYJIphDkGzoACIFa+LDtg6u3GjCz7z1sfrbI9CeZrpLAg0mI6GivvR1D4
 NEFNkGIJA6SJ1fpPrgLkF99j6crqAW76EPo063xNFVtBgbCRhugV+0BOpT4u9FbU4SCP/rblt
 rWLFjUDgKXEfQWUTSPTlfkS+vSsZu4irN0mc3pl11qcGOwEkKMXF/RA7BIsj4QFAaZHM25Tlq
 UMuXoxWbUqgtTv44y1vC4fvvJhmrJ/YG7SqPK0DjHnW2d6TSRx2C8fkMgTYx6bvazqxKwqwIb
 NHOE1Dom7AimjyFQ4y5o6Ut8VPQH3mTfyybBJeB7Ftoa9MQfPQobzg8/YLLTpL5RKRQ6E62Px
 6CukWM3QZWaqNr+obhHOd/l3x09hU7Zwxyk5vzUV2ntzR5R32187YkwfKFuuwprMlYx7013Z+
 2mcVbmkyo+5222bf8xf4aZdEDLtqRTTd8lR4X6/y/Wf8MLjA0f+FTEJs8bMAnaCJiLyaub8HF
 n/EA/IZQZS5d5ifG+4tdV67HhH9ty9WmQf9kK8p1dyqVYLcuI5Xj/snrzKUTOIUdjNfmONRU0
 bo7gliiMoT+t4/YF4nlLvNb3UyjvyYOlANLeRw4BiCcjraS+30LN8bALjGD/5EotrLCZHVDM6
 fFlV/a/7dhGExvLeTwPhhvFEkfVNtWqjWLeL3Xkj7/8X+ktCrL2XsqJ7oD+iR6pjk9/o2JvFG
 JPmQIGZf7YQFAOpnprNuMFe0sGqHbWXgj9ah3wxkvsH+0=

Move the conditional locking from __battery_hook_unregister()
into battery_hook_unregister() and rename the low-level function
to simplify the locking during battery hook removal.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index da3a879d638a..10e9136897a7 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -706,28 +706,28 @@ static LIST_HEAD(acpi_battery_list);
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

@@ -753,7 +753,7 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)
 			 * hooks.
 			 */
 			pr_err("extension failed to load: %s", hook->name);
-			__battery_hook_unregister(hook, 0);
+			battery_hook_unregister_unlocked(hook);
 			goto end;
 		}

@@ -807,7 +807,7 @@ static void battery_hook_add_battery(struct acpi_batte=
ry *battery)
 			 */
 			pr_err("error in extension, unloading: %s",
 					hook_node->name);
-			__battery_hook_unregister(hook_node, 0);
+			battery_hook_unregister_unlocked(hook_node);
 		}
 	}
 	mutex_unlock(&hook_mutex);
@@ -840,7 +840,7 @@ static void __exit battery_hook_exit(void)
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


