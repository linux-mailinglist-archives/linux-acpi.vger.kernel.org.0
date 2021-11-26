Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E519745F54E
	for <lists+linux-acpi@lfdr.de>; Fri, 26 Nov 2021 20:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhKZTn3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 26 Nov 2021 14:43:29 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:42963 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbhKZTl3 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 26 Nov 2021 14:41:29 -0500
Received: by mail-oi1-f179.google.com with SMTP id n66so20591567oia.9;
        Fri, 26 Nov 2021 11:38:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F9WHBsDLTzuit4FpL95JXqUXCEDgLzm46M8tiPrpblo=;
        b=IslsSqvKbM35zNe++g6CRj8TJ2wnMyRMiM5UXXGGbsuooazcTucLGvy+bG97Jq6LBt
         T8FYMKHHavu7A6GvpyIsOYRQtAFGKNc8fOCNv470g6xrtyUqQuMiSp+FBl8cWpDn6d4t
         YiB3yo76K9c6a180SSHcGG+VR6a6qW7N++NQ7UuEsuwc2f7XlYy1K2noOHpyo71qzIE5
         AF5EKtmcVI6qDsg0+3FLh0BzCg+wqYI5a92L9YMqCcNWSf/NePj+Hfjh94J73za92rWA
         3ufjbN5L8c0P3+Yhd7bXKlHxdRVuEiK4DJf80HNbJcKhJlIRsZBALkAKj+Ntq1DepURM
         JSLQ==
X-Gm-Message-State: AOAM532KqvM9fhZxvhMJyuYqcKSGrAMw7msNrJWyNASZ6JPEJtiDzGjK
        pN8g3iQtdgvJCZcJC68XBBzzFW3rhSk7d5JZabIplOJ9RsM=
X-Google-Smtp-Source: ABdhPJxDuNFd5kP8PSZzKLlxI8I7yqqCWq8JrwFtCZ+uIOI9GIMxK3nSuVvjhKTtdG61/NUxeoKptwCjDCwJ2ahRLAo=
X-Received: by 2002:a05:6808:14c2:: with SMTP id f2mr24949459oiw.154.1637955496108;
 Fri, 26 Nov 2021 11:38:16 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 26 Nov 2021 20:38:05 +0100
Message-ID: <CAJZ5v0hQaF-ANLc4JO=Ub_JMsqLFpZev_gmpb=NPpg=zmqcauA@mail.gmail.com>
Subject: [GIT PULL] ACPI fixes for v5.16-rc3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-5.16-rc3

with top-most commit 2e13e5aeda156f747919c7111723b9302836fb38

 Merge branch 'acpi-properties'

on top of commit 136057256686de39cc3a07c2e39ef6bc43003ff6

 Linux 5.16-rc2

to receive ACPI fixes for 5.16-rc3.

These fix a NULL pointer dereference in the CPPC library code and
a locking issue related to printing the names of ACPI device nodes
in the device properties framework.

Specifics:

 - Fix NULL pointer dereference in the CPPC library code occurring
   on hybrid systems without CPPC support (Rafael Wysocki).

 - Avoid attempts to acquire a semaphore with interrupts off when
   printing the names of ACPI device nodes and clean up code on
   top of that fix (Sakari Ailus).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: CPPC: Add NULL pointer check to cppc_get_perf()

Sakari Ailus (2):
      ACPI: Get acpi_device's parent from the parent field
      ACPI: Make acpi_node_get_parent() local

---------------

 drivers/acpi/cppc_acpi.c |  9 ++++++++-
 drivers/acpi/property.c  | 14 +++++---------
 include/linux/acpi.h     |  7 -------
 3 files changed, 13 insertions(+), 17 deletions(-)
