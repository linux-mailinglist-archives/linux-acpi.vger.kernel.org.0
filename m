Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEFD5262B05
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Sep 2020 10:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIIIyf (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Sep 2020 04:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgIIIye (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Sep 2020 04:54:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C234DC061755
        for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2020 01:54:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so2007096wrn.10
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2020 01:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ge+LjYBvfrPR/6z1eGAAmD+KiWvreg+tXjIgUs0btU=;
        b=q8tRc+rU8QeroDtIWNLDBOL7Agmfjh51hQKjf49eFv3+n5GlODrSJopzzbOq9DLd8c
         CC3Q651wyFUH0A4OoOF/DyS8hzBbBOpGv52huurWK8FPRP8YHmvTcp5jA4FsmmZOZy5P
         yb57ng9AXG1SlNsC7WiI8TcRkWW0+E6HmsJvap8jb4C73AnG/bXpTDXs6k/RG88ZieUc
         VRKkf3YuSKSyZjW4mQt1aQXYSF0YhZv3W7N0KR/iHQ56C1bGZ+CkhvfUmMH97g2uNSaR
         TYe3Lg6uz5Yjs96QMJi+/Fu2vDFWYS70UNXtZp4GhHfaB8LF+K9qNqGlBpzho/nnxVUq
         AKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9ge+LjYBvfrPR/6z1eGAAmD+KiWvreg+tXjIgUs0btU=;
        b=Kjnyr89MN9+L8aBtMA02sRW382AJhrfn25NMtA5oC8i6baIjZCVtn7Qr5hbm7+RdEe
         bIuhgHy5rk0fcycTdE33A23X615RgQrk/KCedC0YEkv4rqGcn2qahUda2Qq0/3v8r6eg
         xclvLKnQeETGzcnpIzGOZhGpUnkPo3h+2PnUPiY9ijxX0mH0VfXjLIxvgUzhfRSTYL47
         va5RKhZLvPnEx2lqlJV+yzlmfNjB2PDJhIEmNLpgkvifph5iQhS2fYBsb2zVqe/0089Q
         hMY/Cy+iQFXoTivdLuPhWcmhHbJ0QYL3LveSl/5wksCam/9kPzUl2lrO2wOwiC1deW+/
         mu9Q==
X-Gm-Message-State: AOAM533HVlokCjwW5U2ALwFdyFJuWxCHp8ZIBbUclH28MKhpczhxJC+P
        7TcKTldaLt/bqWNbeYmT0nLwspciKfXR1A==
X-Google-Smtp-Source: ABdhPJwzDEHKLjOwS9evMvXAKBTZ65IQav9hZYJOaGRhp8jhiQvjJGKJ4Qp9YoxUuuDLlZGHFpXwzA==
X-Received: by 2002:a5d:6404:: with SMTP id z4mr2860751wru.423.1599641672353;
        Wed, 09 Sep 2020 01:54:32 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-657-1-17-60.w109-210.abo.wanadoo.fr. [109.210.64.60])
        by smtp.gmail.com with ESMTPSA id n17sm3418812wrw.0.2020.09.09.01.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:54:31 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 0/3] gpiolib: generalize GPIO line names property
Date:   Wed,  9 Sep 2020 10:54:23 +0200
Message-Id: <20200909085426.19862-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

I initially sent this as part of the gpio-mockup overhaul but since
these patches are indepentent and the work on gpio-mockup may become
more complicated - I'm sending these separately.

The only change is adding additional property helpers to count strings
in array.

v1 -> v2:
- actually remove the previous devprop source file in patch 3
- rename the string counting functions to something more explicit

Bartosz Golaszewski (3):
  device: property: add helpers to count items in string arrays
  gpiolib: generalize devprop_gpiochip_set_names() for device properties
  gpiolib: unexport devprop_gpiochip_set_names()

 drivers/gpio/Makefile          |  1 -
 drivers/gpio/gpiolib-acpi.c    |  3 --
 drivers/gpio/gpiolib-devprop.c | 63 ----------------------------------
 drivers/gpio/gpiolib-of.c      |  5 ---
 drivers/gpio/gpiolib.c         | 55 ++++++++++++++++++++++++++---
 include/linux/gpio/driver.h    |  3 --
 include/linux/property.h       | 13 +++++++
 7 files changed, 64 insertions(+), 79 deletions(-)
 delete mode 100644 drivers/gpio/gpiolib-devprop.c

-- 
2.26.1

