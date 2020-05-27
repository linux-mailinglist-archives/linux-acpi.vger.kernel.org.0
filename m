Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9DA1E516B
	for <lists+linux-acpi@lfdr.de>; Thu, 28 May 2020 00:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgE0WpT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 18:45:19 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:49812 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0WpT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 18:45:19 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 May 2020 18:45:18 EDT
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49XQf73Kxlz9vJbx
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 22:35:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o9wSVrZfW8tQ for <linux-acpi@vger.kernel.org>;
        Wed, 27 May 2020 17:35:59 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49XQf71g2Hz9vJb5
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 17:35:59 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49XQf71g2Hz9vJb5
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49XQf71g2Hz9vJb5
Received: by mail-il1-f200.google.com with SMTP id q2so21722228ild.6
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 15:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CpatvuW2oCiIL+IhriroImU7P7m/r0JsGdlS3UL0xRI=;
        b=epsKr2KQQFASD91Q+FKeGYrbfnjMtu941ofPh58h1X3OFGvYwWvkA8DYxpICLP5JxL
         igEof6dlVtyaEa7orVWfb0MHPf/bxadZ22yUFUi+7ueMlwvZa6uPRuW3DfRCwN3RgH2K
         wi7mABV9A6aAXxxxN1tRUmwCBqxr4JXYffQ4XxwGwYRUXg45eLV5q55+tH0lMb6VVnE/
         DDB3+SRCOfbmNyoWTy5LganvRCPg/iL97DftKHHR4Omxt/KHF4sduSDTBcbEz5TOYAWq
         9JhrmkckVvHLMp72Xz3tBMfPH94dUU5G5TOoEBPvM7sHIHQvjFZlEpU74xwRkwiJ6mXX
         Tmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CpatvuW2oCiIL+IhriroImU7P7m/r0JsGdlS3UL0xRI=;
        b=YL5IO9xnYk0PjMsivBD9l2zS48dL7S60w4P3+8fmqsR21bfl6HdED4Ym0uTdWHDmpL
         C/EBgymukvH757oCsVKsM8vOGayDysmIEFs33e3T01X7VQVmACllITMVQCRu7yB5Qzii
         pDk8xr3fF7t/7JWUPi1sNzy29O1KtCAo+EAH9m+H7QDr9LkcRk2ZnZodGc6QVVxsfb8r
         zMxBxRXIzhsxUKX6DX8qMPnKrmwE35Fon/WLkoujN0KC9Z/t+wIsBGXGxHxzt3iHaXQ8
         B7/o+LJL9bqLoHfiRVlQX8dW3ni41AMn9lRwlvJrZnFCvEMQHOuPxbyxeyYwgsRCpO4h
         d8ZA==
X-Gm-Message-State: AOAM533hr3LtD7SVXmOrTl2NDPPuDHIYB5QrDqp/+8PoZQU/D+y74Niu
        RGUkS82tdyyQwJ4Tqi+33bKjoQrbtRMr0BbLgvxHWmW2nFI1dFnR/OJK2oC2YfEPwIbv4mV9+Gh
        s+0OUWyAZoPZWzjNQ9ZYZjUJKtw==
X-Received: by 2002:a05:6e02:e8c:: with SMTP id t12mr483783ilj.186.1590618958817;
        Wed, 27 May 2020 15:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJywrYsi6lG1iitaeUz/omV2z7LDZxc73HSoMA4aAWYo8kzkH8F8jJi7zhm/0M8Fqsku4JWGqw==
X-Received: by 2002:a05:6e02:e8c:: with SMTP id t12mr483768ilj.186.1590618958532;
        Wed, 27 May 2020 15:35:58 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id o70sm2368169ild.3.2020.05.27.15.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:35:57 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Prashanth Prakash <pprakash@codeaurora.org>,
        Ashwin Chaugule <ashwin.chaugule@linaro.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: CPPC: Fix reference count leak in acpi_cppc_processor_probe.
Date:   Wed, 27 May 2020 17:35:51 -0500
Message-Id: <20200527223551.20156-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: 158c998ea44b ("ACPI / CPPC: add sysfs support to compute delivered performance")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/acpi/cppc_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 8b2e89c20c11..067067bc03d4 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -846,6 +846,7 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 			"acpi_cppc");
 	if (ret) {
 		per_cpu(cpc_desc_ptr, pr->id) = NULL;
+		kobject_put(&cpc_ptr->kobj);
 		goto out_free;
 	}
 
-- 
2.17.1

