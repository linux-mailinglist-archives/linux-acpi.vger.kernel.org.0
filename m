Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FAC3146F0
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 04:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhBIDVs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 8 Feb 2021 22:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbhBIDTT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 8 Feb 2021 22:19:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD411C061788;
        Mon,  8 Feb 2021 19:17:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id s15so8941457plr.9;
        Mon, 08 Feb 2021 19:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q2pKfb69pYQFwh9ajJVA3uQ+Q19S3O7/msVoIYMgUoY=;
        b=OjaZUL7dCiVHJsp8mx1pbyQfCktRG/4k5LYp9UBNJGsvxTbKIPIDPAokPS3uDxuftY
         V21oaREQIVebC6DpmKRK60z6LlPvHNapFhh+Qjffjc6+KVnuwojfyzhhi9HoZ/wGEOTy
         Rc5ffR0oZA+VoG7o9qybHilFMm+BoNKb7LYbtmJcEK1vCTGs+zdZGC65Tc1qRo2kmnFD
         A1BomJzr8GHI2cnIEJpRf8ykpSfODHAR9f1DHV6Aa2LJ3dZUrpofqui6nbkJm82+1EmH
         r4GlRZx5J1VmMHNTiLJ3mB16B2Ug0nABMwI2mcBEWJ5mX7DQtp/EP6/MWC1mTkeDiWuR
         mWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q2pKfb69pYQFwh9ajJVA3uQ+Q19S3O7/msVoIYMgUoY=;
        b=r1fKqf7v/GloSPgMKdoNmavUG2oE1M772M6Bckko59mub3Ilcg6tOKCV3Rh37HcH8B
         ZyZERTJf2VG6uRo3qE4SQ2VuBTu5iymwNb+jk/DU5H7dS9EsKaZJ2ZdRGsuuH47qtJI+
         1BJMroGJnR++2CF4fLjXFEQr6v6HNNhbiBC6QDS39H8OY2xsjyx6qp54INUgu3FK1QI7
         U4u9UN3Ov1fHG4a7HPmWcetVtUndRgSDimC6miqUC3L/SN7hkDQLYF4PD9h7JC+vDwyh
         UcT58Yly30iZ70/ZfPrQvjhjInp3xR98FNQmAAhHkb9VojfQfsxMKWipDrHNp5qEntT0
         /1LA==
X-Gm-Message-State: AOAM53209DJ0QqCw3ZWlderU9dFbEbjp/uof+aeE92aqkM8x+LO77taM
        om2cCPYHNp3QrxOvB5wm75FPi4Rwo/DDbw==
X-Google-Smtp-Source: ABdhPJyAUyPu0EF03mfMjijO/VPBNU/9K3YdmhoMdRoAxMqPILsT+aQQ6TRfDdRIVt2+DfIR/UvnMw==
X-Received: by 2002:a17:90a:77c4:: with SMTP id e4mr1868230pjs.185.1612840679283;
        Mon, 08 Feb 2021 19:17:59 -0800 (PST)
Received: from weidongs-air.lan ([50.35.79.151])
        by smtp.gmail.com with ESMTPSA id 9sm10052617pfw.48.2021.02.08.19.17.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Feb 2021 19:17:58 -0800 (PST)
From:   Weidong Cui <weidongcui@gmail.com>
To:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Weidong Cui <weidongcui@gmail.com>, Xinyang Ge <aegiryy@gmail.com>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Enable ACPI_ADR_SPACE_PCI_CONFIG in acpi_gbl_default_address_spaces only when ACPI_PCI_CONFIGURED is defined
Date:   Mon,  8 Feb 2021 19:17:44 -0800
Message-Id: <20210209031744.26474-1-weidongcui@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Signed-off-by: Weidong Cui <weidongcui@gmail.com>
Signed-off-by: Xinyang Ge <aegiryy@gmail.com>
---
 drivers/acpi/acpica/evhandler.c | 2 ++
 include/acpi/acconfig.h         | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 5884eba04..4c25ad433 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -26,7 +26,9 @@ acpi_ev_install_handler(acpi_handle obj_handle,
 u8 acpi_gbl_default_address_spaces[ACPI_NUM_DEFAULT_SPACES] = {
 	ACPI_ADR_SPACE_SYSTEM_MEMORY,
 	ACPI_ADR_SPACE_SYSTEM_IO,
+#ifdef ACPI_PCI_CONFIGURED
 	ACPI_ADR_SPACE_PCI_CONFIG,
+#endif
 	ACPI_ADR_SPACE_DATA_TABLE
 };
 
diff --git a/include/acpi/acconfig.h b/include/acpi/acconfig.h
index a225eff49..790999028 100644
--- a/include/acpi/acconfig.h
+++ b/include/acpi/acconfig.h
@@ -162,7 +162,11 @@
 /* Maximum space_ids for Operation Regions */
 
 #define ACPI_MAX_ADDRESS_SPACE          255
+#ifdef ACPI_PCI_CONFIGURED
 #define ACPI_NUM_DEFAULT_SPACES         4
+#else
+#define ACPI_NUM_DEFAULT_SPACES         3
+#endif
 
 /* Array sizes.  Used for range checking also */
 
-- 
2.24.3 (Apple Git-128)

