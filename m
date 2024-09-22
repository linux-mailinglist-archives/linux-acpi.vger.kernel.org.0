Return-Path: <linux-acpi+bounces-8363-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B63D97E057
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 08:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C3B1F213C4
	for <lists+linux-acpi@lfdr.de>; Sun, 22 Sep 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A885D193416;
	Sun, 22 Sep 2024 06:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Hfnv1No8"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76249192B84;
	Sun, 22 Sep 2024 06:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726987251; cv=none; b=sSGxrN6V1qd+CZgyEdtEQscNxZemCUfF1iYTzuIb0suFHWjMCu3zH/mrSE4bG76MS2AajzAXSpTScqBQNDDPsZ1kSNleCpZE7qHMDe5lWiWjxxP1S/Xgoxhy+Dm0xPedNcjRhGF2IE4017ulLR2tem64Ob3nAzdmf2conNja4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726987251; c=relaxed/simple;
	bh=7EKPq1By31iy4+3m8HPLcZT9DyoKRKr1fIZ3P/0R2zo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=omKJ6cvwujU8WpnwzNAQ3SDs+bUc1pX5hQbhDTeO3DaNo6/mABaqMa4ufJdSH1wS4Tdez6g/ErcasT7zWtnjceabrdInFXn2uUcBpMPsBpA6WMWzz2xnhg9+pb/JOISUlfL7MiPM0OTiVwyQoi7kuVXDY3Ej5lBjcsNNuaRUSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Hfnv1No8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726987236; x=1727592036; i=w_armin@gmx.de;
	bh=V5StzW4LA8uvP7+ScgSDLOyMk+nvdOwL3xbCGZkTW8w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Hfnv1No8s7jdcHkpzbMnaweK1DWGF0ZtWUCekFbNM3SPpRcBosBAVjA+y41asALH
	 7G2d0kP1cVbaSMobdLFPlxpipnKFnEzX/n+VcS5KAfQ3pWsU/cAIIxjoWMsZTgnxd
	 Don17L1eUP3QaqmFhIkau9+L5bd4rgkQrdWW9FtG+BcaE3Ilhmdd8UTFBKo+vpO9l
	 mOgRmYWkf4qz/zpaxyXNlkz1wwhVaiYSAfj0LCe7BxvgKgfHGWZvl/bUJI/X8kEct
	 FTArHDZQycIRoVKz8o6b+/CYgkRbDfzNRRf97w2jP9ZkRkqudSAJP2u6Qss6H/d13
	 kN48c/+l2yoptmvFeA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MVvPJ-1sQWda3cST-00Ro50; Sun, 22 Sep 2024 08:40:35 +0200
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
Subject: [PATCH v2 2/3] ACPI: battery: Fix possible crash when unregistering a battery hook
Date: Sun, 22 Sep 2024 08:40:25 +0200
Message-Id: <20240922064026.496422-3-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:gpOC2/nb/ukWoQXwnCPRneIftGzaHWRoTLr3dFHi4S2UM7wwYJO
 y4cyGmfT3Ty4+zDkRcRfDuKc2kLIvXyGCBW0faci22TJJ1UtlxUKXF9IenDKVidWRjsaHsQ
 yWussq19NO43E5AXqGeWPlFa/y8fG9sO7vG4yxmMpPwYJ+GUpb3hIh9lej7uX58w5K1ooea
 SHPa3gdNOK1CN5qHv/PcQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WBFFszxG25k=;g/J5Fcl9Lw+oqIpKMdZBpY57277
 xP8akA8fzl2ZBFMOp5kNnMJOGLeupLRbo6pbujhfIGr7ZLQ1bvDsHU3i91UPWTbItIBbAURxP
 6Gpd6x7ca3WhfovFRfEXBYINGW+ddTDAZ/HAweDCVG2Zp8MBhoIfUI9JZKUHLNPRSblehytHd
 F3a4fPSNCttn6Xh+Y/GpWkPzOularH2H/MuFqphtDpmTOSShDvdjduiiVYpyd0n9a/GP0BFsv
 Fl9YiL/WHtOOU+ozQ7WV80ibiSG4HbAUSF7nQ4WXBUxctpwHp71iDjpBA1VlNKhNs47GrNNf7
 ecl2jCbyuWCB2wdKaPIebpeH8Ltk/Ni7MgPyiXGG/k+hVKa6Zd75IVAg52nBvjFJSLtpYIpaJ
 a2mZ3du2WJ4IIPTqNYcdgVSHcn42bY9FKra+b/jKMWZQrvvsZs7WiAPgL+jxtaGbN7fOFC5iF
 MU+/WjyouIhyrCs7cgJ+GhLlCO3uKta8bSPnJ1IVKVMoph1LJDBsmfL8mdDnMCAhCroiIjfW+
 Tox6ew8w13T8KTpgUMdln9IpKRseX6kwP6agkUzk9Ur2Dtom7uGeASR22eqh2bUNa/Js+Cxmo
 Ml7EbY/yvpJX049XPJAJn6E7tgjuyrui/q+FRfGPHH36WsWIG1K3M3jxJ8yLQOSAiE4LEMEO7
 yBBJhSrlP/QBrWSuK4A1Y9DvQ0HOAv6P/RHMIhLqoFdtkNIrJBreegtzN0oQXKAErb/MVpkZc
 p4mN+s4Emq6o4xQAjSVLcqCYMb7rqG6sE4ktvpXOD/Jc7meoODnfj9se4/S90CpHs4FMwqoRx
 BJkdY0vZmi12cpdYLKOMF3BQ==

