Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED5E69DD3A
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Feb 2023 10:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233101AbjBUJvZ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 21 Feb 2023 04:51:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbjBUJvY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2023 04:51:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BEF25976
        for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2023 01:51:21 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id m3-20020a17090ade0300b00229eec90a7fso2905554pjv.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2023 01:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3KVvr6CBOsukm7QoJ3t3HwaEh2lnWSzyPLaHhlGQIk=;
        b=Rr81Ut/AQH0LZe4PgWaEb89DCQff3q86b3BiQmmydmI5Pq7aEfKDvNWV28DWf/3phO
         +S6Lm9ioFQVG+VBdw/FMdA2m9PylTNJbId/dzChgykfHQqwmIzReJw8tFzwV1qj5rTwG
         PevUH9jG5hxxo2A0y6+eibDIHX3IEdbdDwjvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3KVvr6CBOsukm7QoJ3t3HwaEh2lnWSzyPLaHhlGQIk=;
        b=CPaOO4jAIZOmW8HqA1wkJqp4v6tVQAlD5KppEKlFgzSljHiuNhdGYrybx5g0+MGpQS
         rVvLihn/gTk2TiboDk+U6qw0XfOPXBQxDwOHcV0tub6L6bP/yNZUU86DBgxoFfDN/hxa
         bxZTs+pgMqlpctWm37HQ8tKDNlvAEXDYXFrRcdjuyijrxwgg+imAeYOWMIk28rhUmSWJ
         Nn0rqeHkOFKUCXh4RU23tnK9vwvi8uHjxW5Mx7poDiNTqfaWqIQFYRaXcK74cryUQFv7
         d3Yr9vmp8710RzljhTrVFJwTTZd8cMH36rjiAGOmfvMu8sHqN+WPxqqManWm6FmzzHvk
         GnWQ==
X-Gm-Message-State: AO0yUKU4rJgYKPpTW9y/4nsWX/CfCyi7voCLXgayWib7TBqrAiTw97nF
        6WMNc5k6YyL51ievkZkAsJjV0A==
X-Google-Smtp-Source: AK7set8C/GcjydRikSISK50LA8riJfkgFwGZ1c/IgGU06aXsBoeqj0oCVY97o9dvBqRRHjkEPO08yQ==
X-Received: by 2002:a05:6a20:3c9e:b0:cb:2c7e:b673 with SMTP id b30-20020a056a203c9e00b000cb2c7eb673mr5752526pzj.37.1676973080760;
        Tue, 21 Feb 2023 01:51:20 -0800 (PST)
Received: from treapking.tpe.corp.google.com ([2401:fa00:1:10:a1f5:f58d:584e:5906])
        by smtp.gmail.com with ESMTPSA id t25-20020a656099000000b004eca54eab50sm3524918pgu.28.2023.02.21.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 01:51:20 -0800 (PST)
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
Cc:     Pin-yen Lin <treapking@chromium.org>, linux-kernel@vger.kernel.org,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Marek Vasut <marex@denx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, Xin Ji <xji@analogixsemi.com>,
        Lyude Paul <lyude@redhat.com>,
        Allen Chen <allen.chen@ite.com.tw>, devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, chrome-platform@lists.linux.dev,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-acpi@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: [PATCH v12 01/10] device property: Add remote endpoint to devcon matcher
Date:   Tue, 21 Feb 2023 17:50:45 +0800
Message-Id: <20230221095054.1868277-2-treapking@chromium.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
In-Reply-To: <20230221095054.1868277-1-treapking@chromium.org>
References: <20230221095054.1868277-1-treapking@chromium.org>
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

 drivers/base/property.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 083a95791d3b..45f7f40eb5fa 100644
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
@@ -1293,8 +1310,9 @@ static unsigned int fwnode_devcon_matches(const struct fwnode_handle *fwnode,
  * @match: Function to check and convert the connection description
  *
  * Find a connection with unique identifier @con_id between @fwnode and another
- * device node. @match will be used to convert the connection description to
- * data the caller is expecting to be returned.
+ * device node. For fwnode graph connections, the graph endpoints are also
+ * checked. @match will be used to convert the connection description to data
+ * the caller is expecting to be returned.
  */
 void *fwnode_connection_find_match(const struct fwnode_handle *fwnode,
 				   const char *con_id, void *data,
@@ -1325,9 +1343,10 @@ EXPORT_SYMBOL_GPL(fwnode_connection_find_match);
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
2.39.2.637.g21b0678d19-goog

