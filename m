Return-Path: <linux-acpi+bounces-13780-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D252ABAF45
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464A1189979E
	for <lists+linux-acpi@lfdr.de>; Sun, 18 May 2025 10:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161A42135C5;
	Sun, 18 May 2025 10:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XzmFaBEd"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CD5212B07;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747563521; cv=none; b=iR3jnSZMmjAiCYhxkBhhAf4dgXJLmg15EbsFIwuroTWE409kbYie+Wq7s3aEHpfgU+3y0KM8fY797gbV35kK8Gldewnuk1is1VtASpk5OlK+zJ8KzR+tYXaRaa8a25UI7QO0DmF8PzusxL3je6SRHluObiawl4KkNEHXU6ClpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747563521; c=relaxed/simple;
	bh=aVJrjK39DSynV0njKAvRApf87m93tSsBJqU1s3Im3Ew=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=na0+4w/QNdXpNnmouTZ8XNH4dJ3JWGIpHGx3M4uS9CYbfBWfBfkpohCYwKBFjjzC2JXby86hlDG8VCLazB9FB5Tc4ALsW+ndDhZohfcaGCNjukWqOU49cTMnMK1zXOHxsP7+4zAMi6Bq7ku95SbbvUg87QaRxRqbEgXPYTqPX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XzmFaBEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 598D3C4CEEB;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747563521;
	bh=aVJrjK39DSynV0njKAvRApf87m93tSsBJqU1s3Im3Ew=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XzmFaBEdQ7gifcZQi8RBOtlalPUMpJbiTubfs4PKBvtFYiLU+3E8TIBJt+2/lkScH
	 g10jFjFnxeEelCezOSj3Hvsd2EyJWmZ1tEDoaUQygpfNNA/6pph6ZyxjDRVxWOorAe
	 OV4Lucc9eT2r39rxK7y7UuwNFo/UGZ/6xwSOhxKMzn2z9SU2HNYrUmb5qple0MJD80
	 0AoByw0+K9dWRPKV2M0v0ee/dW2ie50qWrPnWmL1bwfTGfVV6BU0GPyVKT0Lv/O/2H
	 fMkop9BfAZNpq4SkHDOyRHMAL3fTndNEuHY4DgzpdHQlUxuFzxanCPjaukBYfouIVa
	 TRYde9iIsjvoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47739C3ABDD;
	Sun, 18 May 2025 10:18:41 +0000 (UTC)
From: Janne Grunau via B4 Relay <devnull+j.jannau.net@kernel.org>
Date: Sun, 18 May 2025 12:18:37 +0200
Subject: [PATCH 1/2] ACPI: platform_profile: Stub platform_profile_cycle
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-hid_lenovo_acpi_dependency-v1-1-afdb93b5d1a6@jannau.net>
References: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
In-Reply-To: <20250518-hid_lenovo_acpi_dependency-v1-0-afdb93b5d1a6@jannau.net>
To: Arnd Bergmann <arnd@arndb.de>, Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-acpi@vger.kernel.org, Janne Grunau <j@jannau.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1409; i=j@jannau.net;
 s=yk2024; h=from:subject:message-id;
 bh=OlgPj4E6TaBNRe/5BROdqUQFmhB+Ec3RjhF6hKrPB94=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhgzNLQwMvefyyg6k51d8+nXzxaWpjaLL3963U9ziGrCYa
 9vn0NXiHaUsDGJcDLJiiixJ2i87GFbXKMbUPgiDmcPKBDaEi1MAJmJsxPC/Nmj9vTNGkdz9k5+k
 vrUzZLu3jbP4/HuLdat3axvdi/g/kZGhaR1v/oqd240U1GxmHutKFRdX5+S+eu7k68bre1czLDj
 ICwA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-Endpoint-Received: by B4 Relay for j@jannau.net/yk2024 with auth_id=264
X-Original-From: Janne Grunau <j@jannau.net>
Reply-To: j@jannau.net

From: Janne Grunau <j@jannau.net>

This is required to allow USB/Bluetooth HID devices to cycle through
platform profiles without depending on ACPI. Commit 52572cde8b4a4
("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE") added this
dependency for hid-lenovo which is used for external USB and Bluetooth
devices.

Fixes: 52572cde8b4a4 ("HID: lenovo: select CONFIG_ACPI_PLATFORM_PROFILE")
Signed-off-by: Janne Grunau <j@jannau.net>
---
 include/linux/platform_profile.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/platform_profile.h b/include/linux/platform_profile.h
index a299225ab92e78ce2e978b1774cdfc95cc688e8f..05a6749991601fd373683c3d498c6e9cc4f97882 100644
--- a/include/linux/platform_profile.h
+++ b/include/linux/platform_profile.h
@@ -54,7 +54,18 @@ void platform_profile_remove(struct device *dev);
 struct device *devm_platform_profile_register(struct device *dev, const char *name,
 					      void *drvdata,
 					      const struct platform_profile_ops *ops);
+#ifdef CONFIG_ACPI_PLATFORM_PROFILE
 int platform_profile_cycle(void);
+#else
+/*
+ * This stub is needed to allow USB/Bluetooth HID drivers to cycle through
+ * platform profiles.
+ */
+static inline int platform_profile_cycle(void)
+{
+	return 0;
+}
+#endif /* CONFIG_ACPI_PLATFORM_PROFILE */
 void platform_profile_notify(struct device *dev);
 
 #endif  /*_PLATFORM_PROFILE_H_*/

-- 
2.49.0



