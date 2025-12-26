Return-Path: <linux-acpi+bounces-19862-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2E2CDE985
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F66C3006AA4
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCE29A307;
	Fri, 26 Dec 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BLCgJE+W"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB118479;
	Fri, 26 Dec 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766745202; cv=none; b=j6XlkNDlVooE96JIJma0is/qrvURDInCAzSXxTg1mY0062lfcZgI+fOQdlK5onkJ1pKvzlR3Kh+1x1fRyf+wHOvrz5H5M0PbKse03sk6qzOAfONUfH9Sm+ki1qs6nMS9I+bwY/ygupRWX/HCXGx279xdzFw5YyDvMyVZpGD52b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766745202; c=relaxed/simple;
	bh=KctfpyIEpIPYB4mHIWJEdk7L0bUqUBoP5bWqMmAm8JY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPgKa0EnydUaCxUIfSE0WePGr1hfHfBoirCsKqCq/gY7vrHy7G49RzqbQzh6p+3kYP8JPR1efDKPB0nM3zMD3wGXT76Yf5Czs23Q5KAl6Msfu4lxhcNlw7YVd+Da7e81bLx88iKQlszkMMcdWlD2Qt5urZiqRDmPePpZVUg6pj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BLCgJE+W; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 0A9305E545;
	Fri, 26 Dec 2025 12:27:46 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 1B2F85E550;
	Fri, 26 Dec 2025 12:27:45 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id C04C3200D51;
	Fri, 26 Dec 2025 12:27:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744864;
	bh=n9mpJSPwpXWXzmQPXHG/E/RkCR3w/MEYONhtJcXWMls=; h=From:To:Subject;
	b=BLCgJE+W2GRfoJsKrTCA1TTpEgDqDIgpgO7kkXWleLz8ySEFBjVnLS5GHaf9c1Fdu
	 Gi6CHdAXMkQpndXmFl5cCuur6jgXSuiHpytKKWBSIau/2YIZ8EL6Qi9zT+pUwSebQg
	 j9ai3Ti4aWJ2jbwSSh4hZ1/p9ZsEzNkriFMGj/+iW+m+PSaUkEqVOwwaF+HSiEGI3T
	 g7J+16gk+YJG3ulzWe4sGhfQhBV8W2yl0G0sJDAygROu0leLbszbakQRsWQ9o2QXFi
	 BKvZQrMKAi8LWQ2EMZjbTDTP2YITCoCqXiIyniysMpSn4N9JWO3tPeszWjQc+4qUlK
	 qqPz4jVgRXocQ==
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
Subject: [RFC v1 3/8] acpi/x86: s2idle: add runtime standby transition
 function
Date: Fri, 26 Dec 2025 12:26:41 +0200
Message-ID: <20251226102656.6296-4-lkml@antheas.dev>
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
 <176674486420.2608355.10993945246372674856@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Add pm_standby_transition() to allow transitioning between standby
states during runtime and implement it as part of the s2idle suspend
sequence. Update the platform_s2idle_ops structure to include a function
to perform firmware notifications and a function to get supported states

Standby states are a way for userspace to indicate the interactivity of
the system at the current moment. Active means that the user is
interacting with the device, inactive that a user is not actively
interacting with the device, and sleep that the system should appear as
if it is suspended to the user, but may still perform small
background tasks.

For modern ACPI s0ix laptops, the inactive state turns off the
backlight and the sleep state may limit the thermal envelope of the
device. Either may pulse the power light. This patch introduces an ACPI
agnostic structure to handle these transitions, so they may implemented
by other platforms, and does not implement them for ACPI.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 include/linux/suspend.h |  26 +++++++
 kernel/power/suspend.c  | 153 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38..916dee124758 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -40,6 +40,25 @@ typedef int __bitwise suspend_state_t;
 #define PM_SUSPEND_MIN		PM_SUSPEND_TO_IDLE
 #define PM_SUSPEND_MAX		((__force suspend_state_t) 4)
 
