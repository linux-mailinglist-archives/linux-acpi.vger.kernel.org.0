Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1964ACF8C
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Feb 2022 04:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346102AbiBHDRb (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Feb 2022 22:17:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346084AbiBHDR1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Feb 2022 22:17:27 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A144BC043181
        for <linux-acpi@vger.kernel.org>; Mon,  7 Feb 2022 19:17:26 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id u25-20020a4ad0d9000000b002e8d4370689so16070448oor.12
        for <linux-acpi@vger.kernel.org>; Mon, 07 Feb 2022 19:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hKVB3bLU9ggU9XnI+AMZ3/ImzjFmGTnZ5s7LsYvB5HY=;
        b=iXg+t3mv3JSzkAmVUlNVijgq9YJGHaIh3dQu0xBUekyv13sQzqbkaSGSlV3tX0CoL7
         WLk4IZglQYRlgcucpl/KfREjjFGtiITjCyn9Iau1dyVjdxD3mPE4I66oToTa1npnNtxl
         3fMPGCKE/YnsU1VyrQl6zuEJq12k/+b7yAAxaDow8pQKA1oAjHEro+VoTNt+/xw26nQw
         hIyh4p8tePEmzonuEwICzq/2c+PT9Q5CTY7kG+/Hon9afsM6pqOy32FFbOW8GisJR2h4
         9URw183zYIYMosRASAeOaTj12X40p8Qj5vao3pQU1D5jf0hs3KJb8vVoFlF6ofJkUbEO
         53+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hKVB3bLU9ggU9XnI+AMZ3/ImzjFmGTnZ5s7LsYvB5HY=;
        b=xKBVHd0zscLQ+3dyXOu368UB06EalNCFlRGsUfXl/i49AJNi2ljqLQiUODuhHMDziQ
         sF4KHooxCVnqruaVQVkAMxAbjhefKA9WR8Z4my5gCozPDDM9KTkefdOCPKqj/g4yUWpj
         zXWQ7SJ9LJk04FJckuF3aB+lu3vCFMVTkJ5y3PsqMedjVbeVSb6eRIBOruC0yUlPD0rg
         J2BfoxOCWksV2jRIBClg5JPru3UhlOR8LozPA4ggyXlPwrXx8NHmagAVAxkAcnTCTN34
         ae+QgzOmmdWlNDecqKG6mvjk2ZXZ68zwNTeEetPIQYvTfNZpFx1jg5NOO0Lzq9Ql6Lrw
         /7vA==
X-Gm-Message-State: AOAM532NNYpi9OO0LBTomJBrBm6zB5/0ga0IEnspw8wrWsCyJ6zTeJAM
        LDaoSFj31IbzBqpoYH/PCKiQew==
X-Google-Smtp-Source: ABdhPJzNXbV7SXPjsWrTumDVo6Zop43VSEbRgLTX/k6A2Bmrr/gqoq7thcv8r+rEDkX4KfjmSF+vNQ==
X-Received: by 2002:a05:6870:b1d3:: with SMTP id x19mr659151oak.101.1644290245976;
        Mon, 07 Feb 2022 19:17:25 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k3sm4763873otl.41.2022.02.07.19.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:17:25 -0800 (PST)
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
Subject: [PATCH v2 1/6] device property: Helper to match multiple connections
Date:   Mon,  7 Feb 2022 19:19:39 -0800
Message-Id: <20220208031944.3444-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220208031944.3444-1-bjorn.andersson@linaro.org>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
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

In some cases multiple connections with the same connection id
needs to be resolved from a fwnode graph.

One such example is when separate hardware is used for performing muxing
and/or orientation switching of the SuperSpeed and SBU lines in a USB-C
connector. In this case the connector needs to belong to a graph with
multiple matching remote endpoints, and the TypeC controller needs to be
able to resolve them both.

Add a new API that allows this kind of lookup.

Given that the match() callback returns an opaque reference to something
provided by the client it's not possible for the implementation to
release the returned object and as such it's not possible to handle
errors, which in turn means that it's not possible to query the number
of elements or dynamically grow the results array. It's however expected
that the number of matches will be reasonably low and that the worst
case is known by the caller before hand.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Iterator in fwnode_devcon_matches() is now unsigned.
- fwnode_handle_put() node for unavailable nodes.
- Extended commit message on the subject of supporting dynamically sized
  "matches" array.

 drivers/base/property.c  | 96 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  5 +++
 2 files changed, 101 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index e6497f6877ee..5230ff5c8d48 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1189,6 +1189,38 @@ fwnode_graph_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static unsigned int fwnode_graph_devcon_matches(struct fwnode_handle *fwnode,
+						const char *con_id, void *data,
+						devcon_match_fn_t match,
+						void **matches,
+						unsigned int matches_len)
+{
+	struct fwnode_handle *node;
+	struct fwnode_handle *ep;
+	unsigned int count = 0;
+	void *ret;
+
+	fwnode_graph_for_each_endpoint(fwnode, ep) {
+		if (count >= matches_len) {
+			fwnode_handle_put(ep);
+			return count;
+		}
+
+		node = fwnode_graph_get_remote_port_parent(ep);
+		if (!fwnode_device_is_available(node)) {
+			fwnode_handle_put(node);
+			continue;
+		}
+
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+
+		if (ret)
+			matches[count++] = ret;
+	}
+	return count;
+}
+
 static void *
 fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 		    void *data, devcon_match_fn_t match)
