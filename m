Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925972C4747
	for <lists+linux-acpi@lfdr.de>; Wed, 25 Nov 2020 19:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731310AbgKYSKs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 25 Nov 2020 13:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730774AbgKYSKr (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Nov 2020 13:10:47 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF00C0613D4
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 10:10:47 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id x25so4256398qkj.3
        for <linux-acpi@vger.kernel.org>; Wed, 25 Nov 2020 10:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l5xM0WWt/jkF9DKKLvJ1sR0pb3zOF+Q6gsRxfvSpR6g=;
        b=tCmj0Fi7oSsbasDbtJtzqpFqRRNnW4wk7tvxDZpRTa2syKniCrjtQwiqNqKneYjCdh
         YMiY0cmrUa5jZAkLfE+kTzEsi8suLEIzr+pRw+w7A15MQK3xH0urliWY5RW8F275mE6J
         GamUBeD49OY4MQBFsrx+d4NdZlfqFybFi3cP4hh0W3QKSWxi2EMqR9ZUkITQdI1paeqf
         tPy1kRQDKljMyLwF7158vtn1/KPhjIMqeq/69tg8bX+07m6t2Ame7csLSlELGCLh6R8c
         przud8LrAgP/MHp91GjFjqE25hff5qWsVnjgAweQ/lU8ROeC+zttUcue9ns4+CRKFxpJ
         ZyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l5xM0WWt/jkF9DKKLvJ1sR0pb3zOF+Q6gsRxfvSpR6g=;
        b=ffkHHe1gVFeTvp6dj0zA/Q/GP0nvMpoRmJrnsQOFzg0pehtHoU3+Yl14GWa/vDc1fN
         YUsHZg6EuzzcP5ArViSX0WcG3okvcvhCnArJpOKNiI8BbwDUK6Q0HfAld2CVUF4dPkhq
         YwNhzW6b0a87wpubSfYnjBmJc08P8Jvn4V9oAhFIBEjRoV0mxxqpEG7oKye56kW7qMgV
         sRPxU3AJA/u5KsPoipIxPGY+1iB8Wx5igJjvfUb1AYo2BW9p6ByyoJ/rLu170vkNlmli
         LbLeRclsfIkbWEZyLvn2mxhcE6GXqXVV+jvrpfnDoOOqZrTpcUA72ZnIBnWh5iDoiItJ
         EuuQ==
X-Gm-Message-State: AOAM532La5yXBgD/F8kib5Fg09feu+09I0LGA2KgnunrT1d1wpGlD69O
        6wVFikRUQPyjPOQdUnT5I7+wpdPDzsiyJO2gm+xTrcQnxxOFYQ==
X-Google-Smtp-Source: ABdhPJySfhbIxRlLjp5I/W7uj4g7eIHGIVFItOZXq9FgtRUwmcmmct7PX1S+0/TPJx2HqhPlkebBq4bMdMpM0NWdIOY=
X-Received: by 2002:a37:5f42:: with SMTP id t63mr109619qkb.236.1606327846332;
 Wed, 25 Nov 2020 10:10:46 -0800 (PST)
MIME-Version: 1.0
From:   Pedro Ribeiro <pedrib@gmail.com>
Date:   Thu, 26 Nov 2020 01:10:35 +0700
Message-ID: <CAEDdjHdmyMSZo=A7gtnKTXqwzzH+ynUw_yFbXd8f9kxOUODkrQ@mail.gmail.com>
Subject: Legion 5 backlight control not working
To:     linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

I have a Lenovo Legion 5 15ARH05H and I'm trying to get the backlight
control working.

This is a laptop with an AMD APU and NVIDIA GPU. It works in a Hybrid
graphics mode with both GPU on, or a Discrete graphics mode where only
the NVIDIA GPU is on and the AMD one is disabled. I always run the
laptop in Discrete mode.

I have tried various NVIDIA driver versions, and was able to get the
backlight working on kernel 5.9.1, but I have no idea what I did to my
system, a few weeks later it stopped working and now I can't get it
back. Tried various kernel versions too, kernel configs, etc, nothing,
the backlight just doesn't work.

It doesn't work either via the /sys/class/backlight device nor via the
hardware keys. On Windows everything works fine.

Every time I boot, I get this in dmesg:
[    1.057696] ACPI BIOS Error (bug): Could not resolve symbol
[\_SB.PCI0.GP17.VGA.LCD._BCM.AFN7], AE_NOT_FOUND (20200717/psargs-330)
[    1.057753] ACPI Error: Aborting method \_SB.PCI0.GP17.VGA.LCD._BCM
due to previous error (AE_NOT_FOUND) (20200717/psparse-529)
[    1.057806] ACPI Error: Evaluating _BCM failed (20200717/video-357)

I believe this is related to the brightness control problem, can
anyone shed a light on this?

Regards,
Pedro
