Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B54308C38
	for <lists+linux-acpi@lfdr.de>; Fri, 29 Jan 2021 19:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhA2SO3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 29 Jan 2021 13:14:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbhA2SOR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2021 13:14:17 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FCC061573
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id v24so13743650lfr.7
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 10:13:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=KC10zSx5MFsfUUjYlG6FRCOeTyTcwX7GVvNaLYrrrt8YFffoMdY92Rh01gJr6XlSmY
         4I2StG06IDQKqqKiAqu88gHc4seS5CORwF959YMHVWmCmchm1b7Bn3A7fg/tBq+MM9y4
         8yDFzSkj9aLzlG6YxJyYupJOThB0naFT27zWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbXatH+jIZoABuAUJLGiKBIVUtMrRLBvUtpWT54lNmk=;
        b=c1DPSit+tA3twhTmjv6bz4dzv0qVVigDN1glMxV5IjnBLWoftv2UgmJUikqni+LfUK
         gQNuoJMiLxpKJC065f63F6C4Eni/7R4Ec4Rb3hAYDt5tCyzV7ZpMTj5uT5S9/Xi6jWxR
         yZnhO7ZEq79vM8pqvAoBoLJ6GgYrQp/zHJErGOcrUS9RVVsuEx434P+QmavJQDTqwDje
         WWot83WunRVVJ377hYhNZQtIVLPqD/YAx8s0fzWT0kzpCXaI8dJ8OL1hsGl4wXwtCkOt
         dz1XnaDQRazEWcCAiUI0sXVtSk9RlsLiq2sl3mTXK2+srfNOlgM1PvVowrojnHTMiqp4
         TQMQ==
X-Gm-Message-State: AOAM531FnGBuNSNfY4tVY2vb2zi03qC6qKdTj9uvVmxAZc7DyJdzlPpD
        l4Y2S+OB7+TULcSWxtVzmKA6zcbxcTY/BQ==
X-Google-Smtp-Source: ABdhPJz2j0MDb7e+n2icsQKaqzUh9j+b2ipH9MkO34q1Xi3hE5mH+TAcKlH588RyBZIiVZCjxRNyrA==
X-Received: by 2002:a05:6512:60e:: with SMTP id b14mr2618491lfe.373.1611944011644;
        Fri, 29 Jan 2021 10:13:31 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id x19sm2114423lfr.144.2021.01.29.10.13.30
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Jan 2021 10:13:30 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id h12so13740513lfp.9
        for <linux-acpi@vger.kernel.org>; Fri, 29 Jan 2021 10:13:30 -0800 (PST)
X-Received: by 2002:ac2:5502:: with SMTP id j2mr2617310lfk.421.1611944010487;
 Fri, 29 Jan 2021 10:13:30 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0is8qQ91Nx_hhMgc3Ga8NgFbE-JAu03=M-L9sCpf8pVmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Jan 2021 10:13:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Message-ID: <CAHk-=wh2vddZUVEQ4Fn3Oy5q70WNGP3C7bAwxsnXkjP02rVjbA@mail.gmail.com>
Subject: Re: [GIT PULL][Resend] ACPI fixes for v5.11-rc6
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 29, 2021 at 10:11 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> [Resending, because it hasn't made it to the mailing lists, not sure why.]

I see it, and I see the cc to the list, so it is likely something
about the list being slow or subtly broken.

There was another pull request a couple of days ago that apparently
had the same problem (and didn't get a pr-tracker-bot reply due to
it). I forget which one.

               Linus
