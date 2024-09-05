Return-Path: <linux-acpi+bounces-8186-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2EF96DFCC
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 18:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3647328B65B
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Sep 2024 16:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119E1B12FB;
	Thu,  5 Sep 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ry35W/6q"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DBE1B12DF;
	Thu,  5 Sep 2024 16:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725553830; cv=none; b=Ilh+mEaInwhy8PaQGBdPlLCTOys4pXNUi5xn6dRPIQtGYReQpa8tEQweQBjZMeQ1b0h/Vb3pMo0xHidWcViyhVXcYauzJSR8FLjAfkNzl6dSSbRsJJIYa/3Fe6NHda2xz4L5Nv4L5OSyetuepqSIu0VJms2GMufVzVbauCa62K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725553830; c=relaxed/simple;
	bh=XZ7K6Q+GJiNQh7jOC8M+XdWVBVAC/1BxSYrJDHfXPXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2DIZqGSEjM8dD08I15I/01A7rTTrqHsX54HOcRV+R9hvkVN/wtTxymgIKzUEMI2X6UiSp9G56/ysh3aF/zHZPFxcd+XgP/++byk8q/xb0gWHvncm9b1ZMB8c0VRZI4sUh89Tw2pkL41RJ3Ms66mNfzUYTVGqxHuEWeg+Kexzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ry35W/6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECC1C4CEC5;
	Thu,  5 Sep 2024 16:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725553830;
	bh=XZ7K6Q+GJiNQh7jOC8M+XdWVBVAC/1BxSYrJDHfXPXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ry35W/6quC7b4BBuc2q3MVv+P1Gy74ff9eX3m9FFLrQ/8sk+SXVUDYFE5ks4QTB4u
	 1XlBMu7+WEW6j9soNmWYITemPs/0kaJPxTo8Vogs9M2+NXCg61XjWkg+E0PqeNY+jH
	 7lFCS20Zo8RbNZmb/RqoJl6yKcU28y3aXipkOylKj91xI24//FjrRVRF7xBhKOxSJi
	 xPp+JOOBKhR/w5DH0DYNjHA020DVhSqZOX2XJrAT8eyHxdyF811IG+wwCv+4s9UtkM
	 SzHmYb/sArMNUzmFHGnRHRJZb2ThazTOkN4qKf5DxReJURdpQEHAVjtVAX25pSCiCI
	 i918ESuJBSWXg==
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
Subject: [PATCH v3 11/11] amd-pstate: Add missing documentation for `amd_pstate_prefcore_ranking`
Date: Thu,  5 Sep 2024 11:30:07 -0500
Message-ID: <20240905163007.1350840-12-superm1@kernel.org>
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

`amd_pstate_prefcore_ranking` reflects the dynamic rankings of a CPU
core based on platform conditions.  Explicitly include it in the
documentation.

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v2->v3:
 * Add tag
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


