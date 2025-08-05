Return-Path: <linux-acpi+bounces-15528-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A249BB1AF4C
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 09:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3326175EB4
	for <lists+linux-acpi@lfdr.de>; Tue,  5 Aug 2025 07:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FF2238C39;
	Tue,  5 Aug 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fK0f2rtu"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EED43ABC;
	Tue,  5 Aug 2025 07:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754378774; cv=none; b=mdi3TiQO44plrS6rUAduRWQXJWEw6OuuaNnTbBAEJv4BkTy6X/kQtApX0AjchTSbABxFRbN7uzfgAR75Vii2mshhXK97FvhCHteGbEffkNFaWiFoGTR8BSAzWdFuUGFoX3m0/1ku13vDvzAD54dpWJNt268iEG6APsRt8H3pHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754378774; c=relaxed/simple;
	bh=PYwq5J6Qn188jtbbwXzze1QQOj7WLlrYWpzJYjArOe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZshfSV1XJkApR4niNcW/tOdjWakhTvznC1GnC/5O1C80I4QAkBP6F2Ne0pHmSYZbwNFE9z2PGZIx5aQYD1zzxNgdVfKCGSlLcnV+BD8wkzqAxYVGvOXICI+1YjisoRtBVfszUlZMNrLyu1FTqCEv3t9XecpiQkNOyuP4tV0CrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fK0f2rtu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 688E2C4CEF4;
	Tue,  5 Aug 2025 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754378773;
	bh=PYwq5J6Qn188jtbbwXzze1QQOj7WLlrYWpzJYjArOe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fK0f2rtu06y1CA7Vn/d7CPrELdSrhXnbdLVSimIpPcR1obohB1V/QQdWWD07JqPGf
	 vDpaTPSWDRtbuZVoTi0NbfBOCLnHJ0LqQrI4rjF4eMGyh9IDCXipqfTKVQaryE8OMQ
	 40dwhsfODRp+4bvVTJ8RJhxUyCwAVkrdTxomOd9Q=
Date: Tue, 5 Aug 2025 08:26:08 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Zhen Ni <zhen.ni@easystack.cn>, linux-acpi@vger.kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v4] mailbox: pcc: Add missed acpi_put_table() to fix
 memory leak
Message-ID: <2025080552-stubbly-elliptic-6fa0@gregkh>
References: <20250804121453.75525-1-zhen.ni@easystack.cn>
 <20250805034829.168187-1-zhen.ni@easystack.cn>
 <41fdbd2b-92c5-4f11-9c58-aff9b9f35e72@web.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41fdbd2b-92c5-4f11-9c58-aff9b9f35e72@web.de>

On Tue, Aug 05, 2025 at 08:28:17AM +0200, Markus Elfring wrote:
> > Fixes a permanent ACPI memory leak in the success path by adding
> > acpi_put_table().
> > Renaming generic 'err' label to 'put_table' for clarity.
> 
> Will a desire grow for the usage of imperative mood also in such change descriptions?
> 
> See also once more:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94
> 
> 
> …> Changes in v4:
> > - Change goto target from err to put_table.
> 
> Thanks.
> 
> 
> > - Remove goto tatget err_nomem
> …
> 
> Does this adjustment indicate questionable development difficulties?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

