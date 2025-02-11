Return-Path: <linux-acpi+bounces-10994-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C40CA3017A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 03:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69FA27A153A
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Feb 2025 02:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3E6433C0;
	Tue, 11 Feb 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKr82Q/c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206979C0;
	Tue, 11 Feb 2025 02:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240913; cv=none; b=ih+22JbmXOC7ZfA+rXYd/udR9oqEtuVtf0XD8u+Hi+Q8FR3FxktiAvd1nVt9j1QIkeBIf+4CSSRyWWVkRULvT/Gy2Ej5RwRWRDTILD3XlhJgFSlGw+Hz+k2SoyPFix+HmroaD3pobykC4BpKM2IQjXFRASBw4cpWj7Ysu4r/Qrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240913; c=relaxed/simple;
	bh=iTjzNwKewvmLzaCQagxyKDVXUVMNYwcrtDjaQM3gppg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oadewpRKDv2+fJbqSz57KDRlYShFebx0/RFOCobinXTvZ9Y0oDEFCvaPn2NZkXC/Gkf2dLjNxhmoo1BGux5jRl3W6GtehK3JrniNklDp7tbJDu4mpkILicDmAxK5HZt7pEV+LksczzxFB6LJLDN46dPt7zfJjBJ3mKhm7hsQN9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKr82Q/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FBF4C4CED1;
	Tue, 11 Feb 2025 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739240913;
	bh=iTjzNwKewvmLzaCQagxyKDVXUVMNYwcrtDjaQM3gppg=;
	h=From:Date:Subject:To:Cc:From;
	b=VKr82Q/cLYkXPxs7/4SjA1T8sL4Ut5cgGO4Ap2nTh4Loc2/gy9nfuE6kgpOewbs4R
	 Kg/OsoATbwL4RY4CDNS/jSygTBaRdFcJHnSJIymjmvfB/OtHDUwncs/m521Niaus0+
	 +00oCrVbU6fiZeML4YhrrEHcdToCcNONbdjVtmM462N+Sl486sceXJjyv9AXg9/nxQ
	 +pZvsz4a1Kp2MiuVBDjCm2TsvjBONKkn+PUpe83VWfF+dgmDF62dByBnn6YL/1Wuau
	 c5PbEXhfCjSKPptvUrUXvzen3goP/Em5mZo025yU4hPFBKdXnZkfZPomX1Nyyefqmm
	 CGuRsZdn5zozQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 10 Feb 2025 21:28:25 -0500
Subject: [PATCH v3] ACPI: platform-profile: Fix CFI violation when
 accessing sysfs files
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-acpi-platform_profile-fix-cfi-violation-v3-1-ed9e9901c33a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMi1qmcC/5WNQQ6CMBBFr2K6dgwtBYor72GMQTqFiUibljQaw
 t0tLEzc6fLN/Lw3s4CeMLDjbmYeIwWyY4J8v2Nt34wdAunETGRCZorX0LSOwA3NZKx/XJ23hgY
 EQ09oDUEkm17JARpFpaoiv+nCsGRzHtNoK50viXsKk/WvLRz5ev2/ETlwkFWdl4VWUpnydEc/4
 nCwvmNrJIqPmHOufheLJC6FMXUhVCY1fomXZXkDGloBgTgBAAA=
X-Change-ID: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 Mario Limonciello <mario.limonciello@amd.com>, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org, John Rowley <lkml@johnrowley.me>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5348; i=nathan@kernel.org;
 h=from:subject:message-id; bh=iTjzNwKewvmLzaCQagxyKDVXUVMNYwcrtDjaQM3gppg=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmrtp5blaIVvLV1SeXyV/Y8noURHTvfFfz83GHJ3nX74
 qyHzyZM6ShlYRDjYpAVU2Spfqx63NBwzlnGG6cmwcxhZQIZwsDFKQATmejKyNDoO7P1ok4wQ9Il
 PQOPk0pqqxTUPZ5Z7D13q5GhcDOvqxHDP+s/fybdeKM8YxuTuMHFScKS5sdc5QycZjq8b18sV3N
 JihkA
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

There is no functional issue from the type mismatch because the layout
of 'struct kobj_attribute' and 'struct device_attribute' are the same,
so the container_of() cast does not break anything aside from CFI.

Change the type of platform_profile_choices_show() and
platform_profile_{show,store}() to match the callbacks in
'struct kobj_attribute' and update the attribute variables to match,
which resolves the CFI violation.

Cc: stable@vger.kernel.org
Fixes: a2ff95e018f1 ("ACPI: platform: Add platform profile support")
Reported-by: John Rowley <lkml@johnrowley.me>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2047
Tested-by: John Rowley <lkml@johnrowley.me>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Changes in v3:
- Rebase on 6.14-rc1, which includes updates to the driver to address
  Greg's previous concerns but this change is still needed for the
  legacy sysfs interface. v2 can be used for the stable backport.
- Link to v2: https://lore.kernel.org/r/20241118-acpi-platform_profile-fix-cfi-violation-v2-1-62ff952804de@kernel.org

Changes in v2:
- Rebase on linux-pm/acpi
- Pick up Sami's reviewed-by tag
- Adjust wording around why there is no functional issue from the
  mismatched types
- Link to v1: https://lore.kernel.org/r/20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org
---
 drivers/acpi/platform_profile.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index fc92e43d0fe9..1b6317f759f9 100644
--- a/drivers/acpi/platform_profile.c
+++ b/drivers/acpi/platform_profile.c
@@ -260,14 +260,14 @@ static int _aggregate_choices(struct device *dev, void *data)
 
 /**
  * platform_profile_choices_show - Show the available profile choices for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
  *
  * Return: The number of bytes written
  */
-static ssize_t platform_profile_choices_show(struct device *dev,
-					     struct device_attribute *attr,
+static ssize_t platform_profile_choices_show(struct kobject *kobj,
+					     struct kobj_attribute *attr,
 					     char *buf)
 {
 	unsigned long aggregate[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
@@ -333,14 +333,14 @@ static int _store_and_notify(struct device *dev, void *data)
 
 /**
  * platform_profile_show - Show the current profile for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to write to
  *
  * Return: The number of bytes written
  */
-static ssize_t platform_profile_show(struct device *dev,
-				     struct device_attribute *attr,
+static ssize_t platform_profile_show(struct kobject *kobj,
+				     struct kobj_attribute *attr,
 				     char *buf)
 {
 	enum platform_profile_option profile = PLATFORM_PROFILE_LAST;
@@ -362,15 +362,15 @@ static ssize_t platform_profile_show(struct device *dev,
 
 /**
  * platform_profile_store - Set the profile for legacy sysfs interface
- * @dev: The device
+ * @kobj: The kobject
  * @attr: The attribute
  * @buf: The buffer to read from
  * @count: The number of bytes to read
  *
  * Return: The number of bytes read
  */
-static ssize_t platform_profile_store(struct device *dev,
-				      struct device_attribute *attr,
+static ssize_t platform_profile_store(struct kobject *kobj,
+				      struct kobj_attribute *attr,
 				      const char *buf, size_t count)
 {
 	unsigned long choices[BITS_TO_LONGS(PLATFORM_PROFILE_LAST)];
@@ -401,12 +401,12 @@ static ssize_t platform_profile_store(struct device *dev,
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
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


