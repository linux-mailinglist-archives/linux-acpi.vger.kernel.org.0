Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FBD256182
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Aug 2020 21:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725979AbgH1Tv0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 28 Aug 2020 15:51:26 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44528 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgH1TvX (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2020 15:51:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id n23so213821otq.11;
        Fri, 28 Aug 2020 12:51:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=kh02sOtDbCvUSxLLTQedVHawiKK6RbNa3pLiwpLAY8E=;
        b=IiS6WDTul1XdPysF8nV8qdAqF37BHJAkrUGPVztwsWMQ/ar/wECLGKWdLxIpz0luTY
         2u3/ihOk08zhEYJrS3LYTgquvlRs0ogo1PqbFFUbZio8XlyNzOnQxNaMRd1soRm4h55W
         ccXrr7x5UecauQEnCZCBKtGoTVnpFPEuQ9jkCDhL/eVRt48pyEVArNhN+LkXMlucBhhh
         z3hz3zzlMK1QJ0LIX0zXzTn/RVhtTw5/GLTZu+cspQwJJ8kR2rQtiv2Twuz1n/Eik2BI
         m/ROogALYOcWKvYn0eldBxBA7bTmxwbUhiFBLsFuxC9nVLWB0GQaq5Hb99OIrWKICJxz
         TmlQ==
X-Gm-Message-State: AOAM532zMpDi1wPNPyVuj0sPckDXGArZfgQ2UP9q1VYd6PIwAi1rgXjz
        Q7vM1vTpbNE04rAd45Fpe0nJ2/191E9FK/pmhJtxFcSVEuA=
X-Google-Smtp-Source: ABdhPJyNIqtgoq1r2Ggvj9+7qt0vvYdY5uyh9CAgVeCrzT4Zy0AT8odfdT5SOGkolmSPtYrg9XHa99GPhmIuEvByKnk=
X-Received: by 2002:a9d:7e99:: with SMTP id m25mr208277otp.118.1598644282097;
 Fri, 28 Aug 2020 12:51:22 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Aug 2020 21:51:11 +0200
Message-ID: <CAJZ5v0hZPb+qOAZFd1vknZ4S0ay=WpJSQECML88fsRGQOWoQSQ@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.9-rc3
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
 acpi-5.9-rc3

with top-most commit 4f31d53c21ec98a2c8973cff759804bd1c217c93

 Merge branch 'acpi-mm'

on top of commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5

 Linux 5.9-rc1

to receive ACPI fixes for 5.9-rc3.

These fix two recent issues in the ACPI memory mappings management
code and tighten up error handling in the ACPI driver for AMD SoCs
(APD).

Specifics:

 - Avoid redundant rounding to the page size in acpi_os_map_iomem()
   to address a recently introduced issue with the EFI memory map
   permission check on ARM64 (Ard Biesheuvel).

 - Fix acpi_release_memory() to wait until the memory mappings
   released by it have been really unmapped (Rafael Wysocki).

 - Make the ACPI driver for AMD SoCs (APD) check the return value
   of acpi_dev_get_property() to avoid failures in the cases when the
   device property under inspection is missing (Furquan Shaikh).

Thanks!


---------------

Ard Biesheuvel (1):
      ACPI: ioremap: avoid redundant rounding to OS page size

Furquan Shaikh (1):
      ACPI: SoC: APD: Check return value of acpi_dev_get_property()

Rafael J. Wysocki (1):
      ACPI: OSL: Prevent acpi_release_memory() from returning too early

---------------

 drivers/acpi/acpi_apd.c |  4 ++--
 drivers/acpi/osl.c      | 23 +++++++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)
