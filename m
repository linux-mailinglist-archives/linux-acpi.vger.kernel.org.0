Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85544339B9
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Jun 2019 22:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfFCU2x (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 3 Jun 2019 16:28:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45419 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFCU2x (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jun 2019 16:28:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id j19so7375449qtr.12
        for <linux-acpi@vger.kernel.org>; Mon, 03 Jun 2019 13:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=EHU5AK+Mj4qB5AL0E/JcoWO3o2cvb7UDAagbWP93F6gd9CE1lBLezG4yQsZYIPaS+V
         Wn9RpyQTGwzMLyh8hwvkDLrpRa+t/w51hbLVk4UfRTMFZ0sX4fSYH8EvMgZ7RTguxaxP
         jRuEv1fBp76DSqLQisjvbdgA1TV2HgMvbvGlIrVHwLg2jFGOJuxOslmXxmk8ADXlo1Gr
         B5HM7/M+TELtie0dDrM2syZO//4NzDIJancg+Vnc5LC7xW7kGR8iygtW0whg94eX8NrG
         +jwMCSIROkXipjWdfUExtXt7YQ8ZzpP9RN6SLACKuDdsUpf+mAWv967wXR62TjV+IZVW
         5LsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+KFBFAnU1kNLS5/DKe/r6zwMtKjfn/DnI3zFYfYxNlc=;
        b=MJ4AtzTHmXlxZ+UCv5WPLBEV5yOCnbsjglPDRJgJlr17lX3JJ/02Z+3I75826EaSqF
         s3bTS/gPAxqrUDtb0XBRC/NjCj8uyPYFUAUPe2bTQ2dpGJiQChf8xIibWDI91IvL0you
         bZxoG3+k5BMmklrZ2if6rR1GV2noMyruRO2UTARKUYKua/XmCYjMDK97nLAW3U7wPs8Y
         jfe04PLsmJdssa2b1jzPgD/bdhO3NpaYXEBosGpOwy1WpG6eQWSxWGAvXCfDTbBrD1Yj
         Z1Ily2PX0DFOkOqMXTp0aq5Rfd2+zjq1VAT9qKgV5rylzioCtvasTo3mSqT0orOf6bmv
         xg/g==
X-Gm-Message-State: APjAAAUJyhmZerHe2cGzxYeX1J3OhxumjbZ4dT63L6Ib4Hwxj7yWCk8l
        YZoXPkXtRiTagHbTA0/Kc+Tp5g==
X-Google-Smtp-Source: APXvYqxjN3irkpRozi2atJyefD1tbFlAgV1wX/NN8oMIDX/KEd/3kvHqEeBXE9FRLWN+X/Vq78i54Q==
X-Received: by 2002:ac8:21bc:: with SMTP id 57mr24334342qty.73.1559593732486;
        Mon, 03 Jun 2019 13:28:52 -0700 (PDT)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id s35sm9488675qth.79.2019.06.03.13.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:28:51 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] acpi/osl: fix a W=1 kernel-doc warning
Date:   Mon,  3 Jun 2019 16:28:35 -0400
Message-Id: <1559593715-29599-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

It appears that kernel-doc does not understand the return type *__ref,

drivers/acpi/osl.c:306: warning: cannot understand function prototype:
'void __iomem *__ref acpi_os_map_iomem(acpi_physical_address phys,
acpi_size size)

Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/acpi/osl.c     | 4 ++--
 include/acpi/acpi_io.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index cc7507091dec..9c0edf2fc0dd 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -301,8 +301,8 @@ static void acpi_unmap(acpi_physical_address pg_off, void __iomem *vaddr)
  * During early init (when acpi_permanent_mmap has not been set yet) this
  * routine simply calls __acpi_map_table() to get the job done.
  */
-void __iomem *__ref
-acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
+void __iomem __ref
+*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size)
 {
 	struct acpi_ioremap *map;
 	void __iomem *virt;
diff --git a/include/acpi/acpi_io.h b/include/acpi/acpi_io.h
index d0633fc1fc15..12d8bd333fe7 100644
--- a/include/acpi/acpi_io.h
+++ b/include/acpi/acpi_io.h
@@ -16,8 +16,8 @@ static inline void __iomem *acpi_os_ioremap(acpi_physical_address phys,
 
 extern bool acpi_permanent_mmap;
 
-void __iomem *__ref
-acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
+void __iomem __ref
+*acpi_os_map_iomem(acpi_physical_address phys, acpi_size size);
 void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size);
 void __iomem *acpi_os_get_iomem(acpi_physical_address phys, unsigned int size);
 
-- 
1.8.3.1

