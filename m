Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD482D1DE
	for <lists+linux-acpi@lfdr.de>; Wed, 29 May 2019 01:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfE1XCr (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 28 May 2019 19:02:47 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43918 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfE1XCg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 28 May 2019 19:02:36 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so91752pgv.10
        for <linux-acpi@vger.kernel.org>; Tue, 28 May 2019 16:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=babayev.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s2ViynWJZEyN8mcu6TmbFxSpMS7SsoypON3/YHWH96A=;
        b=St/vjj6Qqr4VrnqnZt7lhqXW524lNYAN8dAdBgBacW3KRPKYy8Wg6HrwtcmYXieLsr
         2kwhx8/aTOPSBOgQBUK747dtMYB+e43bhpyGGz3RjdfZ+fUUYAxE0/TivmEU1fy9ZhQF
         8x+OP7ChowWrXUwDhs0nuQce21mTBh4CPydsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s2ViynWJZEyN8mcu6TmbFxSpMS7SsoypON3/YHWH96A=;
        b=Mgk8/X1jhu9E/bqQoJFHBa6VeYgbDe6EXgZpIKQ4bqycbfuX+ig7PnaGh7d/t7fMPq
         HFteCspQcTNSQQ3CClv/aIy7sdEA65AcsznNbulom+V0vM9Nnz7aZpeKgthftyJywEmR
         LSv08dj6CipQVU5UG6U/kw6Zbfu01cZeJY9XDbp6WYWIqBu64IUZd5VYwiTFrUUT9CtT
         ApjbO+pYddKVvXInv3Nvh21rNhLqbnky7CUa/FtTmvFFGVt5ka9oHYsCPBoDRBJmywsT
         N/vw3vlQiZk3bIGkEk5BhMzAxFyecyMBJQAFSHa1BOJVShnz38C4uA7H/UM6BsX0Sei4
         6jdw==
X-Gm-Message-State: APjAAAWypAKhNv3Kdy09eo4IGf6q4mc38i6PeDROLpkxO4rGm4paxKNV
        4JrMOTmw1DnFf8ihxk7PDQ5j9g==
X-Google-Smtp-Source: APXvYqxkjw4TsyenlTd45BRn+EsgZDClxPQgonXCVk8Xvy+wPAE8+WBlyAt1u5RrmXA1QHPFV4LWSw==
X-Received: by 2002:a62:5244:: with SMTP id g65mr23525695pfb.237.1559084555903;
        Tue, 28 May 2019 16:02:35 -0700 (PDT)
Received: from p50.cisco.com ([128.107.241.183])
        by smtp.gmail.com with ESMTPSA id p16sm27028196pfq.153.2019.05.28.16.02.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 16:02:35 -0700 (PDT)
From:   Ruslan Babayev <ruslan@babayev.com>
To:     mika.westerberg@linux.intel.com, wsa@the-dreams.de,
        linux@armlinux.org.uk, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org,
        xe-linux-external@cisco.com
Subject: [net-next,v4 1/2] i2c: acpi: export i2c_acpi_find_adapter_by_handle
Date:   Tue, 28 May 2019 16:02:32 -0700
Message-Id: <20190528230233.26772-2-ruslan@babayev.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190528230233.26772-1-ruslan@babayev.com>
References: <20190528230233.26772-1-ruslan@babayev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This allows drivers to lookup i2c adapters on ACPI based systems similar to
of_get_i2c_adapter_by_node() with DT based systems.

Signed-off-by: Ruslan Babayev <ruslan@babayev.com>
Cc: xe-linux-external@cisco.com
---
 drivers/i2c/i2c-core-acpi.c | 3 ++-
 include/linux/i2c.h         | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 272800692088..964687534754 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -337,7 +337,7 @@ static int i2c_acpi_find_match_device(struct device *dev, void *data)
 	return ACPI_COMPANION(dev) == data;
 }
 
-static struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
+struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 {
 	struct device *dev;
 
@@ -345,6 +345,7 @@ static struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
 			      i2c_acpi_find_match_adapter);
 	return dev ? i2c_verify_adapter(dev) : NULL;
 }
+EXPORT_SYMBOL_GPL(i2c_acpi_find_adapter_by_handle);
 
 static struct i2c_client *i2c_acpi_find_client_by_adev(struct acpi_device *adev)
 {
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 1308126fc384..e982b8913b73 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -14,6 +14,7 @@
 #ifndef _LINUX_I2C_H
 #define _LINUX_I2C_H
 
+#include <linux/acpi.h>		/* for acpi_handle */
 #include <linux/mod_devicetable.h>
 #include <linux/device.h>	/* for struct device */
 #include <linux/sched.h>	/* for completion */
@@ -981,6 +982,7 @@ bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 u32 i2c_acpi_find_bus_speed(struct device *dev);
 struct i2c_client *i2c_acpi_new_device(struct device *dev, int index,
 				       struct i2c_board_info *info);
+struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle);
 #else
 static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
 					     struct acpi_resource_i2c_serialbus **i2c)
@@ -996,6 +998,10 @@ static inline struct i2c_client *i2c_acpi_new_device(struct device *dev,
 {
 	return NULL;
 }
+static inline struct i2c_adapter *i2c_acpi_find_adapter_by_handle(acpi_handle handle)
+{
+	return NULL;
+}
 #endif /* CONFIG_ACPI */
 
 #endif /* _LINUX_I2C_H */
-- 
2.19.2

