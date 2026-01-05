Return-Path: <linux-acpi+bounces-19958-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D866CCF4DAB
	for <lists+linux-acpi@lfdr.de>; Mon, 05 Jan 2026 17:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7DD315EE9C
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Jan 2026 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB602C0F97;
	Mon,  5 Jan 2026 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bfKFECZ9"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC52E242D86;
	Mon,  5 Jan 2026 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631634; cv=none; b=ZYBlhvc7TJqooUB0TwVol0Jx8Ifr5N2ZN/LcaW4rrNkdAsRnAG9sHy0DYK6l6InyEup2sZMIjsVrMSt62VtkpdeJjzYk8FoXSQJSBWv3gtyL+ueL3g8poQCPOnwwAuZyfgsLjB4X8Pm5ZM3DIn22GD1AvBAfDI14e+ga+2PWxJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631634; c=relaxed/simple;
	bh=YqcF/TcQVcyjB+TyfnqaxRbsAMM8Ru/KYlMCd80b4z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iD8qjVvNXPlEBlPxu/4DScSEKVpT0GLPGoueulw97hWyKWlUbjVqFBoIcKsqm4x0D1KGvMKB/NmY8CbxsRv7LskJGZ+ukQ97FY0OocKAwnbmrMbXFBsccJK6fBnB3weyULLPtH2Dy3m+yznqI9O+GGH5/9ebO8AEKlgxwWrYrJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bfKFECZ9; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1767631629; x=1768236429; i=w_armin@gmx.de;
	bh=YqcF/TcQVcyjB+TyfnqaxRbsAMM8Ru/KYlMCd80b4z0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bfKFECZ9VsFCfct5HmdelCpIWZp86Ijw5DBvPf+VMXdV84aLMYPppA2VEZzEdCcB
	 U2lRovdq1QCX8WMZplqXc6wCO5Yk/rcXHCM76xXyrJm/fz+tYp6IwhVkIAy5w6NyC
	 0l3LoJBEhl+xNfwOJd00IsWzvF2NdbpdGa/wdk51qCD1mDZGlpglZjId7Sl0A6yBg
	 aZFgsbjdaEmWbtQ0cRHGay+sIKwMz2aMFfcFzABi6eqIZ4X13wmKsYvqI9bD4reTR
	 2wn9hMBkXOrFdIwknJIv29/eOp9R2wpwOOBWx+7+1QdNyvoEqS8x0XMkJyVEx8L8C
	 RHODUXkufmDjYVGiIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KTy-1w2PL50s4I-015WCb; Mon, 05
 Jan 2026 17:47:09 +0100
Message-ID: <c430ba2f-5737-44c3-af6e-f79d15625f17@gmx.de>
Date: Mon, 5 Jan 2026 17:47:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: Documentation: driver-api: Disapprove of using
 ACPI drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
 Hans de Goede <hansg@kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, Danilo Krummrich <dakr@kernel.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
References: <5977355.DvuYhMxLoT@rafael.j.wysocki>
 <2026010553-capable-chip-88d7@gregkh> <aVvd0eYC7Qs5_ZdD@smile.fi.intel.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <aVvd0eYC7Qs5_ZdD@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:IHDx8FS7YoHfe5Sd2vx2we0FJ9kvGfDRzErUeYwsX8oH4kPsy+O
 olzSXzv5tAX21HHgZpoJ7ogKI0S5LvoDdQp3km9Po3LOBAeva0ASESklx9lwb4zPdRlUX3U
 UYkZNk872JpPpO1qKYDFqTkSJLoOjRj5pMK/jpgc0Ltn+Kb5uShNx3+/ejY4oyy9fL/U35f
 nj7AvourJY4774VYDeupw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ohMeQvr3VEQ=;ICn7pZf5l1C10N/bV/Kp12rxaxh
 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

Am 05.01.26 um 16:50 schrieb Andy Shevchenko:

> On Mon, Jan 05, 2026 at 02:47:30PM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Jan 05, 2026 at 12:25:04PM +0100, Rafael J. Wysocki wrote:
>> Documenting this is fine, but really, just moving all of the existing
>> drivers to not use this and deleting the api entirely might be simplest.
>> Looks like the only "new" acpi drivers that show up are in the
>> platform/x86/ subsystem, so just tell the maintainers there not to take
>> any new ones?
> I believe that with or without documentation this will take a few cycles
> to get rid of (as there are more than just the PDx86 being involved as of
> today). Also there were (and might be in the future) a few attempts to convert
> in the opposite direction, i.e. from platform to ACPI driver. Doing something
> temporary for a few cycles is okay, no? From my point of view it helps avoiding
> the above mentioned cases.

I agree with that. Additionally, there might be out-of-tree ACPI drivers that
people might want to upstream, so having this piece of documentation might give
them a hint that ACPI drivers are going to disappear in the future.

Thanks,
Armin Wolf


