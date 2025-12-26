Return-Path: <linux-acpi+bounces-19859-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 261E3CDE970
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17833032733
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582931814A;
	Fri, 26 Dec 2025 10:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="I9d0Fo5w"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DE3316907;
	Fri, 26 Dec 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766744878; cv=none; b=dTOIu9iqns5mInHbP04kkonob9rQEuefwIndvl2N6a65wBqBIvlqyx3kTAzRsxHSmc4o39sETVljLrn9JZAQHGUcQN92dvFCKFIlZ+PcKJi0jhMMHwuiLWQaPVJ0cQNRZHCBHSaiYPDiVCQsZv29C316X06CHD+vbuOG6chGI4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766744878; c=relaxed/simple;
	bh=GN5FkH2/IWa3xOeAAgG18W6llFXZ1m3UcJYJb7HlAc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0RuRxvfSfUerr8QhfRW7Wbj9rgRsNOpYV8LLjCLEb/bzv/+1dsfUTeDoFuv0qVrj60hemd0L4uk6XjtZ6S0s7411th97KPVbkXYBbrhPZtuF2rHUYnNjiRtgsPxGdPL4fPtao1jsj4kBMfdhWC+jHQifMw9OjNziqUvP9rPTUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=I9d0Fo5w; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id DAC9BBDA4F;
	Fri, 26 Dec 2025 12:27:54 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 4C88FBC770;
	Fri, 26 Dec 2025 12:27:54 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 5EA99200D44;
	Fri, 26 Dec 2025 12:27:52 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744874;
	bh=94tJEPb5R4/RMYGeb/XvgeZRhmptqhLSfjBLob/O9UU=; h=From:To:Subject;
	b=I9d0Fo5wUYP2pfVOKr96fFGDjZ8tDfFspm2Z+2C/iNWe/7uAB6YdTQ+AfbmdPF+hc
	 vbzseoWtKPpXWjtiTCwamUaeeboaFJ7LNNdmu/vQ93BFbKrvz6Y7k9Yiw6pid9pPbA
	 UpFtHJujfxXLedP7dnjwIjSIsDnAVj3u6wm3eEvSDW1q189YckCjXjmDLk3sXc3D0G
	 E6WwHDzu3pzs/fmf5+N8eRIVhkISA1W0PiHKXE/QXSJVsjAnYSRTjtKHMwuGKWh+VX
	 /+iIKsrqtZq/LEf4ZqAur+rSX7idBr/8NXU7KrJRGYRt1PU/1wP4CzzTSl61MJtqCs
	 qIdsYyHySS9tw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: dmitry.osipenko@collabora.com
Cc: bob.beckett@collabora.com,
	bookeldor@gmail.com,
	hadess@hadess.net,
	jaap@haitsma.org,
	kernel@collabora.com,
	lennart@poettering.net,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkml@antheas.dev,
	mccann@jhu.edu,
	rafael@kernel.org,
	richard@hughsie.com,
	sebastian.reichel@collabora.com,
	superm1@kernel.org,
	systemd-devel@lists.freedesktop.org,
	xaver.hugl@gmail.com
Subject: [RFC v1 8/8] PM: standby: Add sysfs attribute for runtime standby
 transitions
Date: Fri, 26 Dec 2025 12:26:46 +0200
Message-ID: <20251226102656.6296-9-lkml@antheas.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251226102656.6296-1-lkml@antheas.dev>
References: <20251226102656.6296-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176674487387.2608731.11021375007848229427@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add a sysfs attribute to allow informing the kernel about the current
standby state of the device depending on user involvement, those being:
"active", "inactive", "sleep", and "resume" (in "sleep" but preparing
for presenting to the user faster).

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 kernel/power/main.c  | 84 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/power.h |  1 +
 2 files changed, 85 insertions(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 03b2c5495c77..30494be41557 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -830,6 +830,89 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 
 power_attr(state);
 
+#ifdef CONFIG_SUSPEND
+/*
+ * standby - control system s2idle standby state.
+ *
+ * show() returns available standby states, which may be "active", "screen_off",
+ * "sleep" and "resume" (still in sleep but preparing to present to user).
+ * See Documentation/admin-guide/pm/standby-states.rst for a description of
+ * what they mean.
+ *
+ * store() accepts one of those strings and initiates a transition to that
+ * standby state.
+ *
+ * For backwards compatibility, when the system suspends, it first enters the
+ * state "sleep", regardless of what was written into store() and then during
+ * resume restores the previous value.
+ */
+static ssize_t standby_show(struct kobject *kobj, struct kobj_attribute *attr,
+			    char *buf)
+{
+	unsigned int sleep_flags;
+	standby_state_t i, curr;
+	char *s = buf;
+
+	sleep_flags = lock_system_sleep();
+	pm_standby_refresh_states();
+	curr = pm_standby_get_state();
+	unlock_system_sleep(sleep_flags);
+
+	if (curr < 0)
+		return -EBUSY;
+
+	for (i = PM_STANDBY_MIN; i < PM_STANDBY_MAX; i++)
+		if (standby_states[i])
+			s += sprintf(s, curr == i ? "[%s] " : "%s ", standby_states[i]);
+
+	if (s != buf)
+		/* convert the last space to a newline */
+		*(s - 1) = '\n';
+	return (s - buf);
+}
+
+static standby_state_t decode_standby_state(const char *buf, size_t n)
+{
+	standby_state_t state;
+	char *p;
+	int len;
+
+	p = memchr(buf, '\n', n);
+	len = p ? p - buf : n;
+
+	for (state = PM_STANDBY_MIN; state < PM_STANDBY_MAX; state++) {
+		const char *label = standby_states[state];
+
+		if (label && len == strlen(label) && !strncmp(buf, label, len))
+			return state;
+	}
+
+	return PM_STANDBY_MAX;
+}
+
+static ssize_t standby_store(struct kobject *kobj, struct kobj_attribute *attr,
+			     const char *buf, size_t n)
+{
+	unsigned int sleep_flags;
+	standby_state_t state;
+	int error;
+
+	sleep_flags = lock_system_sleep();
+	pm_standby_refresh_states();
+	state = decode_standby_state(buf, n);
+
+	if (state >= PM_STANDBY_MAX)
+		return -EINVAL;
+
+	error = pm_standby_transition(state);
+	unlock_system_sleep(sleep_flags);
+
+	return error ? error : n;
+}
+
+power_attr(standby);
+#endif
+
 #ifdef CONFIG_PM_SLEEP
 /*
  * The 'wakeup_count' attribute, along with the functions defined in
@@ -1084,6 +1167,7 @@ static struct attribute * g[] = {
 #ifdef CONFIG_SUSPEND
 	&mem_sleep_attr.attr,
 	&sync_on_suspend_attr.attr,
+	&standby_attr.attr,
 #endif
 #ifdef CONFIG_PM_AUTOSLEEP
 	&autosleep_attr.attr,
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 75b63843886e..2327a1ce2b05 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -216,6 +216,7 @@ extern void swsusp_show_speed(ktime_t, ktime_t, unsigned int, char *);
 extern const char * const pm_labels[];
 extern const char *pm_states[];
 extern const char *mem_sleep_states[];
+extern const char *standby_states[];
 
 extern int suspend_devices_and_enter(suspend_state_t state);
 #else /* !CONFIG_SUSPEND */
-- 
2.52.0



