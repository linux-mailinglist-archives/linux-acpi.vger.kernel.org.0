Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609F6BFF08
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Mar 2023 03:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjCSCMU (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 18 Mar 2023 22:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCSCMT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 18 Mar 2023 22:12:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF4C1CF5D
        for <linux-acpi@vger.kernel.org>; Sat, 18 Mar 2023 19:12:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eg48so34238468edb.13
        for <linux-acpi@vger.kernel.org>; Sat, 18 Mar 2023 19:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679191936;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GXkYcxtWGmwPECKilkYLw0ANEYfSD0wpvJZycpobCR4=;
        b=hhJKBNpavJUiOpFyNNavhif8fOBPoI3N8Rk7ER+vkzEGXGQqqvxP/409AvqEGu+R2z
         7ZOh4/rByS8LEIlaX0L1uOvOi/ILZsYJRmi01pj6XUZlvMI+ufAtIfEuzDd4v4S86rZt
         50N/AJt0nHJV0UHPk8tP8A9QBDkkKCyqBhyMh/LiygGiNaLBPKSZXylwVUMFZgsu8GC/
         Z2245Yfc9vlwBCyYAoprJBK/F5lhAGNx4aAOnrL4uK1EQ4fhDu2+xf9ItoGWqvdcm4Po
         EaB9sfP3Zvt/Ex5QLEhpK6ar7be27jwVYyaIs3nEqyMEHmO/x9lBxaAUx63zZH76VFPN
         QhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679191936;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GXkYcxtWGmwPECKilkYLw0ANEYfSD0wpvJZycpobCR4=;
        b=nfYEANvKLh9oVtJc82DY3T4s7c7+m+0VWd0liKSG1wIuwLKvFvArd0L/pbgtI449DO
         ubZ/t8L0HS7v6VvnhjQogBP/oqx4LKbK7Ocr+0nCiDy/IfRj/zxcg9OgIz3dqepB+hQr
         uzWR3sS+W89XUEf9u3ny9F+XOd189b382M5de4PqhAFsR0ZMHSjrKKOewEoaeEPxZD/0
         FJpIb5EcTI4PG/zrLlIZOKEUfFVDam0+dCRb8SllR1YUVnPjES6+37KpaXH58XXr0ilk
         RMXlKaMDH63YWNkbIbHQ0Rl6FN7E0i0aMZ6bPWV4RNT29ZVPLXWEPGEwFHeh4y8U7UPA
         lrPA==
X-Gm-Message-State: AO0yUKXPrG+WCwO6SwBJ5ujlkGWBOk1CMyihOMDWn7Ypq1ZR2fKf57o1
        3zHjMowYYdhJWQhblX8/R+dZBH642BjoNvic0He2Iy3A1Qc=
X-Google-Smtp-Source: AK7set8rRW5URFXj5t33IK0pW5Tgl6VUPAyWoEApH2Ysvvd5ptqkoPh+JknAIMWfkJGgX6nsLQX24ipVvGXiUm0EFtw=
X-Received: by 2002:a17:906:8a75:b0:930:4944:c2c with SMTP id
 hy21-20020a1709068a7500b0093049440c2cmr1966075ejc.12.1679191936547; Sat, 18
 Mar 2023 19:12:16 -0700 (PDT)
MIME-Version: 1.0
From:   obiwac <obiwac@gmail.com>
Date:   Sun, 19 Mar 2023 03:12:05 +0100
Message-ID: <CAN8-kNUhnWxLoAGF7tXsknxRKztNT_fSBUgULLhDyyp4388yBg@mail.gmail.com>
Subject: [PATCH] ACPI: resource: Add Medion S17413 to IRQ override quirk
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add DMI info of the Medion S17413 (board M1xA) to the IRQ override
quirk table. This fixes the keyboard not working on these laptops.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213031
Signed-off-by: Aymeric Wibo <obiwac@gmail.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index 192d1784e..9e1ab01d4 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -400,6 +400,13 @@ static const struct dmi_system_id medion_laptop[] = {
                        DMI_MATCH(DMI_BOARD_NAME, "M17T"),
                },
        },
+       {
+               .ident = "MEDION S17413",
+               .matches = {
+                       DMI_MATCH(DMI_SYS_VENDOR, "MEDION"),
+                       DMI_MATCH(DMI_BOARD_NAME, "M1xA"),
+               },
+       },
        { }
 };

--
2.25.1
