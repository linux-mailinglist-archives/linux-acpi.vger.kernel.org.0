Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4900F4A8810
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Feb 2022 16:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352000AbiBCPxL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Feb 2022 10:53:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59643 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345453AbiBCPxI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Feb 2022 10:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643903588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ks1CIPFj2/fYzB6yS/XckTl+P/ywb94b1XuAVtGF6WU=;
        b=D5CbsNUHDIyGncKSUWmMZRQKzxVSlw32gVSsENAh98o+974wYwcOZjA+Vp8gWO7XK23P3z
        /97FNMmGoaLU2ZcUL+/wbMAQlCzaVQq0HR74G9gH98Ul+xZstZj3RcMpEDQMVxiBKbRFZD
        QzwhJSoKJXF0rClRhd0eRXzHUj2W3W8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-wKkzRli0NqmrOXoxD9T3gg-1; Thu, 03 Feb 2022 10:53:07 -0500
X-MC-Unique: wKkzRli0NqmrOXoxD9T3gg-1
Received: by mail-qv1-f71.google.com with SMTP id u15-20020a0cec8f000000b00425d89d8be0so2683179qvo.20
        for <linux-acpi@vger.kernel.org>; Thu, 03 Feb 2022 07:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ks1CIPFj2/fYzB6yS/XckTl+P/ywb94b1XuAVtGF6WU=;
        b=H9gduCkEBqhVoZ2fccVLWCQxNutSjfOiXeI8syqEW82EjepxlDBP6hCkuroagaEnBg
         EBRaCb6QJ2VHqWM6i4VKCJFTblsJWLwdss8Jnd2sy3ptM7VDx0ZS7Pkfg6nZNhAUE1pR
         4wBR6d+hrIuSsyQJ7WYVO9rOllkEKb3ky+EInG9zU3EE+XoalLxC8eRcUpyBpf2WaZLp
         Kau4p6BTwk/HlUer5/DAXN3pi2i72x4+iVe+l0HU9m9ylnceLKb5TOwgtNQCXSfS9w38
         tvOvAVeav64/3cvG4+cV0eC85CH3nwBZfxK0rz2Jf7OlaZaHcDcPgC0zyBdkuNmlQx2d
         jk9Q==
X-Gm-Message-State: AOAM533t3CbhS50wvk+ODog51nueC7lJ9opR0G8vbb9YO09kr5ED3qlf
        CaCSSMdU0/WeFEQEOSbN9fyk98UQhGftwnVKmHXYBsqUsPrmo0/88Zy5GjqewWgcpfw3aPSCitJ
        L/C+G4/yxO0k05xnPKilbvg==
X-Received: by 2002:a05:622a:1c1:: with SMTP id t1mr17403295qtw.46.1643903586970;
        Thu, 03 Feb 2022 07:53:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTD/AnASNnnYfxnrhsDHv7OxPS8utsyEbOaZ42AbsHkbmkjneV/jcDdipy3Y/MPYP1ZQpAnQ==
X-Received: by 2002:a05:622a:1c1:: with SMTP id t1mr17403279qtw.46.1643903586730;
        Thu, 03 Feb 2022 07:53:06 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id s34sm14189082qtc.88.2022.02.03.07.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 07:53:06 -0800 (PST)
From:   trix@redhat.com
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] ACPICA: cleanup double word in comment
Date:   Thu,  3 Feb 2022 07:52:57 -0800
Message-Id: <20220203155257.1849466-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'than' and 'know'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: combine two cleanups to one patch

drivers/acpi/acpica/exfldio.c | 2 +-
 drivers/acpi/acpica/hwregs.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpica/exfldio.c b/drivers/acpi/acpica/exfldio.c
index bdc7a30d1217c..b92605df3872c 100644
--- a/drivers/acpi/acpica/exfldio.c
+++ b/drivers/acpi/acpica/exfldio.c
@@ -104,7 +104,7 @@ acpi_ex_setup_region(union acpi_operand_object *obj_desc,
 #ifdef ACPI_UNDER_DEVELOPMENT
 	/*
 	 * If the Field access is any_acc, we can now compute the optimal
-	 * access (because we know know the length of the parent region)
+	 * access (because we know the length of the parent region)
 	 */
 	if (!(obj_desc->common.flags & AOPOBJ_DATA_VALID)) {
 		if (ACPI_FAILURE(status)) {
diff --git a/drivers/acpi/acpica/hwregs.c b/drivers/acpi/acpica/hwregs.c
index 69603ba52a3ac..f62d5d0242058 100644
--- a/drivers/acpi/acpica/hwregs.c
+++ b/drivers/acpi/acpica/hwregs.c
@@ -446,7 +446,7 @@ struct acpi_bit_register_info *acpi_hw_get_bit_register_info(u32 register_id)
  * RETURN:      Status
  *
  * DESCRIPTION: Write the PM1 A/B control registers. These registers are
- *              different than than the PM1 A/B status and enable registers
+ *              different than the PM1 A/B status and enable registers
  *              in that different values can be written to the A/B registers.
  *              Most notably, the SLP_TYP bits can be different, as per the
  *              values returned from the _Sx predefined methods.
-- 
2.26.3

