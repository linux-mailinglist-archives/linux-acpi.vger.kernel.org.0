Return-Path: <linux-acpi+bounces-7460-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF8494D087
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 14:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B2828403E
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 12:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D07E1922C7;
	Fri,  9 Aug 2024 12:52:54 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFEB15AD86;
	Fri,  9 Aug 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207974; cv=none; b=g8nKinA9LAB6ym62RIUHJr4pNAMyxeA9gbVBfoH8Vg5Iu0M3ZByQQ8+Jn3LDgfY8lMOpR417tCEA+EpYnxCMCTMAkd+PiC7uoJOrjKP5G3Hjn8d35hzoqmojpckuq3lv6O7NXPLbvQ/Bi1AgLmpPf2i6A02TanNLxU83pGOOUVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207974; c=relaxed/simple;
	bh=EszoISNJ5N0cgLiH7tEMoi2MmUGAUKGBVWEu8kbyNlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4tGJ2XWvaPAk6oWRibpGQvylaiRfyEekT6Dgj14gHzuxiWIqtfdfFV/upmBmbW39t9oMVzH0uJsmZVtmtFfjWIXNDCUXK5EwD+gMQEt56fbC6u9pJgKrLUooN5rzJy0LqCuLM07CXgG4OZIbC7JrRpwqs+qjIJkWDK9Fn/6IYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9A3C32782;
	Fri,  9 Aug 2024 12:52:50 +0000 (UTC)
Date: Fri, 9 Aug 2024 13:52:48 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Will Deacon <will@kernel.org>
Cc: Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI/IORT: Switch to use kmemdup_array()
Message-ID: <ZrYRIPYv8euBkStd@arm.com>
References: <20240606165005.3031490-1-andriy.shevchenko@linux.intel.com>
 <3a1e0ffe-db11-d18f-db33-881df7d9b18d@huawei.com>
 <2edd3b72-24a4-8b19-8738-cc82dc4fae6c@huawei.com>
 <ZrYIosRuNG9S-SqM@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrYIosRuNG9S-SqM@smile.fi.intel.com>

On Fri, Aug 09, 2024 at 03:16:34PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 14, 2024 at 08:54:39AM +0800, Hanjun Guo wrote:
> > +Cc Catalin
> > 
> > On 2024/6/11 18:42, Hanjun Guo wrote:
> > > On 2024/6/7 0:50, Andy Shevchenko wrote:
> > > > Let the kememdup_array() take care about multiplication and possible
> > > > overflows.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >   drivers/acpi/arm64/iort.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > > > index c0b1c2c19444..e596dff20f1e 100644
> > > > --- a/drivers/acpi/arm64/iort.c
> > > > +++ b/drivers/acpi/arm64/iort.c
> > > > @@ -822,7 +822,7 @@ static struct iommu_iort_rmr_data *iort_rmr_alloc(
> > > >           return NULL;
> > > >       /* Create a copy of SIDs array to associate with this rmr_data */
> > > > -    sids_copy = kmemdup(sids, num_sids * sizeof(*sids), GFP_KERNEL);
> > > > +    sids_copy = kmemdup_array(sids, num_sids, sizeof(*sids),
> > > > GFP_KERNEL);
> > > >       if (!sids_copy) {
> > > >           kfree(rmr_data);
> > > >           return NULL;
> > > 
> > > Looks good to me,
> > > 
> > > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> > 
> > Catalin, would you mind pick this up as well?
> 
> Any news?
> 
> I do not see this even in Linux Next...

Ah, sorry, I missed this. Since it doesn't look like a fix, I guess it's
fine to go in 6.12. Adding Will since he's handling the upcoming merging
window.

-- 
Catalin

