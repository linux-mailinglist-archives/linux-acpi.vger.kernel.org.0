Return-Path: <linux-acpi+bounces-13482-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F32AAB67D
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 07:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 378397A9E60
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 05:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B726C2D86A3;
	Tue,  6 May 2025 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nn2oTv8Z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D09836BA5B;
	Mon,  5 May 2025 22:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485819; cv=none; b=GYHig7J+/9eQOupQem6vPdV2eX5ymvMYdk2R0YNuf/oeEtYAvKo1H5DkpWkqRKNvVsosB9WkOyM90dVdauRTsnLAeOsd2l00aqlxr0ijLJIUuT7ZYoary5g14yLogkDRWiXtFmvdhakh939iY6jQGeGslwvC4quGl9vEq4Wjwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485819; c=relaxed/simple;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mw1I/rbwihIV6I2Tr89PcAST4WmHPs0lXyZWPgGOt5n2jkMGP6aU9VDpVh9CxEeSGRa7CqMyUuDLd3kHrwWDdehnxH+CTtgTd3bh+tTEwrBP911Sv/CRbII8UQ110Si3srDbZlSQo60j5oQMT3rJWAdIVFqKB2pG0FQ227UbCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nn2oTv8Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049DC4CEEF;
	Mon,  5 May 2025 22:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485818;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nn2oTv8ZN4fIfIyDACs+GCGThQctxrp6DNQqF6AZSbZSrxgEXUtGrFdO9DZSHjbcz
	 gsPFfjcc6K2bWicZ8NAHOBiae113Cnwbc0fAz8aExsnJ//9dPVSFjrSS4RPW2fLNKo
	 eRwKM8IkWkryMG8jrlR0pTXxRqW8urUEPSb6/yEYNf3QX+1ZgOWgkgV7liGfNsrydV
	 HFxk77hkfzzU6/rwoA1KBJo62hd0sXOkEfmKMgNmrUbr1rPd3/DIOcmb4exSEH7F05
	 rvhMU3IcEXhN7ieMaLFMJ5GU7KMb1ie2iw/IV646yLMbSsvAj4v+CI9Ff4zmn6PkE5
	 2BEyfg+yWoN7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 013/294] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP device list
Date: Mon,  5 May 2025 18:51:53 -0400
Message-Id: <20250505225634.2688578-13-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Diogo Ivo <diogo.ivo@siemens.com>

[ Upstream commit f06777cf2bbc21dd8c71d6e3906934e56b4e18e4 ]

Intel Over-Clocking Watchdogs are described in ACPI tables by both the
generic PNP0C02 _CID and their ACPI _HID. The presence of the _CID then
causes the PNP scan handler to attach to the watchdog, preventing the
actual watchdog driver from binding. Address this by adding the ACPI
_HIDs to the list of non-PNP devices, so that the PNP scan handler is
bypassed.

Note that these watchdogs can be described by multiple _HIDs for what
seems to be identical hardware. This commit is not a complete list of
all the possible watchdog ACPI _HIDs.

Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
Link: https://patch.msgid.link/20250317-ivo-intel_oc_wdt-v3-2-32c396f4eefd@siemens.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_pnp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pnp.c b/drivers/acpi/acpi_pnp.c
index 01abf26764b00..3f5a1840f5733 100644
--- a/drivers/acpi/acpi_pnp.c
+++ b/drivers/acpi/acpi_pnp.c
@@ -355,8 +355,10 @@ static bool acpi_pnp_match(const char *idstr, const struct acpi_device_id **matc
  * device represented by it.
  */
 static const struct acpi_device_id acpi_nonpnp_device_ids[] = {
+	{"INT3F0D"},
 	{"INTC1080"},
 	{"INTC1081"},
+	{"INTC1099"},
 	{""},
 };
 
-- 
2.39.5


