Return-Path: <linux-acpi+bounces-19884-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3208CE6E2C
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 14:28:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 861C3301E92E
	for <lists+linux-acpi@lfdr.de>; Mon, 29 Dec 2025 13:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74483161AA;
	Mon, 29 Dec 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iqtl6w/O"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DD30F7FC;
	Mon, 29 Dec 2025 13:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014869; cv=none; b=iVlJop1d/gGIEFHUwWHER7kmxr/bsjzpeucoqSDpGHcHWxRYOKIlR2/uwRhGos0RjCVOJ0Lo1+NnXeetaHnEpzUPs8O9oePkg5XIcaYmAoZe5HPGdJYKQqpnraq7eY4+WZ8exQGJXeELp8uHFU2E/fleOMGjsPbiXi2hvkDL0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014869; c=relaxed/simple;
	bh=3mA3+dxGsxL+XupXevRUeN1KqNXK3m3S1aMn6HhP0VY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gUN9WhUJ8afaD3z2VVXelDdqeY3Efw9Jz2pmqpzP7yGhWUaM+EuvAT1X0+7WOFH24lExeT4HHseD3U9im8ciPZ6OxKu6/GGYTK6rjhp979CD/1H7F5FsTcZF/iBr0r+wypGadj328Krvt/LRvEDP97F5+rEE/R0zGxmX0JlUYWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iqtl6w/O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1608C4CEF7;
	Mon, 29 Dec 2025 13:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767014869;
	bh=3mA3+dxGsxL+XupXevRUeN1KqNXK3m3S1aMn6HhP0VY=;
	h=From:To:Cc:Subject:Date:From;
	b=Iqtl6w/ODRJwiNXKILxgDTZleHqc5ACTDOyYsam4eybcNgKrGAdF/JHlySym8usv1
	 6bY1XXLWOX+R+tMwWZEJS8tEwXCQHz7G60WFvGiAKbnr0n8K1KrS4j0A66afc1CkUZ
	 rirLducJWRFU54PqkGI9TsKj32liz9HNFdj6KtaS4QBPekgT9RMtO2cR/C0Bo17BUl
	 O0XkcHPEAnXgIYGNGxnHRE2udkE1pQ6mBadZECWwK9ziE8ErTZZwOrek5wVnZvEhAy
	 iknXMVLBAwadURn5ztoVESkTzPIMAzUSqqSyV2kpC+H8qBHreas56yj+iVSeawKvU2
	 +uejZuyGEJQaQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v1] ACPI: bus: Fix typo under sizeof() in acpi_run_osc()
Date: Mon, 29 Dec 2025 14:27:46 +0100
Message-ID: <2817106.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: 

The sizeof(32) in acpi_run_osc() should be sizeof(u32), so fix it.

Fixes: e5322888e6bf ("ACPI: bus: Rework the handling of \_SB._OSC platform features")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Commit e5322888e6bf is a linux-next one.

---
 drivers/acpi/bus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -294,7 +294,7 @@ acpi_status acpi_run_osc(acpi_handle han
 	int ret;
 
 	if (!context || !context->cap.pointer ||
-	    context->cap.length < 2 * sizeof(32) ||
+	    context->cap.length < 2 * sizeof(u32) ||
 	    guid_parse(context->uuid_str, &guid))
 		return AE_BAD_PARAMETER;
 




