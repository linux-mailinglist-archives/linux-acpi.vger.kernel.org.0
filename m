Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326444B9433
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Feb 2022 23:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237823AbiBPWxi (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 16 Feb 2022 17:53:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbiBPWxg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Feb 2022 17:53:36 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EBF29E94C;
        Wed, 16 Feb 2022 14:53:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d27so5813459wrc.6;
        Wed, 16 Feb 2022 14:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q02S7DaGUIfYV0vlp3pYkDN2E9uoIt6l1gbx25MofQI=;
        b=RIfiq7SJqInA4/+xu3nfmHVrW/VoW7UayLokJP0hBCtkSgASOlzE2rMBuy0D99x28b
         vI87kZsN1G9YdabeTJWv34BC34cEfxQla/ADL/bCXcgbADdFLth/yt/TrYfQEt+I/37/
         QkPxnTOnVOiyYEqDk1J/EWnKvG9IjZtT2lrfYQXW48O/EIA400bptxJZzMNIRQWtmnvE
         rEtpkHZSFQ4YYRO+TMGpGX3daZZ3405EKCeM5ktOU6HtVT4n+tSpZ6zFUk/4dGuYnroe
         HxE7DdM8uplVnA6FHb102luwtYADEjC9fBGc0eFfvoEnjto3vCZ6GndV4k6VQg7QtoH3
         u6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q02S7DaGUIfYV0vlp3pYkDN2E9uoIt6l1gbx25MofQI=;
        b=Qd+onMJZlcwb17VPmM+RjeLv2Z0ZeHtB7LQbmYzbI0D1V3NqS0u8EzqLu7FLpY8HM5
         Tp4lwgxqXPbfN3nGKzHQ/tcow9uHdQXgCwOIAxiJxecpY9t1yNG2FD4qlnwMjevK44Pl
         hkZFiUVcTGm8agZyorKqVAcxE9pPA2YZ8c/u/1m6yc68djKaGQqnAxqcNTL59Gcl8jIj
         BQRv9CdEDDShN0hDoERXuTTpMUOVtMpCfmxgSEF17OpiwccLRkSaakV3YoZXFPhpl+Z0
         osdqCSDE+wTFNeWe+4ABBmz/727o82l7dDWqfF2sa44A5KcEIu+8QfUdyv+xrNkRmbPU
         +nVQ==
X-Gm-Message-State: AOAM532V9l48AscYoEWCmqatOJS1hYt2nrr6p3rTxnjq5Kun8kveZnnK
        hb9HnMZeut6VvqpHidX2ChdLH1trw0gtiA==
X-Google-Smtp-Source: ABdhPJxF7uklk0THZAKmOV3uk417g2jgmFAETN4o1HRsC76CG2JUbRj/hHuCD86UY0fwiaf+l7rlqw==
X-Received: by 2002:a5d:61d2:0:b0:1e3:c0b7:c3e7 with SMTP id q18-20020a5d61d2000000b001e3c0b7c3e7mr138484wrv.682.1645052002109;
        Wed, 16 Feb 2022 14:53:22 -0800 (PST)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id o125sm182539wme.37.2022.02.16.14.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 14:53:21 -0800 (PST)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH 2/6] ACPI: bus: Add iterator for dependent devices
Date:   Wed, 16 Feb 2022 22:53:00 +0000
Message-Id: <20220216225304.53911-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220216225304.53911-1-djrscally@gmail.com>
References: <20220216225304.53911-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a helper macro to iterate over ACPI devices that are flagged
as consumers of an initial supplier ACPI device.

Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
 include/acpi/acpi_bus.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 8b06fef04722..72103bcdd5b3 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -723,6 +723,18 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
 						   struct acpi_device *start);
 struct acpi_device *acpi_dev_get_first_consumer_dev(struct acpi_device *supplier);
+
+/**
+ * for_each_acpi_consumer_dev - iterate over the consumer ACPI devices for a
+ *				given supplier
+ * @supplier: Pointer to the supplier's ACPI device
+ * @consumer: Pointer to &struct acpi_device to hold the consumer, initially NULL
+ */
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = acpi_dev_get_first_consumer_dev(supplier);	\
+	     consumer;							\
+	     consumer = acpi_dev_get_next_consumer_dev(supplier, consumer))
+
 struct acpi_device *
 acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
 struct acpi_device *
-- 
2.25.1

