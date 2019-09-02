Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F19EDA5D86
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfIBV3D (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 17:29:03 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35385 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBV3D (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 17:29:03 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so11269977oii.2;
        Mon, 02 Sep 2019 14:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyEcBZbH1GhXCdZ3FGf7pSNInmzgfSYlTtfzGsz7yT4=;
        b=FnAlRYRBhYiU+9FuKbpo2Tv9TKa2xwTn4KwLptzu/72PJ5/N2dl74w2DZhT4yhpbFf
         BaSgKUiXO/KAneq7pAE/xzDQi4k4pzMjcOfR+T/Q/KRNBDNQqnnAd2UPUZ6Ccivn2Aje
         82BKuM3pFNsY6js6cmsc2/vOHmQkddb4QrjEy7cD7q2yFSQm4wvQwpSixvROurPcLjFk
         nPoGiETbNbV/2Z1UAwNw17wtY5dxTdE7ji0Vpfv6MrCiaNnsO3WRUASJYX4QZsMGFc4c
         k3oVv0dQzWrplGsqhzY7V8ACvlRG8DSHJABtpi/YK6Fz85W8GrZT6TUBtGcnon4cSOYZ
         C6jw==
X-Gm-Message-State: APjAAAXJlD7S/CW9CDA8XrJYnP4/za5kmrByKZy4Y2h4Bvc6UFvZ7vZu
        JfDx/8OcgrIhjy9lBYbSznUqaM2lGE/nX5BXEkaOxQ==
X-Google-Smtp-Source: APXvYqytCdvjf2j1TjsZ7xbw47dSuzZwkMXg9Pu48QK5difJX/Qu3f8FFRUenGqOOspgzHoTsKNETF/4P2YGeR/TlWM=
X-Received: by 2002:aca:f105:: with SMTP id p5mr12414543oih.57.1567459742390;
 Mon, 02 Sep 2019 14:29:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190806042440.16445-1-daniel@linux.ibm.com>
In-Reply-To: <20190806042440.16445-1-daniel@linux.ibm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:28:50 +0200
Message-ID: <CAJZ5v0jXiuA3HGPCY3vbH8_53WP-6G=bVJ8SPprCDDg9MoyAsQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/hmat: ACPI_HMAT_MEMORY_PD_VALID is deprecated in ACPI-6.3
To:     Daniel Black <daniel@linux.ibm.com>,
        Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Aug 6, 2019 at 6:24 AM Daniel Black <daniel@linux.ibm.com> wrote:
>
> ACPI-6.3 corresponds to when hmat revision was bumped from
> 1 to 2. In this version ACPI_HMAT_MEMORY_PD_VALID was
> deprecated and made reserved.
>
> As such in revision 2+ we shouldn't be testing this flag.
>
> This is as per ACPI-6.3, 5.2.27.3, Table 5-145
> "Memory Proximity Domain Attributes Structure"
> for Flags.
>
> Signed-off-by: Daniel Black <daniel@linux.ibm.com>

Keith, any comments?

> ---
>  drivers/acpi/hmat/hmat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/hmat/hmat.c b/drivers/acpi/hmat/hmat.c
> index 96b7d39a97c6..e938e34673d9 100644
> --- a/drivers/acpi/hmat/hmat.c
> +++ b/drivers/acpi/hmat/hmat.c
> @@ -382,7 +382,7 @@ static int __init hmat_parse_proximity_domain(union acpi_subtable_headers *heade
>                 pr_info("HMAT: Memory Flags:%04x Processor Domain:%d Memory Domain:%d\n",
>                         p->flags, p->processor_PD, p->memory_PD);
>
> -       if (p->flags & ACPI_HMAT_MEMORY_PD_VALID) {
> +       if (p->flags & ACPI_HMAT_MEMORY_PD_VALID && hmat_revision == 1) {
>                 target = find_mem_target(p->memory_PD);
>                 if (!target) {
>                         pr_debug("HMAT: Memory Domain missing from SRAT\n");
> --
> 2.21.0
>
