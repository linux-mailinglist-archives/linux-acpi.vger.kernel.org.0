Return-Path: <linux-acpi+bounces-21302-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +G9nIeB6pml8QQAAu9opvQ
	(envelope-from <linux-acpi+bounces-21302-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 07:08:32 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 310A41E9671
	for <lists+linux-acpi@lfdr.de>; Tue, 03 Mar 2026 07:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C43B230528BC
	for <lists+linux-acpi@lfdr.de>; Tue,  3 Mar 2026 06:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91959358365;
	Tue,  3 Mar 2026 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K27VfvfK"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF167262F;
	Tue,  3 Mar 2026 06:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518077; cv=none; b=VIybMCbYmZKTKMZkqCd7fTkpd4fjLwmKtdQ9sURscJ7HMG4m9MqM3M8YoW/wgpk7e2f1EHv46/VI2fIf071eDpnTJsV4Uo45I8oEt7zD6Id/H2olWzLIbJt7QqYSeRNS2+99lrFczzEe+fLgwj0JbBXtY6Te4J8FXaXUWEr5mTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518077; c=relaxed/simple;
	bh=bYGxeb0oKnPKhTR3gcq9FDbtu2F7YmpxraTvFuPYRRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ta0iugmq+01IC3xENGmBBFBbR8/yxYWRAtnORlNQ1wYY6GjP++SFxsSBmhGouvvBhCMCBuskycBdR/IBa1nYK8yoNTU/V4SjbDqYKwJEawr02/iIT2htXOYx4TB8DsxWFpIR+JAdGIHo74tcR72rOMwb2331jtYuZuc3F2dRRAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K27VfvfK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E1DC116C6;
	Tue,  3 Mar 2026 06:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772518077;
	bh=bYGxeb0oKnPKhTR3gcq9FDbtu2F7YmpxraTvFuPYRRg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K27VfvfKyTIqhbi5/kcpQyQh82zF4irXRKnnde7Bi2L4lt0VYr3QxxD9oDRMtjimC
	 MmsziJkMiR9P/nfJR6Li7hIkTVCu+N5t+Kln01q985h0dtNfaZ3ZGzDbFS2Wvqrwiy
	 5E6BtdSfg46+O5qOIExeRbucY1mZGAVOi4aBp5kSPGC4X3T72Brv21no0FQ/1MwZT3
	 Vs+qlKE0tF6o+eVyfyF1T8VLZi5JSLR1yvgxpAeDRXW3XqfqzkSPIscCahf7Swj/EO
	 JrzhLxFeEkNb3A9Xp7WK+v+S0RH4qtCZQGi/thxt4uu9Laj/Gp5xW3K2an3pNmaoIg
	 mxTMoDu8W6fXg==
Date: Mon, 2 Mar 2026 23:07:52 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	x86 Maintainers <x86@kernel.org>, linux-rtc@vger.kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v1 4/8] ACPI: x86/rtc-cmos: Use platform device for
 driver binding
Message-ID: <20260303060752.GA2749263@ax162>
References: <5983325.DvuYhMxLoT@rafael.j.wysocki>
 <13969123.uLZWGnKmhe@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13969123.uLZWGnKmhe@rafael.j.wysocki>
X-Rspamd-Queue-Id: 310A41E9671
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21302-lists,linux-acpi=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,linux-acpi@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-acpi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hi Rafael,

On Mon, Feb 23, 2026 at 04:30:21PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Modify the rtc-cmos driver to bind to a platform device on systems with
> ACPI via acpi_match_table and advertise the CMOST RTC ACPI device IDs
> for driver auto-loading.  Note that adding the requisite device IDs to
> it and exposing them via MODULE_DEVICE_TABLE() is sufficient for this
> purpose.
> 
> Since the ACPI device IDs in question are the same as for the CMOS RTC
> ACPI scan handler, put them into a common header file and use the
> definition from there in both places.
> 
> Additionally, to prevent a PNP device from being created for the CMOS
> RTC if a platform one is present already, make is_cmos_rtc_device()
> check cmos_rtc_platform_device_present introduced previously.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After this change in -next as commit 2a78e4210444 ("ACPI: x86/rtc-cmos:
Use platform device for driver binding"), I am seeing

  rtc_cmos PNP0B00:00: error -ENXIO: IRQ index 0 not found

on a few of my test machines. Is this expected?

Cheers,
Nathan

# bad: [d517cb8cea012f43b069617fc8179b45404f8018] Add linux-next specific files for 20260302
# good: [11439c4635edd669ae435eec308f4ab8a0804808] Linux 7.0-rc2
git bisect start 'd517cb8cea012f43b069617fc8179b45404f8018' '11439c4635edd669ae435eec308f4ab8a0804808'
# bad: [30cad5d4db9212a3e9bb99be1d99c4fbc17966c7] Merge branch 'master' of https://git.kernel.org/pub/scm/linux/kernel/git/wpan/wpan-next.git
git bisect bad 30cad5d4db9212a3e9bb99be1d99c4fbc17966c7
# good: [3d6642ce50abe4cccbbc4cfda0808300b4f39cb6] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
git bisect good 3d6642ce50abe4cccbbc4cfda0808300b4f39cb6
# good: [e832bc0903e6b85f9f084fef0a9d51bbbbcc1ee7] Merge branch 'for-next/pstore' of https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
git bisect good e832bc0903e6b85f9f084fef0a9d51bbbbcc1ee7
# bad: [ef26f99b113b16135282e2cda9ee8afda2d39e10] Merge branch 'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git
git bisect bad ef26f99b113b16135282e2cda9ee8afda2d39e10
# good: [df57aa49ec08ebe55d2840e3950be37bff3a8853] Merge branch 'docs-next' of git://git.lwn.net/linux.git
git bisect good df57aa49ec08ebe55d2840e3950be37bff3a8853
# bad: [8aec61332e195aae38737a3b6454526938132f41] Merge branch 'next' of https://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git
git bisect bad 8aec61332e195aae38737a3b6454526938132f41
# bad: [ea956cb5e17cb5910382be255aa2329e067edd3b] Merge branch 'cpupower' of https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git
git bisect bad ea956cb5e17cb5910382be255aa2329e067edd3b
# bad: [0953f6a5e08b6fc636b17e00dcac3d9eeef78e72] Merge branch 'acpi-cmos-rtc' into linux-next
git bisect bad 0953f6a5e08b6fc636b17e00dcac3d9eeef78e72
# bad: [0139085310c40853cc429d5c38fd66e540c97d34] x86: rtc: Drop PNP device check
git bisect bad 0139085310c40853cc429d5c38fd66e540c97d34
# good: [1ae2f435350ec05224a39995c3a680aa6fdae5a5] ACPI: x86: cmos_rtc: Create a CMOS RTC platform device
git bisect good 1ae2f435350ec05224a39995c3a680aa6fdae5a5
# bad: [d15f1c2e413e861270ca6aa5dc5d9da1bcd678ca] ACPI: PNP: Drop CMOS RTC PNP device support
git bisect bad d15f1c2e413e861270ca6aa5dc5d9da1bcd678ca
# bad: [2a78e42104444f948698f1225deaf515e9b7224d] ACPI: x86/rtc-cmos: Use platform device for driver binding
git bisect bad 2a78e42104444f948698f1225deaf515e9b7224d
# first bad commit: [2a78e42104444f948698f1225deaf515e9b7224d] ACPI: x86/rtc-cmos: Use platform device for driver binding

