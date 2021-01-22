Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BB4300725
	for <lists+linux-acpi@lfdr.de>; Fri, 22 Jan 2021 16:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbhAVPZQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 22 Jan 2021 10:25:16 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36365 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbhAVPZI (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2021 10:25:08 -0500
Received: by mail-ot1-f41.google.com with SMTP id v21so5389699otj.3;
        Fri, 22 Jan 2021 07:24:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+hTYwTXKEjF2Iu90nBSCMbWiP/kuflWNdkHyHSyBQCc=;
        b=JLMNTLa7uIHq/WFlYIxFUMKVOvwuklyzDFeZCS9RfAto78mIJI0NLg40Ibck7MG73e
         WxP3tGmR98mhnk2D5MV2rnHxz+H+A7QwzQuAww0tcMW32JHBiGqi0hdSHAguR3mpJvcA
         dwJpU7fBq0dkzoNM017qkck19X3m/6zPcSBMkHwFEcC7E/EV0IGbJb3DXlohq+RkaphX
         7Uz+oNF7SwMbCFiY/joXxvwRIGoJTaYYzUxq0AnejtHN2ngK/ZDL9jlod0k12e8ChbVe
         E+ZqAQPDgifv2E758XTC8kIicCWsCA9zsZekFlTGEzbvlVAAcf/1SxzNFZV8IPkFKX+I
         jaMg==
X-Gm-Message-State: AOAM530pRxTSrhEoLxbVd6ytbKyCsuNm5zebLEfuQEGFmaiIt5zhQDDm
        ypsO+g2JM3MBf/ZNt+XYAkbFz+cvqHQ2lqGtsmc=
X-Google-Smtp-Source: ABdhPJyxvRG8jhzePwqrQYdS0Z+Ju2Gr2jFC9dFpBOYEOeWIbvasQRntNsUwJrlZhUp3C41XleWzbzVOb5zjk+JbFK0=
X-Received: by 2002:a9d:1710:: with SMTP id i16mr3646961ota.260.1611329059682;
 Fri, 22 Jan 2021 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <20201228135026.28343-1-zhengyongjun3@huawei.com>
In-Reply-To: <20201228135026.28343-1-zhengyongjun3@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 22 Jan 2021 16:24:08 +0100
Message-ID: <CAJZ5v0grYbZ0WgRTvd++mdwcKWCp8UQVQK5aBHY-nD+XcayGEQ@mail.gmail.com>
Subject: Re: [PATCH -next] pnp: pnpbios: Use DEFINE_SPINLOCK() for spinlock
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Dec 28, 2020 at 2:50 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> spinlock can be initialized automatically with DEFINE_SPINLOCK()
> rather than explicitly calling spin_lock_init().
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/pnp/pnpbios/bioscalls.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/pnp/pnpbios/bioscalls.c b/drivers/pnp/pnpbios/bioscalls.c
> index ba5cfc3dbe11..ddc6f2163c8e 100644
> --- a/drivers/pnp/pnpbios/bioscalls.c
> +++ b/drivers/pnp/pnpbios/bioscalls.c
> @@ -72,7 +72,7 @@ __visible u32 pnp_bios_fault_esp;
>  __visible u32 pnp_bios_fault_eip;
>  __visible u32 pnp_bios_is_utter_crap = 0;
>
> -static spinlock_t pnp_bios_lock;
> +static DEFINE_SPINLOCK(pnp_bios_lock);
>
>  /*
>   * Support Functions
> @@ -473,7 +473,6 @@ void pnpbios_calls_init(union pnp_bios_install_struct *header)
>  {
>         int i;
>
> -       spin_lock_init(&pnp_bios_lock);
>         pnp_bios_callpoint.offset = header->fields.pm16offset;
>         pnp_bios_callpoint.segment = PNP_CS16;
>
> --

Applied as 5.12 material, thanks!
