Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1F81C8CEF
	for <lists+linux-acpi@lfdr.de>; Thu,  7 May 2020 15:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgEGNtT (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 7 May 2020 09:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgEGNtR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 7 May 2020 09:49:17 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6732083B
        for <linux-acpi@vger.kernel.org>; Thu,  7 May 2020 13:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588859356;
        bh=Y80LahXgKe9aD4SesvsSscumeX54TGslpdqTZX/bqZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1BTed9ewcsXvnnDDcVvEElouNM72YH7BTToCr9y3v6Ch4jsDHMmG3XPaurACgCHWz
         FHC7eR7WU0fjyk46TlW49pQv1yYsHynYW/uhtzJkJeiT1RVXlZ/XyEBumKLe698v2C
         cXvsOhMOpr8FVDfSvJbPjB1j1EyNcQWiTXMxQKGQ=
Received: by mail-io1-f51.google.com with SMTP id i19so3865679ioh.12
        for <linux-acpi@vger.kernel.org>; Thu, 07 May 2020 06:49:16 -0700 (PDT)
X-Gm-Message-State: AGi0PuZDfNWRuMy/aXFM4JzJ1ZXfLc4f/5/EGqhei/Rs0LZfoWAe73UP
        4uDdPnM0Tin16BALs0byoqNYl2bs+s6VEx782O8=
X-Google-Smtp-Source: APiQypL2NHEgs2rvwfrzhTk58JvNGGA087lX1dAPFABa6q/geCppW4/1rQCT4O5DS9ilqochTzOQyzniC1V91BeoMEE=
X-Received: by 2002:a6b:ef03:: with SMTP id k3mr14013067ioh.203.1588859355786;
 Thu, 07 May 2020 06:49:15 -0700 (PDT)
MIME-Version: 1.0
References: <1588858868-18039-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1588858868-18039-1-git-send-email-guohanjun@huawei.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 7 May 2020 15:49:04 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHGfW=OKLO1S1Mf__9TzNXkrZ5BNvD8H_QYUTtF+awwpg@mail.gmail.com>
Message-ID: <CAMj1kXHGfW=OKLO1S1Mf__9TzNXkrZ5BNvD8H_QYUTtF+awwpg@mail.gmail.com>
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

On Thu, 7 May 2020 at 15:47, Hanjun Guo <guohanjun@huawei.com> wrote:
>
> As we already applied a workaround for the off-by-1 issue,
> it's good to add extra message "applying workaround" to
> make people less uneasy to see such message in the boot log.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>

Hi Hanjun,

> ---
>
> Based on top of for-next/acpi branch of ARM64 repo
>
>  drivers/acpi/arm64/iort.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index b011d25..f3d492a 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -328,7 +328,7 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
>                  * Otherwise, things are *really* broken, and we just disregard
>                  * duplicate matches entirely to retain compatibility.
>                  */
> -               pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x\n",
> +               pr_err(FW_BUG "[map %p] conflicting mapping for input ID 0x%x, applying workaround\n",

This is not correct. The workaround is only applied if rid_in ==
map->input_base, so better to print a second line after the 'return'
below that is only reached in that particular case.

>                        map, rid_in);
>                 if (rid_in != map->input_base)
>                         return -ENXIO;
> --
> 1.7.12.4
>
