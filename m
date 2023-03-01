Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E51C6A765C
	for <lists+linux-acpi@lfdr.de>; Wed,  1 Mar 2023 22:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjCAVuL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Mar 2023 16:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCAVuK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2023 16:50:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01AC41B5F
        for <linux-acpi@vger.kernel.org>; Wed,  1 Mar 2023 13:50:01 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so294322237b3.19
        for <linux-acpi@vger.kernel.org>; Wed, 01 Mar 2023 13:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677707401;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxQv5waFu3xv0IisW1bjLsRrEXTjdfJSWFhFeoxtPOI=;
        b=N0u2emcPqt+w7HnP6S48oXIFPSC90k8hPUi9FBqczZs2DLe8JGmBZf1tTzSI/9AJH9
         R3FeC2qBR0N/gzkaEhSFWOlLBGf99HsTk0r1gK3GpRCXRnpK5SiC0Yx225WQheq0SlzC
         gEYBGiYbZvVIaQntfs/IHBIlqcngYC0LYQFg5yIub0ACOUKSxh6/QjCCsPBWToMY8k2i
         OJ6IoUK5EckhAroQDcpi60bjmLR6gu2GB7HtnbPBOScP7J08EmqazMAPZfvRnAnp3bjp
         H0Bn3xnSH5bFiIwDSIR4cc5jzdqq4WJY3DUuQ7FpLxhP0MHcVbnjLTKsr9NYP2cE3X42
         2Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677707401;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxQv5waFu3xv0IisW1bjLsRrEXTjdfJSWFhFeoxtPOI=;
        b=Q3yhwCk8iNIiqD0ZksBNIU1/lKuvwNzcfpG0fpR+/MDQTZTgb962ZWohDNNSGeDnUd
         nJxvZEm4a4ebRQGb9PpRbcbTZxlG7BhtK/1ZXPNnrPCEFy9MH+CE3QfVCx9g6ckBgON0
         rrqiGJRHIL02H8/H+3efun2lnAL3lOAB4BIEPfmO3nr6/dG4nNxbfsy/jJUZzvH7Qe83
         c2FzixayQJP4Jz7jOWCuq7UYUzdoc+HOCaWa/fJ4pE/ZIe7lvImW6WEXw5OrNsULrafv
         uhTyfRu1bgsc2nj/SUWT502iGuDbdSd2bKGoj8ysJXfgXu2x+ACayjqb1n/i4E6YOLe3
         QflA==
X-Gm-Message-State: AO0yUKXWHor7GjgtQviTqBJK76gTTKCGiARtJJ1QRKkq9UgOZ/a8q0he
        czIGFOtRFSqfc6NheXXH1+EsJjjnpZZhPNo=
X-Google-Smtp-Source: AK7set/xyvoFhdWMtePqqoxkiFKJ9A1bLedjGccifdYq3F7anLkOM2Yz4H0fTroMYl9LFY2P1BNgvnKva6FUsqQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:debf:1aed:5c45:c92])
 (user=saravanak job=sendgmr) by 2002:a81:86c2:0:b0:536:e8b5:e7a5 with SMTP id
 w185-20020a8186c2000000b00536e8b5e7a5mr22ywf.239.1677707400820; Wed, 01 Mar
 2023 13:50:00 -0800 (PST)
Date:   Wed,  1 Mar 2023 13:49:49 -0800
In-Reply-To: <20230301214952.2190757-1-saravanak@google.com>
Message-Id: <20230301214952.2190757-3-saravanak@google.com>
Mime-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Subject: [PATCH v1 2/4] usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

After recent changes to fw_devlink that ended with commit 4a032827daa8
("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
cares about the "compatible" property and figures out the correct struct
device at runtime. So, we no longer need to call
fw_devlink_purge_absent_suppliers().

Signed-off-by: Saravana Kannan <saravanak@google.com>
Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 drivers/usb/typec/tipd/core.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 485b90c13078..92401622bc4e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -764,16 +764,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret < 0)
 		goto err_clear_mask;
 
-	/*
-	 * This fwnode has a "compatible" property, but is never populated as a
-	 * struct device. Instead we simply parse it to read the properties.
-	 * This breaks fw_devlink=on. To maintain backward compatibility
-	 * with existing DT files, we work around this by deleting any
-	 * fwnode_links to/from this fwnode.
-	 */
 	fwnode = device_get_named_child_node(&client->dev, "connector");
-	if (fwnode)
-		fw_devlink_purge_absent_suppliers(fwnode);
 
 	tps->role_sw = fwnode_usb_role_switch_get(fwnode);
 	if (IS_ERR(tps->role_sw)) {
-- 
2.39.2.722.g9855ee24e9-goog

