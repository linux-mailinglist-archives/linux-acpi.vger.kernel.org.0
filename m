Return-Path: <linux-acpi+bounces-19433-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCB3CA60AB
	for <lists+linux-acpi@lfdr.de>; Fri, 05 Dec 2025 04:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49277319F5B5
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Dec 2025 03:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC23286889;
	Fri,  5 Dec 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftpDCE9P"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE8B7081E;
	Fri,  5 Dec 2025 03:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906763; cv=none; b=NhGQ3Fu/zmuWZGHA0Kz/f4FQjsrH2tTZS/3H7hOo51iBBrcf8eyq0v9jMM1MJRnURRMTmx3U9Hee4Raozn7GyhsY4dU/oxOE+g1kby9lMe3ungxxZbs6ityS8afp7UK5shhGpOu6hUWCA77mL0TBe8NGOp4Kx52bZzMmILwQnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906763; c=relaxed/simple;
	bh=uhAu0R4lnraS00WX9uVrJqv2qbPtIH5Aet9UvnWAK7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eFpYabtTNq+BjwacWcrMMm70QasUwW1vmS9KJaNZdx7HWoe/yNHoFG1/MpoLC7ht270OzVQHuEovvVKxzYA14yPl4Bs1bT+lG79iPSaYbEB3KABRZvAY3Kzotgj7wbvocJjGWc7floQHnv4PXQpzwI+j3PS5lLxla26CzAhatos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftpDCE9P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7481BC4CEF1;
	Fri,  5 Dec 2025 03:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906763;
	bh=uhAu0R4lnraS00WX9uVrJqv2qbPtIH5Aet9UvnWAK7E=;
	h=From:To:Cc:Subject:Date:From;
	b=ftpDCE9PVQs9TNhOb1A3Imxm2lyIunnW7YAWCuj2YMnRLH7aGqBfymQD6pGbHDBiB
	 2iBzXkeW7HJeFjC+sYM7LZ01Wq7MPYhzA4e90PO2WGu6pA5xdPGd800OMkqzM4hnyz
	 SMY5Y5aFd3rLi5c13hkk3EVmOcjINNLgaOim/n6cSsKkWzEOlyQzdgyjeSIKQ/mHDP
	 87LNy9JSRBUYulYDR+aF7qNQT+SjJCqYA702ac6y4K7Jax+5bPwgu5Phv4LOWsJW6G
	 LKFG4i/CqoUYjy4U4Ax+a0d9duAKOzreBlT/V1v/Bm49LAJvHU/y3edTemIxdbzbtI
	 9ievSOIl3P+dQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] ACPI: property: Use ACPI functions in acpi_graph_get_next_endpoint() only
Date: Thu,  4 Dec 2025 22:52:30 -0500
Message-ID: <20251205035239.341989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
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

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 5d010473cdeaabf6a2d3a9e2aed2186c1b73c213 ]

Calling fwnode_get_next_child_node() in ACPI implementation of the fwnode
property API is somewhat problematic as the latter is used in the
impelementation of the former. Instead of using
fwnode_get_next_child_node() in acpi_graph_get_next_endpoint(), call
acpi_get_next_subnode() directly instead.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20251001104320.1272752-3-sakari.ailus@linux.intel.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

## Analysis

### 1. COMMIT MESSAGE ANALYSIS

The commit message states:
- Problem: `acpi_graph_get_next_endpoint()` calls
  `fwnode_get_next_child_node()`, which dispatches back to ACPI code,
  creating unnecessary indirection.
- Solution: Call `acpi_get_next_subnode()` directly instead.

No "Cc: stable@vger.kernel.org" tag, no "Fixes:" tag, no explicit bug
report link. The message says "somewhat problematic," indicating an
architectural issue rather than a critical bug.

### 2. CODE CHANGE ANALYSIS

The diff shows 4 replacements in `acpi_graph_get_next_endpoint()`:
- Line 1475: `fwnode_get_next_child_node(fwnode, port)` →
  `acpi_get_next_subnode(fwnode, port)`
- Line 1493: `fwnode_get_next_child_node(port, prev)` →
  `acpi_get_next_subnode(port, prev)`
- Line 1495: `fwnode_get_next_child_node(fwnode, port)` →
  `acpi_get_next_subnode(fwnode, port)`
- Line 1499: `fwnode_get_next_child_node(port, NULL)` →
  `acpi_get_next_subnode(port, NULL)`

Call chain:
1. `fwnode_get_next_child_node()` dispatches via `fwnode_call_ptr_op()`
   to the fwnode-specific implementation.
2. For ACPI fwnodes, it calls `acpi_get_next_present_subnode()`
   (registered at line 1747).
3. `acpi_get_next_present_subnode()` filters non-present device nodes
   and calls `acpi_get_next_subnode()`.

