Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3AEA8FA37
	for <lists+linux-acpi@lfdr.de>; Fri, 16 Aug 2019 07:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfHPFIe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 16 Aug 2019 01:08:34 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44838 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfHPFId (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Aug 2019 01:08:33 -0400
Received: by mail-yb1-f193.google.com with SMTP id y21so1572409ybi.11;
        Thu, 15 Aug 2019 22:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=n9jPFjFtgknTRJ6GU7NeK3IhfspwHon9co3H1wc56uc=;
        b=RMD6SAOcd3Qko5Xq7Gy+9SyBuIj9orZwjH1DOBsa1csrfqUCtJVitxB9t/yYLNc7dq
         lXiANOJnubr/LlzWjanZVgxz7pQzZdmIa0ftKhJ0gzR3BrO9Faa/oluuN3zFvP7Kfs9K
         4oyMpFm+uG0dfZB0dPLFQ/Z2XhQStZ8jFa1jpKaBV6UyxbblB7glrTfWrRiOWhOJ946F
         xEe31+xDRbI7lSgHcBqNa0Ema8GLmNpzq2Hr78+lP8JFzBqltmXNOLo3U8D+LSSo/JU+
         rvvg2GIZYkwi9QtNym2e1s+E9mgxTdE4S1eP+0GVvWRTLCb26VEMUytS63/b+nQgsgtH
         WRpw==
X-Gm-Message-State: APjAAAUxTAwbaoZmp6ziuk7/88j0QMPoUqk0+0TlwACp+o5/d8192njp
        S/tXUXroihNG7xRYlEUcLnwq5TpO+RkGSg==
X-Google-Smtp-Source: APXvYqy29T35yGSC6n5EaPM9cAmWTFrCnfRGxbLV1crOkV6a7+U7Hf7qPZ2wU1e3wKb7ctrnb3ikoA==
X-Received: by 2002:a5b:d08:: with SMTP id y8mr5755756ybp.464.1565932113075;
        Thu, 15 Aug 2019 22:08:33 -0700 (PDT)
Received: from localhost.localdomain (24-158-240-219.dhcp.smyr.ga.charter.com. [24.158.240.219])
        by smtp.gmail.com with ESMTPSA id b64sm1036577ywe.43.2019.08.15.22.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 22:08:32 -0700 (PDT)
From:   Wenwen Wang <wenwen@cs.uga.edu>
To:     Wenwen Wang <wenwen@cs.uga.edu>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org (open list:ACPI),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ACPI: custom_method: fix memory leaks
Date:   Fri, 16 Aug 2019 00:08:27 -0500
Message-Id: <1565932107-5864-1-git-send-email-wenwen@cs.uga.edu>
X-Mailer: git-send-email 2.7.4
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

In cm_write(), 'buf' is allocated through kzalloc(). In the following
execution, if an error occurs, 'buf' is not deallocated, leading to memory
leaks. To fix this issue, free 'buf' before returning the error.

Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
---
 drivers/acpi/custom_method.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/custom_method.c b/drivers/acpi/custom_method.c
index b2ef4c2..fd66a73 100644
--- a/drivers/acpi/custom_method.c
+++ b/drivers/acpi/custom_method.c
@@ -49,8 +49,10 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 	if ((*ppos > max_size) ||
 	    (*ppos + count > max_size) ||
 	    (*ppos + count < count) ||
-	    (count > uncopied_bytes))
+	    (count > uncopied_bytes)) {
+		kfree(buf);
 		return -EINVAL;
+	}
 
 	if (copy_from_user(buf + (*ppos), user_buf, count)) {
 		kfree(buf);
@@ -70,6 +72,7 @@ static ssize_t cm_write(struct file *file, const char __user * user_buf,
 		add_taint(TAINT_OVERRIDDEN_ACPI_TABLE, LOCKDEP_NOW_UNRELIABLE);
 	}
 
+	kfree(buf);
 	return count;
 }
 
-- 
2.7.4

