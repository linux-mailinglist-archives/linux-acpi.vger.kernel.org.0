Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01F61E4FF0
	for <lists+linux-acpi@lfdr.de>; Wed, 27 May 2020 23:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE0VR1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 27 May 2020 17:17:27 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:40624 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgE0VR1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2020 17:17:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49XNvV1V43z9vZDH
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 21:17:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VwhfnLMuVdwW for <linux-acpi@vger.kernel.org>;
        Wed, 27 May 2020 16:17:26 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49XNvT70QGz9vZCv
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 16:17:25 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49XNvT70QGz9vZCv
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49XNvT70QGz9vZCv
Received: by mail-io1-f71.google.com with SMTP id t23so17886536iog.21
        for <linux-acpi@vger.kernel.org>; Wed, 27 May 2020 14:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=BDu1w4GqO/0pwDPGlIUN+9X68Gz6RrCs3/Z4Oto/lYw=;
        b=gkBq24eHjb6B5dSfbfBULFJBXu2PcGqnzT1r9IXXAToWbihu+C2732wgnnb04Y97RI
         QcHAPjlm6fosilIkj8/AtxZokBKcq+PivyUeG1VPWYo1SxbpghOZitTdsYTYkmaiTLSM
         yf94ZTs4WLnXWwiSj41W1W0ugugADONEcSWPckLB5DXU44RsIb4AY9ocR3XAG5YBDMcN
         NlLqrWphMlQhF7ipaGK1TM0cjHOP6TcAWMjMgn0dJ4bqCQCXdoU6fnseQhs3sjWZbSYZ
         AMX3n4LfrSmXJ93Gi/9eVLN4btEgUMANVtCmUNPATG0QFXfO+df0Cp+QAOwzkWsf746/
         6Qig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=BDu1w4GqO/0pwDPGlIUN+9X68Gz6RrCs3/Z4Oto/lYw=;
        b=BR55HdhIjANBAzsxGHjvRQawOfTWaffL3okNRuKJFqwUE++uegzHBKJ9X1YkjaCcn/
         w7CsgUIO8FngNmD4RxstTgr+Sjm2/7XnBH3WPGF5nnYPRrKl0iYWv0GwGUyJ68tLj06d
         qwxFsokj1KC1C+gz0+/CYLY4l3jdLLD28kC2sl8c3A7CpVgZYuxcNMbhA2B0SBVEfbMI
         L7x05g7+wrS2CXY00dDY8kguFnwGHrhLnPZczgxZ/FNW5fBY/wTZtVfqP9kxVCGJZRLQ
         saa5Bbd5BPhSRhNjXup/fhI8zhY+TVlngKCa/ICWrgYFJpqf5a3hTSBEhuIDbh3/gkj0
         mCYg==
X-Gm-Message-State: AOAM532XeZMumRqDTuTeWIK9UjDvN3UFi8OOsNwyXTo39VaHVl5ltzpd
        ltIziiphhkHE5x34hX/q3oiJrUY7hAD7ms487lMlIImLP1wMAVXMIAq8VNbqZ0quLHyXuvSZcIG
        wVJZuiNbu5JtGRCPILmffEi4sDQ==
X-Received: by 2002:a02:6649:: with SMTP id l9mr7195262jaf.94.1590614245182;
        Wed, 27 May 2020 14:17:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxH0S45utso1gfq4UzIatRjIO6VGNo6OZSkKkjTWCUSfGl0t6tZGMoYqJ549D8RbhNBw6YJ3g==
X-Received: by 2002:a02:6649:: with SMTP id l9mr7195246jaf.94.1590614244903;
        Wed, 27 May 2020 14:17:24 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id w26sm2278931ill.19.2020.05.27.14.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 14:17:24 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Toshi Kani <toshi.kani@hp.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: sysfs: Fix reference count leak in acpi_sysfs_add_hotplug_profile.
Date:   Wed, 27 May 2020 16:17:17 -0500
Message-Id: <20200527211717.14956-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
Thus, when kobject_init_and_add() returns an error,
kobject_put() must be called to properly clean up the kobject.

Fixes: 3f8055c35836 ("ACPI / hotplug: Introduce user space interface for hotplug profiles")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/acpi/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index c60d2c6d31d6..3a89909b50a6 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -993,8 +993,10 @@ void acpi_sysfs_add_hotplug_profile(struct acpi_hotplug_profile *hotplug,
 
 	error = kobject_init_and_add(&hotplug->kobj,
 		&acpi_hotplug_profile_ktype, hotplug_kobj, "%s", name);
-	if (error)
+	if (error) {
+		kobject_put(&hotplug->kobj);
 		goto err_out;
+	}
 
 	kobject_uevent(&hotplug->kobj, KOBJ_ADD);
 	return;
-- 
2.17.1

