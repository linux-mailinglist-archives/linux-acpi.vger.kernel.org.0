Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28902ED0DE
	for <lists+linux-acpi@lfdr.de>; Thu,  7 Jan 2021 14:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbhAGNaM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-acpi@lfdr.de>); Thu, 7 Jan 2021 08:30:12 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:45616 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728277AbhAGNaM (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jan 2021 08:30:12 -0500
Received: by mail-ot1-f46.google.com with SMTP id n42so6198919ota.12;
        Thu, 07 Jan 2021 05:29:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=O0IFt919wBzbG3JSlTkTtKHQ7HuQSNcqkdNzTODBuQU=;
        b=V7cCo6tvs607iniT8FqCtvsy66+08G++gxzneWodoDJL34aZ4zjquh5A9TbKchJWff
         R5yiqqAPVH/S2Lj8cJf4N7BOFjoaKr9UDhXyhKvyiWruEDOvPcrWwkZP74c+kpftwVn4
         ERrDaf4PSqyiJ9bRjCSCD9cCwEg9TypfTXKM65ITCW7qHT9BCK7dSOHH3S5XAxQWxPfy
         Sc3X6TBt9uiV0MpIihzUXUEmDOEv9Un2ZslyOJtNDRR3Z7WgbTvHQZT7090xGz1Sod+w
         IKH4hy337iXggPL2W5nMhCyTdX1kmrhqL+OVFKPFueCPC+N/q20C9Q67UgQIW2Vz5N8n
         fzpA==
X-Gm-Message-State: AOAM530p36QsgjXow5CzM/2nNcEcee4c2ZHQ4HjP/l/5JWE8/W/mOoyL
        k6HbqzDm4YluI/DI6BA2cE5FS0mj0u/Ummxf8FjNFbAvwQk=
X-Google-Smtp-Source: ABdhPJwjLHRp5Xjg+XRGcx0yCh9G0neQuVmsfB8533sqwYQp9rQ1Sr5FOoiZVuOIyZP6/7JsiE8Wbf1HtQ1371q5nlE=
X-Received: by 2002:a9d:67da:: with SMTP id c26mr6641913otn.321.1610026171229;
 Thu, 07 Jan 2021 05:29:31 -0800 (PST)
MIME-Version: 1.0
References: <20210106012301.71260-1-yebin10@huawei.com>
In-Reply-To: <20210106012301.71260-1-yebin10@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 7 Jan 2021 14:28:55 +0100
Message-ID: <CAJZ5v0jhXFOW3DsM2xsSq2fZmeGOz=ARTH3VkcTNZ7m9cyYVgA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_ACPI=3A_PM=3A_s2idle=3A_Remove_useless_variabl?=
        =?UTF-8?Q?e_=E2=80=98obj=5Fnew=E2=80=99_in_lpi=5Fdevice=5Fget=5Fconstraints=5Famd?=
To:     Ye Bin <yebin10@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jan 6, 2021 at 2:13 AM Ye Bin <yebin10@huawei.com> wrote:
>
> Fix warning:
> drivers/acpi/x86/s2idle.c:138:25: warning: variable ‘obj_new’ set but
> not used [-Wunused-but-set-variable]
>       union acpi_object *obj_new;
>                                ^~~~~~~
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/acpi/x86/s2idle.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 25fea34b544c..e5fb17fd1020 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -135,12 +135,10 @@ static void lpi_device_get_constraints_amd(void)
>
>                                 for (k = 0; k < info_obj->package.count; ++k) {
>                                         union acpi_object *obj = &info_obj->package.elements[k];
> -                                       union acpi_object *obj_new;
>
>                                         list = &lpi_constraints_table[lpi_constraints_table_size];
>                                         list->min_dstate = -1;
>
> -                                       obj_new = &obj[k];
>                                         switch (k) {
>                                         case 0:
>                                                 dev_info.enabled = obj->integer.value;
> --

I posted an alternative fix for this issue on Tue, sorry:

https://patchwork.kernel.org/project/linux-pm/patch/3607102.xkEKTzvHZR@kreacher/
