Return-Path: <linux-acpi+bounces-5748-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CEF8C2965
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FD801C21804
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9798418654;
	Fri, 10 May 2024 17:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="q1QsG7EL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCF51BDC8;
	Fri, 10 May 2024 17:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715362755; cv=none; b=G5bOouK3BqAGTXzF2Ay25SYTbZ/K/g+f673EGJzGYozuHJvR09XoNzmDhpmaYhb880TOxLMSJV9BMcFxlh7Rani9gedqIygPEaDO9XtEe5PU141iLOTFblIU8KlIPAdskeCWLTxBmTkfFusXh+9HKn93k5KPoi6xEtFaoqD7Vps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715362755; c=relaxed/simple;
	bh=u3APilzbMNtqOZMLPN2WV/6Lb05zx0rNSqQPRAygaTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcqEyneVpTE9iKJns7uDU/xe87uqO5Za3XM43+LVKUYNO7nzh7wHEgjzQhNcCdGHgjZpEiEc2H/cH7u+WDbONAFQ3gNlDeyastE33u7Wdsj7WLG3kHObwFSYNOjDnbvrIA9nX5p58AyLQxZA+B55DMsXV4ZglYlO/2CUZ1/peOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=q1QsG7EL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715362737; x=1715967537; i=w_armin@gmx.de;
	bh=z0VltB2Hvfk8CsgxOW0/hP0I9raK/6ln4is4V8Bvz/M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=q1QsG7EL+UPPn6cf4zE876oS0SyFmcFqq7a7tvXUVFiALaxlalhyY4zGNqmNv46O
	 QqLCSCZwEXxkeC7YgGlq4GZKNIM7aPH2FP5R8WepVJfrvySgxcFZTDZumJwD3O8ST
	 HuHhlbhbmHZsF8Hffu1UbOFZmZwXNYNJjlhL7sZ+9PwGatx4xfCtxjk4YrRZuwccX
	 oX2f2D2gttPaY7vz3vBesmicWgkYof23/eWQtbH5WslUTTW8bMW/wiEi08nNcFXa5
	 713UrvgvC0BPW9jH5lE/ZOBsEOTQdvxkwo1mOEcq35SuYbvsf1ZqfmYs2b6L74qTr
	 OuQSJ5KSf9ljcAD9EQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MRmfi-1sBUUt37gw-00SQJw; Fri, 10
 May 2024 19:38:57 +0200
Message-ID: <22937f20-93fd-4ae2-a5cb-31e5a477ac37@gmx.de>
Date: Fri, 10 May 2024 19:38:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvM5SKIObVOLAeidcXB2jTJIhDe9MC097JNe9+0mhy+IhwUw9m4
 Wi66lz/zofhdpEijFL4tcTNIoIyMuK+goEIw8TKf9AfMS2cO+TcuwghbaI2b/QdaD3sWTxy
 +mIGKWNPpuuDRJPQzrWj60LHsa5u0DdiFC8M7aacMtjDz7A8VM9VfLxTesnk6uEB870zf78
 L5UepzfbOvVhWX0yoUoSA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1K6PtlAGIfw=;2BcAVPpb1fvsHbnQxxUrenpuOAx
 EQ5BFX3d+fsO+xwVpINiKqlaB8f4dQSg7CZPlEqsBOcisrYkhn7IuCaqaAvchgH9lWcur2J5B
 EYEGuGse3/4cBxkLzsaiqsCanyfnvE+hHqTeXYrTTDNJS5/9tIpydZH0kU1uOshWcDYR4kS2k
 w9DYDqo6KiiqU0fJlnn4RiafWCuHcJM5LF11E56YWWhrWP9VoeTzqOZLPm9USfrP0qt0DMRyM
 1QZMohlboSAf/sfZDqu0vB0dCNCH6owBUhP7PnW1WSs2mIDXZBlIaHbDSbHKzTtdyihymAmm3
 xYhQYOWMVebi4zlpotf8/k7Q/CBt/F74al35DdRmzN2+6iG0+CqSJWOQOY5sgRzjImKJLNOnG
 JE52jAUZQq2zutaFFtaDmGPrf1DlXtf/siFBluH6eFTJhAlPS4aP6+M9pxUKEnetVbQUfWiA1
 BZ1KXcw2VLLKhymPVbvcHO6mFcvUOscmaX0RdmLdTeW72OGigCbgKpRG+d7UalA57ruuYMm/K
 SKHwnd1CdxW3AbD8ul8bmFYDOqTNRLf7GaFYE7XVHSUqjvevA85u+UZAxo0RU+kHlIW620h5y
 K6fHnacNELWzasFy/e4O/LC2iPjXYx3PCUEGTgxPzthvlEcDHCryJT+Uu5+LebUu1Pb+iKzjB
 Wt/C/ytF89IWXk32ns5lJ6ExoETiQ6T+DxPe77IwvQ+Fniy7tsSLlKrjFalzYF7Tv+uWjDvYW
 qP7eukc7oQBwGhpFAjUIjVNpMZxDKR8DR3JNDwhuGbXJ/kmKZNIi3Z9hiT8QIZP53coWHTGp2
 IB6icSkdXNb0cifCCU8lqvxK62J86SXHsCX2UhxDpJsO4=

