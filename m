Return-Path: <linux-acpi+bounces-18674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25987C41552
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 19:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294691899CDC
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 18:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFD933CE86;
	Fri,  7 Nov 2025 18:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="a68+iFZt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9593E33A018;
	Fri,  7 Nov 2025 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541138; cv=none; b=APhA2K1YjHHMoSxEf6LvrAqplKlxdTb0rpRNNCK9jXmeeprEzYKkxvTccq7vATVY+LiCYFtrPHtHv56epAhdiLVZ2j0JNOU0YZQeoN6Q0g3GUaE2ralUCbaHijBQFAKKe63X+nJjM8ke9lRipJxD1Q86NJtZFtElSs5Ug5ETkh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541138; c=relaxed/simple;
	bh=pMaB8Afh0kVsepOVHLiBuIVRvMz+wN1V9FeD5y8QKKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxLBgIW6vJGFZaER92Lh0Qsoo8t9qtZvSTi+VDAnYUSHIJDUBC30WBu3xwQsbWM9CrnJ9LS+1n7fuYkqsrr2tjnLqeyATdqcJUnrPyrAVX1MzZWV4xfXXJly8WWzapbt3hjoPHKiNd9yQk44nztNoxkXlWUYcW7VEUEc0IrL/20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=a68+iFZt; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762541135;
	bh=pMaB8Afh0kVsepOVHLiBuIVRvMz+wN1V9FeD5y8QKKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a68+iFZtXi+o+FKwXWjf/BzcpOjpRywybGV5OpY4oUNilY+6Eam/Xhn6KwMLmstoG
	 dXif6+axpRacotN2j9eJtI4xx9/uekNbg3OOqo7QoJf9fgxGQmyMDFVtWIM6Z14vFz
	 lLPSsoLCNEJ3N0dl5a0Lfg+wxBJP7zHMYF8cpgonYdskwhZTWKEKjpQttgLV74XjoU
	 gmVD9DGpAqCUqjAeQdR3F5UkdoN+s3o1KpqkswO7qmDJvIyn9j5TTAqfLEipBwPaC3
	 7aRt41KDNRwaWVYmat9QfssGNQdBdc/+N4yjhXGLXWmKDTJQgaMd26ZRfsaMKZR7pZ
	 QKf5l5OquOukw==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66ED317E108B;
	Fri,  7 Nov 2025 19:45:31 +0100 (CET)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	superm1@kernel.org
Subject: [PATCH 4/4] PM: sleep: clear pm_abort_suspend at suspend
Date: Fri,  7 Nov 2025 23:44:31 +0500
Message-ID: <20251107184438.1328717-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251107184438.1328717-1-usama.anjum@collabora.com>
References: <20251107184438.1328717-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clear pm_abort_suspend counter in case a wakeup is detected during
hibernation process. If this counter isn't reset, it'll affect the
next hibernation cycle and next time hibernation will not happen as
pm_abort_suspend is still positive.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/base/power/main.c | 2 ++
 kernel/cpu.c              | 1 +
 kernel/power/hibernate.c  | 5 ++++-
 kernel/power/process.c    | 1 +
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 5760abb25b591..84e76f8df1e02 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1642,6 +1642,7 @@ static void device_suspend_late(struct device *dev, pm_message_t state, bool asy
 		goto Complete;
 
 	if (pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
@@ -1887,6 +1888,7 @@ static void device_suspend(struct device *dev, pm_message_t state, bool async)
 
 	if (pm_wakeup_pending()) {
 		dev->power.direct_complete = false;
+		pm_wakeup_clear(0);
 		WRITE_ONCE(async_error, -EBUSY);
 		goto Complete;
 	}
diff --git a/kernel/cpu.c b/kernel/cpu.c
index db9f6c539b28c..74c9f6b4947dd 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1921,6 +1921,7 @@ int freeze_secondary_cpus(int primary)
 
 		if (pm_wakeup_pending()) {
 			pr_info("Wakeup pending. Abort CPU freeze\n");
+			pm_wakeup_clear(0);
 			error = -EBUSY;
 			break;
 		}
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index e15907f28c4cd..1f6b60df45d34 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -349,8 +349,10 @@ static int create_image(int platform_mode)
 		goto Enable_irqs;
 	}
 
-	if (hibernation_test(TEST_CORE) || pm_wakeup_pending())
+	if (hibernation_test(TEST_CORE) || pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		goto Power_up;
+	}
 
 	in_suspend = 1;
 	save_processor_state();
@@ -660,6 +662,7 @@ int hibernation_platform_enter(void)
 		goto Enable_irqs;
 
 	if (pm_wakeup_pending()) {
+		pm_wakeup_clear(0);
 		error = -EAGAIN;
 		goto Power_up;
 	}
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22b..e935b27a04ae0 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -67,6 +67,7 @@ static int try_to_freeze_tasks(bool user_only)
 			break;
 
 		if (pm_wakeup_pending()) {
+			pm_wakeup_clear(0);
 			wakeup = true;
 			break;
 		}
-- 
2.47.3


