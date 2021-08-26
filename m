Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728333F8342
	for <lists+linux-acpi@lfdr.de>; Thu, 26 Aug 2021 09:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHZHqS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 26 Aug 2021 03:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbhHZHqR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 26 Aug 2021 03:46:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C42CC061757
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r15-20020a056902154f00b00598b87f197cso2227477ybu.13
        for <linux-acpi@vger.kernel.org>; Thu, 26 Aug 2021 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=wKFLqTVWaVrcQULKv1jqscU7IEOt0JC1OsA098B/mg8=;
        b=MgrRFJDm1nANvlgHSds/Pe4ZKKgMbmjPSzIetJqnyx7l4IeGw8CA8DOJ1MkwJ8Q1fr
         rE471tV2WG8jVbXtNw/o04Ax9QjwrccP2Fx1QJGGRniwORpBUYKnm0DYKNaM7Pv0rgEu
         BIQ4qLSmEknUPOFvBYuEixlESUUhGJTgXWLMmBh++7p036Y8qDdClF1Y/q5y/94SHgfX
         0xcEEN3qr0fgB2SI/iWRtkxX1ViId6077Ue1NyGKx+RkfhRI+J1Llh/dJBzoYLaKjUy5
         BFsRmQW+ev1BGTyj8BOxilty2S1Vz1mB/WDJjsct4nEQrrTCTYJquK/sb7ve2o0WBa0s
         sbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=wKFLqTVWaVrcQULKv1jqscU7IEOt0JC1OsA098B/mg8=;
        b=T0rOlnvw3gMFhtPzONwprQFikmogpHSRhi/+fDGpo1+QINhxz+GoU2xdCmd0+dZSM7
         9Bb2FLa3pa95xUrzr3cGcSmfPck6xX5H8SrDXfOBJyA4XZuCreooD4wWkWBt8KpdHUSY
         5YWDC/h9Jx0nWVLgH/97Phrrzso6L1j9jgyn8bSkpGk6jor4GzyobWvZWW6+AILVPSbl
         svSlOG8rq+Ska7w16C2UEBAjA5EYUBD0dpZFHV/PBnfvUfCQqK8sOSrDwqwqzWYUgpgN
         bMLWFFH3BO2byU/Lr5CRM/BETEIVjIunaWeZMemhHMiR+KSYM5RC9UCZOssxQZ28OS37
         SDvw==
X-Gm-Message-State: AOAM5326yai1lPDu6MLKdRnVYA4J5sj99x2U2eRRmWBDlnaeexHObRLI
        ruGIj8bxeo8DXOs/VCsVV6g6Le2hVx8Isec=
X-Google-Smtp-Source: ABdhPJxz+g0Ic2ZhjBouHVwCw2zCtQ4XGrAuR6D8xhyLLvtQM7hmYzuuUc4xpmTTTvSNqfkXQX93y+AA1vZL1lg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:5b7b:56e7:63bf:9b3c])
 (user=saravanak job=sendgmr) by 2002:a25:1056:: with SMTP id
 83mr3551029ybq.52.1629963929742; Thu, 26 Aug 2021 00:45:29 -0700 (PDT)
Date:   Thu, 26 Aug 2021 00:45:23 -0700
Message-Id: <20210826074526.825517-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH v1 0/2] Fix rtl8366rb issues with fw_devlink=on
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Alvin Sipraga <ALSI@bang-olufsen.dk>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I consider Patch 2/2 to be a temporary fix that restores functionality
while a proper fix of the driver is figured out.

Alvin,

Can you test this out? Also, sorry to drop the accents in your name.
git-send-email was being weird about it.

Thanks,
Saravana
Cc: Alvin Sipraga <ALSI@bang-olufsen.dk>

Saravana Kannan (2):
  driver core: fw_devlink: Add support for FWNODE_FLAG_BROKEN_PARENT
  net: dsa: rtl8366rb: Quick fix to work with fw_devlink=on

 drivers/base/core.c                | 22 ++++++++++++++++++++++
 drivers/net/dsa/realtek-smi-core.c |  7 +++++++
 include/linux/fwnode.h             |  3 +++
 3 files changed, 32 insertions(+)

-- 
2.33.0.rc2.250.ged5fa647cd-goog

