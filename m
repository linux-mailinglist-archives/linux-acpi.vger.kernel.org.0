Return-Path: <linux-acpi+bounces-19368-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEAEC979ED
	for <lists+linux-acpi@lfdr.de>; Mon, 01 Dec 2025 14:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 351204E0F2D
	for <lists+linux-acpi@lfdr.de>; Mon,  1 Dec 2025 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905830E837;
	Mon,  1 Dec 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5atazrX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF82DAFC1;
	Mon,  1 Dec 2025 13:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764596051; cv=none; b=Wco7dT8grhI4rrdJTfTj/exfkTeLtqw7pmdQqR2dVhnOayYUdEJMOtDezYUdfJJ2rwjftn5njP47ZwaHh5LsJxTS0C3gBHn7CHCFY5nx1FVLiGVAkBS12mQkMFB3JSsXrMSpK+jPksqoRTgovDnRUE/M9gshE7hpaIV8eOz/0Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764596051; c=relaxed/simple;
	bh=M6M7eOv7j7NHxq3WPSZpnrzrMCtiltxJ2usZl0W04Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/O4n5SKw5FuT3QIc9PzwnUzu3QThmzHKG8bENLOoEL5I9hdrnmySgd7YDsS4g+Sot/PiwVJLr2CcqD57AQVHOB4SngZAhO14pzFCF/EB0xddmNn7j0KkGIyRBB969vydV87eTQBt00uPi8NC8DB0brtVYiyiWuBCbuNdnuhYdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5atazrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8576BC116D0;
	Mon,  1 Dec 2025 13:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764596050;
	bh=M6M7eOv7j7NHxq3WPSZpnrzrMCtiltxJ2usZl0W04Io=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f5atazrXnzwdIWaicOOKXD2Z54CrOh1WxVE893eX0ZMHoN+tdrLNp5hp5eMuErXU0
	 Uj6aLYyaIgcTRxMHPjXt5ALYmr0ikeATyI/EQgvBBicftvBQcz5t/tr5Y4UWUR55dE
	 OwoV0lovrohau4HuJcoapCCJXlKoDeZRABVGgeV9mTO3DxFsuHLzwhbEUvQJCF7tBA
	 H6Ejq1qKcOcwZd8Ekg6Me4t5wX19H7W+NEKmEEBgYYo/ke2tajpxfgHx99wqlKoFga
	 N1P4HFnB9PscXtjydKWKsbDfH9bfdfgMlCQDhg5JYUSDiMBckhZ4wk0TpkS8MU3bvL
	 GbPD1mrBjRjFg==
Date: Mon, 1 Dec 2025 13:34:05 +0000
From: Will Deacon <will@kernel.org>
To: Hanjun Guo <guohanjun@huawei.com>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] ACPI: GTDT: Correctly number platform devices for MMIO
 timers
Message-ID: <aS2ZTfS9YVO98Exe@willie-the-truck>
References: <20251030110115.1842961-1-maz@kernel.org>
 <c1edd6cc-0542-8d22-6edc-60c619c9e162@huawei.com>
 <861plrsr1l.wl-maz@kernel.org>
 <5a742d2a-ac57-f060-913a-6bc9db1e71a2@huawei.com>
 <aShpQ4iDceJ7-Nzs@willie-the-truck>
 <71cbdfbc-9281-b0d8-1590-ac666f4f5194@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cbdfbc-9281-b0d8-1590-ac666f4f5194@huawei.com>

On Sat, Nov 29, 2025 at 02:02:34PM +0800, Hanjun Guo wrote:
> On 2025/11/27 23:07, Will Deacon wrote:
> > Catalin and I were chatting the other day and we wondered whether it's
> > worth adding something to MAINTAINERS so that we get CC'd on arm64 ACPI
> > patches without you having to add us in manually? We wouldn't merge
> > anything without an Ack from somebody listed under the "ACPI FOR ARM64"
> > entry but it would mean that we get picked up by get_maintainer.pl.
> > 
> > What do you think?
> 
> Looks great to me!
> 
> > 
> > I can't tell whether this would be best as an F: line under the arm64
> > architecture entry, or adding us as R:/M: for the ACPI/arm64 entry.
> 
> How about adding M: for the ACPI/arm64 entry? I can send a patch
> for this change if you and Catalin agree with it.

Sure, that's fine by me. We'll still want Acks from the currently listed
folks when merging patches, though, so we're not letting you off the
hook that easily :p

Will

