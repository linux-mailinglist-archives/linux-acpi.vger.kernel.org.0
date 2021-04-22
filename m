Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96677368264
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Apr 2021 16:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbhDVOY3 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 22 Apr 2021 10:24:29 -0400
Received: from foss.arm.com ([217.140.110.172]:52124 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236398AbhDVOY2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 22 Apr 2021 10:24:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9694413A1;
        Thu, 22 Apr 2021 07:23:53 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B1943F73B;
        Thu, 22 Apr 2021 07:23:52 -0700 (PDT)
Date:   Thu, 22 Apr 2021 15:23:42 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        dann frazier <dann.frazier@canonical.com>,
        Fu Wei <wefu@redhat.com>, Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 0/2] arm64: ACPI GTDT watchdog fixes
Message-ID: <20210422142334.GA24087@lpieralisi>
References: <20210421164317.1718831-1-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421164317.1718831-1-maz@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, Apr 21, 2021 at 05:43:15PM +0100, Marc Zyngier wrote:
> Dann recently reported that his ThunderX machine failed to boot since
> 64b499d8df40 ("irqchip/gic-v3: Configure SGIs as standard
> interrupts"), with a not so pretty crash while trying to send an IPI.
> 
> It turned out to be caused by a mix of broken firmware and a buggy
> GTDT watchdog driver. Both have forever been buggy, but the above
> commit revealed that the error handling path of the driver was
> probably the worse part of it all.
> 
> Anyway, this short series has two goals:
> - handle broken firmware in a less broken way
> - make sure that the route cause of the problem can be identified
>   quickly
> 
> Thanks,
> 
> 	M.
> 
> Marc Zyngier (2):
>   ACPI: GTDT: Don't corrupt interrupt mappings on watchdow probe failure
>   ACPI: irq: Prevent unregistering of GIC SGIs
> 
>  drivers/acpi/arm64/gtdt.c | 10 ++++++----
>  drivers/acpi/irq.c        |  6 +++++-
>  2 files changed, 11 insertions(+), 5 deletions(-)

Patch(2) needs an ACK from Rafael - usually these patches go via
the ARM64 tree but I don't think it is compulsory for this series.

Thank you !

Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
