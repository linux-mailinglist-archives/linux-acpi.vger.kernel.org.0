Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1078932F11D
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Mar 2021 18:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCER0G (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Mar 2021 12:26:06 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44077 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbhCERZe (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Mar 2021 12:25:34 -0500
Received: by mail-oi1-f174.google.com with SMTP id x20so3275421oie.11;
        Fri, 05 Mar 2021 09:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=D+0jVYmbc+noQchTievGiwi4tyUd7XxsHK+aRScLuas=;
        b=LmZRTK0KgFS0i9LWdES3QAC6jj3eLxg+n8pxidnlcicd41mkn4D2h+AwqSQ1r5GNGi
         6FuPg6G9rH0y5FtCWNewJD/82pcrWdA+q4y7CeUVRPcQEbr9fvfUdQulZ5YtT6JURSd3
         60L3eVEcnfzHleD+xdHm8pZ9IItzMWfSJ08wfZfLEpRtS/au1VwK8MYvWAjlKePcySIP
         ekE1qcdvOAHVV9lFjzg3sBVluEdoHk+ZrmTSpiB1b+BrVWuYxhF9T6IjxBYx1Hy5PlSE
         jZ9AX+Elatq0r1U1wTxY1U+SFb+2b3Gk/HnP2wX6RyYWbrqcenqdSuPocb6fKC+4OgEX
         nAxw==
X-Gm-Message-State: AOAM533Qcx0pOsCaP5sqO3b1DG2/G2dV/VjPP+RFX2YJWeKjgY1mV95n
        hmfZhnRKlmSykg9Mva/o4l3BYazhqxq6mjpHcxZHEf512/I=
X-Google-Smtp-Source: ABdhPJw0goefTdHQ42HEXayKXEqUh/6SKN7negU+eUMejUKLnhvHODIq3UQiVwN+DzH1Ozt3/ZhYNpF5E9ZL0abOGFA=
X-Received: by 2002:aca:3d85:: with SMTP id k127mr8235744oia.157.1614965134200;
 Fri, 05 Mar 2021 09:25:34 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 Mar 2021 18:25:23 +0100
Message-ID: <CAJZ5v0gVgrV3eeHtiVS715RJXOfd1-_nQR4D5J9a6ggjuUNokw@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v5.12-rc2
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
 acpi-5.12-rc2

with top-most commit ff70784ab9f89e78e67d5d172bf7644de673f61f

 ACPI: bus: Constify is_acpi_node() and friends (part 2)

on top of commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8

 Linux 5.12-rc1

to receive an ACPI fix for 5.12-rc2.

This makes the empty stubs of some helper functions used when
CONFIG_ACPI is not set actually match those functions (Andy
Shevchenko).

Thanks!


---------------

Andy Shevchenko (1):
      ACPI: bus: Constify is_acpi_node() and friends (part 2)

---------------

 include/linux/acpi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
