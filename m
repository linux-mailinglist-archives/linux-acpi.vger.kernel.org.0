Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6502FF3D3
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbhAUTJ0 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 21 Jan 2021 14:09:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhAUTId (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:08:33 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EFDC061756
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 11:07:53 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id y12so2256798pji.1
        for <linux-acpi@vger.kernel.org>; Thu, 21 Jan 2021 11:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8IL7omGXKEqUEF+imDmaysOYy0Y9v5wjKeu9DQV9gtM=;
        b=LS1oZDTgEfmQ3PeXTj9eJTcnp2nnkJHRgZnIQ6BaqfTxUcZQIBJP9s1WwoSmTd0Tvj
         rVcEUaeF7v1T11FsVCzrVr8VzPztXZAh2VHIE388NN4u5C3WckelWSMGDmUiXvYw8ece
         ozHA8/ZacmBUmdv7CgWaDVDGkG5XkKQRASUATeXlbO2CvZBEEK0IGYToF8nFxVpliy5R
         7+VfMV0h4wrHr0hJsXDHCvJ3rnZOFLQ3tgu7wiSV9MvgKRI9SoENgA1pSjEd5AknhJ6j
         zjAYUehG61fD9+/i7Ux4zs2888ksSw6YrAKM6VODwXeKHmSUKFVpM060dvq0UcTIrhQ4
         PSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8IL7omGXKEqUEF+imDmaysOYy0Y9v5wjKeu9DQV9gtM=;
        b=Vikg6hftHtxvpjOZilM31r18z0kAERHeA3LjhXqjUDa86JQUbqR8mm7z4wHAvRCNF7
         4LpvVlOMYB9F0A7AJbNH4yEc0W6tNjzw3pnuP+pTaqdrAWRF9ZlfSgEhXqb6KSj71w1a
         7Km6MS1Msn19oiMDOCa2ORL7uJZvQlG3q50zz7RNXceE8KuLT57LqMpavcsVaXQwYx/k
         Hm+Vf72IWtCrGYhJYX7vQpJX8CGqft9XF5aAUW9VaL9XIPrdNuWKZ/66NWwf9ZUmHdWr
         UX5g+f3ZWKMCH+8OUP0lhW58U9Tb4mdiHXw05mb/ohrYs5d+3cZLU5k1ZzkjT5pk+o9H
         +ulQ==
X-Gm-Message-State: AOAM5333iCG5mVTazajJNLi1hdTenJp+5Y56kvajrZkbZbIRMUuqs6qq
        7tIL3YiJFKHfZAHG8+NxRpsIuy7R8UA7lCAgtEbbnA==
X-Google-Smtp-Source: ABdhPJw9KzZqv85PaIESUgWolglnwMOJ9jGn3M+rVEij1uGHL/1mW94pX1XUEo3JQ0kRBCWDpSgfN//WT2bqvioGnLk=
X-Received: by 2002:a17:902:9f87:b029:de:9e09:ee94 with SMTP id
 g7-20020a1709029f87b02900de9e09ee94mr707417plq.29.1611256072666; Thu, 21 Jan
 2021 11:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com>
 <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com> <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 21 Jan 2021 11:07:41 -0800
Message-ID: <CAKwvOdnG6Ew+7HMjJuH3Or8kEE_ZyP-xNGbwaX8HdT=6FApYxA@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Erik Kaneda <erik.kaneda@intel.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>,
        Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 11:03 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Thu, Jan 21, 2021 at 11:08 AM Jon Hunter <jonathanh@nvidia.com> wrote:
> >
> >
> > On 11/11/2020 02:11, Nick Desaulniers wrote:
> > > The "fallthrough" pseudo-keyword was added as a portable way to denot=
e
> > > intentional fallthrough. This code seemed to be using a mix of
> > > fallthrough comments that GCC recognizes, and some kind of lint marke=
r.
> > > I'm guessing that linter hasn't been run in a while from the mixed us=
e
> > > of the marker vs comments.
> > >
> > > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> >
> >
> > I know this is not the exact version that was merged, I can't find it o=
n
> > the list, but looks like the version that was merged [0],
>
> It would be this patch:
>
> https://patchwork.kernel.org/project/linux-acpi/patch/20210115184826.2250=
-4-erik.kaneda@intel.com/
>
> Nick, Erik?

oh, shit, looks like a line was dropped.  Here's what I sent upstream:
https://github.com/acpica/acpica/pull/650/files#diff-cccd96e900e01f7224c815=
08cbddfb1af6fcfbff959d6bfb55123e1b9cad4e38R1543
Note in the patch Rafael links to that line is missing and there's
instead an #ifdef that's empty.  Was this line accidentally dropped?

>
> > is causing build errors with older toolchains (GCC v6) ...
> >
> > /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscon=
trol.c: In function =E2=80=98acpi_ds_exec_begin_control_op=E2=80=99:
> > /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscon=
trol.c:65:3: error: =E2=80=98ACPI_FALLTHROUGH=E2=80=99 undeclared (first us=
e in this function)
> >    ACPI_FALLTHROUGH;
> >    ^~~~~~~~~~~~~~~~
> > /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscon=
trol.c:65:3: note: each undeclared identifier is reported only once for eac=
h function it appears in
> > /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:28=
7: recipe for target 'drivers/acpi/acpica/dscontrol.o' failed
> >
> > Cheers
> > Jon
> >
> > [0] https://github.com/acpica/acpica/commit/4b9135f5
> >
> > --
> > nvpublic



--=20
Thanks,
~Nick Desaulniers
