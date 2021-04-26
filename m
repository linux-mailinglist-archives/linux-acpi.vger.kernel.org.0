Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C55136B8E8
	for <lists+linux-acpi@lfdr.de>; Mon, 26 Apr 2021 20:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbhDZS3Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 26 Apr 2021 14:29:16 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:36375 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbhDZS3Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2021 14:29:16 -0400
Received: by mail-oi1-f174.google.com with SMTP id i26so2006969oii.3;
        Mon, 26 Apr 2021 11:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lhhDnDrz7SxH0vtjl7AEWE9DYDGK7xa0xu0uNkl5/jE=;
        b=aekE8oXbP3ACq0ifp/EB6ivwW7+tIfQUD0+J8BulFJ9Vpia1uUQxEMTvxa7KTl15AJ
         13R5pg3VQWbM8tsyHbxtbVSia5A9O3xA/qtBMtS9Ih1MvGYeH1hH19W9IDGtkBrwMv2M
         tYZb/axqd1EHskQKi2QNj94RwSxy9qoogAPqBh6mJBv2XVvJP94wtzFywl8dXaedKGc/
         y6dW3yquhJ5o02ITv31rVxjxfpSlwLZxXqZXNNmFYXQPQ+TC9E3XSoGHQ9wJTNsSxmH7
         Lg65kIS2QYYDhbN0fGPHwWq8vS5oblLjK1tCKoa4hTt7J0NJAqeIlgmuYBvY8df5pqmE
         SCjQ==
X-Gm-Message-State: AOAM531PevLUMofZR9i99M6WUPa/Eo6JZLBsEkY4Bn3kdJnTf8H5vl9T
        HrC+y65B87HCcueYzz5wQV9BvBvhnrRLALHMg3khLj2Kyu0=
X-Google-Smtp-Source: ABdhPJwX5NzD1AEtUsJa2nVt/hDV8fJssFQOIkpi5kxLvt+F9Gn8TwdrQhJmR06DYgrfHit3N6DYp0mKxc296Zr973g=
X-Received: by 2002:a54:4501:: with SMTP id l1mr257436oil.157.1619461714383;
 Mon, 26 Apr 2021 11:28:34 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 26 Apr 2021 20:28:23 +0200
Message-ID: <CAJZ5v0hrpjNW8ZHULfkTsLMVyti-0H7gFgSySPwXsQMpTEf8nA@mail.gmail.com>
Subject: [GIT PULL] Device properties updates for v5.13-rc1
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
 devprop-5.13-rc1

with top-most commit 46b37c6e4b072d1440e82558aadd5b678627fec6

 MAINTAINERS: Add entry for the software nodes

on top of commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0

 Linux 5.12-rc3

to receive device properties framework update for 5.13-rc1.

This adds a MAINTAINERS entry for software nodes core code (Heikki
Krogerus).

Thanks!


---------------

Heikki Krogerus (1):
      MAINTAINERS: Add entry for the software nodes

---------------

 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)
