Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBB54189FA6
	for <lists+linux-acpi@lfdr.de>; Wed, 18 Mar 2020 16:30:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgCRPaD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 18 Mar 2020 11:30:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53419 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726879AbgCRPaD (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 18 Mar 2020 11:30:03 -0400
Received: by mail-wm1-f66.google.com with SMTP id 25so3918868wmk.3
        for <linux-acpi@vger.kernel.org>; Wed, 18 Mar 2020 08:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TaCGRE0ddOQFfvjcvGEAh9NQeOSr5Kg0auRkCXlkB9A=;
        b=W3UBXYh31RvR0blEgis0zhsMRI88hYEvr9oLOl8gVTXgiL9H0D3IGOkpXRn2H8Tx0N
         jqcmgyMkm9JIPIG+1Y6Q1Dll64O5ahHBkpmaZFR80mz8zCSOKQDjqFzWIZKgy/Pu5kif
         H4ifB/yWB4RuKk2xbgIh48z/zfOkFi95uAGogll5/j4+boNXtSZsrM3pAa2ggksq/e6W
         yT5pLTWvjOTRpdldS/MT94b6GuvuIc9AIh2746LBZrjjrSRNx2sDWjpNz00di+zxLRIC
         wqvRKklO9Vy+u8Ajti1mPqcLyoDKTaKUx4z8jNvzF1UZspk4GfRQT8OcbYDWPLZhV3bm
         6mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TaCGRE0ddOQFfvjcvGEAh9NQeOSr5Kg0auRkCXlkB9A=;
        b=jn/3G+EU44QyWoXbR7CECGEd5YFeH3c+bB4u5ESOhpCVOwdDxHJgodYuvoqCQlwAv1
         26IrOp6fPmnx89PnUDaqyxYXoMYbVDfq5yQr9CaiJ7Nv+QuFl2KJo4OO7CfDlN/+JWVa
         mvMRerJSaRY16oRJRyQfT+LqVDUibb9B1SbiYo6ZeVeIKVcHUVOXYAnUWBeDEg2TLaYE
         Z8YYibiEjUXOtxtjtja3g2XqwXjRfWZaicFI7VRINc5Z4cL9xDzLe5VkbMfVwVfOouTv
         PQJqg/AOzhSPSNQfsDpi62gjAnIvobwV1Y7lb5yVH4eWiYGZXCFoEVsavEGR6X7BEnSS
         XTHw==
X-Gm-Message-State: ANhLgQ0yCXRYwem42ro8OtiGiuxjwx8Z0mSGEFsv3MMexOXSuk5aE6VL
        DRJahTVBZIgNLdRhU6OQ6Zn3fRkiazE=
X-Google-Smtp-Source: ADFU+vsyKpeQKIsfzZhMgnHUIlxJK9C3vLhsK2vuOOu2pil/AdsY61Szi10LT/GQ7MH+tK+6zDJS1Q==
X-Received: by 2002:a05:600c:350:: with SMTP id u16mr5681702wmd.27.1584545399916;
        Wed, 18 Mar 2020 08:29:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l5sm9678228wro.15.2020.03.18.08.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 18 Mar 2020 08:29:59 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     rjw@rjwysocki.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: Add linux-acpi list to PNP
Date:   Wed, 18 Mar 2020 15:29:51 +0000
Message-Id: <1584545391-20811-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

As asked by the PNP maintainer, linux PNP patch should be CC to
the linux-acpi mailing list.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index be44251d1e04..4979de5c0c61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13452,6 +13452,7 @@ F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
 
 PNP SUPPORT
 M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
+L:	linux-acpi@vger.kernel.org
 S:	Maintained
 F:	include/linux/pnp.h
 F:	drivers/pnp/
-- 
2.24.1

