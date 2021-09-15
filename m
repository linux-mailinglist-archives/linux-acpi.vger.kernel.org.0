Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB95540C162
	for <lists+linux-acpi@lfdr.de>; Wed, 15 Sep 2021 10:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhIOINT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 15 Sep 2021 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhIOINL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 15 Sep 2021 04:13:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C16C0613E0
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a23-20020a25ae17000000b005ad73346312so2545205ybj.18
        for <linux-acpi@vger.kernel.org>; Wed, 15 Sep 2021 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=yfa5Rx/Qiunlci+zcN20hGjk88ftJaLJ8MhJAuyVtPg=;
        b=Bziq+JAqVVonT8FZlMTg9QRvlqbUqLE8pqptTBdcOCh1N6hQ7V85vIJZEmAJFOFIEe
         MDN4tK9VdpMxrx7LFFTAiWGV79SBpHFjqNYqp2Ol6tOwYbR0gHIU9ZYA96tTgwPvBkkf
         h7ar0uSpe9wkk6LZUVuo10u6lIWO7mb551gfLsgCWmYApmmUdoFc4dKx4Fn272xt1dff
         5Zxkk94pxBzeNzjW0DcYthW+/Mg+upiqLEJbpFePYgaBiqUjbHIOyFrbEapt1nF4XkgP
         cEaxl9cKDdiIasFtJFHqVpfT9/eLWIo9Lq6PvO8ARORvrLvJaHI9fizqKrvmdvGxuMQE
         C/9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=yfa5Rx/Qiunlci+zcN20hGjk88ftJaLJ8MhJAuyVtPg=;
        b=UkevHdMH6DNLrYmIhOTQmFsmp4TP/j321KKPkIM5bppEenVR1PmWHvJLjI8ottFu/J
         WBf9lefEAFaIJztiauaSX4g/RcDqLpVSBTV8Gbfw0sqfHX/xlkY7hJRRPYocwqgfXiOy
         lWrpWeoH9tK+Jai0qXo2uOTLPwrkezkFDrYW8kP+B67p3bwS5+siuC6J8a5qnBPO9m98
         KSocwzgOMB7bci2Y0Z9Hf90OkqEqvVZ7Y3L+txg62D2F2UqlpIqAMO3Jo+qdLlzRzmW8
         7Aw9su3mr6yHlrSd/JiQjQSOfhjiWHOThqfAyNmwdEj8sVLMwbZAqOLUUHYe0gUZ1GVX
         NE4w==
X-Gm-Message-State: AOAM532gGxuqdPJq45cULzdYmurqqLQeU7xlDmUCubDmRHnp4lEhTUzF
        uznZ4hHu2fTdsTxU4hp+xgq2DbFZ86XuA/k=
X-Google-Smtp-Source: ABdhPJw5lk8+hNRREG7eLjZEFSM4ko3LXxf98/UI9AGjkdcwerpLOs2cJ00+a4CoN07Yf0O8WeHlY6ZQDJGAc9Y=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:16d1:ab0e:fc4a:b9b1])
 (user=saravanak job=sendgmr) by 2002:a25:9906:: with SMTP id
 z6mr4480758ybn.373.1631693503120; Wed, 15 Sep 2021 01:11:43 -0700 (PDT)
Date:   Wed, 15 Sep 2021 01:11:32 -0700
Message-Id: <20210915081139.480263-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.309.g3052b89438-goog
Subject: [PATCH v2 0/6] fw_devlink improvements
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Patches ready for picking up:
Patch 1 fixes a bug in fw_devlink.
Patch 2-4 are meant to make debugging easier
Patch 5 and 6 fix fw_devlink issues with PHYs and networking

Andrew,

I think Patch 5 and 6 should be picked up be Greg too. Let me know if
you disagree.

-Saravana

Cc: John Stultz <john.stultz@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vladimir Oltean <olteanv@gmail.com>

v1->v2:
- Added a few Reviewed-by and Tested-by tags
- Addressed Geert's comments in patches 3 and 5
- Dropped the fw_devlink.debug patch
- Added 2 more patches to the series to address other fw_devlink issues

Thanks,
Saravana

Saravana Kannan (6):
  driver core: fw_devlink: Improve handling of cyclic dependencies
  driver core: Set deferred probe reason when deferred by driver core
  driver core: Create __fwnode_link_del() helper function
  driver core: Add debug logs when fwnode links are added/deleted
  driver core: fw_devlink: Add support for FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD
  net: mdiobus: Set FWNODE_FLAG_NEEDS_CHILD_BOUND_ON_ADD for mdiobus parents

 drivers/base/core.c        | 90 ++++++++++++++++++++++++++------------
 drivers/net/phy/mdio_bus.c |  4 ++
 include/linux/fwnode.h     | 11 +++--
 3 files changed, 75 insertions(+), 30 deletions(-)

-- 
2.33.0.309.g3052b89438-goog

