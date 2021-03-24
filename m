Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF93479FA
	for <lists+linux-acpi@lfdr.de>; Wed, 24 Mar 2021 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235668AbhCXNy3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 24 Mar 2021 09:54:29 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34744 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbhCXNy1 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Mar 2021 09:54:27 -0400
Received: by mail-ot1-f53.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so23081809otn.1
        for <linux-acpi@vger.kernel.org>; Wed, 24 Mar 2021 06:54:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvxTQpbMDkDS2fnwFO+0hE7NRXVaf9XdJGVoaV3HFuw=;
        b=ZzH8f9M9mYl+Gn5WjqSweFKMY6d1F5l9AHJZM2o71OQwXN8mew2TO3nuFm5N+T62kQ
         btuz9iGyV46B0tyC/VtXHIgIY0FZ1AmT2x7nM/of3+IKjYExlEhXRu5cl+sKXscsQmcF
         JIEHxp61YGkBo+x+WvGF5aeO0xv8ne7IfWalpcUkbW8iWPScaLIaZBxoDgWTcPQU1Rmu
         JX8nwR+RBPytEFk/HMw9Ap18+wqwVkmD0bdDUdlG1u8tZldbgYTA0raZYWYJdRMU+ox4
         kezWSS9hyaClQn0tFPoDQ4x5v78Bv/D9yAfDDQkT4em18PcAtgURvRAycGc8ewLpZNKE
         oGNQ==
X-Gm-Message-State: AOAM531nmtof2D/1ljtVe6AxzsgrbZTToaPobjbIQ2tVQ95GmtHVmSzw
        VUKZmqO3mc/u2HugKYwwqlND2ex0HO+p75oXT/w=
X-Google-Smtp-Source: ABdhPJxVOEYbRr/a8OdPFO3CQRQeA8S1DubCxVAeE5JrcQdVqEaUmpoujYk30At7Sp4jCIaSUNazNkKpL2jx94Yle18=
X-Received: by 2002:a05:6830:20d2:: with SMTP id z18mr3310314otq.260.1616594067366;
 Wed, 24 Mar 2021 06:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210323212033.2033633-1-erik.kaneda@intel.com>
In-Reply-To: <20210323212033.2033633-1-erik.kaneda@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Mar 2021 14:54:16 +0100
Message-ID: <CAJZ5v0izYKBQiTHNj6bn89t-PVCQOBAN9m0E0vJmqdgn+LjB6w@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Always create namespace nodes using acpi_ns_create_node()
To:     Erik Kaneda <erik.kaneda@intel.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 23, 2021 at 10:52 PM Erik Kaneda <erik.kaneda@intel.com> wrote:
>
> From: Vegard Nossum <vegard.nossum@oracle.com>
>
> ACPICA commit 29da9a2a3f5b2c60420893e5c6309a0586d7a329
>
> ACPI is allocating an object using kmalloc(), but then frees it
> using kmem_cache_free(<"Acpi-Namespace" kmem_cache>).
>
> This is wrong and can lead to boot failures manifesting like this:
>
>     hpet0: 3 comparators, 64-bit 100.000000 MHz counter
>     clocksource: Switched to clocksource tsc-early
>     BUG: unable to handle page fault for address: 000000003ffe0018
>     #PF: supervisor read access in kernel mode
>     #PF: error_code(0x0000) - not-present page
>     PGD 0 P4D 0
>     Oops: 0000 [#1] SMP PTI
>     CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0+ #211
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> Ubuntu-1.8.2-1ubuntu1 04/01/2014
>     RIP: 0010:kmem_cache_alloc+0x70/0x1d0
>     Code: 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 6f cc e7 7e 4d 8b
> 20 4d 85 e4 0f 84 3d 01 00 00 8b 45 20 48 8b 7d 00 48 8d 4a 01 <49> 8b
>    1c 04 4c 89 e0 65 48 0f c7 0f 0f 94 c0 84 c0 74 c5 8b 45 20
>     RSP: 0000:ffffc90000013df8 EFLAGS: 00010206
>     RAX: 0000000000000018 RBX: ffffffff81c49200 RCX: 0000000000000002
>     RDX: 0000000000000001 RSI: 0000000000000dc0 RDI: 000000000002b300
>     RBP: ffff88803e403d00 R08: ffff88803ec2b300 R09: 0000000000000001
>     R10: 0000000000000dc0 R11: 0000000000000006 R12: 000000003ffe0000
>     R13: ffffffff8110a583 R14: 0000000000000dc0 R15: ffffffff81c49a80
>     FS:  0000000000000000(0000) GS:ffff88803ec00000(0000)
> knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000003ffe0018 CR3: 0000000001c0a001 CR4: 00000000003606f0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>      __trace_define_field+0x33/0xa0
>      event_trace_init+0xeb/0x2b4
>      tracer_init_tracefs+0x60/0x195
>      ? register_tracer+0x1e7/0x1e7
>      do_one_initcall+0x74/0x160
>      kernel_init_freeable+0x190/0x1f0
>      ? rest_init+0x9a/0x9a
>      kernel_init+0x5/0xf6
>      ret_from_fork+0x35/0x40
>     CR2: 000000003ffe0018
>     ---[ end trace 707efa023f2ee960 ]---
>     RIP: 0010:kmem_cache_alloc+0x70/0x1d0
>
> Bisection leads to unrelated changes in slab; Vlastimil Babka
> suggests an unrelated layout or slab merge change merely exposed
> the underlying bug.
>
> Link:
> https://lore.kernel.org/lkml/4dc93ff8-f86e-f4c9-ebeb-6d3153a78d03@oracle.com/
> Link:
> https://lore.kernel.org/r/a1461e21-c744-767d-6dfc-6641fd3e3ce2@siemens.com
> Debugged-by: Vlastimil Babka <vbabka@suse.cz>
> Debugged-by: Kees Cook <keescook@chromium.org>
> Reported-by: Jan Kiszka <jan.kiszka@siemens.com>
> Fixes: f79c8e4136eac37255ead8875593ae33a2c16d20 ("ACPICA: Namespace:
> simplify creation of the initial/default namespace")
>
> Link: https://github.com/acpica/acpica/commit/29da9a2a
> Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> ---
>  drivers/acpi/acpica/nsaccess.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/nsaccess.c b/drivers/acpi/acpica/nsaccess.c
> index 3f045b5953b2..a0c1a665dfc1 100644
> --- a/drivers/acpi/acpica/nsaccess.c
> +++ b/drivers/acpi/acpica/nsaccess.c
> @@ -99,13 +99,12 @@ acpi_status acpi_ns_root_initialize(void)
>                  * just create and link the new node(s) here.
>                  */
>                 new_node =
> -                   ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_namespace_node));
> +                   acpi_ns_create_node(*ACPI_CAST_PTR(u32, init_val->name));
>                 if (!new_node) {
>                         status = AE_NO_MEMORY;
>                         goto unlock_and_exit;
>                 }
>
> -               ACPI_COPY_NAMESEG(new_node->name.ascii, init_val->name);
>                 new_node->descriptor_type = ACPI_DESC_TYPE_NAMED;
>                 new_node->type = init_val->type;
>
> --

Applied as 5.12-rc material, thanks!
