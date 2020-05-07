Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0888E1C96AF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 18:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEGQkM (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 12:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGQkM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 12:40:12 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BFD02084D
        for <linux-acpi@vger.kernel.org>; Thu,  7 May 2020 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588869611;
        bh=GG1N4eYVC6gF2jkWtOf+2i+94GM+Npe39EG8Lf+ifms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HgJwnUm2oLXN80bpkEvbRGUcxO7po8C3x+eey1I1d9h16G8qEy4dyYPWtHMA+/CU8
         wMP9Z9o7JuhBTBldGAWOeFWND8Css3TFi7aacE4S84ZElrx+cepmd8zVX0UWmm6+CO
         mDQ/VUMY2FfS/WO8rZqbmImH6hXwc58bgV3p6Rko=
Received: by mail-io1-f42.google.com with SMTP id d7so2790076ioq.5
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 09:40:11 -0700 (PDT)
X-Gm-Message-State: AGi0PuYQZX2ujFsaxdQdZ6u2rCmBvooFoFQOJUACIRXC15jqXQG9w+Fy
        QsM46fs53+CXIJ9+iRf7aotn8mXtunrj4XVYANk=
X-Google-Smtp-Source: APiQypJU8CxXD0K+wmjkUZLW0ktGnLc+EwVNbQw+UBmlCqtOEoPpKmbWJbvupmPg1sRh5Xk+l48nSrDsKKRjQXG30+w=
X-Received: by 2002:a02:3341:: with SMTP id k1mr13309473jak.74.1588869610945;
 Thu, 07 May 2020 09:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <1588858868-18039-1-git-send-email-guohanjun@huawei.com>
 <CAMj1kXHGfW=OKLO1S1Mf__9TzNXkrZ5BNvD8H_QYUTtF+awwpg@mail.gmail.com>
 <251b222a-7340-2d06-f07b-f81a9c19ac43@huawei.com> <628896e3-e43f-5814-a5ff-2bd5de223f20@huawei.com>
In-Reply-To: <628896e3-e43f-5814-a5ff-2bd5de223f20@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 May 2020 18:39:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHY1mwtWYe3JnO4Gw_oEqSgNLiRxVyFFR2rxp4nh6sF0g@mail.gmail.com>
Message-ID: <CAMj1kXHY1mwtWYe3JnO4Gw_oEqSgNLiRxVyFFR2rxp4nh6sF0g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: IORT: Add extra message "applying workaround" for
 off-by-1 issue
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, 7 May 2020 at 16:02, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> On 2020/5/7 21:53, Hanjun Guo wrote:
> > Hi Ard,
> >
> > On 2020/5/7 21:49, Ard Biesheuvel wrote:
> >> On Thu, 7 May 2020 at 15:47, Hanjun Guo <guohanjun@huawei.com> wrote:
> >>>
> >>> As we already applied a workaround for the off-by-1 issue,
> >>> it's good to add extra message "applying workaround" to
> >>> make people less uneasy to see such message in the boot log.
> >>>
> >>> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> >>
> >> Hi Hanjun,
> >>
> >>> ---
> >>>
> >>> Based on top of for-next/acpi branch of ARM64 repo
> >>>
> >>>   drivers/acpi/arm64/iort.c | 2 +-
> >>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> >>> index b011d25..f3d492a 100644
> >>> --- a/drivers/acpi/arm64/iort.c
> >>> +++ b/drivers/acpi/arm64/iort.c
> >>> @@ -328,7 +328,7 @@ static int iort_id_map(struct
> >>> acpi_iort_id_mapping *map, u8 type, u32 rid_in,
> >>>                   * Otherwise, things are *really* broken, and we
> >>> just disregard
> >>>                   * duplicate matches entirely to retain compatibility.
> >>>                   */
> >>> -               pr_err(FW_BUG "[map %p] conflicting mapping for input
> >>> ID 0x%x\n",
> >>> +               pr_err(FW_BUG "[map %p] conflicting mapping for input
> >>> ID 0x%x, applying workaround\n",
> >>
> >> This is not correct. The workaround is only applied if rid_in ==
> >> map->input_base, so better to print a second line after the 'return'
> >> below that is only reached in that particular case.
> >
> > Obvious I'm wrong, I will update this patch, thanks a lot!
>
> By the way, how about the print below? Should I add something more?
>
>                  if (rid_in != map->input_base)
>                          return -ENXIO;
> +
> +         pr_err(FW_BUG "applying workaround for the conflicting
> mapping\n");
>

Simply 'applying workaround' should do it imo.
