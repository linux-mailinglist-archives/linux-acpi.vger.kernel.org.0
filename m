Return-Path: <linux-acpi+bounces-20610-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFTGOZk2d2nhdAEAu9opvQ
	(envelope-from <linux-acpi+bounces-20610-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 10:40:41 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C41861EC
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 10:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86ED1300DE35
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Jan 2026 09:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF4532AAB2;
	Mon, 26 Jan 2026 09:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaF2boSC"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AE5329385
	for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420405; cv=none; b=D3tj0oYyHIdVrCaB8USl+XBHpyV9SWOyTyOrSoEKiOR7kg4gAedemqiFY5myZpTtCPKSvA5Ec3sFKw8N4BPbM46rZtkyRYH1q2i/lXRdGuUhWw+plRckm8tHuxaDwZU+4Xga6iHPu0topT6s/EyhgrYnM69JYN/s2ql7PenEm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420405; c=relaxed/simple;
	bh=dvZNE+mvgypovO1CpO7HBZhq3LZ0srcdMMc6kzi19+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXXYCa+bQsJN/9iwWB0ijtP5NaOza7Ja9/A/le4KBmSaV1eGQYUluZDwkwyDJONiUKdRoWvrEWkiieW6uLLm+sXRO2kPKkd5dJJYkSeG7Xyu4QNi5n9nTzF8QwkaWfSAVq/RFHRsxFbZGwXO6cStis2hdtr86z3ket3p8ov9Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaF2boSC; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3530715386cso3785435a91.2
        for <linux-acpi@vger.kernel.org>; Mon, 26 Jan 2026 01:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420403; x=1770025203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5J/yysAHxIhyaGA7VxFBlt0GOH3uXRc0AwbYc4HyxeI=;
        b=BaF2boSCc4LqXrZ56GgXYvSx5V48Any4sL139j6wHxB3gLz+JV911NGmdfsb/TCHIc
         UjsKIw8JXUTk8aQKKBWpMwStVmTmR1kaysE/3J+NpHY4PrCcp+DoB4JfSWWrw+rMUsOh
         IyiPGxdnJ/kX9SLJCJTQ2D+hKgdJxn2jG8YIXfzU/1Z87ZxYWr0mJOr/EhKTVXBHN+rw
         VzS5OJ5fvCEGOABwxs6+mKu6ALwnewkW68KnRVt6f736/NTX+pHHnyxODSuQN0F4ggHJ
         i3EtcFrd5pj15dElwJuCBYHShtAm9BpdzR5DU9GREDUmJP3lqKNO0rTttrdBzGjQPYra
         JYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420403; x=1770025203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5J/yysAHxIhyaGA7VxFBlt0GOH3uXRc0AwbYc4HyxeI=;
        b=sho3Z9s0kgE5gxsPHydje1gobbdDRijxnqUzfyzAPvP6qoK5pU+N8Ho/eE0V9iuWTt
         PA72HuA3R3NKXu8vTFoP/LVDyQO9zq2/AYq6BGMu85KTg3nZcL1/BziJvWFGQzEQ6QUs
         lNsfprgrnV+u1ruBjNERbNJ7XU24UQVub55WMakFO1dfuQqqGz7J+fnHhOXOR2BfSWBT
         fvs6ST3v62lLHeqsWQ2j/+g4kmQUo9cvhBsfbu7tR4QjZZVY9wfJvSjh/9BQYj2IZOlN
         AcSUQNAcswAaFuuFwptI7+DzHNpJyETpinUO6WRe+VS0bP67wwgJkHbGqKdqEhQzAnVB
         IJlA==
X-Forwarded-Encrypted: i=1; AJvYcCVILjOfwObJDlUSsG8JQDtJXxRe/4UudhRACnGNRJHH2nlwV4CKMiZwycHljigQkSobVqky53maJhg9@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/OMO6myJ2dZfT/GtXIsYitLzpwbga5ZzRKzCB2LZ6ZeDWXo5X
	4Ne0EjihFVERmJTbkGeDAiI2o9wGUUrpu2fT4CEC/RgDx15E5wTlKcoH
X-Gm-Gg: AZuq6aLEuOmIUH+xRmaRMhhrp2Y8+wO8nrnFQlL2vW1OGVKRoZk+ZdBMZW9D6fM9ktn
	9ie7EzBi86lTxZx39nlX9pW4j7d1ZMwqfX3wkqO37VIDbwxiQwjs1fdBsuTGYz+4W4Hmpys6qOQ
	9zisBdwl0At1wobC6YmgDb4627uF4U9s0SH/dJgPWGvtZf/44VPHQ2k7SBxXA4XRXZc4ALKArx8
	KfJx5olxqHRk92soQa7maHCN6THoiFp8XKfTjexDZSKhg08kGEu0aFF0PwP7FYaAuj/bzelmpTD
	TokAAlsFEXwY+1u9T9u/vk9kEWZNnvDmCkjcRB5GKfM2fRcKWK8rQXmKoyXjKnB4HcFpfJg4nsw
	QtdHyuZRqgfUuuFDK2U0keM6bpWYBqlYPJHPm93DBQp6NzlZhVCWvZ531Zbddfi8R2hWfQIE5bR
	e4u6tsOp1qoo4wFz3Y24Xbz+Nilg==
X-Received: by 2002:a17:90a:dfd0:b0:32e:7270:9499 with SMTP id 98e67ed59e1d1-353c3fda458mr2846857a91.0.1769420403261;
        Mon, 26 Jan 2026 01:40:03 -0800 (PST)
Received: from gmail.com ([2402:e280:3e9b:22f:d4f6:7f7c:22ee:831c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8231871f97asm8896952b3a.40.2026.01.26.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:40:02 -0800 (PST)
From: Sumeet Pawnikar <sumeet4linux@gmail.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	sumeet4linux@gmail.com
Subject: [PATCH] ACPI: Replace sprintf with sysfs_emit
Date: Mon, 26 Jan 2026 15:09:49 +0530
Message-ID: <20260126093949.8910-1-sumeet4linux@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20610-lists,linux-acpi=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_NEQ_ENVFROM(0.00)[sumeet4linux@gmail.com,linux-acpi@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49C41861EC
X-Rspamd-Action: no action

Replace all sprintf() calls with sysfs_emit() in sysfs show functions.
sysfs_emit() is preferred over sprintf() for formatting sysfs output
as it provides better bounds checking and prevents potential buffer
overflows.

Signed-off-by: Sumeet Pawnikar <sumeet4linux@gmail.com>
---
 drivers/acpi/device_sysfs.c | 20 ++++++++++----------
 drivers/acpi/sysfs.c        | 30 +++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index cd199fbe4dc9..a52dc35ff9ba 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -27,7 +27,7 @@ static ssize_t acpi_object_path(acpi_handle handle, char *buf)
 	if (result)
 		return result;
 
-	result = sprintf(buf, "%s\n", (char *)path.pointer);
+	result = sysfs_emit(buf, "%s\n", (char *)path.pointer);
 	kfree(path.pointer);
 	return result;
 }
@@ -347,7 +347,7 @@ static ssize_t real_power_state_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%s\n", acpi_power_state_string(state));
+	return sysfs_emit(buf, "%s\n", acpi_power_state_string(state));
 }
 
 static DEVICE_ATTR_RO(real_power_state);
@@ -357,7 +357,7 @@ static ssize_t power_state_show(struct device *dev,
 {
 	struct acpi_device *adev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_power_state_string(adev->power.state));
+	return sysfs_emit(buf, "%s\n", acpi_power_state_string(adev->power.state));
 }
 
 static DEVICE_ATTR_RO(power_state);
@@ -399,7 +399,7 @@ hid_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_device_hid(acpi_dev));
+	return sysfs_emit(buf, "%s\n", acpi_device_hid(acpi_dev));
 }
 static DEVICE_ATTR_RO(hid);
 
