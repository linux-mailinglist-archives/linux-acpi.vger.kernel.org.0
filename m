Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F278446928F
	for <lists+linux-acpi@lfdr.de>; Mon,  6 Dec 2021 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbhLFJib (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 6 Dec 2021 04:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240982AbhLFJht (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Dec 2021 04:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638783260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ra3kQHTCwzQUyLE3rcy1WJPB0zxIUMMyGd0X+9XuSqE=;
        b=Viev5RJPhJtskWyYBCmCPW+bJzPPqmU+lSzmbv95vTvNsKi7A1ztmMKNmdiCat9Va+bWMi
        yC7O78dKdq/F6t/Fl5xkKjoJ/Tgge97Aq+Z5RUn3WKOfro3FvegfJVUNncq5PW4fHAIknV
        vQ4jBAIOLLzLuXaJjH4DCC476rxb0DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-u5xLgrYyPUWsw6FDM4p6mA-1; Mon, 06 Dec 2021 04:34:15 -0500
X-MC-Unique: u5xLgrYyPUWsw6FDM4p6mA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C74710144E0;
        Mon,  6 Dec 2021 09:34:12 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.194.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3F4EF5DAA5;
        Mon,  6 Dec 2021 09:34:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: [PATCH v4 07/20] power: supply: bq25890: Enable charging on boards where we skip reset
Date:   Mon,  6 Dec 2021 10:33:05 +0100
Message-Id: <20211206093318.45214-8-hdegoede@redhat.com>
In-Reply-To: <20211206093318.45214-1-hdegoede@redhat.com>
References: <20211206093318.45214-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On boards where the "linux,skip-reset" boolean property is set we don't
reset the charger; and on some boards where the fw takes care of
initalizition F_CHG_CFG is set to 0 before handing control over to the OS.

Explicitly set F_CHG_CFG to 1 on boards where we don't reset the charger,
so that charging is always enabled on these boards, like it is always
enabled on boards where we do reset the charger.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/bq25890_charger.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index f758e28046e5..d185299db9c3 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -747,6 +747,17 @@ static int bq25890_hw_init(struct bq25890_device *bq)
 			dev_dbg(bq->dev, "Reset failed %d\n", ret);
 			return ret;
 		}
+	} else {
+		/*
+		 * Ensure charging is enabled, on some boards where the fw
+		 * takes care of initalizition F_CHG_CFG is set to 0 before
+		 * handing control over to the OS.
+		 */
+		ret = bq25890_field_write(bq, F_CHG_CFG, 1);
+		if (ret < 0) {
+			dev_dbg(bq->dev, "Enabling charging failed %d\n", ret);
+			return ret;
+		}
 	}
 
 	/* disable watchdog */
-- 
2.33.1

