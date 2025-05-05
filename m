Return-Path: <linux-acpi+bounces-13471-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC4AA9F16
	for <lists+linux-acpi@lfdr.de>; Tue,  6 May 2025 00:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD01A81D55
	for <lists+linux-acpi@lfdr.de>; Mon,  5 May 2025 22:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4427627D79C;
	Mon,  5 May 2025 22:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQXPCr2K"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1594827D793;
	Mon,  5 May 2025 22:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483295; cv=none; b=gF2UOoA9cTMaT4bsYpa5o1kyQe41NNCcXV/+qAou4+rzVCqfDrZqcrD77T/ljxTKRRUCl43uA40zLO06Re30RLVY2YC5BapAYB5+IlM/1Wb0tprrrQ7URIE0WLhxvJFG+rHF14lyreLz9QJf5WVBMAZxBBHqnRbEE0NFmgs2mGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483295; c=relaxed/simple;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZF2t44KUfkbuJ3WkqLSBlTNYPSqJLh4cm9QWMUmVmvZfPg5RZEmwKlyMapD68HArFgyoeejvoI0huYoZ8D35641s44DdOajWdfcSZuTy/bUTacQWBw2T9Y7pAMzO2ddi5nm3e/I8j3wir7xzE7Q4JFUQn42MJHyt7VOfW6nl5a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQXPCr2K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A05C4CEEE;
	Mon,  5 May 2025 22:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483294;
	bh=3NjjJic+KfXlHN5dzLwkv6OiL634PsPW6GB6dHVFi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WQXPCr2KieWNhmjUKfOeLAIyUUmlI9G46Dk+6fnUzReL1M6b2WSrAEJ4cw+5GE+BS
	 uW89hsRQ9sUT1QaTQohVfF191nf+6RgfVwBdk6eFBGrFHH84qRsYF2qLuFDOZsBpOz
	 dmhmmoEZVK9Ql/qYh9H3uocF/35btvthHXwF8zwZKZlMRBYGlCxBw8Wyh+eWQxHp4Q
	 LGHFlceP5VxdXcTP6js/b4mCTjSUPwvVdWU+dC4qPw+tA3mwp+tvSgomiTNshQGqxa
	 CJEYpkUmW2nIM1YTDLdqGVkGcJIs+67MpEvtQvVfm+9T+KlTMdwBCHwB0UCs3Gm/Xe
	 0n0YDISeuqHPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Diogo Ivo <diogo.ivo@siemens.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 019/642] ACPI: PNP: Add Intel OC Watchdog IDs to non-PNP device list
Date: Mon,  5 May 2025 18:03:55 -0400
Message-Id: <20250505221419.2672473-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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


