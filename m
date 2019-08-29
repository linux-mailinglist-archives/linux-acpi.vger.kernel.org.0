Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F753A12E0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2019 09:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbfH2Hq0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 29 Aug 2019 03:46:26 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:51616 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbfH2HqZ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Aug 2019 03:46:25 -0400
Received: by mail-pf1-f201.google.com with SMTP id v134so1832103pfc.18
        for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2019 00:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2WQfeka9QBJ0u6SuW6w6DrBJqjwEt58/QtmjRSQZxGs=;
        b=Uawm/Ct9U0N5DQ5wL+c4cXY7A15ODdjLSpWbtecf7+bVuGrvVT8yhcn0nHza1nYE22
         nlfeGgnpm7skSgEmECryCHA+Qkf+BLESDY0MmQ1S05nkBC2F9qXVejgFxY3hdmY01WFP
         ZBJHWOt2BU0KO1KxZBdrVp+dViuWjW1grr7wNcw8+PvOHYH6O2NhMtIK8HAfYno4cUxv
         3+dL8MMGXmiWrBEzFvEAcBKU5KC9riYNb4/pXhvajgW8wWve63HI3peOzrJepZONSDpj
         1LDrxdoOMPTFGJo52Ki1v510UgLOMSrNcm4QS8N0lhbixIwWYCkmw+nLbw3oZ8NAcXXF
         r14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2WQfeka9QBJ0u6SuW6w6DrBJqjwEt58/QtmjRSQZxGs=;
        b=ktNp8ZJw4pbmYhoQ0ty6RezftsBUwMq/xbwfSIU8mcFCSKFhagykv7o3DIoRJNJuLV
         spuHcyZSjEfvp/rYAjETDRp+IotkstLiaXpCI7tKrqDM6WXy31i3Xe7+/SiDPjpcPnWx
         nyvlBu95t9kw9ssGwK5kkei0DCDjJvWs6B5rO8mwichziHFrSC7oR6R+RmunM97xehV0
         h99e6gRL2TOb4LqzExZ9By3qkhMs4kfSAWViNzQyOvLvKhp1c8+w8xmoy7L/HGsIqr7y
         B7i5cTXLMTM7y9mUaPF+Gppvx7pPLXCJeQDPwKXe8Wgd0RPMyl10YsKvsKgCvDjYixuk
         7M9A==
X-Gm-Message-State: APjAAAV4EwhbxoEzM8VPQBME0xZQ7RqB56kOAv3HhDoy6M8DgFd2/cPT
        Dufm3AFxtPb19Mqlh3vWgArOCSIF0OLwkpI=
X-Google-Smtp-Source: APXvYqwZzrFjjrO3w9B/Hx1N3gqqdyIyM5Foq9bn18J8PpxtA1ZufCbOQOb/BhQ1ntceTWa9Kc3liGPAH+ydJyM=
X-Received: by 2002:a65:52c5:: with SMTP id z5mr7120687pgp.118.1567064784480;
 Thu, 29 Aug 2019 00:46:24 -0700 (PDT)
Date:   Thu, 29 Aug 2019 00:46:01 -0700
In-Reply-To: <20190829074603.70424-1-saravanak@google.com>
Message-Id: <20190829074603.70424-6-saravanak@google.com>
Mime-Version: 1.0
References: <20190829074603.70424-1-saravanak@google.com>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
Subject: [PATCH v10 5/7] of: property: Create device links for all
 child-supplier depencencies
From:   Saravana Kannan <saravanak@google.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org, clang-built-linux@googlegroups.com,
        David Collins <collinsd@codeaurora.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

A parent device can have child devices that it adds when it probes. But
this probing of the parent device can happen way after kernel init is done
-- for example, when the parent device's driver is loaded as a module.

In such cases, if the child devices depend on a supplier in the system, we
need to make sure the supplier gets the sync_state() callback only after
these child devices are added and probed.

To achieve this, when creating device links for a device by looking at its
DT node, don't just look at DT references at the top node level. Look at DT
references in all the descendant nodes too and create device links from the
ancestor device to all these supplier devices.

This way, when the parent device probes and adds child devices, the child
devices can then create their own device links to the suppliers and further
delay the supplier's sync_state() callback to after the child devices are
probed.

Example:
In this illustration, -> denotes DT references and indentation
represents child status.

Device node A
	Device node B -> D
	Device node C -> B, D

Device node D

Assume all these devices have their drivers loaded as modules.

Without this patch, this is the sequence of events:
1. D is added.
2. A is added.
3. Device D probes.
4. Device D gets its sync_state() callback.
5. Device B and C might malfunction because their resources got
   altered/turned off before they can make active requests for them.

With this patch, this is the sequence of events:
1. D is added.
2. A is added and creates device links to D.
3. Device link from A to B is not added because A is a parent of B.
4. Device D probes.
5. Device D does not get it's sync_state() callback because consumer A
   hasn't probed yet.
5. Device A probes.
5. a. Devices B and C are added.
5. b. Device links from B and C to D are added.
5. c. Device A's probe completes.
6. Device D does not get it's sync_state() callback because consumer A
   has probed but consumers B and C haven't probed yet.
7. Device B and C probe.
8. Device D gets it's sync_state() callback because all its consumers
   have probed.
9. None of the devices malfunction.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/of/property.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index 82052172f508..420c2d428184 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1207,6 +1207,10 @@ static int __of_link_to_suppliers(struct device *dev,
 		if (of_link_property(dev, con_np, p->name))
 			ret = -EAGAIN;
 
+	for_each_child_of_node(con_np, child)
+		if (__of_link_to_suppliers(dev, child))
+			ret = -EAGAIN;
+
 	return ret;
 }
 
-- 
2.23.0.187.g17f5b7556c-goog

