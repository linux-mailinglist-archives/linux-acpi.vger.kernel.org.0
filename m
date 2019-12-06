Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10231156B7
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 18:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFRro (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 12:47:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfLFRro (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 12:47:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id y14so3677884pfm.13
        for <linux-acpi@vger.kernel.org>; Fri, 06 Dec 2019 09:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czGuC5S25a2G8ezz9SsBlbfDryX7Jz6D2cmI55S4+G4=;
        b=kPcOwhhGLvFANSXb6YNYRvACF/JRB+aZkta+k4aeqdH99etwectI3DjL9Y+zcfYmC9
         lJQmWYkDXpuwlVJRUiSH/gP6GCdbD3iGwb2ifvd0oWD0wUch34QLneobnPzTfTaUIp8F
         4DtdkTKvoeHx0vM6QsESpPE4eeKTn8wezc3s7C6dFZMC8fh1tJMHvaX8Aa1mMm2nx5YM
         SYPpOBWIJoy+vHZjYirYdink6+cEHUpUuNusA3gZAdln84V+xVnuvGCnMLOG7qMddifF
         FH7D3ErNWnt14Nm2Pw0aJFq1UZ4IMPV2l8bsAx0ZNJoP3Dq/3uzyfVnln5Cg3q95wCB4
         Zrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=czGuC5S25a2G8ezz9SsBlbfDryX7Jz6D2cmI55S4+G4=;
        b=kO9PdBsxM9PYhX8HBFT2NZHSl/TPBUDBPGnAP36RTU87ZugagKRyKrrtnDUWJ1PQ5B
         DJVlj7vgk9Jbs/wr5q9PpHchVqTLHiVbhRg/0vD9T/NvINF6YaQyUFTau2IxNKpyGTuh
         qsq3tmB9FLpcHOP0BrMTJDyimNY+5mMcPqAhmtNTaweRc/coLE20j6hgjcmM4umb2qxA
         HXSlQsPDlMgZOQK4qehRHqk5ZfO0ae9CwGunbty1+xrFB0NAs3RhdODO3BM6t968Zy3r
         vWt6MzWmElUI/XrmZxOEwzfE8gRnJuPUvmR4+MB/XSTvhYXdeO4K349MoPZ7dZ0c2Wie
         /ACA==
X-Gm-Message-State: APjAAAUkfWWHlzCUUJwYhyhXWM/UglT4zzZGJjgDnoCtoQdmPMa4fgVC
        P0d3uXqhQZ5X50VI/AM1RQ8eCQ==
X-Google-Smtp-Source: APXvYqzGQg0k/mZ+iZfUmy3rSiaqnmLz55In4Ous8WyxJ0R8wRtdFF2G8kckdzzm2mh+DK417y4+aw==
X-Received: by 2002:aa7:8284:: with SMTP id s4mr15960822pfm.83.1575654463100;
        Fri, 06 Dec 2019 09:47:43 -0800 (PST)
Received: from omlet.com ([2605:6000:1026:c273::341])
        by smtp.gmail.com with ESMTPSA id b21sm18131018pfp.0.2019.12.06.09.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:47:42 -0800 (PST)
From:   Jason Ekstrand <jason@jlekstrand.net>
Cc:     hdegoede@redhat.com, Jason Ekstrand <jason@jekstrand.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13 late 2019 lid-switch
Date:   Fri,  6 Dec 2019 11:47:23 -0600
Message-Id: <20191206174723.335338-1-jason@jlekstrand.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Jason Ekstrand <jason@jekstrand.net>

Running evemu-record on the lid switch event shows that the lid reports
the first close but then never reports an open.  This causes systemd to
continuously re-suspend the laptop every 30s.  Resetting the _LID to
open fixes the issue.

Signed-off-by: Jason Ekstrand <jason@jekstrand.net>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 662e07afe9a1..f7ca94e41c48 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Razer Blade Stealth 13 late 2019, _LID reports the first
+		 * close but never resets to open.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Razer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Razer Blade Stealth 13 Late 2019"),
+		},
+		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
+	},
 	{}
 };
 
-- 
2.23.0

