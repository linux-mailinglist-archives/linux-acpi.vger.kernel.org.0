Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB7237EE80
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 00:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239529AbhELVv6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 17:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388844AbhELUqA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 16:46:00 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A97BC06138A
        for <linux-acpi@vger.kernel.org>; Wed, 12 May 2021 13:44:47 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x5so24938515wrv.13
        for <linux-acpi@vger.kernel.org>; Wed, 12 May 2021 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=y0JwxUTKQTGgfTmHi2QNuckl7Wl7GTxaemnVYe6JZxg=;
        b=IFdVBkgrhe+QPxuXT+6L65m572tATK9h3WC+SUMj6aDsAFjQa7zWvFFXk7nRJWsVZ6
         o6dxwoxH9IFAHUIFvbce5X2p6xpnavWbAk12QYaxlOq4nPUY3wFmrT313Yns7UFdoITW
         Gaqc+X9jHDezqpFz2HFOVsEjMIEUjIV7dn5JX4wzQUAecwLjGd0CpIF6McJ2dmr6k+EE
         bSTDHbpdWkftslr+5KVNmdMfAFcfLjtdZ8btY28SCH1iwTfwPDh2aFqIBJqC93ynUWWD
         4UTKofReKANZ/oVJpE7GzxPWBVtHOGuCsBjf9aXTSKgNSswq3wDspVhLHSJSlJEyfyck
         ZQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=y0JwxUTKQTGgfTmHi2QNuckl7Wl7GTxaemnVYe6JZxg=;
        b=WCPCahLSzMyKfjfYxSvYlOQzwY93OtG+KyPsrYEaDCdOud7p6sBqLm4SMrFLzpujRV
         VQCRuvAa48hB4rmnpvNlSoMBx0L9+dK6NQtNQ/PDoDGvvP+SbYM1tHl1tcEYAGyM2uLz
         R7iRpCgCRI1/nu6dbG7sq4QC5pQwEomzonH/1mZs4bmuiI7JRWNfnBCQVNjUWgTg0Iw7
         UFNbyR9IPZuaA4FvAW2qyMM3xajN1jMqKKjUH8++UroajwM9cOK+XEawfbQOlClKqm+2
         9TVn/4Oq+JJWYE272OTRQ/woh8Bih0DFDkjy3g60D2CkREYPOjuT81pBGJTyYVsPvUfY
         cvmw==
X-Gm-Message-State: AOAM530u80DAZ8+GTF4YGEBRwxF/YUi1nCdlCo8+oFyWGVtaWbZAN7SI
        GnZ1AL+krgHQrvJgQZI157LNO8N3HbtMqw==
X-Google-Smtp-Source: ABdhPJx9CSSD8eGfhR020+0ZEGyUJgMmneCU7c9dhHqJokWzA+OyDLRFTGnpigaNweKKvrnHug711A==
X-Received: by 2002:a5d:54c2:: with SMTP id x2mr46245575wrv.278.1620852286066;
        Wed, 12 May 2021 13:44:46 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:acaa:d921:6cbb:e380? (p200300ea8f384600acaad9216cbbe380.dip0.t-ipconnect.de. [2003:ea:8f38:4600:acaa:d921:6cbb:e380])
        by smtp.googlemail.com with ESMTPSA id c187sm7113149wmf.23.2021.05.12.13.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:44:45 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pnp: Remove pnp_alloc
Message-ID: <2c94aae5-2dd5-0046-bacb-c09770bf5d82@gmail.com>
Date:   Wed, 12 May 2021 22:36:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Kernel will complain anyway if it runs out of memory. Therefore we
don't need the error message in pnp_alloc() and hence can remove it
and use kzalloc() directly.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pnp/base.h      |  1 -
 drivers/pnp/card.c      |  2 +-
 drivers/pnp/core.c      | 12 ------------
 drivers/pnp/interface.c |  4 ++--
 4 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
index cdcfa39cf..e74a0f6a3 100644
--- a/drivers/pnp/base.h
+++ b/drivers/pnp/base.h
@@ -6,7 +6,6 @@
 
 extern struct mutex pnp_lock;
 extern const struct attribute_group *pnp_dev_groups[];
-void *pnp_alloc(long size);
 
 int pnp_register_protocol(struct pnp_protocol *protocol);
 void pnp_unregister_protocol(struct pnp_protocol *protocol);
diff --git a/drivers/pnp/card.c b/drivers/pnp/card.c
index c2464ee08..2430c14f4 100644
--- a/drivers/pnp/card.c
+++ b/drivers/pnp/card.c
@@ -80,7 +80,7 @@ static int card_probe(struct pnp_card *card, struct pnp_card_driver *drv)
 	if (!id)
 		return 0;
 
-	clink = pnp_alloc(sizeof(*clink));
+	clink = kzalloc(sizeof(*clink), GFP_KERNEL);
 	if (!clink)
 		return 0;
 	clink->card = card;
diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index a50ab002e..ccdfbf397 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -31,18 +31,6 @@ DEFINE_MUTEX(pnp_lock);
 int pnp_platform_devices;
 EXPORT_SYMBOL(pnp_platform_devices);
 
-void *pnp_alloc(long size)
-{
-	void *result;
-
-	result = kzalloc(size, GFP_KERNEL);
-	if (!result) {
-		printk(KERN_ERR "pnp: Out of Memory\n");
-		return NULL;
-	}
-	return result;
-}
-
 static void pnp_remove_protocol(struct pnp_protocol *protocol)
 {
 	mutex_lock(&pnp_lock);
diff --git a/drivers/pnp/interface.c b/drivers/pnp/interface.c
index 602c46893..44efcdb87 100644
--- a/drivers/pnp/interface.c
+++ b/drivers/pnp/interface.c
@@ -214,7 +214,7 @@ static ssize_t options_show(struct device *dmdev, struct device_attribute *attr,
 	int ret, dep = 0, set = 0;
 	char *indent;
 
-	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
@@ -257,7 +257,7 @@ static ssize_t resources_show(struct device *dmdev,
 	if (!dev)
 		return -EINVAL;
 
-	buffer = pnp_alloc(sizeof(pnp_info_buffer_t));
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
 	if (!buffer)
 		return -ENOMEM;
 
-- 
2.31.1

