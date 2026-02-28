Return-Path: <linux-acpi+bounces-21264-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLUuDbMLo2nY9AQAu9opvQ
	(envelope-from <linux-acpi+bounces-21264-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:37:23 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7B31C4013
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 16:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DACEF300279B
	for <lists+linux-acpi@lfdr.de>; Sat, 28 Feb 2026 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424BC47B42F;
	Sat, 28 Feb 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMNFpzBy"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4E04657F2
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292920; cv=none; b=oeRjZKlhsltMumDixLeL9i3dcpNcdWDSlDhUra6V6Xcnu10KFKonS+Yi8dqLK0OqoCCUlmWHE2jhLUdco7rfB2NsCdwGQlBhW6avmRtdG+6bkps4I+SLitrEOwPrjmrjDCvbfUnEPeYmtZGdZyVJ0TCRb9mJl5xSPoIP5s9UHtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292920; c=relaxed/simple;
	bh=HUZbR4HHbzKSmMPbJBbt4DjH6eOUfq+Q6mI6wNlEPGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cBwUatUXe9t60r5eVv1ER2myJzNEBfV2JKi3uz7Ag43qPRc4vYda9qlAC3u5y7oE5SF1UaDVEgMXoaTpruz+w3iaaZf/K+GhOTR1UcVoOls0KznXKex0Zm2Ci/RIYWy0G29tzo9cOcjkYypfsucKRWVtTnBxFdy42eOIw87YaIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMNFpzBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A76C2BCB2
	for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 15:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772292920;
	bh=HUZbR4HHbzKSmMPbJBbt4DjH6eOUfq+Q6mI6wNlEPGE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VMNFpzByzCXFaDyj/cMNokeHmlOqHqU30sD1StNluRckyxRgb0CQ3UGmGGfh2i+XU
	 kz+WYABNpWtkwziBqgX+n7FbjJkXe3+4mf9eLTtClh+dWwOJT4j/SnUvTd1lycLtJE
	 Er/wa6gkRZ7YswKZ1B7imYbAVXhA5hrTIAMv5NaTNfEI8Lc0zrSVKlXtcAojFhHhEa
	 ZSnuUdP5fjNZOBF4VDCbvQ+bWkL4iMrCc6HcuPzDBRgehAvl8z4jiR4Nym0D++O2A9
	 sFzdTzcJAmQxV98wxYjTFty7873vfgS31YegG3RalN5S5nLFSZwAwfenxT1olXjCZI
	 TcSWhh5fwJukg==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-662efd1bdd4so2153737eaf.0
        for <linux-acpi@vger.kernel.org>; Sat, 28 Feb 2026 07:35:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVT3W/knR7ihjZ/w3kKLSeIJaMttzzp6s2Ic9RQq5z1xJMxuN+2tlQBk/k1V5Lv+hFdMpFifFNGbbwW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+gXggOA8UHaWQrUFC82RssavBeRJIvB7C8qkfOqz3wKhO6ci8
	a89RfdnhCjpb6MgWGJuU9oef6/e7drbaYInWKSF4wQtCdK3H+Xgj9RHMWHnTCdXaIkQfte/u3lR
	UnU6hU0asZ/Tib8BTRKjFudcIp/G5rL0=
X-Received: by 2002:a05:6820:2916:b0:674:4b83:8720 with SMTP id
 006d021491bc7-679fb471a86mr3392275eaf.13.1772292918934; Sat, 28 Feb 2026
 07:35:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aW3d4B3xMwe-pyzJwFnM7q4q5WjOjAajU2c6gk65arrBx5-soWv9AAZPzZHxAiX1XOxILELauRQdnxGxMectmmW76xfxyQyErVEH8nR_iyw=@protonmail.com>
 <CAJZ5v0gL1=m6j5r3ZAp61nmwBb+wd2Y9zPSv=a=NQem5XiZMCg@mail.gmail.com> <lA7Dz_m7_nCF8KkRyEOcSCLg799Mm9_DN2r9hx7ISjw32OoKiB1r_YjGHIFX8vgqxpOkVJ8d_yHb-VsGAvIWC942D4-zdWxAIP4_k6ZIQi8=@protonmail.com>
In-Reply-To: <lA7Dz_m7_nCF8KkRyEOcSCLg799Mm9_DN2r9hx7ISjw32OoKiB1r_YjGHIFX8vgqxpOkVJ8d_yHb-VsGAvIWC942D4-zdWxAIP4_k6ZIQi8=@protonmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 28 Feb 2026 16:35:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0h-0FUn+RdWX358pYce+pECL9whne7MZR4GJUy7PxrLoA@mail.gmail.com>
X-Gm-Features: AaiRm51NJ4120zaSkIDuqL1AIxbqLDA_-a5SPIwwUmkX360Qm5fRK6LAK63_JWE
Message-ID: <CAJZ5v0h-0FUn+RdWX358pYce+pECL9whne7MZR4GJUy7PxrLoA@mail.gmail.com>
Subject: Re: [REGRESSION] Suspend broken on 6.19.4
To: Athul Krishna <athul.krishna.kr@protonmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "superm1@kernel.org" <superm1@kernel.org>, 
	"sashal@kernel.org" <sashal@kernel.org>, "bp@alien8.de" <bp@alien8.de>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21264-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,protonmail.com:email,mail.gmail.com:mid,alien8.de:email]
