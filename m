Return-Path: <linux-acpi+bounces-21464-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJJTBVYhqmn2LgEAu9opvQ
	(envelope-from <linux-acpi+bounces-21464-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:35:34 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A90C219DC3
	for <lists+linux-acpi@lfdr.de>; Fri, 06 Mar 2026 01:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03EF2302E7B1
	for <lists+linux-acpi@lfdr.de>; Fri,  6 Mar 2026 00:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF372C3254;
	Fri,  6 Mar 2026 00:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDjU1l3f"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED91818B0A;
	Fri,  6 Mar 2026 00:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772757331; cv=none; b=dXseQzcgPnk9FBecBaVpSa8u8H3N9kgTuIYChEJSaWg9KrPnLXLyeg6TKB24uDNSlfGRQYNzsCytj/9sgRD//8+77eFPgJMmxuJqtmqNaMS7DA4yfmy368fynAOL5QX1S4azh1qnlaDhG1/cDLs6D+G6XWHV5t/mA6vxEMX7F7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772757331; c=relaxed/simple;
	bh=LW7dbYDOkNHz8g43eyYZDS9v1JXlcR+zT14BnEL+RJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDn9MeC5YaZ5sHniKi1LyXxD6D9k3QIVK7WG5erPjtQDLEnQrFenLwiOMmTFIIvfofZvgR88MKVWWivdBlIWZ3UWP2xsrrVgBFv7cn+QAS3MOSUg8hlhYZN6SBzqH/ZuiummfCYGeyElRpIbakp98Znu2gXC6Y158Wqq8keK2Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDjU1l3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7136C116C6;
	Fri,  6 Mar 2026 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772757330;
	bh=LW7dbYDOkNHz8g43eyYZDS9v1JXlcR+zT14BnEL+RJg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SDjU1l3frVFzWgi9iV+ahcW2fjZihPesFK5QZ0pvGQ32gAT/sETj0XTZhp8RyalnN
	 yUo2Nn5zj2kHRE0uooBGm3VkindmSX553G2d4ILnFH4fxxkp6Efp4CBQSRdOqVUFAO
	 KTTAysJ1B5KA5zJ4RE1Eo5M+4vWOU/8rExT9JOBpLTQvB7H0Ihdcn+xxikbDV6k4r9
	 K4sYdcqgHMT05kkD5TmiEACqptUtUMdL5PNysDJEBM6nfyMIA8VCq5Bdjx+uwR6MVG
	 HOQ8RpAQMVnWcs7N0TEQicB+x5LDUHZhakJswoaXZjMa6nCVHF43WM6CtR89UZdy31
	 DRImIHpXO2gug==
Message-ID: <23e8f0df-3eec-46e8-b5f1-5f417460e272@kernel.org>
Date: Thu, 5 Mar 2026 18:35:28 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] AMDISP failure with kernel v7.0-rc2 due to Commit:
 02c057ddefef5
To: "Nirujogi, Pratap" <pnirujog@amd.com>, rafael@kernel.org
Cc: W_Armin@gmx.de, lenb@kernel.org, Bin Du <bin.du@amd.com>,
 benjamin.chan@amd.com, king.li@amd.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev
References: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <007e3390-6b2b-457e-83c7-c794c5952018@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6A90C219DC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org,amd.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-21464-lists,linux-acpi=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,linux-acpi@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action



On 3/5/2026 5:11 PM, Nirujogi, Pratap wrote:
> Hi Rafael,
> 
> In kernel version 7.0-rc2, the AMDISP device reports the following 
> errors when created via mfd_add_hotplug_devices.
> 
> [    5.236645] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: 
> no  post: no)
> [    5.236744] input: Video Bus as /devices/ 
> pci0000:00/0000:00:08.1/0000:c3:00.0/amd_isp_capture.1.auto/input/input21
> [    5.236779] acpi device:14: Error installing notify handler
> [    5.236782] acpi device:15: Error installing notify handler
> [    5.236783] acpi device:16: Error installing notify handler
> [    5.236784] acpi device:17: Error installing notify handler
> [    5.236785] acpi device:18: Error installing notify handler
> [    5.236786] acpi device:19: Error installing notify handler
> [    5.236786] acpi device:1a: Error installing notify handler
> [    5.236787] acpi device:1b: Error installing notify handler
> [    5.236788] acpi device:1c: Error installing notify handler
> 
> These failures indicate AMDISP device is incorrectly detected as ACPI 
> Video device while it is not.
> 
> The seems like a regression caused by the change that converts the ACPI 
> video device to a platform device (commit: 02c057ddefef5).
> 
> Issue is not observed in 6.19-rc6, and also when this change is reverted 
> in 7.0-rc2.
> 
> I really appreciate your inputs on addressing this issue and helping us 
> make progress on 7.0 rc2.
> 
> Steps followed to reproduce the issue:
> 
> 1. Apply AMDISP v9 patch series [1] on top of kernel v7.0-rc2
> 2. Add NULL check for “dev->type” in isp_genpd_add_device() [2] (to 
> avoid kernel panic found in v7.0-rc2)
> 3. Build kernel with:
>      - CONFIG_AMD_ISP_PLATFORM=y
>      - CONFIG_VIDEO_AMD_ISP4_CAPTURE=m
> 4. Install kernel on AMDISP supported system (HP ZBook Ultra G1a)
> 5. Boot system to see the failures
> 
> [1] https://lore.kernel.org/all/20260302073020.148277-1-Bin.Du@amd.com/
> [2] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/amd/ 
> amdgpu/isp_v4_1_1.c#L132
> 
> Thanks,
> Pratap
> 
> 
> 

It's a bit weird to see it even probe in this path in the first place. 
acpi_video_bus_probe() getting called with the mfd device doesn't seem 
right to me.

I wonder if it's because ISP is an MFD device of GPU (and thus LNXVIDEO 
ends up matching).

Would a sensible solution be to reject mfd device types in 
acpi_video_bus_probe()?

> 


