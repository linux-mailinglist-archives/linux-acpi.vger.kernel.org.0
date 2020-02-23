Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4C516965D
	for <lists+linux-acpi@lfdr.de>; Sun, 23 Feb 2020 07:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgBWGI1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 23 Feb 2020 01:08:27 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37968 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgBWGI1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 23 Feb 2020 01:08:27 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so2636609pjz.3
        for <linux-acpi@vger.kernel.org>; Sat, 22 Feb 2020 22:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9HpNnUs7QncuZ77UZCIt45kwbpnyNIy2S/U3jF7+HbY=;
        b=rTCl5UC12i6Z6Pga9r7uRu/5AxtgW3mgE2TbcQ8B1jy8IM4dFgFgUAlqT00VslKpwb
         VynAs/IuFFaIcUmUR6EVAYQoBUaKnTXcJlTtDzBzkJQ5LdYvPv/oqCY9tYfAZK4+cn/W
         sUWnl1bmS2Tejq2JdvNVH0s87qT3LEMjX0UyqQ4UfDTYb4T6uLBDQcLQn4W6bSwdPMBz
         kULjF0/8Mn1fkI9XCJCUVH3xBXflbB0lNfoM5fppBTGmXnabe6SMgTfEaOrEPZETXIml
         g/rile8hQGm69OwXufi3ViQdq4fXTt1w7oJzqqxCvlc06WmNcR+BbvCF1QEvqyo72cac
         tkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9HpNnUs7QncuZ77UZCIt45kwbpnyNIy2S/U3jF7+HbY=;
        b=Y2UgqFmMS4in7bfQXedPXpSYM4yVtCTIFXUpXUlI1sI1pNk3z4au9jIWVtrjIWEGga
         d+S8xFeRLPsgVzEEUkW44jhW5m/xsbD5UQsNpEB9D1AXj6jbNyaC3Sfr6IOhd7kRWeNu
         KlCIshB4SrB5hzN962qbbKWlbM3VFRSk8dKzFe0CCZZXdR8Xx1uWcOeLHjbd5UN9M8I0
         IDULMgehCWxyfibfWOsEc47JqpqYWP4Kpu6Wr2UvG7/G4Bbh5hgOhGCR9JRmKiXV1D0i
         y2wDrTqWzZizcodHGM1AlXBwoDJV/s1hgb/Fp9fjWTmnYIRdqA2gMGZEAnxbdKUJbesI
         XHSw==
X-Gm-Message-State: APjAAAUEORG7fWNVCVwp+icKdQX4azeOJXiMo4aAxh8+KMnm7lWMhPQE
        pExQzgStzw+hWu9p7Ul7+m4=
X-Google-Smtp-Source: APXvYqxwIyPZ89JTL09e6DkttbqAFkllVgiz/P+NRaW09SGF9fBTB+G7M3FMiT4KR02KtDABiah3kQ==
X-Received: by 2002:a17:90a:2486:: with SMTP id i6mr13556850pje.9.1582438106893;
        Sat, 22 Feb 2020 22:08:26 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id w26sm8144369pfj.119.2020.02.22.22.08.25
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 22 Feb 2020 22:08:26 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     rjw@rjwysocki.net, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] acpi: list_for_each_safe() -> list_for_each_entry_safe()
Date:   Sun, 23 Feb 2020 14:08:22 +0800
Message-Id: <1582438102-29488-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Use list_for_each_entry_safe() instead of list_for_each_safe()
to simplify code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 drivers/acpi/proc.c   | 14 ++++++--------
 drivers/acpi/wakeup.c | 24 +++++++++---------------
 2 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
index 0e62ef2..7892980 100644
--- a/drivers/acpi/proc.c
+++ b/drivers/acpi/proc.c
@@ -22,14 +22,13 @@
 static int
 acpi_system_wakeup_device_seq_show(struct seq_file *seq, void *offset)
 {
-	struct list_head *node, *next;
+	struct acpi_device *dev, *tmp;
 
 	seq_printf(seq, "Device\tS-state\t  Status   Sysfs node\n");
 
 	mutex_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev =
-		    container_of(node, struct acpi_device, wakeup_list);
+	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
+				 wakeup_list) {
 		struct acpi_device_physical_node *entry;
 
 		if (!dev->wakeup.flags.valid)
@@ -96,7 +95,7 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
 				const char __user * buffer,
 				size_t count, loff_t * ppos)
 {
-	struct list_head *node, *next;
+	struct acpi_device *dev, *tmp;
 	char strbuf[5];
 	char str[5] = "";
 
@@ -109,9 +108,8 @@ static void physical_device_enable_wakeup(struct acpi_device *adev)
 	sscanf(strbuf, "%s", str);
 
 	mutex_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev =
-		    container_of(node, struct acpi_device, wakeup_list);
+	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
+				 wakeup_list) {
 		if (!dev->wakeup.flags.valid)
 			continue;
 
diff --git a/drivers/acpi/wakeup.c b/drivers/acpi/wakeup.c
index 9614126..c28244d 100644
--- a/drivers/acpi/wakeup.c
+++ b/drivers/acpi/wakeup.c
@@ -30,12 +30,10 @@
  */
 void acpi_enable_wakeup_devices(u8 sleep_state)
 {
-	struct list_head *node, *next;
-
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev =
-			container_of(node, struct acpi_device, wakeup_list);
+	struct acpi_device *dev, *tmp;
 
+	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
+				 wakeup_list) {
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
@@ -57,12 +55,10 @@ void acpi_enable_wakeup_devices(u8 sleep_state)
  */
 void acpi_disable_wakeup_devices(u8 sleep_state)
 {
-	struct list_head *node, *next;
-
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev =
-			container_of(node, struct acpi_device, wakeup_list);
+	struct acpi_device *dev, *tmp;
 
+	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
+				 wakeup_list) {
 		if (!dev->wakeup.flags.valid
 		    || sleep_state > (u32) dev->wakeup.sleep_state
 		    || !(device_may_wakeup(&dev->dev)
@@ -79,13 +75,11 @@ void acpi_disable_wakeup_devices(u8 sleep_state)
 
 int __init acpi_wakeup_device_init(void)
 {
-	struct list_head *node, *next;
+	struct acpi_device *dev, *tmp;
 
 	mutex_lock(&acpi_device_lock);
-	list_for_each_safe(node, next, &acpi_wakeup_device_list) {
-		struct acpi_device *dev = container_of(node,
-						       struct acpi_device,
-						       wakeup_list);
+	list_for_each_entry_safe(dev, tmp, &acpi_wakeup_device_list,
+				 wakeup_list) {
 		if (device_can_wakeup(&dev->dev)) {
 			/* Button GPEs are supposed to be always enabled. */
 			acpi_enable_gpe(dev->wakeup.gpe_device,
-- 
1.9.1