@@ -408,7 +408,7 @@ static ssize_t uid_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "%s\n", acpi_device_uid(acpi_dev));
+	return sysfs_emit(buf, "%s\n", acpi_device_uid(acpi_dev));
 }
 static DEVICE_ATTR_RO(uid);
 
@@ -418,9 +418,9 @@ static ssize_t adr_show(struct device *dev,
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
 	if (acpi_dev->pnp.bus_address > U32_MAX)
-		return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
+		return sysfs_emit(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
 	else
-		return sprintf(buf, "0x%08llx\n", acpi_dev->pnp.bus_address);
+		return sysfs_emit(buf, "0x%08llx\n", acpi_dev->pnp.bus_address);
 }
 static DEVICE_ATTR_RO(adr);
 
@@ -482,7 +482,7 @@ sun_show(struct device *dev, struct device_attribute *attr,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	return sprintf(buf, "%llu\n", sun);
+	return sysfs_emit(buf, "%llu\n", sun);
 }
 static DEVICE_ATTR_RO(sun);
 
@@ -498,7 +498,7 @@ hrv_show(struct device *dev, struct device_attribute *attr,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	return sprintf(buf, "%llu\n", hrv);
+	return sysfs_emit(buf, "%llu\n", hrv);
 }
 static DEVICE_ATTR_RO(hrv);
 
@@ -513,7 +513,7 @@ static ssize_t status_show(struct device *dev, struct device_attribute *attr,
 	if (ACPI_FAILURE(status))
 		return -EIO;
 
-	return sprintf(buf, "%llu\n", sta);
+	return sysfs_emit(buf, "%llu\n", sta);
 }
 static DEVICE_ATTR_RO(status);
 
diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index e596224302f4..1bd2f555e673 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -687,7 +687,7 @@ static ssize_t counter_show(struct kobject *kobj,
 	    acpi_irq_not_handled;
 	all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
 	    acpi_gpe_count;
-	size = sprintf(buf, "%8u", all_counters[index].count);
+	size = sysfs_emit(buf, "%8u", all_counters[index].count);
 
 	/* "gpe_all" or "sci" */
 	if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
@@ -698,29 +698,29 @@ static ssize_t counter_show(struct kobject *kobj,
 		goto end;
 
 	if (status & ACPI_EVENT_FLAG_ENABLE_SET)
-		size += sprintf(buf + size, "  EN");
+		size += sysfs_emit_at(buf, size, "  EN");
 	else
-		size += sprintf(buf + size, "    ");
+		size += sysfs_emit_at(buf, size, "    ");
 	if (status & ACPI_EVENT_FLAG_STATUS_SET)
-		size += sprintf(buf + size, " STS");
+		size += sysfs_emit_at(buf, size, " STS");
 	else
-		size += sprintf(buf + size, "    ");
+		size += sysfs_emit_at(buf, size, "    ");
 
 	if (!(status & ACPI_EVENT_FLAG_HAS_HANDLER))
-		size += sprintf(buf + size, " invalid     ");
+		size += sysfs_emit_at(buf, size, " invalid     ");
 	else if (status & ACPI_EVENT_FLAG_ENABLED)
-		size += sprintf(buf + size, " enabled     ");
+		size += sysfs_emit_at(buf, size, " enabled     ");
 	else if (status & ACPI_EVENT_FLAG_WAKE_ENABLED)
-		size += sprintf(buf + size, " wake_enabled");
+		size += sysfs_emit_at(buf, size, " wake_enabled");
 	else
-		size += sprintf(buf + size, " disabled    ");
+		size += sysfs_emit_at(buf, size, " disabled    ");
 	if (status & ACPI_EVENT_FLAG_MASKED)
-		size += sprintf(buf + size, " masked  ");
+		size += sysfs_emit_at(buf, size, " masked  ");
 	else
-		size += sprintf(buf + size, " unmasked");
+		size += sysfs_emit_at(buf, size, " unmasked");
 
 end:
-	size += sprintf(buf + size, "\n");
+	size += sysfs_emit_at(buf, size, "\n");
 	return result ? result : size;
 }
 
@@ -937,7 +937,7 @@ static void __exit interrupt_stats_exit(void)
 
 static ssize_t pm_profile_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
+	return sysfs_emit(buf, "%d\n", acpi_gbl_FADT.preferred_profile);
 }
 
 static const struct kobj_attribute pm_profile_attr = __ATTR_RO(pm_profile);
@@ -946,7 +946,7 @@ static ssize_t enabled_show(struct kobject *kobj, struct kobj_attribute *attr, c
 {
 	struct acpi_hotplug_profile *hotplug = to_acpi_hotplug_profile(kobj);
 
-	return sprintf(buf, "%d\n", hotplug->enabled);
+	return sysfs_emit(buf, "%d\n", hotplug->enabled);
 }
 
 static ssize_t enabled_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -1000,7 +1000,7 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 static ssize_t force_remove_show(struct kobject *kobj,
 				 struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", 0);
+	return sysfs_emit(buf, "%d\n", 0);
 }
 
 static ssize_t force_remove_store(struct kobject *kobj,
-- 
2.43.0


