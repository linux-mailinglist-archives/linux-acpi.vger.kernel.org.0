Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B54853B4807
	for <lists+linux-acpi@lfdr.de>; Fri, 25 Jun 2021 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFYRLy (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 25 Jun 2021 13:11:54 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:38812 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhFYRLx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Jun 2021 13:11:53 -0400
Received: by mail-ot1-f45.google.com with SMTP id x17-20020a05683000d1b029045fb1889a9eso9519042oto.5;
        Fri, 25 Jun 2021 10:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y+5z09ET9rmHIXvmXsjPmo0TKU8YqEtXoBdjlMUbcbk=;
        b=PBhsj7+tls/rWETfU8jGZ1fv5dAywdBpJgZ3QrY3vE5v5w+xt7KTbAgdtjSAZUhTDP
         h6P9Zfajj/GenLGVpTqrCR/PFXAkgZj+jrEyV25AN7tzxOPYX0/90PKHNR3uzE/MOkV4
         cSQJL81V/ySMuI1DTh3fcF9A5VX62yWv669dpXEOXVCpz1+e6hAkaUDJ7Pyz+C2PftVK
         vg9tDBt2uenbHQ4GuvdF64OfdFXAu2kYrl5qo/RULHJCQpqzsFCho8Nps0kCWwqZkiUE
         WHV3qLNMCBY1sochYo1uMjqkXjzu0FW487ZI68kE0F1O5NWP/exyYw4zm8dmDp2gaCfz
         191Q==
X-Gm-Message-State: AOAM530DaEiHUcFeRpRYPR9iE/IwJtGSBozRnxRZOFi12yJnRrJ6L/0g
        JmWDGq7997SGxEoPdmM+dAohjirOIxF8ND67CEGpeS17xHY=
X-Google-Smtp-Source: ABdhPJyDi5WiiBhtozO4yTZWAluSmKoCeD/nja1BecxsML0m5cn+k/2eckQrazAF7S28lwyah2w/AzVlfUHMZLezzvY=
X-Received: by 2002:a9d:674b:: with SMTP id w11mr10607120otm.260.1624640972031;
 Fri, 25 Jun 2021 10:09:32 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 25 Jun 2021 19:09:21 +0200
Message-ID: <CAJZ5v0gpxRL=B_PaUDRzyiR5z17r_6omrCk-DWM+=dG5=xSJiQ@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fix for v5.13-rc8
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
 devprop-5.13-rc8

with top-most commit 5dca69e26fe97f17d4a6cbd6872103c868577b14

 software node: Handle software node injection to an existing device properly

on top of commit 13311e74253fe64329390df80bed3f07314ddd61

 Linux 5.13-rc7

to receive a device properties framework fix for 5.13-rc8.

This fixes a NULL pointer dereference introduced by a recent commit
and occurring when device_remove_software_node() is used with a device
that has never been registered (Heikki Krogerus).

Thanks!


---------------

Heikki Krogerus (1):
      software node: Handle software node injection to an existing
device properly

---------------

 drivers/base/swnode.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)
