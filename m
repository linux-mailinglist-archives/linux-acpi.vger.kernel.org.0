Return-Path: <linux-acpi+bounces-11830-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8697A4FC71
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 11:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058BB16FF74
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 10:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8820ADD6;
	Wed,  5 Mar 2025 10:42:22 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C35320A5EE;
	Wed,  5 Mar 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741171342; cv=none; b=Ao6RPhjxbroPhdFM5WzqEWT79bFJpBRDZwpH2KV8ryYhEZtLy7tMag662W5D2SBM+AHvcgoB3MJKXtqG2KCYv4kSgWzhe6+A0VtbnHziplmxRDRiFlKpkDhJzKAszcEFk6dD6X+xVNPGQXoMxhDFoyukkvqwXwbObg9XeB1R5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741171342; c=relaxed/simple;
	bh=85MBWr98xcaQYJQdEGDq8tJQlKr8b+CeRh2/oRwLikk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESW7H/XpRKfA36lt1rea3WF6SWphRb8pqMy89H/MXeNm6rGYE3jZKkW7dBxxIxuj2+0neq29VAv6rmC14c3BavPTQE76IcGuakqRb96pmvss/56V3JW2W6RDYdqZ8Seh8/ArQ9TYzKiprO6NGo4C7PVMjsdoENa9EoOevgBKiG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 138CDFEC;
	Wed,  5 Mar 2025 02:42:33 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E4C3F3F673;
	Wed,  5 Mar 2025 02:42:18 -0800 (PST)
Date: Wed, 5 Mar 2025 10:42:15 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>
Subject: Re: [PATCH 06/14] mailbox: pcc: Refactor error handling in irq
 handler into separate function
Message-ID: <20250305104215.zjvpoiniqxhld5u4@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-6-3b44f3d134b1@arm.com>
 <91106bf6-9777-bde6-55f5-8fb7e7afd8ba@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91106bf6-9777-bde6-55f5-8fb7e7afd8ba@huawei.com>

On Wed, Mar 05, 2025 at 02:09:03PM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > The existing error handling logic in pcc_mbox_irq() is intermixed with the
> > main flow of the function. The command complete check and the complete
> > complete update/acknowledgment are nicely factored into separate functions.
> > 
> > Moves error detection and clearing logic into a separate function called:
> > pcc_mbox_error_check_and_clear() by extracting error-handling logic from
> > pcc_mbox_irq().
> > 
> > This ensures error checking and clearing are handled separately and it
> > improves maintainability by keeping the IRQ handler focused on processing
> > events.
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/mailbox/pcc.c | 30 ++++++++++++++++++++----------
> >   1 file changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index a0fdafc3ef71d20c73ff58ef065201e6dc911396..e693675ce1fbd8d01d0640b3053a5c1882bdbce7 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -269,6 +269,25 @@ static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
> >   	return !!val;
> >   }
> > +static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
> > +{
> > +	u64 val;
> > +	int ret;
> > +
> > +	ret = pcc_chan_reg_read(&pchan->error, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	val &= pchan->error.status_mask;
> > +	if (val) {
> > +		val &= ~pchan->error.status_mask;
> > +		pcc_chan_reg_write(&pchan->error, val);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >   static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> >   {
> >   	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> > @@ -309,8 +328,6 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >   {
> >   	struct pcc_chan_info *pchan;
> >   	struct mbox_chan *chan = p;
> > -	u64 val;
> > -	int ret;
> >   	pchan = chan->con_priv;
> > @@ -324,15 +341,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
> >   	if (!pcc_mbox_cmd_complete_check(pchan))
> >   		return IRQ_NONE;
> > -	ret = pcc_chan_reg_read(&pchan->error, &val);
> > -	if (ret)
> > +	if (!pcc_mbox_error_check_and_clear(pchan))
> >   		return IRQ_NONE;
> 
> Here should be like below code, right? 0 on success.
> 
> if (pcc_mbox_error_check_and_clear(pchan))
>  		return IRQ_NONE;

Spot on, nice catch. Copied it from pcc_mbox_cmd_complete_check(), will fix
it.

-- 
Regards,
Sudeep

