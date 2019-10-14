Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44523D5DF1
	for <lists+linux-acpi@lfdr.de>; Mon, 14 Oct 2019 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730366AbfJNIz4 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 14 Oct 2019 04:55:56 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34130 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730354AbfJNIz4 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Oct 2019 04:55:56 -0400
Received: by mail-ot1-f68.google.com with SMTP id m19so13172482otp.1;
        Mon, 14 Oct 2019 01:55:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbsWRrvQTJbuWyAg2ul9J/hFRTz5fzt/9tGYH0/lnMU=;
        b=fs4wZGs4F3OXOQ1ecSCALKE8lO1fwYsaRnCPzCRa8KtOIzKesDJfaRFSnbTOWXh9Gm
         hBcHkH063vbRBcxsMKxrVVxCViceRS39/f1wu6mGn11AjvnpwGyuK1u1iX5Dbs8BlLg4
         e0mzlvUrdUcJQYszTXxkUMUTvNBml4s42uM6A5bygrT5Tlsd/0DBU1ZAutPAHZaXYzQk
         IguyitAs0AdU6m4/fJXSjApC8COC7GYw0Z74lO1ag+gj68yLj0cdnxp1+njLlEvyr7Kd
         OFDNxxTDlfs0LM3gX89l29D+tlTJjwKfwCvVQv6UfARdH57TtjMMyq/Ikk0JLNopadz+
         Lh8g==
X-Gm-Message-State: APjAAAX37dxJ0k+WqlZwHGGQ9+O2U78PNVrftV2vpQUsSAsIK/ROFviV
        v7GE5A+wTVMCMBK6azZl5rep1yBfAh2v3GBANioAPQ==
X-Google-Smtp-Source: APXvYqwSlvaE3YLgndSZ8qlhM/0cbXoelH23LKI6nbiD+tFcA3y3bXO9N4RW6ac2fPN++RtVr6j7ryhO/RbYeJlc0/A=
X-Received: by 2002:a9d:459b:: with SMTP id x27mr22444160ote.167.1571043353566;
 Mon, 14 Oct 2019 01:55:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191009130433.29134-1-sameo@linux.intel.com> <20191009130433.29134-2-sameo@linux.intel.com>
 <CAJZ5v0ioC6XnC+sFpRJmm40T+YCnqoaHhJ+_Pmk7rvvC8UPT9w@mail.gmail.com> <20191011121447.GA4256@caravaggio>
In-Reply-To: <20191011121447.GA4256@caravaggio>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 14 Oct 2019 10:55:41 +0200
Message-ID: <CAJZ5v0gv_ycJc_XgxyA4LZS50xmh9PU_iLDRKyDL738C0Zaj_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi: Fail GED probe when not on hardware-reduced
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Oct 11, 2019 at 2:14 PM Samuel Ortiz <sameo@linux.intel.com> wrote:
>
> On Fri, Oct 11, 2019 at 12:38:49PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Oct 9, 2019 at 3:04 PM Samuel Ortiz <sameo@linux.intel.com> wrote:
> > >
> > > The Generic Event Device (GED) is a hardware-reduced platform device.
> >
> > No, it is not AFAICS.
> It's a little confusing, I was not sure what's the common understanding
> and tried to be safe by not having non HW-reduced machines getting a
> new device that they've never seen so far.

I really don't expect firmware to expose GED for such machines (why
would it?), but if it does so, then why not to handle it?

> > The spec doesn't say that GED cannot be used on platforms that aren't
> > HW-reduced
> I agree.
>
> >  and if evged.c is going to be built in unconditionally, the
> > kernel will be able to handle GED regardless.
> Ok, perfect then. Does that mean you're ok with the 2nd patch but are
> going to drop this one?

Sure, I will apply the second patch only.

Thanks!
