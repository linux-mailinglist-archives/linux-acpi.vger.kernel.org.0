Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB7403F4F
	for <lists+linux-acpi@lfdr.de>; Wed,  8 Sep 2021 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbhIHTAL (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 8 Sep 2021 15:00:11 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:39485 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240231AbhIHTAL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 8 Sep 2021 15:00:11 -0400
Received: by mail-ot1-f45.google.com with SMTP id m7-20020a9d4c87000000b0051875f56b95so4268797otf.6;
        Wed, 08 Sep 2021 11:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEJSOLQiEemCZp/NaCXgmsRjkI5kNGuY2bc69tclxOc=;
        b=1Eymx/5BWWzrjDyyiGBLYTPNrY8dJTpviklbMqsc9Il99bPD1YeB8LNDVKV95nrtaP
         aIBZEmL28zXW+mBDDIxbbCra7xLDAJXLtrdO+V+psvQV3sivTyCa2Dlb2mXRvNLCiwA/
         /Zvk/Z2lIpW+6sVYlDz3s67SPeuEutWA6kaReD1Xr7uuO9lsyqMxgeXihviPc82WJdrd
         l9kyJRPYlij6SehRJZJPFaMLghIk9ifnIovSMn7XNtuHNLPp3S4nh+GPjQIoso/JmOVo
         /igO213ayG0iS63HkvuFD2pNigr+Ar2fyDO1xY01Q2kdMkxAWV8Aer4+plR0gsw88fWT
         Yd9w==
X-Gm-Message-State: AOAM5331a8WS6zTaFqdoeTS8IXGLj5Lexzv9D3KJHqi8S7f8a0zZUYfZ
        SnLlsyxj9Aoo8x1cEbyRwj9KrMj8tX9SXThwV68=
X-Google-Smtp-Source: ABdhPJxwEl2kWhOAw9XcLwPcAR6qWjwOz1xI7K3Au6M2TbC+JQ+Czs0hYe/fegP+EwEoDBZE3QxKWMKTsfh+/5lNqHE=
X-Received: by 2002:a05:6830:34b:: with SMTP id h11mr4466947ote.319.1631127542639;
 Wed, 08 Sep 2021 11:59:02 -0700 (PDT)
MIME-Version: 1.0
References: <1631098545-64372-1-git-send-email-aubrey.li@intel.com>
In-Reply-To: <1631098545-64372-1-git-send-email-aubrey.li@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Sep 2021 20:58:51 +0200
Message-ID: <CAJZ5v0hxQLboBBhGZvsz1cmQpjwB5v=kj9nr+=tK8BGsQqJOKg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI/PRM: Find PRMT table before parse it
To:     Aubrey Li <aubrey.li@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Sep 8, 2021 at 1:00 PM Aubrey Li <aubrey.li@intel.com> wrote:
>
> Find and verify PRMT table before parse it, this eliminates a
> warning on machines without PRMT table.
>
>         [    7.197173] ACPI: PRMT not present
>
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
> Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
>  drivers/acpi/prmt.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 1f6007a..89c22bc 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -288,10 +288,18 @@ static acpi_status acpi_platformrt_space_handler(u32 function,
>
>  void __init init_prmt(void)
>  {
> +       struct acpi_table_header *tbl;
>         acpi_status status;
> -       int mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
> +       int mc;
> +
> +       status = acpi_get_table(ACPI_SIG_PRMT, 0, &tbl);
> +       if (ACPI_FAILURE(status))
> +               return;
> +
> +       mc = acpi_table_parse_entries(ACPI_SIG_PRMT, sizeof(struct acpi_table_prmt) +
>                                           sizeof (struct acpi_table_prmt_header),
>                                           0, acpi_parse_prmt, 0);
> +       acpi_put_table(tbl);
>         /*
>          * Return immediately if PRMT table is not present or no PRM module found.
>          */
> --

Applied as 5.15-rc material with some edits in the subject and
changelog, thanks!
