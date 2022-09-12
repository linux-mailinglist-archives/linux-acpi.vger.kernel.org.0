Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D25B637C
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Sep 2022 00:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiILWPj (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Sep 2022 18:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiILWOj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Sep 2022 18:14:39 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6019A4E60B
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:02 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id c4so8164701iof.3
        for <linux-acpi@vger.kernel.org>; Mon, 12 Sep 2022 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X10ZOpUm34bcLHNR+SSjFuTiJAOsk7eGIkt+pMI+EVk=;
        b=iQDMilzFGaxTLDDecInVMy6YtjVTJbeJhgq9z+sXXKjsHasxCy0ptsc98o7SCdOrgX
         z8eyVcJd6lslHNzzaX1SdH1oR+E/rZS0/cuwWSGf/P6m9CmJBLhT+a5h+/Y+yGBxK9nn
         wDEO20Ux4b4pSFsKD4pSBhtW0q6fAxHIbhx0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X10ZOpUm34bcLHNR+SSjFuTiJAOsk7eGIkt+pMI+EVk=;
        b=2TExadoLpAH17FGrwM0Rqe3AAaG2O7f8wSws+MhUbrqsYKjfn42A0HNTpUxm+14p0e
         UqSa3d2uUqROpn2wpKq3Rpsyr1ipSug88AZ9NR2NyTBP6B7xcUlqA4/hsHgBIJIaznfW
         vLiz7j5Tln0zHSAiaupPAfiLXtLGb3NHlDy5QDFdRaxh0GjFA2tlrAy3IyfRhUaVF1T5
         s9yfU/FJ3NN4c3/3CNCvRDX64ZW3HnNrVr0aqldo7UTSvFoVeLByiLc4ZnLLY965zj4U
         Uqv+uS3FqJ9zF13Oc79EQn0YhT/4LmDM8sKVMyU7RQRr55YQ+ZjxKE/ONMWYCveyscTc
         8nuA==
X-Gm-Message-State: ACgBeo3k/oAGeO6ovvUIqgQFH3MQQpeQkESbotIzYsBBcv9L7kVAQnYk
        I/vvn9fEspxRAxJjqMqFkbJGfUSiXP5PRs60
X-Google-Smtp-Source: AA6agR5EdyngmDDo1PQcIh/wfbW2LgKdIs7tu0cBhqj1OYu63YLhTTkV9jWySTvU8ptF6rRmRz3lqg==
X-Received: by 2002:a02:bb98:0:b0:35a:29a:4ce9 with SMTP id g24-20020a02bb98000000b0035a029a4ce9mr8445774jan.21.1663020840899;
        Mon, 12 Sep 2022 15:14:00 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id 18-20020a056e020cb200b002f16e7021f6sm4077334ilg.22.2022.09.12.15.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 15:14:00 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jingle.wu@emc.com.tw,
        mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Raul E Rangel <rrangel@chromium.org>,
        Angela Czubak <acz@semihalf.com>,
        Bartosz Szczepanek <bsz@semihalf.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/13] HID: i2c-hid: Don't set wake_capable and wake_irq
Date:   Mon, 12 Sep 2022 16:13:14 -0600
Message-Id: <20220912160931.v2.10.Id22d056440953134d8e8fe2c2aff79c79bc78424@changeid>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220912221317.2775651-1-rrangel@chromium.org>
References: <20220912221317.2775651-1-rrangel@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The i2c-core will now handle setting the wake_irq for DT and ACPI
systems.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
---

(no changes since v1)

 drivers/hid/i2c-hid/i2c-hid-core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 57214549460043..65b7a95956866d 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -1036,15 +1036,6 @@ int i2c_hid_core_probe(struct i2c_client *client, struct i2chid_ops *ops,
 	if (ret < 0)
 		goto err_powered;
 
-	/*
-	 * The wake IRQ should be declared via device tree instead of assuming
-	 * the IRQ can wake the system. This is here for legacy reasons and
-	 * will be removed once the i2c-core supports querying ACPI for wake
-	 * capabilities.
-	 */
-	if (!dev->power.wakeirq)
-		dev_pm_set_wake_irq(&client->dev, client->irq);
-
 	hid = hid_allocate_device();
 	if (IS_ERR(hid)) {
 		ret = PTR_ERR(hid);
-- 
2.37.2.789.g6183377224-goog

