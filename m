Return-Path: <linux-acpi+bounces-17097-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370FB82627
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 02:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD34321818
	for <lists+linux-acpi@lfdr.de>; Thu, 18 Sep 2025 00:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6800F18DB26;
	Thu, 18 Sep 2025 00:36:42 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557E7155C88;
	Thu, 18 Sep 2025 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155802; cv=none; b=iAo+FHdGctq+j5/30tXFf4rT6MP11VcXvZlEY17PSUAfqSh65WE3tY/fRbRcKhMawLgntbJFYFSgTib6aSRS4z99SA0CYhygJKVnAVty+jBb1OtvyvB/JTZ4tXIZ8tQG28nGP9LXtRtBIJChNyOWS6006kFSberaN1ukhkXaIG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155802; c=relaxed/simple;
	bh=UayNBM1GmpR7o1Us1R3d49EZMYhUj8lOlbjWmlvGO98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p58P7Dccq+LltaTknNbo5m7X/3SJzQcX9p3GXjrSI/IPXxX+wFpAsn4yM/JafIq0OYXhGURZHmKwZ/fAKnSPGHNOxZFLBR1lQYMTXehQv3sAdbqlJ8Ash3me/kOhZ/luzL6koP3Wk0v+Cr6fXiR+vYY45QZgqBXbzszlz6Uk33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 86760ac8942711f0b29709d653e92f7d-20250918
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:2640ed47-cee0-4871-a8ca-e0afd6265c47,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:7533c8c04f92634043e68b07df599b37,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 86760ac8942711f0b29709d653e92f7d-20250918
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1301637609; Thu, 18 Sep 2025 08:36:32 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A7C82E009009;
	Thu, 18 Sep 2025 08:36:32 +0800 (CST)
X-ns-mid: postfix-68CB5410-860761
Received: from [172.25.120.24] (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5C8BFE009008;
	Thu, 18 Sep 2025 08:36:31 +0800 (CST)
Message-ID: <f6afc998-f11e-4aac-a190-fbadb97e2d0c@kylinos.cn>
Date: Thu, 18 Sep 2025 08:36:30 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
To: hansg@kernel.org
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, mario.limonciello@amd.com, rafael@kernel.org,
 stable@vger.kernel.org
References: <17cc74d6-2e49-4370-ae37-39cddfe67d7d@kernel.org>
 <20250912103538.3657242-1-zhangzihuan@kylinos.cn>
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
In-Reply-To: <20250912103538.3657242-1-zhangzihuan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/9/12 18:35, Zihuan Zhang =E5=86=99=E9=81=93:
>> 1. There must be a GPU driver for these laptops somewhere?
>> Even if out of tree using a laptop without a GPU these days
>> just does not give a good user experience. So fix the GPU
>> driver to call acpi_video_register_backlight().
>>
>> Note acpi_video_register_backlight() is deliberately exported
>> without requiring the consuming out of tree kernel module to
>> be GPL to allow this.
>>
>> Other options would be:
>>
>> 2. Add some special heuristics for Zhaoxin CPUs,
>> the kernel already has a CPUID match mechanism for
>> things like this. This could potentially be combined
>> with a DMI system-vendor check to only do this special
>> case handling on e.g. Lenovo and Inspur laptops.
>>
>> 3. Instead of adding the CPU-id based special case
>> just outright use DMI quirks. In this case lets try
>> to use substring matches to cover multiple models
>> with a single entry so as to not grow the quirk
>> table too much.
>
> Got it, thanks!
>
> In fact, we have tried a few approaches (cmdline option, CPU-ID based q=
uirk, and DMI quirk),
> and all of them work.
> I will sync this information with Zhaoxin to see which way they prefer.

Zhaoxin has confirmed that they will handle this through their own GPU=20
driver,

so we don=E2=80=99t need to take any additional actions on our side.

Thanks!



