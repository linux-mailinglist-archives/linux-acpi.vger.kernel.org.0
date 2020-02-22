Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD665168BAF
	for <lists+linux-acpi@lfdr.de>; Sat, 22 Feb 2020 02:41:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbgBVBlB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 21 Feb 2020 20:41:01 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:51731 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728019AbgBVBlA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Feb 2020 20:41:00 -0500
Received: by mail-pg1-f202.google.com with SMTP id m18so2116847pgn.18
        for <linux-acpi@vger.kernel.org>; Fri, 21 Feb 2020 17:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KJExBCe79TvbDWBtLAIAPlDU0zRERHckO2kWsYTv978=;
        b=Q+ZW5zteZDu1FNYEMvKTjgWjf9TVSuk16yWcCy2JweJvkq+lTHDxx786967t+KpMC4
         WrYcOnyyCjG511w+00j/x8XY7e26b2TsnE4kgWSZWOu2mqXMNa4nKltDIZEpyts40fte
         lFqRTRmjS84KOl/C+eXYSKbGlWvz3Gd//g5GAHgn0aO4ANiawlYoLTBfCMF4SiV0na5K
         le4v19xzzHsWvOo6HvWOoFfzUVYAS9DL8Q/vlnOOT1FwrUxBu+HkYHMl42BYYcyqchtQ
         ViLRU0kcaRQfGqeLQ4KYUhyqKl7rdiLM2cX6tOiClI1uGnFefdSz/2HsMYabeyxF/Who
         Bv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KJExBCe79TvbDWBtLAIAPlDU0zRERHckO2kWsYTv978=;
        b=E1qJKSnOQN1eUd7qk/Etq157ezcbzuPFhFHMaOXJx91ejqOcEdHbhEDAVTNTItLycF
         g+Fd5/B4fIRv6fTQx9/Rs/XVesL7EpiPHfDZJ+BBrGHOuX00W9V7VaVWqdpiZY5reojw
         yUfSdsxKMww/uSNaCEg/LUjVqQeSq3/xiUyatkLAR8FRpgoELGh3ky6Y11m/uatYL3m/
         4WTY0d3KJQG6eSLYPrYjEm4CZfSDHrTEq2sqJkHUsylXCSoB733RlpMOLX8aSBuFWL1O
         Sf2ONeMHwuMEB0AHg8S/HBr+xYQ7FXLyItL3TgHPPJ4bl/77pdAb75RQizMxqwP6ciZo
         4DcQ==
X-Gm-Message-State: APjAAAV9hXkBnX4XY2uyrdA2W+emxQtninpmAJ/fe3w+1s2VImqUMTef
        6WOhWo5hhbJ3rsF3p1tJpARY5oejg/ujdX0=
X-Google-Smtp-Source: APXvYqzeslKuPNzcFs1IbK32oZCNMmy4nVP9Y84HztkmAh6Tdl4LyaoiuujEisOnVrevdJg+wGWCL5JtzXjW6PI=
X-Received: by 2002:a63:4804:: with SMTP id v4mr40448137pga.373.1582335658427;
 Fri, 21 Feb 2020 17:40:58 -0800 (PST)
Date:   Fri, 21 Feb 2020 17:40:38 -0800
In-Reply-To: <20200222014038.180923-1-saravanak@google.com>
Message-Id: <20200222014038.180923-6-saravanak@google.com>
Mime-Version: 1.0
References: <20200222014038.180923-1-saravanak@google.com>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v1 5/5] of: property: Delete of_devlink kernel commandline option
From:   Saravana Kannan <saravanak@google.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

With the addition of fw_devlink kernel commandline option, of_devlink is
redundant and not useful anymore. So, delete it.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ------
 drivers/of/property.c                           | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 29985152b66d..6692b2aa6140 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3299,12 +3299,6 @@
 			This can be set from sysctl after boot.
 			See Documentation/admin-guide/sysctl/vm.rst for details.
 
-	of_devlink	[OF, KNL] Create device links between consumer and
-			supplier devices by scanning the devictree to infer the
-			consumer/supplier relationships.  A consumer device
-			will not be probed until all the supplier devices have
-			probed successfully.
-
 	ohci1394_dma=early	[HW] enable debugging via the ohci1394 driver.
 			See Documentation/debugging-via-ohci1394.txt for more
 			info.
diff --git a/drivers/of/property.c b/drivers/of/property.c
index 15fc9315f1a7..f104f15b57fb 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1299,15 +1299,9 @@ static int of_link_to_suppliers(struct device *dev,
 	return ret;
 }
 
-static bool of_devlink;
-core_param(of_devlink, of_devlink, bool, 0);
-
 static int of_fwnode_add_links(const struct fwnode_handle *fwnode,
 			       struct device *dev)
 {
-	if (!of_devlink)
-		return 0;
-
 	if (unlikely(!is_of_node(fwnode)))
 		return 0;
 
-- 
2.25.0.265.gbab2e86ba0-goog

