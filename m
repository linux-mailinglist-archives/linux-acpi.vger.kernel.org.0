Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF83556E25
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Jun 2022 23:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347203AbiFVV7a (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 22 Jun 2022 17:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242676AbiFVV71 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Jun 2022 17:59:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783E6317
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 14:59:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id q138-20020a252a90000000b006694ac29d4eso5865310ybq.14
        for <linux-acpi@vger.kernel.org>; Wed, 22 Jun 2022 14:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=ShVpNHmjygEofAqZTHbL2NPyHgeZoFDheDozlrqz8Mo=;
        b=mPUp1ZaiPzHiX/ODKTWQHSWhTGs2yrj0nz46pJea4DKVIWXpl3q0hnFrpNlVeVuFMu
         O6opAaXQuvi5uzX9EE3KaV2tOUFGq1jDJOmlWAwGI9JnOmBxCTczh9qb6dkX4IMOxw4R
         7k5Jju5GTUCe3yiEswDVY4cctHhutRwGFrXTp4d6H7EswQNBSuousy5e+nF8IFajtZYo
         OjoVhxEhdXwBTMSSxpG6OZNtheT6Ku7+aQY740oMkBnQKdxNivQym1AS38woNuH1PkQi
         LMpv++OC1nrl7lO39MRZ8QiA8XyTUqyfG3zJSRr2zKL91xKNcPmDsDkOZgGsgRtYkxv9
         yh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=ShVpNHmjygEofAqZTHbL2NPyHgeZoFDheDozlrqz8Mo=;
        b=tsy0MLglZcbhdD66krbhleNW+UWmkiCfmjtu0Ioa9MHMjpnduBNelNZhlScI+MXpEb
         /JgOm0kul8tqBVC2ir7TDLtZX3AMWN3bkYs3jldufdC6zDTUdOwrl/dqqt9koS+9OpYv
         kT26Ju4e5hSPYpF+eCHYr66hvXiy6U56q4AGzKDFVpXam8rNRGvFl8gZuZLHOJ6Hdl42
         WhlPbSECCnsl+a2xohE2uBWf1HZVvljkuAOIhICoUTBbbNsFV10xSZogjsX2//X6BZNQ
         rzYnjkmXSK31bi9a8bHXzXyJTtb3G/Z1TsyAT/pjj3s/q+fBvym068X2Qfp7LT8b0cks
         Kffw==
X-Gm-Message-State: AJIora97yp5yZMqwMr6THGFFHoDYy7/zC5xvpmfWFB3285sdoAFshVyk
        p6vaRb6LQ9GDMEFJ4AuICPyrJYG0dvQQl4s=
X-Google-Smtp-Source: AGRyM1sPRolQYIbNGET+LNO41EG5xKdb86jsaddJpKTB6LWlD19bkf1RVr0BB1uN5nuhu99u7pbeK+zWsKcFtIE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:be1f:89ac:a37d:6bb4])
 (user=saravanak job=sendgmr) by 2002:a25:73d7:0:b0:668:e7db:d62 with SMTP id
 o206-20020a2573d7000000b00668e7db0d62mr6272113ybc.265.1655935157166; Wed, 22
 Jun 2022 14:59:17 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:59:09 -0700
Message-Id: <20220622215912.550419-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v1 0/2] Fix console probe delay due to fw_devlink
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Sascha Hauer <sha@pengutronix.de>, Peng Fan <peng.fan@nxp.com>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

fw_devlink.strict=1 has been enabled by default. This was delaying the
probe of console devices. This series fixes that.

Sasha/Peng,

Can you test this please?

-Saravana

Cc: Sascha Hauer <sha@pengutronix.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: David Ahern <dsahern@kernel.org>
Cc: kernel-team@android.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Cc: iommu@lists.linux-foundation.org
Cc: netdev@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: kernel@pengutronix.de

Saravana Kannan (2):
  driver core: fw_devlink: Allow firmware to mark devices as best effort
  of: base: Avoid console probe delay when fw_devlink.strict=1

 drivers/base/core.c    | 3 ++-
 drivers/of/base.c      | 2 ++
 include/linux/fwnode.h | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.37.0.rc0.161.g10f37bed90-goog

