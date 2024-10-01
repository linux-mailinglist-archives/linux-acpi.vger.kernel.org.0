Return-Path: <linux-acpi+bounces-8523-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAC698C79B
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 23:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491011F22756
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Oct 2024 21:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5C1CEACE;
	Tue,  1 Oct 2024 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rwtWe6hC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4B6322E;
	Tue,  1 Oct 2024 21:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727818140; cv=none; b=frZQJEH75+7LrgCN7kAp1lfLC9u2EqgJ7xxHd08mKNzcKou/1K6q/t+0mS43gvESN6LPsbiPCuMs3jdmXzqp9fF/8FL2LDFxRJPG1L1XU2V1pEy0IpsWEM7L7MgdZ3pPwjRjX2B0oSQNLoZSokfL/Q1c4IkgMk4iUK6fP4mlSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727818140; c=relaxed/simple;
	bh=HSgmYOiPjTS+Y7k55CMsqRvyzjtSPq2GUW0pjz5carE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ExXEItPmQiiPC08oGLkPTOLiNYf8ZYsFzs14sEP0sM1/FXh+th7TKJIG4uTnTJbmmzFrHXtL41RAPyUO31SMY2dkHs35Z406kFdotZ8Bx/lr3x+MtbYCj+XVMXBRKXB52W6mTCHPXSAB/uvjtvoVJHvtarqGGLgPv3+z2/4H4+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rwtWe6hC; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727818125; x=1728422925; i=w_armin@gmx.de;
	bh=wnm+2LUKJumpZZKg7ux4iBcF5swPdX4Q7oXTV5DFeCc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rwtWe6hC2/+zlvUiiNAq6zmKD4DdkdnpDYZcI7W1mcKWoksxlXok5NAw0X1flciW
	 tY4wMWWj4uGzhmRCss8EQuQaQycsVfqG5f5nQkX34c517w4o3VSbL3CKBTdy1g6DR
	 0l8OuZpCBWtFhhxOrZDIXrn3I73zIVvS62At8llbhVqMgIonGkEDnMaKUoPmj61aC
	 FMJWuda1dHCj2RkD9UloQtEDc7qG+aLZ2J2Ts0nHgFw/uVSBzRMDwAX22xdGdjt5s
	 lE0wJvpSOOD8vYblXTTNsqE0vrsKK13J3N9QbXBJHyRjg531eL1kZWSlFydJcwh4g
	 uMzOCWfdkr93u3DjRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MBUmD-1skR5m0G3r-00GuXx; Tue, 01 Oct 2024 23:28:45 +0200
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
Subject: [PATCH RESEND v3 2/3] ACPI: battery: Fix possible crash when unregistering a battery hook
Date: Tue,  1 Oct 2024 23:28:34 +0200
Message-Id: <20241001212835.341788-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241001212835.341788-1-W_Armin@gmx.de>
References: <20241001212835.341788-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HbmhkhuJank0diWHw2R8aalQ2wrO18QkAEZH4K0IOV1d+cZFoNU
 WnbBpuYxFVaMjcv/Wv7czwPahb/wqiu5XdvObPp5/qJYCUdUSbeaWbF8rZaJKCd48IjrtNY
 z1FlIwNdX3iPt+hkGCOxfY5B+ggm4+wUDTOU8LdhoS98/pSZPUVuWf5zDx6LeaGUZylWxaz
 f3AcsbKj2MjEHnVnGs35w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:anvl3W1DNEA=;iW2UEA65vG3+h/IzA/s08Qj6ir+
 2YF21LrJNxCg++m4kG95jCSHms8IbRKewn9ugt9C6nqzmzlc7lVUYWY7baVKViD3GSen13Wi2
 /HIdM0+CDhEclgA7OIhyWa9w0QTVAHkbLF10mCUmf4959jEu9Rkq0iYc/9aeC1yleMC7R28+E
 AY0BHwcrys+jdr5AG96FmeK8LF+cVVa69yruuD3p60Bu9EewYcc2bIDK8dpDzb+RVSJet8l39
 jOIdVX33ZlEzn9ygR1lupK/FdGM9s+agrh/59pEOpyvGCyOz3tboVmdphfBcbEsIRB5IldmK1
 yFoPQfce2aITY6uCjx7/ZEByGGEyyoe58ETr1bwqi1BRTl8B62R4AD3NSGG2QvmmqhI0VuUow
 NLrgWl8T1Pap6K1ycPIm8X2xfrm4z9ZGzepo7eWYnvAivUZn7cAuJjvtUdeTMirw8j67rQ8Gu
 UPr2rvY7Yc40yY8bxf+TKjLZH0iL5R5KMnPnTKwfiuuj77PeFlV7an3EVR+JjRktC7TVmW5S5
 ga9vKG138KqSeJLgz8eNhcJBE3wYfg0aX33g04WG5poHo27PZOR0wXvPeZXKGY2KEMnSFL0oD
 QoZhNzmYUNxkdiM9agfocfayLpo0pWpiTyIfbC8wXDW9TLSf8mVh5W8jnrUCERcCIRCkTSx48
 7kAYy8Iux8kh7CdwqgwBUL0XyaYBvxJFuD+XBG0czdbOdiNs5NiLNtBOVoPPKzeoa13WMxhrd
 c1+X+AVETPv+j04RJFCMTpRzbLU9llTeF7syPlUo0aIrWIHXO8EszImOEIBr6wbSLb4JcJzDt
 Cn3/JgyUe19gKUO8kt2mqz4Q==

When a battery hook returns an error when adding a new battery, then
the battery hook is automatically unregistered.
However the battery hook provider cannot know that, so it will later
call battery_hook_unregister() on the already unregistered battery
hook, resulting in a crash.

Fix this by using the list head to mark already unregistered battery
hooks as already being unregistered so that they can be ignored by
battery_hook_unregister().

Fixes: fa93854f7a7e ("battery: Add the battery hooking API")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index dda59ee5a11e..1c45ff6dbb83 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -715,7 +715,7 @@ static void battery_hook_unregister_unlocked(struct ac=
pi_battery_hook *hook)
 		if (!hook->remove_battery(battery->bat, hook))
 			power_supply_changed(battery->bat);
 	}
-	list_del(&hook->list);
+	list_del_init(&hook->list);

 	pr_info("extension unregistered: %s\n", hook->name);
 }
@@ -723,7 +723,14 @@ static void battery_hook_unregister_unlocked(struct a=
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
+	if (!list_empty(&hook->list))
+		battery_hook_unregister_unlocked(hook);
+
 	mutex_unlock(&hook_mutex);
 }
 EXPORT_SYMBOL_GPL(battery_hook_unregister);
@@ -733,7 +740,6 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)
 	struct acpi_battery *battery;

 	mutex_lock(&hook_mutex);
-	INIT_LIST_HEAD(&hook->list);
 	list_add(&hook->list, &battery_hook_list);
 	/*
 	 * Now that the driver is registered, we need
=2D-
2.39.5


