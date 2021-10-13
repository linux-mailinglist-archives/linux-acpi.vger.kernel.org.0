Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E5742BB0D
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Oct 2021 11:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbhJMJFF (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 13 Oct 2021 05:05:05 -0400
Received: from foss.arm.com ([217.140.110.172]:57444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234117AbhJMJFE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 13 Oct 2021 05:05:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34C2BED1;
        Wed, 13 Oct 2021 02:03:01 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC43E3F70D;
        Wed, 13 Oct 2021 02:02:59 -0700 (PDT)
Date:   Wed, 13 Oct 2021 10:02:54 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Hanjun Guo <guohanjun@huawei.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] acpi: arm64: fix section mismatch warning
Message-ID: <20211013090254.GA9901@lpieralisi>
References: <20210927141921.1760209-1-arnd@kernel.org>
 <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <988fa24c-76d2-1c9d-9761-b356efb0576c@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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

My bad, we did not coordinate well - I noticed your Acked-by but as a
rule we should also CC LAKML and Catalin/Will (if they aren't CCed) on
the reply to make sure they can actually see it.

Lorenzo
