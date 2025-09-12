Return-Path: <linux-acpi+bounces-16695-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B1B53FAD
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 03:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C2DC5A182E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 01:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383FD54791;
	Fri, 12 Sep 2025 01:11:17 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEDE168BD;
	Fri, 12 Sep 2025 01:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757639477; cv=none; b=CejFA6Drgu6Mxzu3m1oPNyA4dk0yJi4V9dOgLkNMITOh4YIogK+QyGeG5ko07x7E7T9CS52nvRf1pt+TA6nz3AIvuWaBYSwzsXjfQopeGNGqTyN3YD5qxGc+FSPeO7I9zEaxSX+rOdQFO9JOYVHKUHfRt8mGGzkQUk32EBT6faA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757639477; c=relaxed/simple;
	bh=vV9IcXnxbwOyZ8l1SQmnYpbR2lc+Z9Ae+far9EGwBBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NqXYUC//auVqiNTJ+EdqDDSh7G0uQLFSZHAHTP9NuG59S9QuuLqXfWKmj89hNsgo2wqqw3EEgAOB8pS77Z0GKKhbvd0ydKCWe5kC9CD5q4GBgR1tbc2Tu1cNR+vZxNlXMgf7v3Y4pnZPouWHsf+EaCPPyE6Y9hGr55rhdvU3MGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c0e01c08f7511f0b29709d653e92f7d-20250912
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:d7750f67-295c-450f-86ba-968d43d9bad1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:ef6f51f2fe3759adf93d1299e6ece788,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c0e01c08f7511f0b29709d653e92f7d-20250912
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1210366386; Fri, 12 Sep 2025 09:11:06 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 7E747E009007;
	Fri, 12 Sep 2025 09:11:06 +0800 (CST)
X-ns-mid: postfix-68C3732A-41695370
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8C08CE009007;
	Fri, 12 Sep 2025 09:11:05 +0800 (CST)
Message-ID: <365c42f5-56a1-4a2c-9244-7943c3600fa2@kylinos.cn>
Date: Fri, 12 Sep 2025 09:11:04 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
To: Hans de Goede <hansg@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 stable@vger.kernel.org
References: <de4b5ec6-1e42-44b8-b5d3-5a452d7401ef@kernel.org>
 <20250911074543.106620-1-zhangzihuan@kylinos.cn>
 <ae7b139f-dc25-413d-bfc3-3be187ab3a73@kernel.org>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <ae7b139f-dc25-413d-bfc3-3be187ab3a73@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/11 18:38, Hans de Goede =E5=86=99=E9=81=93:
> Hi Zihuan,
>
> On 11-Sep-25 9:45 AM,  Zhang wrote:
>
> ...
>
>>>   So as you say the issue is that you have no native GPU driver calli=
ng
>>>   acpi_video_register_backlight().
>> I'm very happy that you got it.
>>
>>> First of all I assume that there is some sort of builtin GPU on these
>>> Lenovo and Inspur machines with Zhaoxin CPUs. Even if the GPU driver
>>> is not in the mainline kernel then I assume there is some out of tree
>>> driver. Can that driver not call acpi_video_register_backlight() ?
>> We are currently working with Zhaoxin on this matter, and we expect to=
 have some results in a few days.
>> I will keep you updated once we have progress.
> Ok.
>
> ...
>
>> Thanks a lot for your patch and for looking into this issue.
> You're welcome.
>
>> At the moment, we are still confirming with Zhaoxin whether this behav=
ior is consistent across all their platforms,
>> so we are not sure if the special handling should always apply.
>>
>> Also, on kernel 5.4 these machines seem to work fine without requiring=
 a native GPU driver, while on 6.6+ the backlight node is missing.
>> Could you please clarify what design change or intention caused this b=
ehavioral difference between 5.4 and newer kernels?
> The main problem is that on x86 laptops there are too much different
> ways to control the backlight:
>
> enum acpi_backlight_type {
>          acpi_backlight_undef =3D -1,
>          acpi_backlight_none =3D 0,
>          acpi_backlight_video,
>          acpi_backlight_vendor,
>          acpi_backlight_native,
>          acpi_backlight_nvidia_wmi_ec,
>          acpi_backlight_apple_gmux,
>          acpi_backlight_dell_uart,
> };
>
> With video, vendor and native all 3 being quite normal to have
> around on a single laptop.
>
> A long time ago the kernel just used to register all
> backlight handlers for which there seemed to be support,
> so "ls /sys/class/backlight" would e.g. output:
>
> acpi_video0
> intel_backlight
> dell_laptop
>
> And then userspace would pick one to use, typically
> checking for different backlight types (raw/platform/firmware)
> in descending order of preference and picking the first
> backlight interface matching the highest preference type.
>
> But even though multiple types may be advertised by
> the firmware, they do not necessarily actually work.
>
> So the simple userspace pick based on preferred type
> solution did not work on all laptop models and
> drivers/acpi/video_detect.c starting growing heuristics
> + quirks to let the kernel pick one and hide the others.
>
> At first for acpi_video# backlights they would get
> registered and then later if a native backlight
> (e.g. intel_backlight) showed up and the heuristics /
> quirks set that should be preferred then the
> acpi_video# backlight would be unregistered again.
>
> But this is racy (and ugly) and caused issues for userspace
> trying to open the already unregistered backlight.
>
> So the code was changed to delay registering the
> acpi_video backlights till after the GPU driver has
> loaded so that it is known if native backlight
> control is supported or not.
>
> Long story short: The design goal is to only
> register 1 backlight handler, so that userspace
> does not has to guess and to only register this
> once and not do a register + unregister dance
> of a potentially unwanted acpi_video backlight.


Thank you for the very detailed explanation!

One concern, however, is that the current approach seems to assume the=20
presence of a GPU driver, which may not always be the case. Would it be=20
possible to consider a more generic fallback?


For example, if no GPU driver is available, we could still register the=20
acpi_video backlight node.

 =C2=A0This way we can at least ensure that a backlight device is exposed=
 to=20
userspace instead of leaving the system without any backlight control=20
interface.

Do you think such a fallback could be a reasonable option?

Thanks again for your insights!


> Regards,
>
> Hans
>
>
>

