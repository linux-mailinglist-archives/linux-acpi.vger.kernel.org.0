Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B17212EADA
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Jan 2020 21:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbgABU2K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 2 Jan 2020 15:28:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44686 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABU2K (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jan 2020 15:28:10 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so22408699pgl.11
        for <linux-acpi@vger.kernel.org>; Thu, 02 Jan 2020 12:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nvVcmlkNvZgR9NC4iyrVMsbtfW9B3x2SucU6Uz6N6dM=;
        b=ieYvsLZTf7YkKr6c4cvY+IElAxPeGge7dnnP+bwh/iMn6BtOVR7aIJNdxoCKVxaFdJ
         7PvFnTwhxrtHG64aPN1bqjhLzG68bcI+yRFMBu8/6ka/zqvTma3772sSbcwk8r924DQP
         TDLRRiQUdO69Jfit1wcYpMTo9/SNVvVJaLn+ORvjNIPi5qeCg9UVo7Yb1QSHKyIGl+us
         q+g7w2V8/dLLTAxLriA3k6OE6m6Pu0oYT/57AtZKWSuvzOtqfmq9KtyDXrrNvR+OnW+I
         Fax5efFrKw++B3oYhU/d8UxHCnA64KMu2D7t0wSFf+omFY5q7Z4q3L7zanx+wzW9TJFs
         FTNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nvVcmlkNvZgR9NC4iyrVMsbtfW9B3x2SucU6Uz6N6dM=;
        b=O5KbpVwYQkxiqIP8De9/RmkplMpTG5UHoOb3sy7C0BSYKaoXmlTJqBsl21qF59eY2V
         XkjzcSuNQtJ29/mNblUhhgd/bPwVEyJ/wm3l7YkcDj/gViexRqcuKtRApb2Ur2W+jrA9
         zKZbqF/anB4RhVu6/AVGV4jYe7MIlt3EIviVa1KsGFZYPgY/qpBoVyfnPQxMP52SLHhN
         /BXoHYwtKAiQ2S7nZ70tHiS+op/RRHnDHLeFtLwyP22zEtPDoCnbqgNmiLORyivnqJTC
         o0tb9MH+Tsfj16a/3tOpWQw6bDs9L8DPqY1JDNotuvAqNGj97GC/rIJp/S5mdJQFbvqg
         +4DA==
X-Gm-Message-State: APjAAAUes0v27TwaSdI4yBflGxuK9yxoF9iu0ufysYAvfkK+0VbYy9yp
        ox8pb6ZdKxH4WBcD4HLNHNEfRw==
X-Google-Smtp-Source: APXvYqznFxGPwMkXy87HNZv7iDkAzGbHD4tMeRUXQK5vRUyZlykzLCZCHmSReIIleZIkLpctSAn8YA==
X-Received: by 2002:a63:454a:: with SMTP id u10mr92912183pgk.248.1577996889938;
        Thu, 02 Jan 2020 12:28:09 -0800 (PST)
Received: from omlet.an.intel.com ([192.55.54.42])
        by smtp.gmail.com with ESMTPSA id n188sm61206681pga.84.2020.01.02.12.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2020 12:28:09 -0800 (PST)
From:   Jason Ekstrand <jason@jlekstrand.net>
Cc:     hdegoede@redhat.com, Jason Ekstrand <jason@jlekstrand.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: button: Add a DMI quirk for Razer Blade Stealth 13 late 2019 lid-switch
Date:   Thu,  2 Jan 2020 14:27:54 -0600
Message-Id: <20200102202754.24028-1-jason@jlekstrand.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206175409.335568-1-jason@jlekstrand.net>
References: <20191206175409.335568-1-jason@jlekstrand.net>
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

v2: Updated the comment to better describe the behavior of ACPI

Signed-off-by: Jason Ekstrand <jason@jlekstrand.net>
---
 drivers/acpi/button.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index 662e07afe9a1..ef5d473e7992 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -122,6 +122,17 @@ static const struct dmi_system_id dmi_lid_quirks[] = {
 		},
 		.driver_data = (void *)(long)ACPI_BUTTON_LID_INIT_OPEN,
 	},
+	{
+		/*
+		 * Razer Blade Stealth 13 late 2019, notification of the LID device
+		 * only happens on close, not on open and _LID always returns closed.
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

