Return-Path: <linux-acpi+bounces-20226-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F9BD17CD1
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 10:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9758D3029231
	for <lists+linux-acpi@lfdr.de>; Tue, 13 Jan 2026 09:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B691A38759F;
	Tue, 13 Jan 2026 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="ZYtP2zTx"
X-Original-To: linux-acpi@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAE938737E;
	Tue, 13 Jan 2026 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768297805; cv=pass; b=Dac3iToYLU0u6r2U+pfZHajqpH7dGN134cqdcWJovCIgOM37uYeddD8vVwRYVFaV5RJkQjar6RG5RsZROsCu85KuwGqtXMB7Nj+3VIbRRRpyYKocy0zJIIvZ8PVGUyu9pFKqqF+1zly234Or8FgNYz6JhSycjETAopPH8bDmYYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768297805; c=relaxed/simple;
	bh=wuXajAGowgi5U3DXm9AjydnuH+sqFHt9l+ZChdc5DCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFALJR0pVJ90rNpuT0FrrkFE0spFFeUjdtJThCExHjVoOsDLHY1kf1gVQoCLyjLrQtof7GejSCqR3uT6+IrkdMVg3O/tr7gZgUjJZFVnU0om9uHVPIr1S2VSFsoUEEIivBCt4WP8cz0yUGaLTodEhx13ALHwFtSKrW6q6kTvo24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=ZYtP2zTx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1768297718; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YwE3iL6Z0ME5dya9SWhhcVUdXHNc5mU/kHT2Tqew8J4PCs3nq3kdzS1igur7gJktEAUyLiEyLMJW/eofPSYIH6KI0uW35NUSVkpZh4s3EC7u9/0SufTMC8rvTrRT7M10fQWE073xTTIFwIKR9y77Q7URjwMRjoEiXDTNBnjfhuU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768297718; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=m9pQUtdurL/byPhHYPtKhF+HGgJbwhZPH74kgDHJKBA=; 
	b=TNPJHU8EdnHvuCxmJRakCjg32wqbHz0dqQ42SsS9EzrtI2kL1xtlMnM/VMCb/bylGzsWWjmvjJVyXqa8qeHEdY53lGd/yN7cZodALkIMt13UEmMXSIJjo+dq/ZrOy3MJ7vuQASvX3HNQCRQgrEwZ2YIvsTWYez5hQY1t52dmcbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768297718;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=m9pQUtdurL/byPhHYPtKhF+HGgJbwhZPH74kgDHJKBA=;
	b=ZYtP2zTx67zhQIfTBDuQCHwUH3L+jimMh5wFL05bfb7K8lpEbD3+7lZZgBRxYo9B
	yBwzeNPzSp+EqXzDcizSMOQAGuOzKIe+JiXNuCSmlK6weyy2rsQdTEgU0f1uKziIfv1
	drNSpYVzqljVL5FC7YODzjb4vUE6d5GdfM2l+o1g=
Received: by mx.zohomail.com with SMTPS id 1768297716376552.1985088181589;
	Tue, 13 Jan 2026 01:48:36 -0800 (PST)
Message-ID: <3ca00958-13e5-4732-b500-aa9673a4c965@collabora.com>
Date: Tue, 13 Jan 2026 12:48:30 +0300
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
 superm1@kernel.org, systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
References: <20251226102656.6296-1-lkml@antheas.dev>
 <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <CAGwozwF5wsb8pYmHj5G0uTfr+3vx+HhrfOR9t-pEGPw-jjvbHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hello,

On 1/12/26 23:33, Antheas Kapenekakis wrote:
> On Fri, 26 Dec 2025 at 12:27, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>>
>> This series introduces a new runtime standby ABI to allow firing Modern
>> Standby firmware notifications that modify hardware appearance from userspace
>> without suspending the kernel. This allows userspace to set the inactivity
>> state of the device so that it looks like it is asleep (e.g., flashing the
>> power button) while still being able to perform basic computations.
>>
>> snip
>>
>> base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
>> --
>> 2.52.0
>>
> 
> Happy new year everyone
> 
> Small bump on this as all of us are starting to get back from holidays
> 
> I still have to bump an asus series before I get back to this. I would
> appreciate some feedback in the interim.
> 
> I think targeting 6.20/7.0? is unrealistic so there is no rush from my side
> 
> Antheas

Thanks a lot for sending these patches! I briefly looked through them
last week and will make another iteration soon.

-- 
Best regards,
Dmitry

