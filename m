Return-Path: <linux-acpi+bounces-15625-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB6AB23BE3
	for <lists+linux-acpi@lfdr.de>; Wed, 13 Aug 2025 00:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B988E1883BEE
	for <lists+linux-acpi@lfdr.de>; Tue, 12 Aug 2025 22:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63FA280308;
	Tue, 12 Aug 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gdlUCr3b"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F308A2F0693;
	Tue, 12 Aug 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755037634; cv=none; b=dyArimnlXGDIgKUwwROhcYquWZsaHj4ljctnju+8Md60IZmLvWHj7iryJS940An0BmmU4nQqH0c5RDS+LJ+Cl3W/irQSN+Bh4HRL6DTQpoRXf9f1pG/JquukdlYEjXzFQUfOlDcE0PKoj3jE6TdWlsnuP0hV2o8Vi5wwC2goOiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755037634; c=relaxed/simple;
	bh=VY5Ka5lKFTywN1joTNL4CpA9sajHibbkhU+nf4Nd58Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XR2B5FCdH0rTkT5SgNzgMYZghF+qR6a05O8JFutbRThYsVFVUky924Qrf0y1TBsDtip1lZEXdEShEz5qDjW1CAQJasnPTT1D5E0SffhdG9RwYD0MccZ5hvteuOpOWaxQQq8n9BaAWuqxJN3NdMwj+x/jImFF6rptMWFwaHoWD78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gdlUCr3b; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1755037629; x=1755642429; i=w_armin@gmx.de;
	bh=Yo83TFZryGsnrgCIpOREWBxoCr1jDrR7cTvv7FC/rog=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gdlUCr3b6ehbTxWu/onnomcGps346w3/HYKOquxASqSuXAexWBfztSTndpqsH7F7
	 /vOx6yhAtjbBouahNsw8K5BSYmfMGnxGOepGvVPGSdxfnbn48OQSCm0PhsL8ZTHKa
	 plJTfSTZyQYujPkZ8kANsZTNftxPPZgFuYIvwwCe48X9xMowV4hmGrPFUfoE/cwSl
	 FEAS1wYNpUYZsDxa8JEbGWLqCKk9hxVtcbwUZ8JWm0gz88ZM7DZbMS7B30JSC4xQD
	 63KEoNeiTmSZ0scqqFuLLqtsG5/tEV0mhEqlIL0pWvwssf48170uO6LMb6VNWiKvR
	 42oPL2hKNXlX+nVF7Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([91.14.231.131]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbAcs-1uAPiP0v6m-00dQxo; Wed, 13
 Aug 2025 00:27:09 +0200
Message-ID: <f4de859e-3cbc-403b-b9da-12a426ba6a74@gmx.de>
Date: Wed, 13 Aug 2025 00:27:08 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Ilya K <me@0upti.me>, "Rafael J. Wysocki" <rafael@kernel.org>,
 lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <CAJZ5v0g0vjP_ST2xnDnFAmDXKR9oPn5t0sfQqamDCNwUjJt-xg@mail.gmail.com>
 <d8c3432f-dfb7-4263-a556-2d93f22e618e@0upti.me>
 <2025081246-raft-tattle-642c@gregkh>
 <4e610854-d84c-4a59-9f83-422eafb40d6e@gmx.de>
 <2025081227-humpback-garden-7a4b@gregkh>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2025081227-humpback-garden-7a4b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:yXmBsPSJEVg1N3/Ko18xp0wSy9HGuahKqkrItLUPFjtzZ698fY7
 IDYH+poOERKD6AclGlMvvpphA4/MuRAFo6FRXvIiRlNnWEieSFyqy5yYf/D0WJ9CGkLLwi/
 VXcn/bzIk62sYPqzvc62b7q+XpxaPPSKCwTT4e4kaxpDEFO8kKFi36f4Iubjqj0bTKDEFeE
 V5NWBBJDryWgkwVOjjxMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WArHKKeKQNg=;TjMIHUYIY/8xW+d5p1g72XGq07H
 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
 VKGeAIYCA8u14aIZrAkA==

Am 12.08.25 um 19:10 schrieb Greg KH:

> On Tue, Aug 12, 2025 at 06:54:39PM +0200, Armin Wolf wrote:
>> Am 12.08.25 um 18:40 schrieb Greg KH:
>>
>>> On Tue, Aug 12, 2025 at 06:51:10PM +0300, Ilya K wrote:
>>>> On 2025-08-12 16:32, Rafael J. Wysocki wrote:
>>>>> Applied as 6.17-rc material and sorry for the delay (I was offline).
>>>>>
>>>>> Thanks!
>>>> Thanks!
>>>>
>>>> Tagging stable@ so we're hopefully in time for 6.16.1.
>>> <formletter>
>>>
>>> This is not the correct way to submit patches for inclusion in the
>>> stable kernel tree.  Please read:
>>>       https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
>>> for how to do this properly.
>>>
>>> </formletter>
>> Agree.
>>
>> AFAIK the Fixes: tag should be enough to ensure that this patch gets included
>> in the affected stable kernels.
> Not at all!
>
> Please read the above link for the full details on how to do this (hint,
> Fixes: will not do it.)
>
> thanks,
>
> greg k-h

Oops, seems that i missed something rather significant about the stable kernels.
I will give keep that in mind when sending future patches.

Thanks,
Armin Wolf


