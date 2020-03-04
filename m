Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293231788AF
	for <lists+linux-acpi@lfdr.de>; Wed,  4 Mar 2020 03:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387469AbgCDCyY (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 3 Mar 2020 21:54:24 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:40359 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbgCDCyY (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Mar 2020 21:54:24 -0500
Received: by mail-ua1-f65.google.com with SMTP id t20so141379uao.7
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2020 18:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BeYrItptjbmjm//xr6aNyLoo5RY49LjduotLIGizl2Q=;
        b=svKGsOub7ZxaZcRswMLgCyDY9M7NlICSs5yYlhOef4CgZNMJcaYeET/xRbMKQ2Sjr5
         x7GrMkay5P8/ZTFyES2T+ek+RbYR2RemcPCVu+HbAmIFr52QuJUfNlYIDjqSawG8QDzp
         0vCxvKUV/N1gtjL905bZyOBMcqzTysyA9eRQIdcblr7hiLn1f0+ey7tUnKSqwIK0dsIS
         QBaYZSPDhDrYqdgCHcHWHXctCO5wH1KioQ8OeE2T7xde0a1zreyfPiWu4q1SIFRVPuK5
         aXi9e42c6PiHzw6poPmQTBgbmSY2eZooZwI57dm74ZY9MkZBdtGScDfCaLfZfBsw1f2W
         kINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BeYrItptjbmjm//xr6aNyLoo5RY49LjduotLIGizl2Q=;
        b=QM4liwON76CAj+7/u/u5K1mf6SX3qPf5H/a5Fgbjp34wNdqp2Phpy8vT0vWJ+bBjo1
         0sH7QC3SCFEku0QvKgCr/dAC7AnxksEXIRBe3kwcTfniEP/aemdigy3l6wdzVxFHuLiR
         6tCh+RJAsKLdI8Ih5FlOKYPrY+CwdnGWpufPjfwmJFzNCgv+Uacnf+8y2y/ecQqFZizy
         HZ3pzkNmHooMVCqVrlns+muvm98pJoTxcZZLsP6N79ooaerx5hzR6IJsxpcA0vWsewqM
         pxFnPTpmESoCmkTx42EZsoghpfvYFlGYbhF/68MP/44Tbe/99efqdD70xSmIGrAkyGsH
         vrFw==
X-Gm-Message-State: ANhLgQ173IQFJpuFDAZzxj5PxnWHhOuMd/FYS+D+Ts+ky5jECKctkH/N
        ZB8DkH37jGN5eCaTQvmKVpYnk15lf+taq6kyRwXkQw==
X-Google-Smtp-Source: ADFU+vsmy3goZ2XX5DADDbfFg/eIMnxSpbzjpinVr40A+RklPux/uxz2QGDs7Xd1N45NfSJVEjGvjDKfrkpOY1fF7WQ=
X-Received: by 2002:ab0:1161:: with SMTP id g33mr388779uac.32.1583290462899;
 Tue, 03 Mar 2020 18:54:22 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher> <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
 <CAPpJ_edfTg11QZs25MrThj2+FKUo2103rv7iYNzo=kr-jeg1MA@mail.gmail.com>
 <CAJZ5v0gB9yuVmPjJ_MvfT8aFpvP-X5JRsNfZn8+Mv5RwTednGg@mail.gmail.com>
 <CAJZ5v0imqwdmXzKayqs1kgHOb-mXrkr61uNxVka8J9bKca989Q@mail.gmail.com>
 <CAPpJ_efvF0XzjevA1eL3BUJqBwxRTOPLcqWKN40Azj-n1AtjcA@mail.gmail.com>
 <CAJZ5v0hie79+jG+3h4t5Q8r0M7E37HY-7i8ijg8DpvS0RXZSiQ@mail.gmail.com> <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com>
In-Reply-To: <CAJZ5v0hwrZX4+4m-g0c2bUTHxJO=1+kenXBjLz1ChWdcxSLJbA@mail.gmail.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 4 Mar 2020 10:53:33 +0800
Message-ID: <CAPpJ_ed5KPPu47ri3phnjKrToqJ8vSNV32zaRmBPLr3pq4M_4A@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Drake <drake@endlessm.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=886:23=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Mar 3, 2020 at 10:09 AM Rafael J. Wysocki <rafael@kernel.org> wro=
te:
> >
> > On Tue, Mar 3, 2020 at 8:29 AM Jian-Hong Pan <jian-hong@endlessm.com> w=
rote:
> > >
> > > Rafael J. Wysocki <rafael@kernel.org> =E6=96=BC 2020=E5=B9=B43=E6=9C=
=882=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > >
>
> [cut]
>
> > >
> > > Originally, ec_install_handlers() will return the returned value from
> > > install_gpio_irq_event_handler() from acpi_dev_gpio_irq_get(), which
> > > is -EPROBE_DEFER, instead of -ENXIO.  However, ec_install_handlers()
> > > returns -ENXIO directly if install_gpio_irq_event_handler() returns
> > > false in patch ("ACPI: EC: Consolidate event handler installation
> > > code").  Here needs some modification.
> >
> > Thanks, I forgot about the -EPROBE_DEFER case.
>
> The top-most commit in the git branch at
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
>
> has been updated to take that case into account (I think that it
> should be spelled out explicitly or it will be very easy to overlook
> in the future).
>
> Please test this one if possible.

Tested the commits on some laptops including ASUS UX434DA.  The
brightness hotkeys are working now.

Jian-Hong Pan
