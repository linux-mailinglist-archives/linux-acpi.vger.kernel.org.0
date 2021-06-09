Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0003A151B
	for <lists+linux-acpi@lfdr.de>; Wed,  9 Jun 2021 15:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhFINIX (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 9 Jun 2021 09:08:23 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:38831 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFINIW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2021 09:08:22 -0400
Received: by mail-ot1-f50.google.com with SMTP id j11-20020a9d738b0000b02903ea3c02ded8so10226736otk.5;
        Wed, 09 Jun 2021 06:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9hr9RsM9zNNuYw3ly+RrdhuD9VNNNRXckBVBQ8djeU=;
        b=JTSb/TQ0nBE2EciLUKv+Uf61q4bUlhBkAVGvmt/PZEihHPnUrRto455SsxvTrczl9f
         /TunfJ3Kn5J1jTjmF0eDI5AYADKYUIyORD5iQJpNX5RlzPvMFqAvG9mqaK3/A6GXUd3g
         idLPZRoOHEd3rwOWGPR4a9JIewdTGvVEdLLrFMeb0wNHeUw4imSD83phb+2Upb+O4som
         FxfqAKcFb2xMl9H8YszQhUN44MQUSMxVYJs2yOKDJ/iXj7vFGe0EAm6cMBuCESZSRlNW
         jd2tgIo61J1HWwmaRVs3JGMP1nDfBQASJM4WeAPT3v+EegbDmZIg85kF0dUUmykOftUE
         Je5w==
X-Gm-Message-State: AOAM533KOndz+IvGcYmCfBfft1U7HC6PYXv0hl2Ql5KtMNu2VJQlOHBx
        08RxZ7r7j6YZmalNr+6gcSaNrOhcj1qCqlB2Lz4=
X-Google-Smtp-Source: ABdhPJwq01xCeS79aZbASAuRHHg9V03Lu7CDgHQGnOPOdoA2GrmAKcNbYLviTlbvcqg+eSWDdl7FP6YgwwLRIpZtFKk=
X-Received: by 2002:a9d:6c4d:: with SMTP id g13mr19675402otq.321.1623243973537;
 Wed, 09 Jun 2021 06:06:13 -0700 (PDT)
MIME-Version: 1.0
References: <1623155732-62028-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1623155732-62028-1-git-send-email-zou_wei@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 9 Jun 2021 15:06:02 +0200
Message-ID: <CAJZ5v0ja1rC7yJ2LzVQ5zpBwCuDp5497=_qo9G2hKLHb4amqrA@mail.gmail.com>
Subject: Re: [PATCH -next] PNP: pnpbios: convert list_for_each to entry variant
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 8, 2021 at 2:17 PM Zou Wei <zou_wei@huawei.com> wrote:
>
> convert list_for_each() to list_for_each_entry() where
> applicable.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/pnp/pnpbios/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/pnp/pnpbios/core.c b/drivers/pnp/pnpbios/core.c
> index 9b760e7..669ef47 100644
> --- a/drivers/pnp/pnpbios/core.c
> +++ b/drivers/pnp/pnpbios/core.c
> @@ -298,14 +298,12 @@ struct pnp_protocol pnpbios_protocol = {
>
>  static int __init insert_device(struct pnp_bios_node *node)
>  {
> -       struct list_head *pos;
>         struct pnp_dev *dev;
>         char id[8];
>         int error;
>
>         /* check if the device is already added */
> -       list_for_each(pos, &pnpbios_protocol.devices) {
> -               dev = list_entry(pos, struct pnp_dev, protocol_list);
> +       list_for_each_entry(dev, &pnpbios_protocol.devices, protocol_list) {
>                 if (dev->number == node->handle)
>                         return -EEXIST;
>         }
> --

Applied as 5.14 material with rewritten subject and changelog, thanks!
