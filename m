Return-Path: <linux-acpi+bounces-16957-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CA6B5849A
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 20:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D63A7B14CB
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEF82FE042;
	Mon, 15 Sep 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNgtsZkR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567EC2C375E;
	Mon, 15 Sep 2025 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757961009; cv=none; b=KKn+HICWU1v4hekq8BrmufMohKMXZ4aGQ5Kxe0nBI9YidTff6Sd9uW/MwQC7cexdMNrVy4vcLkKFmg1KCpnHWErREwlMrKe2ZxVsQ8a/6K8SUEV8yx6AItCW2lzdmtvrbeN38wAsiZ/4dqEJrW55iM3kYXXZeLvD7UDZp0S2Ufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757961009; c=relaxed/simple;
	bh=XXx0fvR/iZHwG9J8k92ip4f2K/TpzlOCmmuuBLvoaqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5377XOG/7z+lie16ZcTO3FTvY8RX1H5Clymev1wdV/5s2SXk93cM9bGc+vmWr3/KF810tnzOhLlzPVlidMxO9+dUcC7wRIXFzW08uBU+NGv1DyX+VhuxFRL/ssms4nuHfGFu+asYk+eWT4yAALcQy8jOKUx+3/qkfsYKgtcpBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNgtsZkR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C742C4CEF1;
	Mon, 15 Sep 2025 18:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757961009;
	bh=XXx0fvR/iZHwG9J8k92ip4f2K/TpzlOCmmuuBLvoaqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNgtsZkRVBQOsl2JMT7S7TyfhqkWyDnflUtnX7s61AByzRnz6l9FGT8Xyu+2rKN40
	 90acA3qG7Rbe3Ly0msjMNVC8Iznhu0qgmD/bQYssm3lT9kLQg3Ic8g8bqZbY+ve8Fd
	 GAQc/e3/ZR1VpdP4RsbYn6nBAjHWRKOat146YGfo0caYBpkZIjn50AnqklgC02X4yR
	 liUlzzdQ0JCjJO65fRaUMBVbIZMf5xwPB5PXMKtsca98Ddn7FP1Rt4f6T1xwZhl6QA
	 UD73LFYoIl6WjtkdrmZgR3hvp4h9IdTa9BBZ/vppHyDS92YBqrtU0qsfeVxJL7mLU7
	 r7ckC0CukNM8g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Subject:
 [PATCH v2 5/5] ACPI: property: Adjust failure handling in
 acpi_nondev_subnode_extract()
Date: Mon, 15 Sep 2025 20:29:50 +0200
Message-ID: <2322469.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <5922318.DvuYhMxLoT@rafael.j.wysocki>
References: <5922318.DvuYhMxLoT@rafael.j.wysocki>
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

v1 -> v2: Previously [4/4], no changes

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
 
 static bool acpi_nondev_subnode_ok(acpi_handle scope,




