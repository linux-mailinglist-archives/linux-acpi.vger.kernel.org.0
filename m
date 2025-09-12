Return-Path: <linux-acpi+bounces-16768-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2BEFB5575B
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 22:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01F7AA1E3E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 20:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088EC31DD81;
	Fri, 12 Sep 2025 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rxu2b2hM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52302BE037;
	Fri, 12 Sep 2025 20:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757707591; cv=none; b=cNpdZUlHm5gK6r+99bzDzqZaGoCw4yX3FPhVZyTkEKDUJBUK1LDXRjpTPfIF1ljGYgfSkrnr+yDRHvjymzYQduDzV9c+Um0klod8AZyZNy/NSFPmzetnck/mnp4ecRV5Km0kmVkSNJEx5c5Oy2r2dXB06/Hg2BizJqvbCPe8yD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757707591; c=relaxed/simple;
	bh=4qfHyfQbLYIFkgMw3OTcrEKwDy8kS2doyl0jsKPHOjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tb1MwiWfHqtXQCr27BgawUiZzpzAup08V3UJtSWChdncdher/NAh+PHBNE79p9tm8RWstZZIhKDbeGJebXP23brBbDtINPFCOQCYaNAxRRrOhrKUuw43nvoyUNL2fDmtcltFIaxuN6d7Jp+6VzAG1dIEWinysd3yzBc8huVSFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rxu2b2hM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8873FC4CEF4;
	Fri, 12 Sep 2025 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757707591;
	bh=4qfHyfQbLYIFkgMw3OTcrEKwDy8kS2doyl0jsKPHOjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rxu2b2hMYPe0GGPkNYz+nGULL8IT/LSl57TiMW8vG63AcSCglk52sBDA6sXiqRjlQ
	 v+Icq7Z2OvuaW7PXVGYMUzhJGss9NZZ6hallFriYb3K/e05Pfu6N6AyX8MGjQ6qEJF
	 1vQYzGqqREIzUAODsQIixzgYRSAePbEuEVk2IFER38x0MbLOprWCDxlbYcamEspxbD
	 +kIddVb5TG7f4tBIV0GNg6uNRgkZxpDjbnhC4NDMIZrMCUenuXeM/mSz+Ksp5pKqV7
	 /WcK2oxwNJhCOwNW/yofjNV+S39bn+TEDfI5MlWkZ8p278gHfU6M7FeFI4YyxXWhU3
	 yYcZ1YqY8/gvg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 12/16] ACPICA: Update version to 20250807
Date: Fri, 12 Sep 2025 22:02:32 +0200
Message-ID: <2528460.jE0xQCEvom@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <2021361.PYKUYFuaPT@rafael.j.wysocki>
References: <2021361.PYKUYFuaPT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Saket Dumbre <saket.dumbre@intel.com>

Link: https://github.com/acpica/acpica/commit/0845a773
Signed-off-by: Saket Dumbre <saket.dumbre@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acpixf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 97c25ae8a36e..e65a2afe9250 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -12,7 +12,7 @@
 
 /* Current ACPICA subsystem version in YYYYMMDD format */
 
-#define ACPI_CA_VERSION                 0x20250404
+#define ACPI_CA_VERSION                 0x20250807
 
 #include <acpi/acconfig.h>
 #include <acpi/actypes.h>
-- 
2.51.0





