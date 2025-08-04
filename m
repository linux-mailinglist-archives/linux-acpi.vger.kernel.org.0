Return-Path: <linux-acpi+bounces-15507-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B79B1995B
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0BC1898463
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5422C204592;
	Mon,  4 Aug 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzikSoX6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2971313B5A9;
	Mon,  4 Aug 2025 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754268091; cv=none; b=SymDdk6Q6WBBhQ0A/5bI/VKoEpgcVMkguqkpyGjDw/s8xmuZvNnCydbESiRx5E2iN6rz6bkKH9EoHsycTQzVZUJtxHJVmANJX+l8jNuIIjAtSrDHpMrhERn7AQ4NXKnpfBn/BrOUuJxlSQqH0xugwK6+rj+6K6LEQoCiPcsdZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754268091; c=relaxed/simple;
	bh=vr+T+8Iu5K+89kk9ZOU5DBGHBBG/VG/yWVt+hpKs9Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JHoHBTabsYx4nV5YwUSTeT1/Ihn61qB95qgGNN/JyCAmfbGdBeDan1OIAv6+JXB80CMKu52wKR4ZrrUdaL/ZLTOtbPY4sdUSPgXK8VytHrnzdJCadA30hU89VQJl16UxSFTz8BtRVXRe1eugEWgUW/sqnSMA3VtcFMxXptlZaD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzikSoX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F793C4CEF8;
	Mon,  4 Aug 2025 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754268091;
	bh=vr+T+8Iu5K+89kk9ZOU5DBGHBBG/VG/yWVt+hpKs9Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FzikSoX6A4oiPElmE3Vc4Xxk5Q/UHSUREZoO+41KneMQfxf53wBAG6GMhJuE2qEwv
	 FJnT5aKmhQEvUKlrrtJrTuhYi7QxEHy4N96xiKh8oOJZyoZEagIzPsfojhDaMSF9ec
	 /a4JVD8mvVdmUV3dVb+kmhATC05NvjebbAfymU6UsSHl+SWE+1/aRui0k3j3aHzXnE
	 vbPg9REBFxyBkFRcwIWk9O2gjxjoLzbfuxeeNI/abwJ8FZoQFV7ioHkcYWAYOpXsdc
	 CBu4KFXMeNrXqBmcaTf2Z9RqLd3W34Ul363qnsG2cjWbUya93MppUE17NLnck9K2Sh
	 7SLoAM/PkC2UA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Ott <sebott@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 20/39] ACPI: processor: fix acpi_object initialization
Date: Sun,  3 Aug 2025 20:40:22 -0400
Message-Id: <20250804004041.3628812-20-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804004041.3628812-1-sashal@kernel.org>
References: <20250804004041.3628812-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.240
Content-Transfer-Encoding: 8bit

From: Sebastian Ott <sebott@redhat.com>

[ Upstream commit 13edf7539211d8f7d0068ce3ed143005f1da3547 ]

Initialization of the local acpi_object in acpi_processor_get_info()
only sets the first 4 bytes to zero and is thus incomplete. This is
indicated by messages like:
	acpi ACPI0007:be: Invalid PBLK length [166288104]

Fix this by initializing all 16 bytes of the processor member of that
union.

Signed-off-by: Sebastian Ott <sebott@redhat.com>
Link: https://patch.msgid.link/20250703124215.12522-1-sebott@redhat.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Based on my analysis, here is my determination:

**Backport Status: YES**

## Extensive Explanation:

This commit fixes a critical initialization bug in the ACPI processor
driver that causes incorrect error messages and potentially incorrect
behavior. Here's why this is a good candidate for stable backport:

### 1. **Clear Bug Fix**
The commit fixes an incomplete initialization issue where `union
acpi_object object = { 0 };` only initializes the first 4 bytes (the
size of `acpi_object_type type`), leaving the remaining bytes of the
union uninitialized. This results in garbage values in fields like
`object.processor.pblk_length`, causing spurious error messages like
"Invalid PBLK length [166288104]".

### 2. **User-Visible Impact**
The bug causes confusing error messages in system logs during ACPI
processor initialization. The error message shown in the commit (`acpi
ACPI0007:be: Invalid PBLK length [166288104]`) indicates that
uninitialized memory is being read and interpreted as a length value.

### 3. **Minimal and Contained Fix**
The fix is extremely simple - changing:
```c
union acpi_object object = { 0 };
```
to:
```c
union acpi_object object = { .processor = { 0 } };
```

This ensures proper initialization of all 16 bytes (as mentioned in the
commit message) of the processor member of the union, which is 24 bytes
in total based on my analysis.

### 4. **No Architectural Changes**
This is a pure bug fix with no feature additions or architectural
changes. It simply corrects the initialization to prevent reading
uninitialized memory.

### 5. **Low Risk of Regression**
The change is minimal and only affects initialization. It doesn't alter
any logic or behavior beyond ensuring that the union is properly zeroed
out. The designated initializer syntax is standard C and well-supported.

### 6. **Critical Subsystem**
While ACPI is a critical subsystem, this fix is confined to the
initialization of a local variable in `acpi_processor_get_info()`. The
scope is limited and the fix is conservative.

### 7. **Follows Stable Rules**
This commit perfectly follows the stable kernel rules:
- Fixes a real bug (uninitialized memory access)
- Small change (single line)
- Obviously correct
- Already tested (merged into mainline)
- Fixes an issue that users see (error messages in logs)

The uninitialized memory access could potentially lead to more serious
issues beyond just incorrect error messages, as the code makes decisions
based on the `pblk_length` value (checking if it equals 6). This makes
the fix even more important for stable kernels.

 drivers/acpi/acpi_processor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 707b2c37e5ee..74e949d340a1 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -228,7 +228,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { .processor = { 0 } };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
-- 
2.39.5


