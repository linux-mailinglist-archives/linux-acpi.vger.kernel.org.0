Return-Path: <linux-acpi+bounces-15618-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68593B22E0C
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 18:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD0751881621
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 16:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF512FA0F1;
	Tue, 12 Aug 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gA4Kwv1J"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F2D2FA0C3;
	Tue, 12 Aug 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755016858; cv=none; b=BkxcXODpmuRdfyfzn27YJkcYvC5p+KesFFPiDQMWwOIsXwbswibjx80tfdb7aqG4+YiV0I/ahYzSjDCcPhAnmzjXAGoxt/8x7031RVpvS2bQgAfYhk6JT4jdsvc+eSymkS9emeoD2heWEIF27/f0qKyhfydbkDn/ix43igDYACU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755016858; c=relaxed/simple;
	bh=5PySVuPXNrKkXoK8Bf3VnkR26p+3LBRsdWzp7VQVvQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dvJyk5TYd6kfyDFixTqurz03WDzhfO1gX8KgcijbpmII8veCugjKSSxia7wL/DEH5r8R+JroRmJgG87/4Kr/rtThyeowFqPND/Dsapd/ephrw/nMGa7ePmm605LWgADe/JdbujmJ3kY7d/QLPfcf6gFJdkjfT+TSvBZRKtx9d8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gA4Kwv1J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A7EC4CEF0;
	Tue, 12 Aug 2025 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755016858;
	bh=5PySVuPXNrKkXoK8Bf3VnkR26p+3LBRsdWzp7VQVvQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gA4Kwv1JrWcZ4sGMyol4SApnxD+rQCg5iCUiPOaFl6rqYyhT/O938Z2qkDlm145v1
	 xqJl3gK52vOTy/RDeZcEvYtrqUGzujyx1u5t/QnWkKQr8M3nj4qCQE6mwPsmqWgWgr
	 VUr1M0kc1jGdBFiLHY9otIk9/geKk980QTtEl4n8=
Date: Tue, 12 Aug 2025 18:40:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilya K <me@0upti.me>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
	lenb@kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
Message-ID: <2025081246-raft-tattle-642c@gregkh>
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>

On Tue, Aug 12, 2025 at 06:51:10PM +0300, Ilya K wrote:
> On 2025-08-12 16:32, Rafael J. Wysocki wrote:
> > 
> > Applied as 6.17-rc material and sorry for the delay (I was offline).
> > 
> > Thanks!
> 
> Thanks!
> 
> Tagging stable@ so we're hopefully in time for 6.16.1.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

