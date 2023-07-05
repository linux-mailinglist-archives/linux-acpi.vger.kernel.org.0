Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B18748328
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Jul 2023 13:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGELpd (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 5 Jul 2023 07:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGELp0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Jul 2023 07:45:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EED41BC2
        for <linux-acpi@vger.kernel.org>; Wed,  5 Jul 2023 04:45:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-262d33fa37cso2976035a91.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Jul 2023 04:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688557507; x=1691149507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+ITQvowAXOXD8H4U5Ak65JYD6vo7/xikUkbFThVisc=;
        b=JdOIUPCcVgRbkHL6lKC2twEROgaAL4yJ8ZwTGhCaGWbZQF9aFGaRYNPGYzOGyghzhg
         +xgjWXfn01h1SKYk1tCnUwym7zJigY1FB2L5nLJ9K9xF+V96OcBaG8t1Nvd3B2sJD/Ls
         4hF63PIb9gGwLm7I9MhvBmuNYQeSd2x4nd+O5gtyCppqbUmkWKDhM+rfZ0oSgKLAnmyh
         ef/1usAQUA9CcwFdOCMOZiXTJMrJ22ZEPa8whSjBMypJAPO7J2gk5zs4iFCdj7s8Fcrk
         ie3LhugAEg6iQhA7aaj/0X0A/wWygp1ho0cDLjVJrYds9JfqZ7MvJZbTR5YNypqp+lHX
         hrow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688557507; x=1691149507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+ITQvowAXOXD8H4U5Ak65JYD6vo7/xikUkbFThVisc=;
        b=NaxfYxyzrPYePRyZ06vQeXsRJAEc4G0iWbmaLEg1iWdcCCjTYtENr1BuzhsOQNqaEq
         vtoqsb5MvnQ7/mlZPARM5IiZARkVSh1z2qn4zoH1TUdg9fW8OLhJjlsW2Y6SYx8NAkD4
         1VPuY5ja3bJu2CAaUp2cGdm0sOMY/VPLbaMTLooEbH8pijU+oW+caYGCay/sjtVViTMf
         UxjME1i6PC3VIZrgBdQPc6BI2iOLxOEenI+6wwWQHX26seRTncKmlXB52cVc5vUJoAdE
         lx1kprTet6oQWM4q1HlNrKjZyNad1QYPfLoArlBG1U+fHOuE3af6n+VVRCtQbkCxd9+c
         dklw==
X-Gm-Message-State: ABy/qLaoJp7B4D3/lqJ2NDVkf46TvORsdpJRr3TE0akZBfCRprjfKZqs
        XQtPSyxlMAzBQeIQ2pzcHVMgZA==
X-Google-Smtp-Source: APBJJlFcrKCShSuwPuLAA2ZOXSGBben7z55N7jwvIQjxqZ8xyVRdttDLfGixeJRGpz3xqUvIJ1x13w==
X-Received: by 2002:a17:90b:5109:b0:263:5c78:4b63 with SMTP id sc9-20020a17090b510900b002635c784b63mr12763480pjb.45.1688557506871;
        Wed, 05 Jul 2023 04:45:06 -0700 (PDT)
Received: from PF2E59YH-BKX.inc.bytedance.com ([61.213.176.5])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a194300b00263f6687690sm1177900pjh.18.2023.07.05.04.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 04:45:06 -0700 (PDT)
From:   Yunhui Cui <cuiyunhui@bytedance.com>
To:     conor@kernel.org, sunilvl@ventanamicro.com, ardb@kernel.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        rminnich@gmail.com, mark.rutland@arm.com, lpieralisi@kernel.org,
        rafael@kernel.org, lenb@kernel.org, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, cuiyunhui@bytedance.com
Subject: [PATCH v3 4/4] dt-bindings: firmware: Document ffitbl binding
Date:   Wed,  5 Jul 2023 19:42:51 +0800
Message-Id: <20230705114251.661-5-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230705114251.661-1-cuiyunhui@bytedance.com>
References: <20230705114251.661-1-cuiyunhui@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add the description for ffitbl subnode.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 .../devicetree/bindings/firmware/ffitbl.txt   | 27 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/ffitbl.txt

diff --git a/Documentation/devicetree/bindings/firmware/ffitbl.txt b/Documentation/devicetree/bindings/firmware/ffitbl.txt
new file mode 100644
index 000000000000..c42368626199
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/ffitbl.txt
@@ -0,0 +1,27 @@
+FFI(FDT FIRMWARE INTERFACE) driver
+
+Required properties:
+ - entry		: acpi or smbios root pointer, u64
+ - reg			: acpi or smbios version, u32
+
+Some bootloaders, such as Coreboot do not support EFI,
+only devicetree and some arches do not have a reserved
+address segment. Add "ffitbl" subnode to obtain ACPI RSDP
+and SMBIOS entry.
+This feature is known as FDT Firmware Interface (FFI).
+
+Example:
+	ffitbl {
+
+		smbios {
+				entry = "";
+				reg = < 0x03 >;
+
+		}
+		acpi {
+				entry = "";
+				reg = < 0x06 >;
+
+		}
+	}
+
diff --git a/MAINTAINERS b/MAINTAINERS
index 9b886ef36587..008257e55062 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7874,6 +7874,7 @@ F:	include/linux/efi*.h
 FDT FIRMWARE INTERFACE (FFI)
 M:	Yunhui Cui cuiyunhui@bytedance.com
 S:	Maintained
+F:	Documentation/devicetree/bindings/firmware/ffitbl.txt
 F:	drivers/firmware/ffi.c
 F:	include/linux/ffi.h
 
-- 
2.20.1

