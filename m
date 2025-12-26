Return-Path: <linux-acpi+bounces-19858-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD83CDE96A
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA22302EF7E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Dec 2025 10:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B0F318131;
	Fri, 26 Dec 2025 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="gJJ+JH7B"
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay10.grserver.gr (relay10.grserver.gr [37.27.248.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866013164BD;
	Fri, 26 Dec 2025 10:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.27.248.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766744877; cv=none; b=VM3hJqmKOywzCEXzPw039z21WkrCduy6TISqrZOVLlNhQJI/i50hg3I824U+/NFLoEPlcDv/YQ9z6chhrPeeASGS/PfO9/nNjsxlDJH5Usm7WIPMIaxBSx3UPLVxRKVR7y8LMZcSko76KeOfgTvDq737VH28enRD/2tkQ8XPDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766744877; c=relaxed/simple;
	bh=2RmJMnjXqESrVBOlyCF4D7Fzx3SWx0PCqIRQbL78fkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oliluQcAl5Dv2/jes4yKVDmffWE6UM+n65Y0RYRMh6vNb9BNOgPa9gTG2kJsJxWSMv3e1rDF6Or1mnx12V8nSrReBynNPJt/g4mjrBq7p6kUlP8NBFtVqTouiUMGQYfIP3jPD3d5SOxnV9zoNfzj09RKmaw/0lKrqWHQqBLZO+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=gJJ+JH7B; arc=none smtp.client-ip=37.27.248.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay10 (localhost.localdomain [127.0.0.1])
	by relay10.grserver.gr (Proxmox) with ESMTP id 10D203F41B;
	Fri, 26 Dec 2025 12:27:53 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay10.grserver.gr (Proxmox) with ESMTPS id 872D83F3B9;
	Fri, 26 Dec 2025 12:27:52 +0200 (EET)
Received: from antheas-z13 (unknown [IPv6:2a02:2149:8a28:c200:ffd7:3bf6:9efd:b472])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 623CD200D69;
	Fri, 26 Dec 2025 12:27:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1766744872;
	bh=1K2j6fb9op9Z8JpPuuVJ8hc0VtRGxEEvu4tC0cvyOHk=; h=From:To:Subject;
	b=gJJ+JH7BntLBCI3aRGj8A62fS1GcM4dysJm/cHleZ9meama5c48FyOvvPymQYY6Bi
	 PT9e9t5VCuoagWJ9vqZOkSID+lFmCmtKQ3qyPsdMh6oaGD1OFQjNqQaF+VIEWEAFty
	 g4NrLuB/tT1FYB5HLtcfsUwU3Tgz5yI+o12JbDesxDrOrtLX23xOMadBB5Ng7zM+pE
	 Q9ukl43coCSbqnqYw8hqLzw/PX3b2Jn4YaZXAULpcoHYiuCMd1wOxOK7ECUL/Wta9k
	 30x6i0UAwBtuqXlpb7Ul4iQm4JWQkNc4Ix70PE8oe+ZQZq19JHOsZ2W39N8kFW9yEI
	 fsUl3koOhVDyw==
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
Subject: [RFC v1 7/8] PM: hibernate: Enter s2idle sleep state before
 hibernation
Date: Fri, 26 Dec 2025 12:26:45 +0200
Message-ID: <20251226102656.6296-8-lkml@antheas.dev>
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
 <176674487195.2608645.14321434662587507445@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

Implement the standby states as part of hibernation. Specifically,
ensure we are in the inactive state before hibernation entry, and
sync the state as active after hibernation resume. In case of a failed
hibernation, restore the previous standby state.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 kernel/power/hibernate.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index af8d07bafe02..85a5ca8f6537 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -787,7 +787,11 @@ static int load_image_and_restore(void)
  */
 int hibernate(void)
 {
+#ifdef CONFIG_SUSPEND
+	standby_state_t previous_standby;
+#endif
 	bool snapshot_test = false;
+	bool powered_down = false;
 	unsigned int sleep_flags;
 	int error;
 
@@ -815,6 +819,13 @@ int hibernate(void)
 	}
 
 	pr_info("hibernation entry\n");
+
+#if CONFIG_SUSPEND
+	/* Enter the standby screen off state in case userspace has not. */
+	previous_standby = pm_standby_get_state();
+	pm_standby_transition(PM_STANDBY_INACTIVE);
+#endif
+
 	pm_prepare_console();
 	error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
 	if (error)
@@ -867,10 +878,12 @@ int hibernate(void)
 		error = swsusp_write(flags);
 		swsusp_free();
 		if (!error) {
-			if (hibernation_mode == HIBERNATION_TEST_RESUME)
+			if (hibernation_mode == HIBERNATION_TEST_RESUME) {
 				snapshot_test = true;
-			else
+			} else {
+				powered_down = true;
 				power_down();
+			}
 		}
 		in_suspend = 0;
 		pm_restore_gfp_mask();
@@ -897,6 +910,18 @@ int hibernate(void)
  Notify:
 	pm_notifier_call_chain(PM_POST_HIBERNATION);
  Restore:
+#if CONFIG_SUSPEND
+	/*
+	 * If we resumed from S5, we are in the active standby state. However,
+	 * the kernel restored a stale value. Sync it. Otherwise, in e.g., the
+	 * case of a failed hibernation, transition to the previous value.
+	 */
+	if (powered_down)
+		pm_standby_set_state(PM_STANDBY_ACTIVE);
+	else
+		pm_standby_transition(previous_standby);
+#endif
+
 	pm_restore_console();
 	hibernate_release();
  Unlock:
-- 
2.52.0



