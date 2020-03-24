Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 792011916AE
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Mar 2020 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727574AbgCXQl6 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Tue, 24 Mar 2020 12:41:58 -0400
Received: from foss.arm.com ([217.140.110.172]:38096 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgCXQl6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 24 Mar 2020 12:41:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F6A71FB;
        Tue, 24 Mar 2020 09:41:57 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B87AD3F52E;
        Tue, 24 Mar 2020 09:41:55 -0700 (PDT)
Date:   Tue, 24 Mar 2020 16:41:53 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-mm@kvack.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tyler Baicar <tyler@amperecomputing.com>,
        Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH 3/3] arm64: acpi: Make apei_claim_sea() synchronise with
 APEI's irq work
Message-ID: <20200324164152.GB3901@mbp>
References: <20200228174817.74278-1-james.morse@arm.com>
 <20200228174817.74278-4-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228174817.74278-4-james.morse@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Feb 28, 2020 at 05:48:17PM +0000, James Morse wrote:
> APEI is unable to do all of its error handling work in nmi-context, so
> it defers non-fatal work onto the irq_work queue. arch_irq_work_raise()
> sends an IPI to the calling cpu, but this is not guaranteed to be taken
> before returning to user-space.
> 
> Unless the exception interrupted a context with irqs-masked,
> irq_work_run() can run immediately. Otherwise return -EINPROGRESS to
> indicate ghes_notify_sea() found some work to do, but it hasn't
> finished yet.
> 
> With this apei_claim_sea() returning '0' means this external-abort was
> also notification of a firmware-first RAS error, and that APEI has
> processed the CPER records.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since $last_year:
>  * Dropped all the tags ... its been a year.

I think this patch hasn't changed much since, so my ack still stands.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
