Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82496400741
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Sep 2021 23:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbhICVIM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Sep 2021 17:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbhICVIM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Sep 2021 17:08:12 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AC2C061575;
        Fri,  3 Sep 2021 14:07:11 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f2so791542ljn.1;
        Fri, 03 Sep 2021 14:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cddtKQeEc+oa7/BpvlWaBuaCGWZ/TlldrluPN2NXTtE=;
        b=Hz5EnMY9n/FQS5esgrXhtXj2TvnSb9C7/AkyzvBKcmCa6mMSBlyQNIeGuqKgLg+jHe
         UJh+vdisQrbvmeq5DEzUV4WhoNauWiZrofXOBCSL36NndP4rYYqbgw2eC85iHLObatiG
         DdQ3blMBXqrGxaneFWTTPO/RQJ/bspZ3ktgggZWyY3Ge+QkLrks5nWxE/PqgYgl2Mn3Y
         5++U2KxvTvMvl7U7hHYvLebnsHXDTfscfcjFPTYxUHM42L01/BTWXvOI+q+Ku4VuoRII
         sKBO4IyeyDg4uxARmz8velYK7rgeAPVUlI96CtviARKXkGhkTGXxuAqd4l3r+32XT2Dr
         Vbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cddtKQeEc+oa7/BpvlWaBuaCGWZ/TlldrluPN2NXTtE=;
        b=fZkkogpTqiF2VfWE2zYShIiVRGQn1e9Yoq5mjJTbq7TmZiZMSnl632zwMrW7qIKSG3
         fdXnoawCX4r1ntAlZao8HUdVocH9qtq0kvtS1uXKYmv01qAF2BKeqoBCw6cfZ894FEqa
         er8MpM8dEmkcAYPVcFrXL13v9xXpo/X/vLD2ilgPS91KAUrNKa3r3iMJv8/FIyLEpbtj
         5GpzU6OxP37KiQ8p9TmYFLTn0ehrhppbqiTZsP6PU8fykGSxw60T9DWu7QCCc3A58cz7
         LNBq53urr1FU5xACE8fdkTWN+7jss5L4JtLS811JmF8G8ujnJiV9HLtOZjmvQX62qPHM
         cgCA==
X-Gm-Message-State: AOAM533x1MfWLWj2Jh4QauGtdVYvDldIi/70d41I0rvro3dhhx76yOMS
        gpGNeQjNrCGYWmmB9JcAon0=
X-Google-Smtp-Source: ABdhPJxf5tD5w3mVT1O8fxC4O/0MzSunHKzDS8vZbgzgpR/wAYo+9b9aQkuECwqWMMBvt5kN591s5Q==
X-Received: by 2002:a2e:a726:: with SMTP id s38mr653124lje.386.1630703229754;
        Fri, 03 Sep 2021 14:07:09 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id bt29sm53136lfb.4.2021.09.03.14.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 14:07:08 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: scan: Remove unneeded header linux/nls.h
Date:   Sat,  4 Sep 2021 00:06:33 +0300
Message-Id: <20210903210633.277807-1-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Code that use linux/nls.h was moved to device_sysfs.c by commit
c2efefb33abf ("ACPI / scan: Move sysfs-related device code to a separate file")

Remove this include so that complier has easier times and it would be
easier to grep where nls code is used.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 drivers/acpi/scan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index b24513ec3fae..5b54c80b9d32 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -16,7 +16,6 @@
 #include <linux/signal.h>
 #include <linux/kthread.h>
 #include <linux/dmi.h>
-#include <linux/nls.h>
 #include <linux/dma-map-ops.h>
 #include <linux/platform_data/x86/apple.h>
 #include <linux/pgtable.h>
-- 
2.30.2

