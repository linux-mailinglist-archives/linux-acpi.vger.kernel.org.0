Return-Path: <linux-acpi+bounces-18673-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F26AC41555
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 19:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB4954EFDEC
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 18:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA9633B975;
	Fri,  7 Nov 2025 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="DnNKWtv+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83862338593;
	Fri,  7 Nov 2025 18:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541134; cv=none; b=C4R2nvOeTKCyzdrM3iBmMz56q7a7hJw/20XrmMc7+AlJAW1ZDuA0R7MU/40KJqdWwTavELMUgdtmmGukFRSwMgOcZpHa/swJN5SnJqpehqVBXjw4FuA24tBDFoXssnMQIiEgmzDYz/zG6yXoc5s0vjyns/7mRaoMpezX4Obkn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541134; c=relaxed/simple;
	bh=xXmvoJ0fKBqNUDweBaWsvebE39hNADx8jJYSuxdv35A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gCdJUvzQ1viSaAT3L9VDtU/3oJt+BXV79DKVlUlaaFwmYwfss8JIY98EKlvNk6wYwQbluW2kqvdYP4bqZy5XgBUT2bewHZ3dpZW5cgfGVOO2pTP08nBkNly7A3v/9V9Itd3HIJh0WFFjKUkopjSUckKBzSpzapVDzCMGr7AtY10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=DnNKWtv+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762541130;
	bh=xXmvoJ0fKBqNUDweBaWsvebE39hNADx8jJYSuxdv35A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DnNKWtv+rB/0BdGYpARjhf9sHNvwJZ8ACTDYkp6vu2tQoT8hZ93JOgxfeyv8BUvSL
	 cYYzGuIu7vYeYoHC1Mysi4EQlx5HNj7zGLGxJQzcitZRAWevQUHWqX5IKisSx9qSf7
	 3Hwvuca4CR2Hm8nNtVO/haQKDPFJ3qxfGXWYJ4193kFLhx3okjLIpe4Y0xbbSni8Tj
	 rlfIeyS6Fu28/5Za0vLbiZHah1AtNerWnCqWEVdeGR354BPhUw7RHfwGsLFwkTvp+W
	 hC3sYr+sDnocadiF84nHNpqe/njnsv+xxOkzJJ4JXoMgq5ym1YNUBAzRrIMBNr04Ku
	 UC7EVhcN0wWKQ==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2223E17E139C;
	Fri,  7 Nov 2025 19:45:26 +0100 (CET)
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
Subject: [PATCH 3/4] Input: Ignore the KEY_POWER events if hibernation is in progress
Date: Fri,  7 Nov 2025 23:44:30 +0500
Message-ID: <20251107184438.1328717-4-usama.anjum@collabora.com>
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

Input (Serio) drivers call input_handle_event(). Although the serio
drivers have duplicate events, they have separate code path and call
input_handle_event(). Ignore the KEY_POWER such that this event isn't
sent to the userspace if hibernation is in progress.

Abort the hibernation by calling pm_wakeup_dev_event(). In case of serio,
doesn't have wakeup source registered, this call doesn't do anything.
But there may be other input drivers which will require this.

Without this, the event is sent to the userspace and it suspends the
device after hibernation cancellation.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since RFC:
- Use pm_sleep_transition_in_progress()
- Update description
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a500e1e276c21..7939bd9e47668 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -26,6 +26,7 @@
 #include <linux/kstrtox.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/suspend.h>
 #include "input-compat.h"
 #include "input-core-private.h"
 #include "input-poller.h"
@@ -362,6 +363,11 @@ void input_handle_event(struct input_dev *dev,
 
 	lockdep_assert_held(&dev->event_lock);
 
+	if (code == KEY_POWER && pm_sleep_transition_in_progress()) {
+		pm_wakeup_dev_event(&dev->dev, 0, true);
+		return;
+	}
+
 	disposition = input_get_disposition(dev, type, code, &value);
 	if (disposition != INPUT_IGNORE_EVENT) {
 		if (type != EV_SYN)
-- 
2.47.3


