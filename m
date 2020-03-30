Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1A197F93
	for <lists+linux-acpi@lfdr.de>; Mon, 30 Mar 2020 17:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgC3P06 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 30 Mar 2020 11:26:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38218 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgC3P06 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Mar 2020 11:26:58 -0400
Received: by mail-oi1-f196.google.com with SMTP id w2so16029208oic.5;
        Mon, 30 Mar 2020 08:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=3ERbyzjjb9C/BS6z56ljJWImJZXslvyQibnwigyRCXM=;
        b=L+egwsr6JtmdfAKAHD4HdPk7gYHpVGpCoJdUYYyr154ZLwBYzG1lhiSDOKsDpL/gtO
         DF/jD2NXXmTu7OAzLZ3XHuImkwspMcybY1rGWis6Z8BJliL2rz0EKKAIZdoaEfmduEH7
         vxtCj0s0KTOjjE0h9F0yECCGbjq4UBHy4S6vh8WWZE3qki7p2EGTSCEOPoILfVvIoGP7
         K70iO7t6krTLPxdGGkI7p5US+uUsSVJ7867XoZ8akrG/Gpf3NhU4a2RFyZaUOWGf3gAx
         vguUhNjCQbEBXwiVj0ajpaO7coCHY5PS/Txzd3mZz6M1xRhcgXFH9SZ0XkxuHTtwZ7iC
         GbsQ==
X-Gm-Message-State: ANhLgQ1CYSWIFzqXux/hUun0tfosWGkRBYZpfoP8nO0dJ612IwTpP8ot
        +J/izDK8JJ6ovYhs+bUccEOfCg5seKclo2z5KLERednk
X-Google-Smtp-Source: ADFU+vssJKJGqzZ3Y9ujDijHuJGhRhWn2k+pl4QzbD5HVN3WZ7Uk9QkF0OXs5WFpxC9rsRL0qfBCfoJW1H+cGQYALhM=
X-Received: by 2002:aca:f07:: with SMTP id 7mr7681801oip.68.1585582017437;
 Mon, 30 Mar 2020 08:26:57 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 30 Mar 2020 17:26:45 +0200
Message-ID: <CAJZ5v0jLoTcE5WhFiJ_z6tUcuPrJs2SBe5id-7OWAd8AYw3n9Q@mail.gmail.com>
Subject: [GIT PULL] PNP subsystems updates for v5.7-rc1
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
 pnp-5.7-rc1

with top-most commit eaec20c7362c68176369f11e26dc0f6f994ae2d3

 MAINTAINERS: Add linux-acpi list to PNP

on top of commit 98d54f81e36ba3bf92172791eba5ca5bd813989b

 Linux 5.6-rc4

to receive PNP subsystem updates for 5.7-rc1.

Update MAINTAINERS to cover include/linux/pnp.h and add the linux-acpi
list to the PNP entry in it, add the const modifier to the name field
definition in struct pnp_driver and drop a pointer case in the RTC
CMOS driver that has become redundant (Corentin Labbe).

Thanks!


---------------

Corentin Labbe (4):
      PNP: add missing include/linux/pnp.h to MAINTAINERS
      PNP: constify driver name
      rtc: cmos: remove useless cast for driver_name
      MAINTAINERS: Add linux-acpi list to PNP

---------------

 MAINTAINERS            | 2 ++
 drivers/rtc/rtc-cmos.c | 2 +-
 include/linux/pnp.h    | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)
