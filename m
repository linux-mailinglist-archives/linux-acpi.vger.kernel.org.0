Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CAF28799C
	for <lists+linux-acpi@lfdr.de>; Thu,  8 Oct 2020 18:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbgJHQBQ (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 8 Oct 2020 12:01:16 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43964 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgJHQBQ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Oct 2020 12:01:16 -0400
Received: by mail-ot1-f67.google.com with SMTP id n61so5917976ota.10;
        Thu, 08 Oct 2020 09:01:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncmA7l15CwxkJeU0tFbx/6ulFLyyd5NMWl1kTa2aMeY=;
        b=N7ouX/L5co+1EyHWCyK8ARJa57Y5dyn3h+8190y1zZyDPa3emhMMP/fetBNCuCweS3
         01eOtnBqs9+sT3xKekUkOtiWWObr38bchz2boKQqZxIHi6yjVa+AzpVMdXsUg9nSKpaX
         9IiGfVAfmlc+b0D9INeTywijtZ8vwG8m6wINWh+EZvP6VukZrVG142VSSfFRCudv3Z/b
         N6Z6c0F4rCsqXKY52RXJFvEXasiDKZZ3xmZR1PuVrZArd9/zi8NnYK7GzzDsVZxc6tL8
         flh50phd3Rrv/yuBgbxBAKqe3Cnd6YDk+mZL75M1n9FT4R+fYfVVR4GDJIydy4cCnREu
         FjIA==
X-Gm-Message-State: AOAM531HupoiNQrFbRrw5YgjHtiRXV1yl5scVFme2lihwRzcu6XTeFrp
        YgYEoM75m55DM+I/mxfSoMk8x6Net3kRFVYLtoQ=
X-Google-Smtp-Source: ABdhPJxU8jb1koWqPLPrOgwYJIofMG+fbuiw+LoHMTx4gKOs8sqyCneL/oTRNwbHogsKiheouEFqDHSA7V4QEKsnBsw=
X-Received: by 2002:a9d:3626:: with SMTP id w35mr5880870otb.206.1602172874763;
 Thu, 08 Oct 2020 09:01:14 -0700 (PDT)
MIME-Version: 1.0
References: <20201008065303.1486028-1-hch@lst.de>
In-Reply-To: <20201008065303.1486028-1-hch@lst.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 8 Oct 2020 18:01:03 +0200
Message-ID: <CAJZ5v0jRj1Ni+470yPksa0=J16yM_5TfZgUssApNQN43WMY1Ug@mail.gmail.com>
Subject: Re: [PATCH] pnp: remove the now unused pnp_find_card function
To:     Christoph Hellwig <hch@lst.de>
Cc:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 8, 2020 at 8:53 AM Christoph Hellwig <hch@lst.de> wrote:
>
> All user of the pnp_find_card compat wrapper are gone, so remove
> the function as well.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/admin-guide/pnp.rst |  4 ----
>  drivers/pnp/isapnp/compat.c       | 23 -----------------------
>  include/linux/isapnp.h            |  6 ------
>  3 files changed, 33 deletions(-)
>
> diff --git a/Documentation/admin-guide/pnp.rst b/Documentation/admin-guide/pnp.rst
> index bab2d10631f00d..3eda08191d139a 100644
> --- a/Documentation/admin-guide/pnp.rst
> +++ b/Documentation/admin-guide/pnp.rst
> @@ -281,10 +281,6 @@ ISAPNP drivers.  They should serve as a temporary solution only.
>
>  They are as follows::
>
> -       struct pnp_card *pnp_find_card(unsigned short vendor,
> -                                      unsigned short device,
> -                                      struct pnp_card *from)
> -
>         struct pnp_dev *pnp_find_dev(struct pnp_card *card,
>                                      unsigned short vendor,
>                                      unsigned short function,
> diff --git a/drivers/pnp/isapnp/compat.c b/drivers/pnp/isapnp/compat.c
> index 6c845b6283163d..035e9509248968 100644
> --- a/drivers/pnp/isapnp/compat.c
> +++ b/drivers/pnp/isapnp/compat.c
> @@ -21,28 +21,6 @@ static void pnp_convert_id(char *buf, unsigned short vendor,
>                 (device >> 12) & 0x0f, (device >> 8) & 0x0f);
>  }
>
> -struct pnp_card *pnp_find_card(unsigned short vendor, unsigned short device,
> -                              struct pnp_card *from)
> -{
> -       char id[8];
> -       char any[8];
> -       struct list_head *list;
> -
> -       pnp_convert_id(id, vendor, device);
> -       pnp_convert_id(any, ISAPNP_ANY_ID, ISAPNP_ANY_ID);
> -
> -       list = from ? from->global_list.next : pnp_cards.next;
> -
> -       while (list != &pnp_cards) {
> -               struct pnp_card *card = global_to_pnp_card(list);
> -
> -               if (compare_pnp_id(card->id, id) || (memcmp(id, any, 7) == 0))
> -                       return card;
> -               list = list->next;
> -       }
> -       return NULL;
> -}
> -
>  struct pnp_dev *pnp_find_dev(struct pnp_card *card, unsigned short vendor,
>                              unsigned short function, struct pnp_dev *from)
>  {
> @@ -86,5 +64,4 @@ struct pnp_dev *pnp_find_dev(struct pnp_card *card, unsigned short vendor,
>         return NULL;
>  }
>
> -EXPORT_SYMBOL(pnp_find_card);
>  EXPORT_SYMBOL(pnp_find_dev);
> diff --git a/include/linux/isapnp.h b/include/linux/isapnp.h
> index 11edb2109a68f6..dba18c95844bde 100644
> --- a/include/linux/isapnp.h
> +++ b/include/linux/isapnp.h
> @@ -75,9 +75,6 @@ static inline int isapnp_proc_done(void) { return 0; }
>  #endif
>
>  /* compat */
> -struct pnp_card *pnp_find_card(unsigned short vendor,
> -                              unsigned short device,
> -                              struct pnp_card *from);
>  struct pnp_dev *pnp_find_dev(struct pnp_card *card,
>                              unsigned short vendor,
>                              unsigned short function,
> @@ -92,9 +89,6 @@ static inline int isapnp_cfg_end(void) { return -ENODEV; }
>  static inline unsigned char isapnp_read_byte(unsigned char idx) { return 0xff; }
>  static inline void isapnp_write_byte(unsigned char idx, unsigned char val) { ; }
>
> -static inline struct pnp_card *pnp_find_card(unsigned short vendor,
> -                                            unsigned short device,
> -                                            struct pnp_card *from) { return NULL; }
>  static inline struct pnp_dev *pnp_find_dev(struct pnp_card *card,
>                                            unsigned short vendor,
>                                            unsigned short function,
> --

Applied as 5.10 material, thanks!
