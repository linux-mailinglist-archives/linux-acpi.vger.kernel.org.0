Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFE09178D2C
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 10:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgCDJOH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Wed, 4 Mar 2020 04:14:07 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34363 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDJOH (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Mar 2020 04:14:07 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so1339193otl.1;
        Wed, 04 Mar 2020 01:14:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2yqcmNpEhEyaoox7sgCu8vgkk/Ww/B7auVe1x64oSBk=;
        b=j2diKycW4GOtU6AnzvAzCml2SGfkMYP0g4a1XcRmhSAJxaocdO7v5mJ9DAWQKUs5IK
         okoUG3OExWv7IQ4/KhM5a6t+PADRtpMSwfE13UMZc2n9hQyV0KWZhNNm86CsP81mlAMX
         AZeP0+Y2iAgCIkJzKut8Ikt+izg55VWjyVLF6Tp3kykU+nYKI39vyCxLLSPKajAW8Ns1
         LLqLs/oJNl2fedu5I5J81bo5h1Fs9SHOyV0+VLUjZvqGuUJnfNYy3/HVpFviOtpM1m8r
         O5o5oYjbgTa18iq8ny0OYCgP2IZIWVS4OrNOQAjTP1awtUOT6yy5aXv6RkAPee4gDhuQ
         /TNQ==
X-Gm-Message-State: ANhLgQ2uAK/xYxY9X6hSTT2aUS4FxJ0Q0mm9/Jtsn49gXvuhaj2TrqnY
        z+6pN2f+zvPXfE4BT4qokVSI1oWbEyxR0fUG/qA=
X-Google-Smtp-Source: ADFU+vvJVrT5XzB+LN4pvHpPN9koJloy6ZWiadNJKU6hGzyCilF4pGMcGTQth78LVdONiuIhebTgdghVxAbgAmk19GE=
X-Received: by 2002:a05:6830:4b9:: with SMTP id l25mr1612658otd.266.1583313246413;
 Wed, 04 Mar 2020 01:14:06 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
 <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
 <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
 <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com>
 <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com> <CAPpJ_ed5KPPu47ri3phnjKrToqJ8vSNV32zaRmBPLr3pq4M_4A@mail.gmail.com>
In-Reply-To: <CAPpJ_ed5KPPu47ri3phnjKrToqJ8vSNV32zaRmBPLr3pq4M_4A@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 4 Mar 2020 10:13:54 +0100
Message-ID: <CAJZ5v0jVNXGxko+LUJ5K91UmM_Fz4Q=JN2eK1sSxO7AsDj=Gyw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Mar 4, 2020 at 3:54 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
>
> Rafael J. Wysocki <rafael@kernel.org> 於 2020年3月4日 週三 上午6:23寫道：
> >
> > On Tue, Mar 3, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >
> > > On Tue, Mar 3, 2020 at 8:29 AM Jian-Hong Pan <jian-hong@endlessm.com> wrote:
> > > >
> > > > Rafael J. Wysocki <rafael@kernel.org> 於 2020年3月2日 週一 下午7:45寫道：
> > > > >
> >
> > [cut]
> >
> > > >
> > > > Originally, ec_install_handlers() will return the returned value from
> > > > install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
> > > > is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
> > > > returns -ENXIO directly if install_gpio_irq_event_handler() returns
> > > > false in patch ("ACPI: EC: Consolidate event handler installation
> > > > code").  Here needs some modification.
> > >
> > > Thanks, I forgot about the -EPROBE_DEFER case.
> >
> > The top-most commit in the git branch at
> >
> >  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
> >  acpi-ec-work
> >
> > has been updated to take that case into account (I think that it
> > should be spelled out explicitly or it will be very easy to overlook
> > in the future).
> >
> > Please test this one if possible.
>
> Tested the commits on some laptops including ASUS UX434DA.  The
> brightness hotkeys are working now.

Thank you!