+typedef int __bitwise standby_state_t;
+
+#define PM_STANDBY_ACTIVE	((__force standby_state_t) 0)
+#define PM_STANDBY_INACTIVE	((__force standby_state_t) 1)
+#define PM_STANDBY_SLEEP	((__force standby_state_t) 2)
+#define PM_STANDBY_RESUME	((__force standby_state_t) 3)
+#define PM_STANDBY_MIN		PM_STANDBY_ACTIVE
+#define PM_STANDBY_MAX		((__force standby_state_t) 4)
+
+typedef int __bitwise standby_notification_t;
+
+#define PM_SN_INACTIVE_ENTRY	((__force standby_notification_t) 0)
+#define PM_SN_INACTIVE_EXIT	((__force standby_notification_t) 1)
+#define PM_SN_SLEEP_ENTRY	((__force standby_notification_t) 2)
+#define PM_SN_SLEEP_EXIT	((__force standby_notification_t) 3)
+#define PM_SN_RESUME		((__force standby_notification_t) 4)
+#define PM_SN_MIN		PM_STANDBY_DISPLAY_OFF
+#define PM_SN_MAX		((__force standby_notification_t) 5)
+
 /**
  * struct platform_suspend_ops - Callbacks for managing platform dependent
  *	system sleep states.
@@ -132,6 +151,8 @@ struct platform_suspend_ops {
 };
 
 struct platform_s2idle_ops {
+	u8 (*get_standby_states)(void);
+	int (*do_notification)(standby_notification_t state);
 	int (*begin)(void);
 	int (*prepare)(void);
 	int (*prepare_late)(void);
@@ -276,6 +297,11 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+
+extern void pm_standby_refresh_states(void);
+extern int pm_standby_transition(standby_state_t state);
+extern void pm_standby_set_state(standby_state_t state);
+extern int pm_standby_get_state(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 2da4482bb6eb..ede1ba483fa5 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -46,12 +46,21 @@ static const char * const mem_sleep_labels[] = {
 	[PM_SUSPEND_MEM] = "deep",
 };
 const char *mem_sleep_states[PM_SUSPEND_MAX];
+static const char * const standby_labels[] = {
+	[PM_STANDBY_ACTIVE] = "active",
+	[PM_STANDBY_INACTIVE] = "inactive",
+	[PM_STANDBY_SLEEP] = "sleep",
+	[PM_STANDBY_RESUME] = "resume",
+};
+const char *standby_states[PM_STANDBY_MAX];
 
 suspend_state_t mem_sleep_current = PM_SUSPEND_TO_IDLE;
 suspend_state_t mem_sleep_default = PM_SUSPEND_MAX;
 suspend_state_t pm_suspend_target_state;
 EXPORT_SYMBOL_GPL(pm_suspend_target_state);
 
+standby_state_t standby_current = PM_STANDBY_ACTIVE;
+
 unsigned int pm_suspend_global_flags;
 EXPORT_SYMBOL_GPL(pm_suspend_global_flags);
 
@@ -195,6 +204,9 @@ void __init pm_states_init(void)
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
 	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+
+	/* Always support the active runtime standby state. */
+	standby_states[PM_STANDBY_ACTIVE] = standby_labels[PM_STANDBY_ACTIVE];
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -334,6 +346,141 @@ static bool platform_suspend_again(suspend_state_t state)
 		suspend_ops->suspend_again() : false;
 }
 
