Return-Path: <linux-acpi+bounces-16759-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4FDB55708
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 21:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759DE1D651E6
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 19:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9329A2BE7A0;
	Fri, 12 Sep 2025 19:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnnZHI22"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B39726561D;
	Fri, 12 Sep 2025 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757706234; cv=none; b=iFEK6xWAMdaGvrMOtrBuaOCS/1STlN97vZ9GC5aSQE4AJ4xvLnRpHNi7ii2zNk+NOMRF4fzjTVH0KkbXYo0JiE2wrYvGpx8LcrgO4Xj+vVCNaMCwHtGGnOQUKAJ+f9tNMKZQ2U7wTwQDLg3/CWlCXZTLf1RBn37jmvEgcQopah4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757706234; c=relaxed/simple;
	bh=mDXKdIa89IcPIb6Hy/A6UcB63/viBmrhTut69A9OiUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWdZaNYhdT+6pM7fAAlb98e+/K31jiIOW09rb/O7qhg5RhVhUwBnVemMD/56//cCrA+HcZJpUSPjYS9vsXsJOjcqcJMuXKsI5sH4VJJ4iorOo8j6mpCSkegiLA9UYlsV9J/ArRaIQjPy+BfuM4JgzGAlvLfWJlc04uWvbuNm2qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnnZHI22; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCA4C4CEF1;
	Fri, 12 Sep 2025 19:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757706233;
	bh=mDXKdIa89IcPIb6Hy/A6UcB63/viBmrhTut69A9OiUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XnnZHI22qDF931x6CJv+BqYLhuFugU8ktt1tobj8v6mAhl/9bbPq2orC58ntTKMF4
	 +RPQurwRbusSApBTRtIvd91EiqLqBv268OPDTbGCoXMrcqKnOA/tXnfyyII84Uyc4H
	 IJGRa76ry6stZ1FP0WQymjMj0ZxY998ekqV2RfkXwTIHGwWrsJO4l5V0ggEdYwrDjg
	 zozSkVGrMBEZyy4UQc5L19/L3/1+TccLlR60fF78G6JQCTFBPrIYGDdeeKzAyPMCkr
	 yxmow2619i9pzoV2Kd60yUXqzDFvqQKyWc0HUJcl+MX9B7dHJeJXyi5DlfkBbqIEgQ
	 s/w94BvbAOe+w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v1 4/4] ACPI: property: Adjust failure handling in
 acpi_nondev_subnode_extract()
Date: Fri, 12 Sep 2025 21:43:41 +0200
Message-ID: <3383971.44csPzL39Z@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5046661.31r3eYUQgx@rafael.j.wysocki>
References: <5046661.31r3eYUQgx@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make acpi_nondev_subnode_extract() follow the usual code flow pattern
in which failure is handled at the point where it is detected.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/property.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -123,20 +123,21 @@ static bool acpi_nondev_subnode_extract(
 	if (acpi_enumerate_nondev_subnodes(scope, desc, &dn->data, &dn->fwnode))
 		result = true;
 
-	if (result) {
-		/*
-		 * This will be NULL if the desc package is embedded in an outer
-		 * _DSD-equivalent package and its scope cannot be determined.
-		 */
-		dn->handle = handle;
-		dn->data.pointer = desc;
-		list_add_tail(&dn->sibling, list);
-		return true;
+	if (!result) {
+		kfree(dn);
+		acpi_handle_debug(handle, "Invalid properties/subnodes data, skipping\n");
+		return false;
 	}
 
-	kfree(dn);
-	acpi_handle_debug(handle, "Invalid properties/subnodes data, skipping\n");
-	return false;
+	/*
+	 * This will be NULL if the desc package is embedded in an outer
+	 * _DSD-equivalent package and its scope cannot be determined.
+	 */
+	dn->handle = handle;
+	dn->data.pointer = desc;
+	list_add_tail(&dn->sibling, list);
+
+	return true;
 }
 
 static bool acpi_nondev_subnode_data_ok(acpi_handle handle,




