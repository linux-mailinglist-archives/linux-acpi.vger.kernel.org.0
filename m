Return-Path: <linux-acpi+bounces-8185-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FB596DFC9
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:32:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C474528BC6B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D01AF4C9;
	Thu,  5 Sep 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEeRcFP4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16811AE056;
	Thu,  5 Sep 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553829; cv=none; b=PEYwYYJJl+jqj+abF3fpHZw92w8KGikkXP4H9TYt4yrdTo46L/Q2MGLk3EwZ9eDInfomWy/UNM/OSfZXOgsCXmPbySBiIIHG2hec8bc5Q+978vNSDUwdiWWxbpXtuIjIbFK+vCZ5NYl0FvACwNlCwRwZFkYMWU/kJhiNajnRiC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553829; c=relaxed/simple;
	bh=Hvu/JDym95sl9P2OaGdfnlcHvW9GhdS42LXTs42qNMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulutI5FSVs+uIQ7PtUIB6y7A6KsmASrO88aA6RKZyKfchWrRTJ6skB2nKs7323taALWwjpe7jzLv1Rk2XHnjaScfuOB44LMYHPiSvNUWIds9in7M40FHaTIElIb/4ovuDKwa8CZZRJt42ue+ud74REW+wmrQ2oiEzC73ivk75ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEeRcFP4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E2AFC4CEC3;
	Thu,  5 Sep 2024 16:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553829;
	bh=Hvu/JDym95sl9P2OaGdfnlcHvW9GhdS42LXTs42qNMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UEeRcFP4hQ/4B4S3/fx4scu5EFBZCQs5mdXWnQl6OZt/ZUKSlNEHTj5Dnw1uIHQlx
	 QZKUtYn86Rj/bbcGnCJEYF6Qu9yPrsUUgOmVOXhhxrRU0RygabQhrtCIAwDuIyJOTH
	 5Dz1WiLw/LbS2PT/3Zl8IJzG8yw5BxJj+0hsWG0mXjQDdNtD7RX08cCV94WkhJ5gvu
	 NcVNYL2VFj4dqhiUgZpOUdYzNPLvcjcP43vxNWNQ3IsAZfcVV4HoRzgTSpi5mIVRVH
	 IuxKEEfIq3Gv4ll5F57H7fkjhpxX6zGjNEzhagZOZe26fTZZd5bjZXRZh9vux4ir81
	 6CM1FsaZAR42A==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: Borislav Petkov <bp@alien8.de>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-acpi@vger.kernel.org (open list:ACPI),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v3 10/11] cpufreq: amd-pstate: Add documentation for `amd_pstate_hw_prefcore`
Date: Thu,  5 Sep 2024 11:30:06 -0500
Message-ID: <20240905163007.1350840-11-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240905163007.1350840-1-superm1@kernel.org>
References: <20240905163007.1350840-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Explain that the sysfs file represents both preferred core being
enabled by the user and supported by the hardware.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tag
---
 Documentation/admin-guide/pm/amd-pstate.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index e13915c540648..d5c050ea390dc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -263,6 +263,11 @@ lowest non-linear performance in `AMD CPPC Performance Capability
 <perf_cap_>`_.)
 This attribute is read-only.
 
+``amd_pstate_hw_prefcore``
+
+Whether the platform supports the preferred core feature and it has been
+enabled. This attribute is read-only.
+
 ``energy_performance_available_preferences``
 
 A list of all the supported EPP preferences that could be used for
-- 
2.43.0


