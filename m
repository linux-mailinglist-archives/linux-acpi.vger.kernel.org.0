Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CBF4E88BA
	for <lists+linux-acpi@lfdr.de>; Sun, 27 Mar 2022 18:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbiC0QPf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 27 Mar 2022 12:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235977AbiC0QPf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 27 Mar 2022 12:15:35 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B3427CFF;
        Sun, 27 Mar 2022 09:13:56 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w4so17008796wrg.12;
        Sun, 27 Mar 2022 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MoaYREzq6jXyRyPsLV3DSxV09kFGjo/gj37Cv5lUcH8=;
        b=dbKQRX+2WDNHQwKo+f8wT6nYSnPGKx6p+cuJ4Bk1nqNvOIfJk9VO4Rgro7w+ZwYbDc
         r3GKJ40MrPoRL8731j2g2mhO4efwTtZDcAjuLV/fWod0FXFWAARiyvyTERf1fPrOLKsE
         KWDocqGRDXJhjS9YLjIb1yg75cd+bCLdz9Iyse7rT5/pE0hTR8cMCe/dxeea8Y4TTMIy
         LO/Y/Vmk4OzbI4x5/La7oiBS0KBGoB4JGrvHduEgJeDpPk51ZGUDn41M5aBiQIFWjn3K
         guJN5ya4tfRgHdSaNEZNQO9cIEryejVsbjoRZrnDvP6Ijqfeb2nPIQ4V3iBZMUHOrLOa
         UBVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MoaYREzq6jXyRyPsLV3DSxV09kFGjo/gj37Cv5lUcH8=;
        b=UJx4zeZyLFNFzYTkqSb0WaOu768L2cyv8I8oD/xeP4foq/XUxmNmxNBkoNl9n2zXMg
         PLBtOUiysDK0oYa3WTVo1g32dSMpP5wtMKc32HuFIwKWdT9vIjZdx34IBQdoLik/9Uzl
         mpNOClqW0foCpz6sHVWFVXJlPhwtSaTRMfrhXRhxw73CWrjt3zrVRDxrhUTLcDxQDytq
         /kmq2GRvsTbOtWAoFGH9AmZ6Bg98RKu6uBsjLGhNkpn0P3vs60lRLKfuDkehKL0UYSea
         CN2b+MB3EmWnuxN8I0oru8ZenLVhf5oZeoG1CUhzQqcUXBVr8yFq3oKH7Bm9L1pqdH9x
         nTMA==
X-Gm-Message-State: AOAM531B2h9M2leLvNqhB40SPYbrvrqshq9R/5kkVpKAZhni1Q3PQS/U
        Hrvu8utw3uz8VaCFFabeD958S7SfDas=
X-Google-Smtp-Source: ABdhPJyWhRnLzY0DHAkT/e+X5XKouMYHpLzaYGdW5A54blCDoptzan9nYsBawMS6AQMxvkcojpD1JA==
X-Received: by 2002:adf:e18f:0:b0:204:444:dd0d with SMTP id az15-20020adfe18f000000b002040444dd0dmr17926225wrb.678.1648397635237;
        Sun, 27 Mar 2022 09:13:55 -0700 (PDT)
Received: from localhost.localdomain (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net. [86.13.91.161])
        by smtp.gmail.com with ESMTPSA id k2-20020a1ca102000000b0038c78fdd59asm13764924wme.39.2022.03.27.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Mar 2022 09:13:54 -0700 (PDT)
From:   Daniel Scally <djrscally@gmail.com>
To:     linux-acpi@vger.kernel.org, linux-clk@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, hdegoede@redhat.com, markgross@kernel.org,
        robert.moore@intel.com
Subject: [PATCH v2 2/5] ACPI: bus: Add iterator for dependent devices
Date:   Sun, 27 Mar 2022 17:13:41 +0100
Message-Id: <20220327161344.50477-3-djrscally@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220327161344.50477-1-djrscally@gmail.com>
References: <20220327161344.50477-1-djrscally@gmail.com>
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

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Daniel Scally <djrscally@gmail.com>
---
Changes in v2:

	- switched to use acpi_dev_get_next_consumer_dev() in the loop init

 include/acpi/acpi_bus.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index cdc726d251b6..7fbe690a5b33 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -699,6 +699,17 @@ bool acpi_dev_ready_for_enumeration(const struct acpi_device *device);
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

