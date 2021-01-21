Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59CC62FF484
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbhAUTbe (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:31:34 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39440 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbhAUTGp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:06:45 -0500
Received: by mail-oi1-f171.google.com with SMTP id w124so3306682oia.6;
        Thu, 21 Jan 2021 11:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=auUhqe4c4epubCSjzDaZMmecS2XhKUMHupzG7J1XSwM=;
        b=MVARbRymDvvUmqgtfVvYPx4NgWBFnZIW72fKwCxVEIlCTzcp/tmVBTaXNLZkVOvdET
         Z/EclmfXdxeCzn2MWm+YncmZW0i9VJGuVIi8PK7UjZjNSlCoB5JgBZvgB556GXIDIbsv
         Hfalsg28bcBgEAu/8WoFLBr0HjxkFFKo60TuLlmK1pzC1ABO+JYw07AgvwKvIzg5DEk4
         tKlRjU1/J4bejvex02GL8K/ue2IDCKAKlmjZ/kFRd/xV9B1jL1O+v26v6am7olQ6D9s4
         RIMD96NA/mpIH0PhESPugk7sBxOa2m0OOvEXNh5cvySVmIIcfhven5JmGQJhx6qSYf/7
         iV8A==
X-Gm-Message-State: AOAM531AD2psh6+jdHh01mDhYTq7KeEz/gW/O/WFbToi7Fnkkbh+1xDi
        y/cLy7uFg5zn7qWzeD7vJ7ywZF3V0U5rewm6PvhFH1/5Jm0=
X-Google-Smtp-Source: ABdhPJzOsw6WyrFSwOqzvemVRDLX92DpP0d9JIy1Mn458RUoOriHw7mBTncToey8cqtOaxrtXsWwkl+izrLieDxbg3A=
X-Received: by 2002:aca:308a:: with SMTP id w132mr712050oiw.69.1611255964790;
 Thu, 21 Jan 2021 11:06:04 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jan 2021 20:05:54 +0100
Message-ID: <CAJZ5v0iN2y5wQNaY3nGEQkq2aXbNzGLHzU29tTqew65CdqTafA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.11-rc5
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
 acpi-5.11-rc5

with top-most commit 78a18fec5258c8df9435399a1ea022d73d3eceb9

 ACPI: scan: Make acpi_bus_get_device() clear return pointer on error

on top of commit 19c329f6808995b142b3966301f217c831e7cf31

 Linux 5.11-rc4

to receive an ACPI fix for 5.11-rc5.

This modifies a helper function in the ACPI core to match the behavior
expected by its users so as to prevent NULL pointer dereferences and
occasional memory corruption from occurring (Hans de Goede).

Thanks!


---------------

Hans de Goede (1):
      ACPI: scan: Make acpi_bus_get_device() clear return pointer on error

---------------

 drivers/acpi/scan.c | 2 ++
 1 file changed, 2 insertions(+)
