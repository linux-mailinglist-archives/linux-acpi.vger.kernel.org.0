Return-Path: <linux-acpi+bounces-9637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E679D1369
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 15:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5399E284C5E
	for <lists+linux-acpi@lfdr.de>; Mon, 18 Nov 2024 14:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945C31B0F38;
	Mon, 18 Nov 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4aVcwCD"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF91ACE12;
	Mon, 18 Nov 2024 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731940800; cv=none; b=IfLjIC+LKxHZzfEVJBecuebgjZJytCFWBZVfhgMYfhJeAvIevBJZlcu6An7KehbMW83lXXgatyJdiGoTNWF4xi8HACCW+ht6hGTjryLPrNQJkrWOKI6/Q+ko0wAVLA3QBSgs5FDFfU2wxzMts3eZgINVBvuKACQqW9YFpes5m7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731940800; c=relaxed/simple;
	bh=VTEd3Ga9NE9gi5Kr6yGwOtdQn4jjIzWJchBVImY2QTo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WcAs1FvdJNUVHETaPT9TdKqL+185DcnK7vbnzf+8Vmj647gtb0ZKcCNskvQ8UyDRh3vpgeg8ho6gc0+QV3ITM5587aZAZmC6eI9DhXmGHn20SXFRRLewuSXl07RT6TABJAPH3HqoyHbiw8wk5pmiM/55JfqURy35h9MmFNIlKOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4aVcwCD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDA9C4CECC;
	Mon, 18 Nov 2024 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731940800;
	bh=VTEd3Ga9NE9gi5Kr6yGwOtdQn4jjIzWJchBVImY2QTo=;
	h=From:Date:Subject:To:Cc:From;
	b=j4aVcwCDmEQ8e7Tno0B28wagSdUXYyaoX5ziEYtxbDr6v5eHhuWbO+Zfcl+R6jwO1
	 dlMQ1FQhPlLZeAn/0A0ZGjv/jbVx1ZmNnRyp87UXtogBaCgTddFO0sJ+vDRsE5kt18
	 f9wiO+5if1noyGcVhrtloN4LLj8jllxlMGw+EbXiZLUaC9LkycnPjCYlPP45L85Kaq
	 ZVi4NtWx+oFePkM3QVdUdvF1mq9XZ0oW2syjMrUhatEjHyCyruikISdVEsDft8oRtG
	 hL6swui2NeV6afXoG+zzxW+aV0WE9RSpWT98CF56y5pl8pAy88qagZTNKMoeb1EO1i
	 4rnxmAhJbi6YQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 18 Nov 2024 07:39:32 -0700
Subject: [PATCH v2] ACPI: platform-profile: Fix CFI violation when
 accessing sysfs files
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241118-acpi-platform_profile-fix-cfi-violation-v2-1-62ff952804de@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKNRO2cC/5WNXQ6CMBCEr0L67Bpa/opP3sMQg3QLG5E2W9JoC
 He3cgMfv5nJfJsIyIRBXLJNMEYK5JYE6pSJYeqXEYFMYqFyVeZattAPnsDP/Wodv+6enaUZwdI
 bBksQyaUqfYBB1eimKh6msiK9ecY0Oky3LvFEYXX8OcRR/tL/HVGChLJpi7oyutS2vj6RF5zPj
 kfR7fv+BXGhoprfAAAA
X-Change-ID: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, 
 Mark Pearson <markpearson@lenovo.com>, Kees Cook <kees@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, patches@lists.linux.dev, 
 stable@vger.kernel.org, John Rowley <lkml@johnrowley.me>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4742; i=nathan@kernel.org;
 h=from:subject:message-id; bh=VTEd3Ga9NE9gi5Kr6yGwOtdQn4jjIzWJchBVImY2QTo=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOnWgfsPyF/9znJvGnfW/d66gr9ti3qLxAt33Uy/NCGuk
 G/bdo/4jlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAjCRpXsYGR4rbPn078LyBvlH
 NjdnLH2w5HGtn8PNQ7scfRhCdn/6FZfIyDB9U+Gpr7sPOgvnPHlt3qhieCNKz3MSv9WLtHlr18w
 5JscIAA==
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
John reminded me that this is still an issue in 6.12:

https://github.com/ClangBuiltLinux/linux/issues/2047#issuecomment-2482635093

I know Greg said this driver should be using a 'struct device' but I am
not familiar with that conversion and there was never any follow up to
me asking how it should be done. I think it would be best to pick this
change up now and have that conversion be done properly by someone who
is more familiar with this driver later.

Changes in v2:
- Rebase on linux-pm/acpi
- Pick up Sami's reviewed-by tag
- Adjust wording around why there is no functional issue from the
  mismatched types
- Link to v1: https://lore.kernel.org/r/20240819-acpi-platform_profile-fix-cfi-violation-v1-1-479365d848f6@kernel.org
---
 drivers/acpi/platform_profile.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/platform_profile.c b/drivers/acpi/platform_profile.c
index d2f7fd7743a13df1dac3100c885208f4418218a5..11278f785526d48243e16659cd78d0b717846a7f 100644
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
base-commit: d47a60e487fbb65bbbca3d99e59009f0a4acf34d
change-id: 20240819-acpi-platform_profile-fix-cfi-violation-de278753bd5f

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


