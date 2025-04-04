Return-Path: <linux-acpi+bounces-12758-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90CA7BFE9
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 16:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36A6E1884707
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 14:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED51F3D30;
	Fri,  4 Apr 2025 14:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCswyAlQ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE881B043E
	for <linux-acpi@vger.kernel.org>; Fri,  4 Apr 2025 14:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743778246; cv=none; b=dKRUMCoji8NyAY3YgphxTT2jb7756FnlYLHgtvOLQqKb/L9o6f8FGHAyIBaPlgj7S3VcszGnN00640AHlL4L3BgGWliYcmL6rNPxRtmzK5SR6UWVVQNm1bRpdTs1G4Iq0esi5WrxJbcyoA/wvGoqlbYoQRC/NcUca2QWdxGRriU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743778246; c=relaxed/simple;
	bh=u/ycyXAJOZQcYh1Gav1mTbxhGhcXUL8emGLvjt85Zks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRYMEPKShzfIJKWPpcVdNq5WkcYqBN/U4us5PfaUsa/x34SEpNXRfumat7FZHBok3e0LWs5QodOpjS6EeuAqpTjYoN3nOilIaLav030MXelUPbrkge96RPYncRFFHOD53110W6sHrAaAzPlbIMc6lb9l11mO/yCkYGztfVfrT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCswyAlQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE70C4CEDD;
	Fri,  4 Apr 2025 14:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743778243;
	bh=u/ycyXAJOZQcYh1Gav1mTbxhGhcXUL8emGLvjt85Zks=;
	h=From:To:Cc:Subject:Date:From;
	b=fCswyAlQTTae1GcwCWogeyb/wnicjTIZ4JVp8pqvYr7R4GjBFYuZKw/MgFWqT8bc/
	 B6GKx7anwG0E752YtF1fRhGtMIz3urxR9N+nxGUicUulF7hAPFsXpVzWYTtx+awy3N
	 y3uW7eSHcwjmtXOXdmS/PE90MgP+LHEMhctta+KztV9/S9SmhMyAZsr/5hX7fetaG2
	 Qy0LuIlVcG5ijoerP50/gJlj1qlEinMjEgj/RA97v73rMC23tJ+8EDPmegjgRgoVWS
	 acQXozspZKYNqcXMWwP9XE+Y22q+5hEHW5gym/2YKOn0VPV7+6RngHdaCELWbfWPqk
	 LBtEwPhOi/MRQ==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: Ian Laurie <nixuser@mail.com>,
	Yijun Shen <yijun_shen@dell.com>,
	Richard Gong <richard.gong@amd.com>,
	rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2] ACPI: button: Only send `KEY_POWER` for `ACPI_BUTTON_NOTIFY_STATUS`
Date: Fri,  4 Apr 2025 09:50:22 -0500
Message-ID: <20250404145034.2608574-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

commit a7e23ec17feec ("ACPI: button: Install notifier for system events
as well") modified the ACPI button behavior to send
`ACPI_BUTTON_NOTIFY_WAKE` events.  This caused a regression on a
"Dell Optiplex 3040" sending `KEY_POWER` randomly at runtime.

Adjust logic so that the event `ACPI_BUTTON_NOTIFY_WAKE` will never
send `KEY_POWER`.

Fixes: a7e23ec17feec ("ACPI: button: Install notifier for system events as well")
Reported-by: Ian Laurie <nixuser@mail.com>
Closes: https://lore.kernel.org/linux-acpi/CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com/T/#md8071e480212201f23e4929607386750d3b6bc13
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2357044
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Yijun Shen <yijun_shen@dell.com>
Cc: Richard Gong <richard.gong@amd.com>

v2:
 * Handle logic change for avoiding KEY_POWER all the time
---
 drivers/acpi/button.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 90b09840536dd..0a70260401882 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -458,7 +458,7 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	acpi_pm_wakeup_event(&device->dev);
 
 	button = acpi_driver_data(device);
-	if (button->suspended)
+	if (button->suspended || event == ACPI_BUTTON_NOTIFY_WAKE)
 		return;
 
 	input = button->input;
-- 
2.43.0


