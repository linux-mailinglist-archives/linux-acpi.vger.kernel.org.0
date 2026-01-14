Return-Path: <linux-acpi+bounces-20351-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B94D21B68
	for <lists+linux-acpi@lfdr.de>; Thu, 15 Jan 2026 00:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87DB4305BC10
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 23:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A894E37FF41;
	Wed, 14 Jan 2026 23:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="LJb19cO1"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A43491C4;
	Wed, 14 Jan 2026 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768432069; cv=pass; b=NiBiWeuuh1mrHYbNiWpX9OgnsMO0dbzezW2KomD6GLIMrgR/MVIkTZeXKgCRDeN7hPVWbk4GDdV876TMq783RXwPP2Ru200vK6k3+4Ec+F5Av1ZJ1o1avSY6uPW8kD8NTpRxBgagDc7ocfa4M/x0CF6hISGZxKLKXKvTl3lOXO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768432069; c=relaxed/simple;
	bh=CZ9IMoQtCnYTdn07wiZEQD3T5FlVNCbhwRM6TXK3Syc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQ0++TcEBVSJ8a1upVUALObLoOIAwPAQXiSvtFfa1coyh3OF/F3Z0lBabnRGnuAXJ3ujV6Jsomq9Mi9W34CYsaO5gdINfBpPXOczSlMNVt/ge/ah9igHf6om8Q38ctyt6qoV6SRzgkgy9aCFOiPQyTw2sfTBx+80r5/NPhbL1RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=LJb19cO1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768432030; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bMCEdjEeapgBTJyI6Q9BkUPgs+kBDzYqmMuNtQJIDt/5YFlvYMAJQ3xuIN8lBqBZa+eydUkE2pNBznzYbFyDjEmCJZTkdniN8Q+D0GlzxaOm3EE7PJCWO3u+UQaQkY6zEpJy0SKxLOl64p1o/M5ZWFG1LqCj3xCUpp3Tr24fELA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768432030; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FP517vtOn/TRrkvUVs7gNtlZQ6ICZ89eoWPe/eRoqJU=; 
	b=Hc8ud0v5RJaitNv7SqgRg1u86o566XFUJCfbKaIEHrulL5okbUEdCra62M7RLJF2GW2KMyj5gIJRJzwRJf/0qxtA25nQbtS1PIPWr9CX0e6cRahhOmJtPQRVljHJTXSxeTDf3v/qKa+HrUZASKGmXo2XmML7qhzDXRAj+bJsiDQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768432030;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=FP517vtOn/TRrkvUVs7gNtlZQ6ICZ89eoWPe/eRoqJU=;
	b=LJb19cO1zlGooN53wzuZsRm6hSbV4fxfDtkDfpqMrZQ7yRtsDgIFOdxJDgebGyiZ
	b3bsPiGl/VVwctMMnW4ASpi3Hn5XjBhLz2JU4oNCKIkxjX6LpkTmT/epif7JOp9r5Tj
	63uG1BbVvH+bXDgTn+qaIJ4SXnghPf84RohK3aRs=
Received: by mx.zohomail.com with SMTPS id 1768432028823622.7960735171055;
	Wed, 14 Jan 2026 15:07:08 -0800 (PST)
Message-ID: <ab4d90d8-3212-4571-9f92-ac4facd3aa33@collabora.com>
Date: Thu, 15 Jan 2026 02:07:02 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/8] acpi/x86: s2idle: Introduce and implement runtime
 standby ABI for ACPI s0ix platforms
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: bob.beckett@collabora.com, bookeldor@gmail.com, hadess@hadess.net,
 jaap@haitsma.org, kernel@collabora.com, lennart@poettering.net,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, mccann@jhu.edu,
 rafael@kernel.org, richard@hughsie.com, sebastian.reichel@collabora.com,
 superm1@kernel.org, systemd-devel@lists.freedesktop.org,
 xaver.hugl@gmail.com, John Schoenick <johns@valvesoftware.com>
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
 <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
 <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <CAGwozwHLkL5xAXzaKoTyLCGzNjjHUf+bNu8qo+-Tpex7NK6=GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 1/13/26 13:11, Antheas Kapenekakis wrote:
> On Tue, 13 Jan 2026 at 11:50, Dmitry Osipenko
> <dmitry.osipenko@collabora.com> wrote:
>>
>> Hello,
>>
>> On 1/12/26 23:33, Antheas Kapenekakis wrote:
>>> On Fri, 26 Dec 2025 at 12:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>>>
>>>> This series introduces a new runtime standby ABI to allow firing Modern
>>>> Standby firmware notifications that modify hardware appearance from userspace
>>>> without suspending the kernel. This allows userspace to set the inactivity
>>>> state of the device so that it looks like it is asleep (e.g., flashing the
>>>> power button) while still being able to perform basic computations.
>>>>
>>>> snip
>>>>
>>>> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
>>>> --
>>>> 2.52.0
>>>>
>>>
>>> Happy new year everyone
>>>
>>> Small bump on this as all of us are starting to get back from holidays
>>>
>>> I still have to bump an asus series before I get back to this. I would
>>> appreciate some feedback in the interim.
>>>
>>> I think targeting 6.20/7.0? is unrealistic so there is no rush from my side
>>>
>>> Antheas
>>
>> Thanks a lot for sending these patches! I briefly looked through them
>> last week and will make another iteration soon.
> 
> Hi Dmitry,
> can you expand a bit on your use-case/KPIs/timeline for your series?
> 
> Is it handhelds/laptops or what is the intended use-case?
> 
> [2] before the rewrite had been tested on most handheld makes and SKUs
> (over 70 models) and laptop manufacturers and it performs as expected.
> As it is multiple months of research I'd like to get some credit for it.
> 
> Happy to collaborate in any case, especially if you will log hours on
> this and can push a variant through faster. I am not sure if starting
> from scratch is worthwhile for either of us

The primary goal is to support screen-off DSM for a power-efficient
background games downloading [1] and further resume-to-dark on Steam
Deck and other handhelds. There is no strict timeline, usual "sooner the
better". Downstreams will use customized WIP solution till upstream will
get necessary generic interfaces.

[1] https://store.steampowered.com/news/app/1675200/view/771930569635267984

A common approach for upstreaming is to divide problem into smaller
manageable parts. That's what I'm planning to focus on now to see if we
can start easy with a minimal changes.

Please don't worry about the credit. You did a significant ground work
that is well recognized by now. Thanks a lot for your efforts and help.
Starting from scratch of course won't be a good approach with all the
broad testing you've done.

-- 
Best regards,
Dmitry