Why the change is safe:
- Graph endpoints are ACPI data nodes (checked by `is_acpi_graph_node()`
  at line 1448: `is_acpi_data_node(fwnode)`).
- `acpi_get_next_present_subnode()` only filters non-present device
  nodes (lines 1407-1408), not data nodes.
- Therefore, for graph endpoints, `acpi_get_next_subnode()` and
  `fwnode_get_next_child_node()` behave the same.

### 3. CLASSIFICATION

This is a bug fix addressing an architectural issue:
- Removes unnecessary indirection in ACPI-specific code.
- Avoids a circular dependency pattern (ACPI → generic → ACPI).
- Functionally equivalent for graph endpoints.

Not a feature addition, not a new API, not a refactor.

### 4. SCOPE AND RISK ASSESSMENT

- Scope: 4 lines changed in one function in one file.
- Risk: Very low — same behavior for graph endpoints, cleaner
  architecture.
- Complexity: Low — direct function call replacement.

### 5. USER IMPACT

- Who is affected: Users of ACPI graph endpoints (e.g., camera/media
  drivers, device tree-like ACPI usage).
- Severity: Low — architectural improvement, not a visible bug fix.
- Likelihood: The "somewhat problematic" wording suggests no immediate
  user-visible issue.

### 6. STABILITY INDICATORS

- Reviewed-by: Laurent Pinchart, Jonathan Cameron
- Signed-off-by: Rafael J. Wysocki (ACPI maintainer)
- No "Tested-by:" tags
- Commit date: October 1, 2025 (recent)

### 7. DEPENDENCY CHECK

- `acpi_get_next_subnode()` exists in the same file and has been present
  for years.
- No external dependencies introduced.
- Should apply cleanly to stable trees that have this code.

### 8. HISTORICAL CONTEXT

Related commits:
- `79389a83bc388`: Introduced `acpi_graph_get_next_endpoint()` with
  `fwnode_get_next_child_node()` calls.
- `48698e6cf44c3`: Introduced `acpi_get_next_present_subnode()` to
  filter non-present devices.
- `5d010473cdeaa` (this commit): Removes the indirection.

The pattern existed since the function was introduced; this commit
cleans it up.

### 9. STABLE KERNEL CRITERIA EVALUATION

- Obviously correct: Yes — direct call instead of indirection.
- Fixes a real bug: Yes — architectural issue that could cause problems.
- Important issue: Moderate — architectural improvement, not a critical
  bug.
- Small and contained: Yes — 4 lines, single function.
- No new features: Yes — same behavior, cleaner code.
- Applies cleanly: Yes — should apply without conflicts.

### 10. RISK VS BENEFIT

Benefits:
- Removes unnecessary indirection.
- Avoids circular dependency pattern.
- Improves code clarity.
- No functional change for graph endpoints.

Risks:
- Very low — functionally equivalent change.
- No new code paths or logic changes.

### 11. CONCERNS AND CONSIDERATIONS

- No "Cc: stable" tag, but that alone doesn't disqualify.
- Recent commit (Oct 2025) — hasn't been in mainline long.
- No explicit bug report or user complaint mentioned.
- Architectural improvement rather than a critical fix.

### CONCLUSION

This is a small, correct fix that removes unnecessary indirection in
ACPI code. It fixes an architectural issue and is functionally
equivalent for graph endpoints. It meets stable kernel criteria:
correct, fixes a real issue, small scope, no new features, and should
apply cleanly.

However, it's an architectural improvement rather than a critical bug
fix, and there's no explicit stable tag or user-visible bug report. The
"somewhat problematic" wording suggests it may not cause immediate
visible problems.

Given the conservative nature of stable trees and the lack of evidence
of user-visible impact, this is borderline but leans toward acceptable
for stable backporting due to its correctness, small scope, and
architectural benefit.

**YES**

 drivers/acpi/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index 43d5e457814e1..76158b1399029 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -1472,7 +1472,7 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 
 	if (!prev) {
 		do {
-			port = fwnode_get_next_child_node(fwnode, port);
+			port = acpi_get_next_subnode(fwnode, port);
 			/*
 			 * The names of the port nodes begin with "port@"
 			 * followed by the number of the port node and they also
@@ -1490,13 +1490,13 @@ static struct fwnode_handle *acpi_graph_get_next_endpoint(
 	if (!port)
 		return NULL;
 
-	endpoint = fwnode_get_next_child_node(port, prev);
+	endpoint = acpi_get_next_subnode(port, prev);
 	while (!endpoint) {
-		port = fwnode_get_next_child_node(fwnode, port);
+		port = acpi_get_next_subnode(fwnode, port);
 		if (!port)
 			break;
 		if (is_acpi_graph_node(port, "port"))
-			endpoint = fwnode_get_next_child_node(port, NULL);
+			endpoint = acpi_get_next_subnode(port, NULL);
 	}
 
 	/*
-- 
2.51.0


