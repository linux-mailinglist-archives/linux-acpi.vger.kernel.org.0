Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D908510E35B
	for <lists+linux-acpi@lfdr.de>; Sun,  1 Dec 2019 20:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfLATzK (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sun, 1 Dec 2019 14:55:10 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42521 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727169AbfLATzK (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 1 Dec 2019 14:55:10 -0500
Received: by mail-oi1-f194.google.com with SMTP id j22so113861oij.9;
        Sun, 01 Dec 2019 11:55:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GVnqatJjkI2d785STQM/Hp3Qg4fwIew62MDkFU1VYf8=;
        b=U3EYuS1dxNyqC6fvDfyJSmYGUhKM+qULTL6KGwTzYw2vpowLgnslT2YQattbTQSvYh
         Umu5OIVLuvmjJYGVhA5V1t35308+3Znj/yS0xk/DomYLPD4Imh5rdqWpzZP4vWwudULj
         vQeBM1/KASYzJgMxDwBJeWN1LtDodhViXHC1gvfevDEhfo406hZHMJFGG2UmNnLnwF0n
         EpRV/YX4spdUf7OYJTHUICl3OP1xZp5T31updUm9NmWNkvyq1uMyr2swqghWOQwHutha
         EzWkt8r6BwprG1SUbmQ5LY9QuPPEajJQdQy2KnoPL4d9nozkSXKLYv7n4Tmht9Y98qiB
         e4hg==
X-Gm-Message-State: APjAAAWzGA+u8F+3w8ywfj/Cb38kW5vLV/pUtNGT/LeNHNyj/7a7O7eW
        veSzXLV9jwNxUZkA4JE4GS/lQ4KtsoZs7Qpy447DIA==
X-Google-Smtp-Source: APXvYqxYLEKiaOGbRHJtdfln7+8FKWBYWG4GovfMLAoWPyghhvhXxos1xzBDaToO1KvOAi52s9rIRcX4BB+nubxdKaU=
X-Received: by 2002:a54:488d:: with SMTP id r13mr8948358oic.115.1575230109255;
 Sun, 01 Dec 2019 11:55:09 -0800 (PST)
MIME-Version: 1.0
References: <2787005.CsmIKtZlk9@kreacher> <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911291231510.6038@hp-x360n>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 1 Dec 2019 20:54:54 +0100
Message-ID: <CAJZ5v0hiSnjZ=ZuSqDsQK6CDxyFRMhUVWL+UP-QJoj9vkLo2vg@mail.gmail.com>
Subject: Re: [PATCH 0/2] ACPI: PM: s2idle: Fix possible suspend lock-up
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Nov 29, 2019 at 9:35 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
>
> On Thu, 28 Nov 2019, Rafael J. Wysocki wrote:
>
> > Please test this series and let me know if it works for you too.
>
> I've tested this quite a few times against the issues reported on the Linux-PM
> mailing list ("resume failures if the charger is plugged in while suspended
> and the battery is at < 90%" and "spurious wakeups from the EC for non-power
> events") and this patchset has fixed both of these issues (the latter is
> especially surprising and welcome).
>
> I'm pretty happy with it; it's been a while since I've had a consistently
> cold laptop while suspended. Much thanks!

Thanks a lot for the testing and feedback, much appreciated!

I'll queue up this series for the next PM pull request.