Am 10.05.24 um 19:29 schrieb Andy Shevchenko:

> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>>> On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>>>
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on Leno=
vo
>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC addr=
ess
>>>>> space:
>>>>>
>>>>>     ACPI Error: No handler for Region [ECSI] (000000007b8176ee) [Emb=
eddedControl] (20230628/evregion-130)
>>>>>
>>>>> This happens because the EC driver only registers the EC address spa=
ce
>>>>> handler for operation regions defined in the EC device scope of the
>>>>> ACPI namespace while the operation region being accessed by the _DSM
>>>>> in question is located beyond that scope.
>>>>>
>>>>> To address this, modify the ACPI EC driver to install the EC address
>>>>> space handler at the root of the ACPI namespace.
>>>>>
>>>>> Note that this change is consistent with some examples in the ACPI
>>>>> specification in which EC operation regions located outside the EC
>>>>> device scope are used (for example, see Section 9.17.15 in ACPI 6.5)=
,
>>>>> so the current behavior of the EC driver is arguably questionable.
>>>> Hi,
>>>>
>>>> the patch itself looks good to me, but i wonder what happens if multi=
ple
>>>> ACPI EC devices are present. How would we handle such a situation?
>>> I'm wondering if this is a theoretical question or do you have any
>>> existing or planned systems in mind?
>>>
>>> ec_read(), ec_write() and ec_transaction() use only the first EC that
>>> has been found anyway.
>> Its a theoretical question, i do not know of any systems which have mor=
e than
>> one ACPI EC device.
> The specification is clear about this case in the "ACPI Embedded Control=
ler
> Interface Specification":
>
>   "The ACPI standard supports multiple embedded controllers in a system,
>    each with its own resources. Each embedded controller has a flat
>    byte-addressable I/O space, currently defined as 256 bytes."
>
> However, I haven't checked deeper, so it might be a leftover in the docu=
mentation.
>
> The OperationRegion() has no reference to the EC (or in general, device)=
 which
> we need to speak to. The only possibility to declare OpRegion() for the =
second+
> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI specif=
ication
> supports 2+ ECs, it doesn't support OpRegion():s for them under the same
> RegionSpace.
>
> That said, the commit message might be extended to summarize this, but a=
t
> the same time I see no way how this series can break anything even in 2+=
 ECs
> environments.

Consider the following execution flow when the second EC probes:

1. acpi_install_address_space_handler_no_reg() fails with AE_ALREADY_EXIST=
S since the first EC
has already installed a handler at ACPI_ROOT_OBJECT.

2. ec_install_handlers() fails with -ENODEV.

3. acpi_ec_setup() fails with -ENODEV.

4. acpi_ec_add() fails with -ENODEV.

5. Probe of seconds EC fails with -ENODEV.

This might cause problems if the second EC is supposed to for example hand=
le EC query events.
Of course if we only support a single EC, then this situation cannot happe=
n.

>> This patch would prevent any ACPI ECs other than the first one from pro=
bing,
>> since they would fail to register their address space handler.
>> I am just curious if/how we want to handle such situations.

