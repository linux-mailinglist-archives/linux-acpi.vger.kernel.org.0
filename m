Return-Path: <linux-acpi+bounces-17699-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B409BCAB68
	for <lists+linux-acpi@lfdr.de>; Thu, 09 Oct 2025 21:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111DC424B03
	for <lists+linux-acpi@lfdr.de>; Thu,  9 Oct 2025 19:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA9D25742C;
	Thu,  9 Oct 2025 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sA8QS00E"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A631B423B;
	Thu,  9 Oct 2025 19:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038588; cv=none; b=DwhLKwN++MumwuK5n9CuxJE3+u6NHQ/F9/6Jimb0Uer6bjtUe5tKeaM6ojVTk1VhZHLIH4LyVmi/KR/m9mNOnAPnnXN20ruRR2ulGbPaOj//S8XMjiWZFAMNeZwNXUfJX5gOJBRVJefzuoSbAEr+xaIocc9KSsjcRynj9eoRyB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038588; c=relaxed/simple;
	bh=YKj5/aGCmlE3HaN0xf6ah90FIbtTbrwL50IYyirhpc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bqg34V4Np0lJ7ld+iXCqWjHEA664LdunHsjEjeigBE9J5eAeRk2FUJl68kXsO54k3JuS4VuYQvxV9NZ9H1ZxaTWjVcuB0OQLygq/4jELRWt3+khGDNT6N2DWpcJNcVkvs/ofik8yBhcHSV+sXetT54fayVl5lUK07fWUM3KwlUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sA8QS00E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC9CC4CEE7;
	Thu,  9 Oct 2025 19:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760038588;
	bh=YKj5/aGCmlE3HaN0xf6ah90FIbtTbrwL50IYyirhpc8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sA8QS00EE7SkS4Tf84aAijmI/rw8pVuKaIGAtAUjjz9oZkwutuB5W9T+nWCoGfQCr
	 uSVxfekDzNlsrUwHEpANUvcFigHU4qTx0s/ccBQlh/LpQLK+Zzk+tDrKhZ+NcA0GrG
	 TYDJFE8XJEI1XApsDqEKeAPZoAItpnpRS6XAbicYpERzbntbcuwzx/wJcZfMtX4YBi
	 UkbKngmXzWULTZ+QI16leP2M/k5077tf7GIleC9EEq54WRRxF4znnoAYo+soLCz3Gr
	 mKMXIULCn35am+HsJ1UfhhsEEFugSJs94TnDXyXfcmZ3NynRby+dhSX1WGXFrF3YSx
	 cH8f+J1VR9Epw==
Message-ID: <226584e9-7dca-49c8-a9a0-e7f8b6edd021@kernel.org>
Date: Thu, 9 Oct 2025 14:36:27 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] ACPI: PM: s2idle: Tidy up the code and avoid
 invoking _DSM unnecessarily
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <4699399.LvFx2qVVIh@rafael.j.wysocki>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <4699399.LvFx2qVVIh@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/25 2:25 PM, Rafael J. Wysocki wrote:
> Hi Everyone,
> 
> There is an unused function related to s2idle on x86, so drop it (patch [1/3]).
> 
> Also, some callback functions used in struct platform_s2idle_ops on x86 can
> be made static, so do that (patch [2/3]).
> 
> Finally, the evaluation of LPS0 _DSM Function 1 is useless overhead unless
> printing PM debug messages has been enabled, so rearrange the code to only
> evaluate it when the data produced by it will be used (patch [3/3]).
> 
> Please see changelogs of the individual patches for details.
> 
> Thanks!
> 
> 
> 

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

