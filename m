Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39042A717C
	for <lists+linux-acpi@lfdr.de>; Thu,  5 Nov 2020 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732778AbgKDXYQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 4 Nov 2020 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732775AbgKDXYI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Nov 2020 18:24:08 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C41C0613D4
        for <linux-acpi@vger.kernel.org>; Wed,  4 Nov 2020 15:24:07 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id p2so61379qtw.16
        for <linux-acpi@vger.kernel.org>; Wed, 04 Nov 2020 15:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=vHdKXIu5a/BipBUhc59oIdWnhVP0pQh7JEIkpmlRKJg=;
        b=XOERp8W0b/RcSy7GKN7PZ+qv75ZBb8xYrdJuS0ojEGsbCPCCPbL0oGz1CAfCUtPkfw
         lOiL3HMR0ll6U1UK+B3qoEVT59G2lnuhpnTsmPpwwPefEOc9anJ/FUEuOKp0ecsKilpQ
         Izo4UwmkzYKOaJ0f5ZfwrMbSPDS/fHt4ZpAwSatLE3a1XGopQG6kkA6rcd9kD/f78Ik+
         XE4Bi/1WSCP6VwP30Sq2ZfgvNnzexMlSKnFXyvjq52upeARB5I2weDknUm/R8wuOV9g2
         9Xizob6R5SUv0q4h9qTAyU0mLdMNelV6a7sjLgGRFcFYgiwr2npfztVqm5M3KZuwiqxZ
         nM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=vHdKXIu5a/BipBUhc59oIdWnhVP0pQh7JEIkpmlRKJg=;
        b=Y6YKvAXnrGes94oK3KpjWe8yL0YiI6IjcauqZsTBWPYUD3xVjDc/0RRM8dH09ydUzr
         Tnd0Xg9qJZeGuE0sOXbausjtquX7Hk07GcRXh+5tuoZ7ZjkMj12Xp8c97XtS5IgKvoRr
         ftr8KNVE3wlBAcv+JZ6uPw034/zwDsQtX2Rm0VWtqXPAG6oBK2+qREtBxW5KKBNJ4cik
         QLDO0/8/oZrbuMqgn0a2ZzNd/QL5sgImy7c8t2dHlnIiyyq4FMx3RF9a/yBJmSKrPaQk
         Qo3Vm5H8emZVvbzta8m5Aaje5zaIN/NJD8MNdjKX9R/QmeKvrB5uWJy2nAy7NGJU5ZTf
         4A7g==
X-Gm-Message-State: AOAM532RI/Z9AvYk2pgDZGG/6oOFCUX0zC1WyUJEmlfdG6ftxdN/5csm
        lYf+h8N1cd9/p2+7Gi/85TT7rGwL14y5uDA=
X-Google-Smtp-Source: ABdhPJyqW/2GEna8dpUtpHta9UVhP+9LYSo/Tlv/B4BKnI5/sEaw73zeE7aowjC0wyYjQsjaj/1GKdDhM34tjxE=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:8d05:: with SMTP id
 r5mr257917qvb.31.1604532247024; Wed, 04 Nov 2020 15:24:07 -0800 (PST)
Date:   Wed,  4 Nov 2020 15:23:40 -0800
In-Reply-To: <20201104232356.4038506-1-saravanak@google.com>
Message-Id: <20201104232356.4038506-4-saravanak@google.com>
Mime-Version: 1.0
References: <20201104232356.4038506-1-saravanak@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v1 03/18] Revert "driver core: Don't do deferred probe in
 parallel with kernel_init thread"
From:   Saravana Kannan <saravanak@google.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This reverts commit cec72f3efc6272420c2c2c699607f03d09b93e41.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/base.h | 1 +
 drivers/base/core.c | 1 +
 drivers/base/dd.c   | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 91cfb8405abd..c3562adf4789 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -156,6 +156,7 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
 extern int devres_release_all(struct device *dev);
 extern void device_block_probing(void);
 extern void device_unblock_probing(void);
+extern void driver_deferred_probe_force_trigger(void);
 
 /* /sys/devices directory */
 extern struct kset *devices_kset;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2328c8951695..6745375a8bb9 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1550,6 +1550,7 @@ void fw_devlink_resume(void)
 		goto out;
 
 	device_link_add_missing_supplier_links();
+	driver_deferred_probe_force_trigger();
 out:
 	mutex_unlock(&defer_fw_devlink_lock);
 }
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b42229b74fd6..008724f8edf1 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -167,6 +167,11 @@ static void driver_deferred_probe_trigger(void)
 	if (!driver_deferred_probe_enable)
 		return;
 
+	driver_deferred_probe_force_trigger();
+}
+
+void driver_deferred_probe_force_trigger(void)
+{
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.29.1.341.ge80a0c044ae-goog

