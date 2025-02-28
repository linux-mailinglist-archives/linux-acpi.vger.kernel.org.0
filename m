Return-Path: <linux-acpi+bounces-11630-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DDFA49EED
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 17:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FD113B5A8C
	for <lists+linux-acpi@lfdr.de>; Fri, 28 Feb 2025 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED0A275606;
	Fri, 28 Feb 2025 16:32:34 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA0227560B;
	Fri, 28 Feb 2025 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740760354; cv=none; b=Z9POYK7PQN2KKrofVFEwiFL66roXDLp0lbDYoWFg68LmNUrpVlyOgO/OwcZ3PA6NUM4Vwi6UgD+8LpPWLc6OIIxW8S2xghEQGk52gXMZWlOZUEqYQTRuFhKO0p0GWI54IyQ874w5Tm3ifWhaR+x8SKwyW3d8gOe+2iWyZ8wKIRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740760354; c=relaxed/simple;
	bh=eq+NnALod3436I9Ed+BoXmb+oSMC7kn0v44DWs+5M9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWrpcUEZStxA6tCgTvNedIbzwwA0sE2w58rK6emW6lj2Ppam1wThbUVG39bQjA1W4SvdClQYFOLoSoc1RyVs9G2lTsFaVH+EudHWB2yBQYkXHm14mnwYSZAVVhrutg3iso19OFiwg6LaTzEjIsHSSYmsd7SqtVcaLQuUcYMK1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D657D150C;
	Fri, 28 Feb 2025 08:32:47 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0A8E3F5A1;
	Fri, 28 Feb 2025 08:32:31 -0800 (PST)
Date: Fri, 28 Feb 2025 16:32:28 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Huisong Li <lihuisong@huawei.com>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<jassisinghbrar@gmail.com>, <liuyonglong@huawei.com>
Subject: Re: [PATCH] mailbox: pcc: Fix can't clear level interrupt of type3
 in cornor case
Message-ID: <Z8HlHDAUWqQOjrCH@bogus>
References: <20250227072341.28693-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227072341.28693-1-lihuisong@huawei.com>

On Thu, Feb 27, 2025 at 03:23:41PM +0800, Huisong Li wrote:
> The mbox_chan_received_data() will call Rx callback of mbox client driver
> using type3 to set the flag of command completion. Then driver can continue
> to do something like sending a new command. In this case, the rest of the
> interrupt handler function may be concurrent with pcc_send_data().
>

Understood and valid issue/bug.

> The 'chan_in_use' flag of a channel is true after sending a command. And
> the flag of the new command may be cleared by the running interrupt handler
> in cornor case. As a result, the interrupt being level triggered can't be
> cleared in pcc_mbox_irq() and it will be disabled after the number of
> handled times exceeds the specified value. The error log is as follows:
>
> [519082.811553] kunpeng_hccs HISI04B2:00: PCC command executed timeout!
   ^^^^
These timestamps are useless, needs to be dropped.

> [519082.828532] kunpeng_hccs HISI04B2:00: get port link status info failed, ret = -110.
> [519082.833438] irq 13: nobody cared (try booting with the "irqpoll" option)
> [519082.844622] CPU: 304 PID: 15206 Comm: systemd-journal Kdump: loaded Tainted: G           OE     5.10.0 #5
> [519082.854959] Hardware name: To be filled by O.E.M. To be filled by O.E.M./To be filled by O.E.M., BIOS Nezha B800 V3.1.0 01/02/2024

"To be filled by O.E.M." interesting. Either as silicon vendor, some prefer
to leave it this way to ensure the O.E.M fill them correctly or the firmware
engineers are not bothered to get these right as nothing breaks without
these.

Anyways, good example of what not to have in the products, as it is completely
useless.

[...]

>
> To solve this issue, pcc_mbox_irq() clear 'chann_in_use' flag immediately
> after clearing interrupt ack register.
>

This may be correct way of fixing the issue here, but I am questioning the
existence of this flag now. I have some rework on this file. I will pick
this up if I think this is needed as it may conflict with my changes or
we will drop the flag completely. Give a week or so, will post the changes
and we can take it from there.

--
Regards,
Sudeep

