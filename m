Return-Path: <linux-acpi+bounces-20301-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 005B2D1EDBF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E97F13082AE6
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B28F39B487;
	Wed, 14 Jan 2026 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFvlX9uM"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEAE399A7B;
	Wed, 14 Jan 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394521; cv=none; b=SFJtA0foZje/I+ICDyeHNVuDNhdas/iN2MJPrfA4qydcOqXaJe9z7k02cI3mW0k5Y9TWtoVl8Hu3TkKifjne8+ABu/f5A2gLVp27y9AgzYAa6/YVI/q8Hd6rN3L8FkYrJN6SEP/KTbukOn7IO3a16lNjgMSytc/yYtRz6UUQy8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394521; c=relaxed/simple;
	bh=fjY2fj4x6v1JC4RCH1Wr4co07aVVa6LXg6P1IDohxvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G5gMr115vIk/Ct99UWnC3qEmkpXdYw1s1nHL4Ch27v7pUMN2RDvf51ye+gAnpxSLVMar4JZ86rQuAMHla0CYyZWm+RgGa5at7x8xSrkZ/Z5h/MKyYzFzDrXHvRrSmwzJW8agmQ2QZy1rOb+qBKOtbe/LTug7Et9PbIiKxLJWRDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFvlX9uM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E899C4CEF7;
	Wed, 14 Jan 2026 12:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394520;
	bh=fjY2fj4x6v1JC4RCH1Wr4co07aVVa6LXg6P1IDohxvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFvlX9uMaRlEk/bQg+AgrvpBdWNE0WdPx4XzlnvTSBVdbCbsLL4drvzhpO94rgZKg
	 g++MNQGHfGKOLaScpThTlsupPOYyj4M5T82XgTRWXZE/vFNgt3BeqO0j6QuKjOfkhg
	 U/SqUwzEW9tPOCV5fdFWuoQj407fTWifiJ2SrU2RkcpsXkC+Zpux3SYzp6CQAVdPW9
	 n4Y/IBCMBtPLx6gKdNOs9dV7r4awag2AoWAseGNZQxerAw7Y9xtZkT1orNqg1/U1Nm
	 j+02VQdz0icsw99bca6+080GcMykIkR2yv7qRQDN0jliXK51jgdfExOSJEU919qf/r
	 8D4RSGTtSKYHw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject:
 [PATCH v1 16/26] ACPICA: actbl2.h: ACPI 6.6: RAS2: Update Parameter Block
 structure
Date: Wed, 14 Jan 2026 13:31:06 +0100
Message-ID: <2263284.Mh6RI2rZIc@rafael.j.wysocki>
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

From: Pawel Chmielewski <pawel.chmielewski@intel.com>

ACPI 6.6 introduces RAS2 enhancements for patrol scrub functionality,
adding new fields to the Parameter Block structure. These fields are
applicable only in the response to the GET_PATROL_PARAMETERS command.

Link: https://github.com/acpica/acpica/commit/062842024000
Signed-off-by: Pawel Chmielewski <pawel.chmielewski@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/actbl2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 01dc35e4b60a..5c0b55e7b3e4 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -3249,6 +3249,8 @@ struct acpi_ras2_patrol_scrub_param {
 	u32 flags;
 	u32 scrub_params_out;
 	u32 scrub_params_in;
+	u32 ext_scrub_params;
+	u8 scrub_rate_desc[256];
 };
 
 /* Masks for Flags field above */
-- 
2.51.0





