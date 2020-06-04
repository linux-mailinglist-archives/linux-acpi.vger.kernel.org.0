Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78AC1EEB68
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jun 2020 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbgFDT52 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 4 Jun 2020 15:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgFDT51 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2020 15:57:27 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679CC08C5C0
        for <linux-acpi@vger.kernel.org>; Thu,  4 Jun 2020 12:57:27 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x22so3769997pfn.3
        for <linux-acpi@vger.kernel.org>; Thu, 04 Jun 2020 12:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17b2aaxx9AWik+/H6nkchZPzWER/WcSta2U6qBhKjfI=;
        b=UJqmJXRMu1MCMIknBTQnQbAcYFvoypy/3vBe+OATtsjD/2iSOyg5q2yQ/edgeCLPSd
         bn8wZpbzUnj4rYWdkqMW5g9R2NMAPbfWz9eCOAazkyIzP83AmLPbYiaOpAM/Y8hfr9l0
         zPslHOc7sqHKhoejCEYWz1TIpXbjQlC7UPrO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17b2aaxx9AWik+/H6nkchZPzWER/WcSta2U6qBhKjfI=;
        b=G26c5tWNtnJSy3bV0D/wO378xl5rKeEWS9f3b8NwYQ70w5HmemSakKOVFV4jYEqua6
         0NcG2NCFbnF+gKOaSHeOcrjSs2UFHlc1VFIkJiVioRzV+qrooFC9A6oi94f5i9cb4c+X
         +avB1PCOXSXVr4ituGh0XKSoZ9JK0q2i7/yhil7V88aEJ5vWAdGaH4ZDpNlrxV1XgdDc
         4JQy5fhcqBaRCiDimHYLrldNUuQEBYAoG82B3RlQvKYEhv5NelI/c4nr8dkY8LTV8oVg
         MdnsGvmK5l64mfOp9ZmjlboFiB1J/Vm1xeIaxWnZEP/2gN5SsgPI0eqz/DI2n1+l5KsQ
         a7mA==
X-Gm-Message-State: AOAM53363A61C9iC6Y20AiqXgQwtfxLYQ2udDvGSHbzcwiqraFGqIzTe
        WcVvszJs6nlK6GwhuudzIM2rSg==
X-Google-Smtp-Source: ABdhPJwN5n5f0TKfN423aURRb4ZD2T087OtrXyelKJTyJ/6QqMLlLTeoMVmKyvSJ1+0DhyBpwVEeEg==
X-Received: by 2002:aa7:9d01:: with SMTP id k1mr6059050pfp.6.1591300647119;
        Thu, 04 Jun 2020 12:57:27 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id p19sm5324130pff.116.2020.06.04.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 12:57:26 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: battery: Always read fresh battery state on update
Date:   Thu,  4 Jun 2020 13:56:58 -0600
Message-Id: <20200604195658.66201-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When the ACPI battery receives a notification event it should always
read the battery state fresh from the ACPI device and not use the cached
state. Currently the cached state stays valid and the new state may not
be read when a notification occurs. This can lead to a udev event
showing that the battery has changed but the sysfs state will still have
the cached state values. This change invalidates the update time forcing
the state to be updated before notifying the power_supply subsystem of
the change.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/acpi/battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 366c389175d8..ab7fa4879fbe 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -981,6 +981,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		acpi_battery_init_alarm(battery);
 	}
 
+	battery->update_time = 0;
 	result = acpi_battery_get_state(battery);
 	if (result)
 		return result;
-- 
2.27.0.rc2.251.g90737beb825-goog

