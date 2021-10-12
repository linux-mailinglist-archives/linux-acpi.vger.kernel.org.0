Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A273B42A96F
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Oct 2021 18:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhJLQcm (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 12 Oct 2021 12:32:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229495AbhJLQcl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 12 Oct 2021 12:32:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 447F761074;
        Tue, 12 Oct 2021 16:30:38 +0000 (UTC)
Date:   Tue, 12 Oct 2021 17:30:34 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
Message-ID: <YWW4KrbVfPeUikAL@arm.com>
References: <20210927141921.1760209-1-arnd@kernel.org>
 <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Oct 12, 2021 at 03:03:29PM +0800, Hanjun Guo wrote:
> Hi Arnd,
> 
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
> [1]: https://lore.kernel.org/linux-acpi/7f29a149-e005-f13f-2cc4-a9eb737107e1@huawei.com/T/

I haven't seen this one, it was on linux-acpi list which I don't follow.
I usually rely you, Lorenzo or Sudeep to ack such patches and cc
Will/me.

-- 
Catalin
