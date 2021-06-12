Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58C73A5067
	for <lists+linux-acpi@lfdr.de>; Sat, 12 Jun 2021 21:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhFLTnH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 12 Jun 2021 15:43:07 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:45934 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhFLTnG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jun 2021 15:43:06 -0400
Received: by mail-ot1-f44.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso6677061oto.12
        for <linux-acpi@vger.kernel.org>; Sat, 12 Jun 2021 12:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPRqkHUi5RoPwMu6FzSt6nJ375HmNoxfcA4FZNsYiU0=;
        b=oVji3pLtrqN1fLE0AbsW4WapuCGQlxKTQrTJgtDfkJhPIjT0Qx0F0cGqAEqbNOqWho
         UUneWWLwSSFRLxChXLG/ZRB88T2Kr+NyY1bi/+lljunZ6MicYor7KDu5OD+NtPp2e0cM
         ajg0pvUYKnb9Qfaja36tTLUt/FOl4FsZtt2a475uTzq40zrwZbJU0EDrrEQnyKCYq0jq
         hD77FnwlN0SOlcUKAG92DLg1Zai+9/NuC58TvTXM8TCZPlQ2Y9VcDCUAHgmlSR5tIym9
         nQgOq7oZM837MwdN3rQf14g0QjVZmupFBMbuEuJetXtARY1V2en2tIDdkoMaShQH5QlH
         l0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QPRqkHUi5RoPwMu6FzSt6nJ375HmNoxfcA4FZNsYiU0=;
        b=GcFjm0F+oT+GeEaUCqRsx0US82qBfk+F/nQ7xlh+uGv8z0IkspALp5rGA+8cWdk1rs
         TJnpmQL8K/zFyGvtOGd68vzlJnJwtKRmQLevsJif4TztVLh0K2b650+NSsV3TxFqoZLf
         OfunSQTD60UE8MBX1Lcmz9B1dsU/wFCEMEffPXuss4buq616VxojxwaX/5Y2JsEOEEWk
         zWJUL3zCzsbt2B0D3jSAX3cR3Zon8chZzgAGxCYHz00FZ9gKBPgNiMIu37bNjlE/Vtdl
         MQ6lW/XliICM1iGYtFWQ1ezovfq2rEeGO6zZ1h45HGLiHBywCh/Jos/XVECYA/9K0ay3
         scmg==
X-Gm-Message-State: AOAM532WPkq0lWkU7R1RcI08TYYIscGaiqMreVppafbx72jVLFugimo0
        X+OvB6VpLkj/4N0E5AbMkIXw3+Db9uf9xA==
X-Google-Smtp-Source: ABdhPJzLuY2Skt6AEGdwuTwMvySW9a8A72qi1L5ixfe6R004LWGJHv4QzYhmvmsekqKFumlL7YH3dA==
X-Received: by 2002:a9d:6484:: with SMTP id g4mr7780936otl.331.1623526791357;
        Sat, 12 Jun 2021 12:39:51 -0700 (PDT)
Received: from fedora.. ([2601:283:4400:c0:96c1:9c48:12a7:2c7c])
        by smtp.gmail.com with ESMTPSA id x9sm1951421oig.18.2021.06.12.12.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jun 2021 12:39:50 -0700 (PDT)
From:   Clayton Casciato <majortomtosourcecontrol@gmail.com>
To:     rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        Clayton Casciato <majortomtosourcecontrol@gmail.com>
Subject: [PATCH] acpi: acpi_video: Fixed void function style code issues
Date:   Sat, 12 Jun 2021 13:38:01 -0600
Message-Id: <20210612193800.1011328-1-majortomtosourcecontrol@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Fixed coding style issues.

Signed-off-by: Clayton Casciato <majortomtosourcecontrol@gmail.com>
---
 drivers/acpi/acpi_video.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index 0c884020f74b..ffb4afc5aad9 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -1619,8 +1619,6 @@ static void acpi_video_bus_notify(struct acpi_device *device, u32 event)
 		input_report_key(input, keycode, 0);
 		input_sync(input);
 	}
-
-	return;
 }
 
 static void brightness_switch_event(struct acpi_video_device *video_device,
@@ -1690,8 +1688,6 @@ static void acpi_video_device_notify(acpi_handle handle, u32 event, void *data)
 		input_report_key(input, keycode, 0);
 		input_sync(input);
 	}
-
-	return;
 }
 
 static int acpi_video_resume(struct notifier_block *nb,
@@ -2308,8 +2304,6 @@ static void __exit acpi_video_exit(void)
 {
 	acpi_video_detect_exit();
 	acpi_video_unregister();
-
-	return;
 }
 
 module_init(acpi_video_init);
-- 
2.31.1

