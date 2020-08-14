Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA2244E5F
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Aug 2020 20:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgHNSJw (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 Aug 2020 14:09:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33373 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgHNSJw (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 Aug 2020 14:09:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id t7so8284498otp.0;
        Fri, 14 Aug 2020 11:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FWpki59Yt66zh3jh8q/OcbPj2ya0dDjDcuiyjVjlaFs=;
        b=D+Li9jXvh/uUoE9O3gGJS1SMYm4CUGGGrMawk5O54GDADps3DTtcLfgFH83LGBYgLe
         V7wVM2b7Nvqf9AVnfIL7zjaCGaRSyir34KudDRu3eIBVRf5SRPBgM/+v2/+uHJmZzMUK
         CVBgm99+jSCj61SoteMAcNFt9+zZIj9GTS2RQ9WHmm83MD1KNtutVlkXfiYlWaMltzJt
         UeObn/zwOqW0kzfnPYtexhelO1GXvTdZrmWlqkkgt+uoecxtSyed6WnjXOONJG8uLH9O
         mnEwAsYaclTLV7fWozF38ZgZxCaZ4IeyfEu05D7zTszOuKBc+ON7sWXEOb8VOo/18RA8
         NJTA==
X-Gm-Message-State: AOAM531RwkM+G5JHFCXw6Zf8C7KDObQab5Rw0cTtYrWPeIHu1FUdxFHC
        FqRAyKid+Qo0OheXFUb7hePQJrALhNv/00PpBnZ/bBiiyRE=
X-Google-Smtp-Source: ABdhPJzZCUjOjz3+qUDbyYxT24ltsOM+ORo5EAMg7K5+43lWHZtaKlAF/HxuPOTFxNJGjVpIrlOdWqB9zE2LSfZmvQE=
X-Received: by 2002:a9d:5c06:: with SMTP id o6mr1655235otk.262.1597428591566;
 Fri, 14 Aug 2020 11:09:51 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 20:09:40 +0200
Message-ID: <CAJZ5v0iA_PSMf9gpXsmymS8t2ctMeyJ3FJE_v1LqbFu+fF_R6g@mail.gmail.com>
Subject: [GIT PULL] More ACPI updates for v5.9-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.9-rc1-2

with top-most commit 19fe87fd854a92c746ac73cb91a0bebac07a4618

 clk: x86: Support RV architecture

on top of commit 2baa85d6927d11b8d946da2e4ad00dddca5b8da2

 Merge tag 'acpi-5.9-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive additional ACPI updates for 5.9-rc1.

These add new hardware support to the ACPI driver for AMD SoCs,
the x86 clk driver and the Designware i2c driver (changes from
Akshu Agrawal and Pu Wen).

Thanks!


---------------

Akshu Agrawal (4):
      ACPI: APD: Change name from ST to FCH
      clk: x86: Change name from ST to FCH
      ACPI: APD: Add a fmw property is_raven
      clk: x86: Support RV architecture

Pu Wen (1):
      i2c: designware: Add device HID for Hygon I2C controller

---------------

 drivers/acpi/acpi_apd.c                            |  19 ++--
 drivers/clk/x86/Makefile                           |   2 +-
 drivers/clk/x86/clk-fch.c                          | 101 +++++++++++++++++++++
 drivers/clk/x86/clk-st.c                           |  78 ----------------
 drivers/i2c/busses/i2c-designware-platdrv.c        |   1 +
 .../linux/platform_data/{clk-st.h => clk-fch.h}    |  11 ++-
 6 files changed, 121 insertions(+), 91 deletions(-)
