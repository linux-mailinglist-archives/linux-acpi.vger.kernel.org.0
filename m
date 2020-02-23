Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB5EB169AC9
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Feb 2020 00:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgBWXS4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 18:18:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45117 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727714AbgBWXSX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 18:18:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so8198972wrs.12;
        Sun, 23 Feb 2020 15:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ccYGGn1uhoFTFXxc2+BMi8Zd6VbgRQR/G4zbVgFlOUE=;
        b=r4STgYyAZux/o3Dt72R5Ko6iVKcPclN6D+za76CjVEHXwp2xpo50t4Sk2ftvec+6md
         qufUrxwUIfQPvTvKCHy5caU007cv6vV0VC09jtOMlIJm0BOGfHS9ExLutNgwTkM6j4b0
         JRQP1r9UZXQG0Y2MiBZvzKAiTtKxzm8J8HMw/ozs9pAohsOLmO7RmE7jjQxI42KQA6lo
         TIz2mOQgcSYOgjylKHxSus783f3EKk3emoFKntkmZQxUbB+/eYMSxPXra0jFrFb+x6O3
         tM4tHlI6rVujFLcvUW271ltzJfVXg7OFLxE4Tirir3h/jq0MiGeWQBEkjMuKtyXoWydc
         En7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ccYGGn1uhoFTFXxc2+BMi8Zd6VbgRQR/G4zbVgFlOUE=;
        b=sikWP39GkGFe12Ls2TIbT3r97w2rqw3hdUiAfa6oYUQvWLP6FXc88MnZ/rTAgk/FMD
         h0kDwh0NJs0TrDa1MPATPWBzON15QeMeA+lhUxVWEuMO/HJqHScvWui8uKi2+aa5piZE
         FHEL5IRWtDr5+HQemGOvKKsWpvMRihkikSWPK2WUSLxHuSLn/+07r0BHK12mEqGjI9tm
         o36/uFpc0nKWpmo+guL1tRFgpmRCkeZzVsFtNl+ioIVDf8/jBLnhCVYEe2+JesNXBUSc
         vYkqmhg9PnoNldAbBqGj6Y/vwCY9zUC6UG1UUH8abFT1KQqD/dGfosUNnaeuRGsqAUTm
         Q6gw==
X-Gm-Message-State: APjAAAXbIvzlsihWLMce+bMfxW0Y80EXjrS3bYIo5OdVRrr31wkcfnU3
        raml30ilGCSI5YTWp4ty8Q==
X-Google-Smtp-Source: APXvYqze4QE8CTc6dz6axQ5sYtb2cIFpT5+DoqGVfDSvPVruLu/UNRhG1Tr1HgVBEm1bF2VSQAm7Ww==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr2849788wrr.379.1582499902227;
        Sun, 23 Feb 2020 15:18:22 -0800 (PST)
Received: from ninjahost.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.googlemail.com with ESMTPSA id q6sm8968203wrf.67.2020.02.23.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 15:18:21 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     boqun.feng@gmail.com
Cc:     jbi.octave@gmail.com, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI)
Subject: [PATCH 22/30] ACPI: OSL: Add missing annotation for acpi_os_acquire_lock()
Date:   Sun, 23 Feb 2020 23:17:03 +0000
Message-Id: <20200223231711.157699-23-jbi.octave@gmail.com>
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

Sparse reports a warning at acpi_os_acquire_lock()

warning: context imbalance in acpi_os_acquire_lock() - unexpected unlock

The root cause is the missing annotation at acpi_os_acquire_lock()
Add the missing annotation __acquires(lockp)

Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
---
 drivers/acpi/osl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 41168c027a5a..7094abc5ffc6 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1598,6 +1598,7 @@ void acpi_os_delete_lock(acpi_spinlock handle)
  */
 
 acpi_cpu_flags acpi_os_acquire_lock(acpi_spinlock lockp)
+	__acquires(lockp)
 {
 	acpi_cpu_flags flags;
 	spin_lock_irqsave(lockp, flags);
-- 
2.24.1

