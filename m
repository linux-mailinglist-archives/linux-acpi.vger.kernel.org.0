Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9134AC8E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Mar 2021 17:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhCZQcQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Mar 2021 12:32:16 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:46807 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhCZQbz (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Mar 2021 12:31:55 -0400
Received: by mail-ot1-f48.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso5707219ott.13;
        Fri, 26 Mar 2021 09:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zKr+R6WlXjzMQCFE4jV12KKRxXdL9EcwwgypNGtEQlU=;
        b=Hbema6FvLM8WN3+yttVR+kHNjXBmNNMpe4xi9ePlQGWbGqk8pb7wmvwMQA+vyxmuVn
         JQDpaknvTiSdCTvOOZ7glc1oL7V/1OB2aqJL1OCKAdGyz1eYbRxlodf7kuDOnCQObwH7
         hMNCVksWnHeu1wIo1I2dcs05QWOEyn9+F89ehWhWoAdOCMAaxwZ8kqgAKLtUVxcT79xY
         mHYP9chtHHuS08CpgSR3AWrOW1TviIMgzEs/UWvZUZ4udR2nVU+gCnYxSjugvKi28gUy
         EtPYjupi8Q3iiAnwtm1/SjTx0c4G4WzBue6vowU2+8Qy91XG6clzwRdkR+pSe/JAKarp
         dQbA==
X-Gm-Message-State: AOAM530SxrJ9KCDeAE5A2XqesziJplyg4xqmo1zKSzeZk+qNETvLcG03
        e8EwLfBgU17pooZL/B8EaPdbRgN/oC2DqbJCJTPHgk+ZZgM=
X-Google-Smtp-Source: ABdhPJz7smLA46STpBh7/Dlvyli6TdbyQljEPJRMSukYU45Z0XUBQ84C472o6+52ZZ8QoH+HPuvZlXh4WaNti3xb2Po=
X-Received: by 2002:a9d:4811:: with SMTP id c17mr12885586otf.206.1616776314722;
 Fri, 26 Mar 2021 09:31:54 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Mar 2021 17:31:43 +0100
Message-ID: <CAJZ5v0inc+R90Ra2Bz0QUAUS9Ev1awRkfdDvUPBXjF4FNnJ5og@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.12-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.12-rc5

with top-most commit e1db18b59729e24f001459b98955019344d5b12b

 Merge branches 'acpi-video' and 'acpi-scan'

on top of commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b

 Linux 5.12-rc4

to receive ACPI fixes for 5.12-rc5.

These fix a memory management regression in ACPICA, repair an ACPI
blacklist entry damaged inadvertently during the 5.11 cycle and fix
the bookkeeping of devices with the same primary device ID in the
ACPI core.

Specifics:

 - Make ACPICA use the same object cache consistently when allocating
   and freeing objects (Vegard Nossum).

 - Add a callback pointer removed inadvertently during the 5.11 cycle
   to the ACPI backlight blacklist entry for Sony VPCEH3U1E (Chris
   Chiu).

 - Make the ACPI device enumeration core use IDA for creating names of
   ACPI device objects with the same primary device ID to avoid using
   duplicate device object names in some cases (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: scan: Use unique number for instance_no

Chris Chiu (1):
      ACPI: video: Add missing callback back for Sony VPCEH3U1E

Vegard Nossum (1):
      ACPICA: Always create namespace nodes using acpi_ns_create_node()

---------------

 drivers/acpi/acpica/nsaccess.c |  3 +--
 drivers/acpi/internal.h        |  6 +++++-
 drivers/acpi/scan.c            | 33 ++++++++++++++++++++++++++++-----
 drivers/acpi/video_detect.c    |  1 +
 include/acpi/acpi_bus.h        |  1 +
 5 files changed, 36 insertions(+), 8 deletions(-)
