Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B99339631
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Mar 2021 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhCLSWL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 12 Mar 2021 13:22:11 -0500
Received: from mail-yb1-f173.google.com ([209.85.219.173]:38759 "EHLO
        mail-yb1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbhCLSWE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Mar 2021 13:22:04 -0500
Received: by mail-yb1-f173.google.com with SMTP id 133so26335278ybd.5;
        Fri, 12 Mar 2021 10:22:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Pii1IaLJeXJQq3umnW87gUW5P0EG1iDNJxRAAjnqsCw=;
        b=rjfka7CJSZB3rECrKWjworRAylZ+SKZKqtZkuHkIyKYfJKS75QFd7Az5tfH+mPANHz
         vW2k5MtpbtdYiFOG7kUv7UGTWNWqpBR12c1kAcMoS0paKET/zKmpcvAsTaMg6BUX/DEu
         iX1Q5l8Zj0mX0bJ2AP+0jvzqVRRu7ORYVAkqi3PKZqtmWHCRZIJiTkHqPhtQZctKIpj1
         YTazylYthLEjdCxrUjK4FichGVS0EQs29LPthQwHWCgW8+mFfOUUP6Yu6Utfpg66YxOC
         M8dDyz5/dJO5SNl6+NRktZ1whl1nR3U+8Yx1hlJ4Zanf32aWg694kKc62lyekzPKXIP9
         Ly3Q==
X-Gm-Message-State: AOAM533fZMX209XBQSbeTolbCQkbj4diA+/86hJuG/LWX/snYiIaBOuz
        BKLSvHSdOvmmPChwILm6yNScj8OnPOFhoqkNjW6xUXn9YW8=
X-Google-Smtp-Source: ABdhPJxqQLv3iomq0WXQrvpLgvwYBh1uo7vB/Nb42Zl61h9/fYO21lnndWhhYx8bAXEVPpg+4xoQessMqtO36G8NMlY=
X-Received: by 2002:a4a:d48b:: with SMTP id o11mr4246473oos.2.1615573323318;
 Fri, 12 Mar 2021 10:22:03 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 12 Mar 2021 19:21:52 +0100
Message-ID: <CAJZ5v0ikL-0es_QyQ5XQvxiaYp4a6B1VJ1by_7W2=vp-sWMznw@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fixes for v5.12-rc3
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
 devprop-5.12-rc3

with top-most commit 2a92c90f2ecca4475d6050f2f938a1755a8954cc

 software node: Fix device_add_software_node()

on top of commit a38fd8748464831584a19438cbb3082b5a2dab15

 Linux 5.12-rc2

to receive device properties framework fixes for 5.12-rc3.

These prevent software nodes from being registered before their
parents and fix a recent mistake causing already registered
software nodes to be registered again in some cases (both commits
from Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (2):
      software node: Fix node registration
      software node: Fix device_add_software_node()

---------------

 drivers/base/swnode.c    | 29 ++++++++++++++++++++---------
 include/linux/property.h |  2 +-
 2 files changed, 21 insertions(+), 10 deletions(-)
