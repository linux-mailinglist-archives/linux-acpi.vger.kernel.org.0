Return-Path: <linux-acpi+bounces-19434-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EB9CA60D2
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D47831E0C90
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 03:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1567128751B;
	Fri,  5 Dec 2025 03:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGDqP6xk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB33F287511;
	Fri,  5 Dec 2025 03:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906776; cv=none; b=TJBk3Y8HOYwBVC9QjeIstTopJ0ckckAHzg0h/R/DY9okiOmX1ipSHGCQCXVr1yY2sFSgaHZWAV/AXC3gFRl4TzHPHkxfansTu4ExQyZb7+P5ScaWx7QbaYfDSgRU9NN36QmdslwW9qZVVwXMGw0YnkuX/iIbsuu3kOEzLdwLmTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906776; c=relaxed/simple;
	bh=NUISdYukTJaqN4rnMX/MjabMnKemln+4pC0/rTyxsxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MZ7FgCh7b3qWLiv0Z/ZX+FusL5ARWZWEA5lYn/CHmVcy166Xmi078eIc/mARs8Irin702lDPMhFWvRnWModCb0/pLGv0CY7OuY9iv4PpeSB7vI1bu8BgZkqcQeU6oMDPRIgkixsBvaAH6JAiY2IJQ2nNNGwr6qhtC5pYv/BD9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGDqP6xk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED980C116D0;
	Fri,  5 Dec 2025 03:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906775;
	bh=NUISdYukTJaqN4rnMX/MjabMnKemln+4pC0/rTyxsxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGDqP6xkl5NEovweba7tB3prQECC5bMzHytZc0QuJT3+oz87EAi4AxYKUiq8mkrRm
	 HW4rujiGGNErH9qym3zT74+tBvPUnl0HpTVdbv0/1JMNZ3w81vEm8RItK1ZRPvfANN
	 0j7/SqFGEGL2MktO39i64fjSv6TKe0ns0RQXi42NuxnOH9XK6iRcREpqtifP8pdRqr
	 S6zCmGsgKmFoRz7N0ONlVAIMhAHls/Ndkhj+i3ZzVHHQCtllHF8c04Q/wCCyIKsA36
	 FKyOewkp+ei5tUCg6+4bFIq2W9lqLE41042dJw2B0oRgbkIqdkaUCXJJXkLMDqyuiY
	 HcZ0Uhu7Go7Uw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	WangYuli <wangyl5933@chinaunicom.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	robert.moore@intel.com,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.18-5.10] ACPICA: Avoid walking the Namespace if start_node is NULL
Date: Thu,  4 Dec 2025 22:52:35 -0500
Message-ID: <20251205035239.341989-6-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251205035239.341989-1-sashal@kernel.org>
References: <20251205035239.341989-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

[ Upstream commit 9d6c58dae8f6590c746ac5d0012ffe14a77539f0 ]

