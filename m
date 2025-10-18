Return-Path: <linux-acpi+bounces-17942-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02BBED177
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1662134EB70
	for <lists+linux-acpi@lfdr.de>; Sat, 18 Oct 2025 14:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AF42FB99F;
	Sat, 18 Oct 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="aaiiLurW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC002D193B;
	Sat, 18 Oct 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797331; cv=none; b=P1lDNbguBrPOQDjvObg1TQb4FMwOSORy1zFe09Odb989hs1f01ehJ71Ee5bRkxWKYk1knwk/kdMJUBl/DbObwGH7aVS+v20ephI0hNmLRi/embrmaS81w9EnhTZLvsS20knUH9Oo3DOvzxbFXu7Zhx1RwlpbN3tfVtNBABOoQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797331; c=relaxed/simple;
	bh=EqQ8MAIlBeL0HxmwV1J6+SA32Ee7gxWi1w10nll/Jdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+iGa3ZA3P/KPS3RoQeQOpUQxqoDeLZ6vShsOiIzdJIVqG0Ko6i88cUyVAl8FCEZAWEswyxq654iAX9cu+QKMvTL9L7p1ttHpEs+fjNiqYakrgMuOihsf7SDOShi9VGSZHv8fkNmM5Nq2+nh1PDI5rnVj7BdXVp04+NCs2fjl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=aaiiLurW; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760797321;
	bh=EqQ8MAIlBeL0HxmwV1J6+SA32Ee7gxWi1w10nll/Jdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aaiiLurWhMWtr8LCK/2dqu39r37+fdrvSOENK6GtOv1lP3Eo/QA5FQd+HuWgOLzMe
	 BB3tDBSZ7eY7SMl97xEqs1hlSfZW4Z0gF2UM2v7/T2+R13/buCJ6in0Wxi277e5Sav
	 2/rms0efZg56mg0XBt7IjDPfymZWktn0lc8aVeJTfVv+g0AIsPXcB/CsXF/FClibEP
	 TQvHkzu4dHP9YrjwLGmYyPgtP3kOcuYuTbaG3fDsMb30DU3IWpO35OIVBItjQYLL+x
	 rF44c5YKdGA+x+7GCeVp3QQBoUdLjTwstVePwRbMsV3TDkbflrQ7nqQoFh+lhxlZ/v
	 l1Fj4cWRpO+Yg==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C464E17E0DB7;
	Sat, 18 Oct 2025 16:21:58 +0200 (CEST)
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
Subject: [RFC 1/4] PM: hibernate: export hibernation_in_progress()
Date: Sat, 18 Oct 2025 19:21:04 +0500
Message-ID: <20251018142114.897445-2-usama.anjum@collabora.com>
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

Export hibernation_in_progress() to be used by other modules. Add its
signature when hibernation config isn't enabled as well.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 include/linux/suspend.h  | 2 ++
 kernel/power/hibernate.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b02876f1ae38a..348831cdb60e4 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -393,6 +393,7 @@ extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
 extern int hibernate(void);
 extern bool system_entering_hibernation(void);
 extern bool hibernation_available(void);
+extern bool hibernation_in_progress(void);
 asmlinkage int swsusp_save(void);
 extern struct pbe *restore_pblist;
 int pfn_is_nosave(unsigned long pfn);
@@ -412,6 +413,7 @@ static inline void hibernation_set_ops(const struct platform_hibernation_ops *op
 static inline int hibernate(void) { return -ENOSYS; }
 static inline bool system_entering_hibernation(void) { return false; }
 static inline bool hibernation_available(void) { return false; }
+static inline bool hibernation_in_progress(void) { return false; }
 
 static inline int hibernate_quiet_exec(int (*func)(void *data), void *data) {
 	return -ENOTSUPP;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 14e85ff235512..aadf82f57e868 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -105,6 +105,7 @@ bool hibernation_in_progress(void)
 {
 	return !atomic_read(&hibernate_atomic);
 }
+EXPORT_SYMBOL_GPL(hibernation_in_progress);
 
 bool hibernation_available(void)
 {
-- 
2.47.3


