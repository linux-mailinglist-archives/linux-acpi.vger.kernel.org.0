Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851F1423C8F
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 13:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238326AbhJFLYY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 07:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238305AbhJFLYW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 07:24:22 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13933C06174E;
        Wed,  6 Oct 2021 04:22:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m22so7848951wrb.0;
        Wed, 06 Oct 2021 04:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOKM+pEePhem4widkHVhzfPY+xV2PoH5qxuaHku2BGg=;
        b=jovSS3roUqUucRZmK4Hysv7OycrN+80n0uARBvijogTnlkb1Ogk9DSW8vtukwQHUQb
         Xu+bnYFNwfFBVT9nBFln+651Vkpy3+zcSxIhvuVyWpV2MweHnjhqrmeYuc86waRdCCUR
         IfmxVmHIElJAPTXuPHgkMJOg8k98uZykFLrKbQEwke48Xg4rEquuw7oX63f6CLW+AnFR
         6OwxMPNKhsOrWz3ybgogqAcvS1SFhx6usomHWIWc87ujBcoEpReRn0Rlvo2GATmPNzm6
         QgIsgYxwcgUpZbMG9nR1huR2BxKjTX8gcOfz+xmlKqByl1qomFKcWBzih0lQnaD551kU
         hp8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOKM+pEePhem4widkHVhzfPY+xV2PoH5qxuaHku2BGg=;
        b=nF2V751+Ok1ZTCrde1cnl0NAozRLA7bU5G51LWF/ZeAZRTHRQIhllITgOPcEpuUCX3
         MghzybJI0chKJrDPMFZ241r1qc9CwqFlkWLjIy7R6GBi4dgjwRgTwsQwEBOuVJILkssY
         z6bkr7ZlpnFwuzm5Gpa6jHYcGmrbg+GIMfvA+wbySfvvRjhWkPjuqgD5WNAQDNTZ2UQl
         Lw4qY+OjMX7vmK3xVga5guBsFQF/lNnt/2cYpL3o4IgdcMqu8aTtFSMMGj2TxRF4AR4Z
         +0ta3Czmi8NA67pCUSNynX+6jK4kekd4T5PZBnMu/WHdwBx/26IbjiGuc6DU27nx8HwX
         /eJw==
X-Gm-Message-State: AOAM5318DXPAVwmMNx6Wbh48inxEvOQf//GlJKyuS9MOONj77GE3sPfL
        QOXvUZyuBQ7KEcbFSa2MrF8=
X-Google-Smtp-Source: ABdhPJzqV6pbGRmNxh/6nIl4JB5xH/x4SzqV8vrsv1ncVkzVo4Qnxlyygi4G2S1Zth4R6K2a/KnUSA==
X-Received: by 2002:a1c:a508:: with SMTP id o8mr9180075wme.29.1633519348664;
        Wed, 06 Oct 2021 04:22:28 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id o15sm4807105wmc.21.2021.10.06.04.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:22:28 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: drop unneeded initialization value
Date:   Wed,  6 Oct 2021 13:20:04 +0200
Message-Id: <20211006112004.52643-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Do not initialise statics to NULL

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/acpi/acpica/dbcmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpica/dbcmds.c b/drivers/acpi/acpica/dbcmds.c
index 9eb68e0751c7..d0e3b874ca0e 100644
--- a/drivers/acpi/acpica/dbcmds.c
+++ b/drivers/acpi/acpica/dbcmds.c
@@ -35,7 +35,7 @@ acpi_db_device_resources(acpi_handle obj_handle,
 
 static void acpi_db_do_one_sleep_state(u8 sleep_state);
 
-static char *acpi_db_trace_method_name = NULL;
+static char *acpi_db_trace_method_name;
 
 /*******************************************************************************
  *
-- 
2.25.1

