Return-Path: <linux-acpi+bounces-5650-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505578BEC4C
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 21:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B0642874E5
	for <lists+linux-acpi@lfdr.de>; Tue,  7 May 2024 19:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADEE16F0DC;
	Tue,  7 May 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mr86xFKX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A83616EC18;
	Tue,  7 May 2024 19:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715108868; cv=none; b=myiPZEETKAIVgaCKxpM79eM8S3Wogz6T848GaZUYYJacmG1gI/q0Yqa4XLCjBL4vhyHsbazDE2LaujvRjZa1J7iPr/0LCX11/1p3GHbF6y2b9Y8tuGmQ81TasbNC6z4Yc773AMxwoOTCvz5xCMJ88VNYjELqLO433GncStnZXCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715108868; c=relaxed/simple;
	bh=waLCspmlg8j9NTDYt1T+THr2DrqmxLmYPqVHAIrBI9U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkzWOwdRHCczc7glW/i21fYXuT5f9a8cmMMrwjVlmarm3B1ZTJVGr0dCAxAAaZpd/HcfpTtwM4bDfR07r+n0CsneELFmYZvCpHC0eeaSA4z/Mg7puEP8qLygWqbn4pZkyt6kEmaWIB3Kscq9oTdqRBNx2i9vhbxAZDvt4xfXT5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mr86xFKX; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715108867; x=1746644867;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=waLCspmlg8j9NTDYt1T+THr2DrqmxLmYPqVHAIrBI9U=;
  b=Mr86xFKXpVM/VLtgCeUq++mndLdNV6Kmnag+wbvUqCqEqug1ruEdGdAS
   ePp2SIadlNC8zgFpJuyLE1tFGvwj8DL4dvtRPtI1vKH8gU+j4IXTTUKSU
   2aykqHsr/pUZstVh5cIdiWkOcl5aJbx9m7N1twpUpn2dpD/NEMAgpqPt2
   hQ55bqFtNWV6raDMDHxOxQ0yY1K8RHcLFV5skP1YWPW/LLMVpyMeBMiJW
   UV9b16J8UF0lEh4J9+IzkkHhbxx3gfpCu76taivJhEAF/M0jBYJts8r4M
   MksbmvAoa6uyWHF38BEw8CgWjWfyK+NxNoCziXkeLF7jE4sVkT5ZrLTtt
   A==;
X-CSE-ConnectionGUID: HDkV8y1FTxyqrAGoZf1/vg==
X-CSE-MsgGUID: wZPIpfE8QVKl0wxZ3/0dsg==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="11087471"
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="11087471"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:47 -0700
X-CSE-ConnectionGUID: IkH+ULFaTsmsOFJSl5JxuQ==
X-CSE-MsgGUID: JlmXhDtLTROfPDazgTOrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,143,1712646000"; 
   d="scan'208";a="28682099"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.246.52])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 12:07:45 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	"Fabio M . De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [RFC PATCH 3/3] ACPI: extlog: Make print_extlog_rcd() log unconditionally
Date: Tue,  7 May 2024 21:02:22 +0200
Message-ID: <20240507190724.323269-4-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
References: <20240507190724.323269-1-fabio.m.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make extlog_print_rcd() log unconditionally to report errors even if
userspace is not consuming trace events. Remove ras_userspace_consumers()
because it is not anymore used.

This change makes extlog_print() (ELOG) to act consistently to ghes_proc()
(GHES).

Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---
 drivers/acpi/acpi_extlog.c | 6 +-----
 drivers/ras/debugfs.c      | 6 ------
 include/linux/ras.h        | 2 --
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
index c167e391ba43..7bb1204080ef 100644
--- a/drivers/acpi/acpi_extlog.c
+++ b/drivers/acpi/acpi_extlog.c
@@ -185,10 +185,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 
 	tmp = (struct acpi_hest_generic_status *)elog_buf;
 
-	if (!ras_userspace_consumers()) {
-		print_extlog_rcd(NULL, tmp, cpu);
-		goto out;
-	}
+	print_extlog_rcd(NULL, tmp, cpu);
 
 	/* log event via trace */
 	err_seq++;
@@ -222,7 +219,6 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
 		}
 	}
 
-out:
 	mce->kflags |= MCE_HANDLED_EXTLOG;
 	return NOTIFY_OK;
 }
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b2..6633844acdd6 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -13,12 +13,6 @@ struct dentry *ras_get_debugfs_root(void)
 }
 EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
 
-int ras_userspace_consumers(void)
-{
-	return atomic_read(&trace_count);
-}
-EXPORT_SYMBOL_GPL(ras_userspace_consumers);
-
 static int trace_show(struct seq_file *m, void *v)
 {
 	return 0;
diff --git a/include/linux/ras.h b/include/linux/ras.h
index a64182bc72ad..98840f16b697 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -7,11 +7,9 @@
 #include <linux/cper.h>
 
 #ifdef CONFIG_DEBUG_FS
-int ras_userspace_consumers(void);
 void ras_debugfs_init(void);
 int ras_add_daemon_trace(void);
 #else
-static inline int ras_userspace_consumers(void) { return 0; }
 static inline void ras_debugfs_init(void) { }
 static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
-- 
2.45.0


