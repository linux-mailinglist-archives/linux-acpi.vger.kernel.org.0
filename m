Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB3C3B7838
	for <lists+linux-acpi@lfdr.de>; Tue, 29 Jun 2021 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhF2THy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 29 Jun 2021 15:07:54 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:38444 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234903AbhF2THx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 29 Jun 2021 15:07:53 -0400
Received: by mail-oi1-f173.google.com with SMTP id t3so4508474oic.5;
        Tue, 29 Jun 2021 12:05:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=GBuhUt0WuLcN+kq+yGwU2a2JtwgMbACwPa/dWz/hDXQ=;
        b=DUjVZaPgY4hsMmi8VLbJcAfFDpjJ4TJfnu2NZyR6qu/R505Jui93mRvqgvwbl7V8We
         vcNl0g/0MGq8TzimFdiPeWEmWS8BVpdiKp9I5CfhGl2HXFnIlIRkNy+mRZ1Bu6RT5sDi
         rcnY9AmHgjxGxHgs5J+haDAWiYPdz+E1Lw8ftNx8be7SkbVNEOl/vpXb9tY8ZpbSggJP
         S4Xns6gv9PX0EF/pCOccbEWlht6Fv1Uj8aUQoprlefuOAT111IxQHfqZ7u6aQWVZ0MjO
         FGzllt04YVvn9Q+sy64WQ2OxnBoJENwLwr9RGpHCAeIqnNwtneadBCs1ImF5z5LVblJ+
         PQEQ==
X-Gm-Message-State: AOAM533w/G+fBsx/yaPtJX6+sMGSNE/KtKDz4jAMKRDPKmXyxiEloUvq
        OiJKm8o1/lnejnorFHdZr/lYXqrwP9wE9wqFBT4=
X-Google-Smtp-Source: ABdhPJz5SSwM3dSsMwODQX4YOchzW4OLSKagsOH51Lp4iI4cGAOroz+seMJ2+XJGtizW4PUEbXf2rGXe67XTFskAb1U=
X-Received: by 2002:a05:6808:15a6:: with SMTP id t38mr248818oiw.157.1624993526012;
 Tue, 29 Jun 2021 12:05:26 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Jun 2021 21:05:15 +0200
Message-ID: <CAJZ5v0jWTynLe9jQ+KnPU97ed4CQ35dKssuXQHDEPdwMqtyqgA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework updates for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-5.14-rc1

with top-most commit fb38f314fbd173e2e9f9f0f2e720a5f4889562da

 device property: Unify access to of_node

on top of commit 6efb943b8616ec53a5e444193dccf1af9ad627b5

 Linux 5.13-rc1

to receive device properties framework updates for 5.14-rc1.

These unify device properties access in some pieces of code and
make related changes.

Specifics:

 - Handle device properties with software node API in the ACPI
   IORT table parsing code (Heikki Krogerus).

 - Unify of_node access in the common device properties code,
   constify the acpi_dma_supported() argument pointer and
   fix up CONFIG_ACPI=n stubs of some functions related to
   device properties (Andy Shevchenko).

Thanks!


---------------

Andy Shevchenko (4):
      device property: Retrieve fwnode from of_node via accessor
      ACPI: property: Constify stubs for CONFIG_ACPI=n case
      ACPI: scan: Constify acpi_dma_supported() helper function
      device property: Unify access to of_node

Heikki Krogerus (1):
      ACPI: IORT: Handle device properties with software node API

---------------

 drivers/acpi/arm64/iort.c |  2 +-
 drivers/acpi/scan.c       |  2 +-
 drivers/base/property.c   | 31 ++++++++++++++-----------------
 include/acpi/acpi_bus.h   |  2 +-
 include/linux/acpi.h      |  8 ++++----
 include/linux/property.h  |  2 +-
 6 files changed, 22 insertions(+), 25 deletions(-)
