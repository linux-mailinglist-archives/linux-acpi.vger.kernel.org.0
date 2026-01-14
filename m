Return-Path: <linux-acpi+bounces-20313-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 169F3D1EE01
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 13:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE888302AD93
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B829439B483;
	Wed, 14 Jan 2026 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CrVdrwwV"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB739A810;
	Wed, 14 Jan 2026 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394565; cv=none; b=UWnKgEr6bMG+GzKlorw0gznTFQXPSLAK+mPyK+LOfZ9cESmSIGDtloLfO5YPZvmOFUapEzMiSE8KmnzjmUnh2Osj8zmRfFMKPH6bTv3yHR0Y7SbtpfbWH53Upayu99g6mGxooqOAaXa8XNzV9A0mK7gB/xouBewmB8svu2tjSLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394565; c=relaxed/simple;
	bh=4qbSgtAPDXjKS/H9YDM/jNsBZWD6CucHJ1GTQsWgPa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSy1imVzGHzyo5fjXNDJH4eZ1+tew3cg0CTf2OU/ERuUEAjWbg4PfAzrGx8ktMOPRG7jlDEc7Pzi6jIU/mGOw+0zVqdy+XCsjv9tHlbsYCHpUZ/u9ClZwIAlGWgP3EA+ayD/v0acY0OciXv72LMMovABkToUkD1exUv0sQMaftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CrVdrwwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45851C16AAE;
	Wed, 14 Jan 2026 12:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768394563;
	bh=4qbSgtAPDXjKS/H9YDM/jNsBZWD6CucHJ1GTQsWgPa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CrVdrwwV399MqMA8p7tSsj8gjd4hQ0wH6auQfp1Wb6OoBw+ja0cmVBs0Qkp+wuxbu
	 fLpxHEdGojE5l4uvjUMFOSXNBTGw6HM3VJ8nzaDngvW3C9CJ/bRAh33vz77/dvDWc7
	 NPgkoLkzaA5m2bG3buqeO1TYQAh+1qZ47jMs7yYPg4ToD+lK/IqeHWpNZaXjPcDHrg
	 b7ZPYJ/71JRqVke8kM3e90/fjkxDtEy92iZEpTs00MukHUItiyXmz0K8aYuxSGYVWq
	 DA7OKtVXBG0+8p1Aj7Ai91X1pkVJ+X3YqnYmwDdhx337hMUZd/PmzSUsXL9Ogcs8sd
	 WorM2G6Qf2LzQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Dumbre, Saket" <saket.dumbre@intel.com>
Subject: [PATCH v1 04/26] ACPICA: Add UUIDs associated with TPM 2.0 devices
Date: Wed, 14 Jan 2026 13:19:22 +0100
Message-ID: <2254685.irdbgypaU6@rafael.j.wysocki>
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

From: Armin Wolf <W_Armin@gmx.de>

The Trusted Computing Group has designed multiple interface extensions
around TPM 2.0 devices including the ACPI start method, hardware
information and memory clear features. Add the associated UUIDs to the
list of known UUIDs so that the ASL compiler stops complaining about
them.

Link: https://github.com/acpica/acpica/commit/0e8b10b05825
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/acpi/acuuid.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/acpi/acuuid.h b/include/acpi/acuuid.h
index 0eda9d997f31..b2e29da6ba0a 100644
--- a/include/acpi/acuuid.h
+++ b/include/acpi/acuuid.h
@@ -37,6 +37,11 @@
 #define UUID_DEVICE_LABELING            "e5c937d0-3553-4d7a-9117-ea4d19c3434d"
 #define UUID_PHYSICAL_PRESENCE          "3dddfaa6-361b-4eb4-a424-8d10089d1653"
 
+/* TPM */
+#define UUID_HARDWARE_INFORMATION       "cf8e16a5-c1e8-4e25-b712-4f54a96702c8"
+#define UUID_START_METHOD               "6bbf6cab-5463-4714-b7cd-f0203c0368d4"
+#define UUID_MEMORY_CLEAR               "376054ed-cc13-4675-901c-4756d7f2d45d"
+
 /* NVDIMM - NFIT table */
 
 #define UUID_NFIT_DIMM                  "4309ac30-0d11-11e4-9191-0800200c9a66"
-- 
2.51.0





