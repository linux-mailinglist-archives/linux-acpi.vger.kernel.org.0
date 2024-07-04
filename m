Return-Path: <linux-acpi+bounces-6764-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E992927523
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 13:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ADCE285262
	for <lists+linux-acpi@lfdr.de>; Thu,  4 Jul 2024 11:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6428D191F6E;
	Thu,  4 Jul 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xp6zJVhH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD05E1DA30D;
	Thu,  4 Jul 2024 11:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092682; cv=none; b=OaY0Qaw4n2FKFFabLozer9vS+CRLuFDMLoy/u1Y/ckSeJMXBlA4Gqf13JATBlGU5yDjIAS1rJESwOy8SU2J8bBA1MHy8a5XokzgTvN6wLXGmb48T5fcO92Q/YzmpMaFVFK+I13EtBrnS+u/FSakseHCq7rZc2iP01klakl6I+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092682; c=relaxed/simple;
	bh=gA0QjNnLmRhml1iZJ2B3tlltYB33iuMEn55tUD0Hj4A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NPOOK0BTK7rqCrurN4yw1dPaetTXheEKiC4uR8savBkYdsazII9MBQhHppgUweBrY50zmZXUEeFPIY4u8D7EoqbTtuUIrtO+1rWxbuHeEU9Sxo9W5MhdLJ2DcLXCXecv0x8R8r/6jO5TjPkg1mbKMZMsfVCcfAEGcHmIkzdgRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xp6zJVhH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8588940E019C;
	Thu,  4 Jul 2024 11:31:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9ur-PWNcwGlc; Thu,  4 Jul 2024 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720092674; bh=OHMquNuMMQHx7ddHPRPVlHWYBUhFIjdeJqDW7Swm+ao=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Xp6zJVhHNfzZ8NGkEedT5qPUXiqUTwG5hUg51+bSAX41c6etMHOABF3jL0u9LL3Ps
	 hRqOphLkVKy9RzMH3H7ukwcGlEdBsDOLaGF6RfvBbPugAOy2WFgedoZujFlnmVoCxt
	 HH0csMBU3JuOoDOlTUnHN4ePT1haEjza7itj43GlZTxxfAeFuHk2JUPtmRNxTD0tTl
	 9EvnQU6yPkTOfFn+5arY60A1eOG2itqHrS7OSeORihxG0HWzwWGb7B/iO2ElwssJ0D
	 5XtSxTGhX8Cqra0TK2wlOYfWrGcTUXrG9DkeEWdz4rHUrlcHy3CXOh079BxUJFDjxV
	 uVMua+x0fQz+bHMG5UOJUGX9A8Aqs0xe4V+CBZUtk75a+fWDslUkZ+0x2hAJxR4Aar
	 ISi7mmXhRBeX9s8tVXLlhZxKbJwcICXnYL4D3EqmjbxgL8aBcLoXlUGZNayctCydx1
	 FqOMbTp+kgtq+VxYGFoHlp+JNO/Gr5Sa4zgCL90Xs8Ovbwn8l/8+HX9r0vw0IXVK5o
	 vD0BZa6ATLfnKPI8Bzz0oHHzLHzS7YSrhx8ri0cfKZjf0zKht0KlDIVDoqonU7NIBb
	 PewBDzOxXlLEnOYwe3njLuLwP10n6FWHBjEjVhVaOqoF9oP5444UYtFyaVR5aO9Wvc
	 lshbJgvQbP8qynZWXgTQLSgA=
Received: from [127.0.0.1] (business-24-134-159-81.pool2.vodafone-ip.de [24.134.159.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9C04440E0187;
	Thu,  4 Jul 2024 11:31:02 +0000 (UTC)
Date: Thu, 04 Jul 2024 13:31:00 +0200
From: Borislav Petkov <bp@alien8.de>
To: Zhiquan Li <zhiquan1.li@intel.com>, "Huang, Kai" <kai.huang@intel.com>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "rafael@kernel.org" <rafael@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
 "mingo@redhat.com" <mingo@redhat.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_x86/acpi=3A_fix_panic_while_AP_?=
 =?US-ASCII?Q?online_later_with_kernel_parameter_maxcpus=3D1?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2ce73ea8-bd1e-4148-8206-ffac8926a5d1@intel.com>
References: <20240702005800.622910-1-zhiquan1.li@intel.com> <41ee5438e8059c299f5722e386cdc1457ddc16eb.camel@intel.com> <20240702124524.GEZoP2ZKcTcKl1ca1R@fat_crate.local> <1b716b14c52a89c254108df1cee85306c786c52b.camel@intel.com> <2ce73ea8-bd1e-4148-8206-ffac8926a5d1@intel.com>
Message-ID: <9774DEAE-8E9E-40CD-B5A5-0A19243BB432@alien8.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 3, 2024 4:39:43 AM GMT+02:00, Zhiquan Li <zhiquan1=2Eli@intel=2Ecom=
> wrote:
>
>On 2024/7/3 07:55, Huang, Kai wrote:
>>> This happens to us maintainers at least once a week=2E Well, I don't w=
ant
>>> that to happen in my tree anymore=2E
>>>
>>> So none of this text above still doesn't explain to me *why* this is
>>> happening=2E
>>>
>>> Why do APs need to update acpi_mp_wake_mailbox?
>
>Not AP needs to update acpi_mp_wake_mailbox, but BSP might need to
>update it after the init stage=2E  In the encrypted guest CPU hot-plug
>scenario, BSP memremap() the acpi_mp_wake_mailbox_paddr, and writes APIC
>ID of APs, wakeup vector and the ACPI_MP_WAKE_COMMAND_WAKEUP command
>into mailbox=2E  Firmware will listen on mailbox command address, and onc=
e
>it receives the wakeup command, the CPU associated with the given apicid
>will be booted=2E
>
>We cannot assume that all APs will be brought up in the init stage=2E
>
>> They don't need to if acpi_mp_wake_mailbox can be setup before smp_init=
()
>> once for all=2E
>>=20
>> But currently the setup of acpi_mp_wake_mailbox is done when the first =
AP is
>> brought up because memremap() doesn't work in acpi_parse_mp_wake(), as
>> mentioned in the changelog of this patch=2E
>>=20
>> I also feel it's not ideal to setup acpi_mp_wake_mailbox when bringing =
up
>> the first AP, so I provided my diff=2E  IIUC, if memremap() works for
>> acpi_mp_wake_mailbox when bringing up the first AP, then it should also=
 work
>> in
>> the early_initcall()=2E
>
>Besides the factor that whether memremap() is functional at the point in
>the boot process, another reason I can think of is, if the intention is
>just to work with BSP, then the remapping is a redundant step=2E
>Especially in the kexec & kdump case, the capture kernel only needs
>single CPU to work usually with the "maxcpus=3D1" option=2E
>
>IMHO, the solution that postpone the remapping while really needs to
>bring up APs is reasonable, just don't make acpi_mp_wake_mailbox
>read-only=2E  The APs might be brought up later, might be never=2E
>
>
>>=20
>>> Which patch is this fixing?
>> It fiexes below commit AFAICT:
>>=20
>>   24dd05da8c79 ("x86/apic: Mark acpi_mp_wake_* variables as
>> __ro_after_init")
>>=20
>> Which didn't consider 'maxvcpus=3Dxx' case=2E
>>=20
>
>Thanks a lot for checking this, Kai=2E
>
>>=20
>> But I will leave to Kirill to confirm=2E
>
>Best Regards,
>Zhiquan

Then please extend the commit message with the "why", add the Fixes tag an=
d resend=2E

Thx=2E
--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

