Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539C2391CE5
	for <lists+linux-acpi@lfdr.de>; Wed, 26 May 2021 18:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbhEZQXH (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 26 May 2021 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhEZQXH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 26 May 2021 12:23:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ED9C061756
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 09:21:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b9so3340893ejc.13
        for <linux-acpi@vger.kernel.org>; Wed, 26 May 2021 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ny/LVTZ9NhT7pAThv8EZzNISFLoNH72249Lr1FcP2cI=;
        b=DiMkylxvByFm8pw9ICWMTsxJtAVMkIc1v+qhXw8MlH8NYoOQHZDzPwYhMKyf4zehcU
         9BNQZFb9m83eA/WivtK5JIiBd4CBiLu6jsxruJCx2FxqUBSHWfYIswDrkBbj34h8J23B
         lqaFT3E/HC7lRmeBzk+WxMIEH79wtIqeoj081sGiC3xbeyMQdgoLwp/s+UAvdIwYunwf
         wTgcqQL/RzXf19RnNXhRFRjvlFUb0SxOfGYi82FD8Wnwe3w584+pU+UxuUZaku/pGTrn
         C313eJUpAnO9OUiQrzvBZLWbGuT/2fXE9gNwjeJ7hJRd+C0onv7py91r2R+Mao66KI7F
         cjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ny/LVTZ9NhT7pAThv8EZzNISFLoNH72249Lr1FcP2cI=;
        b=D4gQEhBlHw4XhF+YA6JmtSVA2LFgLXu0tqV58hh6rre/WymoWBdzzQ1/1ZnNFJOwbp
         r+nyD+rMWtL4uEnoefQmoLYSxiO915rcSkxs5VjJgfUuXzxW1dxBfvfl2erFbHQg3eaL
         GTdz5E3TKFHPafJa/ZP+DMrUjiC+ma0wY704qCe43Q+TAqwF4l79mwdz394lSB2yieS9
         EYWpW6Y8aP/dhz5W6KLMaKhDQzk1RYBu4OQO+xD9tXuVMNnlKJyfOKy38G/LXwkgZY64
         cc1N+pdS4O2DLSUY/0lnw+nIoms4SDASOZfjPPnk+df1cjQVScyADrvtnqJ/siMQ9B9J
         r75Q==
X-Gm-Message-State: AOAM532tzUnivlxY5LWuVUdzExZ4juSi0Cnmf3ZZoQmutqL/Re12xqGz
        4Ww58bjDw+tvufa+SmaLbrWzag==
X-Google-Smtp-Source: ABdhPJyqzgF1RD6CdwvK48ZfcwVE7vT+A0zVtv0WtiBKRWJwPQ1T58Q1HOYoySz9zdFZA/kfZFQwvw==
X-Received: by 2002:a17:906:a0a:: with SMTP id w10mr34330704ejf.416.1622046093908;
        Wed, 26 May 2021 09:21:33 -0700 (PDT)
Received: from localhost.localdomain (adsl-84-226-106-126.adslplus.ch. [84.226.106.126])
        by smtp.gmail.com with ESMTPSA id e6sm10497145ejd.31.2021.05.26.09.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 09:21:33 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     joro@8bytes.org, will@kernel.org
Cc:     robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        guohanjun@huawei.com, sudeep.holla@arm.com, rjw@rjwysocki.net,
        lenb@kernel.org, robin.murphy@arm.com, Jonathan.Cameron@huawei.com,
        eric.auger@redhat.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com, iommu@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v15 0/3] iommu/arm-smmu-v3: Add stall support
Date:   Wed, 26 May 2021 18:19:25 +0200
Message-Id: <20210526161927.24268-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Add stall support for SMMUv3, enabling I/O page faults and SVA for
compatible devices. No change since last version [1], but I'd still like
this to be considered for upstream, because there exists hardware and
applications.

Stall is implemented by the Kunpeng 920 processor for its compression
and crypto accelerators, with which I tested the SVA infrastructure.
Using the userspace accelerator API [2], a program can obtain a queue
from one of these devices and submit compression or encryption work
within the program's address space. UADK [3] provides a library to do
this, and there is an openssl plugin [4] to use it.

That's probably as far as we can go in terms of real users of SVA at the
moment, since userspace won't progress much further without upstream
kernel support - these three patches.

Stall is only enabled if the firmware declares that the device supports
stalling (explicit flags from patches 1 and 2) or, in the case of the
Kunpeng 920, with a quirk [5]. If that property is not set, stall will
still be disabled in the STE and CD, and this series should not have any
negative impact on existing systems.

[1] https://lore.kernel.org/linux-iommu/20210401154718.307519-1-jean-philippe@linaro.org/
[2] Documentation/misc-devices/uacce.rst
[3] https://github.com/Linaro/uadk
[4] https://github.com/Linaro/openssl-uadk
[5] https://lore.kernel.org/linux-pci/1615258837-12189-1-git-send-email-zhangfei.gao@linaro.org/
    FWIW future devices should implement PRI:
    https://lore.kernel.org/linux-pci/5FD9EE6E.1040505@hisilicon.com/

Jean-Philippe Brucker (3):
  dt-bindings: document stall property for IOMMU masters
  ACPI/IORT: Enable stall support for platform devices
  iommu/arm-smmu-v3: Add stall support for platform devices

 .../devicetree/bindings/iommu/iommu.txt       |  18 ++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  43 ++++
 drivers/acpi/arm64/iort.c                     |   4 +-
 .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   |  59 +++++-
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 196 +++++++++++++++++-
 5 files changed, 304 insertions(+), 16 deletions(-)

-- 
2.31.1

