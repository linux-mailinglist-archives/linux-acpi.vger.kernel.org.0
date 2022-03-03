Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B734CC8EF
	for <lists+linux-acpi@lfdr.de>; Thu,  3 Mar 2022 23:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiCCWcv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 3 Mar 2022 17:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236927AbiCCWct (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Mar 2022 17:32:49 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B2614FFF2
        for <linux-acpi@vger.kernel.org>; Thu,  3 Mar 2022 14:32:03 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id j2so6196440oie.7
        for <linux-acpi@vger.kernel.org>; Thu, 03 Mar 2022 14:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X9JV+NV8hUdIRYanc1M81YurPWGieX1bhPcntTov4JQ=;
        b=c1kUcex8F+vJCxoKxNHDMtjxEQfmTnbQbbD1n1WPDnHEF5FnFi6Q6xhiU0gtNrvDiI
         GJyfnMZNzfhDVGA5cPVtOifgfe31tg08XGCP2javdtE8eVgWj60JNpHOJv2WdlF5zLUa
         9IwTDPSFZFE+SGnsy9+6To5tSpMrL1H1WigpRs7PSlvcrzOKA6XElrjabd2r7ZYAtsFC
         pipuhGugBLIaVg5bronMYFQFdLQtv58iTT6FmZt6V6mdCuA+QgxUfkeFzJvpsglW9RFG
         fJ4jvodZfR69AcC8iCiAvH0zUVoBvCkWxxJ1IlVBCRqrjIcL72jxaZf7gTDk6O03Rx/S
         iVqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X9JV+NV8hUdIRYanc1M81YurPWGieX1bhPcntTov4JQ=;
        b=F32bdBThmix/853aApvB5iJg3YGERbH38zusHyVKxIsP6EFEuIZU3xfKu+2O9KlYO6
         O46uWav95ymO3mF0oHazKGgziux6CrAJLYXYE8IfBT0nESDgcVwjwZWZO7qwzjlTeNnd
         0iKExwp0HTFxovaX0cDndmhywGaF4czHRoLxfo/wbH+u1MeVZ9VZx9uqef0f1RwzqUVG
         tXw+o9jWLWxdYSb9FKiePazPtohMPP/ca//YH6JPYdEey5415ZewCiZTeyAQt29S7BNk
         W8e5sNUDrZiQWLayrC4HNIJ/ScJQoqcxRm4DxiRYB7maWAAj+q8OgfiUFNE8cnbXG+2M
         AgaQ==
X-Gm-Message-State: AOAM532DX5dqSaZZaFDNSKjOJ6I+LAnbh57lIvReeM4QpH1mJqrdtNiW
        HoveKerwhsXCVAREX1/fvR2LHw==
X-Google-Smtp-Source: ABdhPJzL3GC3wuYi5UpGljLYoJiWtR+9mxBdEmFbSxDUE6Mf39bmn8ivY5qiDQNoaV8V2Rgdux3Xfw==
X-Received: by 2002:a05:6808:2022:b0:2d4:752b:dfb5 with SMTP id q34-20020a056808202200b002d4752bdfb5mr6712133oiw.174.1646346722312;
        Thu, 03 Mar 2022 14:32:02 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id fq14-20020a0568710b0e00b000d4492531a2sm1764777oab.17.2022.03.03.14.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:32:01 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v3 2/6] device property: Use multi-connection matchers for single case
Date:   Thu,  3 Mar 2022 14:33:47 -0800
Message-Id: <20220303223351.141238-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220303223351.141238-1-bjorn.andersson@linaro.org>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

The newly introduced helpers for searching for matches in the case of
multiple connections can be resused by the single-connection case, so do
this to save some duplication.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

Changes since v1:
- None

 drivers/base/property.c | 55 ++++-------------------------------------
 1 file changed, 5 insertions(+), 50 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 5cda205136f6..81156dc97ad7 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1193,31 +1193,6 @@ const void *device_get_match_data(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(device_get_match_data);
 
-static void *
-fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-			  void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	struct fwnode_handle *ep;
-	void *ret;
-
-	fwnode_graph_for_each_endpoint(fwnode, ep) {
-		node = fwnode_graph_get_remote_port_parent(ep);
-		if (!fwnode_device_is_available(node)) {
-			fwnode_handle_put(node);
-			continue;
-		}
-
-		ret = match(node, con_id, data);
-		fwnode_handle_put(node);
-		if (ret) {
-			fwnode_handle_put(ep);
-			return ret;
-		}
-	}
-	return NULL;
-}
-
 static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 						const char *con_id, void *data,
 						devcon_match_fn_t match,
@@ -1252,28 +1227,6 @@ static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
 	return count;
 }
 
-static void *
-fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
-		    void *data, devcon_match_fn_t match)
-{
-	struct fwnode_handle *node;
-	void *ret;
-	int i;
-
-	for (i = 0; ; i++) {
-		node = fwnode_find_reference(fwnode, con_id, i);
-		if (IS_ERR(node))
-			break;
-
-		ret = match(node, NULL, data);
-		fwnode_handle_put(node);
-		if (ret)
-			return ret;
-	}
-
-	return NULL;
-}
-
 static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
 					  const char *con_id, void *data,
 					  devcon_match_fn_t match,
@@ -1320,16 +1273,18 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
 				   devcon_match_fn_t match)
 {
+	unsigned int count;
 	void *ret;
 
 	if (!fwnode || !match)
 		return NULL;
 
-	ret = fwnode_graph_devcon_match(fwnode, con_id, data, match);
-	if (ret)
+	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match, &ret, 1);
+	if (count)
 		return ret;
 
-	return fwnode_devcon_match(fwnode, con_id, data, match);
+	count = fwnode_devcon_matches(fwnode, con_id, data, match, &ret, 1);
+	return count ? ret : NULL;
 }
 EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
 
-- 
2.33.1

