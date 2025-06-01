Return-Path: <linux-acpi+bounces-14069-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B284ACA79A
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 03:16:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6404917D014
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Jun 2025 01:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58397337842;
	Sun,  1 Jun 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXFUEfZk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28711337FCD;
	Sun,  1 Jun 2025 23:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821508; cv=none; b=DwVH0lSJzIpvpOYIpEIF9Xt/duwBG1i70GSp5ncFodCZtcOaH4DHp3LVRzwdw+erxS0KwFCW5daheOKAfJLf7z6LqkK8JqW13Ih8EiE69zmYScQsW7KEqUYry9q0FVyXJQJON8YlorZ6Wl1YLjz3gZPVcqDAlFNKJhl4ITvDM10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821508; c=relaxed/simple;
	bh=VVhxovnkjl4JnSzMOzwVw8swg5d1cLj784vqQ2+A5jA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+ENHiGWYlnKXXuK458Bluj+jla3Wfpxhg8Wloay7WoMef3+4VFpLa13B5BJc37LF3AgPBIcQHSplQIQrDPCtMHB6mom4prjoH6gMwPCWckfu4ITWg02EBFXNFGnKA4t7CQmZiBq0twvxBZJimgcyME5NJy4D2VtY1nj2Ikke44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXFUEfZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB418C4CEE7;
	Sun,  1 Jun 2025 23:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821508;
	bh=VVhxovnkjl4JnSzMOzwVw8swg5d1cLj784vqQ2+A5jA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXFUEfZkypLmSyego04cL3feUjW3gS4yXtoxREQbSMSoDSWhR7rWVNRsH8miigFA0
	 QT29H3aSgxPIynNIWWep8CLaVCr1+ZOD3QpoTlP0fxZigffxZhGYM6ODT1PRaLmUnj
	 V9bd5nt7e2Lwb4yigj+h4HQCcVwM5DQg4T0HMRX8nm4SVnCwbVmLFVDREAvSQhoEPD
	 1RqBQ4ZDLktcYAMdSBJ/IG3JFJ6p5BxKvvTenPJ32LrnFsUWOdDTffnRlBJU3CIjl7
	 v0gTt9eNahCxq4ngngy7GmHeSpp4GgAt+NvUN89iw3tyy1QAwE+Z/mxrVrPKmE9kwP
	 ftKnPgjQo0YPw==
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
Subject: [PATCH AUTOSEL 5.10 31/34] ACPICA: utilities: Fix overflow check in vsnprintf()
Date: Sun,  1 Jun 2025 19:43:55 -0400
Message-Id: <20250601234359.3518595-31-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234359.3518595-1-sashal@kernel.org>
References: <20250601234359.3518595-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 681c11f4af4e8..a288643e8acd3 100644
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


