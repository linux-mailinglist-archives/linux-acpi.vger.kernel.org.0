Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEA54943F6
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jan 2022 01:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344629AbiATAEQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 19 Jan 2022 19:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344600AbiATAEP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Jan 2022 19:04:15 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61102C06161C
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so8190214ybg.8
        for <linux-acpi@vger.kernel.org>; Wed, 19 Jan 2022 16:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=Iyr+MG88n+iHRt04O0HAxgK5CL4awNioywRv0cYQLtlwJ7Cp2SF2E+wRqKyckrKrSy
         hmfqoFYVLlfPXiyjZU06fsJiaM/B8aeEaNl3VbXQGhaWdYv6ndFzA8ejdebFsaE4eeIH
         kEvmt22o01TDRtXrlTgL3RIJthagpYwzNqQ089bNvHagB0KLUVE+3Qebav6fE5W+MVK6
         0aES0QD7R8qT9H/ciOd7arS2npXxDYv2+lDyzoviHA4D/0fKmtDzFqx3ZZuExjD1dTVD
         6mRh2ScSTKfbsEbGwT5BFTnd5Hj5sxoVitLpDVQeh5FObEJFXH+HRD6SHTvrHlLmyzbR
         fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=k7+5PtSi2SaE/0SJmGi4QGUE4EmxDvz5Ukuy4725lAE=;
        b=awb9Q5BXwPm4NNmRqTcwaLye1VN+MO5zhthLwUi7EdJTrufQ0FkrZGgB73s3suVIzu
         bffWQQR+FAVvVx0xJLs9SOHB4zj3SMoh6YIhLqDpQYhq5osCYkEAr7soPb1GAcZcJvaV
         LrucTBiZCFJik6df6/IwiEn/3aIQO4ukkZIHnmD0pqgv7G+olufPewYEps4/LwRZ1JQJ
         xM3t6yGoTygZvVx+qgr/5SO+7ieu9P/IMIa2MXNIqRuNnjbpwp6Wcuz0vhHHqPwRzenV
         yxVh+jE5DuKRTwbWHdUB+cZXfVic4TCSjT27AP5/EsNDhJjlWDFM82JCtDUlDxL7lE9r
         yUCQ==
X-Gm-Message-State: AOAM532BFeD4aX8qC+ate8AR759FmD5nyhx9PyqHcozwP9Tsm2d5/iX9
        5/6M2aY1clEkRJ3bMnx+/BSbkeV1gnGN
X-Google-Smtp-Source: ABdhPJxHY8jtaOES8j1o7rDLaIqeTvHnKwyZJ56vMd87GW+rxIi4jQUMPrzyY5G6j/GnKeYEUMVs8qiGk8ds
X-Received: from rajat2.mtv.corp.google.com ([2620:15c:202:201:4305:5632:a281:7eb0])
 (user=rajatja job=sendgmr) by 2002:a25:7e87:: with SMTP id
 z129mr45619551ybc.719.1642637054515; Wed, 19 Jan 2022 16:04:14 -0800 (PST)
Date:   Wed, 19 Jan 2022 16:04:09 -0800
Message-Id: <20220120000409.2706549-1-rajatja@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] PCI: ACPI: Allow internal devices to be marked as untrusted
From:   Rajat Jain <rajatja@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Today the pci_dev->untrusted is set for any devices sitting downstream
an external facing port (determined via "ExternalFacingPort" property).
This however, disallows any internal devices to be marked as untrusted.

There are use-cases though, where a platform would like to treat an
internal device as untrusted (perhaps because it runs untrusted
firmware, or offers an attack surface by handling untrusted network
data etc).

This patch introduces a new "UntrustedDevice" property that can be used
by the firmware to mark any device as untrusted.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci-acpi.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a42dbf448860..3d9e5fa49451 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1350,12 +1350,25 @@ static void pci_acpi_set_external_facing(struct pci_dev *dev)
 		dev->external_facing = 1;
 }
 
+static void pci_acpi_set_untrusted(struct pci_dev *dev)
+{
+	u8 val;
+
+	if (device_property_read_u8(&dev->dev, "UntrustedDevice", &val))
+		return;
+
+	/* These PCI devices are not trustworthy */
+	if (val)
+		dev->untrusted = 1;
+}
+
 void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
 {
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_external_facing(pci_dev);
+	pci_acpi_set_untrusted(pci_dev);
 	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
-- 
2.34.1.703.g22d0c6ccf7-goog

