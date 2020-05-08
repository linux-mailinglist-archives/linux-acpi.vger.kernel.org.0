Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF8021CBADD
	for <lists+linux-acpi@lfdr.de>; Sat,  9 May 2020 00:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEHWse (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 8 May 2020 18:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727774AbgEHWse (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 8 May 2020 18:48:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E96C061A0C
        for <linux-acpi@vger.kernel.org>; Fri,  8 May 2020 15:48:34 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id j8so3400684iog.13
        for <linux-acpi@vger.kernel.org>; Fri, 08 May 2020 15:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWdsJ1NGPr7oPwWFvlUBsi6Qw8i1lzhg04lZd6bc6aM=;
        b=aO/VaZcOYz/Kc0PeZol3BrIcDYWRjNYcEV4HH9TIWi6NIRkGQqrao0rXYf8DXlMYkw
         5iUYwq5F6iIKqthHa2WlsWQuNt/bv9OwTt/j5Hv8LdBA5qs2/EE2VFRkvHp4Xpocerqt
         TLcefjFE87OQVuugLNM8vOr+L+WRXnbBFHnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fWdsJ1NGPr7oPwWFvlUBsi6Qw8i1lzhg04lZd6bc6aM=;
        b=sButJJwSvdLC/z/4cyFiD48GEhuWyeXUlNDTMi3U0fmylAI/uX0k96n6w6Damh/sgm
         W+7jCtaWLBjaXBnp4euQPXz5yG21HQFKIR8w3GHEY86ExzV02moI8rxBflSr+06XKcVU
         CRb5SYSvDB692oU+96P7ogiSMtjgC0JGavpQ53F7bNuCb0EiJnydHZZ8VBQeI9XrF4O9
         ioURybuimymsERSlKLbnDpyDSNp+wwLpE4BSLxXw9sshesdFHqyW+LVwCywqC+YNkj5Y
         ndLEvOcSTq3K056O41PpThxUfKyeKsijOt7zPytVt7h3+tl5Mik9DffTSVr7kjx8svKb
         0Erw==
X-Gm-Message-State: AGi0PubBMUezjew+PwikvT9jAeVs8GiqNzyn2Vperv5nMwIwhG0znY1X
        35osZOd1k6VXJt3E9ErkgIV8Eg==
X-Google-Smtp-Source: APiQypI25iFqqbLfAR8A9ESKFC1ynWatFmSQmQsfDFNfZoDnC88RujwSFozsdqmou1Wfrnm/FyVC7g==
X-Received: by 2002:a5d:8591:: with SMTP id f17mr3040492ioj.26.1588978113517;
        Fri, 08 May 2020 15:48:33 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id 17sm431818ill.14.2020.05.08.15.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 15:48:33 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc:     Daniel Kurtz <djkurtz@chromium.org>, dianders@chromium.org,
        evgreen@chromium.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iommu/amd: Fix get_acpihid_device_id
Date:   Fri,  8 May 2020 16:48:30 -0600
Message-Id: <20200508164819.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

acpi_dev_hid_uid_match expects a null pointer for UID if it doesn't
exist. The acpihid_map_entry contains a char buffer for holding the
UID. If no UID was provided in the IVRS table, this buffer will be
zeroed. If we pass in a null string, acpi_dev_hid_uid_match will return
false because it will try and match an empty string to the ACPI UID of
the device.

Fixes: ae5e6c6439c3 ("iommu/amd: Switch to use acpi_dev_hid_uid_match()")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..06f603366cb1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -125,7 +125,8 @@ static inline int get_acpihid_device_id(struct device *dev,
 		return -ENODEV;
 
 	list_for_each_entry(p, &acpihid_map, list) {
-		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid,
+					   p->uid[0] ? p->uid : NULL)) {
 			if (entry)
 				*entry = p;
 			return p->devid;
-- 
2.26.2.645.ge9eca65c58-goog

