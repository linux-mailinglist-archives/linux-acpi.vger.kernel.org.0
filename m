Return-Path: <linux-acpi+bounces-15502-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E83B198D7
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 02:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECAD01897C61
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 00:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D111F130B;
	Mon,  4 Aug 2025 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jes3PRZ5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2F51E7C38;
	Mon,  4 Aug 2025 00:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267866; cv=none; b=K9FUyMPcKWvzgfxAudJoiMCh/DyRzjEHii5koNeN6WK8PAKYl9E+b9eqSSRg5oHWpZFGMxlXtRezjxjyQMqHwcnhJO38yNO3+7HF+3SAgkZdmc+BmyCw/Yw1k44U1rER8CD5EcdOPp3r4t6eKiYVIXVodfdFABck30IvsTDPing=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267866; c=relaxed/simple;
	bh=j+0MW+exHE04Kl+zR/ro3FPj+d8z5IJ5CYki4O8t98I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTBnXxmFmWoPBgFLbXmjcQgYTy+LAxUI0OrSRaNRDpylPkv79Y32ga/Q6ANC8qjmPoWV7TxJKbV8ShBEpfDfhn5NYeygOpLPw1rXjyIz/7GC9+exbMGPvphzsLdnTBXvFq/8KqVP68f2zPd/UbjmFce6s6O5QvqzZxVfbj7zRKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jes3PRZ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1911EC4CEFB;
	Mon,  4 Aug 2025 00:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267866;
	bh=j+0MW+exHE04Kl+zR/ro3FPj+d8z5IJ5CYki4O8t98I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jes3PRZ5LBguMhUNQ5qOufJL9IUeVuKbWphmGIIadeJjVSlQR3VLmtusvxFcSQPeL
	 ZU5GB9ONBkpZ7cDIOvDYnnqPrWaoIDN+LN4oTjik54R3x1MWMwcsHGCBG9bPqPRfj+
	 VXJQ2hPX0t4t7y7/q7GVIru5Vo2UmXHIJyLOY7SrVA3kvbeDx7MZVlJFAil7zfelqZ
	 /XX6dntdCGweLy4MtCg81MMTnZb0XsxHZg/eBx/jabFu14/UBVBSe1LOhzWSrRyS8q
	 Rc9uwC23+WkeZeh+hPncyVU3VVopT2MHvrXBb4Zkj4c6nxcOOBdynS01rhMa3xGet/
	 19UZTcZFWtSNQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Ott <sebott@redhat.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 28/51] ACPI: processor: fix acpi_object initialization
Date: Sun,  3 Aug 2025 20:36:20 -0400
Message-Id: <20250804003643.3625204-28-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804003643.3625204-1-sashal@kernel.org>
References: <20250804003643.3625204-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.147
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
index 8bd5c4fa91f2..cfa75b14caa2 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -216,7 +216,7 @@ static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
-	union acpi_object object = { 0 };
+	union acpi_object object = { .processor = { 0 } };
 	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
 	struct acpi_processor *pr = acpi_driver_data(device);
 	int device_declaration = 0;
-- 
2.39.5


