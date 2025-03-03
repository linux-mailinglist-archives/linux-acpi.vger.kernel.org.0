Return-Path: <linux-acpi+bounces-11730-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AAEA4C42F
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D73E9171683
	for <lists+linux-acpi@lfdr.de>; Mon,  3 Mar 2025 15:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F781213E6F;
	Mon,  3 Mar 2025 15:05:46 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC169156F5E;
	Mon,  3 Mar 2025 15:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741014346; cv=none; b=QM7QRwRmUop+KymQfKEg9OdvsTzYdSyvTE220DYJUhM8MwEfnZ26lZHMGQvs5AjMCg4wso+VMHkuVb5CmuxfD1zI04GpBK2S6dk4/wSkDLWEQQMwDlRybePpSmrRSnZtvlYHzclKeNXEql5L75+4Rip1mZVidQ+PNne/4Vx+YzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741014346; c=relaxed/simple;
	bh=L5pWAKrCXOYUoIhvx6Wbj4qhfpX1Y/d5A9WddHMWFno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jIExw0bsRTwcUinSaG+g+LXfgc6h1/7weVrBeJFvI2N7fCWIizb1Cy/LFguZ9HAJVinheoRM4/GALxFreM+oR5Mbwy10dCwA5FcKv05BFJI14U8l/6SBHNKz/sG6W3RG6w8S+IDiDBUOGz3hsCR1fB4NNxVUYxZ5Yn6CeQUaq5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B8D106F;
	Mon,  3 Mar 2025 07:05:58 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 831693F5A1;
	Mon,  3 Mar 2025 07:05:42 -0800 (PST)
Date: Mon, 3 Mar 2025 15:05:39 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Huisong Li <lihuisong@huawei.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 12/14] hwmon: (xgene-hwmon) Simplify PCC shared memory
 region handling
Message-ID: <Z8XFQySIuyZvcsYH@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-12-3b44f3d134b1@arm.com>
 <afb9a22f-7d21-42a2-a8dc-87537caad027@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb9a22f-7d21-42a2-a8dc-87537caad027@roeck-us.net>

On Mon, Mar 03, 2025 at 05:55:57AM -0800, Guenter Roeck wrote:
> On 3/3/25 02:51, Sudeep Holla wrote:
> > The PCC driver now handles mapping and unmapping of shared memory
> > areas as part of pcc_mbox_{request,free}_channel(). Without these before,
> > this xgene hwmon driver did handling of those mappings like several
> > other PCC mailbox client drivers.
> > 
> > There were redundant operations, leading to unnecessary code. Maintaining
> > the consistency across these driver was harder due to scattered handling
> > of shmem.
> > 
> > Just use the mapped shmem and remove all redundant operations from this
> > driver.
> > 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
> Note that I'll apply a fix this week which will cause a context conflict.
> See below.
>

Sure, I was planning to repost these individually after the mailbox changes
are merged. I am not sure if I can get some testing on this xgene platform
as I am changing the mapping attributes which currently is different for
different versions of firmware and both are incorrect in terms of ACPI spec.

In short, no rush. The idea of posting these is to show how duplicate code
can be removed. I will post it independently sometime in the future.

>
> This needed to be IS_ERR_OR_NULL() since devm_memremap() returns an ERR_PTR.
>

True. IIRC, there are few valid iomem related sparse warnings which I plan
to fix and post it together once the PCC changes are merged.

Thanks for the review.

-- 
Regards,
Sudeep

