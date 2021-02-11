Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB030319424
	for <lists+linux-acpi@lfdr.de>; Thu, 11 Feb 2021 21:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbhBKUSE (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 11 Feb 2021 15:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhBKUR5 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Feb 2021 15:17:57 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8841C061756;
        Thu, 11 Feb 2021 12:17:16 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id w1so11948038ejf.11;
        Thu, 11 Feb 2021 12:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h/P68fi4XyowjoWEA/DZsqBXWvyY+Lwx+kBuaa3z2Q=;
        b=BrLIhb7FgXeGt4Krf6DDIxY6dUT7v+kxo7nrmPnKPFyFd93HEBYaHtC5cZJPb968zU
         FyDSZ4SPeUTkTlOwn6HaaRWa4XAiRFN4tWMW2/MTgrgrx0xIpRBo1uO4/blGKa2NlW8y
         aK7e1BR7xEil47+QoaUzW5NCnT3J5NmT3u+4l3ea24KTGOkG7VaoA3uu+FJX1/0uGDwd
         e2Q1EpXH9Mu29p5Q5uopJlbP/yyseea/o4QzsayVZm4jVDZHn1lZ5OrVIk8Z6BAZm/pj
         0wEMzXJYtVXIfJGmArg78JXFl7SdjmvDd3YucpYXvH4civWhHU5s2mQZ57NCFDF00yAc
         Oo+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7h/P68fi4XyowjoWEA/DZsqBXWvyY+Lwx+kBuaa3z2Q=;
        b=juImyTrZhGNVnpqXKGXlt504DwC3o97wkXt4owIiydKw2SNMrmioS3mdxfrWefvLXc
         VYbWj1toOTkw9ERHJa6q6FCld+lHFFMTBOBWCq4K0ACv69rkoEfluNmCiEDRVZXQ24FL
         LmmSInPur7YABcJEids+i1FeovUtXv24yihQl0X7VnHhPMd6iTzKoyGmB6+oiktlK9FZ
         fwKu4bKzDS+qxAH9e5/ky1RUStXqaeYWP4AsnW8/QYLfjMc//B9cQWQUQ95a8SPipnEI
         xvTB67SlTNeVimeykRBrKBL7re2W683HGkGE49N+3lmzVMG2FEmkwptIO/hK7lGvuFyz
         nVQg==
X-Gm-Message-State: AOAM531ypXQX/+J1Q8rLZSSrCxRkDUCEyHZt1+uL+wOF13bFk/g6WZCl
        uA7+rkqQJ1eQEdh/hTw4LK8=
X-Google-Smtp-Source: ABdhPJz/mCRWkKdWxJbBlnyWVmhf578mEZPXMXD3CInoUq7fpVB1g7s6bZl01dIzevBLvFWG7JOnlw==
X-Received: by 2002:a17:906:7698:: with SMTP id o24mr9757984ejm.504.1613074635665;
        Thu, 11 Feb 2021 12:17:15 -0800 (PST)
Received: from xws.localdomain ([37.58.58.229])
        by smtp.gmail.com with ESMTPSA id a1sm4938177edj.6.2021.02.11.12.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 12:17:15 -0800 (PST)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <mgross@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] platform/surface: Add platform profile driver for Surface devices
Date:   Thu, 11 Feb 2021 21:16:59 +0100
Message-Id: <20210211201703.658240-1-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

This series adds a driver to provide platform profile support on 5th-
and later generation Microsoft Surface devices with a Surface System
Aggregator Module. On those devices, the platform profile can be used to
influence cooling behavior and power consumption.

To achieve this, a new platform profile is introduced: the
'balanced-performance' profile.

In addition, a couple of fix-ups are performed:
- Hide CONFIG_ACPI_PLATFORM_PROFILE and change drivers so that it is
  selected instead of depended on.
- Fix some references to documentation in a comment.

Note: This series (or more specifically "platform/surface: Add platform
profile driver") depends on the "platform/surface: Add Surface
Aggregator device registry" series.

Changes in v2:
 - Introduce new 'balanced-performance' platform profile and change
   profile mapping in driver.
 - Perform some fix-ups for the ACPI platform profile implementation:
   - Fix some references to documentation in a comment.
   - Hide CONFIG_ACPI_PLATFORM_PROFILE

Maximilian Luz (4):
  ACPI: platform: Hide ACPI_PLATFORM_PROFILE option
  ACPI: platform: Fix file references in comment
  ACPI: platform: Add balanced-performance platform profile
  platform/surface: Add platform profile driver

 .../ABI/testing/sysfs-platform_profile        |  18 +-
 MAINTAINERS                                   |   6 +
 drivers/acpi/Kconfig                          |  16 +-
 drivers/acpi/platform_profile.c               |   1 +
 drivers/platform/surface/Kconfig              |  22 ++
 drivers/platform/surface/Makefile             |   1 +
 .../surface/surface_platform_profile.c        | 190 ++++++++++++++++++
 drivers/platform/x86/Kconfig                  |   4 +-
 include/linux/platform_profile.h              |   6 +-
 9 files changed, 237 insertions(+), 27 deletions(-)
 create mode 100644 drivers/platform/surface/surface_platform_profile.c

-- 
2.30.0

