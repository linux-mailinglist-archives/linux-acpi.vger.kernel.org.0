Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7E842CAE6E
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Dec 2020 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389126AbgLAVbK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 1 Dec 2020 16:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389080AbgLAVbK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Dec 2020 16:31:10 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1387BC0613D4
        for <linux-acpi@vger.kernel.org>; Tue,  1 Dec 2020 13:30:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u37so3982107ybi.15
        for <linux-acpi@vger.kernel.org>; Tue, 01 Dec 2020 13:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=0fZJNYwOSqcD8+IxQldlQWReWNbfGau5AHEVcdiMUlE=;
        b=sjUzOmeqHlEVulc92piMYN9qFlBmLj+7D8kxU4XW2ReOVTN03rm69uePsvpz8soROf
         sle7We46ZVXIdVxl/HwOuGnjAG9I9usk2JlXX7Z7FgUtMGKjLm6vQCJy6fAgU+pGZSHb
         PIYRmxtVLS3578blW2fEke3e6kpT6bSRKJ1ijQhZcX64xj0AGZU5Euv8bhPsHU5gYdJN
         SzQhe3lqCpDem4jcNtOJs0nfxaRuMWifFdkVodfaYjrhsdXWKvn13UyDZ2dhNfaljWX1
         +BH5JxsmzS0au1misZgLU7a8ELBNTqGJHQ25YnTxBb1IhoWC+Lw66J6HZZ55cMRMXjeO
         6FOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=0fZJNYwOSqcD8+IxQldlQWReWNbfGau5AHEVcdiMUlE=;
        b=EdZxi+l7gCNRxp2B576JhT2PChZT3dTC86LWvHfBSYy6RjcPY8WGUbf8w2kWkqSIoE
         GZwaAxU3jrs1fs28kG5vfk2MsE+8WIBP/zGL1/XhdItC5VHrZgfI1Iqm8lxxpcbPj+fb
         yZMDqNCqeT+QgerihJOfhe6fqvz+nV1kbQMFA+MW/HrTeaVwIKnfeMJYVyAB6B4+6WKa
         77UlBUfbBMbAVeKuMnNzuJSkkV9BNeaz+Jm5D+hpdADhC8jASa04pq2XSn4oSDD5o39Y
         j8Mu1e2ZPuZzXnmyEnr0S7/S6M4dguVic0yy6HApd4UQgo8zqU9EI/FOuSOeKhKP26YR
         UUMw==
X-Gm-Message-State: AOAM530aC+gejmZ77gqEwoS4x6cK4fUzc/Or6M8nYk6e5ToZOB3NG/h3
        kkfcfqWims0C5nzAOzQwwW6Rgr07ozWf
X-Google-Smtp-Source: ABdhPJzwbH9QOsffb86FfNWo79SZUkTVor2Plwd0GZicm/PB5AP+/QrE6MFqyeBUo3SlaGcW58JW6fO+9hS+
Sender: "furquan via sendgmr" <furquan@furquan.mtv.corp.google.com>
X-Received: from furquan.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:13a4])
 (user=furquan job=sendgmr) by 2002:a25:9392:: with SMTP id
 a18mr7255295ybm.330.1606858223245; Tue, 01 Dec 2020 13:30:23 -0800 (PST)
Date:   Tue,  1 Dec 2020 13:30:19 -0800
Message-Id: <20201201213019.1558738-1-furquan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH] drivers: core: Detach device from power domain on shutdown
From:   Furquan Shaikh <furquan@google.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Furquan Shaikh <furquan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

When the system is powered off or rebooted, devices are not detached
from their PM domain. This results in ACPI PM not being invoked and
hence PowerResouce _OFF method not being invoked for any of the
devices. Because the ACPI power resources are not turned off in case
of poweroff and reboot, it violates the power sequencing requirements
which impacts the reliability of the devices over the lifetime of the
platform. This is currently observed on all Chromebooks using ACPI.

In order to solve the above problem, this change detaches a device
from its PM domain whenever it is shutdown. This action is basically
analogous to ->remove() from driver model perspective. Detaching the
device from its PM domain ensures that the ACPI PM gets a chance to
turn off the power resources for the device thus complying with its
power sequencing requirements.

Signed-off-by: Furquan Shaikh <furquan@google.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d661ada1518f..5823f1d719e1 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -23,6 +23,7 @@
 #include <linux/of_device.h>
 #include <linux/genhd.h>
 #include <linux/mutex.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/netdevice.h>
 #include <linux/sched/signal.h>
@@ -4057,6 +4058,8 @@ void device_shutdown(void)
 			dev->driver->shutdown(dev);
 		}
 
+		dev_pm_domain_detach(dev, true);
+
 		device_unlock(dev);
 		if (parent)
 			device_unlock(parent);
-- 
2.29.2.454.gaff20da3a2-goog

