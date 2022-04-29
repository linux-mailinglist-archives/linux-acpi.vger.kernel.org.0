Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C9F51591C
	for <lists+linux-acpi@lfdr.de>; Sat, 30 Apr 2022 01:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239925AbiD2XrQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Apr 2022 19:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239913AbiD2XrP (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Apr 2022 19:47:15 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99A7DB0D7
        for <linux-acpi@vger.kernel.org>; Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id y14so8104712pfe.10
        for <linux-acpi@vger.kernel.org>; Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiS8qEoWRaz1WJHgDpdYQzj9UXTuORSLeUZZBuLbpAQ=;
        b=QfV9qZQSy7zKpLgp3XKRuVVGQgXKgCEdZT8M6YLWLWuzskyledgrDoNbnEeL6+vdAy
         J1x4CD4N/XKato7QqwqelKbTKiWvYbwUH3sZuY4jCfH6bKi9uUj8MsW6jOFLQXVjURAX
         OatmJuCqt75DW8gtrxh6zZLgi05jRW6xz/fmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wiS8qEoWRaz1WJHgDpdYQzj9UXTuORSLeUZZBuLbpAQ=;
        b=GFgCBbFwqkW2yGdicos63XuTdVZcU3nxC4+8E5JaaxtUwxc9aHqvw5mi6xW4iAQHa/
         Hu1g40A2joIzee+hsC8zSyyr94ZOMmPiw5s3r7G6zFxEf7wh1ukeRNGaEqS0F1f1xK1S
         7pMxfk9bvAtTFXq61kNbNe0TK25/N2CDLS8PVZXKMNa8syaIuhhjsDLBnuGyW03F9/xy
         YId8GZvsv+6x8NhBQMCmhFXOHqC4TSlX3XNx9S8eG7NhoPqMgsuTt3NQmZ+xzwPkDSzR
         9ng6x24rJSHWcKl/gw1FLJPl5Xsat1hfifKbskj/mVU2Cd91ilIkcTLt+89NainKfpL/
         e99Q==
X-Gm-Message-State: AOAM533UkFZJPurb7rp5hT0S7h5YbzurJNJb0GTX4JlKzW/B0GdKBDIQ
        CA7vsS5sJjv8LekZYaohLnriWg==
X-Google-Smtp-Source: ABdhPJyGwn4LqJY11HpxsF3RCIIDl8jF0wjSNEEMrwJ5U7v246J/p3J5Kt/Ft8+Hq1Ze7VFy0q1q0g==
X-Received: by 2002:a05:6a00:190f:b0:50d:8b82:cb90 with SMTP id y15-20020a056a00190f00b0050d8b82cb90mr1532752pfi.65.1651275835135;
        Fri, 29 Apr 2022 16:43:55 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:408:3697:902b:59f1])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709028bc100b0015e8d4eb26dsm152563plo.183.2022.04.29.16.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 16:43:54 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     swboyd@chromium.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        freedreno@lists.freedesktop.org,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Scally <djrscally@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] device property: Fix recent breakage of fwnode_get_next_parent_dev()
Date:   Fri, 29 Apr 2022 16:43:47 -0700
Message-Id: <20220429164325.1.I2a3b980ea051e59140227999f0f0ca16f1125768@changeid>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Due to a subtle typo, instead of commit 87ffea09470d ("device
property: Introduce fwnode_for_each_parent_node()") being a no-op
change, it ended up causing the display on my sc7180-trogdor-lazor
device from coming up unless I added "fw_devlink=off" to my kernel
command line. Fix the typo.

Fixes: 87ffea09470d ("device property: Introduce fwnode_for_each_parent_node()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/base/property.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 36401cfe432c..52e85dcb20b5 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -600,7 +600,7 @@ struct device *fwnode_get_next_parent_dev(struct fwnode_handle *fwnode)
 	struct device *dev;
 
 	fwnode_for_each_parent_node(fwnode, parent) {
-		dev = get_dev_from_fwnode(fwnode);
+		dev = get_dev_from_fwnode(parent);
 		if (dev) {
 			fwnode_handle_put(parent);
 			return dev;
-- 
2.36.0.464.gb9c8b46e94-goog

