Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE35E5689
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Sep 2022 01:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiIUXEw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 21 Sep 2022 19:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIUXEv (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Sep 2022 19:04:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402965A3D2;
        Wed, 21 Sep 2022 16:04:50 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id e10-20020a05600c4e4a00b003b4eff4ab2cso204995wmq.4;
        Wed, 21 Sep 2022 16:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Hg39dyimgm7lunzbqIkD5pGfg/LBZjGZ6Kg26DrWVrk=;
        b=ORXEvXSwVVOhiyNaKF41hd1MCBbz4lpxnIr8QnofC0vejyCZ+eR94z7SOJYcJDTjMa
         xUhNEY4H8a/bLcWgFerhBFf9WpFqvf8jncJVGZlK9vayE05NS9Ruwk01VG2xT7IgYl2B
         MGCALbea4zY39QNsvrMJr5xGQjKAdAbZYr64+hdbw+FX3sQSfElycApT2IG+68cYNcSL
         Eu5LgoSl2OoXCKGwzcd+6I46cozbyt/DgMDlO87lIFM9SSAqvn7Ia3lSjdo33UCK9Nej
         A8KfUtHLMICUSs4pstR/1oV7F/ucPrxn/Fs8k/and9RIA72Jye8006shGaNZI4uiniYa
         a3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Hg39dyimgm7lunzbqIkD5pGfg/LBZjGZ6Kg26DrWVrk=;
        b=2HfA5iXLep2fYatsYDU4GmPKVsigbXszdY2gC9vzCTW04S6kbVYOG0jO14UGvn76ny
         Q06qgHm8DbPHgathfVrPlk58x6nUwh+BVc7bfY5HDQoXJLxgsDPj+Q3/olqu6GARET/u
         bqw+eQzG0up1OW9CqgaPrAHH9ihZ3dIHVrecXoQavXNI8O8JqI3UDGWKPciT1fvcHuHe
         naMmwSuNCQfLxzPMWzEf0tHgDOtWnheYY4cYZWqwflOuX9VjY7VJgnDkjAvAVaqJrzte
         e6corGXpLQ66htjTf8/MHaRMBS/NyA0BCpwQ2ktRGd69PYwRAHjIFW/zrUxC9kSxnkhy
         4YeQ==
X-Gm-Message-State: ACrzQf3g0wgOa6m8KxeHI733g+Dm1VBkIy0/029GN78hNhb5bQZPqX1T
        BOWRH9oSO4zgOFOyt3eY6kE+r6zzuqI=
X-Google-Smtp-Source: AMsMyM50X1vfh2/TAuzwguEAv6xy7yFmdSnf3fF3Jj+crms3jHTFZu4gO055J+XMiJv8YyY5MXHj2Q==
X-Received: by 2002:a05:600c:19cc:b0:3b4:b15a:7df with SMTP id u12-20020a05600c19cc00b003b4b15a07dfmr312589wmq.185.1663801488670;
        Wed, 21 Sep 2022 16:04:48 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id x12-20020adfffcc000000b0022ac672654dsm3519252wrs.58.2022.09.21.16.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 16:04:48 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v3 2/5] ACPI: bus: Add iterator for dependent devices
Date:   Thu, 22 Sep 2022 00:04:36 +0100
Message-Id: <20220921230439.768185-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220921230439.768185-1-djrscally@gmail.com>
References: <20220921230439.768185-1-djrscally@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add a helper macro to iterate over ACPI devices that are flagged
as consumers of an initial supplier ACPI device.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes since v2:

	- None

 include/acpi/acpi_bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bf0886dca6eb..abce6f0219ea 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -739,6 +739,17 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
 struct acpi_device *acpi_dev_get_next_consumer_dev(struct acpi_device *supplier,
 						   struct acpi_device *start);
 
+/**
+ * for_each_acpi_consumer_dev - iterate over the consumer ACPI devices for a
+ *				given supplier
+ * @supplier: Pointer to the supplier's ACPI device
+ * @consumer: Pointer to &struct acpi_device to hold the consumer, initially NULL
+ */
+#define for_each_acpi_consumer_dev(supplier, consumer)			\
+	for (consumer = acpi_dev_get_next_consumer_dev(supplier, NULL);	\
+	     consumer;							\
+	     consumer = acpi_dev_get_next_consumer_dev(supplier, consumer))
+
 struct acpi_device *
 acpi_dev_get_next_match_dev(struct acpi_device *adev, const char *hid, const char *uid, s64 hrv);
 struct acpi_device *
-- 
2.25.1

