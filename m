Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF4130AFB7
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Feb 2021 19:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhBASpv (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Feb 2021 13:45:51 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:40671 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhBASpi (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Feb 2021 13:45:38 -0500
Received: by mail-oi1-f178.google.com with SMTP id k142so5462444oib.7;
        Mon, 01 Feb 2021 10:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3F+IaK/LsrQrHTLR46KGKmkQYpd2IqLJ3cy++TfHCOw=;
        b=PTLBFKfUCgeX1DZXG8ht8oQv5uNZqQLyQG2y7AuKoxg4zBn/uuYZimwfbdGLQo0EG8
         1irTCtqfwL0ElLiQNCWYtcCb1Ewt9P3tCWOINnlU3+m5fXZAXjGoVRx3T7k+H1hzs1GS
         7KTZsdcGw2oTYDg+DkoOqxPFwbMsio4cB7lP265i4IFCPrIQ+OwxinNbJL753uzE/5ho
         9ReduF/t/ah6PGjPWBaoxuD29KljszKWT8WFrsRXxpqakGQUBW34xqk8cXZbCStw5u8t
         mBd94hzh/omnJ3PcR4+2F9MuQM8CidMtqs8fAwWy1GvKmqX22DM1rq0/qCeGkcf2UgEn
         s0yA==
X-Gm-Message-State: AOAM532x+geUoyy4q0eyRgGF25Kn3ZAVkHZpca1Lp0MBbusYEXx92J8M
        kHTKw9IHe3vRn7nywwU4Y+uQ/wehZK8YqPBAT1K1UXeD
X-Google-Smtp-Source: ABdhPJzopJHlhNhpir5maIJreoA9jMznT8poHisvkoSSMrrZIJGmFYhdiu1HY4P/xs6wY/6LlBOOvINugbgG+phwxZ0=
X-Received: by 2002:aca:fc84:: with SMTP id a126mr170770oii.71.1612205096134;
 Mon, 01 Feb 2021 10:44:56 -0800 (PST)
MIME-Version: 1.0
References: <2367702.B5bJTmGzJm@kreacher> <1996712.1aSbzQgNOC@kreacher> <ab62890a1128b0d3109553208379015fcb36e0c7.camel@perches.com>
In-Reply-To: <ab62890a1128b0d3109553208379015fcb36e0c7.camel@perches.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 1 Feb 2021 19:44:43 +0100
Message-ID: <CAJZ5v0hoPLKe9mVY_mJgFrcLSdutTd-UFGJS11pu8qDzemy43w@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] ACPI: battery: Clean up printing messages
To:     Joe Perches <joe@perches.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Erik Kaneda <erik.kaneda@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Feb 1, 2021 at 7:37 PM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-02-01 at 19:16 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Replace the ACPI_DEBUG_PRINT() and ACPI_EXCEPTION() instances
> > in battery.c with acpi_handle_debug() and acpi_handle_info() calls,
> > respectively, drop the _COMPONENT and ACPI_MODULE_NAME() definitions
> > that are not used any more, drop the no longer needed
> > ACPI_BATTERY_COMPONENT definition from the headers and update the
> > documentation accordingly.
> >
> > While at it, update the pr_fmt() definition and drop the unneeded
> > PREFIX sybmbol definition from battery.c.
> []
> > --- linux-pm.orig/drivers/acpi/battery.c
> []
> > @@ -466,7 +460,8 @@ static int extract_package(struct acpi_b
> >  static int acpi_battery_get_status(struct acpi_battery *battery)
> >  {
> >       if (acpi_bus_get_status(battery->device)) {
> > -             ACPI_EXCEPTION((AE_INFO, AE_ERROR, "Evaluating _STA"));
> > +             acpi_handle_info(battery->device->handle,
> > +                              "_STA evaluation failed\n");
>
> I believe this changes the logging level from KERN_ERR to KERN_INFO.
>
> Perhaps this and others should instead use acpi_handle_err()

Actually, these log level changes, because the messages in question
are not very urgent.

Something doesn't work and it's kind of good to know that, but there's
not much that can be done about it.
