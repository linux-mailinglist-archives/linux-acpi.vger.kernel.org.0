Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6900D324385
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Feb 2021 19:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhBXSHk (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Feb 2021 13:07:40 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:43198 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbhBXSHh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Feb 2021 13:07:37 -0500
Received: by mail-ot1-f53.google.com with SMTP id v12so1903825ott.10;
        Wed, 24 Feb 2021 10:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUyGjHMdzy5k0NymwhlK4usRhZbPwNaCWNv1VgX9sq4=;
        b=Pp5d6XH31agMb/PNwaRhcF2uUPC9xGRRTh/nFuwn18cfpN0PBdnnbs4pT/gHSH7lr7
         ItIIYL/9PPIzZe+uED3QfWaLHF51iZ/jC2pTfO7aqGmQmQDH7TgWsQ6HtapzR9y3twm/
         HxlbGIPNdJ58BA6XhliD3BproNqS7vvsQPSV3mEpi/4H9bbnshER3xBztvoi7SEhF7ZO
         GVkUZCeFVCuR8I8cynvLY5J9ihAZSYs7f8ehY9wZ8uMkVeCC4Tuczjp9YNeTv1hghGjg
         nnDNlMv9WG3KjLxpCdd8xMX7NiWCyELNb4qpZeN7jH1y03OXE7MFK+oSj0TsnShzh30X
         wNig==
X-Gm-Message-State: AOAM533JOAulR06GUJuaIRZ1mrFSigEd93dnixfeoJxZnHLbl/tR9f9I
        OA+KS25fEigY+B+rfzgicSGJi1HQX+ftp3mr22I=
X-Google-Smtp-Source: ABdhPJxuXkX+666/Lv6ikmFdus5B0e+dUJwf/jEXpLD1oPXJSXdOJc6n6bAAaO45L9rZTfhBgGz28obtt+9kdAhehVE=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr21745058ota.321.1614190017269;
 Wed, 24 Feb 2021 10:06:57 -0800 (PST)
MIME-Version: 1.0
References: <5138173.kHyPcihzTF@kreacher> <10245832.OiMb8u2cOm@kreacher>
 <0faea0bd-107b-5c4c-5324-e0cd5e5cfba4@huawei.com> <CAJZ5v0i01rX0b-=dDJEdGsK2=6D3tXbC_wdOByTF_mJ0ggTPJQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i01rX0b-=dDJEdGsK2=6D3tXbC_wdOByTF_mJ0ggTPJQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Feb 2021 19:06:46 +0100
Message-ID: <CAJZ5v0hwouj_1KpZ_RrC3r50RxngvinBBJVgNhQkwA3bw0oXag@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] ACPI: processor: Get rid of ACPICA message printing
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Feb 23, 2021 at 3:45 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 23, 2021 at 12:31 PM Hanjun Guo <guohanjun@huawei.com> wrote:
> >
> > On 2021/2/23 2:59, Rafael J. Wysocki wrote:
> > > Index: linux-pm/drivers/acpi/processor_idle.c
> > > ===================================================================
> > > --- linux-pm.orig/drivers/acpi/processor_idle.c
> > > +++ linux-pm/drivers/acpi/processor_idle.c
> >
> > In this file, function acpi_processor_cstate_first_run_checks()
> > has a wrong pr_notice():
> >
> > pr_notice("ACPI: processor limited to max C-state %d\n",
> >                 max_cstate);
> >
> > Since we have pr_fmt() for this file, "ACPI:" is duplicate,
> > we'd better cleanup this as below:
> >
> > pr_notice("processor limited to max C-state %d\n", max_cstate);
>
> Thanks for pointing this out, I'll make this change when applying the patch.

Actually, this issue is not strictly related to the patch here, so I'm
going to send a separate patch to fix it.