X-Rspamd-Queue-Id: 9E7B31C4013
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 4:31=E2=80=AFPM Athul Krishna
<athul.krishna.kr@protonmail.com> wrote:
>
> On Saturday, February 28th, 2026 at 7:21 PM, Rafael J. Wysocki <rafael@ke=
rnel.org> wrote:
>
> > On Sat, Feb 28, 2026 at 1:40=E2=80=AFPM Athul Krishna
> > <athul.krishna.kr@protonmail.com> wrote:
> > >
> > > Device: Asus Zephyrus G14 (GA402RJ)
> > > CPU: Ryzen 7 6700H
> > > iGPU: Radeon 680M
> > >
> > > Problem: Suspend broken on 6.19.4. On closing the lid or systemctl su=
spend, screen turns off but device does not fully power down.
> > > No obvious errors in dmesg except:
> > > [  219.151441] amd_pmc AMDI0007:00: Last suspend didn't reach deepest=
 state
> > > [  219.164301] ACPI: EC: interrupt unblocked
> > >
> > > Bisected:
> > > commit 6cfed39c2ce64ac024bbde458a9727105e0b8c66
> > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Date:   Tue Dec 23 18:09:11 2025 +0800
> > >
> > >     ACPI: processor: Update cpuidle driver check in __acpi_processor_=
start()
> > >
> > >     [ Upstream commit 0089ce1c056aee547115bdc25c223f8f88c08498 ]
> > >
> > >     Commit 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle
> > >     driver registration") moved the ACPI idle driver registration to
> > >     acpi_processor_driver_init() and acpi_processor_power_init() does
> > >     not register an idle driver any more.
> > >
> > >     Accordingly, the cpuidle driver check in __acpi_processor_start()=
 needs
> > >     to be updated to avoid calling acpi_processor_power_init() withou=
t a
> > >     cpuidle driver, in which case the registration of the cpuidle dev=
ice
> > >     in that function would lead to a NULL pointer dereference in
> > >     __cpuidle_register_device().
> > >
> > >     Fixes: 7a8c994cbb2d ("ACPI: processor: idle: Optimize ACPI idle d=
river registration")
> > >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >     Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > >     Tested-by: Borislav Petkov (AMD) <bp@alien8.de>
> > >     Link: https://patch.msgid.link/20251223100914.2407069-4-lihuisong=
@huawei.com
> > >     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >
> > > Reverting the commit or downgrading to 6.19.3 resolves the issue.
> > > Attached dmesg and lspci.
> >
> > Is this problem also present in 7.0-rc1?
> >
> Nope, not an issue in 7.0-rc1 (7.0.0-rc1-00286-gaed968f8a6cd).

OK, thanks!

So as I said, commit 0089ce1c056aee5471 shouldn't have been backported
(sorry for missing that!) and so commit 6cfed39c2ce64ac0 needs to be
reverted from -stable.

