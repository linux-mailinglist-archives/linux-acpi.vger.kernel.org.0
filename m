Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA4E2FF480
	for <lists+linux-acpi@lfdr.de>; Thu, 21 Jan 2021 20:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbhAUTFz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 21 Jan 2021 14:05:55 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:33065 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbhAUTFG (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Jan 2021 14:05:06 -0500
Received: by mail-oi1-f177.google.com with SMTP id d203so3331160oia.0;
        Thu, 21 Jan 2021 11:04:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sxUFDSeoZEWN4aDqisZF6mUVpomTtmiF7YK6hytZxWc=;
        b=qWa+uEpZ5yso8/rb0urhOsLhosKvFHOxVghxZirLSf+NyVU4lUnkz+0Yyi2/8WqwMJ
         dDo+yvXqyPP80ZaCbcWyLdrh5wr2FQ2rITEfsh2lpxAjUY2DtDfYORfcO5iPIthS5FOK
         6CMlt/IbsL7hSM674dbayLLexoq+gSxD6NaM/8SDYEoPv/YxiIBf9AtQF5w3+AQyez/p
         CjuEWz102L451pDCZ7Cm+fR2jpkbxq72MdadmemvrWPAMyIwm7iuwZX3NSlZR3BXg3OB
         Nw00zR7EHZnVSGcVPA6ai1iHN3xwKm/vDAqkcycFWCPUVUcX9Joqk67V9mSOcaUsUuSl
         UjOA==
X-Gm-Message-State: AOAM530b/i4To4Gq0pyUDiYB713k8FTP3OmJLgw4eFvLo5I6Xh4ijxWT
        jahMtwKDx6Bxj5id4GbBwrZRa/5kWiKgKs70aH4=
X-Google-Smtp-Source: ABdhPJwFYOx7GKzTGGbTxgqjm5rCY/53kLF3X/JTRr/LaAc8hfo2mXKv0cD2IHyeZkf+1CBzz3/fcbRitQ3sr4ri09g=
X-Received: by 2002:aca:308a:: with SMTP id w132mr703472oiw.69.1611255814671;
 Thu, 21 Jan 2021 11:03:34 -0800 (PST)
MIME-Version: 1.0
References: <20201111021131.822867-1-ndesaulniers@google.com> <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com>
In-Reply-To: <031790d7-ee26-f919-9338-b135e9b94635@nvidia.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jan 2021 20:03:23 +0100
Message-ID: <CAJZ5v0it3KfdNo7kwq-7__C+Kvr4Eo7x8-3rBi09B5rHfNv-hQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: fix -Wfallthrough
To:     Jon Hunter <jonathanh@nvidia.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Robert Moore <robert.moore@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        clang-built-linux@googlegroups.com, Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Jan 21, 2021 at 11:08 AM Jon Hunter <jonathanh@nvidia.com> wrote:
>
>
> On 11/11/2020 02:11, Nick Desaulniers wrote:
> > The "fallthrough" pseudo-keyword was added as a portable way to denote
> > intentional fallthrough. This code seemed to be using a mix of
> > fallthrough comments that GCC recognizes, and some kind of lint marker.
> > I'm guessing that linter hasn't been run in a while from the mixed use
> > of the marker vs comments.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>
>
> I know this is not the exact version that was merged, I can't find it on
> the list, but looks like the version that was merged [0],

It would be this patch:

https://patchwork.kernel.org/project/linux-acpi/patch/20210115184826.2250-4-erik.kaneda@intel.com/

Nick, Erik?

> is causing build errors with older toolchains (GCC v6) ...
>
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol.c: In function ‘acpi_ds_exec_begin_control_op’:
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol.c:65:3: error: ‘ACPI_FALLTHROUGH’ undeclared (first use in this function)
>    ACPI_FALLTHROUGH;
>    ^~~~~~~~~~~~~~~~
> /dvs/git/dirty/git-master_l4t-upstream/kernel/drivers/acpi/acpica/dscontrol.c:65:3: note: each undeclared identifier is reported only once for each function it appears in
> /dvs/git/dirty/git-master_l4t-upstream/kernel/scripts/Makefile.build:287: recipe for target 'drivers/acpi/acpica/dscontrol.o' failed
>
> Cheers
> Jon
>
> [0] https://github.com/acpica/acpica/commit/4b9135f5
>
> --
> nvpublic
