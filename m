Return-Path: <linux-acpi+bounces-14048-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E403CACA381
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 01:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599813B6B49
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Jun 2025 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E1BB28151C;
	Sun,  1 Jun 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0tn9L/A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB2F28137E;
	Sun,  1 Jun 2025 23:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748820555; cv=none; b=e5LQoIppBNx6zHpDBgDGtfas9SZd3KfHmOR8fABqLEybj4bDMORBilwokYgs7Vrb9w5NXv9FuVyS2M05ODMq3SkRs3XZMqENfB7eVO1JVBo9euPOlhQd4wOCg0eKqwI4PpWU7Me2OoX3mmIo7o5egSle1f5hU3OKMncZXy5H1Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748820555; c=relaxed/simple;
	bh=wp/Ie4gCYpVkVdYHMkiWZOquB9vU2Le6O1WmW1eUOH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFezX50BAhje1laOsGnKpRaPF5/0f8hIW/NyrvJ4eoAf0+UCGAWkgngjD+om7PHNBJq5dMRntrp6WWslFbQ4GRkQTt3zg9ObnmNj9SLzUc/t7cJpDkJP7obmUVc9xsjhq7T5YGqWlz0MYl3C6QDMU4O8yofRDZQd/OpxHli/06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0tn9L/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF51C4CEEE;
	Sun,  1 Jun 2025 23:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748820553;
	bh=wp/Ie4gCYpVkVdYHMkiWZOquB9vU2Le6O1WmW1eUOH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0tn9L/AAxcx5OYrBnVb6G3MvZYTaKMgyzHZXtg8OJIwJSm3hylAqgtXAplj94fHa
	 pu5ccn4DmAsKX51iRGTVmgjOn7ShEHLg4Ogezf/aAEFTORSyhz1f4moBmtqZB8ryBs
	 e6LHA+d+OSV8rVQ4ePHkNlJ5lhgAXPutts9PVLITTl/TLKi4HK3QD8NrqqeAeQ/SF2
	 E0hDK5SI8GG64UwVeKiMZA4ytTy+O2uLX+Tn5cK0Ok9s4NAQwPSus8YyJX6R5LD06x
	 tm+V0iymdkP2L9wlN/kVjLmWziD9qi5NTF9+j9GeyZduKiWackXPUks4MwEkkauFzY
	 M2EuQMKBY3IXQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: gldrk <me@rarity.fan>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.15 099/110] ACPICA: utilities: Fix overflow check in vsnprintf()
Date: Sun,  1 Jun 2025 19:24:21 -0400
Message-Id: <20250601232435.3507697-99-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601232435.3507697-1-sashal@kernel.org>
References: <20250601232435.3507697-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: gldrk <me@rarity.fan>

[ Upstream commit 12b660251007e00a3e4d47ec62dbe3a7ace7023e ]

ACPICA commit d9d59b7918514ae55063b93f3ec041b1a569bf49

The old version breaks sprintf on 64-bit systems for buffers
outside [0..UINT32_MAX].

Link: https://github.com/acpica/acpica/commit/d9d59b79
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/4994935.GXAFRqVoOG@rjwysocki.net
Signed-off-by: gldrk <me@rarity.fan>
[ rjw: Added the tag from gldrk ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should definitely be backported to stable kernel
trees. Here's my detailed analysis: ## Critical Bug Analysis This commit
fixes a serious overflow vulnerability in the ACPICA vsnprintf()
function that affects 64-bit systems. The commit message explicitly
states "The old version breaks sprintf on 64-bit systems for buffers
outside [0..UINT32_MAX]", indicating this is a critical functionality
bug. ## Code Change Analysis The fix replaces problematic boundary
checking logic: **Old problematic code:** ```c if (size !=
ACPI_UINT32_MAX) { end = string + size; } else { end =
ACPI_CAST_PTR(char, ACPI_UINT32_MAX); } ``` **New safe code:** ```c size
= ACPI_MIN(size, ACPI_PTR_DIFF(ACPI_MAX_PTR, string)); end = string +
size; ``` ## Why This Needs Backporting 1. **Security Issue**: The old
code could cause buffer overflows when `string + size` exceeds the
maximum pointer value on 64-bit systems, potentially leading to memory
corruption. 2. **Functional Breakage**: As stated in the commit message,
sprintf() functionality is completely broken for large buffers on 64-bit
systems, which could cause system crashes or boot failures. 3. **Low
Risk Fix**: The change is minimal and well-contained, using proper
ACPICA macros (`ACPI_MIN`, `ACPI_PTR_DIFF`, `ACPI_MAX_PTR`) that are
designed for safe pointer arithmetic. 4. **Core Utility Function**: This
affects `vsnprintf()`, a fundamental string formatting function used
throughout ACPICA, meaning the impact could be widespread. ## Comparison
to Similar Commits Unlike the previous ACPICA commits shown (which were
mostly code style changes, fallthrough annotations, or parameter
additions), this commit fixes an actual functional bug that breaks core
functionality on 64-bit systems. ## Stable Tree Criteria Met - ✅ Fixes
important bug affecting users - ✅ Small, contained change - ✅ Minimal
regression risk - ✅ Affects critical subsystem (ACPICA string handling)
- ✅ Clear technical necessity (prevents crashes/corruption) This is
exactly the type of critical bugfix that stable trees are designed to
carry.

 drivers/acpi/acpica/utprint.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/acpica/utprint.c b/drivers/acpi/acpica/utprint.c
index 42b30b9f93128..7fad03c5252c3 100644
--- a/drivers/acpi/acpica/utprint.c
+++ b/drivers/acpi/acpica/utprint.c
@@ -333,11 +333,8 @@ int vsnprintf(char *string, acpi_size size, const char *format, va_list args)
 
 	pos = string;
 
-	if (size != ACPI_UINT32_MAX) {
-		end = string + size;
-	} else {
-		end = ACPI_CAST_PTR(char, ACPI_UINT32_MAX);
-	}
+	size = ACPI_MIN(size, ACPI_PTR_DIFF(ACPI_MAX_PTR, string));
+	end = string + size;
 
 	for (; *format; ++format) {
 		if (*format != '%') {
-- 
2.39.5


