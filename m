Return-Path: <linux-acpi+bounces-8121-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C49FD96A88E
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0218E1C2319F
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Sep 2024 20:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A923921C17C;
	Tue,  3 Sep 2024 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtyegceG"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E02D201279;
	Tue,  3 Sep 2024 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395840; cv=none; b=JYKZHwjSrCFoGC3F2evyEKheRIevkNrQI21V+z3P/HpjGzjuThAHlW1NByuVa6de6IarhNx6TXfako341i1m5cRUvsKUOqfRrWTmnRceE0mT7b9066IHBC/Xpwxd6XNPrzI39HJynfEhxIAGgpvcAoSZ7K7GPtghsmNjkRRvhaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395840; c=relaxed/simple;
	bh=UglMZej8JoFiX1K8RXVbHidL58fkydivL2IaXEJEqss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXNdeY80oioXL9zjisLBQBtt2dJaNxxtryc4XVHUIZLJf/uceOwnk1V/6n80r7slf2neg1YLB5zu6R/qHIg1is4wc6Hg6MwQ4ve76Cr4D00UzRiXC0/g2WB+oGu83ycspvJZ7RZFyvf7+5KEEqu4weA7cUSJoIjasnddBdF7gWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtyegceG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 315C2C4CEC9;
	Tue,  3 Sep 2024 20:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725395840;
	bh=UglMZej8JoFiX1K8RXVbHidL58fkydivL2IaXEJEqss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtyegceGDPYZhfAza6oR/FNSqeOU2Y+Zx11LaiHWJ0VkO88usaExSbTwHHc1MwEvF
	 YUaRAkHODFw+Mr6RL2ECMBYtN8R/908hIk1JOfMY1XsHHF2/PAejT+Nlmexpmk60sD
	 uUWXD4D+BBej8D9rXG9FSWxmYbXdf7kt7WYV5+jRziJV4lIjfQOnx+1Y8RXX/HRz1B
	 8r/g0NvA3fdUFQAIVB8SFg2SmiEOiudIZFUN05/seuXhp/sjmF6qrhPjNXHp4X2DP5
	 suJcdR88Kx416cknNHKTiST2ze/19bWsy9SwxHvPQHBng/e+qh/nP755ngYjwYGIKE
	 MkU4jVKr1pUjw==
From: Mario Limonciello <superm1@kernel.org>
To: Borislav Petkov <bp@alien8.de>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2 11/11] amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`
Date: Tue,  3 Sep 2024 15:37:01 -0500
Message-ID: <20240903203701.2695040-12-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903203701.2695040-1-superm1@kernel.org>
References: <20240903203701.2695040-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

`amd_pstate_prefcore_ranking` reflects the dynamic rankings of a CPU
core based on platform conditions.  Explicitly include it in the
documentation.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index d5c050ea390dc..210a808b74ec2 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -252,7 +252,8 @@ In some ASICs, the highest CPPC performance is not the one in the ``_CPC``
 table, so we need to expose it to sysfs. If boost is not active, but
 still supported, this maximum frequency will be larger than the one in
 ``cpuinfo``. On systems that support preferred core, the driver will have
-different values for some cores than others.
+different values for some cores than others and this will reflect the values
+advertised by the platform at bootup.
 This attribute is read-only.
 
 ``amd_pstate_lowest_nonlinear_freq``
@@ -268,6 +269,12 @@ This attribute is read-only.
 Whether the platform supports the preferred core feature and it has been
 enabled. This attribute is read-only.
 
+``amd_pstate_prefcore_ranking``
+
+The performance ranking of the core. This number doesn't have any unit, but
+larger numbers are preferred at the time of reading. This can change at
+runtime based on platform conditions. This attribute is read-only.
+
 ``energy_performance_available_preferences``
 
 A list of all the supported EPP preferences that could be used for
-- 
2.43.0


