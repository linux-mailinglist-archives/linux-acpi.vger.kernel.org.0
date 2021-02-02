Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C0230B686
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Feb 2021 05:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbhBBEed (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 23:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhBBEe3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 23:34:29 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B16DC0613D6
        for <linux-acpi@vger.kernel.org>; Mon,  1 Feb 2021 20:33:49 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id t18so12818865qva.6
        for <linux-acpi@vger.kernel.org>; Mon, 01 Feb 2021 20:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tOYAEf4gylyNqcFyFHPYOstSUX7x6x4Pk46wd4Wq7MY=;
        b=cJRowJDPEh1zpt14Aur7j/uzBRdycqBeX8NMGh2Z1sBJOEtDJWxCAw0U4/dErXnxv8
         DOOiEmDX9+GevZyR608ZsYoms0h6Mqo7yAb2C5JPKMsT5w7/hCsxue7BS6NcFXqaAQDr
         yGiY4yOk+Sc9fuTMihToCaWo2q/W91QjIGVezxLHXaeAsUmVCsDqSdIXkfCxnsQ9WLUl
         3UGKXkweaXJAsrY5FUoaehKhBR7ql8br+65ddJYL/eSdpWlDqgVCpNhu2KT+9nyVHZ+P
         aB2JY6WJiH/84WJPMqlT7Q5U1ESmTxTu/NDADk1DM2MBa88D1omHZbH//S1tKANFffiP
         ESmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tOYAEf4gylyNqcFyFHPYOstSUX7x6x4Pk46wd4Wq7MY=;
        b=MQplMOE2O9JF0z3IyFNxX9nSOhF0C8WGSmPYm5nTX9quPSTZSw+FCVj8LL6dousNeb
         AJwlfDHuCTvxgH3U5UFctIC371jyog8p6Al3OYcR8immvSh+wVGWjeC6/wyLHsZjYEng
         SHx/Q4FkMQZwRkD5e2jWY8vqihTkotZEeJLwxHyAlBnG7/lsXckDwV5ksp4joBLgMZM3
         nl6awY38glybgujs0qYR1cf5vkLFPCFM31RxGYCgTUmbSJXxlq/y1o2BQQhqyYl2kaSp
         c4ZFfiTcwW1cDDU0+hXZwiumGhhps/D395gpNGodbfmX6mheKxqs6sPFQMetXB3K69CR
         SehQ==
X-Gm-Message-State: AOAM532RlSJkDWDDhuW8slqMmpa3PSfJUARFNQU17J+fPAsKEvtWtiRH
        ZuUa0+EmSbRInDKYj0Pkw9S10nPRNW8wxQ4=
X-Google-Smtp-Source: ABdhPJy2LOQmHXIPtgM0yQzz8CguovvD9V0s5CEoUoEgjJjFKOuZbXrCgaR98OU20BdvteGPXIR5L+TeGYv4fKI=
Sender: "saravanak via sendgmr" <saravanak@saravanak.san.corp.google.com>
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:a0c:ef87:: with SMTP id
 w7mr18229527qvr.44.1612240428256; Mon, 01 Feb 2021 20:33:48 -0800 (PST)
Date:   Mon,  1 Feb 2021 20:33:41 -0800
Message-Id: <20210202043345.3778765-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 0/3] Make fw_devlink=on more forgiving
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Martin Kaiser <martin@kaiser.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Len Brown <lenb@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This patch series solves two general issues with fw_devlink=on

Patch 1/3 and 3/3 addresses the issue of firmware nodes that look like
they'll have struct devices created for them, but will never actually
have struct devices added for them. For example, DT nodes with a
compatible property that don't have devices added for them.

Patch 2/2 address (for static kernels) the issue of optional suppliers
that'll never have a driver registered for them. So, if the device could
have probed with fw_devlink=permissive with a static kernel, this patch
should allow those devices to probe with a fw_devlink=on. This doesn't
solve it for the case where modules are enabled because there's no way
to tell if a driver will never be registered or it's just about to be
registered. I have some other ideas for that, but it'll have to come
later thinking about it a bit.

Marek, Geert,

I don't expect v2 to do any better for your cases.

This series not making any difference for Marek is still a mystery to
me. I guess one of the consumers doesn't take too well to its probe (and
it's consumers' probe) being delayed till late_initcall(). I'll continue
looking into it.

Marc,

This v2 should do better than v1 with gpiolib stub driver reverted. I
forgot to take care of the case where more suppliers could link after I
went and deleted some of the links. v2 handles that now.

Tudor,

You should still make the clock driver fix (because it's a bug), but I
think this series will fix your issue too (even without the clock driver
fix). Can you please give this a shot?

Martin,

If you tested this series, can you please give a Tested-by?

Thanks,
Saravana

v1 -> v2:
Patch 1: Added a flag to fwnodes that aren't devices.
Patch 3: New patch to ise the flag set in patch 1 to not create bad links.

Saravana Kannan (3):
  driver core: fw_devlink: Detect supplier devices that will never be
    added
  driver core: fw_devlink: Handle missing drivers for optional suppliers
  of: property: Don't add links to absent suppliers

 drivers/base/base.h    |   2 +
 drivers/base/core.c    | 135 +++++++++++++++++++++++++++++++++++------
 drivers/base/dd.c      |   5 ++
 drivers/of/property.c  |   4 +-
 include/linux/fwnode.h |   2 +
 5 files changed, 127 insertions(+), 21 deletions(-)

-- 
2.30.0.365.g02bc693789-goog

