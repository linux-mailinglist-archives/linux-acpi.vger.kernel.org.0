Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB056429E77
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 09:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhJLHW5 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 03:22:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:47514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233507AbhJLHWz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 03:22:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 360266109E;
        Tue, 12 Oct 2021 07:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634023254;
        bh=8jaIstSCV92d2Xt7MjVnIrZ+TWYeRa/yWVKjnGK6Ftc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ULzzgcQRRkfT7/FxruT42ePHeHsCOGgMzUC+j0GBdmvoPq0BlepZ8CN8RLkKLYDAL
         ziHwFEtHvZsBFPzBA+UhynS32skfrAKVOc33gbTgjN/uNo/aOLhOHo82+b8CMp9Xos
         bcoCbxaPhD5MGwjEj4wIWQFNmzfFVkiV0o0hRizl/lNyOf443LiMwwkac0PQ6poIuK
         Z1BYmBm95i9/u9Ma7x8RcgdgPAEQC0C3TE/mRToFQyvdr09N31UaZnMDP507q0gA0x
         CrmDBs128fruP3m8KYnDQjfCD7qHKiYodmE4IUe16OXBPfnK/d0J0FBvHlNARwNUm2
         MPl4txxXToOiw==
Received: by mail-wr1-f45.google.com with SMTP id e3so30196657wrc.11;
        Tue, 12 Oct 2021 00:20:54 -0700 (PDT)
X-Gm-Message-State: AOAM531O4dC2RiRTVTXNn553eFVvOaXGl7/5FESYrakMVBk8ya3QW0xe
        93Trp2ujgmExpdSKbmlS6nnu4Aum/TWelJUrNvs=
X-Google-Smtp-Source: ABdhPJz328ejRDzsHVNlFY0x7FAh7FFo1ebX5G5N8bb2qQCW+qmlzT6+9qldpei1G20HWxt+x2UPV+Wdji8ifq612tM=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr3855879wmg.35.1634023252673;
 Tue, 12 Oct 2021 00:20:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141921.1760209-1-arnd@kernel.org> <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
In-Reply-To: <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 12 Oct 2021 09:20:36 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0Ny=Q=3Ass2xemWSG4wUkmojh5QxXryebiemroo6oruw@mail.gmail.com>
Message-ID: <CAK8P3a0Ny=Q=3Ass2xemWSG4wUkmojh5QxXryebiemroo6oruw@mail.gmail.com>
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2021 at 9:03 AM Hanjun Guo <guohanjun@huawei.com> wrote:
> On 2021/9/27 22:19, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > In a gcc-11 randconfig build I came across this warning:
> >
> > WARNING: modpost: vmlinux.o(.text.unlikely+0x2c084): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
> > The function next_platform_timer() references
> > the variable __initdata acpi_gtdt_desc.
> > This is often because next_platform_timer lacks a __initdata
> > annotation or the annotation of acpi_gtdt_desc is wrong.
> >
> > This happens when next_platform_timer() fails to get inlined
> > despite the inline annotation. Adding '__init' solves the issue,
> > and it seems best to remove the 'inline' in the process seems
> > better anyway.
>
> There was a patch to fix this issue as well [1],
> but not merged yet.
>
> [1]:
> https://lore.kernel.org/linux-acpi/7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com/T/

Right, either of those patches should be fine.

Rafael, can you pick one of them up?

       Arnd
