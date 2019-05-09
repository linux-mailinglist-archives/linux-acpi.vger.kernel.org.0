Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B69B218FBC
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2019 19:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfEIR5O (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 9 May 2019 13:57:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39992 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfEIR5O (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 9 May 2019 13:57:14 -0400
Received: by mail-pg1-f194.google.com with SMTP id d31so1588019pgl.7;
        Thu, 09 May 2019 10:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2/Ojxz6R9uaL2KTgaEJOCwL4nXhymGztvuWe0n46Oas=;
        b=sqyPOTbmHW6d3BX5lQrXfvRvmVT8Vhf37Zr+ifzy1/AgKiStiC9VncCPXw53Es650A
         o5ff9frbPDhp/mEsQfUpU1WVYwKXl1VyWBxUrh34SoAXBFueb9AmKn0EYOFI3WkecKmc
         4m7bI1fs0aZtf1cckpad1DGFyfIbfTSL8ZwtCLnTbVxp/qJEARtpbyeqPH0M74Uur9RN
         MrUQQaPCrDhOVJhLA5Xf9SpFspA9IdMg4l6f4F9cgHQ7iwGzzRdTQTAmZkA91yJ9lKBg
         uu5SiC0pNRlwvSLyh92gOYpw+eg0QJd49eTZrnNyipIzxP3D2p51UUsLWOEUihg+ThZl
         Lylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2/Ojxz6R9uaL2KTgaEJOCwL4nXhymGztvuWe0n46Oas=;
        b=eqp3xJqkySTq2Hw5VKtY8x/f4HxSX5DZmE32KIriTBZPXT2teuAWS2iTcBFZ0phlrW
         canUwrxqZX0qxWwgq3U2cvrrdidn+ZZI8UE6gFIPPg0maWN3JGnq5gVCbSdfb/gKSnvY
         VdwGOYonkxN5xAiQ5/FMicDYtdscwnXfW5FQq8t9vX8WzpzkgBjuAsdj0Dcw4zbtgNAa
         XW7xj9bRq8bwtlACdtzcaZ5IwLoEysnsD+dX3WjXxRvIGDgZuEjM3KyHEx2SHzQbQ3oU
         rbbliitFnVz8eG9VeNFaFv261Yd9FVKJL8QyVJwWTqh7iUR9+PwdqfCdS3nW0My5V4RV
         Auxg==
X-Gm-Message-State: APjAAAUu+XaSC6qhn/9oLAyUbQMu8VALSLP2RMfDLmm4vKmpofLJewGt
        MH1DkTey8LVvujE41XOLs9uYBIfpeLkKgnLjdDQ=
X-Google-Smtp-Source: APXvYqyrrXc8pqDrg9zaDFCNTR+gfH90uQMsb+/u8yUKI37oLarx+6vUJYbsY8E+vLUwj2oLEHjksfwOgak9JFyzC3k=
X-Received: by 2002:aa7:8212:: with SMTP id k18mr7162450pfi.50.1557424633583;
 Thu, 09 May 2019 10:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <7acd57fe-604a-a96a-4ca2-a25bc88d6405@gmail.com>
 <d6ee51cc-eb0f-2bb9-fef9-f8b4bf849076@gmail.com> <CAHp75VfMXAyUpWTrEHnv1NcQcHch+RHehWYTjk6KMTbXbtppPg@mail.gmail.com>
 <CAD8Lp46tCfi3ZCmmXZv3-ZDbon+6P8qC4GPR9Bt3uFFr=Sn4Cw@mail.gmail.com> <92518192-8cf0-7529-0c05-4b3e44ce04b7@gmail.com>
In-Reply-To: <92518192-8cf0-7529-0c05-4b3e44ce04b7@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 May 2019 20:57:02 +0300
Message-ID: <CAHp75Vdo80jfFt5s6KWK1dPJFAEa7BrQS_tcKLx6GPUrpQm+ag@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] platform/x86: asus-wmi: Improve DSTS WMI method
 ID detection
To:     Yurii Pavlovskyi <yurii.pavlovskyi@gmail.com>
Cc:     Daniel Drake <drake@endlessm.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, May 9, 2019 at 8:29 PM Yurii Pavlovskyi
<yurii.pavlovskyi@gmail.com> wrote:
> On 08.05.19 15:36, Andy Shevchenko wrote:> On Fri, Apr 19, 2019 at 1:08 PM
> Yurii Pavlovskyi
> > <yurii.pavlovskyi@gmail.com> wrote:
> >>         int rv;
> >> +       char *wmi_uid;
> >
> > Keep them in reversed spruce order.
>
> What do you mean by that? Do you mean like this?

> + char *wmi_uid;
> int rv;

Yes.

> int err;

Don't see this in the above, though.

> >> +#define ASUS_WMI_METHODID_DSTS         0x53544344 /* Device STatuS
> (DCTS) */
> >
> > It's not clear from the description what 'C' stands for.
> > Is there any specification which describes the difference and actual
> > abbreviations?
> >
> Not that I know of. Daniel had written some research in the previous
> version thread regarding where it is used, but as I understand from current
> implementation the functional difference is not really there, as it serves
> the same purpose as DSTS, just for another hardware.
>
> On 09.05.19 08:08, Daniel Drake wrote:
> > For clarity I think the constants could be renamed as
> > ASUS_WMI_METHODID_DCTS and ASUS_WMI_METHODID_DSTS.
> >
> Agree, that'll be better.

Also makes sense, but then fix up capitalization in the comment
(perhaps "Device status" would be good in both cases).

-- 
With Best Regards,
Andy Shevchenko
