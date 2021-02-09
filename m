Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9649931522D
	for <lists+linux-acpi@lfdr.de>; Tue,  9 Feb 2021 15:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhBIO4K (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 9 Feb 2021 09:56:10 -0500
Received: from mail-oi1-f175.google.com ([209.85.167.175]:39221 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhBIO4A (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Feb 2021 09:56:00 -0500
Received: by mail-oi1-f175.google.com with SMTP id l19so7194079oih.6;
        Tue, 09 Feb 2021 06:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wfriFlXIrzFi4KX6VlE2iBQzZn4GFGemJfFKfjpFTU=;
        b=BLyaCcyhkwUBMXE3erWNwvx0yzG9ilvjV0lO+P0ru88jhduJ4vsW5yWqqQOYMZSSDu
         rc5ZXdbnqNBSDWOhk+KEehO0P1FMOdupIjnwBv3sS+1Snnp4Ck5e2D5xAdC8uXlKrqQH
         V+ysZbt9O1rrqz6Q5m+43LBLaOII+TmcqvwxyTm/5sT2emzx52wTYJiG+0dtHE+8s8Tq
         luLOpDfZFCSfGiojqSUxnkbeF9GRMTc63D7BlTXZF3aDTfdzMAwTxAY9B2HJFg7kYPsI
         pDvGWCFtfjstVYVsV5D8mpEAPnekzonuLN4ehL930JXVdcdUvVYZlTOGLRT8Bpcr7kPm
         QnsA==
X-Gm-Message-State: AOAM532fPLOfXFfo/n8CboZbRtsX4y1im7GYuG070z2hzErq7SIJPsUJ
        J2cQVBt5z1wv7/WgrcKiqHsw7/RMsHj4IM4CUUc=
X-Google-Smtp-Source: ABdhPJxz/0sq6wGwTGGw++QjO1GJFuVwOZyJKAIjYtl3KOXfzpi9ABaBefFgHDE0/t9XqE1xHsm72c+uFkZ+CX206x8=
X-Received: by 2002:a05:6808:5cf:: with SMTP id d15mr2555860oij.69.1612882519120;
 Tue, 09 Feb 2021 06:55:19 -0800 (PST)
MIME-Version: 1.0
References: <4653881.kBYL0eE9gL@kreacher> <3297462.0emgCRZMdL@kreacher> <337f970b0643d2f67f9a388ff8bbddcf673a1c6b.camel@perches.com>
In-Reply-To: <337f970b0643d2f67f9a388ff8bbddcf673a1c6b.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 9 Feb 2021 15:55:06 +0100
Message-ID: <CAJZ5v0j0xRHxEN=m3_NcSUgGOD491_DPFfc-1dK2hTixzBRHJA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPI: OSL: Clean up printing messages
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hanjun Gou <gouhanjun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 8, 2021 at 9:49 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-08 at 19:59 +0100, Rafael J. Wysocki wrote:
> > Replace the ACPI_DEBUG_PRINT() instance in osl.c unrelated to the
> > ACPICA debug with acpi_handle_debug(), add a pr_fmt() definition
> > to osl.c and replace direct printk() usage in that file with the
> > suitable pr_*() calls.
> []
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/osl.c
> > +++ linux-pm/drivers/acpi/osl.c
> []
> > @@ -528,13 +531,13 @@ acpi_os_predefined_override(const struct
> >
> >
> >       *new_val = NULL;
> >       if (!memcmp(init_val->name, "_OS_", 4) && strlen(acpi_os_name)) {
> > -             printk(KERN_INFO PREFIX "Overriding _OS definition to '%s'\n",
> > +             pr_info("Overriding _OS definition to '%s'\n",
> >                      acpi_os_name);
>
> If you do more of these, perhaps rewrap lines to 80 columns when possible.
>
>                 pr_info("Overriding _OS definition to '%s'\n", acpi_os_name);
>
> etc...

I've overlooked this one, will fix it up in the final commit.

Thanks!
