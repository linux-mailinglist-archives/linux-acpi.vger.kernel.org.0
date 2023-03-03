Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5606A997D
	for <lists+linux-acpi@lfdr.de>; Fri,  3 Mar 2023 15:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCCOeY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 3 Mar 2023 09:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCCOeV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 3 Mar 2023 09:34:21 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606717CF2
        for <linux-acpi@vger.kernel.org>; Fri,  3 Mar 2023 06:34:05 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z11so1677676pfh.4
        for <linux-acpi@vger.kernel.org>; Fri, 03 Mar 2023 06:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677854045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79Uwb6iDaWyQVJjZrRJ473QcWA7ttMYiWdGYGLA3qE0=;
        b=K6DPnUEhwAuq3ZfNxMIvOPR4SUuvBcbDP2j+8IK7g6phQeQaBx40sRrTwGVA5hkuyF
         gYIzWVSiB+ON2Y/GuvUTmuWTEbZQHKwyQ4KChVELGR2ZT5FzPcxtF8JD4lENhVH3jOj8
         SEnz34mo0XPVbLXqUo1fl9VNQbZz461GH7YpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677854045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79Uwb6iDaWyQVJjZrRJ473QcWA7ttMYiWdGYGLA3qE0=;
        b=B1ajb1qVIW/igPODD4JEA0fqp4ACVbJYZHj43zeAN7/nxIkP7UA9xw+ZEwWonuhwyD
         uDVg4mrHWpn4VFgMNgj/sCjuBFwEhk0BGQsY8szGtl+Jx0NUgMsuD9fBDso6gyGuPTIC
         ef7pCuSKlyvfVLTPnfW8E6chrmTml2H/tIoVBVb5TKpxwHb/6H6WuUVqNt0TBbgFXoQE
         SNSJxys4CcTPMqd958eOCC+1hdmgEsz0riPUGStz5M8NER0LS44cRhL/J9CjH7lYe4rl
         lJqHkC/RWL4tqOzznuNAI2BjkXiDNnvAHrhOWtBLzXWdh6C/cUuUlAL4v4pi5M8D9S+3
         t4Ag==
X-Gm-Message-State: AO0yUKWQukMH6e0Q0DPV0vagMIJVndjvgGrUVoNT73QByslf6VJA6ia7
        ohQzd+GdndB2KJ+uTeZYLEZPIA==
X-Google-Smtp-Source: AK7set8h4+hsoLy5T3/JD6xdGPxFqv6a3VOB7IL+KpQMvfnOj+90dWvkkyB4VFJoObht4fS0rgBaOA==
X-Received: by 2002:a62:38d7:0:b0:5de:7ef1:d03a with SMTP id f206-20020a6238d7000000b005de7ef1d03amr2054923pfa.19.1677854045367;
        Fri, 03 Mar 2023 06:34:05 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:55e5:8423:31ee:83dd])
        by smtp.gmail.com with ESMTPSA id c18-20020aa781d2000000b005a8b4dcd21asm1767214pfn.15.2023.03.03.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 06:34:05 -0800 (PST)
From:   Pin-yen Lin <treapking@chromium.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc:     Xin Ji <xji@analogixsemi.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
        Pin-yen Lin <treapking@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, Marek Vasut <marex@denx.de>,
        Hsin-Yi Wang <hsinyi@chromium.org>, devicetree@vger.kernel.org,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Stephen Boyd <swboyd@chromium.org>, linux-acpi@vger.kernel.org
Subject: [PATCH v13 01/10] device property: Add remote endpoint to devcon matcher
Date:   Fri,  3 Mar 2023 22:33:41 +0800
Message-Id: <20230303143350.815623-2-treapking@chromium.org>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
In-Reply-To: <20230303143350.815623-1-treapking@chromium.org>
References: <20230303143350.815623-1-treapking@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Prashant Malani <pmalani@chromium.org>

When searching the device graph for device matches, check the
remote-endpoint itself for a match.

Some drivers register devices for individual endpoints. This allows
the matcher code to evaluate those for a match too, instead
of only looking at the remote parent devices. This is required when a
device supports two mode switches in its endpoints, so we can't simply
register the mode switch with the parent node.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>

---

Changes in v13:
- Update the kernel doc of fwnode_connection_find_match

Changes in v12:
- Check the availability of the device node in fwnode_graph_devcon_matches
- Ensured valid access to "matches" in fwnode_graph_devcon_matches
- Updated the documentation in fwnode_connection_find_match(es)
- Dropped collected tags due to the new changes

Changes in v11:
- Added missing fwnode_handle_put in drivers/base/property.c

Changes in v10:
- Collected Reviewed-by and Tested-by tags

Changes in v6:
- New in v6

 drivers/base/property.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..4426ac2b16ca 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1243,6 +1243,23 @@ static unsigned int fwnode_graph_devcon_matches(const struct fwnode_handle *fwno
 			continue;
 		}
 
+		ret = match(node, con_id, data);
+		fwnode_handle_put(node);
+		if (ret) {
+			if (matches)
+				matches[count] = ret;
+			count++;
+
+			if (matches && count >= matches_len)
+				break;
+		}
+
+		/*
+		 * Some drivers may register devices for endpoints. Check
+		 * the remote-endpoints for matches in addition to the remote
+		 * port parent.
+		 */
+		node = fwnode_graph_get_remote_endpoint(ep);
 		ret = match(node, con_id, data);
 		fwnode_handle_put(node);
 		if (ret) {
@@ -1293,8 +1310,11 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
  * @match: Function to check and convert the connection description
  *
  * Find a connection with unique identifier @con_id between @fwnode and another
- * device node. @match will be used to convert the connection description to
- * data the caller is expecting to be returned.
+ * device node. For fwnode graph connections, the graph endpoints are also
+ * checked. @match will be used to convert the connection description to data
+ * the caller is expecting to be returned.
+ *
+ * Return: The pointer to the matched node, or NULL on error.
  */
 void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
@@ -1325,9 +1345,10 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
  * @matches_len: Length of @matches
  *
  * Find up to @matches_len connections with unique identifier @con_id between
- * @fwnode and other device nodes. @match will be used to convert the
- * connection description to data the caller is expecting to be returned
- * through the @matches array.
+ * @fwnode and other device nodes. For fwnode graph connections, the graph
+ * endpoints are also checked. @match will be used to convert the connection
+ * description to data the caller is expecting to be returned through the
+ * @matches array.
  * If @matches is NULL @matches_len is ignored and the total number of resolved
  * matches is returned.
  *
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

