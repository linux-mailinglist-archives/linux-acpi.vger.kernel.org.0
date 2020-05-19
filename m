Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F491D944B
	for <lists+linux-acpi@lfdr.de>; Tue, 19 May 2020 12:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgESKZ1 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 19 May 2020 06:25:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35936 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgESKZ0 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 19 May 2020 06:25:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id h7so3704592otr.3;
        Tue, 19 May 2020 03:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eV7W0QRQXtndP6jkP/fVWb+3f6ZswnL5HLdjdhMzchY=;
        b=L/xT6m/ySneD9xBsuvOY68tuRbcGVhEcvduQ8KG/nCjcC57u2mKNA2BJarM4cTkWwK
         6o+/M+xz92e8F8uelqNL1XViXlBn3XKCzQYHQduJhYdWEpbqZVYAAxIq+s1W7PkGXgXI
         SRbx1PYpAtiWhI2JhxgZC/o2/F8Zz60WvmsngNJmsFBycXM18JTAq7eWXpgH2T7l3Vj7
         tw8cUfCCd+7YvwghVTaIiq5eKqn94hTVKuK3yNUnzrdDDBOieUBz/3jz10pE97IB63io
         ygidwK14Dznb02ZGVrJWNzEZyczo0CU8Yl+msrwUpIkAPY6PZ9oAoq0dK1cB5COxttS+
         H71w==
X-Gm-Message-State: AOAM531z9gG4nzBQQUCCjxtdLIDHb6BxC1aP1EDM6dCLTDEqVPbgFAol
        Rrhvhkt2jGtZBf24kLN+3022EVrusNCVxlWr3ek=
X-Google-Smtp-Source: ABdhPJxsHZmJ0GxGhgBhGR2E78WtzR03gWHvv1HislPOLfyFU37t73pV2JWpfKyHtneguOkz8Su1AOTRYH864ZCfDwc=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr4477701otc.262.1589883925192;
 Tue, 19 May 2020 03:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200518222722.GA7791@embeddedor>
In-Reply-To: <20200518222722.GA7791@embeddedor>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 19 May 2020 12:25:13 +0200
Message-ID: <CAJZ5v0goZpvRQ6du214FqvFNQnqZHR9-kz=WhEgRsMJ3Zx0WiQ@mail.gmail.com>
Subject: Re: [PATCH] ACPICA: Replace one-element array and use struct_size() helper
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 19, 2020 at 12:22 AM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> The current codebase makes use of one-element arrays in the following
> form:
>
> struct something {
>     int length;
>     u8 data[1];
> };
>
> struct something *instance;
>
> instance = kmalloc(sizeof(*instance) + size, GFP_KERNEL);
> instance->length = size;
> memcpy(instance->data, source, size);
>
> but the preferred mechanism to declare variable-length types such as
> these ones is a flexible array member[1][2], introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.

However, the ACPICA code in the kernel comes from an external project
and changes of this type are generally not applicable to it unless
accepted upstream.

I'll let Erik and Bob take over.

> Also, make use of the new struct_size() helper to properly calculate the
> size of struct acpi_pnp_device_id_list.
>
> This issue was found with the help of Coccinellea and, audited and
> fixed _manually_.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/acpi/acpica/utids.c | 4 +---
>  include/acpi/actypes.h      | 2 +-
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utids.c b/drivers/acpi/acpica/utids.c
> index 3bb06935a2ad3..c2f819a39424a 100644
> --- a/drivers/acpi/acpica/utids.c
> +++ b/drivers/acpi/acpica/utids.c
> @@ -262,9 +262,7 @@ acpi_ut_execute_CID(struct acpi_namespace_node *device_node,
>          * 2) Size of the CID PNP_DEVICE_ID array +
>          * 3) Size of the actual CID strings
>          */
> -       cid_list_size = sizeof(struct acpi_pnp_device_id_list) +
> -           ((count - 1) * sizeof(struct acpi_pnp_device_id)) +
> -           string_area_size;
> +       cid_list_size = struct_size(cid_list, ids, count) + string_area_size;
>
>         cid_list = ACPI_ALLOCATE_ZEROED(cid_list_size);
>         if (!cid_list) {
> diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
> index 4defed58ea338..c7bcda0ad366a 100644
> --- a/include/acpi/actypes.h
> +++ b/include/acpi/actypes.h
> @@ -1145,7 +1145,7 @@ struct acpi_pnp_device_id {
>  struct acpi_pnp_device_id_list {
>         u32 count;              /* Number of IDs in Ids array */
>         u32 list_size;          /* Size of list, including ID strings */
> -       struct acpi_pnp_device_id ids[1];       /* ID array */
> +       struct acpi_pnp_device_id ids[];        /* ID array */
>  };
>
>  /*
> --
> 2.26.2
>
