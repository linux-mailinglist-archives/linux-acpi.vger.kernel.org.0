Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3C01156CD
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Dec 2019 18:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFRyW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 6 Dec 2019 12:54:22 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43620 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfLFRyW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Dec 2019 12:54:22 -0500
Received: by mail-pl1-f193.google.com with SMTP id q16so3011844plr.10
        for <linux-acpi@vger.kernel.org>; Fri, 06 Dec 2019 09:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImBNc4qgIrwMkM+rUGDaHKqVHr1dUMeLNQ6cHJK9ITc=;
        b=mnEa9scsD0yZ9KuG2m25kWPF915gHBveN/LvobWfLRm43El/RdiqlPFFWVkqTWWAEU
         lohSksI0zMUhkH6n/LgmLVP1/FwQBd0vKeVLxYWEmL5Wv1a6q8Fgp5SeeCD2NQFLr2Ge
         Rm5rYnDj/YzWHgAVSnmVkddW4yQ1LsCABhkYFn5A69BDGqwrC4JoM3ehQov1bQqtxPG8
         HYMGlI4LpXwS0FcQoyKBMTvwWRHtz5y4VuBtsyTMLPoymBU38grhJTgKkJJmg/GM4rBY
         H3uc/FlnOLvMnR0y2wEYoYr/S8A+5pxk9G+XX5ass9MThFZHqgBI61raJKEk3Bvx0HG6
         8Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ImBNc4qgIrwMkM+rUGDaHKqVHr1dUMeLNQ6cHJK9ITc=;
        b=K5te7reu56vtlvNQC+eG8rNkPyitwNlkkmU8JsCsJgNDlGMaHvY4673O3TG9oUADb0
         HrVjkvSYENTgOIDvle+El/I1zY4eQy7Mp36RWLnx9t98tsa57pp9D9RhXbCtKbrdV4fi
         GU9i532O4aiDnW722bAvRb4IV4N5XOePNyNodIvnq1Cwy8T2P9fwO+Pkh5jBghInomgN
         THLBPLEdKs5t52KgugRzOikWBPL5S8fvCUSDyAv8eB4yMe+fSltZjbR8dZCAdfQBuDpf
         5b9ncLFWMiorAyvEgGXv4G3XWvBeVP0PqQm+tWNM+3OEkMHGqy52NLiNoKLnJeJ1vS2Q
         /MAw==
X-Gm-Message-State: APjAAAXl8kM0D8I61budmRxy1Qac/Rzql4k3dgYk3+1Fq5W9QtK8tH64
        eBU9l8k8uLxu8bwGd9cpcB6ASA==
X-Google-Smtp-Source: APXvYqyPsz0unA2rwxCZ07LA/cUq/kYApAfKk+0M+ZkkMZbAYWyEOc6D3gfVKMiKnp8Zf0rJOh0IiQ==
X-Received: by 2002:a17:902:aa46:: with SMTP id c6mr15231626plr.250.1575654861115;
        Fri, 06 Dec 2019 09:54:21 -0800 (PST)
Received: from omlet.com ([2605:6000:1026:c273::341])
        by smtp.gmail.com with ESMTPSA id d22sm16597000pfn.164.2019.12.06.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 09:54:20 -0800 (PST)
From:   Jason Ekstrand <jason@jlekstrand.net>
Cc:     hdegoede@redhat.com, Jason Ekstrand <jason@jlekstrand.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13 late 2019 lid-switch
Date:   Fri,  6 Dec 2019 11:54:09 -0600
Message-Id: <20191206175409.335568-1-jason@jlekstrand.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Running evemu-record on the lid switch event shows that the lid reports
the first close but then never reports an open.  This causes systemd to
continuously re-suspend the laptop every 30s.  Resetting the _LID to
open fixes the issue.

Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
---

Re-sending due to a typo in my own e-mail address. :(

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

