Return-Path: <linux-acpi+bounces-20483-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIvvJsyScGkaYgAAu9opvQ
	(envelope-from <linux-acpi+bounces-20483-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 09:48:12 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EADCC53D4D
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 09:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1D5584A0424
	for <lists+linux-acpi@lfdr.de>; Wed, 21 Jan 2026 08:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A974243E4B2;
	Wed, 21 Jan 2026 08:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="izjSbPRx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC413EF0D6;
	Wed, 21 Jan 2026 08:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768985223; cv=none; b=I8e4xV+DeoQvh/JpDouy4UsK5To922duzYRKVtOT21uTa9iaGP+BkvK+NL+AeLMDxVm1b8bnT9G8kCTdae1hVPoYFk3kGc1Nc3julvC1cR0M/sxmTk1W+ohjELWTaAyQP/jZ35OkMkdeB9TLlqKXKIjCgsz58DRqkwOcvYGC/6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768985223; c=relaxed/simple;
	bh=jr4lo79c9o5L25a37x1jGtK94EImtXFj0w8+rwRzm6U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djK533M/T9Lf+M9oIjR8RCGOePJCiqYy5RWu7W+KyVAQy6URlLlIqul95H6EsqJTfL8OQ1Ftbg+lU/iJiOvdR84+8/0EaCShf4rS1nDXLWwzGtGpMaqDuTjKIOJeAjtrtGJOdhVOcTXeUA3aRceZxIPd4xz5hcmZeZC/mvmc7Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=izjSbPRx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768985221; x=1800521221;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jr4lo79c9o5L25a37x1jGtK94EImtXFj0w8+rwRzm6U=;
  b=izjSbPRxfZoRY7xom1t+eWpMV9GAVHfh4ODL4PWs9uyKn5qAW8Nwb5j8
   TScfXyUZBn4LCemfHgCYHRp9ff4ntXY4/mhhv2+hhYGF7ZVzObpRdZD6w
   vTS4Lk+yOhQ9QqlpQv2cBLDBBkljbbmcWDFchxIuiFmn8Oo30H7kw9Xln
   NVisaI+HAncUq5AxHKW19OWzF+704PnsX+sJ9Fh08U0MzmIM2WBQG651a
   293Izj24sEMRVSIyz6LdB3ktidYWHts4NCu3I3beR9VGhF+SZjvLlzDSk
   mFwYl6VftMVD204frVCh/1ZLQvr0wRov+LKnVknvAOYVWR1560ubEyefM
   Q==;
X-CSE-ConnectionGUID: IGqsJ2BrQHWhQ3QDrPVypw==
X-CSE-MsgGUID: fqyFEF61Tuyh+W9BFlCRcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="80836023"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="80836023"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 00:46:59 -0800
X-CSE-ConnectionGUID: zs4PLQQoRjWRIYsjRb3puQ==
X-CSE-MsgGUID: g0cyh7FOTb+B255qHUkWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="205639972"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 21 Jan 2026 00:46:57 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 748B798; Wed, 21 Jan 2026 09:46:56 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] ACPI: video: simplify code with acpi_get_local_u64_address()
Date: Wed, 21 Jan 2026 09:46:36 +0100
Message-ID: <20260121084654.2227037-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20483-lists,linux-acpi=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andriy.shevchenko@linux.intel.com,linux-acpi@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,linux.intel.com:mid]
X-Rspamd-Queue-Id: EADCC53D4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now we have a helper so there's no need to open-code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: removed now unused variable (LKP)

 drivers/acpi/acpi_video.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 944aba605c1a..69469757b965 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1134,13 +1134,11 @@ static int acpi_video_bus_get_one_device(struct acpi_device *device, void *arg)
 	struct acpi_video_bus *video = arg;
 	struct acpi_video_device_attrib *attribute;
 	struct acpi_video_device *data;
-	unsigned long long device_id;
-	acpi_status status;
 	int device_type;
+	u64 device_id;
 
-	status = acpi_evaluate_integer(device->handle, "_ADR", NULL, &device_id);
 	/* Skip devices without _ADR instead of failing. */
-	if (ACPI_FAILURE(status))
+	if (acpi_get_local_u64_address(device->handle, &device_id))
 		goto exit;
 
 	data = kzalloc(sizeof(struct acpi_video_device), GFP_KERNEL);
-- 
2.50.1


