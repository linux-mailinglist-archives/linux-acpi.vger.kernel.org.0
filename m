Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3977E3DDC99
	for <lists+linux-acpi@lfdr.de>; Mon,  2 Aug 2021 17:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234655AbhHBPiC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Mon, 2 Aug 2021 11:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:47132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234605AbhHBPiB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 2 Aug 2021 11:38:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F331561103;
        Mon,  2 Aug 2021 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627918672;
        bh=U6kvM7hjSC76+fQoa0a/IaaXzBvI0i+8+uxTT40yjO0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lbVqO9NaiV9RK2DfsHoS0hfiZPwOV8yrk0ZU2uRqbJY5SQ64ZlL5InD+kyZwCio6/
         kJ8qvvAedeRpMzu5TM2Zbva3CqxetCxFMGNquIN/x73Ehb/QquWBPkZ1g9Zjo/3YKY
         lc8qLrn4PVhwAcweY/L48kCQom+zvqDXOHQWsN9IaCi5T+i3D51m033WKteKMINdwk
         UJKDa1txp/Gnphq7PzsWGA+cKilXwKSCjFzA89yCasYZire7DkZEaIwzJcZa+CPy0i
         zjtuCcytilrD5Y6LLGh5vy19A4D0mEnJrt9FVI8yymCrHnUy9Z7EMOs3b9S8p3QGmO
         YRPJ/Ybw3EQIg==
Received: by mail-oo1-f47.google.com with SMTP id k7-20020a4abd870000b029025e4d9b0a3dso746426oop.6;
        Mon, 02 Aug 2021 08:37:51 -0700 (PDT)
X-Gm-Message-State: AOAM5302sawzgUp4FUcXN56sbahpkSOR+1woyLmv9O3WDKTlt1O4GA/m
        +I4nuJtNpd1wwMfuUuo0u0iugxlE9zVlV6f3oTE=
X-Google-Smtp-Source: ABdhPJwKKdHfEqVJzsxa1UD9AtgB/0tptfvNeDagjNfo6ROiQZXyY4TWeTVpdkWznh147Qe3deblfxgW7B51ZleNa1g=
X-Received: by 2002:a4a:414e:: with SMTP id x75mr11195341ooa.13.1627918671384;
 Mon, 02 Aug 2021 08:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210726100026.12538-1-lorenzo.pieralisi@arm.com> <20210802152359.12623-1-lorenzo.pieralisi@arm.com>
In-Reply-To: <20210802152359.12623-1-lorenzo.pieralisi@arm.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 2 Aug 2021 17:37:40 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEyk5xfJsCy=KMuM2cVFR93zkCKBZjUzyiONDR9+Q4EBQ@mail.gmail.com>
Message-ID: <CAMj1kXEyk5xfJsCy=KMuM2cVFR93zkCKBZjUzyiONDR9+Q4EBQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI: Fix acpi_os_map_memory() memory semantics
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Veronika kabatova <vkabatov@redhat.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will@kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Mon, 2 Aug 2021 at 17:24, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> Patch series is a v2 of a previous version[1]:
>
> v1->v2
>         - Added patch 1 and 2 according to feedback received on[1]
>
> [1] https://lore.kernel.org/linux-acpi/20210726100026.12538-1-lorenzo.pieralisi@arm.com
>
> Lorenzo Pieralisi (3):
>   ACPI: osl: Add __force attribute in acpi_os_map_iomem() cast
>   ACPI: osl: Reorder acpi_os_map_iomem() __ref annotation
>   ACPI: Add memory semantics to acpi_os_map_memory()
>

For the series,

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/arm64/include/asm/acpi.h |  3 +++
>  arch/arm64/kernel/acpi.c      | 19 ++++++++++++++++---
>  drivers/acpi/osl.c            | 23 ++++++++++++++++-------
>  include/acpi/acpi_io.h        | 12 ++++++++++--
>  4 files changed, 45 insertions(+), 12 deletions(-)
>
> --
> 2.31.0
>
