Return-Path: <linux-acpi+bounces-20818-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EZ9BIa0gGl3AgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20818-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:28:22 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22655CD586
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 22ED830046B5
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 14:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B25336CE15;
	Mon,  2 Feb 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Nhbu0VYP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796FC4A21;
	Mon,  2 Feb 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042495; cv=none; b=Zye8Q5NsZpWgxKC/cpZjEUqdrDVWqXB9k2GvLY8mWPAfB37b9JWAX+/CbfU5utrTPjxncPS0G/XS6hTzqbrZscl9Ox+xra7Kt5SnYANKbLCE7J48EgWVGtvM8qo4nURTzEFfX+Hq1i11oz+gwe3GYAm/4MMFfmuZwR5zLtuvaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042495; c=relaxed/simple;
	bh=U8EjTz/5T7IsTrWh7ZVcmmDz3W/0lTlfkat5cxh/2+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y50Py/gsULTHm3HnfnVWuO17fQpnwnaaynLW3IftlOuRQFBIi7VQTpMf9zrCKyt45eh+Bg0zWpCPdoUTQoYxTAtALimnn/mrqHiAsNT9FihM9lRgPDRyfhHUZtbY40cVEm9h6+Xs0LHxKLgrUJ9K1vsJzYTt9i1r+yKinWo1WW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Nhbu0VYP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pCFb4xxEV2N7KzX/8XoJeWKKN9wS7tz47sg5Z5hO/c4=; b=Nhbu0VYP5qTK/s7HyyQREOyam0
	Zr2Pj3ksZVl3YspztLX8aZJrLG2MIPsanMki3avg4U09a8bbgGudCOOS/2DfdUluDn4wGg8Ikcf+D
	engXbwdRtM8ezeXXpTuFlc4VxUxROW3OMSUMa/17Q/o4Urwel3/BjJHaYy3PfXGwXG+KMRYjW9C5b
	rWrOjcrk/Dee/c2M+MZ6wOTvBeCRT/tCLKOO4ygn62B/oYUqO3aw52IKQkU2ALeTnPTJYsLtznVw/
	FWhjpZIAxOzFozgN1FyqQ4rpLe3QJhz6ZfPFaSxowDpOSAz6PwpU/JDUBtQ8CuRYX+P2ZB+tINPyg
	9AV7EUuA==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuO-0046Xd-NY; Mon, 02 Feb 2026 14:28:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Feb 2026 06:27:39 -0800
Subject: [PATCH v2 1/2] vmcoreinfo: expose hardware error recovery
 statistics via sysfs
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-vmcoreinfo_sysfs-v2-1-8f3b5308b894@debian.org>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3683; i=leitao@debian.org;
 h=from:subject:message-id; bh=U8EjTz/5T7IsTrWh7ZVcmmDz3W/0lTlfkat5cxh/2+Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRtwiUfi29mGTnW4ixNZP7zWlKBlM3vszSJq
 AEuwxTr9ZeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bVU7D/4/ExbTJHPtttzMSuBhk++xqEFTGnO6/RhPBgJukq8LwzOrL2hTvO+rp4eeK8XuIhLXwwg
 bqHzyu8rolbjXfhhAaHIUgSvhChUcCPBHq8yzLTAJKn/I2EEVNOz/ZBR1sdHNNQD2D/Zdsn5EZ6
 fW2qiKLSsVchqc/HvA7aGm19p4Wk5BIQ+cbiaiKgkzZqCKe0V49KH5KP1NiVlLFjR/lPVrO2jp6
 fCp/Z7HPXRA8+GpYjT9O6ScKytWNNGmDlN2qZOwbU/RNqGej1tUlbL/Xtcr9c0tZzh9AoZTUUdJ
 tO+RmLebtx5DBsWl5jOzTE9XcA/eQJFIYM/Hy4+/3BTRscC2Jo3CyJf+XicmaKxF/KG3CdnOjNQ
 4vhgMhqdKw5xeXA/+eJ5ZiVNymjHTM/ohxmqvrcq9LVj1Cd6Ppnm29eQBchEaWY5f8xJCGsnAtK
 Crnwg+xpSxZJT2CXLzbm2f2q7+GgSrw60Prdml0pQyPGTwl4DorPYv83f+5ji1wMkmE3sk0AJxF
 SxxrLb6nVEGwdT3edG53ysA++T6Y0oRN/0ZWzWvM+RIuARAOznbXwibF1eNELSbsQyAf+Vnl6Q+
 YT+QI/GpAb0Km9KE73ggMe3TFKAw1/8N4ZudMe7rXnTtyvg8hlhjuLwSd2YKPXq53KGojpz/U06
 uxWw7bKkJrqqotw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20818-lists,linux-acpi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	URIBL_MULTI_FAIL(0.00)[sin.lore.kernel.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22655CD586
X-Rspamd-Action: no action

Add a sysfs directory at /sys/kernel/hwerr_recovery_stats/ to expose
hardware error recovery statistics that are already tracked by the
kernel. This allows userspace monitoring tools to track recovered
hardware errors without requiring kernel crashes.

This is useful to track recoverable hardware errors in a time series,
even if the host doesn't crash.

The sysfs directory contains one file per error subsystem:

  /sys/kernel/hwerr_recovery_stats/cpu     - CPU-related errors (MCE, ARM errors)
  /sys/kernel/hwerr_recovery_stats/memory  - Memory-related errors
  /sys/kernel/hwerr_recovery_stats/pci     - PCI/PCIe AER non-fatal errors
  /sys/kernel/hwerr_recovery_stats/cxl     - CXL errors
  /sys/kernel/hwerr_recovery_stats/others  - Other hardware errors

Each file contains a single integer representing the count of recovered
errors for that subsystem.

These statistics provide visibility into the health of the system's
hardware and can be used by system administrators to proactively detect
failing components before they cause system crashes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/vmcore_info.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/vmcore_info.c b/kernel/vmcore_info.c
index e2784038bbed7..b7fcd21be7c59 100644
--- a/kernel/vmcore_info.c
+++ b/kernel/vmcore_info.c
@@ -6,6 +6,8 @@
 
 #include <linux/buildid.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
@@ -139,6 +141,56 @@ void hwerr_log_error_type(enum hwerr_error_type src)
 }
 EXPORT_SYMBOL_GPL(hwerr_log_error_type);
 
