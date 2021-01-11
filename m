Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52202F1FDB
	for <lists+linux-acpi@lfdr.de>; Mon, 11 Jan 2021 20:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389077AbhAKTvg (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 11 Jan 2021 14:51:36 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41280 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbhAKTvg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Jan 2021 14:51:36 -0500
Received: by mail-oi1-f169.google.com with SMTP id 15so569434oix.8;
        Mon, 11 Jan 2021 11:51:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBH8vdEZw4wobGGWgNS/lc2kPCRJEwAz0dTT6ck4Rmg=;
        b=GmS5TveI6di1Tsnky1gLf1UAnbzi0f+ZPyQn8ZC6bH32hIA+def6Hhqkf4Z0ZEGswg
         bf4l6WVb0fWqh4ycixalx2cSM3oA4nC7Vo81HaQL9ypxcrtnVH05ifC5j8eAyBWtsPDz
         s0baId64P8pjRlqJ2PkvYMhs+IlSrzAHvLoc2RbIkpsd2NKcXwkRO81hvVwbfIXJWRVv
         KyCqPTNvfXHK8jMZhSwYZt8ZrsBckWnTwhY0sCTAqXHpjp9Wmc1o5Y0EKHoFKNUvypUT
         HJgRAEg0hWggBrVgCQkS7zhS9Ix5FzHw199MxXbePQ0tZVHWTe21FLdIswFZEe0r2pwb
         RAzA==
X-Gm-Message-State: AOAM533oN78ziaeXRu/vJN6SQcOrSiUP+1xqrvB8Ijm9qlV8187CEQwH
        YswkRULxbJHSlOjtHxcCi7CY/4D6LDbVV0GsEQc=
X-Google-Smtp-Source: ABdhPJwGwAryPjBUePblwFBBrQdE7OAE/NKHxCygnLqPkc60x7YRiicxbM/qVaIM6xVBvrA6Gp0ryuFFiRy823Pr4sc=
X-Received: by 2002:aca:4c1:: with SMTP id 184mr276436oie.157.1610394655441;
 Mon, 11 Jan 2021 11:50:55 -0800 (PST)
MIME-Version: 1.0
References: <20210108072348.34091-1-decui@microsoft.com> <CAHp75VfPsMNZxN-hA3Cytjpm0K9xGoQpcGY_FZR4hUrtyqMj=w@mail.gmail.com>
 <MWHPR21MB0798C62978C2E6F23FAB953EBFAD9@MWHPR21MB0798.namprd21.prod.outlook.com>
 <5464224.fTvfEN5hHQ@kreacher>
In-Reply-To: <5464224.fTvfEN5hHQ@kreacher>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jan 2021 20:50:44 +0100
Message-ID: <CAJZ5v0hT4STe8wyxUWLjYkzHYnn9FgJWaabqJFZtz=eyGtjinA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Fix a Hyper-V Linux VM panic caused by buffer overflow
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "len.brown@intel.com" <len.brown@intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "dwaipayanray1@gmail.com" <dwaipayanray1@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jan 9, 2021 at 6:08 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Saturday, January 9, 2021 10:37:41 AM CET Dexuan Cui wrote:
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Saturday, January 9, 2021 12:52 AM
> > >>
> > >> Hi Rafael, Len, and all,
> > >> Can you please take a look at the v2 patch?
> > >>
> > >> The Linux mainline has been broken for several weeks when it
> > >> runs as a guest on Hyper-V, so we'd like this to be fixed ASAP,
> > >> as more people are being affected
> > >
> > > I would like to see a warning printed when the dupped
> > > string violates the spec.
> >
> > Hi Andy,
> > Do you want a simple strlen() check like the below, or a full
> > check of the AAA#### or NNNN#### format?
>
> It would be good to check the format too while at it.
>
> > Can we have the v2 (https://lkml.org/lkml/2021/1/8/53) merged
> > first, and then we can add another patch for the format checking?
>
> Yes, we can.
>
> I'm going to apply the v2 early next week.

Applied now with a new subject ("ACPI: scan: Harden acpi_device_add()
against device ID overflows") and slightly adjusted white space,
thanks!
