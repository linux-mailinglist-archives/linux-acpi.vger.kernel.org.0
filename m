Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF92442620
	for <lists+linux-acpi@lfdr.de>; Tue,  2 Nov 2021 04:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhKBDoT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 1 Nov 2021 23:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbhKBDoT (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Nov 2021 23:44:19 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21668C061764
        for <linux-acpi@vger.kernel.org>; Mon,  1 Nov 2021 20:41:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so3231684plf.4
        for <linux-acpi@vger.kernel.org>; Mon, 01 Nov 2021 20:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gzmp4ilbJkq5QYbhj6iCw5FdGcx14AEq7TMn9Ge25Qo=;
        b=AaPbOrnPrtsIzlqcWR0Uztu4HaiDBOxGcS9kS0VG5ID9Fb2w809/OXdct5VQTrcyr5
         BoL5JlAoahpZTtB8sYpktjhOk9tD6DISZ423uJpcZ42h3VDTQsoUUk/ytKI6aHX6zu67
         OJS7Fts87ITRfZs9tBBRVoYb4UPoMXArtOnUT+2b8FPkYPoTEVM6xT4McKl2vgA4j1SE
         THbeLAGRpwKaSozGrDBNTGP4g9PrHNQbTJ9JjjISi7BRg90i/RsYU8lCIdRiRs5lbeHW
         j4Q30N4CzrhwPE0zi1HJ1kKYsPAbDiAoeAupenH96ElZJHNYV7g38q26DHaLHk+6LCmw
         sxrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gzmp4ilbJkq5QYbhj6iCw5FdGcx14AEq7TMn9Ge25Qo=;
        b=Jp64HibEzSFfzse7WQ0ko1JKZXoqo1bcZxeZUgr69Nv7e5vfJ+6Aj5ZAkU0T9KVdaF
         BckhJ25d77QYTjdRsi/zTmT0TiAxJHbs6SkxCE0oawLDHxIRxHq0fRi6XEVuIjDigeGy
         vmZkRx6hBL+vSxCTcGE9uTj7UZ55qsLPOmG4tu7hoTeHqamImnf58kvOqXtYH86nlX2W
         XZcMqXH3uZ2VUc5VTQt+/5IAZGn3TUuNtcxWmcGrC3ZGaQR+aml9BSjA/LISHfnNKg/B
         qjPJPmZRnym7lwAcVyI5u324FCdSE5PS0f8ZuF2Y3yasPDpErNTjkcKLPO5d6iS+ydR0
         0JDQ==
X-Gm-Message-State: AOAM533GOEDtn4C1HQ3vLoTLzNV2do6WS9UHdG9mSDKoyqTYSI6adJSf
        VGjo1i0wLoxgUSwI/Z3+7Sl3QWCZC5EiROaDbtjQBg==
X-Google-Smtp-Source: ABdhPJwvwP/DpIyXE5I0mln05z9Xybn/2R0CgbIqW3HGXyLSpop+/xj5b6AS42KNGxJ/3Q7WTFPIP+d/PkZUiFRBCa8=
X-Received: by 2002:a17:902:ab50:b0:13f:4c70:9322 with SMTP id
 ij16-20020a170902ab5000b0013f4c709322mr28891772plb.89.1635824504674; Mon, 01
 Nov 2021 20:41:44 -0700 (PDT)
MIME-Version: 1.0
References: <163553708697.2509508.16523059414830959692.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211101120055.00007383@Huawei.com>
In-Reply-To: <20211101120055.00007383@Huawei.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 1 Nov 2021 20:41:34 -0700
Message-ID: <CAPcyv4g_c1mF6WvsMHC7-US7YybSprk=GX6cFWjoGOVa+yLx9g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce acpi_table_parse_cedt and extra nodes for CXL.mem
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Rafael J Wysocki <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-cxl@vger.kernel.org,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Nov 1, 2021 at 5:01 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri, 29 Oct 2021 12:51:27 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Hi Rafael,
> >
> > While reviewing "[PATCH v3] ACPI: NUMA: Add a node and memblk for each
> > CFMWS not in SRAT" [1]. I noticed that it was open coding CEDT sub-table
> > parsing in a similar fashion as drivers/cxl/acpi.c. The driver open
> > coded the parsing because the ACPI sub-table helpers are marked __init.
> > In order to avoid the ongoing maintenance burden of a split between
> > "early" and "late" ACPI sub-table parsing this series proposes to make
> > those helpers available to drivers.
> >
> > The savings in drivers/cxl/ are:
> >
> >  drivers/cxl/Kconfig |    1
> >  drivers/cxl/acpi.c  |  234 +++++++++++++++++++--------------------------------
> >  2 files changed, 88 insertions(+), 147 deletions(-)
> >
> > ...and 15 lines new code not added are saved in this new version of
> > "ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT".
> >
> > Let me know if this looks ok to you and I can carry it in the CXL tree
> > (i.e. after the merge window, for v5.17 consideration).
> >
> > [1]: https://lore.kernel.org/r/20211019050908.449231-1-alison.schofield@intel.com
>
> Is it worth the complexity of the __init_or_acpilib and export part?
> Seems like a fiddly dance for what looks to be minor savings...

It follows the __initdata_or_meminfo precedent that identifies data
that is normally __init unless a specific driver needs it. The lesson
from the tinyconfig effort was that image size dies a death of many
cuts unless care is taken to preserve minor savings. Yes, it's likely
trivial in this case, but it's at least a gesture to avoid bloating
the kernel image size unnecessarily when the kernel has gotten by so
long with this infrastructure being purely __init.
