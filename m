Return-Path: <linux-acpi+bounces-18671-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFF5C41531
	for <lists+linux-acpi@lfdr.de>; Fri, 07 Nov 2025 19:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168223AE75D
	for <lists+linux-acpi@lfdr.de>; Fri,  7 Nov 2025 18:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C998333A01A;
	Fri,  7 Nov 2025 18:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ndBaIEq+"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0232338593;
	Fri,  7 Nov 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762541125; cv=none; b=KIG6tAH9uPEGlxp1vQsdco2N5tfaNSjv0R44yqk6iCePCIU5vN20dOwwNG7xa8L4VNGF7DTR4SZIKEoOxLVx/QYOR62Wp4/2WayOqdy8hR8oxNztYKC2y6g3+9+78ieFshANQjNWvahT4WRrhbZ5njX+7hfaMMv5EOkD5coGdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762541125; c=relaxed/simple;
	bh=lLwaDEBgZ3XXm5ekoIesIjr8qgF4E0RS+/DB0seu4ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oyaU5yRzQwWvI0/YHRH7dyrlaUGJXUJYHxI00z1XLBytDWz07u9DIqnFnpj7+UYBzr866VTgiT5wD3UKmaQQx1gOI7aiwkT2sMZ14vGJDRAOhVM+AUEX4jEn0ZACZ0YwvICNDwyf89sjJKX7wyL/iz4KHsoLz5Tz8Boz7KRWSJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ndBaIEq+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1762541122;
	bh=lLwaDEBgZ3XXm5ekoIesIjr8qgF4E0RS+/DB0seu4ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndBaIEq+5KgEQ5J/OOp/DaF56bCw5VFLcuVivAXg2snLNuebSxv3uudXArsHrf1x3
	 S2tVRDcqBTKilDbxEOnbMLStBOT4RvSm9wgVSlfj1mFqirHsaGJlD8R+nw23J/wh6C
	 RFymf1VvVK2wDA7ubT17+qGlPPGh+IEpxEHXfqWnCl2sdshURMxELslpZ+3wxhfloQ
	 FAn7oW3jBE9tLoabiuNq+6+QAgrNrVQcJ7zg2ob2NA+0vA09yVDOU4dtcj6m/itjhe
	 Ot5nTGIfKPRMKdbW7GF5l/vR6i68ATVSsD5Od1VGwYlusH28OvEE92Rd1hUyAL9mkq
	 HGYalEUbEaSdQ==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 886BC17E107C;
	Fri,  7 Nov 2025 19:45:18 +0100 (CET)
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
Subject: [PATCH 1/4] PM: hibernate: export pm_sleep_transition_in_progress()
Date: Fri,  7 Nov 2025 23:44:28 +0500
Message-ID: <20251107184438.1328717-2-usama.anjum@collabora.com>
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

Export pm_sleep_transition_in_progress() to be used by other
modules.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 kernel/power/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 33a47ed15994f..ff3354b5be150 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -570,6 +570,7 @@ bool pm_sleep_transition_in_progress(void)
 {
 	return pm_suspend_in_progress() || hibernation_in_progress();
 }
+EXPORT_SYMBOL_GPL(pm_sleep_transition_in_progress);
 #endif /* CONFIG_PM_SLEEP */
 
 #ifdef CONFIG_PM_SLEEP_DEBUG
-- 
2.47.3


