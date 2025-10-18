Return-Path: <linux-acpi+bounces-17941-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870A4BED15F
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AE919C0CB6
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5F2F9DA0;
	Sat, 18 Oct 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TD+8zrys"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC8F2D47EE;
	Sat, 18 Oct 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797330; cv=none; b=qzDlvd/C2EL94kJOpyWfPxWQYbqmUjk/nJY6kceL8meJtlo9EdclTwPtC80C71pPOy+L8iTQw4YlIO5RynLy5YCPwUQfDPxb5vWHUwO/SKQaqAbiPaRhHOLWsxsWKIPT0qG8tWzCTZRYmDHUm2Iu95khR7/LOBJuKT3Jl8u7YxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797330; c=relaxed/simple;
	bh=0GCM+sC4vUY2XQf0nMipoEUodjdAnH62YcPJ2JBPJ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IaJE8NQHKaCd30HWwW7RL+77/CTIsnTHZN6oaNJjwkG7eNQT+2X80XIlgWUEldjDA/bQPVKVmqK6Gr80ijucHoyzTyEnNl6aEBDGbAjsXYHKZLj6UVM916+JLVQEBaGl5KBvpZHnHyjdqdptcVreyxTPzPvwCNXL1Si8N7ERBfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TD+8zrys; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760797326;
	bh=0GCM+sC4vUY2XQf0nMipoEUodjdAnH62YcPJ2JBPJ8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TD+8zryswrNSzOq+8mjBD5lLX2QRNXnHv0MQbMGvTwcjNF5J4e/0ZBdEzSBGRJr0e
	 +2XhOFnpB055YcsgojqGBpvX8IHd+kF2UmqBzeHzq9DQGRm/1U6qEjQSe7/ffcSO3n
	 w3E8LidbVdJXn9OaOP73UhkKiEBrX+OD8JynpLk2sfJLIwqbmJ8EJUsTuCG7sjBTVv
	 7rz2KxikMRwu8JqwXjHjUXQJD+XH2Dr3qnQvPni5yUCeU47wxNnJZEj1qCHNf9IAu6
	 odj53/098mKCIpz8QtdqVBVVfhpKxOwZIMHXdbC/n1htn0tQk3GQvBbyl/wbQO4GYb
	 ntdPCvSn/T5SQ==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66F2017E13E0;
	Sat, 18 Oct 2025 16:22:04 +0200 (CEST)
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
Subject: [RFC 3/4] Input: Ignore the KEY_POWER events if hibernation is in progress
Date: Sat, 18 Oct 2025 19:21:06 +0500
Message-ID: <20251018142114.897445-4-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251018142114.897445-1-usama.anjum@collabora.com>
References: <20251018142114.897445-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Serio drivers call input_handle_event(). Although the serio drivers have
duplicate events, they have separate code path and call
input_handle_event(). Ignore the KEY_POWER such that this event isn't
sent to the userspace if hibernation is in progress.

Abort the hibernation by calling pm awake API as well.

Without this, the event is sent to the userspace and it suspends the
device after hibernation cancellation.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 drivers/input/input.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a500e1e276c21..0979f18aae6a2 100644
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
 
+	if (code == KEY_POWER && hibernation_in_progress()) {
+		pm_wakeup_dev_event(&dev->dev, 0, true);
+		return;
+	}
+
 	disposition = input_get_disposition(dev, type, code, &value);
 	if (disposition != INPUT_IGNORE_EVENT) {
 		if (type != EV_SYN)
-- 
2.47.3


