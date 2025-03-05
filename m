Return-Path: <linux-acpi+bounces-11837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7FCA501F7
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 15:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEA43A3E8B
	for <lists+linux-acpi@lfdr.de>; Wed,  5 Mar 2025 14:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D5324C062;
	Wed,  5 Mar 2025 14:29:53 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA4C2356C2;
	Wed,  5 Mar 2025 14:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741184993; cv=none; b=JGX+3tOPRbADanyO7pu/wqKYT0pUke8VSkPY9MhvsQSVkJHnTlN26sX0eLZM61/t8NBm1n+Vc210hcsTIVJ9Unto0+biSB/yOGEvZHkoJGhu7iNfZoW4SJ3/QSZPYWxAzK/0nbo/KcAFz3MXVdPAzp6k0pFevyTT11KYxZzwKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741184993; c=relaxed/simple;
	bh=Es+ipad2jb2E8NWIEfYNqeNCPuatl4xqFgmbg98e+QA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S4nz09O8VA+jYe/t9dkRmsqayLx30lcEhGxhFZ+EOtaYVEOn3thZzddXocSoWz9Ol/BsaTrUj37/yX5Kvkf55cWn82Q8k1LODj/VACmeObG1WMVcAcLAh12eucYUP2Trji+S7LVh78zQ+YjnjfWY0DIrRbQSjvL2YBGqNS4LLe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5A78FEC;
	Wed,  5 Mar 2025 06:30:03 -0800 (PST)
Received: from bogus (unknown [10.57.37.20])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 293B93F673;
	Wed,  5 Mar 2025 06:29:49 -0800 (PST)
Date: Wed, 5 Mar 2025 14:29:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
Subject: Re: [PATCH 02/14] mailbox: pcc: Always clear the platform ack
 interrupt first
Message-ID: <20250305142945.kzs4hfljbktkndbe@bogus>
References: <20250303-pcc_fixes_updates-v1-0-3b44f3d134b1@arm.com>
 <20250303-pcc_fixes_updates-v1-2-3b44f3d134b1@arm.com>
 <397910e0-38eb-553a-2bd2-c338d8c3a49c@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <397910e0-38eb-553a-2bd2-c338d8c3a49c@huawei.com>

On Wed, Mar 05, 2025 at 11:45:35AM +0800, lihuisong (C) wrote:
> 
> 在 2025/3/3 18:51, Sudeep Holla 写道:
> > The PCC mailbox interrupt handler (pcc_mbox_irq()) currently checks
> > for command completion flags and any error status before clearing the
> > interrupt.
> > 
> > The below sequence highlights an issue in the handling of PCC mailbox
> > interrupts, specifically when dealing with doorbell notifications and
> > acknowledgment between the OSPM and the platform where type3 and type4
> > channels are sharing the interrupt.
> > 
> >          Platform Firmware              OSPM/Linux PCC driver
> > ------------------------------------------------------------------------
> >                                       build message in shmem
> >                                       ring type3 channel doorbell
> > receives the doorbell interrupt
> >    process the message from OSPM
> >    build response for the message
> > ring the platform ack interrupt to OSPM
> > 				--->
> > build notification in type4 channel
> >                                       start processing in pcc_mbox_irq()
> >                                        enter pcc handler for type4 chan
> >                                           command complete cleared
> > 			        	 read the notification
> >                                  <---     clear platform ack irq
> >    		* no effect from above as platform ack irq *
> > 		* not yet triggered on this channel *
> > ring the platform ack irq on type4 channel
> > 				--->
> >                                        leave pcc handler for type4 chan
> >                                        enter pcc handler for type3 chan
> >                                           command complete set
> > 					 read the response
> >                                  <---     clear platform ack irq
> >                                        leave pcc handler for type3 chan
> >                                       leave pcc_mbox_irq() handler
> >                                       start processing in pcc_mbox_irq()
> >                                        enter pcc handler for type4 chan
> >                                        leave pcc handler for type4 chan
> >                                        enter pcc handler for type3 chan
> >                                        leave pcc handler for type3 chan
> >                                       leave pcc_mbox_irq() handler
> This is not easy to understand to me.
> The issue as below described is already very clear to me.
> So suggest remove above flow graph.

I understood it with the graph similar to the one above, though I simplified
it in terms of PCC rather than specific IP reference.

> > The key issue occurs when OSPM tries to acknowledge platform ack
> > interrupt for a notification which is ready to be read and processed
> > but the interrupt itself is not yet triggered by the platform.
> >
> > This ineffective acknowledgment leads to an issue later in time where
> > the interrupt remains pending as we exit the interrupt handler without
> > clearing the platform ack interrupt as there is no pending response or
> > notification. The interrupt acknowledgment order is incorrect.
> >

> Has this issue been confired? It's more better if has the log.😁
> But it seems a valid issue.

Yes Robbie reported this. He is away and can't test or respond until next
week. The log just says there was loads of spurious interrupts and nobody
cared log as you got in the first patch of yours fixing similar race.

> >
> > To resolve this issue, the platform acknowledgment interrupt should
> > always be cleared before processing the interrupt for any notifications
> > or response.
> >
> AFAIC，always clearing the platform ack interrupt first which is also the
> communication flow as ACPI spec described.

Indeed, not sure how we missed it so far.

> I am not sure if it is ok when triggering interrupt and clearing interrupt
> occur concurrently.

Should be OK as we start clearing all the channels that share, if the
handler doesn't clear any source, the interrupt must remain asserted.

> But this scenario is always possible. I think It doesn't matter with this
> patch. It's just my confusion.

Indeed, it can happen any time as you mentioned. No worries better to ask
and clarify than assume. Thanks for your time and review.

--
Regards,
Sudeep

