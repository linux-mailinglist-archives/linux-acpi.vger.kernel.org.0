Return-Path: <linux-acpi+bounces-12085-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5ABA5C085
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 13:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322D93B63A7
	for <lists+linux-acpi@lfdr.de>; Tue, 11 Mar 2025 12:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D68C256C73;
	Tue, 11 Mar 2025 12:08:24 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A13256C6D;
	Tue, 11 Mar 2025 12:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694904; cv=none; b=i6B/cXyuJOPB6ZCEz6xoEQCnAry2fkTxmuKIvKyCmouM3MdHFEZQNGAMHUmPpW2gNjMKZuJu7wnIODzdIPguT62VNWj5JuyMdYmDYN1aiyveg18bKpQmguNC8odYpV3obiMhA3Ml9JyQDRTJlo0KGcsphH6fSY91DsCA1byyjvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694904; c=relaxed/simple;
	bh=azxGg4L7apOOz1PTr017NZZrbSpCOqvvTzNDvGn4wO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmYjNQlVo9Bvahfqii55GIf0TbJKByzPczCvPQ0LTmVru4QPllu3L6NVaxUxqArz1rwgNrh+LM2R6QRt6CLVyppUegpPGX77q0bdumAkI96AVm+t5/olP0rPe2zbhm62Z8Vg9j/zyU4nRnyv1aZ97ch5pxVGW4r9GTrAWE+I7/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0A8152B;
	Tue, 11 Mar 2025 05:08:32 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A01F3F673;
	Tue, 11 Mar 2025 05:08:20 -0700 (PDT)
Date: Tue, 11 Mar 2025 12:08:17 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Adam Young <admiyo@os.amperecomputing.com>,
	Robbie King <robbiek@xsightlabs.com>
Subject: Re: [PATCH v2 08/13] mailbox: pcc: Refactor and simplify
 check_and_ack()
Message-ID: <Z9AnsaoxypL6qult@bogus>
References: <20250305-pcc_fixes_updates-v2-0-1b1822bc8746@arm.com>
 <20250305-pcc_fixes_updates-v2-8-1b1822bc8746@arm.com>
 <34bdfee2-4780-f45b-7891-e845b13fdd2f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34bdfee2-4780-f45b-7891-e845b13fdd2f@huawei.com>

On Tue, Mar 11, 2025 at 07:47:39PM +0800, lihuisong (C) wrote:
>
> 在 2025/3/6 0:38, Sudeep Holla 写道:
> > The existing check_and_ack() function had unnecessary complexity. The
> > logic could be streamlined to improve code readability and maintainability.
> >
> > The command update register needs to be updated in order to acknowledge
> > the platform notification through type 4 channel. So it can be done
> > unconditionally. Currently it is complicated just to make use of
> > pcc_send_data() which also executes the same updation.
> >
> > In order to simplify, let us just ring the doorbell directly from
> > check_and_ack() instead of calling into pcc_send_data(). While at it,
> > rename it into pcc_chan_check_and_ack() to maintain consistency in the
> > driver.
> LGTM except for some trivial,
> Acked-by: Huisong Li <lihuisong@huawei.com>
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/mailbox/pcc.c | 37 +++++++++++++------------------------
> >   1 file changed, 13 insertions(+), 24 deletions(-)
> >
> > diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> > index b3d133170aac7f8acfd1999564c69b7fe4f6d582..90d6f5e24df7e796f8c29705808eb6df2806c1f2 100644
> > --- a/drivers/mailbox/pcc.c
> > +++ b/drivers/mailbox/pcc.c
> > @@ -117,8 +117,6 @@ struct pcc_chan_info {
> >   static struct pcc_chan_info *chan_info;
> >   static int pcc_chan_count;
> > -static int pcc_send_data(struct mbox_chan *chan, void *data);
> > -
> >   /*
> >    * PCC can be used with perf critical drivers such as CPPC
> >    * So it makes sense to locally cache the virtual address and
> > @@ -288,33 +286,24 @@ static int pcc_mbox_error_check_and_clear(struct pcc_chan_info *pchan)
> >   	return 0;
> >   }
> > -static void check_and_ack(struct pcc_chan_info *pchan, struct mbox_chan *chan)
> > +static void pcc_chan_check_and_ack(struct pcc_chan_info *pchan)
> How about use pcc_chan_ack?
> >   {
> > -	struct acpi_pcct_ext_pcc_shared_memory pcc_hdr;
> > +	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_hdr;
> >   	if (pchan->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
> >   		return;
> > -	/* If the memory region has not been mapped, we cannot
> > -	 * determine if we need to send the message, but we still
> > -	 * need to set the cmd_update flag before returning.
> > -	 */
> > -	if (pchan->chan.shmem == NULL) {
> > -		pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> > -		return;
> > -	}
> > -	memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
> > -		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
> > +
> > +	pcc_chan_reg_read_modify_write(&pchan->cmd_update);
> > +
> > +	pcc_hdr = pchan->chan.shmem;
>
> Should use the original code?
>
> memcpy_fromio(&pcc_hdr, pchan->chan.shmem,
> 		      sizeof(struct acpi_pcct_ext_pcc_shared_memory));
>

ioread32(&pcc_hdr->flags) just reads 4 byte flag instead of copying entire
header for no reason. It should be same as memcpy_fromio(.., .., 4)

--
Regards,
Sudeep

