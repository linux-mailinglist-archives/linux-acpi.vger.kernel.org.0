Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853CB35D010
	for <lists+linux-acpi@lfdr.de>; Mon, 12 Apr 2021 20:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244008AbhDLSMB (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 12 Apr 2021 14:12:01 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:38636 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241111AbhDLSMB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 12 Apr 2021 14:12:01 -0400
Received: by mail-ot1-f46.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so13659230otk.5
        for <linux-acpi@vger.kernel.org>; Mon, 12 Apr 2021 11:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rEAFGFik4TQz9w+zL0LZQWffJSiz0foEtDak0JL0Qz4=;
        b=rx6RgTQxYctckYTOb49SMrBd7bXPp2X5I4yZp2IuQObvOZc8BpFLUCOSjj22A2Vtyv
         EzgoBN6jlX7bhwpznzqEsqRrH3cX9mpceyV8rW+zLKrTbF0JjzdHSrYKfO5PALWuvPwR
         yp+Qg0Nf+nS0MGIJO/vX9NwIt9PqwDo5AT7nwVq9bqMMW4MKuJOGQfnc0HBxR/CIoOSC
         e6MfU0/TUh95vHlfrjmeC7LKMH7AKw4y/PECyjZ8/dVtPqC3vKUCRBO17m2s2OaZnuth
         RWLiwio55f6/ds31R6QHwCSIudI7jK9Yfz84f9PoukmrYWsl0Be8ht++fTBljRTQQyU0
         JGlQ==
X-Gm-Message-State: AOAM533XR23lFr3cLE2c76mCUxtMxIKNpDkK9JE9rz/9uy8hKCRLMQsS
        Xwx06eAF9FdUdvKjgY4LcGD6YucjVbEiwvk2tpg=
X-Google-Smtp-Source: ABdhPJy7AKefWFwba6jZSzxbC9gA7iLdWNlt8BZZFLcja3OeDCyDjxVJPqsA8fRb9LCPtXN1G+/7rb68KjxzUKLef0k=
X-Received: by 2002:a9d:6951:: with SMTP id p17mr12157014oto.206.1618251102673;
 Mon, 12 Apr 2021 11:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <7d941a3c-bced-09cf-27a1-b61f0d20ef4c@redhat.com> <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iLSbfRH9A3EMUTrY5=vPdp=uVOF2XQnWkAbko9NjPqJg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 12 Apr 2021 20:11:31 +0200
Message-ID: <CAJZ5v0gOMZbyD5r+bCL9vD6_NrFz0nAq+eY2QDtxOY4DfsXG6w@mail.gmail.com>
Subject: Re: [5.12 regression] DSDT overriding from initrd no longer works
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Apr 12, 2021 at 8:01 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, Apr 12, 2021 at 7:38 PM Hans de Goede <hdegoede@redhat.com> wrote:
> >
> > Hi Rafael,
> >
> > Sorry about the timing of reporting this regression.
>
> Oh well.
>
> > I just noticed that overriding the DSDT (*) from the initrd will not work in 5.12,
> > this is caused by:
> >
> > commit 1a1c130ab757 ("ACPI: tables: x86: Reserve memory occupied by ACPI tables")
> >
> > This makes the initial acpi_locate_initial_tables() call happen earlier
> > then before, but the acpi_table_upgrade) call in arch/x86/kernel/setup.c is
> > not moved up, so the tables in the initrd are now only parsed and saved
> > after the initial ACPI table scanning has already been done.
> >
> > I guess fixing this might be as easy as moving the acpi_table_upgrade) call
> > higher in arch/x86/kernel/setup.c but I'm not sure if that is save to do.
>
> Why do you think it may not be safe?

OK, so it won't work in some cases, because acpi_table_upgrade() needs
to be called after reserve_initrd(), so I guess the commit above will
need to be reverted.
