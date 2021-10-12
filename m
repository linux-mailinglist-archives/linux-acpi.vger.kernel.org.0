Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6946842A9DC
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhJLQrs (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:47:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:55142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbhJLQrk (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:47:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D801A601FA;
        Tue, 12 Oct 2021 16:45:36 +0000 (UTC)
Date:   Tue, 12 Oct 2021 17:45:33 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
Message-ID: <YWW7rTJKUJKTbvFE@arm.com>
References: <20210927141921.1760209-1-arnd@kernel.org>
 <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
 <CAK8P3a0Ny=Q=3Ass2xemWSG4wUkmojh5QxXryebiemroo6oruw@mail.gmail.com>
 <CAJZ5v0hGrZuNvM1gYOZscSnrgMMHZc9mXUtvUUKOnZch+0hWnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hGrZuNvM1gYOZscSnrgMMHZc9mXUtvUUKOnZch+0hWnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2021 at 04:16:09PM +0200, Rafael J. Wysocki wrote:
> On Tue, Oct 12, 2021 at 9:20 AM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > On Tue, Oct 12, 2021 at 9:03 AM Hanjun Guo <guohanjun@huawei.com> wrote:
> > > On 2021/9/27 22:19, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > In a gcc-11 randconfig build I came across this warning:
> > > >
> > > > WARNING: modpost: vmlinux.o(.text.unlikely+0x2c084): Section mismatch in reference from the function next_platform_timer() to the variable .init.data:acpi_gtdt_desc
> > > > The function next_platform_timer() references
> > > > the variable __initdata acpi_gtdt_desc.
> > > > This is often because next_platform_timer lacks a __initdata
> > > > annotation or the annotation of acpi_gtdt_desc is wrong.
> > > >
> > > > This happens when next_platform_timer() fails to get inlined
> > > > despite the inline annotation. Adding '__init' solves the issue,
> > > > and it seems best to remove the 'inline' in the process seems
> > > > better anyway.
> > >
> > > There was a patch to fix this issue as well [1],
> > > but not merged yet.
> > >
> > > [1]:
> > > https://lore.kernel.org/linux-acpi/7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com/T/
> >
> > Right, either of those patches should be fine.
> >
> > Rafael, can you pick one of them up?
> 
> I can, but arm54 ACPI changes go in via arm64 as a rule.

Queued as https://git.kernel.org/arm64/c/596143e3aec3

-- 
Catalin
