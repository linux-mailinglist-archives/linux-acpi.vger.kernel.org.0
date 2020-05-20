Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50F9C1DAE76
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 11:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgETJPc (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 05:15:32 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45353 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETJPb (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 20 May 2020 05:15:31 -0400
Received: by mail-ot1-f65.google.com with SMTP id c3so1865179otr.12;
        Wed, 20 May 2020 02:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqoyHeOoEDMlB+jQwZuDNn8FHfH7mQ3PMOITKSmc9rM=;
        b=DPxvfZqG/qRiPIHMNr4/vnu+UfEN+lEEd+HEWG3e0HDb/0Y2IQCA9o9jMNyM7cualp
         wuesSXYA4Ci1WBSBiR2hyMpeB0EhlgkXFIc93Ox1FlCQWRCs2qVJLW+RHOSmqGrnjwBq
         kXq0Kjk31AbojylE0E1rcH7hQrnTp+6Wx7CszxI5QgCS6kXfxY8bLGbVpNu5VtKhRqVx
         HfxqPw0wsnqkSH4wsDFLeIUdzw8O/cCvNR0CDYDkR0FGTZjyr1qprXpsVHnJKjY3EHE3
         rsx2s50glQltQJt0J7WlKaO/2y13T1oLEP8fjZ3yenz7OjzR0I1UP9h812O8SOS/IO8g
         UuwA==
X-Gm-Message-State: AOAM532XxtrZAM5MuSjzwTtMK64QTZtsL1j2jwc6BJQq6ywnmfk1qg+A
        eDtnF1+NL5vkk2AcU1KacnXG2mPBYjOn6L757kg=
X-Google-Smtp-Source: ABdhPJyAQnNwUbpbP3PLRjXubPXhxP1e5qRO/5LlKFxssnkRW8i1aQTDADuYa6bxey7awz5NwtSwBv6uQ99bF+Kj+8M=
X-Received: by 2002:a9d:6356:: with SMTP id y22mr2364835otk.167.1589966129710;
 Wed, 20 May 2020 02:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200518222722.GA7791@embeddedor> <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
 <20200519225058.GA14138@embeddedor>
In-Reply-To: <20200519225058.GA14138@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 20 May 2020 11:15:18 +0200
Message-ID: <CAJZ5v0jg9HoE2KEm45hxKNB1g61DzCn-GWH74w1goeHH3AKRaA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace one-element array and use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 20, 2020 at 12:46 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 12:25:13PM +0200, Rafael J. Wysocki wrote:
> > On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
> > <gustavoars@kernel.org> wrote:
> > >
> > > The current codebase makes use of one-element arrays in the following
> > > form:
> > >
> > > struct something {
> > >     int length;
> > >     u8 data[1];
> > > };
> > >
> > > struct something *instance;
> > >
> > > instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> > > instance->length = size;
> > > memcpy(instance->data, source, size);
> > >
> > > but the preferred mechanism to declare variable-length types such as
> > > these ones is a flexible array member[1][2], introduced in C99:
> > >
> > > struct foo {
> > >         int stuff;
> > >         struct boo array[];
> > > };
> > >
> > > By making use of the mechanism above, we will get a compiler warning
> > > in case the flexible array does not occur last in the structure, which
> > > will help us prevent some kind of undefined behavior bugs from being
> > > inadvertently introduced[3] to the codebase from now on.
> >
> > However, the ACPICA code in the kernel comes from an external project
> > and changes of this type are generally not applicable to it unless
> > accepted upstream.
>
> Hi Rafael,
>
> By _accepted upstream_, in this case, you mean the adoption of the
> flexible-arrays in the whole codebase, first?

I meant whether or not the patch is accepted by the ACPICA upstream.

>  If this is the case
> notice that there are hundreds of these flexible-array conversions
> in mainline, already:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?qt=grep&q=flexible-array
>
> Is this what you mean?

I'm not actually sure what you mean here.
