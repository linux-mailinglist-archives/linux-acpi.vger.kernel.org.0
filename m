Return-Path: <linux-acpi+bounces-15620-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4460CB22EA6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 19:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52EB31A26AE1
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 17:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E42F83D8;
	Tue, 12 Aug 2025 17:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E95QSfBv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCFE23D7F6;
	Tue, 12 Aug 2025 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755018659; cv=none; b=XcGDcqEYka1EgdiLYKqw+hNY0wscogEJRcDTucMj1NsEXSB1IyiJmnTc9YJ9TTcGJdDpqAAapKr7u+A7avMQg4YN1Qf00u413zlfbm0+oWJ5a2YecOX1/UThbxBMm+OXGgHk/3vfEkZ2oxG0ZHVDHFf6OxO0wunY4wBGNoCJIJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755018659; c=relaxed/simple;
	bh=oeO3oswPSIxuGMauo6AcF42kFWIo1ZJwzMrkI3ytPDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8tCaPoT0Vq2tPQpInWO2aapzMRfQCvm7fSxYTILF1EhWiQWso/CY7vqSZanSQq9CrbkFGiFTzvtJmSc5+oEHuruNzpa3a4HJ0jTc2cqkgoZC9kPtYvK0unbBBY2VGiSYsRLS78esOvBLlg4U7a4bgIznvEgp18O5okCg7JKza8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E95QSfBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15094C4CEF0;
	Tue, 12 Aug 2025 17:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755018657;
	bh=oeO3oswPSIxuGMauo6AcF42kFWIo1ZJwzMrkI3ytPDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E95QSfBvzwPBeou03b7N2PaZxmUFSsnbQpRpgSJXg19TdnDdkzo39NoE+pJeuEhlP
	 TILOEdEscv62rBW2O13X0Opqk/BJ0gaAP/oc5qV8WOHpkslUSy81wixeM0pffj1TYi
	 rUKCkdvX9ErRcC1NPFWjVZZrct2CYPhKsul3Mep4=
Date: Tue, 12 Aug 2025 19:10:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Ilya K <me@0upti.me>, "Rafael J. Wysocki" <rafael@kernel.org>,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
Message-ID: <2025081227-humpback-garden-7a4b@gregkh>
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
 <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>

On Tue, Aug 12, 2025 at 06:54:39PM +0200, Armin Wolf wrote:
> Am 12.08.25 um 18:40 schrieb Greg KH:
> 
> > On Tue, Aug 12, 2025 at 06:51:10PM +0300, Ilya K wrote:
> > > On 2025-08-12 16:32, Rafael J. Wysocki wrote:
> > > > Applied as 6.17-rc material and sorry for the delay (I was offline).
> > > > 
> > > > Thanks!
> > > Thanks!
> > > 
> > > Tagging stable@ so we're hopefully in time for 6.16.1.
> > <formletter>
> > 
> > This is not the correct way to submit patches for inclusion in the
> > stable kernel tree.  Please read:
> >      https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> > for how to do this properly.
> > 
> > </formletter>
> 
> Agree.
> 
> AFAIK the Fixes: tag should be enough to ensure that this patch gets included
> in the affected stable kernels.

Not at all!

Please read the above link for the full details on how to do this (hint,
Fixes: will not do it.)

thanks,

greg k-h

