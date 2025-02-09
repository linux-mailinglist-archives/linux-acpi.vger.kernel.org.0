Return-Path: <linux-acpi+bounces-10956-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91109A2E120
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Feb 2025 23:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEAD18860C0
	for <lists+linux-acpi@lfdr.de>; Sun,  9 Feb 2025 22:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA93C225384;
	Sun,  9 Feb 2025 22:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aOZBycUq"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0708D1EDA1B
	for <linux-acpi@vger.kernel.org>; Sun,  9 Feb 2025 22:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739138936; cv=none; b=BAcFHvBfWn0OrF58byJenGLo629wYlYw2G6wUXeIcB5zwNUw0zazl3c4S4ZrZqhzNjwgYkOWdOMujqxDkR6iOSCw5S9JD7WebvC6OOyD70vXd8Xafs/Er0FQlIPZ4WZicpIAjjvs4ysHOhDXAn7jyV0S5mGEnyTkM1idVzuSh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739138936; c=relaxed/simple;
	bh=5DOuGnXuaFqcLhfTqbGrEhlr2Wac8X+DomJF6Rsevcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CTbrKjw2qYs2uzwVogdF//5hYjjoPhtbXKlr3uJUr/Ql4OolBYoj2rrClQLSIdZA14PwDMXHZmqlKgqQs91M1Wud/GqSyNSdGrgTqStKZJWjskmFa3qb9SpOZ69Sd8LHCzFW/fbCAL0PsS4I/x5luO4+oZoZUpcQzvYHUDh3PVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aOZBycUq; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739138932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H7sOTGB7YQQ4FwrjrH7kz3zB1WAq4sy6rI1LruA9pJI=;
	b=aOZBycUqBfEC0rSGDO5vF706auIBur5D8nbnQLV9rL8ioKyogGWH2Q4VpiMqf4TnlJKFWG
	KA62vWseCQg8008/9xw2zYPiWZicracqqNneYg81XCK6A0j3iAAhAT6gLF8T+B63tChMk+
	sD2DvZRXrFoliZCskjxkpiCxWxuakTU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: power: Use str_on_off() helper function
Date: Sun,  9 Feb 2025 23:08:35 +0100
Message-ID: <20250209220835.78434-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_on_off() helper function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/acpi/power.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 25174c24d3d7..b7243d7563b1 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -29,6 +29,7 @@
 #include <linux/init.h>
 #include <linux/types.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include <linux/acpi.h>
@@ -197,7 +198,7 @@ static int __get_state(acpi_handle handle, u8 *state)
 	cur_state = sta & ACPI_POWER_RESOURCE_STATE_ON;
 
 	acpi_handle_debug(handle, "Power resource is %s\n",
-			  cur_state ? "on" : "off");
+			  str_on_off(cur_state));
 
 	*state = cur_state;
 	return 0;
@@ -240,7 +241,7 @@ static int acpi_power_get_list_state(struct list_head *list, u8 *state)
 			break;
 	}
 
-	pr_debug("Power resource list is %s\n", cur_state ? "on" : "off");
+	pr_debug("Power resource list is %s\n", str_on_off(cur_state));
 
 	*state = cur_state;
 	return 0;
-- 
2.48.1


