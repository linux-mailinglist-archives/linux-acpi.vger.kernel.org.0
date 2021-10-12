Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D442A6FB
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 16:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236846AbhJLOSW (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 10:18:22 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:35348 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbhJLOSW (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 12 Oct 2021 10:18:22 -0400
Received: by mail-ot1-f42.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so8188957ott.2;
        Tue, 12 Oct 2021 07:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i1B87BplSibMGB0bbHJxKqA5PDx9ieQTn2OIC9YZDmo=;
        b=E7G+d221KsQ1HLBpUYgS86TO9xGhsdQtf7WzHxQzuv6jT1qCq/yQdz8T+Xxo3XrnUm
         w2xYprVzwOnyHgjxDJIju+N0btlSzeepL0rwJ88KsotegbZz1jXYPZEUVaQK6cU2LKLP
         Zq39OfFsLT3sWzvBCe4kXERghOb+p8bIvrDuD5pHOYlR6Uh42TWlevD6517gFMWhOs7M
         4re6++Z5j1kHYmG8wuRhep22U4sTqFneZHqhSto6WrxatftjyKapyKf87PqgCFG9rUFn
         fL9rPSN76wFKKKrHHHJqnF/5I/zN4uw8Qkf72LzV5o4Qwi9Idp21QzLkqqOJr6IyQiy2
         1x6w==
X-Gm-Message-State: AOAM531l9tyO8PecdU62Qr4VQOz/8Ux7f6NJMyrktaJUcqnRBohCUEYF
        qjvIv44p2u9/Od2Hyv+I+dzuB+rcrdLpUAvhH9s=
X-Google-Smtp-Source: ABdhPJwYk27OuMG2A1M81OsyjBDCEWak1LaaQM+RixCGzExLo50FHibEO1UtRB9b+XgyhByL1HV/EsHTwK/R7H+4MA8=
X-Received: by 2002:a9d:2f24:: with SMTP id h33mr26652764otb.254.1634048180284;
 Tue, 12 Oct 2021 07:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210927141921.1760209-1-arnd@kernel.org> <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
 <CAK8P3a0Ny=Q=3Ass2xemWSG4wUkmojh5QxXryebiemroo6oruw@mail.gmail.com>
In-Reply-To: <CAK8P3a0Ny=Q=3Ass2xemWSG4wUkmojh5QxXryebiemroo6oruw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Oct 2021 16:16:09 +0200
Message-ID: <CAJZ5v0hGrZuNvM1gYOZscSnrgMMHZc9mXUtvUUKOnZch+0hWnw@mail.gmail.com>
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
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

On Tue, Oct 12, 2021 at 9:20 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Oct 12, 2021 at 9:03 AM Hanjun Guo <guohanjun@huawei.com> wrote:
> > On 2021/9/27 22:19, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > In a gcc-11 randconfig build I came across this warning:
> > >
> > > WARNING: modpost: vmlinux.o(.text.unlikely+0x2c084): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
> > > The function next_platform_timer() references
> > > the variable __initdata acpi_gtdt_desc.
> > > This is often because next_platform_timer lacks a __initdata
> > > annotation or the annotation of acpi_gtdt_desc is wrong.
> > >
> > > This happens when next_platform_timer() fails to get inlined
> > > despite the inline annotation. Adding '__init' solves the issue,
> > > and it seems best to remove the 'inline' in the process seems
> > > better anyway.
> >
> > There was a patch to fix this issue as well [1],
> > but not merged yet.
> >
> > [1]:
> > https://lore.kernel.org/linux-acpi/7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com/T/
>
> Right, either of those patches should be fine.
>
> Rafael, can you pick one of them up?

I can, but arm54 ACPI changes go in via arm64 as a rule.
