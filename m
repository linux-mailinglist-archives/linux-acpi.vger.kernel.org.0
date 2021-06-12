Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2783A5120
	for <lists+linux-acpi@lfdr.de>; Sun, 13 Jun 2021 00:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFLWjO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Jun 2021 18:39:14 -0400
Received: from mail-il1-f169.google.com ([209.85.166.169]:34718 "EHLO
        mail-il1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLWjN (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jun 2021 18:39:13 -0400
Received: by mail-il1-f169.google.com with SMTP id w14so8821968ilv.1
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 15:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxVBWyRUpBh0zEhPPp6kTbGLbxSZSNOFyjmCx1JSTiM=;
        b=XPYWmJvr4FQYNjNM/p5JT6DGYvKeX9IOIw857yF8lrdde8L+Aw1g35B3X0wk/o8u60
         S+XHC9V4WwKsNz5j+t2+oo0Az20KgbJdTLMoTu3iAB+witiVJpDvcOXLayzF4Kp2irke
         QHrhvOCyNLNaXPW5J5uXUpb0YbX0659S+ihRUlpag47wtlfDrDRxVj+nmmr+4XORLxOX
         OEaJ+iaTwkLvsYWd67VLA+ldcpKFGad4jLAsVeDoATmRs8g7ZzOGeBj5MZOHkJqNbLP+
         iaOGHOmcWGQat1z3UFC14AhvYYRqIPwobX1K9KsFTqNT4OCI6jc/KUQamwl7GufMVAAP
         agwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SxVBWyRUpBh0zEhPPp6kTbGLbxSZSNOFyjmCx1JSTiM=;
        b=TaH57/9roRj9dJ8Q1tojPyVNd8O4Ot1PisV27s1DQhahUWV4PnW1WeWL0b2Tr/yYKX
         9NdPxvhHPX1+1n+1RTaUOMHoZl6NbnBSVwuuS7h33gjsyBCLUGhXLU1clwH8TNOlWNLi
         +Bn+tGNfQwDRGYNbAya5xbsTbLwRdz7LanUQu0LBbdrVD2GWxCMSZbB9ZO+HtbrHw/43
         rtzadGRzN2b72sO0Oc5vTttyi1aowxtYRTGdmGPN9aBxZ2VQeTOqMAO8uN11FXkWzY+n
         UfdFm34M3+ODNNDIRaSrOTxug9UyY0j3cXnUD0YLmOXfuhl55bQFFcgefGfBUUWIVnl5
         sleA==
X-Gm-Message-State: AOAM533kTdsTassRlI2Eo0C64fe2NX+XKloH1eDaKtxt04HIeNShGLs9
        7YjMyjcmkqla4voRkh24Ryo=
X-Google-Smtp-Source: ABdhPJyVdwocuHs9AxHKI9SMhWfJF78kFel524znp4I62C4IoJvTroU1v9ldHHybq/Bc6bhcZtpn5A==
X-Received: by 2002:a92:2802:: with SMTP id l2mr8011560ilf.298.1623537358471;
        Sat, 12 Jun 2021 15:35:58 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id g11sm5251814ilc.71.2021.06.12.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 15:35:58 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     rjw@rjwysocki.net
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] acpi: sysfs: Fixed a control flow style issue
Date:   Sat, 12 Jun 2021 16:34:02 -0600
Message-Id: <20210612223401.9273-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixed coding style issue.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/sysfs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index d6626aba4a6a..0e685ca8f78f 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -254,15 +254,15 @@ static int param_get_trace_state(char *buffer, const struct kernel_param *kp)
 {
 	if (!(acpi_gbl_trace_flags & ACPI_TRACE_ENABLED))
 		return sprintf(buffer, "disable\n");
-	else {
-		if (acpi_gbl_trace_method_name) {
-			if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
-				return sprintf(buffer, "method-once\n");
-			else
-				return sprintf(buffer, "method\n");
-		} else
-			return sprintf(buffer, "enable\n");
-	}
+
+	if (acpi_gbl_trace_method_name) {
+		if (acpi_gbl_trace_flags & ACPI_TRACE_ONESHOT)
+			return sprintf(buffer, "method-once\n");
+		else
+			return sprintf(buffer, "method\n");
+	} else
+		return sprintf(buffer, "enable\n");
+
 	return 0;
 }
 
-- 
2.31.1

