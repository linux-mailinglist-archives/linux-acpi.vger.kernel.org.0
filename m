Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A375203A16
	for <lists+linux-acpi@lfdr.de>; Mon, 22 Jun 2020 16:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgFVO4Q (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 22 Jun 2020 10:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729065AbgFVO4P (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jun 2020 10:56:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA002C061573;
        Mon, 22 Jun 2020 07:56:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so8534828pfe.4;
        Mon, 22 Jun 2020 07:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjagLTgBdJuS+lxCzj+HJEcO0dILS8d3HH+uOW/jYtg=;
        b=Md8aji7v9v0IesqnKaESVzP6xZdACvIez0GIkPpCPmtWFsewspfffLO15ZBS7ofNeu
         i5H6dE4LJi6O1A7RSHmuZV7nLXinxR9H7+KvrUlooYEHr0Aho3aIMdQBF+L2sXNjFY0Q
         Gh3B3cagl5QtXpxT+COfqGy3PV+KOXHuG4NH1Uel+v8fSPemDaWeTlsS66xv1B1raMhj
         hwwZkHtRYkYbQiX9vMs0U4oAYXI3hPYLW1fttm9Az0WpH9SpcI96Hsx+A8vJEbcEYtTY
         motBNPnQH1XLgb+g1Es5sQUsaGzcdvH04dcVsVHiVlXm0B/C8j0Kl7aCzhOciJwAKT4l
         3EcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjagLTgBdJuS+lxCzj+HJEcO0dILS8d3HH+uOW/jYtg=;
        b=FL/9ZUke9nYc9Lp4oVi1Ud/41UyP4RH0a3is0kph3vGq7fIrF3eJLPNmmaMDFFZCHk
         Z/gTZKAOiS+aduXZF9Ce8EJwWQKM7dLK7/bL/jv+M41WM12ne6vlj8s87jAnl3Z8lYbb
         LAIOMFTkppoLXghjwpu/v0X9CswnrRh3/zI7mSK9s1F1vUf+zmyYnuWhIGLRlTv46jQH
         gt7G0UdKPZIABkxCvjHdnJxRSct1bMiojcFD/dSWRM+EbidxJp73QEu2yO25XZ9x4R/o
         UH/mL89dvNL0ri7f/nGCBW54S2khd8LxeCmW35fAnR22f2AT4CccX/R3VtiNUZpkWll7
         Z6Ag==
X-Gm-Message-State: AOAM533sqtSmOWkXjqirdaFheEk1F9Z9/MthF6lE1oqwku/H1+NnPQ+v
        I3cdCONVUa0KjdsBO3spC4gBcWbf37hQ97llIyI=
X-Google-Smtp-Source: ABdhPJw6mQ+zxmpMSkJb+dlDQRkhgtNZHBFjiCPSrtowB9pYMq4Z4oApxfCZkPSIP1wpDoaef47WoTMB7FRH5DO4Uyo=
X-Received: by 2002:a62:3103:: with SMTP id x3mr20128249pfx.130.1592837774307;
 Mon, 22 Jun 2020 07:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <2713141.s8EVnczdoM@kreacher> <1821880.vZFEW4x2Ui@kreacher>
In-Reply-To: <1821880.vZFEW4x2Ui@kreacher>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Jun 2020 17:56:01 +0300
Message-ID: <CAHp75VePDyPevCAOntFpTajf5zd9ocwjeWRz80WmCNtiDicpLg@mail.gmail.com>
Subject: Re: [RFT][PATCH v2 2/4] ACPI: OSL: Add support for deferred unmapping
 of ACPI memory
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ira Weiny <ira.weiny@intel.com>,
        James Morse <james.morse@arm.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-nvdimm@lists.01.org, Bob Moore <robert.moore@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, Jun 22, 2020 at 5:06 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Implement acpi_os_unmap_deferred() and
> acpi_os_release_unused_mappings() and set ACPI_USE_DEFERRED_UNMAPPING
> to allow ACPICA to use deferred unmapping of memory in
> acpi_ex_system_memory_space_handler() so as to avoid RCU-related
> performance issues with memory opregions.

...

> +static bool acpi_os_drop_map_ref(struct acpi_ioremap *map, bool defer)
>  {
> -       unsigned long refcount = --map->refcount;
> +       if (--map->track.refcount)
> +               return true;
>
> -       if (!refcount)
> -               list_del_rcu(&map->list);
> -       return refcount;
> +       list_del_rcu(&map->list);
> +

> +       if (defer) {
> +               INIT_LIST_HEAD(&map->track.gc);
> +               list_add_tail(&map->track.gc, &unused_mappings);

> +               return true;
> +       }
> +
> +       return false;

A nit:

Effectively it returns a value of defer.

  return defer;

>  }

...

> @@ -416,26 +421,102 @@ void __ref acpi_os_unmap_iomem(void __iomem *virt, acpi_size size)
>         }
>
>         mutex_lock(&acpi_ioremap_lock);
> +
>         map = acpi_map_lookup_virt(virt, size);

A nit: should it be somewhere else (I mean in another patch)?

>         if (!map) {

...

> +       /* Release the unused mappings in the list. */
> +       while (!list_empty(&list)) {
> +               struct acpi_ioremap *map;
> +
> +               map = list_entry(list.next, struct acpi_ioremap, track.gc);

A nt: if __acpi_os_map_cleanup() (actually acpi_unmap() according to
the code) has no side effects, can we use list_for_each_entry_safe()
here?

> +               list_del(&map->track.gc);
> +               __acpi_os_map_cleanup(map);
> +       }
> +}

...

> @@ -472,16 +552,18 @@ void acpi_os_unmap_generic_address(struct acpi_generic_address *gas)
>                 return;
>
>         mutex_lock(&acpi_ioremap_lock);
> +
>         map = acpi_map_lookup(addr, gas->bit_width / 8);

A nit: should it be somewhere else (I mean in another patch)?

-- 
With Best Regards,
Andy Shevchenko
