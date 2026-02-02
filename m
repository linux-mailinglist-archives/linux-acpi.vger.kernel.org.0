Return-Path: <linux-acpi+bounces-20819-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MKL/Mn62gGl3AgMAu9opvQ
	(envelope-from <linux-acpi+bounces-20819-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:36:46 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DFFCD70A
	for <lists+linux-acpi@lfdr.de>; Mon, 02 Feb 2026 15:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED1EE3087363
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Feb 2026 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35D136CE04;
	Mon,  2 Feb 2026 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="aTgBNQQh"
X-Original-To: linux-acpi@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C4836D4EB;
	Mon,  2 Feb 2026 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770042497; cv=none; b=mBuqkteg/63ZoZ57ZwFQHMzOAV/M5KnoW5Ostb4P+j+QUN3uoG3Cjt4zWbD74WpTeIyfLNgeWMTZgVncfRrlQWBkK08vuVyFzIiEPTueAwI8VHK7J0cZ1Ps83fMCPed0qc82+f0T70gB9lYok4/M+rO0iFRUxr22hQVAoZrmmRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770042497; c=relaxed/simple;
	bh=18gfPfnS76lTnOnvubbkQRKtlWGXJGHF5diwW/VEeLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOLvzMB+y1arspPyl9kUb7NlFhZFTT8Cbx0VeclaOZ1A1iol8JvcsUhDcTGzlMfWoJ3gIfHxb1pcZNIdkfXxdpBdLHs9hI/sw81Y3C7OO92eZYRl3FYZAABGv17OJcu6T9MeQzsF1B2ylx5lwbg1c5i29slTCB7zuU6kdfT8uEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=aTgBNQQh; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=BsYw1jdHI6UNaHJ0xGEA+g0R+OyYdE59KzSX/GWoWYg=; b=aTgBNQQhltAuw96wTOS8uy9t3o
	u5GM4R+satqAZlav3VkjHQMCbIG+RU7NskjwGA0dSj4hMrzgo3GbAQY6aonNxs5O34lCC8JVWXB3v
	20VQ2YCokPSqSK2xreRzSFq2dcdhkY71p3FBlRSJ2FhYaloOS6gMTGmL/sJzYm7H8d2IyQ3Gk3Kwy
	x8pNfhc+PtmsR1Yq3cwsj/0kUr/8gf54yPRr6qfmF39F41WG2wO3E8fcR4C0B+soL7U3O+sRwqt1w
	ZVwyNntOpXeIXXsnuzW2YYLxdpZPW2fi2O9huq1p51c0Ip/wltzgBdMk6rNaGHud87OYBeFFeLHmu
	1y8f8MTQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vmuuT-0046Xj-1B; Mon, 02 Feb 2026 14:28:13 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 02 Feb 2026 06:27:40 -0800
Subject: [PATCH v2 2/2] docs: add ABI documentation for
 /sys/kernel/hwerr_recovery_stats/
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260202-vmcoreinfo_sysfs-v2-2-8f3b5308b894@debian.org>
References: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
In-Reply-To: <20260202-vmcoreinfo_sysfs-v2-0-8f3b5308b894@debian.org>
To: akpm@linux-foundation.org, bhe@redhat.com
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, 
 dyoung@redhat.com, tony.luck@intel.com, xueshuai@linux.alibaba.com, 
 vgoyal@redhat.com, zhiquan1.li@intel.com, olja@meta.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.15-dev-f4305
X-Developer-Signature: v=1; a=openpgp-sha256; l=3053; i=leitao@debian.org;
 h=from:subject:message-id; bh=18gfPfnS76lTnOnvubbkQRKtlWGXJGHF5diwW/VEeLw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpgLRtcjZ4+WBywa2wxT1191HPWP7OKn4XR6Tn9
 uqH93TzJzmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaYC0bQAKCRA1o5Of/Hh3
 bXbeEACoupF1Pf8XMs+rEdztojnWgDL4it51PtcayAHw+CQ6Wdp1MY6lxhkmj0g1+YNf+SwxbRl
 QynpeiRWj8Q15AddCGhpfuh7Uj4EuytJ6LXF18iIygYbwxlqC6GHxcYALJDCe/0RCpvnmrB5t0C
 KFSumDtE69FQYF2XESSku2W12rRODBRbnqvMWXdUkdVUobQyWmVhzGrntc7YDDX8MAg9si7Q6RQ
 WRrOTx28/G/RnNnzV/y4JBPjPJWV6Ibb7xGBrpVoiOJSJzEkGPBbKl6ZE+Fm3a+CmQp50aOLeWp
 yEscW50qSksuh0MyMdyDr1YhG+1vibIu/YUePZscz/cU7lK2dO+lORrafpeeEHHVbS5mnxmeM+R
 XDzkv+QiSPJIz1SAblR4iVeIwJYVuhI8irPOuv5KvdGWG1LE9aCEb/IZQKF3zQ3fOl5ywUK97JR
 SgoWnzj4yei259VzhSdUsgb9UR3RhGX8IX5TN8YJ7Yip9jK2Q4h3GL9loYly8g0c3ptWRDSaV4f
 eL50p/ADmpWoj899YL94PfCLUhZ8LSx+/QrwOdWmq3n6l46BPoEdrrF9LcXVnNDXIjw1tfAlhA8
 SAOGRYTZHatuaHp8sqoHRksVztne8OSrCPc70LI+pubdyQxWbmjuYKvYSVq59R3S/0PBxZm0oAF
 6TW1S81PupfKqIw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20819-lists,linux-acpi=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 35DFFCD70A
X-Rspamd-Action: no action

Document the new hwerr_recovery_stats sysfs directory that exposes
hardware error recovery statistics.

Update hw-recoverable-errors.rst to reference the new sysfs interface
for runtime monitoring.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../ABI/testing/sysfs-kernel-hwerr_recovery_stats  | 47 ++++++++++++++++++++++
 Documentation/driver-api/hw-recoverable-errors.rst |  3 +-
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats b/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats
new file mode 100644
index 0000000000000..4cb9f5a89fba9
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-kernel-hwerr_recovery_stats
@@ -0,0 +1,47 @@
+What:		/sys/kernel/hwerr_recovery_stats/
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Directory containing hardware error recovery statistics.
+		These statistics track recoverable hardware errors that the
+		kernel has handled since boot.
+
+		Each file contains a single integer representing the count
+		of recovered errors for that subsystem.
+
+What:		/sys/kernel/hwerr_recovery_stats/cpu
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of CPU-related recovered errors (MCE, ARM processor
+		errors).
+
+What:		/sys/kernel/hwerr_recovery_stats/memory
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of memory-related recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/pci
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of PCI/PCIe AER non-fatal recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/cxl
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of CXL (Compute Express Link) recovered errors.
+
+What:		/sys/kernel/hwerr_recovery_stats/others
+Date:		February 2026
+KernelVersion:	6.20
+Contact:	Breno Leitao <leitao@debian.org>
+Description:
+		Count of other hardware recovered errors.
diff --git a/Documentation/driver-api/hw-recoverable-errors.rst b/Documentation/driver-api/hw-recoverable-errors.rst
index fc526c3454bd7..4aefcd103be22 100644
--- a/Documentation/driver-api/hw-recoverable-errors.rst
+++ b/Documentation/driver-api/hw-recoverable-errors.rst
@@ -36,7 +36,8 @@ Data Exposure and Consumption
   types like CPU, memory, PCI, CXL, and others.
 - It is exposed via vmcoreinfo crash dump notes and can be read using tools
   like `crash`, `drgn`, or other kernel crash analysis utilities.
-- There is no other way to read these data other than from crash dumps.
+- It is also exposed via sysfs at ``/sys/kernel/hwerr_recovery_stats/`` for runtime
+  monitoring without requiring a crash dump.
 - These errors are divided by area, which includes CPU, Memory, PCI, CXL and
   others.
 

-- 
2.47.3


