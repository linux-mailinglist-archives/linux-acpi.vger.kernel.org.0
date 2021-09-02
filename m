Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDB33FE7D7
	for <lists+linux-acpi@lfdr.de>; Thu,  2 Sep 2021 04:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243251AbhIBC4b (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 1 Sep 2021 22:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243248AbhIBC4a (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Sep 2021 22:56:30 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8492CC061575
        for <linux-acpi@vger.kernel.org>; Wed,  1 Sep 2021 19:55:32 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o22-20020ac872d60000b029029817302575so337517qtp.10
        for <linux-acpi@vger.kernel.org>; Wed, 01 Sep 2021 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/aXUDlx1JTPpPyu3WN1BFuFJPOsjfLN1lwH9GuIMxhI=;
        b=BgTX341W1lvzaiOHoeTuEgeDO5h9DsUjqW60RI6LF/VS/q57VUubjG5ZEnceGkiqg7
         snSZVITLyFuZh+zfsChhY4LeuKr7of5HB/j6IHdaquCtOJBdsilBqLEE0xaVp8K7COVC
         zyJFfPOEHV6KyhbGUD/CgKXZ4jWnXl06VTzOMZ7wJi+Q/ryEUY+WPsVKSrK2YILervrB
         U31uWU+iPBIsDKUYGYjRPpGVuHKioYa6CsiRmFnm0BS+0T5uezZ1kN4PDOcHnRc16Tkt
         5VAiKbnLi8zl6AHBK//d6KV7yYDZXJoF+cuT4c4QPy7AV+2lHtSePXRJ2mSqh3szjFyu
         /nbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/aXUDlx1JTPpPyu3WN1BFuFJPOsjfLN1lwH9GuIMxhI=;
        b=Q87N0l1+op/jPLPQp9Z29HRW8IA4ojeWgnUHlLLHAoA0lYaCFlL+Eb7oLd3qroWzOy
         NhmNzqVy4cqUQnELo+8lum/VuR5C6ufKQPuMFIDhB1VcqVvkP2Qb/sNArXvNa/G+LRU3
         2iRP9Q1CUR9ZgSPfGzN19mIkcWBg9U306QWxd4x6UAjJ6zhQWvSQHbwubjVMf5rY7Evz
         1dhO/zLbXZv9sDnLtcjQAO5vmBNFnu0RS+AMUObv3tGf2Fk8ugIibplyH+kiQ6nBn3wQ
         2za8+baKYKdipedcuoxrh2ys7kGzGo1R/0p+uHWYKA2BHojDNrmplNI0eYB6IKhuMosb
         juSg==
X-Gm-Message-State: AOAM533ELbnun70IgGwmQli0MZIRFqfyVG6/mHpND/LG/QExIWN+Wyt6
        Y8mBEWgAPqeWHP9IresAin+/Sh79+VFTq4I=
X-Google-Smtp-Source: ABdhPJxb+rqgJ4/whkv1W+O1QqlMsEVUZd/MibVKjNebliHGR7A9pNhOlNE+GhvyfafZAHEiUjdSLsHe0F9Y+YQ=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:17e:f0b7:5862:e47d])
 (user=saravanak job=sendgmr) by 2002:ad4:4a04:: with SMTP id
 m4mr1116266qvz.42.1630551331676; Wed, 01 Sep 2021 19:55:31 -0700 (PDT)
Date:   Wed,  1 Sep 2021 19:55:25 -0700
Message-Id: <20210902025528.1017391-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v1 0/2] Ulf reported an issue[1] with fw_devlink. This series
 tries to fix that issue.
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Ulf, mind testing this?

Thanks,
Saravana
[1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/

Cc: Ulf Hansson <ulf.hansson@linaro.org>

Saravana Kannan (2):
  driver core: Add support for FWNODE_FLAG_NEVER_PROBES
  of: platform: Mark bus devices nodes with FWNODE_FLAG_NEVER_PROBES

 drivers/base/core.c    |  8 ++++++++
 drivers/of/platform.c  | 16 ++++++++++++++++
 include/linux/fwnode.h |  8 +++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

-- 
2.33.0.259.gc128427fd7-goog

