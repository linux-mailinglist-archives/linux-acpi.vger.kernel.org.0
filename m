Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8545E30076D
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbhAVPeA (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:34:00 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:39442 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbhAVPds (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:33:48 -0500
Received: by mail-ot1-f42.google.com with SMTP id i30so5416144ota.6;
        Fri, 22 Jan 2021 07:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dH4mL8XiIr5tXI9uOJYWrjHPyyDGTmGdAo3u+JoYNyI=;
        b=oBZF5E+O37tD7mXR5R+EPg9fv910Lpu+09blql9o9OFNIXlAa7Xk8ZO2/8cO9xlbGO
         UVocxpLqd9EJSnsBnBLFvWH1UWCieaV9zAwdZi7c36nIbX6j9BNtqOMBpyXWtz3eJZeg
         v54pFzwxUTrj1l5KBPeEgoH7C/YOhFvmKcgQgXkkOWpG5rIseUHnkb+2h6P/Vh4QEOLq
         xPIA384o3j6iIS9JqPdk77hi5743O+oAJY47PSJOTT5cSE0gxXUDz0TGPfgFHg4htnen
         1pbIx7Pgg3RziKq3x9IwBWoKCJ3Kn0IdpagQ+cDbIl/aYzSXraveBeiwuO2q4LhH85JE
         UJiQ==
X-Gm-Message-State: AOAM530SDdgFbkjH7APXSWICE7kywA6J+4sIhJ9XaIgTxTlVwcR8mrqk
        JKWYD9Vf3NHNg2PquWTzWtXgFIxX0sTg9NiRRkw=
X-Google-Smtp-Source: ABdhPJzvvYGMEOddIwDfbu1Ch1Ldzr38ZXPQBNQ7cEfEJMp99F9DE2EAd0/mfH2G3gSE7PO0L9iUsXXe2XtRwLJdvX0=
X-Received: by 2002:a05:6830:2313:: with SMTP id u19mr534710ote.321.1611329586496;
 Fri, 22 Jan 2021 07:33:06 -0800 (PST)
MIME-Version: 1.0
References: <20210108152447.116871-1-f.suligoi@asem.it> <CAHp75Vf54TTXr4HH6TxMo0QRTBa5V3=La1LCDxSizaYZjJM9Qg@mail.gmail.com>
In-Reply-To: <CAHp75Vf54TTXr4HH6TxMo0QRTBa5V3=La1LCDxSizaYZjJM9Qg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:32:55 +0100
Message-ID: <CAJZ5v0iVp8z7WAqX1NxQNKx55tfwUJtx-gK67x=Npxjf05g4Kg@mail.gmail.com>
Subject: Re: [PATCH v1] Documentation: ACPI: add new rule for gpio-line-names
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Flavio Suligoi <f.suligoi@asem.it>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jan 8, 2021 at 5:03 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jan 8, 2021 at 5:28 PM Flavio Suligoi <f.suligoi@asem.it> wrote:
> >
> > The gpio-line-names lists must respect some rules.
> >
> > This patch adds a new rule in documentation, to avoid
> > the use of duplicate names in the same gpiochip.
>
> Thanks!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> > Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> > ---
> >  Documentation/firmware-guide/acpi/gpio-properties.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/firmware-guide/acpi/gpio-properties.rst b/Documentation/firmware-guide/acpi/gpio-properties.rst
> > index b36aa3e743d8..4e264c16ddff 100644
> > --- a/Documentation/firmware-guide/acpi/gpio-properties.rst
> > +++ b/Documentation/firmware-guide/acpi/gpio-properties.rst
> > @@ -146,6 +146,7 @@ following rules (see also the examples):
> >      other words, it is not mandatory to fill all the GPIO lines
> >    - empty names are allowed (two quotation marks ``""`` correspond to an empty
> >      name)
> > +  - names inside one GPIO controller/expander must be unique
> >
> >  Example of a GPIO controller of 16 lines, with an incomplete list with two
> >  empty names::
> > --

Applied as 5.12 material, thanks!
