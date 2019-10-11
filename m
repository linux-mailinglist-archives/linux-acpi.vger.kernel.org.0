Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC69D4842
	for <lists+linux-acpi@lfdr.de>; Fri, 11 Oct 2019 21:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbfJKTPa (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 11 Oct 2019 15:15:30 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:36631 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbfJKTPa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Oct 2019 15:15:30 -0400
Received: by mail-qk1-f201.google.com with SMTP id k67so9975489qkc.3
        for <linux-acpi@vger.kernel.org>; Fri, 11 Oct 2019 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=b6OPfeDXDNnLoQEW6NHQIyUVbhLZaRHwvYyPaGn7Jx4=;
        b=h68zGj5xh+JMp5ROxPTII7AfDWeZLe+QFnK3e/ab7881KamtZ+ymQWny9QpnUGSzCN
         UxQ2QN+2lcZbZ8CCj8y9YuV9DaumY7ELPJstSm4v3Kjxh1B5b3Fs1Y2SrV3s6htG8LdT
         XWsAoMVEmzi+/gmNTTKOLRoTsUdIhmlRnfQwMqlR0R4scxGxUFD92oqBDBr7PS9z2vUx
         uFOEBXHpmdyscah3hj1NxTvGqQsT6/1rpVzVYa1GBmFPOlvlWlghrKIOvVVSsOvu/vdT
         bGhhElYb/2NdC42yhGz5UgOPFxELaCOb+5V3xYGS2lua/fyEZ3mRdetUQBuF26drHJSa
         6Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=b6OPfeDXDNnLoQEW6NHQIyUVbhLZaRHwvYyPaGn7Jx4=;
        b=as5E39h4FQj3kuX57gC4SbPHAZXkXVMC8D1XGh/GGiTnUOU0oKpC5wE5/x5ccOPrzs
         qWyytSvDiF1r9mBL5PrXVTi2/Y6z4EoGJwFQPC7aGtWMTK4frF88K1RFPM4K2UCQWNGT
         HTEtaSbx0JqSgEneNETI1KcNZkS5s5lAHeJReOKJkKrlOJbCG5zpqO78b9ko6ny1s8bp
         S80UpqIWCdYy3NivGCPfnIhdZoV764aWYM2xwTxvBEIsjx8n2FlUhlHZDD1AdGR8DB7j
         wHYf6ak6LKVl5oDwpXsbZ16pzfPlGlM3Q0A+PIFDKDZK6F6KWqNIohiej6ct6BPGBs9x
         JWlA==
X-Gm-Message-State: APjAAAUG6F/8zA5hnGZcwNxVKJbU5DJq15DOJmJpuLXx+t2NrJIn9zNL
        8UtMZJeV+KpHbFXiy6lobRSwJgVqNh8iFVs=
X-Google-Smtp-Source: APXvYqzrDB1u/6Ws76aANvtFWvjSpE4W7wK5JP6C/Mh29zv9OXM1FQmakJRl8/LsdIt9CkIdWU3Zo67haQv9IXs=
X-Received: by 2002:a0c:f9c6:: with SMTP id j6mr17688251qvo.40.1570821329024;
 Fri, 11 Oct 2019 12:15:29 -0700 (PDT)
Date:   Fri, 11 Oct 2019 12:15:19 -0700
In-Reply-To: <20191011191521.179614-1-saravanak@google.com>
Message-Id: <20191011191521.179614-2-saravanak@google.com>
Mime-Version: 1.0
References: <20191011191521.179614-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH v1 1/3] of: property: Minor code formatting/style clean ups
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Better variable and function names. Remove "," after the sentinel in an
array initialization list.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 923d6f88a99c..6f6e1d9644cf 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1147,11 +1147,11 @@ struct supplier_bindings {
 					  const char *prop_name, int index);
 };
 
-static const struct supplier_bindings bindings[] = {
+static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_clocks, },
 	{ .parse_prop = parse_interconnects, },
 	{ .parse_prop = parse_regulators, },
-	{},
+	{}
 };
 
 /**
@@ -1177,7 +1177,7 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
 			     const char *prop_name)
 {
 	struct device_node *phandle;
-	const struct supplier_bindings *s = bindings;
+	const struct supplier_bindings *s = of_supplier_bindings;
 	unsigned int i = 0;
 	bool matched = false;
 	int ret = 0;
@@ -1196,7 +1196,7 @@ static int of_link_property(struct device *dev, struct device_node *con_np,
 	return ret;
 }
 
-static int __of_link_to_suppliers(struct device *dev,
+static int of_link_to_suppliers(struct device *dev,
 				  struct device_node *con_np)
 {
 	struct device_node *child;
@@ -1208,7 +1208,7 @@ static int __of_link_to_suppliers(struct device *dev,
 			ret = -EAGAIN;
 
 	for_each_child_of_node(con_np, child)
-		if (__of_link_to_suppliers(dev, child))
+		if (of_link_to_suppliers(dev, child))
 			ret = -EAGAIN;
 
 	return ret;
@@ -1226,7 +1226,7 @@ static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
 	if (unlikely(!is_of_node(fwnode)))
 		return 0;
 
-	return __of_link_to_suppliers(dev, to_of_node(fwnode));
+	return of_link_to_suppliers(dev, to_of_node(fwnode));
 }
 
 const struct fwnode_operations of_fwnode_ops = {
-- 
2.23.0.700.g56cf767bdb-goog

