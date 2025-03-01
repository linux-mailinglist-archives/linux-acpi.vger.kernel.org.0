Return-Path: <linux-acpi+bounces-11666-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFCFA4AB4F
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 14:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C4911897181
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Mar 2025 13:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C061DED79;
	Sat,  1 Mar 2025 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dtGMaeWx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5748B249F9;
	Sat,  1 Mar 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740836668; cv=none; b=r71r8I4cLQ2szgBmsWi2HhHRbI0BRKJ1kVU1Ftri8gb1PnEME4JSzD4Sb3VWQVvx6n2g5SKydSm13nqIncJymq+wAqMFCSfKvZGHfocnJW5EJokLoufURZ4EqG3fwuL54rCUVLyH4MifhoiP0oBule7fi022wX7uId8tWjjUIfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740836668; c=relaxed/simple;
	bh=h3vHCIfVJCCiGkV7ISSfFTxz68bVIJF5cI8rPcNKEfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QTpA1fvyqMJeBWi0KMa9deyV7ku8VZ6PlazJcus/IoC/b062cT4Tx+9rCzGA1pFrcp37pvprNn3DcBiNm1v+8JuaXowHtbXwz0Gxm64XjM0R0IJkP0tiMtAUiv+SDoUxEuqRm4zFJGHBmQQMiiRVfADqKSvXx4NDIE481z6YHeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dtGMaeWx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E3C4CEDD;
	Sat,  1 Mar 2025 13:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740836667;
	bh=h3vHCIfVJCCiGkV7ISSfFTxz68bVIJF5cI8rPcNKEfQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dtGMaeWxRw/bUxZICtcCiHwvZ6y+JJbyEy7vw+G8k6kP0BZqRODyzofXBo887J6Yq
	 8bmppSvXlJLHuVjQTz5dXgV/eKz1JVt/ffPP2DMQIzXh8zl5Tee4NX63IuhmrjTVmU
	 qWGXGKt8hGryaIUdy0tYU2ww9iz4ldtIKB1LIdeSSGDQz1bo/D6h4cNrcNZCbGx7g6
	 gHXtC/uV59msiLVt0+KzNm23vMmrla+UdWDdXx4l9D/cjbrvyiYBO+ns53Eu+GFPhu
	 5WgQXG5UUOMkbMWRB16cC902aD8zB9I07R0WVVKeYMfnKNKc8gJXZvSzLbmNaJxoyG
	 Q5wR+ll3hm23g==
Message-ID: <8ae80eef-ce73-401a-97ae-cc62416bd2a7@kernel.org>
Date: Sat, 1 Mar 2025 07:44:22 -0600
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for hidden choices to platform_profile
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Hans de Goede
 <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Luke D . Jones" <luke@ljones.dev>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "open list:AMD PMF DRIVER" <platform-driver-x86@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>, me@kylegospodneti.ch,
 Denis Benato <benato.denis96@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20250228170155.2623386-1-superm1@kernel.org>
 <CAGwozwFoqUPiZjozj5MHV5-4dVF3Ef0Wy-Sn5v38keHp2BfStQ@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAGwozwFoqUPiZjozj5MHV5-4dVF3Ef0Wy-Sn5v38keHp2BfStQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/1/25 05:09, Antheas Kapenekakis wrote:
> I just tested this. The behavior of this patch series matches mine
> 1-1. Feel free to add a tested-by.

I understand your intent, but can you please explicitly type out your 
tag?  This is especially important because maintainers often use 'b4' to 
pull all tags out of an email thread when accepting patches.

> 
> IMO it is a bit cleaner/thought through than my series, so I am fine
> with dropping mine. Should be as it is essentially a V3
> 
> 

<strip>

Also; Rafael mentioned this in another thread, but please refrain from 
top posting when possible [1].

[1] 
https://www.kernel.org/doc/html/v6.14-rc4/process/submitting-patches.html#use-trimmed-interleaved-replies-in-email-discussions