+static int platform_standby_notify(standby_notification_t state)
+{
+	return s2idle_ops && s2idle_ops->do_notification ?
+		       s2idle_ops->do_notification(state) :
+		       0;
+}
+
+/**
+ * pm_standby_refresh_states - Refresh the supported runtime standby states
+ */
+void pm_standby_refresh_states(void)
+{
+	u8 standby_support = s2idle_ops && s2idle_ops->get_standby_states ?
+				     s2idle_ops->get_standby_states() :
+				     0;
+
+	standby_states[PM_STANDBY_INACTIVE] =
+		standby_support & BIT(PM_STANDBY_INACTIVE) ?
+			standby_labels[PM_STANDBY_INACTIVE] :
+			NULL;
+	standby_states[PM_STANDBY_SLEEP] =
+		standby_support & BIT(PM_STANDBY_SLEEP) ?
+			standby_labels[PM_STANDBY_SLEEP] :
+			NULL;
+	standby_states[PM_STANDBY_RESUME] =
+		standby_support & BIT(PM_STANDBY_RESUME) ?
+			standby_labels[PM_STANDBY_RESUME] :
+			NULL;
+}
+EXPORT_SYMBOL_GPL(pm_standby_refresh_states);
+
+/**
+ * pm_standby_transition - Transition between standby states
+ *
+ * Configure the runtime standby state of the system. Entering these states
+ * may change the appearance of the system (e.g., keyboard backlight) or limit
+ * the thermal envelope of the system (e.g., PLx to 5W).
+ *
+ * Returns an error if the transition fails. The function does not rollback.
+ */
+int pm_standby_transition(standby_state_t state)
+{
+	int error;
+
+	if (state == standby_current)
+		return 0;
+	if (state > PM_STANDBY_MAX)
+		return -EINVAL;
+
+	pm_standby_refresh_states();
+
+	pm_pr_dbg("Transitioning from standby state %s to %s\n",
+		  standby_states[standby_current], standby_states[state]);
+
+	/* Resume can only be entered if we are on the sleep state. */
+	if (state == PM_STANDBY_RESUME) {
+		if (standby_current != PM_STANDBY_SLEEP)
+			return -EINVAL;
+		standby_current = PM_STANDBY_RESUME;
+		return platform_standby_notify(PM_SN_RESUME);
+	}
+
+	/*
+	 * The system should not be able to re-enter Sleep from resume as it
+	 * is undefined behavior. As part of setting the state to "Resume",
+	 * userspace promised a transition to "Inactive" or "Active".
+	 */
+	if (standby_current == PM_STANDBY_RESUME && state == PM_STANDBY_SLEEP)
+		return -EINVAL;
+
+	/* Resume is the Sleep state logic-wise. */
+	if (standby_current == PM_STANDBY_RESUME)
+		standby_current = PM_STANDBY_SLEEP;
+
+	if (standby_current < state) {
+		for (; standby_current < state; standby_current++) {
+			switch (standby_current + 1) {
+			case PM_STANDBY_INACTIVE:
+				error = platform_standby_notify(PM_SN_INACTIVE_ENTRY);
+				break;
+			case PM_STANDBY_SLEEP:
+				error = platform_standby_notify(PM_SN_SLEEP_ENTRY);
+				break;
+			}
+
+			if (error) {
+				/* Rollback to previous valid state */
+				while (standby_current > PM_STANDBY_ACTIVE &&
+				       !standby_states[standby_current])
+					standby_current--;
+				return error;
+			}
+		}
+	} else if (standby_current > state) {
+		for (; standby_current > state; standby_current--) {
+			switch (standby_current) {
+			case PM_STANDBY_SLEEP:
+				error = platform_standby_notify(PM_SN_SLEEP_EXIT);
+				break;
+			case PM_STANDBY_INACTIVE:
+				error = platform_standby_notify(PM_SN_INACTIVE_EXIT);
+				break;
+			}
+
+			if (error) {
+				/* Rollback to previous valid state */
+				while (standby_current < PM_STANDBY_SLEEP &&
+				       !standby_states[standby_current])
+					standby_current++;
+				return error;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pm_standby_set_state - Set the current standby state and skip the transition
+ */
+void pm_standby_set_state(standby_state_t state)
+{
+	standby_current = state;
+}
+EXPORT_SYMBOL_GPL(pm_standby_set_state);
+
+/**
+ * pm_standby_get_state - Returns the current standby state
+ */
+int pm_standby_get_state(void)
+{
+	return standby_current;
+}
+EXPORT_SYMBOL_GPL(pm_standby_get_state);
+
 #ifdef CONFIG_PM_DEBUG
 static unsigned int pm_test_delay = 5;
 module_param(pm_test_delay, uint, 0644);
@@ -572,6 +719,7 @@ static void suspend_finish(void)
  */
 static int enter_state(suspend_state_t state)
 {
+	standby_state_t standby_prior;
 	int error;
 
 	trace_suspend_resume(TPS("suspend_enter"), state, true);
@@ -588,6 +736,9 @@ static int enter_state(suspend_state_t state)
 	if (!mutex_trylock(&system_transition_mutex))
 		return -EBUSY;
 
+	standby_prior = standby_current;
+	pm_standby_transition(PM_STANDBY_SLEEP);
+
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
@@ -619,6 +770,8 @@ static int enter_state(suspend_state_t state)
 	pm_pr_dbg("Finishing wakeup.\n");
 	suspend_finish();
  Unlock:
+	pm_standby_transition(standby_prior);
+
 	mutex_unlock(&system_transition_mutex);
 	return error;
 }
-- 
2.52.0



