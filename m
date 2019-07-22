Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2193C6F735
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jul 2019 04:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbfGVCgE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 21 Jul 2019 22:36:04 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41610 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbfGVCgE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Jul 2019 22:36:04 -0400
Received: by mail-io1-f67.google.com with SMTP id j5so66450003ioj.8;
        Sun, 21 Jul 2019 19:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7CEzcbOz71poU4j3yG0xg7J69W88eLOvN2k9jJzfLm8=;
        b=TuMIIfdyVwz4Q4mMVyjhYAoVVOOlk8i5e8EZkE9fcs7lDwW5SdfEr9lk98yIFg4XXx
         +wKvt9Z2MahPIR4l5fTkxUlqEeM8TSZz3zvMw4Cr+7PftPkDGE4TI+7GQFXKtMoQtpn+
         pHpt+nYxea1gFZ3TOyrOq4TdV2Crrv9VJ8gulOTFyYLy7q4OnJjBE8Wfb8GvC6nj0QA6
         31k+z+nMdhq7YYYIlov/FUYp387m+9JLfQLfXO9tHZRyrBfE1shZbsoOwh1mzY3K2yHn
         5xTxNxl6P+jNkq5jQfzT/tVZGkwU8Cq/NKmrVqCK6LvW+LUpqTAInC+EOjBaZElc4XLP
         JXkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7CEzcbOz71poU4j3yG0xg7J69W88eLOvN2k9jJzfLm8=;
        b=r6CWsPc1KF+jspFQ1i+9m+NTVR8J2zUm5S/wP5OMsuFRdLvXc3vwwY5fUsSPA58tS9
         rycDWsuGmgD/De51qcK0LEWFhQmceyaqTvEiTviyzo8kbfDkc390p3Z9deOun3OO7npY
         tbJcXkTVSbWBGQrhuiXmiEZTw/ShxY2fMp8nIB3bvWlJM8omDVdCScUui3+pKv1weihW
         86LnNSj/lHU9RGr4vEW15Kk12bVNlP50QmAhYxMp+JOvRoG6nsrBFwUrZDovaG1IxRT9
         aVbu5sfBiIdforb+TNbNgWY3e6G66o2V+oc+bCy+9mH+vSfafkAqNZiSWHPTQ2TKgccb
         z50Q==
X-Gm-Message-State: APjAAAX+y0VU56/Iliq7QvEUY+XdSyw55LCAYtg+vgepNImu/LBl9KW/
        ctwcLvBesyvoPIndkBELF7IbYHCWSpM39Q==
X-Google-Smtp-Source: APXvYqyjvt9UTlCFXQ7qZs1+LlnjSsv7L3fhmjibyDHfbnTDGc6qaCUdt1d3Hl/Bjpgz/FqWPQP+0w==
X-Received: by 2002:a5e:8412:: with SMTP id h18mr63668858ioj.268.1563762963997;
        Sun, 21 Jul 2019 19:36:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-243-191-173.hsd1.co.comcast.net. [73.243.191.173])
        by smtp.gmail.com with ESMTPSA id e188sm32816577ioa.3.2019.07.21.19.36.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 21 Jul 2019 19:36:03 -0700 (PDT)
From:   Kelsey Skunberg <skunberg.kelsey@gmail.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, bjorn@helgaas.com,
        skunberg.kelsey@gmail.com
Subject: [PATCH 2/3] ACPI: Remove acpi_has_method() call from scan.c
Date:   Sun, 21 Jul 2019 20:35:29 -0600
Message-Id: <20190722023530.67676-3-skunberg.kelsey@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
References: <20190722023530.67676-1-skunberg.kelsey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_evaluate_reference() will return an error if the DEP method
does not exist. Checking if the DEP method exists before the
acpi_evaluate_reference() call is not needed. Remove acpi_has_method()
call to avoid additional work.

Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
---
 drivers/acpi/scan.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 0e28270b0fd8..4f2b0b481cee 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1803,9 +1803,6 @@ static void acpi_device_dep_initialize(struct acpi_device *adev)
 
 	adev->dep_unmet = 0;
 
-	if (!acpi_has_method(adev->handle, "_DEP"))
-		return;
-
 	status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
 					&dep_devices);
 	if (ACPI_FAILURE(status)) {
-- 
2.20.1

