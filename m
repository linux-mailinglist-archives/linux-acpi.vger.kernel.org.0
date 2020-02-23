Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230B9169AB8
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2020 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBWXSZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 18:18:25 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35789 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgBWXSY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 18:18:24 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so7458149wmb.0;
        Sun, 23 Feb 2020 15:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eQ5r1R+UXgGBuhFGCv+iPfwy5B5w68fhiQyCKeEBPYo=;
        b=HwmZB7S8xicuJrpOFUlYj6Ywn+OcDppxlvgApU3s1ba85vApmC+cFGYcw1DfOobyc+
         377o2d2eVuGlEGGsGSrGfo1nh0BMD+Gf/tHin6Ro+tEEnUH0EGHqFTgMaavwLJi86Nr9
         p/QGVc/Oo4oFsgCtjMe+2EIvVKqsOSKzfIX0ZI7Jt2PQBjf43lRChJ/mE8oOaGGGhuQU
         XQvZkkWki2aSOv9m86A6T2UG5t6F7YD5uYy1Y7pmAqETA+NYfQPUJs0snqG5pdvp/aLq
         K+8kL0OfVBmD1tS0XT66jfv29XWpVp8p1CpQyEv6PEpz1VmaTRr/FlxBpvQ4gfjfPDrl
         hslA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eQ5r1R+UXgGBuhFGCv+iPfwy5B5w68fhiQyCKeEBPYo=;
        b=ucRtrGTh+GWdEoEKlAP+5GW2fBCv5O3kTR7cYnuXMkYxu5xPFL5c8jgg/aoDLuqUUF
         gxEm34mULCdNgwBlDCUpLQvbPoiG29+I4qyvynHgs8JoXpGVvnXIuvoSkuGAiNoQtDwD
         DwGlYS2PWgdgGu/TApbwfMuBWy1o0XkoaAd7J92sLBkiyIhiFKClgBJ1PPQ/v1ep9Vfz
         39QvS+4+m7NzFl6mKNb5W5WKBjU3ME/4atU2REtW+0n6BoHGkeJbQXvxywpXQ+gTz9/F
         DgP0603jAkf9CLT6TykwdvXMf73S0Tdfve6VtGKS9cdemfnCiWTqjrbCzB0hkOPa5GV8
         zW7A==
X-Gm-Message-State: APjAAAV7JMk9w+s464yAT9AV/5EO4Yp/1wLocH/lELBdIahcVU8bU2+q
        WUDfyqUYiNQu2s34zrzEbg==
X-Google-Smtp-Source: APXvYqwuXB8nvNhZzMwFqEvDoIykVeaCu/TUBfTRvhnQKrU5oyx+n944YvUaV3THAhlRAMI2/lRwzw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr17317321wmi.37.1582499903296;
        Sun, 23 Feb 2020 15:18:23 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:22 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI)
Subject: [PATCH 23/30] ACPI: OSL: Add missing annotation for acpi_os_release_lock()
Date:   Sun, 23 Feb 2020 23:17:04 +0000
Message-Id: <20200223231711.157699-24-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200223231711.157699-1-jbi.octave@gmail.com>
References: <0/30>
 <20200223231711.157699-1-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Sparse reports a warning at acpi_os_release_lock()

warning: context imbalance in acpi_os_release_lock() - unexpected unlock

The root cause is the missing annotation at acpi_os_release_lock()
Add the missing annotation __releases(lockp)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/acpi/osl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7094abc5ffc6..762c5d50b8fe 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1610,6 +1610,7 @@ acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
  */
 
 void acpi_os_release_lock(acpi_spinlock lockp, acpi_cpu_flags flags)
+	__releases(lockp)
 {
 	spin_unlock_irqrestore(lockp, flags);
 }
-- 
2.24.1

