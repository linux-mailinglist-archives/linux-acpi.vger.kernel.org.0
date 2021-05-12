Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E3537EE88
	for <lists+linux-acpi@lfdr.de>; Thu, 13 May 2021 00:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239841AbhELVwJ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 12 May 2021 17:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388846AbhELUqB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 12 May 2021 16:46:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CEBC06138B
        for <linux-acpi@vger.kernel.org>; Wed, 12 May 2021 13:44:48 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id b11-20020a7bc24b0000b0290148da0694ffso370311wmj.2
        for <linux-acpi@vger.kernel.org>; Wed, 12 May 2021 13:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=+yb83sAXPzhXv25RIUQaT67tLnlk20Moze94tCtifKk=;
        b=eMh1fBXPQjpGJvFgUR5akHtI87x67BrY2ZkN37Dto4dJPLHAC+BtqYVZhjkJJJCW1/
         pwcMbuNVv4qzj52mSxzTln2pakSbAqFd4m/ULBzTiMCij+Qv2bXB8TFMvM2JaTdHXolD
         eQTRSKKmirhn0G/C/uI15AZtetbZ2F3hcuKfR9M1Lv1pmrYbuuvAvD6BJkuTO8rCBnNB
         PmBlA/fPw0jVYPk54zVO51XkilxPhNuDenlqbkUKIr+/pueQuOaxbq3BH8aKQ5EeylGO
         lT0iFU1b0ihIhHcuDKk/9pK8beYNsPCQDGU2sn05TUSJGCON7ziaVs54KAWnnqDqiDI1
         QW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=+yb83sAXPzhXv25RIUQaT67tLnlk20Moze94tCtifKk=;
        b=nXg3XnxCfN16SZWrOKhAvKjSbA3mMx1V71u1AycvkirYBncns81Ngum47J+qL6zTfo
         B5i9sHoijpiL0mgDda1sZSF1WBqlaJPIZbNiynJVGjnY3SG71rUPO62+GWYBtHqfIq2k
         JN/Me3Ji203NOM5rvVF33ov2pcQvcoTlB1eY+wLP8UaVHf9Ny9ffRZFU1HQsp47Owi27
         NfYN5L2hg49b/BUnlvV2WNGJp5pg8tP5+tv9Facduvxyku6wWl6/F/pux8WESQ7+5Odc
         N35KHmL2+EP0MZtIIU0AWNNvnt2ib0ekAV38tsqtvuKD6WjYCsxIBmKb9JD+vo4AVXhD
         6Jqg==
X-Gm-Message-State: AOAM533aJ+lFVybedG1uUFRWsIwQGHDPU5ySg8wvtHWi3Bnn+hc0Tbd9
        ddSvNgaz/RvnJyyO+E/y9sZA6XSciXvhSw==
X-Google-Smtp-Source: ABdhPJzEmKM/SZfw422Sj09XE5dODp8Hmo9spKydIupG++DZUnTEl/8LgD89htCwUb4m9cRSH2Ypig==
X-Received: by 2002:a05:600c:4eca:: with SMTP id g10mr303541wmq.180.1620852287346;
        Wed, 12 May 2021 13:44:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f38:4600:acaa:d921:6cbb:e380? (p200300ea8f384600acaad9216cbbe380.dip0.t-ipconnect.de. [2003:ea:8f38:4600:acaa:d921:6cbb:e380])
        by smtp.googlemail.com with ESMTPSA id g19sm587780wme.48.2021.05.12.13.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 13:44:47 -0700 (PDT)
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     linux-acpi@vger.kernel.org
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] pnp: Switch to dev_dbg
Message-ID: <31c6013e-1acd-4d2f-f0d6-baec208ff292@gmail.com>
Date:   Wed, 12 May 2021 22:44:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Debug output in dmesg log may confuse users. Therefore let's restrict
debug output to cases where DEBUG is defined or dynamic debug output
is enabled for the respective code piece.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/pnp/core.c     | 5 ++---
 drivers/pnp/resource.c | 2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/pnp/core.c b/drivers/pnp/core.c
index ccdfbf397..4df5aa6a3 100644
--- a/drivers/pnp/core.c
+++ b/drivers/pnp/core.c
@@ -215,9 +215,8 @@ int pnp_add_device(struct pnp_dev *dev)
 	for (id = dev->id; id; id = id->next)
 		len += scnprintf(buf + len, sizeof(buf) - len, " %s", id->id);
 
-	dev_printk(KERN_DEBUG, &dev->dev, "%s device, IDs%s (%s)\n",
-		   dev->protocol->name, buf,
-		   dev->active ? "active" : "disabled");
+	dev_dbg(&dev->dev, "%s device, IDs%s (%s)\n", dev->protocol->name, buf,
+		dev->active ? "active" : "disabled");
 	return 0;
 }
 
diff --git a/drivers/pnp/resource.c b/drivers/pnp/resource.c
index 70d4ba957..2fa0f7d55 100644
--- a/drivers/pnp/resource.c
+++ b/drivers/pnp/resource.c
@@ -540,7 +540,7 @@ struct pnp_resource *pnp_add_irq_resource(struct pnp_dev *dev, int irq,
 	res->start = irq;
 	res->end = irq;
 
-	dev_printk(KERN_DEBUG, &dev->dev, "%pR\n", res);
+	dev_dbg(&dev->dev, "%pR\n", res);
 	return pnp_res;
 }
 
-- 
2.31.1

