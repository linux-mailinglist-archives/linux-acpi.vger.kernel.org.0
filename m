Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF0916051E
	for <lists+linux-acpi@lfdr.de>; Fri,  5 Jul 2019 13:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfGELKD (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Fri, 5 Jul 2019 07:10:03 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45236 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfGELKC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 5 Jul 2019 07:10:02 -0400
Received: by mail-lf1-f67.google.com with SMTP id u10so6052333lfm.12;
        Fri, 05 Jul 2019 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5RdEr/X79ZzCf783w6bsQHLAIWzpq3B5zyX8W61fTzI=;
        b=BEJ0jTNDgxkIrq5B0EAyVPWrcib5p8ltZW1kqENTIzzMAgI7BvHjiV/4/6ExHMMu/W
         zUgdPUTxMP9mDx7qjrfhIWGFKrmyqL1BYxrjt9ma+pJklavUO+Gw02cp+gF6aAdicDDt
         L6klAFIcohzWpJ69+fMRgmpGz2V9cGiyVLY9x33LulH/ORwdrqKCqff7tZ5CgI+hNgUW
         Yls2gurLdNlhgGxVt6zNnIxwmwCIZo9FTAT7dnfQF68ainZ5ieky7dGuqhk02eCV/0xI
         T9vtA6u77fb/A1cepU9CKQ4IaFYmz4nsGtM1xwZWQhMxcS3rwzQk1pdr3wjpEidokcGu
         EWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5RdEr/X79ZzCf783w6bsQHLAIWzpq3B5zyX8W61fTzI=;
        b=KST1WL8jbFzRsF/qfKTU/cLalpHHKYVkRNRgxaKSN5Psc+CPxloavbOlnrxnDEhNn0
         WmENE8zNYT7A0LI3N4Xl9BuJ+SefufXllXl2/n9u9EKl79e8dbOLTMt1TOL4es/w04l4
         OR8vlT0bvTZk/YDWehbMKEKZrtyd4hOgqqrmQlDa/ly+uquSq+umMvP86bRhjJ9myALb
         AbW1cOXLe8BnOikLNJ1+yWq16sBMMZ7/3188rfol6PgMD4uyxRlR+jTjIKTV6g3UbIJy
         bDjj3aNSuS32UjRFhyAyBpfzMib20JTJwcEmJH9od5rSMT5Q2uGYVFG0npdfNVX5hW3/
         H28w==
X-Gm-Message-State: APjAAAX3g+kN9sbZya/g3Kvj4+tgpRbpgkTtJ5ENkmC82k9sYt8MOSSA
        JFcODeTnVwT0GaKrMXXa8YKl4BQBukgue5c/Eo4=
X-Google-Smtp-Source: APXvYqz949oo2/kA7nq/uLcOQSgvG3b3xUHzgNiXeOmOmSGCD3sqOvcoaQa63QGtwoIvsSuETPtkwACwhlOwk2WqOJU=
X-Received: by 2002:ac2:5189:: with SMTP id u9mr1742156lfi.189.1562325000643;
 Fri, 05 Jul 2019 04:10:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190705095800.43534-1-mika.westerberg@linux.intel.com> <20190705095800.43534-4-mika.westerberg@linux.intel.com>
In-Reply-To: <20190705095800.43534-4-mika.westerberg@linux.intel.com>
From:   Yehezkel Bernat <yehezkelshb@gmail.com>
Date:   Fri, 5 Jul 2019 14:09:44 +0300
Message-ID: <CA+CmpXtMBEtyh77fcrhX2BU8esiit56CWfZmey6LYEHZVUxf8A@mail.gmail.com>
Subject: Re: [PATCH 3/8] thunderbolt: Use 32-bit writes when writing ring producer/consumer
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        Anthony Wong <anthony.wong@canonical.com>,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jul 5, 2019 at 12:58 PM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> The register access should be using 32-bit reads/writes according to the
> datasheet. With the previous generation hardware 16-bit writes have been
> working but starting with ICL this is not the case anymore so fix
> producer/consumer register update to use correct width register address.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/thunderbolt/nhi.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
> index 27fbe62c7ddd..09242653da67 100644
> --- a/drivers/thunderbolt/nhi.c
> +++ b/drivers/thunderbolt/nhi.c
> @@ -143,9 +143,24 @@ static void __iomem *ring_options_base(struct tb_ring *ring)
>         return io;
>  }
>
> -static void ring_iowrite16desc(struct tb_ring *ring, u32 value, u32 offset)
> +static void ring_iowrite_prod(struct tb_ring *ring, u16 prod)
>  {
> -       iowrite16(value, ring_desc_base(ring) + offset);
> +       u32 val;
> +
> +       val = ioread32(ring_desc_base(ring) + 8);
> +       val &= 0x0000ffff;
> +       val |= prod << 16;
> +       iowrite32(val, ring_desc_base(ring) + 8);
> +}
> +
> +static void ring_iowrite_cons(struct tb_ring *ring, u16 cons)
> +{
> +       u32 val;
> +
> +       val = ioread32(ring_desc_base(ring) + 8);
> +       val &= 0xffff0000;
> +       val |= cons;
> +       iowrite32(val, ring_desc_base(ring) + 8);
>  }
>
>  static void ring_iowrite32desc(struct tb_ring *ring, u32 value, u32 offset)
> @@ -197,7 +212,10 @@ static void ring_write_descriptors(struct tb_ring *ring)
>                         descriptor->sof = frame->sof;
>                 }
>                 ring->head = (ring->head + 1) % ring->size;
> -               ring_iowrite16desc(ring, ring->head, ring->is_tx ? 10 : 8);
> +               if (ring->is_tx)
> +                       ring_iowrite_prod(ring, ring->head);
> +               else
> +                       ring_iowrite_cons(ring, ring->head);

Really a matter of taste, but maybe you want to consider having a single
function, with a 3rd parameter, bool is_tx.
The calls here will be unified to:
        ring_iowrite(ring, ring->head, ring->is_tx);
(No condition is needed here).

The implementation uses the new parameter to decide which part of the register
to mask, reducing the code duplication (in my eyes):

        val = ioread32(ring_desc_base(ring) + 8);
        if (is_tx) {
                val &= 0x0000ffff;
                val |= value << 16;
        } else {
                val &= 0xffff0000;
                val |= value;
        }
        iowrite32(val, ring_desc_base(ring) + 8);

I'm not sure if it improves the readability or makes it worse. Your call.