Although commit 0c9992315e73 ("ACPICA: Avoid walking the ACPI Namespace
if it is not there") fixed the situation when both start_node and
acpi_gbl_root_node are NULL, the Linux kernel mainline now still crashed
on Honor Magicbook 14 Pro [1].

That happens due to the access to the member of parent_node in
acpi_ns_get_next_node().  The NULL pointer dereference will always
happen, no matter whether or not the start_node is equal to
ACPI_ROOT_OBJECT, so move the check of start_node being NULL
out of the if block.

Unfortunately, all the attempts to contact Honor have failed, they
refused to provide any technical support for Linux.

The bad DSDT table's dump could be found on GitHub [2].

DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025

Link: https://github.com/acpica/acpica/commit/1c1b57b9eba4554cb132ee658dd942c0210ed20d
Link: https://gist.github.com/Cryolitia/a860ffc97437dcd2cd988371d5b73ed7 [1]
Link: https://github.com/denis-bb/honor-fmb-p-dsdt [2]
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Reviewed-by: WangYuli <wangyl5933@chinaunicom.cn>
[ rjw: Subject adjustment, changelog edits ]
Link: https://patch.msgid.link/20251125-acpica-v1-1-99e63b1b25f8@linux.dev
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Comprehensive Analysis

### 1. COMMIT MESSAGE ANALYSIS

**Subject**: "ACPICA: Avoid walking the Namespace if start_node is NULL"

The commit message clearly indicates:
- This is a fix to a prior fix (commit 0c9992315e73)
- It addresses a real crash on Honor Magicbook 14 Pro hardware
- The bug is a NULL pointer dereference in `acpi_ns_get_next_node()`
- Link to ACPICA upstream commit
  (1c1b57b9eba4554cb132ee658dd942c0210ed20d) - this is coordinated with
  the ACPICA project
- Signed off by Rafael J. Wysocki (ACPI maintainer) with "Reviewed-by"
  tag

**Missing tags**: No explicit `Cc: stable@vger.kernel.org` or `Fixes:`
tag, but this is clearly a fix to a stable-tree-relevant commit.

### 2. CODE CHANGE ANALYSIS

**The bug mechanism**:

Looking at `acpi_ns_get_next_node()` (lines 34-46 of nswalk.c):

```c
if (!child_node) {
    /* It's really the parent's _scope_ that we want */
    return (parent_node->child);  // <-- CRASH if parent_node is NULL
}
```

The original fix (0c9992315e73) added this check **inside** the
ACPI_ROOT_OBJECT branch:
```c
if (start_node == ACPI_ROOT_OBJECT) {
    start_node = acpi_gbl_root_node;
    if (!start_node) {  // Only catches: ACPI_ROOT_OBJECT +
gbl_root_node==NULL
        return_ACPI_STATUS(AE_NO_NAMESPACE);
    }
}
```

**The problem**: If `start_node` is passed as NULL directly (not via
ACPI_ROOT_OBJECT), the check is never executed:
- `start_node` remains NULL
- `parent_node = start_node;` makes `parent_node` = NULL
- `acpi_ns_get_next_node(parent_node, NULL)` dereferences
  `parent_node->child` → **KERNEL PANIC**

**The fix** (this commit): Move the NULL check outside the if block:
```c
if (start_node == ACPI_ROOT_OBJECT) {
    start_node = acpi_gbl_root_node;
}

/* Avoid walking the namespace if the StartNode is NULL */
if (!start_node) {  // Now catches ALL NULL cases
    return_ACPI_STATUS(AE_NO_NAMESPACE);
}
```

### 3. CLASSIFICATION

- **Type**: Bug fix (NULL pointer dereference crash)
- **Not an exception category**: This is a pure crash fix, not a device
  ID, quirk, or DT update
- **Severity**: Kernel panic/crash - HIGH severity for affected hardware

### 4. SCOPE AND RISK ASSESSMENT

**Lines changed**: 8 (minimal)
**Files touched**: 1 (`drivers/acpi/acpica/nswalk.c`)
**Complexity**: Trivial - literally moving 3 lines of code outside an if
block

**Risk**: VERY LOW
- The change only affects the code path when `start_node` is NULL
- For non-NULL `start_node`, behavior is identical
- The fix is obviously correct - you must catch all NULL cases
- The fix was also merged upstream to ACPICA project

### 5. USER IMPACT

**Who is affected**:
- Users with Honor Magicbook 14 Pro (FMB-P series)
- Potentially other devices with similar DSDT issues

**Impact severity**:
- Complete system crash (kernel panic) during boot
- System is completely unusable without this fix

**Evidence**: Real crash report linked in commit with DMI string: "HONOR
FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025"

### 6. STABILITY INDICATORS

**Positive signals**:
- Reviewed-by tag present
- Signed off by Rafael J. Wysocki (ACPI maintainer - highly trusted)
- Merged to ACPICA upstream (external validation)
- Very simple, obvious logic fix

**Concerns**:
- Very recent commit (Nov 25, 2025)
- No explicit Cc: stable tag

### 7. DEPENDENCY CHECK

**Dependencies**:
- Requires commit 0c9992315e73 to be present (it added the original NULL
  check that this fix improves)
- Commit 0c9992315e73 is already in stable trees (v5.18+, backported to
  many LTS trees)

The code change is self-contained - no other changes required.

### 8. HISTORICAL CONTEXT

The original commit 0c9992315e73 was introduced in March 2022 and was
backported to all stable trees. This new fix addresses a gap in that
original fix. The fact that the original fix was deemed stable-worthy
means this completion of that fix should also be stable material.

---

## Final Assessment

**Should this be backported?** YES

**Rationale**:
1. **Fixes a real crash**: NULL pointer dereference causing kernel panic
   on real hardware
2. **Minimal, surgical change**: Only 8 lines changed, moving code
   outside an if block
3. **Obviously correct**: The logic is trivial - catch ALL NULL cases,
   not just one path
4. **Completes a prior stable fix**: The original fix (0c9992315e73) is
   already in stable trees; this completes it
5. **Low risk**: Only affects NULL case; no behavioral change for
   working systems
6. **Externally validated**: Merged to ACPICA upstream project
7. **Trusted maintainer**: Signed off by Rafael J. Wysocki

**Backport considerations**:
- Should apply cleanly to all kernels that have commit 0c9992315e73
- May have minor copyright year conflicts (trivial to resolve)
- No functional dependencies beyond the original fix

The lack of explicit `Cc: stable` tag is likely an oversight. The commit
is clearly stable material as it fixes a crash that makes hardware
completely unusable.

**YES**

 drivers/acpi/acpica/nswalk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/nswalk.c b/drivers/acpi/acpica/nswalk.c
index a2ac06a26e921..5670ff5a43cd4 100644
--- a/drivers/acpi/acpica/nswalk.c
+++ b/drivers/acpi/acpica/nswalk.c
@@ -169,9 +169,12 @@ acpi_ns_walk_namespace(acpi_object_type type,
 
 	if (start_node == ACPI_ROOT_OBJECT) {
 		start_node = acpi_gbl_root_node;
-		if (!start_node) {
-			return_ACPI_STATUS(AE_NO_NAMESPACE);
-		}
+	}
+
+	/* Avoid walking the namespace if the StartNode is NULL */
+
+	if (!start_node) {
+		return_ACPI_STATUS(AE_NO_NAMESPACE);
 	}
 
 	/* Null child means "get first node" */
-- 
2.51.0


