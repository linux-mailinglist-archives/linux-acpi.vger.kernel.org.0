Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 695353B1164
	for <lists+linux-acpi@lfdr.de>; Wed, 23 Jun 2021 03:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFWBlL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 22 Jun 2021 21:41:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFWBlL (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 22 Jun 2021 21:41:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F2CA610A0;
        Wed, 23 Jun 2021 01:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624412334;
        bh=tYMcg0A6FJf1k3FBz4ypXl/o/qa0iWWfHJFijI/1IVw=;
        h=From:To:Cc:Subject:Date:From;
        b=uIr9F5Lyaoq60Bqi+omXqpIj5pbfw2wbaVSYCUmslV6JcQnd6y+BfiDUG/EgT9bHi
         pc/P+mbrKTmojx+UUZgptzALVoTrs2AE14tyf7shwPFvU9/l17ozqB4a+lUKWRzXhB
         VqNOoOVzvxT1icBNst3mWou4IvfGGMrjleWqEIc2SeQdOkgyhdDIPC6dzWZdwb7hQg
         LgdVvR3XKPWlkVKL1dA2g01PC6/AYopHBQoaiwp50TCGQ151FhHNuADgaDXwXFiVYY
         FK/UloIOC0X4XVMRCppak2ieyvadK5Y2ahOmfuv3wSouEYa5L+plULA0IHaiI+G1pG
         YZadOlnW3ecYQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 1/2] ACPI: bgrt: Fix CFI violation
Date:   Tue, 22 Jun 2021 18:38:01 -0700
Message-Id: <20210623013802.1904951-1-nathan@kernel.org>
X-Mailer: git-send-email 2.32.0.93.g670b81a890
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

clang's Control Flow Integrity requires that every indirect call has a
valid target, which is based on the type of the function pointer. The
*_show() functions in this file are written as if they will be called
from dev_attr_show(); however, they will be called from
sysfs_kf_seq_show() because the files were created by
sysfs_create_group() and the sysfs ops are based on kobj_sysfs_ops
because of kobject_add_and_create(). Because the *_show() functions do
not match the type of the show() member in struct kobj_attribute, there
is a CFI violation.

$ cat /sys/firmware/acpi/bgrt/{status,type,version,{x,y}offset}}
1
0
1
522
307

$ dmesg | grep "CFI failure"
[  267.761825] CFI failure (target: type_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
[  267.762246] CFI failure (target: xoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
[  267.762584] CFI failure (target: status_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
[  267.762973] CFI failure (target: yoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
[  267.763330] CFI failure (target: version_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):

Convert these functions to the type of the show() member in struct
kobj_attribute so that there is no more CFI violation. Because these
functions are all so similar, combine them into a macro.

Fixes: d1ff4b1cdbab ("ACPI: Add support for exposing BGRT data")
Link: https://github.com/ClangBuiltLinux/linux/issues/1406
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/bgrt.c | 57 ++++++++++++++-------------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/bgrt.c b/drivers/acpi/bgrt.c
index 19bb7f870204..e0d14017706e 100644
--- a/drivers/acpi/bgrt.c
+++ b/drivers/acpi/bgrt.c
@@ -15,40 +15,19 @@
 static void *bgrt_image;
 static struct kobject *bgrt_kobj;
 
-static ssize_t version_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.version);
-}
-static DEVICE_ATTR_RO(version);
-
-static ssize_t status_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.status);
-}
-static DEVICE_ATTR_RO(status);
-
-static ssize_t type_show(struct device *dev,
-			 struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_type);
-}
-static DEVICE_ATTR_RO(type);
-
-static ssize_t xoffset_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_offset_x);
-}
-static DEVICE_ATTR_RO(xoffset);
-
-static ssize_t yoffset_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab.image_offset_y);
-}
-static DEVICE_ATTR_RO(yoffset);
+#define BGRT_SHOW(_name, _member) \
+	static ssize_t _name##_show(struct kobject *kobj,			\
+				    struct kobj_attribute *attr, char *buf)	\
+	{									\
+		return snprintf(buf, PAGE_SIZE, "%d\n", bgrt_tab._member);	\
+	}									\
+	struct kobj_attribute bgrt_attr_##_name = __ATTR_RO(_name)
+
+BGRT_SHOW(version, version);
+BGRT_SHOW(status, status);
+BGRT_SHOW(type, image_type);
+BGRT_SHOW(xoffset, image_offset_x);
+BGRT_SHOW(yoffset, image_offset_y);
 
 static ssize_t image_read(struct file *file, struct kobject *kobj,
 	       struct bin_attribute *attr, char *buf, loff_t off, size_t count)
@@ -60,11 +39,11 @@ static ssize_t image_read(struct file *file, struct kobject *kobj,
 static BIN_ATTR_RO(image, 0);	/* size gets filled in later */
 
 static struct attribute *bgrt_attributes[] = {
-	&dev_attr_version.attr,
-	&dev_attr_status.attr,
-	&dev_attr_type.attr,
-	&dev_attr_xoffset.attr,
-	&dev_attr_yoffset.attr,
+	&bgrt_attr_version.attr,
+	&bgrt_attr_status.attr,
+	&bgrt_attr_type.attr,
+	&bgrt_attr_xoffset.attr,
+	&bgrt_attr_yoffset.attr,
 	NULL,
 };
 

base-commit: a51c80057a887e0f24bd8303b0791a130ff04121
-- 
2.32.0.93.g670b81a890

