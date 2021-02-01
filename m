Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9095F30B1CE
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhBAU7F (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 15:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhBAU6o (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 15:58:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64301C06174A;
        Mon,  1 Feb 2021 12:58:04 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id e9so387568pjj.0;
        Mon, 01 Feb 2021 12:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jl2x4idr/8LE23SOnRpzWHW31Y2nI1o4N+NnWkaHBcY=;
        b=b4yI+5S4Am64ZFz7Sevb7dCOrsIDn+PCflvhjh09vulVBv5Yxn0Xt3Jhsn3aBqgp94
         mEbybBEgkgqior1b2gTEFhi1eB0qBUON2w6KWeg7fDzP7zNslPVzxmQCUkniYA/UHgvc
         jcbP6fj/noZSGcy37Orpnp84wxWycnsEVv6HhTquM/LijBacy212VHUFdFpmz9ej5Eam
         v183TH7nS5Uuro5WlMLU53eUd2spmJBmn6BRSame22HSDxIYWQdKEWX6Xgi2+Z7NpxmE
         PdfHcKupSCXPat0RmiMGjKamRarqUhnNcjBb/khZNJdnsE7BYhCSGD7oafW3AQuO7f30
         XiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jl2x4idr/8LE23SOnRpzWHW31Y2nI1o4N+NnWkaHBcY=;
        b=VqiiEakCh3Se7SexGezfIlTBI7qZfvA5yCtER558BCdYZnPGQCifG3PgLjGnujmTwo
         XOu0wkyxmq9t0gjZmf8TEGNp9RFhW9vyDdTk1caDdvZyknvzFckU5qc1pIxS6qT/c1rb
         pX/PiXNrTT6H6C+fEvKgLAcscMSyZFs19S7JsZAlgCPQsBeC5J1D0nRGzRWMg0VjVsUZ
         KSAtvWu3yvM3lN8VuxW+XlafGM0M/Y88CGriE0Vh6786sOgl3YrKgV6AFVVg6DD2EiGd
         9kJflo4rqOTr7ROSeMGCrBf62Tjx8RymfxYnauiepWJYGW33Qyjvls/bjOfY20c1Yar2
         gCxw==
X-Gm-Message-State: AOAM5339DBLQ1/74H+h/6+Gz1NLeqAbxNF0BpaWfeHJdw9LcpxXL74M2
        3vgWHI01XiyAeD30kuSEaWXh4bY+B7KAd2jqWpE=
X-Google-Smtp-Source: ABdhPJwNka49ycU5pdtTxMjP+hfQVh3l423R6IOSwz8+T+O1QIRf6d/l+l4MYMncVpe8lOe012lk2ekq8VOyfy88OHc=
X-Received: by 2002:a17:90a:c84:: with SMTP id v4mr732625pja.228.1612213083824;
 Mon, 01 Feb 2021 12:58:03 -0800 (PST)
MIME-Version: 1.0
References: <20210125193948.56760-1-andriy.shevchenko@linux.intel.com>
 <20210126082101.GD4903@dell> <YA/xfxcwCabETug6@smile.fi.intel.com>
 <YBhLuNZ7xmHdhurU@smile.fi.intel.com> <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
In-Reply-To: <CAJZ5v0jQLZ7hEn7nDN8AADy7djnrQRrC4jtXKY-YqZiO609_2A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 1 Feb 2021 22:57:47 +0200
Message-ID: <CAHp75VeYdATpv=PTWqq0--JLqJrGaiMhZEucjY7Fc5GPP+AqMA@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] mfd, x86: remove msic driver and leftovers
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 8:52 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Feb 1, 2021 at 7:45 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:

...

> Speaking of which, the patches here are requisite for SFI support
> removal, so I'd like to route them through the ACPI tree if that's
> fine by all of the interested parties.

Fine with me!

-- 
With Best Regards,
Andy Shevchenko