+/* sysfs interface for hardware error recovery statistics */
+#define HWERR_ATTR_RO(_name, _type)					\
+static ssize_t _name##_show(struct kobject *kobj,			\
+			    struct kobj_attribute *attr, char *buf)	\
+{									\
+	return sysfs_emit(buf, "%d\n",					\
+			  atomic_read(&hwerr_data[_type].count));	\
+}									\
+static struct kobj_attribute hwerr_##_name##_attr = __ATTR_RO(_name)
+
+HWERR_ATTR_RO(cpu, HWERR_RECOV_CPU);
+HWERR_ATTR_RO(memory, HWERR_RECOV_MEMORY);
+HWERR_ATTR_RO(pci, HWERR_RECOV_PCI);
+HWERR_ATTR_RO(cxl, HWERR_RECOV_CXL);
+HWERR_ATTR_RO(others, HWERR_RECOV_OTHERS);
+
+static struct attribute *hwerr_recovery_stats_attrs[] = {
+	&hwerr_cpu_attr.attr,
+	&hwerr_memory_attr.attr,
+	&hwerr_pci_attr.attr,
+	&hwerr_cxl_attr.attr,
+	&hwerr_others_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group hwerr_recovery_stats_group = {
+	.attrs = hwerr_recovery_stats_attrs,
+};
+
+static struct kobject *hwerr_recovery_stats_kobj;
+
+static int __init hwerr_recovery_stats_init(void)
+{
+	hwerr_recovery_stats_kobj = kobject_create_and_add("hwerr_recovery_stats",
+							   kernel_kobj);
+	if (!hwerr_recovery_stats_kobj) {
+		pr_warn("Failed to create hwerr_recovery_stats kobject\n");
+		return -ENOMEM;
+	}
+
+	if (sysfs_create_group(hwerr_recovery_stats_kobj,
+			       &hwerr_recovery_stats_group)) {
+		kobject_put(hwerr_recovery_stats_kobj);
+		pr_warn("Failed to create hwerr_recovery_stats sysfs group\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
 static int __init crash_save_vmcoreinfo_init(void)
 {
 	vmcoreinfo_data = (unsigned char *)get_zeroed_page(GFP_KERNEL);
@@ -248,6 +300,9 @@ static int __init crash_save_vmcoreinfo_init(void)
 	arch_crash_save_vmcoreinfo();
 	update_vmcoreinfo_note();
 
+	/* Create /sys/kernel/hwerr_recovery_stats/ directory */
+	hwerr_recovery_stats_init();
+
 	return 0;
 }
 

-- 
2.47.3