When a battery hook returns an error when adding a new battery, then
the battery hook is automatically unregistered.
However the battery hook provider cannot know that, so it will later
call battery_hook_unregister() on the already unregistered battery
hook, resulting in a crash.

Fix this by using a boolean flag to mark already unregistered battery
hooks as "dead" so that they can be ignored by
battery_hook_unregister().

Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 11 ++++++++++-
 include/acpi/battery.h |  1 +
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 10e9136897a7..b31a6183a082 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -719,6 +719,7 @@ static void battery_hook_unregister_unlocked(struct ac=
pi_battery_hook *hook)
 			power_supply_changed(battery->bat);
 	}
 	list_del(&hook->list);
+	hook->dead =3D true;

 	pr_info("extension unregistered: %s\n", hook->name);
 }
@@ -726,7 +727,14 @@ static void battery_hook_unregister_unlocked(struct a=
cpi_battery_hook *hook)
 void battery_hook_unregister(struct acpi_battery_hook *hook)
 {
 	mutex_lock(&hook_mutex);
-	battery_hook_unregister_unlocked(hook);
+	/*
+	 * Ignore already unregistered battery hooks. This might happen
+	 * if a battery hook was previously unloaded due to an error when
+	 * adding a new battery.
+	 */
+	if (!hook->dead)
+		battery_hook_unregister_unlocked(hook);
+
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);
@@ -737,6 +745,7 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)

 	mutex_lock(&hook_mutex);
 	INIT_LIST_HEAD(&hook->list);
+	hook->dead =3D false;
 	list_add(&hook->list, &battery_hook_list);
 	/*
 	 * Now that the driver is registered, we need
diff --git a/include/acpi/battery.h b/include/acpi/battery.h
index c93f16dfb944..5cfe132bb7f5 100644
=2D-- a/include/acpi/battery.h
+++ b/include/acpi/battery.h
@@ -16,6 +16,7 @@ struct acpi_battery_hook {
 	int (*add_battery)(struct power_supply *battery, struct acpi_battery_hoo=
k *hook);
 	int (*remove_battery)(struct power_supply *battery, struct acpi_battery_=
hook *hook);
 	struct list_head list;
+	bool dead;
 };

 void battery_hook_register(struct acpi_battery_hook *hook);
=2D-
2.39.5


