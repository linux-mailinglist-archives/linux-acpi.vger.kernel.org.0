Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6989EB2651
	for <lists+linux-acpi@lfdr.de>; Fri, 13 Sep 2019 21:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbfIMT4R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Fri, 13 Sep 2019 15:56:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37764 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729803AbfIMT4Q (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Sep 2019 15:56:16 -0400
Received: by mail-oi1-f193.google.com with SMTP id 11so3677788oix.4;
        Fri, 13 Sep 2019 12:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Bqrell8wJyp7c0Rf4MsSdHNwfJJHDYykWzrcHl5UBW8=;
        b=lHSEcDgqQfaE4Pt8GaPum4cbrlGvGoGLoCmMSnaYRzEGzwPZHrpHSUnN0ithJv0iVX
         0PweOr3gL2PwH5O1esom8lM6XMeWqvXzBR7Br8iQHM5LBSkCLU8AUr7q0+9ianggEFxx
         jYiUQ0IRoAlA/SfXfusPiYfHuoe11pmC4ivtNl4HneruQQNqgrKBkAWt+4324TsRsp5L
         z0cCM2WoBX76xJqa5bC9/b+4I5RfiL31k6CgRAs4aynNi3qiHNS4t0monbxEF1uCfdTl
         yVTa5o+vTr0wgXjSpttz4txuJWe+mTOHmmn1GvAgCwxYx4HLaRTjH+HqnNVqLfFqho/R
         NOHQ==
X-Gm-Message-State: APjAAAW5/4u0yzNaMvm2xaMeJEr6TzdDg3iRJ2HxGm7D4SIhAK4gvsWW
        LQOFd+XX9zXy46eqlyhxJvgAR7NOJ3+m0wdJ7Mg=
X-Google-Smtp-Source: APXvYqxGNZtGjPVXVF2ptVfh59M2fdj1iLV1JXkpMFzMJe6mrSgDGrt2HGM2Tu5TnQ5j8POrLzB1A4PzpQ+CdwYW6oI=
X-Received: by 2002:aca:b808:: with SMTP id i8mr4821405oif.68.1568404575404;
 Fri, 13 Sep 2019 12:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190906174605.GY2680@smile.fi.intel.com> <20190912080742.24642-1-nikolaus.voss@loewensteinmedical.de>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B9679CE8@ORSMSX110.amr.corp.intel.com>
 <alpine.DEB.2.20.1909130911180.20316@fox.voss.local> <94F2FBAB4432B54E8AACC7DFDE6C92E3B967ADF6@ORSMSX110.amr.corp.intel.com>
 <20190913151228.GT2680@smile.fi.intel.com> <7625fe37-1710-056d-fb9e-39c33fd962a1@gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E3B967AEC9@ORSMSX110.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 13 Sep 2019 21:56:03 +0200
Message-ID: <CAJZ5v0iDao-1DxSqOwW+pYsw-8wGi0L8SFoAW6AzKYwUpH+iUA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
To:     "Moore, Robert" <robert.moore@intel.com>
Cc:     Ferry Toth <fntoth@gmail.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        Nikolaus Voss <nv@vosn.de>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nikolaus.voss@loewensteinmedical.de" 
        <nikolaus.voss@loewensteinmedical.de>,
        Jan Kiszka <jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Sep 13, 2019 at 7:41 PM Moore, Robert <robert.moore@intel.com> wrote:
>
>
>
> -----Original Message-----
> From: Ferry Toth [mailto:fntoth@gmail.com]
> Sent: Friday, September 13, 2019 9:48 AM
> To: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Moore, Robert <robert.moore@intel.com>
> Cc: Nikolaus Voss <nv@vosn.de>; Schmauss, Erik <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len Brown <lenb@kernel.org>; Jacek Anaszewski <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org; linux-kernel@vger.kernel.org; nikolaus.voss@loewensteinmedical.de; Jan Kiszka <jan.kiszka@siemens.com>
> Subject: Re: [PATCH] ACPICA: make acpi_load_table() return table index
>
> Hello all,
>
> Sorry to have sent our message with cancelled e-mail address. I have correct this now.
>
> Op 13-09-19 om 17:12 schreef Shevchenko, Andriy:
> > On Fri, Sep 13, 2019 at 05:20:21PM +0300, Moore, Robert wrote:
> >> -----Original Message-----
> >> From: Nikolaus Voss [mailto:nv@vosn.de]
> >> Sent: Friday, September 13, 2019 12:44 AM
> >> To: Moore, Robert <robert.moore@intel.com>
> >> Cc: Shevchenko, Andriy <andriy.shevchenko@intel.com>; Schmauss, Erik
> >> <erik.schmauss@intel.com>; Rafael J. Wysocki <rjw@rjwysocki.net>; Len
> >> Brown <lenb@kernel.org>; Jacek Anaszewski
> >> <jacek.anaszewski@gmail.com>; Pavel Machek <pavel@ucw.cz>; Dan Murphy
> >> <dmurphy@ti.com>; linux-acpi@vger.kernel.org; devel@acpica.org;
> >> linux-kernel@vger.kernel.org; Ferry Toth <ftoth@telfort.nl>;
> >> nikolaus.voss@loewensteinmedical.de
> >> Subject: RE: [PATCH] ACPICA: make acpi_load_table() return table
> >> index
> >>
> >> Bob,
> >>
> >> On Thu, 12 Sep 2019, Moore, Robert wrote:
> >>> The ability to unload an ACPI table (especially AML tables such as
> >>> SSDTs) is in the process of being deprecated in ACPICA -- since it
> >>> is also deprecated in the current ACPI specification. This is being
> >>> done because of the difficulty of deleting the namespace entries for
> >>> the table.  FYI, Windows does not properly support this function either.
> >>
> >> ok, I see it can be a problem to unload an AML table with all it's
> >> consequences e.g. with respect to driver unregistering in setups with
> >> complex dependencies. It will only work properly under certain
> >> conditions
> >> - nevertheless acpi_tb_unload_table() is still exported in ACPICA and we should get this working as it worked before.
> >>
> >> AcpiTbUnloadTable is not exported, it is an internal interface only
> >> -- as recognized by the "AcpiTb".
> >
> > In Linux it became a part of ABI when the
> >
> > commit 772bf1e2878ecfca0d1f332071c83e021dd9cf01
> > Author: Jan Kiszka <jan.kiszka@siemens.com>
> > Date:   Fri Jun 9 20:36:31 2017 +0200
> >
> >      ACPI: configfs: Unload SSDT on configfs entry removal
> >
> > appeared in the kernel.
>
> And the commit message explains quite well why it is an important feature:
>
> "This allows to change SSDTs without rebooting the system.
> It also allows to destroy devices again that a dynamically loaded SSDT created.
>
> The biggest problem AFAIK is that under linux, many drivers cannot be unloaded.
> Also, there are many race conditions as the namespace entries "owned" by an SSDT
> being unloaded are deleted (out from underneath a driver).

While that is true in general, there are cases in which unloading does
work and they
still need to be supported.

You may argue that adding support for unloading SSDTs loaded via
configfs was a mistake,
but that was done and it cannot be undone.

We cannot break existing setups in which it is in use and works.

> This is widely similar to the DT overlay behavior."
>
> >> I'm not sure that I want to change the interface to AcpiLoadTable
> >> just for something that is being deprecated. Already, we throw an
> >> ACPI_EXCEPTION if the Unload operator is encountered in the AML byte
> >> stream. The same thing with AcpiUnloadParentTable - it is being deprecated.
> >>
> >>      ACPI_EXCEPTION ((AE_INFO, AE_NOT_IMPLEMENTED,
> >>          "AML Unload operator is not supported"));
> >
>
