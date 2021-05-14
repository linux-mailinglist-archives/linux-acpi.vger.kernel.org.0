Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA33806DA
	for <lists+linux-acpi@lfdr.de>; Fri, 14 May 2021 12:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhENKIF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 14 May 2021 06:08:05 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:42777 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhENKIF (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 14 May 2021 06:08:05 -0400
Received: by mail-ot1-f46.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso26030428otg.9;
        Fri, 14 May 2021 03:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiedF83E1JudxXyakWQmgvNTS81BZnLXWYIkM7bNNPY=;
        b=rlQoWtB+KUCjEQTMPhVvu0CjGmnHBJ4TlGnGX2c9JoGUQNIQR5+udqXsIbpR+qKaFi
         sRRmSOuD70xmnrZut1kFdu9RkvOFI9GoghtYan+38yhn1XAJdN1jDmXW9t7y03aTEkzI
         /5tnp3AUdXuyTBsauv1B5NoqPuzBuLcaz/OKV7gLvAKYUGQ20rUFMAVTUnloKDNh/UO0
         M5N9ABNdtRKsKniDUDx/NbrPczE2z4wMiBxQrgONtTQeLczDO5IMRsPx4bxRYZ3aP2zA
         VOR/TIBSaodatL8UQPHpiLzGNYOZ6HLjr+ZgxgFVuuSqWwU2DDdkyN8fYlcYu877J4si
         ZYOg==
X-Gm-Message-State: AOAM531xwtFTfxljE5R7uGJyfFRq5CLfOqj7pgBrwRtXAmZ0413UKAII
        e+yDrXSCUq3zvcFzhFbnGZJHr+AwEOZ9A9JUsPE=
X-Google-Smtp-Source: ABdhPJx/FWBPTIZB02IkFKI5Y5yKMGCwEbHzPsy1XPkZ/oE16jGLgEkSSn93mx2jMCVqUZjoHGCoWaAF+lQx1uwu5Sw=
X-Received: by 2002:a9d:5a7:: with SMTP id 36mr39643300otd.321.1620986813019;
 Fri, 14 May 2021 03:06:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0in2AeuGt-YRjKE5r4AKhu1kTf=zRfFWfb+cPFZL-NESA@mail.gmail.com>
 <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
In-Reply-To: <CAHk-=wjSF1Vozzmst-H_xgy20XZx0t55uBwn8B6Rqjhe0JfOwA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 May 2021 12:06:41 +0200
Message-ID: <CAJZ5v0jBPh=mfab69E7SvfQxvR6xDFmUdpOGsHtBK+A26zmXAA@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v5.13-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 13, 2021 at 9:27 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, May 13, 2021 at 12:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > These revert an unnecessary revert of an ACPI power management
> > commit
>
> I think it would be kind of nice to see more of an explanation than
> "was not necessary".
>
> The original report of problems was apparently wrong - but it would
> maybe have been good to just mention how that all went down..

In fact this was my mistake, sadly.

There is a pair of closely related commits and the report was against
the other one, but I reverted the one that I thought was more likely
to be problematic.  Then I realized that it couldn't be the source of
the problem, given the symptoms and the fact that reverting the other
commit alone helped.

So this one is back, but the reported issue still needs to be
addressed, most likely by quirking some systems with bugs in the ACPI
tables.

Cheers,
Rafael
