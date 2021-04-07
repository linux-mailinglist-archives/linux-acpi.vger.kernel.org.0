Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090BD3576DA
	for <lists+linux-acpi@lfdr.de>; Wed,  7 Apr 2021 23:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbhDGVcY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 7 Apr 2021 17:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233250AbhDGVcY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Apr 2021 17:32:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CAE0611C9;
        Wed,  7 Apr 2021 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617831134;
        bh=BuVhiad8pGs7GMTY6aCtThh+R5h7EktJbneSekpN0Mo=;
        h=From:To:Cc:Subject:Date:From;
        b=Zljmet3q7BNxRXSwb9frM11fW4Wgdyg/n6UvuTme9CvplVq0RAtk3oZ2uHHTQeVLh
         0h2hAaspz68XDT5iiO7mizWHQtCHpN2T2zZSnj+pEL1zm658EE7urzEAcjth2JdYCY
         RX73KyyKGzD3NKDZ2QYaPZahxksZrIcuodMP4kc1hM7JJYNRLtHLjos1BpjgQKadUd
         /sXD6o+iX2tzXGcp9jQ55FeminTkZRImI6qlte2zPMmzq7lQtcQ2NBumCLCoRjFORg
         rB3QndRLO/5NecNah+5dly3yuR9UPB+VZNo0Zs9xusbbUCCLGtse/RQAXmsIROHCmj
         B5BvqdQP3i4Bg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] ACPI / CPPC: Replace cppc_attr with kobj_attribute
Date:   Wed,  7 Apr 2021 14:30:48 -0700
Message-Id: <20210407213048.940498-1-nathan@kernel.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

All of the CPPC sysfs show functions are called via indirect call in
kobj_attr_show(), where they should be of type

ssize_t (*show)(struct kobject *kobj, struct kobj_attribute *attr, char *buf);

because that is the type of the ->show() member in
'struct kobj_attribute' but they are actually of type

ssize_t (*show)(struct kobject *kobj, struct attribute *attr, char *buf);

because of the ->show() member in 'struct cppc_attr', resulting in a
Control Flow Integrity violation [1].

$ cat /sys/devices/system/cpu/cpu0/acpi_cppc/highest_perf
3400

$ dmesg | grep "CFI failure"
[  175.970559] CFI failure (target: show_highest_perf+0x0/0x8):

As far as I can tell, the only different between 'struct cppc_attr' and
'struct kobj_attribute' aside from the type of the attr parameter is the
type of the count parameter in the ->store() member (ssize_t vs.
size_t), which does not actually matter because all of these nodes are
read-only.

Eliminate 'struct cppc_attr' in favor of 'struct kobj_attribute' to fix
the violation.

[1]: https://lore.kernel.org/r/20210401233216.2540591-1-samitolvanen@google.com/

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Link: https://github.com/ClangBuiltLinux/linux/issues/1343
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/acpi/cppc_acpi.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 69057fcd2c04..a5e6fd0bafa1 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -119,23 +119,15 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
  */
 #define NUM_RETRIES 500ULL
 
-struct cppc_attr {
-	struct attribute attr;
-	ssize_t (*show)(struct kobject *kobj,
-			struct attribute *attr, char *buf);
-	ssize_t (*store)(struct kobject *kobj,
-			struct attribute *attr, const char *c, ssize_t count);
-};
-
 #define define_one_cppc_ro(_name)		\
-static struct cppc_attr _name =			\
+static struct kobj_attribute _name =		\
 __ATTR(_name, 0444, show_##_name, NULL)
 
 #define to_cpc_desc(a) container_of(a, struct cpc_desc, kobj)
 
 #define show_cppc_data(access_fn, struct_name, member_name)		\
 	static ssize_t show_##member_name(struct kobject *kobj,		\
-					struct attribute *attr,	char *buf) \
+				struct kobj_attribute *attr, char *buf)	\
 	{								\
 		struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);		\
 		struct struct_name st_name = {0};			\
@@ -161,7 +153,7 @@ show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, reference_perf);
 show_cppc_data(cppc_get_perf_ctrs, cppc_perf_fb_ctrs, wraparound_time);
 
 static ssize_t show_feedback_ctrs(struct kobject *kobj,
-		struct attribute *attr, char *buf)
+		struct kobj_attribute *attr, char *buf)
 {
 	struct cpc_desc *cpc_ptr = to_cpc_desc(kobj);
 	struct cppc_perf_fb_ctrs fb_ctrs = {0};

base-commit: 454859c552da78b0f587205d308401922b56863e
-- 
2.31.0

