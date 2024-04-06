Return-Path: <linux-acpi+bounces-4687-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD7389A7C5
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 02:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C3B22F00
	for <lists+linux-acpi@lfdr.de>; Sat,  6 Apr 2024 00:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4501CD13;
	Sat,  6 Apr 2024 00:01:51 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from irl.hu (irl.hu [95.85.9.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A47374EB;
	Sat,  6 Apr 2024 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.85.9.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361711; cv=none; b=kANSs4+q4maCFbfkz0hyhcPNOPVhPjHWmCP/usHIE2p5g4+8baNn3T2UwtMAAZjw82U5WO1V3TlFtXhaREDlgXiy/z5q9YGIkNC61POF11rQf3qBs5dU1Um4u0Mzb4Bfrj9KXMDS0b+caRRlKd/pSDrspUG6a+hldISZP8HK1gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361711; c=relaxed/simple;
	bh=jDfFOIqdI4WU8ZptpCWpiWScAHZGn68u/HHOO16s4Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YX3NVUgTFipjg4dPxOZOu4WUANBDvCi0aRktz7ZpxExPRA1X9MwVpIXctlOyZoXJ0R+PwpReIKKmpEsmRP/bnsYgsi26J8vzR7CuF9tVjZOMPrELhmTM59tiNKZCFiXpwyfcKEb6njrrcNtpubHDzvnyKt6QyDE++ZGWY9kqPgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu; spf=pass smtp.mailfrom=irl.hu; arc=none smtp.client-ip=95.85.9.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=irl.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=irl.hu
Received: from fedori.lan (51b69f53.dsl.pool.telekom.hu [::ffff:81.182.159.83])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F99A.00000000661090EB.0025D55B; Sat, 06 Apr 2024 02:01:47 +0200
From: Gergo Koteles <soyer@irl.hu>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
  Len Brown <lenb@kernel.org>, Ike Panhc <ike.pan@canonical.com>,
  Hans de Goede <hdegoede@redhat.com>,
  =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
  Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
  Daniel Lezcano <daniel.lezcano@linaro.org>,
  =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
  platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
  Gergo Koteles <soyer@irl.hu>
Subject: [PATCH v5 1/3] ACPI: platform-profile: add platform_profile_cycle()
Date: Sat,  6 Apr 2024 02:01:31 +0200
Message-ID: <afd975d98708921f67a269aaf031a1dd1be1220d.1712360639.git.soyer@irl.hu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712360639.git.soyer@irl.hu>
References: <cover.1712360639.git.soyer@irl.hu>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0

Some laptops have a key to switch platform profiles.

Add a platform_profile_cycle() function to cycle between the enabled
profiles.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/acpi/platform_profile.c  | 39 ++++++++++++++++++++++++++++++++
 include/linux/platform_profile.h |  1 +
 2 files changed, 40 insertions(+)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d418462ab791..acc606af812a 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -136,6 +136,45 @@ void platform_profile_notify(void)
 }
 EXPORT_SYMBOL_GPL(platform_profile_notify);
 
+int platform_profile_cycle(void)
+{
+	enum platform_profile_option profile;
+	enum platform_profile_option next;
+	int err;
+
+	err = mutex_lock_interruptible(&profile_lock);
+	if (err)
+		return err;
+
+	if (!cur_profile) {
+		mutex_unlock(&profile_lock);
+		return -ENODEV;
+	}
+
+	err = cur_profile->profile_get(cur_profile, &profile);
+	if (err) {
+		mutex_unlock(&profile_lock);
+		return err;
+	}
+
+	next = find_next_bit_wrap(cur_profile->choices,
+				  ARRAY_SIZE(profile_names), profile + 1);
+
+	if (WARN_ON(next == ARRAY_SIZE(profile_names))) {
+		mutex_unlock(&profile_lock);
+		return -EINVAL;
+	}
+
+	err = cur_profile->profile_set(cur_profile, next);
+	mutex_unlock(&profile_lock);
+
+	if (!err)
+		sysfs_notify(acpi_kobj, NULL, "platform_profile");
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(platform_profile_cycle);
+
 int platform_profile_register(struct platform_profile_handler *pprof)
 {
 	int err;
diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index e5cbb6841f3a..f5492ed413f3 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -36,6 +36,7 @@ struct platform_profile_handler {
 
 int platform_profile_register(struct platform_profile_handler *pprof);
 int platform_profile_remove(void);
+int platform_profile_cycle(void);
 void platform_profile_notify(void);
 
 #endif  /*_PLATFORM_PROFILE_H_*/
-- 
2.44.0


