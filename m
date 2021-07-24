Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEA33D49D5
	for <lists+linux-acpi@lfdr.de>; Sat, 24 Jul 2021 22:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGXTpN (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Sat, 24 Jul 2021 15:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXTpM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Jul 2021 15:45:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483D5C061575;
        Sat, 24 Jul 2021 13:25:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so8601608pji.5;
        Sat, 24 Jul 2021 13:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oX5fp2Nd3pjI/G9YdONxiLdBOXyu28WtsV/xr2FFBcM=;
        b=MleA1nfsh6fJ0gs2dghL4xrngg8YiagMbY7B66ZlCMD2z5AztzMGSQPwrXyhZd8MkQ
         L8oT1tz+xo/ioxQk/QOP6XONFYOZr7bosbTJXlqX2uDnQh4yLsqWnifbQ+BHLoaV9tKp
         EFLASh3QItzEHlx+pq40+jRlGFM9dSKxNmcCVadldLbikD69tYE6f0xgwUMBWG4bCrl/
         TTwXZOAz2c7G2aLRhX6hDMeuj9A87fLkG26utfBsREOVhnXkdWtTqrA7ga24EuM3R0jJ
         q+4HpZIyf8Ihat9zxU0sJrAAd+OJUGnthorkRyUF+Yk1B9IqQ7iZrHylwmU1XgxyeRUP
         SntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oX5fp2Nd3pjI/G9YdONxiLdBOXyu28WtsV/xr2FFBcM=;
        b=PcS06fYUA9R1NQfxFHJFidPPYhKqNi/vdaUIEArMDxUwRv4pIR2SigbAskAS92bRQ6
         m8KJI2ABAim8unIsF05B6xX5NKZKn3Zlr2EX9ci8j2nZGtaBphE0fBeFWDdDU6rqgsRw
         OaMwutVn/27pQEpbH+X0WMTqkQBlOZZjc4DSyjmmVwbAqePu9dzCo6FjnI5MYI++hjqP
         EvrqfEqSKogm4e0/ZIQovCu9Yj/J9fjqC+TAKsKQVYdS5eiBB6vdcu2rSAfbcj/y5pvB
         kMsLd4BM57Y5J18rOcAgtYRHzeswobJD1SSHkm8YH+ifcOo1tRjZ+POJ+Por0+0rll9v
         i3lA==
X-Gm-Message-State: AOAM533TnOcBer4TWC87C/usFagTX+mNX0Dw8uYl/+1S/D0knRN6jG6I
        rH1K9/10laPoPXIRpwU8SjlHL7O2usSEy7+KyCY=
X-Google-Smtp-Source: ABdhPJwUTRel3gjPkDQOX+a2yHZ/w3me8pjMINp3dKxourGyiImC63ckIod43RoF5q1yN0p8t9bUdUAmzFZPdlxmw7M=
X-Received: by 2002:a17:90b:1194:: with SMTP id gk20mr19462244pjb.181.1627158343731;
 Sat, 24 Jul 2021 13:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210723202157.2425-1-michael.a.bottini@linux.intel.com>
 <20210723202157.2425-2-michael.a.bottini@linux.intel.com> <CAHp75Ve2Ls9KVM0KZ2GMgbrQvc6wXvAXP1CqSLzQ4JWMTAcZ0A@mail.gmail.com>
 <27751c8ff02d98cabd512472b29078b11f4bdf0e.camel@linux.intel.com>
In-Reply-To: <27751c8ff02d98cabd512472b29078b11f4bdf0e.camel@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 24 Jul 2021 23:25:06 +0300
Message-ID: <CAHp75VfbDXW5DTfmV1r+=Q+7m=qta1p3h0uRk8D1rctxG_kDvg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/x86/intel/pmc: Add PSON residency counter
To:     David Box <david.e.box@linux.intel.com>
Cc:     Michael Bottini <michael.a.bottini@linux.intel.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "irenic.rajneesh@gmail.com" <irenic.rajneesh@gmail.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Jul 24, 2021 at 10:49 PM David E. Box
<david.e.box@linux.intel.com> wrote:
> On Sat, 2021-07-24 at 11:29 +0300, Andy Shevchenko wrote:
> > On Friday, July 23, 2021, Michael Bottini
> > <michael.a.bottini@linux.intel.com> wrote:
> > > Tiger Lake devices have the capability to track the duration
> > > of time that their Power Supply Units (PSUs) are turned off during
> > > S0ix.
> > > This patch adds a debugfs file `pson_residency_usec` to provide
> > > access to this counter.
> > >
> > > In order to determine whether the device is capable of PSON,
> > > use acpi_init_properties() to reevaluate _DSD.
> > >
> > >
> >
> > It=E2=80=99s direct abuse of ACPI specification as I read it:
> >
> > =E2=80=9C_DSD must return the same data each time it is evaluated. Firm=
ware
> > should not expect it to be evaluated every time (in case it is
> > implemented as a method).=E2=80=9D
> >
> >
> > NAK to the series.
>
> Okay, we'll check with the BIOS folks. They are setting this property
> from _STA. They may not expect OSPM to reevaluate _DSD.

Does it matter?

> But they may
> have expected that OSPM doesn't attempt to read _DSD until after _STA
> is executed.

They may study a bit of ACPI specification perhaps?
Or if there is indeed an issue with the specification language (so
native-speaking people misinterpret above) then ECR to ASWG should be
submitted?

--=20
With Best Regards,
Andy Shevchenko
