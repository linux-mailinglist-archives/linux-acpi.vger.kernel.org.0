Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA393AB3DD
	for <lists+linux-acpi@lfdr.de>; Thu, 17 Jun 2021 14:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhFQMoS (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 17 Jun 2021 08:44:18 -0400
Received: from mail-oi1-f172.google.com ([209.85.167.172]:44680 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231623AbhFQMoR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jun 2021 08:44:17 -0400
Received: by mail-oi1-f172.google.com with SMTP id a26so6352630oie.11;
        Thu, 17 Jun 2021 05:42:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZSdAlA7229AxqrvmWdPuLysFFr809Vi8uOO0GFEEjMw=;
        b=ELHNd6J+FpRjo+CVRo048k3dVS1UX1ifYoaIXhem/qCrzmi+b1ZFT/WUnCtNMZ2n0j
         2WvdkZjXYfCrkrcTqZvVmSIz5LJsvID7awBjxpteUmvem9nW2Rnhc4PO2c2VWjIXYWM7
         y7E25aKkALzj+hekr3IN8TH4RVwFlhCTtGjDeJ75m+TPE57NY+s9d/KTUBWUbMDysXBk
         6zrpbxQAMEYoFAVSJS175oijXASmtCG10waAjLCd2ZNZOL45BlHUfEwwIC7wVhVZyGz6
         MDgDgyFjirlNEHFKnRBIENpVWcmdCmgrWpuwJGewajkNTfcqQXS18y0QNlAsa/QF7h7C
         hMFw==
X-Gm-Message-State: AOAM530uGyUe0kpmalslyDtE2A7bKFmhPJoa3mK2XXchJjw+1+ymlp/W
        jLHd+qTn0Makn7Y92kuY9oTugg731HMbHISR1m4=
X-Google-Smtp-Source: ABdhPJyE4Uc9tX5vAYC9Hgs0pgYC//1t7VmAuqfGpxl5H4EJ9A4L6d22+T+E0aFHoRGx302POKyLAz9pOTxy0/VeyIM=
X-Received: by 2002:aca:49c7:: with SMTP id w190mr10723282oia.157.1623933730094;
 Thu, 17 Jun 2021 05:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210615172157.2841280-1-weiyongjun1@huawei.com>
In-Reply-To: <20210615172157.2841280-1-weiyongjun1@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 17 Jun 2021 14:41:59 +0200
Message-ID: <CAJZ5v0jW0VKi1m_5oNyMtEgKVA3=WuEdiDU_1=p6Ezm5zvUSog@mail.gmail.com>
Subject: Re: [PATCH -next] ACPI: PRM: make symbol 'prm_module_list' static
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 15, 2021 at 7:11 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> The sparse tool complains as follows:
>
> drivers/acpi/prmt.c:53:1: warning:
>  symbol 'prm_module_list' was not declared. Should it be static?
>
> This symbol is not used outside of prmt.c, so marks it static.
>
> Fixes: cefc7ca46235 ("ACPI: PRM: implement OperationRegion handler for the PlatformRtMechanism subtype")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/acpi/prmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
> index 33c274698d07..31cf9aee5edd 100644
> --- a/drivers/acpi/prmt.c
> +++ b/drivers/acpi/prmt.c
> @@ -50,7 +50,7 @@ struct prm_context_buffer {
>  #pragma pack()
>
>
> -LIST_HEAD(prm_module_list);
> +static LIST_HEAD(prm_module_list);
>
>  struct prm_handler_info {
>         guid_t guid;
>

Applied, thanks!
