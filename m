Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C70DE2F3231
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Jan 2021 14:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbhALNuj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Tue, 12 Jan 2021 08:50:39 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34955 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbhALNuj (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Jan 2021 08:50:39 -0500
Received: by mail-oi1-f176.google.com with SMTP id s2so2390762oij.2;
        Tue, 12 Jan 2021 05:50:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzLjfKbap56hNQt8zCr5eINZRU89Feh7WJmB8qJ3UiM=;
        b=Zwq8VNN3bQRuBliVl4qyRQgKJ5PYpfENwABQEctRtg1al5MDSof+fJIQFPYnAoH/tj
         LluraZpBmCBwSqtzLZ3A8Lvn9W90J5GesTI9hMBo4GgnVbjodm7+S3eyIx2bTnu2Q77m
         9PorM1lyHVtSWSWcgtC4RLQy/f0YCokBiQLlJw4NKQGGZmBkt8VxjvYMDygSe2/uJEBA
         dSFkpqV6Fr2TXmIzY5LyJztXOjRPHjj6K7FO9COb1kjvDFLLKwA0Nq/chWooI4NKygtH
         9nbwjFt9BrtlFr1Qsxul3KIMjjYiNQUvcfcQcwDkXMKlbYbbl2lCcDvg6gZggPsqcLrH
         Qd6A==
X-Gm-Message-State: AOAM532xzo7O54O8cjyk1lXOl1ZBJWpOpsfYmTDEiQYXRwgZ43SkRwWR
        yJuDYSzlsaSWY9LgKzwKQjbCdS1ltJb8i7Vo8k6TKNRA
X-Google-Smtp-Source: ABdhPJy9BZ64g8q2StwTZAAIAMvc+dlWXYdWI1Jgqigh9G/nHpAaP5q9RMsVRAKMrXWV9W9mCYefBJHupj10cA9bSdM=
X-Received: by 2002:aca:4892:: with SMTP id v140mr2379482oia.71.1610459398177;
 Tue, 12 Jan 2021 05:49:58 -0800 (PST)
MIME-Version: 1.0
References: <202101081623.CGkLO3Kx-lkp@intel.com> <5e7a4d87-52ef-e487-9cc2-8e7094beaa08@redhat.com>
 <106d7891-230f-18e1-1b0f-cb6a62cf0387@flygoat.com> <01442a77-7d87-5a12-d7b8-4fe397a37464@redhat.com>
In-Reply-To: <01442a77-7d87-5a12-d7b8-4fe397a37464@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 14:49:46 +0100
Message-ID: <CAJZ5v0hUrNd9HCY66mw6_Vab0JrgNwJYV_PgaT6fkd1+j8UBtw@mail.gmail.com>
Subject: Re: [pm:bleeding-edge 20/29] drivers/acpi/platform_profile.c:67:33:
 error: passing 'const struct platform_profile_handler to parameter of type
 'struct platform_profile_handler discards qualifiers
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 12, 2021 at 1:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 1/12/21 1:07 PM, Jiaxun Yang wrote:
> > 在 2021/1/12 下午6:42, Hans de Goede 写道:
> >> Hi,
> >>
> >> On 1/8/21 9:52 AM, kernel test robot wrote:
> > [...]
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >> All errors (new ones prefixed by >>):
> >>
> > [...]
> >>>     2 errors generated.
> >
> > Oops, thanks for the reminder, I should exclude 0day CI from mail filter.
> > It's wired that GCC didn't say anything about it.
> >
> >> Ugh, so that means that the current version of the
> >> "ACPI: platform-profile: Pass profile pointer to driver callbacks"
> >> patch is no good. Since this is causing compile errors I assume
> >> that it will be dropped from the bleeding-edge branch.
> >> Is that right Rafael?
> >
> > I'm not familiar with x86pdx and ACPI workflow.
> > Should I resend the patch or send a fixup patch?
>
> I believe a new version of the patch is best, then Rafael can
> replace the broken patch. We want to avoid having a commit in
> git history which does not compile in some cases, because that
> creates problems when git bisecting.

That's right.

If the plan is to drop the "const" everywhere, I would appreciate an
additional patch to do that on top of the two from Mark and a new
patch adding a new callback on top of that.
