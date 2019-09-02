Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B56A5D8E
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Sep 2019 23:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfIBVcO (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Sep 2019 17:32:14 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43090 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfIBVcO (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 2 Sep 2019 17:32:14 -0400
Received: by mail-ot1-f68.google.com with SMTP id 90so10830825otg.10;
        Mon, 02 Sep 2019 14:32:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRzaQ7RpTXTj09HDdlktAr/ebyQQrL0kch2BnxuHgVM=;
        b=GPqChi5ZEQEJ2d6snw08BqkZoUfTizyDuyx91exo8Ojx18+lgomU/WROvx1jQtPZ1o
         8rIghigt3pNT9eCnotG236Q9G+mbjSWGlK9a4bCfQeqHBrg1PIA+lcA4R+b919x6MGPF
         CfGbTH9T8aOFPb66/yGmcJfbCyJ4fsvS963PQkpjs7OWA9U9uqkK1T7OBXTP+PcUFvsP
         nM/0wpy5EE3gwtwxwvWftIb4RrBBIlzSVwI8lx0puDFK9h2lEJRgA+6iWCWfl46jQ+IK
         9TFr+lMe8ULfDO84JKlLNYCyQTjdb8phYQY+MTy2Vvck7zFv869tS/ajd41eYm6DD9oi
         lGzg==
X-Gm-Message-State: APjAAAWMn41siAlUT6+C55eDkyw3pfaGc1RjjOmJCWPszxsNe787fUpI
        Q6HGn1r6AtXlP9Ba9xW6h8NeGl1DxBf7dq9vSdxW0w==
X-Google-Smtp-Source: APXvYqxFaje6DHixq3AXTitOhl/CdjQent8WfatECLamdB5wUhfMK3ec5uVdGchXtjQ9kQC/iwqzzDSlffmJFXUHlug=
X-Received: by 2002:a9d:7411:: with SMTP id n17mr5860561otk.118.1567459933133;
 Mon, 02 Sep 2019 14:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <1567240295-44686-1-git-send-email-tiantao6@huawei.com>
In-Reply-To: <1567240295-44686-1-git-send-email-tiantao6@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 2 Sep 2019 23:32:01 +0200
Message-ID: <CAJZ5v0huLagaNiK38JRaYY7=N38HSrHSqbw-HJiQDUmg_HTE2Q@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Namespace: fix the no brace needed warning
To:     tiantao <tiantao6@huawei.com>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Robert Moore <robert.moore@intel.com>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        Len Brown <lenb@kernel.org>, Linuxarm <linuxarm@huawei.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Sat, Aug 31, 2019 at 10:34 AM tiantao <tiantao6@huawei.com> wrote:
>
> for if else statements having single block no braces are needed fixed
> the following checkpatch warning
>
> WARNING: braces {} are not necessary for any arm of this statement
> +               if (!prev_node) {
> [...]
> +               } else {
> [...]
>
> Signed-off-by: tiantao <tiantao6@huawei.com>
> ---
>  drivers/acpi/acpica/nsaccess.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> index 2566e2d..7cef22a 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -109,11 +109,10 @@ acpi_status acpi_ns_root_initialize(void)
>                 new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
>                 new_node->type = init_val->type;
>
> -               if (!prev_node) {
> +               if (!prev_node)
>                         acpi_gbl_root_node_struct.child = new_node;
> -               } else {
> +               else
>                         prev_node->peer = new_node;
> -               }
>
>                 new_node->parent = &acpi_gbl_root_node_struct;
>                 prev_node = new_node;
> --

The ACPICA code comes from an external project and the coding style in
it is different from the rest of the kernel, so the patch is not
applicable.

Thanks!
