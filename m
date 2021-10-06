Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A99F423CE7
	for <lists+linux-acpi@lfdr.de>; Wed,  6 Oct 2021 13:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238106AbhJFLjo (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 6 Oct 2021 07:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbhJFLjn (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Oct 2021 07:39:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86443C061749;
        Wed,  6 Oct 2021 04:37:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id e12so7898593wra.4;
        Wed, 06 Oct 2021 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhCrSBwQcUGPmOoHV4cQHMNe4P44vuUP3RyY/XmjhVs=;
        b=GsxCTD2zleFZfp6Je+QcFI56LHwOmRKojfSkhORIckOop2tuo6J++lylQByHfdUT7j
         KRzeZD6M73B8Bl0DIX0Gb1T71wsKHFUez9CZCrUl7erwucoqPC7tB/b7QgY6mNz4NlTK
         4jvBbgO1gK2gVw4b+inrVHBEBWtlo9MnIs7EmmMAIACrh7tpdB9bgIGlt77alXa8RYzd
         WsmFPbJ07zZtKjaItSmSDyQWWgetkUbErTLege2Ct8XZzhm5EyUw2PVrCBknvEjoudCh
         bjqjI4Cpvj6nwxpJyXdv57uSzSdSMAWyXp2e68tUnxHYaqPO8gFQdYZzYasAXcXZk846
         aQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhCrSBwQcUGPmOoHV4cQHMNe4P44vuUP3RyY/XmjhVs=;
        b=lmAPe7zlaAdUjKWR+tzFsKl5Sl9ejsNggvRtnAuXBHTzgwvXWCi7nmcMDVHy1NULyC
         WWC1uw1V/OjXKBDoFQ0McckCPkNZtSIw/O6qQAtWL15D8vTNGaf/34P14VImdHE0o72f
         KrOlaSYkykAxsmdgJswFSXqv13fwDYv4+QlYY/IFvkta5a+/IquKqcKKBVEVXGaEEqYM
         ZLK4c43+sPovITF120e4NDJa/AeJYE4JFWigvnO4Ds5AcbRN9WG1AhCuJ7pz/tWi4Eyb
         M3fQ/TaUUVzwVr/D2aIZlWuR9ERD8VO5qCMefn9jJ2K831laTcMTU21v9MVBJRjbnHOC
         rciQ==
X-Gm-Message-State: AOAM532rU4xEGQ4jGok3oa9wiuaTmt4RtCip9NNwaQAS3cSObYiG9kqA
        v+FXiTowm0ms5PU4hmyUsEI=
X-Google-Smtp-Source: ABdhPJyvE+PxDHuqpJW1+88/DOYgkCOORLNiPimKKHqW4mMqn4ql+qeDVDEPm3fx3Y4qpIVg7BUAFw==
X-Received: by 2002:adf:bb81:: with SMTP id q1mr17252993wrg.119.1633520270108;
        Wed, 06 Oct 2021 04:37:50 -0700 (PDT)
Received: from localhost.localdomain ([197.49.35.129])
        by smtp.gmail.com with ESMTPSA id b15sm24479679wru.9.2021.10.06.04.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 04:37:47 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        devel@acpica.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPICA: drop unneeded initialization value
Date:   Wed,  6 Oct 2021 13:37:45 +0200
Message-Id: <20211006113745.60186-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Do not initialise statics to 0

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/acpi/acpica/dbhistry.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpica/dbhistry.c b/drivers/acpi/acpica/dbhistry.c
index fd813c5d3952..60b77b11c0f2 100644
--- a/drivers/acpi/acpica/dbhistry.c
+++ b/drivers/acpi/acpica/dbhistry.c
@@ -24,9 +24,9 @@ typedef struct history_info {
 } HISTORY_INFO;
 
 static HISTORY_INFO acpi_gbl_history_buffer[HISTORY_SIZE];
-static u16 acpi_gbl_lo_history = 0;
-static u16 acpi_gbl_num_history = 0;
-static u16 acpi_gbl_next_history_index = 0;
+static u16 acpi_gbl_lo_history;
+static u16 acpi_gbl_num_history;
+static u16 acpi_gbl_next_history_index;
 
 /*******************************************************************************
  *
-- 
2.25.1

