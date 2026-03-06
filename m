Return-Path: <linux-acpi+bounces-21490-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJUEMarOqml4XQEAu9opvQ
	(envelope-from <linux-acpi+bounces-21490-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:55:06 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C94222211E5
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 13:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 376883004416
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EE53659FF;
	Fri,  6 Mar 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7tP2fRe"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761C531D372;
	Fri,  6 Mar 2026 12:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801159; cv=none; b=OKktg/hwUzVT7S/0Np0++DSI9tnS1UrXek8kTUOZIrL08kSlWs5zEBp4zPk4NKKUoehazXSGndeaTyyEvEE3XAcihjvTNXLYUPyU5nYO7Etas/0f7SjOM0Yn2PcTbfIlMMH0VFAEb9ixHKeWCUSdsLWLpUq2cd1zIIbblSBHZVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801159; c=relaxed/simple;
	bh=0T6JmVCeaLZwZT8GrU0O5xL7QHSuhazrZ7z4L4Oikes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jic8PHyAmkK+tAlvTF7vZUIKYHUA7VtOFgZpVz0Uj9UkEqKodEyvURwxjV1fviNMXB6gEzd3dUx2ZLT277uPenOWnsNZlWcb0UertszdxgkStjiAKqBKVM+s2zS70gdap2SvQ09C2430OOE7qcnhssZ3Z3UQa7hggVX2pgldzPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7tP2fRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281A5C4CEF7;
	Fri,  6 Mar 2026 12:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772801159;
	bh=0T6JmVCeaLZwZT8GrU0O5xL7QHSuhazrZ7z4L4Oikes=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y7tP2fReUN4PTDiiIF4jjXaWnIHOCtkKUjeV/zv9HtXOa5OmXg4MWtpKgxS7Ei8PF
	 QprFmz3PmjGo+eHGbzTL0/83QiovfdELcCtqaliCCjr00e+GUBDjIYDuZDQCPxz9OT
	 lGoFrWmJ27PrTbiQMSkIuu5rL377VeT6zpJerfMM2Kt1oeI/3c9RVdFFnW/ihx1ncE
	 0sBoVoZ1KeaegMJ95tRP0OACqV0TrnvVb7+0r4S+EqTLxCl47i52VnQC+hM389lW7n
	 gizXBWdkErF0aP3/crWdkCQHvsXgFTeC7MElDvWayfY8VqO6oYCQ96q8PDAz2NVYx3
	 ijtgUF3S9k9QQ==
Message-ID: <971fc64d-abef-448a-aa7d-7d4b3391f67e@kernel.org>
Date: Fri, 6 Mar 2026 06:45:56 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit:
 02c057ddefef5
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Nirujogi, Pratap" <pnirujog@amd.com>, W_Armin@gmx.de, lenb@kernel.org,
 Bin Du <bin.du@amd.com>, benjamin.chan@amd.com, king.li@amd.com,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
 <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
 <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0gQK_OPyZGZDPC6WCbVtBuJKggk0Lrscmxxkq1GHiiVRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C94222211E5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amd.com,gmx.de,kernel.org,vger.kernel.org,lists.linux.dev];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21490-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action



On 3/6/26 6:01 AM, Rafael J. Wysocki wrote:
> On Fri, Mar 6, 2026 at 1:35 AM Mario Limonciello (AMD) (kernel.org)
> <superm1@kernel.org> wrote:
>>
>>
>>
>> On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
>>> Hi Rafael,
>>>
>>> In kernel version 7.0-rc2, the AMDISP device reports the following
>>> errors when created via mfd_add_hotplug_devices.
>>>
>>> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom:
>>> no  post: no)
>>> [    5.236744] input: Video Bus as /devices/
>>> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/input21
>>> [    5.236779] acpi device:14: Error installing notify handler
>>> [    5.236782] acpi device:15: Error installing notify handler
>>> [    5.236783] acpi device:16: Error installing notify handler
>>> [    5.236784] acpi device:17: Error installing notify handler
>>> [    5.236785] acpi device:18: Error installing notify handler
>>> [    5.236786] acpi device:19: Error installing notify handler
>>> [    5.236786] acpi device:1a: Error installing notify handler
>>> [    5.236787] acpi device:1b: Error installing notify handler
>>> [    5.236788] acpi device:1c: Error installing notify handler
>>>
>>> These failures indicate AMDISP device is incorrectly detected as ACPI
>>> Video device while it is not.
>>>
>>> The seems like a regression caused by the change that converts the ACPI
>>> video device to a platform device (commit: 02c057ddefef5).
>>>
>>> Issue is not observed in 6.19-rc6, and also when this change is reverted
>>> in 7.0-rc2.
>>>
>>> I really appreciate your inputs on addressing this issue and helping us
>>> make progress on 7.0 rc2.
>>>
>>> Steps followed to reproduce the issue:
>>>
>>> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
>>> 2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to
>>> avoid kernel panic found in v7.0-rc2)
>>> 3. Build kernel with:
>>>       - CONFIG_AMD_ISP_PLATFORM=y
>>>       - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
>>> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
>>> 5. Boot system to see the failures
>>>
>>> [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
>>> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/
>>> amdgpu/isp_v4_1_1.c#L132
>>>
>>> Thanks,
>>> Pratap
>>>
>>>
>>>
>>
>> It's a bit weird to see it even probe in this path in the first place.
>> acpi_video_bus_probe() getting called with the mfd device doesn't seem
>> right to me.
>>
>> I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO
>> ends up matching).
>>
>> Would a sensible solution be to reject mfd device types in
>> acpi_video_bus_probe()?
> 
> Every platform device with LNXVIDEO in the device ID list will be
> matched and so probed.
> 
> I'm wondering how those devices get that ID though.

Yeah me too.  I was surprised an MFD device got it.

Pratap - can you figure this out before we go too far in this path?

If they really shouldn't have LNXVIDEO fixing that may be a better solution.

> 
> Also, is this really a mainline regression?  AMDISP patches are not in
> the mainline, no?

The amdgpu half of it is mainline, the other half is still on the lists.

