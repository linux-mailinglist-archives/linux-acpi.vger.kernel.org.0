Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6B0448BAF4
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Jan 2022 23:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiAKWtW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 11 Jan 2022 17:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbiAKWtV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Jan 2022 17:49:21 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC079C061756
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 14:49:20 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id n30-20020a17090a5aa100b001b2b6509685so1379537pji.3
        for <linux-acpi@vger.kernel.org>; Tue, 11 Jan 2022 14:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=W11G8KOKO0fe1jEMu72qehVZONI87KeyD8+Vm5Xf76U=;
        b=0JxaCMJ1GyV8z331bQf2eZSF9nbkko60u09Jj/RK4b4X8Z9NMX1pg09y0uwtIB8GLr
         auuDdG8RncHOGCb7+qIb8SxUtg9Inxfwq2/FcFrItisxZRMZgcxyOZ0G6T99HrnWsuBQ
         k6FJykIPYsaNoCkbUnPHoAWimQSscJSLjb6i+qOQ7QScRzqTWThC8ydPExfG5Fdk1R/T
         1r/tdrdNgXS33b4NthDIix8KJIsrXphJ1NBGatTT/dmngGwnBWzvFbgoCACNaCXfLS79
         uCnfYlTKAYojz7W5uBkQPxlHv478EpMmLZP1LNIKQ58ZVbxo+rEBudvJa4diSvRIvn2h
         YRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=W11G8KOKO0fe1jEMu72qehVZONI87KeyD8+Vm5Xf76U=;
        b=UV+VTbS96WkUnyCsALu6L04QRggwGybIQ/I3Z9K410pG5cP+exeXXXyjxdSo2rrdmi
         w27oPqNUTqRD1FcfyMIwKYtU0D008Eq9EmGOAjmKhDv0HxvJgcO+T/awIhi9xP98eFHL
         UVB6G3HYgBvQM4wyEbR5nbj/+bd+XHwdRLrptYYhK0wVpIEy4+lkoAl55F0+KrAUBepo
         hs9tP+DYggFs2ljzLGG5yClSD4X06dz51XEt0SRi+u0TMnwyoHGjrytKvkxpYIlTFWJJ
         zjfvUPWrViL5i/aJPZcXC8Q7N2Jy4UWHBdZ/e3JMz/KUwQbdeNcMKfe07TJmXaNgHk6Z
         c2Yw==
X-Gm-Message-State: AOAM530dH0jG9cd00v05D8vH1Akmeq8B4s5EQvxf+Ggr9cYGtFpz+fv1
        nRXuA4ZAQ52rKcF6e2Wj/NlnOKyV2afTOpc6ZFrjfbxNLNt3UA==
X-Google-Smtp-Source: ABdhPJxGZpEtTNJNY8srJCMQx1uA1lWF7NpqUotUHbEwy5YC9/+Xwh7r4cHpRs7imbRArXjCsHhKGB4n1PjRv1viREw=
X-Received: by 2002:a17:902:8f8f:b0:14a:766:67f1 with SMTP id
 z15-20020a1709028f8f00b0014a076667f1mr6600855plo.34.1641941360403; Tue, 11
 Jan 2022 14:49:20 -0800 (PST)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 11 Jan 2022 14:49:09 -0800
Message-ID: <CAPcyv4j0NfC4RKr=VU6yUKrqVRKdAer9YeSezRctpp-k31iAzA@mail.gmail.com>
Subject: [GIT PULL] Compute Express Link for 5.17
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17

...to receive the CXL update for v5.17. The highlight is initial
support for CXL memory hotplug. The static NUMA node (ACPI SRAT
Physical Address to Proximity Domain) information known to platform
firmware is extended to support the potential performance-class /
memory-target nodes dynamically created from available CXL memory
device capacity.

New unit test infrastructure is added for validating health
information payloads.

Fixes to module reload stress and stack usage from exposure in -next
are included. A symbol rename and some other miscellaneous fixups are
included as well.

This has been in -next for several weeks with no reported issues / conflicts.

---

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-for-5.17

for you to fetch changes up to be185c2988b48db65348d94168c793bdbc8d23c3:

  cxl/core: Remove cxld_const_init in cxl_decoder_alloc() (2022-01-04
17:29:31 -0800)

----------------------------------------------------------------
cxl for 5.17

- Rework ACPI sub-table infrastructure to optionally be used outside of
  __init scenarios and use it for CEDT.CFMWS sub-table parsing.
- Add support for extending num_possible_nodes by the potential hotplug
  CXL memory ranges
- Extend tools/testing/cxl with mock memory device health information
- Fix a module-reload workqueue race
- Fix excessive stack-frame usage
- Rename the driver context data structure from "cxl_mem" since that
  name collides with a proposed driver name
- Use EXPORT_SYMBOL_NS_GPL instead of -DDEFAULT_SYMBOL_NAMESPACE at
  build time

----------------------------------------------------------------
Alison Schofield (1):
      ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT

Dan Williams (8):
      cxl/pmem: Fix reference counting for delayed work
      cxl/core: Convert to EXPORT_SYMBOL_NS_GPL
      ACPI: Keep sub-table parsing infrastructure available for modules
      ACPI: Teach ACPI table parsing about the CEDT header format
      ACPI: Add a context argument for table parsing handlers
      cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers
      cxl/test: Mock acpi_table_parse_cedt()
      cxl/pmem: Fix module reload vs workqueue state

Ira Weiny (3):
      cxl/mbox: Remove bad comment
      cxl/memdev: Change cxl_mem to a more descriptive name
      cxl/memdev: Remove unused cxlmd field

Nathan Chancellor (1):
      cxl/core: Remove cxld_const_init in cxl_decoder_alloc()

Vishal Verma (1):
      tools/testing/cxl: add mock output for the GET_HEALTH_INFO command

 drivers/acpi/Kconfig          |   3 +
 drivers/acpi/numa/srat.c      |  59 ++++++++++-
 drivers/acpi/tables.c         |  87 ++++++++++++----
 drivers/cxl/Kconfig           |   1 +
 drivers/cxl/acpi.c            | 237 ++++++++++++++++--------------------------
 drivers/cxl/core/Makefile     |   2 +-
 drivers/cxl/core/bus.c        |  26 +++--
 drivers/cxl/core/mbox.c       | 186 ++++++++++++++++-----------------
 drivers/cxl/core/memdev.c     |  55 +++++-----
 drivers/cxl/core/pmem.c       |  20 ++--
 drivers/cxl/core/regs.c       |   8 +-
 drivers/cxl/cxl.h             |  10 +-
 drivers/cxl/cxlmem.h          |  37 ++++---
 drivers/cxl/pci.c             | 120 ++++++++++-----------
 drivers/cxl/pmem.c            |  85 ++++++++++-----
 include/linux/acpi.h          |  34 ++++--
 tools/testing/cxl/Kbuild      |   3 +-
 tools/testing/cxl/test/cxl.c  |  68 ++++++++----
 tools/testing/cxl/test/mem.c  |  99 +++++++++++++-----
 tools/testing/cxl/test/mock.c |  30 ++----
 tools/testing/cxl/test/mock.h |   6 +-
 21 files changed, 675 insertions(+), 501 deletions(-)
