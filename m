Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE3E39DE02
	for <lists+linux-acpi@lfdr.de>; Mon,  7 Jun 2021 15:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhFGNsV (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 7 Jun 2021 09:48:21 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:45644 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhFGNsV (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Jun 2021 09:48:21 -0400
Received: by mail-ot1-f54.google.com with SMTP id 6-20020a9d07860000b02903e83bf8f8fcso3709646oto.12
        for <linux-acpi@vger.kernel.org>; Mon, 07 Jun 2021 06:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tl00WXIeK5mogd1XJK9bSPoDnFXAUvV7RlkDB8YUwGY=;
        b=LgFIi9hyCs/91M/d3KRhsfQ2KSRq1MxJV3f1+LO95LUtWEozv3OsMzk04IrEhBSdC1
         +FFD1dzqwBXOD2lqH4WY0FF2cbI5pisvAHhTht6n+aIs3BobDg8LVdD3JI+KMaPNZFxT
         zbSdJ7XZGipaISKmcx0fsx29IoWR9ZZOOUUJXTtzwKG0wXPg7V0qi554lALF3BY7Sng8
         gwtWJIWKEMcjW/WLMJxahKc/b2RvqHx6DBj+xSEsn5kbsJVNnoYxdVW7qfm3X1SLpuww
         ohcywTwCFRsdl1XhLPy3UlH5EKeOI8BtfuerTpRX9qg/gaMsf/X+0NVuGCBFjVDxJk+Z
         tvzA==
X-Gm-Message-State: AOAM533GjjNjTO7JPMqaDTH5LSyMT3mStjfACexjf/aIXzKpUmHlCjsO
        WAXF/GBWZ1hYHHcIIbA26+SMSN/BgOAo6aNdK51v4nSR
X-Google-Smtp-Source: ABdhPJxFievpKdLEaeiPyt0/wt1qda9hF2Yiaof/b5Prp5f5DDVYuBavQkIPHeyKdiFKZygVLHRH4jEUdoAgqpMDvkY=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr10618418otq.321.1623073589920;
 Mon, 07 Jun 2021 06:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <1622626610-58140-1-git-send-email-guohanjun@huawei.com>
In-Reply-To: <1622626610-58140-1-git-send-email-guohanjun@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 15:46:18 +0200
Message-ID: <CAJZ5v0iFPt3V6OLUE+X95NxAM+s5dUxBiCzSRGTh+FOx4YZKnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ACPI: bus: Remove the not needed NULL set
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Jun 2, 2021 at 11:47 AM Hanjun Guo <guohanjun@huawei.com> wrote:
>
> Code running with if (!acpi_kobj) is true, acpi_kobj is NULL
> as it is, no need to set to NULL.
>
> Signed-off-by: Hanjun Guo <guohanjun@huawei.com>
> ---
>  drivers/acpi/bus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 60787d9..f9b5262 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1325,10 +1325,8 @@ static int __init acpi_init(void)
>         }
>
>         acpi_kobj = kobject_create_and_add("acpi", firmware_kobj);
> -       if (!acpi_kobj) {
> +       if (!acpi_kobj)
>                 pr_debug("%s: kset create error\n", __func__);
> -               acpi_kobj = NULL;
> -       }
>
>         result = acpi_bus_init();
>         if (result) {
> --

Applied as 5.14 material along with the [2/2[ with some edits in the
subject and changelog, thanks!
