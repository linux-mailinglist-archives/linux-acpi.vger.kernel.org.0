Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B39F423CC0
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 13:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238205AbhJFL01 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 07:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbhJFL0Z (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 07:26:25 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0804C061749;
        Wed,  6 Oct 2021 04:24:32 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k7so7669722wrd.13;
        Wed, 06 Oct 2021 04:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOKM+pEePhem4widkHVhzfPY+xV2PoH5qxuaHku2BGg=;
        b=gcS6KE9H8iBXBNNn+W/+P/9Vkay/h54bHyT9/m0XJ8/YGQoMQgi3PY8mlQgU/5QBb6
         g2xwtiqpEf03XUaIyTuH22SBXKk6+aASROY5Y+irGMsSj6jChgzhHujzJ2l3Hrlw4gCQ
         Itk9mV0jSInr69rZ7gyntFzkUNaGoxatKs1p/IYlk8rl5yGRkEGcsIMzogLWqeeTAyFI
         QQg2j149oQisxJ8jd4iocC5cLCJGSX2RaEWyCWTcj6lKIEfySoUB7ZN0vZZrmW4+J4At
         cb2iXGPqOKtqVTBDsqz8kzCUG/teZCHFl0UMCgqBxh8OLFiIDguJVwWnr1UrWaSRv8rJ
         4rHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jOKM+pEePhem4widkHVhzfPY+xV2PoH5qxuaHku2BGg=;
        b=1ZVLchvSEU+jKVh9N/aOl/C5m2jWFJa+6oyHEteB+eyqlr8ut/yzxYXsse/tVN+dlc
         pARmDPeNgPQCtj1DRGDBUJcxrDEzftbawJhw9y0u75HqSOUnkt9wjmPrrTWWG/6pa8x3
         q0ExJLRFFdjm3ovq6x1BDmgh6pec/jhLREpmkcFQlYIxRL9bAul9bHlPmin6VkV1N4Pi
         kRjYMG6JrXBWbA1UZy3VoL2/Tfosf9+Ycaboo5U0Q1scHT3AoPXZTSbPDsFQnuLeENHh
         Ox4G2YFsqakDB8SUm870+M0ybxEBJGiAKHM7TrvyyKyA6/feSccccdFZILn8nQR0VBR1
         8SSw==
X-Gm-Message-State: AOAM533ApO7Trw5yW0BnR5R3hhNpV3SJoSeVqi+2eTw3pNTsprdVCFTf
        RbVBL2Re3OE4LEJ5N1RnkNbAosui07azVQ==
X-Google-Smtp-Source: ABdhPJxnDvewR58RdmbSh1drMP+qybZoRLHyfs27dsa8+MSEAaZhBo+g9fWUqyviTFE/a6Rf7NfrLg==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr2711180wrd.16.1633519471482;
        Wed, 06 Oct 2021 04:24:31 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id y1sm10030433wrh.89.2021.10.06.04.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:24:31 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: drop unneeded initialization value
Date:   Wed,  6 Oct 2021 13:24:29 +0200
Message-Id: <20211006112429.54809-1-sohaib.amhmd@gmail.com>
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

