Return-Path: <linux-acpi+bounces-7674-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E1095742A
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70F628552B
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 19:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321CD1D54DA;
	Mon, 19 Aug 2024 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K23Tcdhw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E372F26AD3;
	Mon, 19 Aug 2024 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724094572; cv=none; b=EjVJs8S6g3rnAkS9OmGqEpo9G4UgwjVhipqPP0thyHyOnv+PNYmEfFIZDq5TLuopCBgGP/BdpTml5Sh+qa5AS1A5a+5VXo4mLOUm8mVkGVLr5EAIMirRfgFPLqoGX2/rEZY9U5aAQKOnfZOf4Z/Td/eFsIfvFGQrpY/CmWua8ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724094572; c=relaxed/simple;
	bh=l1fQ+yTpICnSE9dSKG3BDMX4w4n0NCxmJvBhJmEGqB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YfmKR2vLYolwXbpssIP3hMZZMPEeluOd9BbKrl035u+OkzhFo6MH/X9ts4aXofWzqL9FYe06vrDqP87jrvFJ02sZUP1N656SOlDGnAFyhUv2e2zlTQEDqpURSLsgwrvK5LJ+w/2iG2EYcn2Dd1yrP6pXLnN9TaIl2E01l/ZRQlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K23Tcdhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA725C32782;
	Mon, 19 Aug 2024 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724094570;
	bh=l1fQ+yTpICnSE9dSKG3BDMX4w4n0NCxmJvBhJmEGqB4=;
	h=From:Date:Subject:To:Cc:From;
	b=K23Tcdhww1EkxB49+rm3W650EQEZDN1DZ4pOCr70a90bg1W+mWxNTIBGEWrzOsxdQ
	 /EMvooiFf+IIqBl8ZSoQCK8gk7stYV/9fyjK02RANiVANd/6bgf7+Q5IrHJjrna605
	 3sfHSfexgVMRk/2N4SkoZbxhj8+tC6DqFIWHxeBXqQycXeOOgo/FgAXugNSB5QqnQd
	 BGm7TQf7Psk8yCRfi2AJ47B1ggcOG9vOBhF0CqU7QPKErO3V2LFOMe5HDklGyEDSNZ
	 eDL8qvPfw/Z5Alg22hFsgjYJiusCxk9w5Ue/Q5gJ7AZag2sYHD3Sl9TdjiH5tIFs9a
	 1v5qjV10mlL+A==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 19 Aug 2024 12:09:22 -0700
Subject: [PATCH] ACPI: platform-profile: Fix CFI violation when accessing
 sysfs files
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGGYw2YC/x2N0QqDMAxFf0XyvIB2E52/Msbo2sQF1JZ0iCD+u
 8HHw7mcu0MhFSowVDsorVIkLQbNrYLw88tIKNEYXO0edd880YcsmCf/56TzJ2timQhZNgwsuEo
 yZQ2M5Lq+a+/f2DJYLSvZ6Hp6vY/jBPDv3sd5AAAA
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Mark Pearson <markpearson@lenovo.com>, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org, John Rowley <lkml@johnrowley.me>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3849; i=nathan@kernel.org;
 h=from:subject:message-id; bh=l1fQ+yTpICnSE9dSKG3BDMX4w4n0NCxmJvBhJmEGqB4=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGmHZ2T2TtC8LPzCnU3tVVZbYM1K5QeVO3XXH7z8tl5qm
 ZXRmVnrO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEToQzMlzhUrrvE5x5tJHp
 V6pu56JiJXVdg/zMql8a0md81XYt+M/IsLj3AuOdt5MmRYmFBQg+OKRncsTvgeXsCesluSUjrvv
 P4AQA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

When an attribute group is created with sysfs_create_group(), the
->sysfs_ops() callback is set to kobj_sysfs_ops, which sets the ->show()
and ->store() callbacks to kobj_attr_show() and kobj_attr_store()
respectively. These functions use container_of() to get the respective
callback from the passed attribute, meaning that these callbacks need to
be the same type as the callbacks in 'struct kobj_attribute'.

However, the platform_profile sysfs functions have the type of the
->show() and ->store() callbacks in 'struct device_attribute', which
results a CFI violation when accessing platform_profile or
platform_profile_choices under /sys/firmware/acpi because the types do
not match:

  CFI failure at kobj_attr_show+0x19/0x30 (target: platform_profile_choices_show+0x0/0x140; expected type: 0x7a69590c)

This happens to work because the layout of 'struct kobj_attribute' and
'struct device_attribute' are the same, so the container_of() cast
happens to allow the callbacks to still work.

Change the type of platform_profile_choices_show() and
platform_profile_{show,store}() to match the callbacks in
'struct kobj_attribute' and update the attribute variables to match,
which resolves the CFI violation.

Cc: stable@vger.kernel.org
Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
Reported-by: John Rowley <lkml@johnrowley.me>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
Tested-by: John Rowley <lkml@johnrowley.me>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/platform_profile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a1..11278f785526 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -22,8 +22,8 @@ static const char * const profile_names[] = {
 };
 static_assert(ARRAY_SIZE(profile_names) == PLATFORM_PROFILE_LAST);
 
-static ssize_t platform_profile_choices_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	int len = 0;
@@ -49,8 +49,8 @@ static ssize_t platform_profile_choices_show(struct device *dev,
 	return len;
 }
 
-static ssize_t platform_profile_show(struct device *dev,
-					struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+					struct kobj_attribute *attr,
 					char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_BALANCED;
@@ -77,8 +77,8 @@ static ssize_t platform_profile_show(struct device *dev,
 	return sysfs_emit(buf, "%s\n", profile_names[profile]);
 }
 
-static ssize_t platform_profile_store(struct device *dev,
-			    struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+			    struct kobj_attribute *attr,
 			    const char *buf, size_t count)
 {
 	int err, i;
@@ -115,12 +115,12 @@ static ssize_t platform_profile_store(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR_RO(platform_profile_choices);
-static DEVICE_ATTR_RW(platform_profile);
+static struct kobj_attribute attr_platform_profile_choices = __ATTR_RO(platform_profile_choices);
+static struct kobj_attribute attr_platform_profile = __ATTR_RW(platform_profile);
 
 static struct attribute *platform_profile_attrs[] = {
-	&dev_attr_platform_profile_choices.attr,
-	&dev_attr_platform_profile.attr,
+	&attr_platform_profile_choices.attr,
+	&attr_platform_profile.attr,
 	NULL
 };
 

---
base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
change-id: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


