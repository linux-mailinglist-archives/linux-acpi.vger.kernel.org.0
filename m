Return-Path: <linux-acpi+bounces-15623-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD58DB23908
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 21:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE67C16C3D6
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 19:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2822427FD4A;
	Tue, 12 Aug 2025 19:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gvY6BLDZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E113B1FF7C5;
	Tue, 12 Aug 2025 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027223; cv=none; b=fwOSoVH5CgamWsYjnXVkofK5LAoa6QZdyMj2Ch82YY4eyvuzJUng6JVAVACnOa5ut59NnrzoWCXai0Sd6DAKA58WdG9LU/HNYgmDX99l7RBD7M7KfHOGRN5yabDSlqATw4iZiQkeWth7osaazltj8zeXCF4B73DxuR0xi6Nirxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027223; c=relaxed/simple;
	bh=jeMDSVuNsyQScORGiJeAoQZs2Hw7qdnpQqe/G2hblTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lwo1OuCLNuDdRN/fymCW2VFsuYbbxQ8Tr81nEMYSYOXVb6X7BoxcSq+AQAWsma3wTopFn7hmLt/dqurjbdKpBp+qNhmRXrbMPoh+dIhFQbChsjp0sv7Muumq/R5hIXXsTDAkOBk2QFzASJOQ6lM7OUsMe/K2qyezE+E4sVRP/zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gvY6BLDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E3F8C4CEF0;
	Tue, 12 Aug 2025 19:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755027222;
	bh=jeMDSVuNsyQScORGiJeAoQZs2Hw7qdnpQqe/G2hblTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gvY6BLDZ8tUzrhQJjB8BzMta0F2qYLXS+xrE9BmvDAlSpVsHjfHy0wH4kz8+xuGin
	 E2rivwU0HIrr4wiheJzi6+Fxdv6wYIWynk+F6fFZPEpX7WzMft3Ocn6AiN3goirs1O
	 uwjiSJHpbZ1z74QkKLnmHGe4o4TILZ1dDbADbJFc=
Date: Tue, 12 Aug 2025 21:31:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilya K <me@0upti.me>
Cc: Armin Wolf <W_Armin@gmx.de>, "Rafael J. Wysocki" <rafael@kernel.org>,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
Message-ID: <2025081250-subsoil-tropics-91a7@gregkh>
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
 <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>
 <2025081227-humpback-garden-7a4b@gregkh>
 <d51317d4-92da-4617-970d-6a63236aec30@0upti.me>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d51317d4-92da-4617-970d-6a63236aec30@0upti.me>

On Tue, Aug 12, 2025 at 08:56:55PM +0300, Ilya K wrote:
> On 2025-08-12 20:10, Greg KH wrote:
> > 
> > Please read the above link for the full details on how to do this (hint,
> > Fixes: will not do it.)
> > 
> 
> I might be missing something, but doesn't that just tell you to CC stable@?

It must be in the patch itself, in the signed-off-by area.

