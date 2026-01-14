Return-Path: <linux-acpi+bounces-20297-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77147D1EDAA
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BA493047427
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D1F39A7ED;
	Wed, 14 Jan 2026 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8zsIMZ4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F9399A66;
	Wed, 14 Jan 2026 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394507; cv=none; b=iQ8098Hh2s5CqkBxZO6q6OUlZMumsecudynvO9JiKgAEy6FqZ7t2OLFRHJLSUUAXrmFS0YIWmsy9xr91RBOMZAWC0aJ23QvEHScClKjZfz/onqjx8Cq9L7RummLxlw9cL0jlHjLG/1rpHpfWaVckIOvIxhyLFpc0B1JnVkExK84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394507; c=relaxed/simple;
	bh=xMGFgTeldJ7Bw1R6I7bwEaow3TJMWyeG3TvspLUMabk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCPkelPHZ+CMtkRJmP0i1h4y3l8g5OZLrKTlGxKrZoG/zfhndXL6+Ipmy0y/eHEXl9t389OviJUgFxSGPd0LNW3OSB6TB72+42jjdkibE7M8IjhYcrC3nVd56jVD5kBr9Chs1xl0B1nUVmKtyejzzi1Np1wQI46RtNkG0/AHuYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8zsIMZ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF9CC16AAE;
	Wed, 14 Jan 2026 12:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394506;
	bh=xMGFgTeldJ7Bw1R6I7bwEaow3TJMWyeG3TvspLUMabk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8zsIMZ4JlQ/chfdgs+U/96xbv0c7OEcZJBiokKLS22XpbgriWfG80fs5zbux56VD
	 WFQ2FJrEv2IhZ+MPTQRhXJ5+I6UQW0CO0Hdztkjby6VaAJwI48LbwCVz/e/NsWUmOA
	 jo/YFtj13DaVw+Ry6ch6emkOjmMqv3gzegHWbcVxBHbRnV4j603SE+Cs8pQfsviyK3
	 YTuJ15EN72J/iWCw8TgHdgBGYimeCwBl11tMhVZPvQ2vGFMhUaoFz5CTPH5mGGEEfh
	 15CRZFy0mIEGqYJJIooHT60vsXGiCMkM5uTIRISeGxNvjFa0Mo1KK+cM3aFeZ1+iIm
	 7jdHuDtf+TKgA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 20/26] ACPICA: Fix Segmentation Fault error related to DTPR
Date: Wed, 14 Jan 2026 13:34:43 +0100
Message-ID: <2541195.jE0xQCEvom@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12822121.O9o76ZdvQC@rafael.j.wysocki>
References: <12822121.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Michal Camacho Romero <michal.camacho.romero@intel.com>

Fix Segmentation Fault error, caused by invalid buffer lenght in DTPR
Table Template:

 * Update buffer length for TPR Table, which invalid value caused
   Segmentation Fault, during ASL file production.

 * Refactor invalid values of TPR instances, arrays and serialization
   requests count and TPR Base addresses in the DTPR table template.

 * Fix offset updating in the acpi_dm_dump_dtpr function.

Link: https://github.com/acpica/acpica/commit/f75850bc4717
Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl1.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
index 89541cd0c9b0..59fbd64405be 100644
--- a/include/acpi/actbl1.h
+++ b/include/acpi/actbl1.h
@@ -2057,12 +2057,12 @@ struct acpi_tprn_limit_reg {
 *******************************************************************************/
 
 struct acpi_tpr_serialize_request {
-	u64 sts:1;		// status of serialization request (RO)
-	// 0 == register idle, 1 == serialization in progress
-	u64 ctrl:1;		// control field to initiate serialization (RW)
-	// 0 == normal, 1 == initialize serialization
+	u64 sr_register;
+	// BIT 1 - status of serialization request (RO)
+	//         0 == register idle, 1 == serialization in progress
+	// BIT 2 - control field to initiate serialization (RW)
+	//         0 == normal, 1 == initialize serialization
 	// (self-clear to allow multiple serialization requests)
-	u64 unused:62;
 };
 
 /* Reset to default packing */
-- 
2.51.0





