Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197464A371D
	for <lists+linux-acpi@lfdr.de>; Sun, 30 Jan 2022 15:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355339AbiA3O74 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 30 Jan 2022 09:59:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53224 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355351AbiA3O72 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 30 Jan 2022 09:59:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643554766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xudE8SFyweDgi30gczcfI1OPOT6rRDCIESB6EBvxvdI=;
        b=fQWMBKv3fC5tofLoWi/BjplHK/n0rN0CAOL+6kgccd0mKgHfYa5hGLoqm/g40ElsJIniTt
        Jn778NrTUpf7XzDqE9Wm8V/IGeLrMU7zWBxG8FYZptnyyRq65z4BRc1Faws/8sVRrKksTO
        6C8Cm9Bwa4KzkzQeLrluYSFsRJ8NUAY=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-XNNukYuvMkqTsVqNxP670A-1; Sun, 30 Jan 2022 09:59:24 -0500
X-MC-Unique: XNNukYuvMkqTsVqNxP670A-1
Received: by mail-qt1-f197.google.com with SMTP id h5-20020ac87765000000b002cff8751c63so8335842qtu.3
        for <linux-acpi@vger.kernel.org>; Sun, 30 Jan 2022 06:59:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xudE8SFyweDgi30gczcfI1OPOT6rRDCIESB6EBvxvdI=;
        b=qjCsW2Vhjn80vRl59NPz7LusgHagsbFyktKM5+WOGxjxrRcAVSw7aDP2m/lXPh/+zL
         inQAaLolCDgNX2/Iv84GZPq0LrDDlH7mN0BWKNyuSYehJTxW8WCttIepFmVM9k06cPP9
         Qy/3b1BpgjFIBFC1FVybCBnDUzus6HGBbKPSnKl22twvNTO7lkztbqkiHV8j7v/fQGRw
         1LsqxavdbenhB6kg/dC6GMkYgiGrFl4qpXtGNbzv+MN1hGvXIPmltSyQuWTZFgezFXZ6
         0zzAQXa23cq5lJPsmNGOzWVPq8FIPo7ElUJxjC30X/ysMpiVQj9GKtCsohUjMUTLxhGi
         qh9Q==
X-Gm-Message-State: AOAM5337UPPJIHZ2OXJ0frbgcs1KD19ZhvbwgpWDGRn+nI2/IM2olwge
        kUuOneR9TuJDxkK59RhD1OFE3uSCcRXjPd/SU50iGVx2f39ZCdDbFWJ88CHdx7hW7lSmlUuz/tg
        lkFht1cCL6CvTNtAbH8NuMA==
X-Received: by 2002:a05:622a:38c:: with SMTP id j12mr11682784qtx.336.1643554764050;
        Sun, 30 Jan 2022 06:59:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZhw5EwnviYrqCBy0aif5dSsqa62U9luVFrPneT4ZfeEcZxFYRqIU2Vgthv4/kf4s0YPIZxQ==
X-Received: by 2002:a05:622a:38c:: with SMTP id j12mr11682777qtx.336.1643554763850;
        Sun, 30 Jan 2022 06:59:23 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id bl1sm7251745qkb.16.2022.01.30.06.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:59:23 -0800 (PST)
From:   trix@redhat.com
To:     robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] ACPICA: cleanup double word in comment
Date:   Sun, 30 Jan 2022 06:59:18 -0800
Message-Id: <20220130145918.1498203-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'than'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/acpi/acpica/hwregs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