@@ -1211,6 +1243,35 @@ fwnode_devcon_match(struct fwnode_handle *fwnode, const char *con_id,
 	return NULL;
 }
 
+static unsigned int fwnode_devcon_matches(struct fwnode_handle *fwnode,
+					  const char *con_id, void *data,
+					  devcon_match_fn_t match,
+					  void **matches,
+					  unsigned int matches_len)
+{
+	struct fwnode_handle *node;
+	unsigned int count = 0;
+	unsigned int i;
+	void *ret;
+
+	for (i = 0; ; i++) {
+		if (count >= matches_len)
+			return count;
+
+		node = fwnode_find_reference(fwnode, con_id, i);
+		if (IS_ERR(node))
+			break;
+
+		ret = match(node, NULL, data);
+		fwnode_handle_put(node);
+
+		if (ret)
+			matches[count++] = ret;
+	}
+
+	return count;
+}
+
 /**
  * fwnode_connection_find_match - Find connection from a device node
  * @fwnode: Device node with the connection
@@ -1238,3 +1299,38 @@ void *fwnode_connection_find_match(struct fwnode_handle *fwnode,
 	return fwnode_devcon_match(fwnode, con_id, data, match);
 }
 EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
+
+/**
+ * fwnode_connection_find_matches - Find connections from a device node
+ * @fwnode: Device node with the connection
+ * @con_id: Identifier for the connection
+ * @data: Data for the match function
+ * @match: Function to check and convert the connection description
+ * @matches: Array of pointers to fill with matches
+ * @matches_len: Length of @matches
+ *
+ * Find up to @matches_len connections with unique identifier @con_id between
+ * @fwnode and other device nodes. @match will be used to convert the
+ * connection description to data the caller is expecting to be returned
+ * through the @matches array.
+ *
+ * Return: Number of matches resolved, of negative errno.
+ */
+int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match,
+				   void **matches, unsigned int matches_len)
+{
+	unsigned int count;
+
+	if (!fwnode || !match || !matches)
+		return -EINVAL;
+
+	count = fwnode_graph_devcon_matches(fwnode, con_id, data, match,
+					    matches, matches_len);
+
+	return count + fwnode_devcon_matches(fwnode, con_id, data, match,
+					     matches + count,
+					     matches_len - count);
+}
+EXPORT_SYMBOL_GPL(fwnode_connection_find_matches);
diff --git a/include/linux/property.h b/include/linux/property.h
index 7399a0b45f98..aa7ef9d06ebe 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -446,6 +446,11 @@ static inline void *device_connection_find_match(struct device *dev,
 	return fwnode_connection_find_match(dev_fwnode(dev), con_id, data, match);
 }
 
+int fwnode_connection_find_matches(struct fwnode_handle *fwnode,
+				   const char *con_id, void *data,
+				   devcon_match_fn_t match,
+				   void **matches, unsigned int matches_len);
+
 /* -------------------------------------------------------------------------- */
 /* Software fwnode support - when HW description is incomplete or missing */
 
-- 
2.33.1

