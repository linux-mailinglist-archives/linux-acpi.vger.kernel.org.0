Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD731DBBCE
	for <lists+linux-acpi@lfdr.de>; Wed, 20 May 2020 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgETRoC (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Wed, 20 May 2020 13:44:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgETRoB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 May 2020 13:44:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 427C82075F;
        Wed, 20 May 2020 17:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589996641;
        bh=P2aat+TlaI2N+/z7SW3hph4BEYfuA7FSbseNufQGe4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJ5Q3o7lmeUADmYQ2lB29DmpSJq9CwNkr/C8uOM21tMpkAFWObarU+Bu1OsPfq9FG
         4F6Ql4BWleoI4gCPqUB936+6/WYnqm5xYt5ZI5xAF0uY3EHOr74j831yY9jHzVpFEC
         at7VFnF549jrYb1WBdZlx226K8TrOTtmFi+2M4UA=
Date:   Wed, 20 May 2020 18:43:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tuan Phan <tuanphan@os.amperecomputing.com>,
        patches@amperecomputing.com, Hanjun Guo <guohanjun@huawei.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] ACPI/IORT: Fix PMCG node single ID mapping handling
Message-ID: <20200520174355.GC27629@willie-the-truck>
References: <1589994787-28637-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200520172736.GA10693@e121166-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520172736.GA10693@e121166-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, May 20, 2020 at 06:27:36PM +0100, Lorenzo Pieralisi wrote:
> On Wed, May 20, 2020 at 10:13:07AM -0700, Tuan Phan wrote:
> > An IORT PMCG node can have no ID mapping if its overflow interrupt is
> > wire based therefore the code that parses the PMCG node can not assume
> > the node will always have a single mapping present at index 0.
> > 
> > Fix iort_get_id_mapping_index() by checking for an overflow interrupt
> > and mapping count.
> > 
> > Fixes: 24e516049360 ("ACPI/IORT: Add support for PMCG")
> > 
> > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Reviewed-by: Hanjun Guo <guoahanjun@huawei.com>
> > Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> > ---
> > v1 -> v2:
> > - Use pmcg node to detect wired base overflow interrupt.
> > 
> > v2 -> v3:
> > - Address Hanjun and Robin's comments.
> > 
> > v3 -> v4:
> > - Update the title and description as mentioned by Lorenzo.
> > 
> > v4 -> v5:
> > - Remove period in the title and commit references.
> > 
> >  drivers/acpi/arm64/iort.c | 5 +++++
> 
> Hi Will,
> 
> is there a chance we can get this patch into v5.8 ? I understand
> we are very late in the cycle but I wanted to ask (it applies cleanly
> to for-next/acpi).

Sorry, Lorenzo -- I didn't notice that this had been Acked already. I was
waiting for somebody to chime in! I'll queue it ASAP for 5.8.

Will
