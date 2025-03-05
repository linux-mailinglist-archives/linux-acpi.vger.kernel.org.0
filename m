Return-Path: <linux-acpi+bounces-11828-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E95A4FC5E
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3956C3B0A8A
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE11A20ADCF;
	Wed,  5 Mar 2025 10:34:41 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBD207A23;
	Wed,  5 Mar 2025 10:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170881; cv=none; b=YFDcggEcKTJiUmxe2smNDBh73/m0CVJGJpLVh6oSjY0/bMF+3VNWySf31g7uoE9EbR5jaBVoxmU35yp9gAkvL7TL/Kk4at8azZFy4SgU9+W8kBYTUqbmq+zeKpmqp7RrCtEUPjfpLby/LNNg+OuWL4DucuAhy3bvdi3hNKMzdkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170881; c=relaxed/simple;
	bh=Q5R8aeHwPAXVXsXv1i1SqxENOrR8VBTs6sXUnEeVorE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhPnwG6nVBv/gX4hF3tL/ridkxiYEgtvfCN3XxjOOpxWrxJFPumsSLyAvn3RemzCMejsHqSysTrxOomDznjHqeveYxAokVPlZw+m/obIkNgbfB7X8pMBlTNE1E4EVvA7JZ5shzJpsh+o7VtFt6jRomHqpVfZ7c2K24kaM7Ormz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC340FEC;
	Wed,  5 Mar 2025 02:34:52 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A3DE3F673;
	Wed,  5 Mar 2025 02:34:38 -0800 (PST)
Date: Wed, 5 Mar 2025 10:34:35 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 03/14] mailbox: pcc: Drop unnecessary endianness
 conversion of pcc_hdr.flags
Message-ID: <20250305103435.nl5q2uvyqftal7en@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-3-3b44f3d134b1@arm.com>
 <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5093286f-1db6-bab2-920d-71fe274ad251@huawei.com>

On Wed, Mar 05, 2025 at 12:02:13PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > The Sparse static checker flags a type mismatch warning related to
> > endianness conversion:
> > 
> >    |  warning: incorrect type in argument 1 (different base types)
> >    |     expected restricted __le32 const [usertype] *p
> >    |     got unsigned int *
> > 
> > This is because an explicit endianness conversion (le32_to_cpu()) was
> > applied unnecessarily to a pcc_hdr.flags field that is already in
> > little-endian format.
> > 
> > The PCC driver is only enabled on little-endian kernels due to its
> > dependency on ACPI and EFI, making the explicit conversion unnecessary.
> How to confirm ACPI works only on little-endian?
> > 
> > The redundant conversion occurs in pcc_chan_check_and_ack() for the
> > pcc_hdr.flags field. Drop this unnecessary endianness conversion of
> > pcc_hdr.flags.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/mailbox/pcc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index 4c582fa2b8bf4c9a9368dba8220f567555dba963..c87a5b7fa6eaf7bcabe0d55f844961c499376938 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -292,7 +292,7 @@ static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> >   	 *
> >   	 * The PCC master subspace channel clears chan_in_use to free channel.
> >   	 */
> > -	if (le32_to_cpup(&pcc_hdr.flags) & PCC_ACK_FLAG_MASK)
> > +	if (pcc_hdr.flags & PCC_ACK_FLAG_MASK)
> It's recommanded to delete PCC_ACK_FLAG_MASK and use
> PCC_CMD_COMPLETION_NOTIFY.
> They are from the same place, namely, 'Initiator Responder Communications
> Channel Flags'.

Good point, I will use PCC_CMD_COMPLETION_NOTIFY and drop even the definition
of PCC_ACK_FLAG_MASK as it got added for no good reason.

--
Regards,
Sudeep

