Return-Path: <linux-acpi+bounces-12748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D238CA7BBAA
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 13:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD96189C425
	for <lists+linux-acpi@lfdr.de>; Fri,  4 Apr 2025 11:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823A1DE2D6;
	Fri,  4 Apr 2025 11:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvLlnSbP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111AA1DE2CC
	for <linux-acpi@vger.kernel.org>; Fri,  4 Apr 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766607; cv=none; b=n+HWx+swScHd+smMAGBt5Dv9nfS3AHYvu4oRGbWVMYHsxWBNzQlJDXHMRXNjQXT9l37qzpgzizx8BczgbGOy4ujty2Wm9S1bhrGgKIYlH7e25fH5D7ORn482NL2/qYPRw8HPqMVnx688S7TJcvsH04uTwoUgfDTmPukDV1lwQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766607; c=relaxed/simple;
	bh=YVenVswWu/KfCSg2BjOxGhkObMElMTKp4uCcjFmEeIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gr3GFmtn4ZGn64LSDdb/JpNXaQP5tfhtdddvsQ4ET+8Qf2x/FfFSpjkpRyI0YiPjRazc7vAnzz5lxS/TVZR0gYOQCtdHIj0urY46bN93INTJl62LFLBoHBzoFWBNidgKYtGxL84cr0sbjWa2XWJXgzIMUB98zJEiPkdsDkPu5Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvLlnSbP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1A4EC4CEE9;
	Fri,  4 Apr 2025 11:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743766606;
	bh=YVenVswWu/KfCSg2BjOxGhkObMElMTKp4uCcjFmEeIc=;
	h=From:To:Cc:Subject:Date:From;
	b=FvLlnSbPyOAo/6VsKIjiIFVxXiUqM9VTYZh4eessehRAPTERhj6b7IBASfivChS+r
	 1WM+KfRcILwdNLkv4XpLJK+6uumGFuPGc401vyC6OngVRubw7WgjBH96/1dHLFi0Jq
	 HJUItqRQtNT5NQYjpPuZPjbEIOrvkQb6b3wesu3JsQciMuV6byn0YZFtAc1TJ4U88Q
	 s5NVsauHThJQPonTgPl4uhKigWqqGppBvN2zZkQkyN4fgW4/EzK0fXtsP5/SGXdoYI
	 NpWdsU6G7a05p6DALpNuhunUWzZxR0Zz2kvnJW+ucrdhcL1I8JUT80RubA0NzM0ExM
	 0butrA0XZzXnw==
From: Mario Limonciello <superm1@kernel.org>
To: mario.limonciello@amd.com,
	rafael@kernel.org
Cc: Ian Laurie <nixuser@mail.com>,
	Yijun Shen <yijun_shen@dell.com>,
	Richard Gong <richard_gong@amd.com>,
	rafael.j.wysocki@intel.com,
	linux-acpi@vger.kernel.org
Subject: [PATCH] ACPI: button: Only send `KEY_POWER` when suspended
Date: Fri,  4 Apr 2025 06:36:35 -0500
Message-ID: <20250404113636.2390281-1-superm1@kernel.org>
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

Adjust logic so that `ACPI_BUTTON_NOTIFY_WAKE` can not send `KEY_POWER`
unless system is suspended.

Fixes: a7e23ec17feec ("ACPI: button: Install notifier for system events as well")
Reported-by: Ian Laurie <nixuser@mail.com>
Closes: https://lore.kernel.org/linux-acpi/CAJZ5v0hbA6bqxHupTh4NZR-GVSb9M5RL7JSb2yQgvYYJg+z2aQ@mail.gmail.com/T/#md8071e480212201f23e4929607386750d3b6bc13
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2357044
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
Cc: Yijun Shen <yijun_shen@dell.com>
Cc: Richard Gong <richard_gong@amd.com>
---
 drivers/acpi/button.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 90b09840536dd..515224943c3cf 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -444,10 +444,18 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 	struct input_dev *input;
 	int keycode;
 
+	button = acpi_driver_data(device);
+
 	switch (event) {
 	case ACPI_BUTTON_NOTIFY_STATUS:
+		acpi_pm_wakeup_event(&device->dev);
+		if (button->suspended)
+			return;
 		break;
 	case ACPI_BUTTON_NOTIFY_WAKE:
+		acpi_pm_wakeup_event(&device->dev);
+		if (!button->suspended)
+			return;
 		break;
 	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -455,12 +463,6 @@ static void acpi_button_notify(acpi_handle handle, u32 event, void *data)
 		return;
 	}
 
-	acpi_pm_wakeup_event(&device->dev);
-
-	button = acpi_driver_data(device);
-	if (button->suspended)
-		return;
-
 	input = button->input;
 	keycode = test_bit(KEY_SLEEP, input->keybit) ? KEY_SLEEP : KEY_POWER;
 
-- 
2.43.0


