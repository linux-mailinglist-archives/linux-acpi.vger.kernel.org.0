Return-Path: <linux-acpi+bounces-8007-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02458966225
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 14:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3BC1C21550
	for <lists+linux-acpi@lfdr.de>; Fri, 30 Aug 2024 12:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1AFF1A2842;
	Fri, 30 Aug 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgeGhM3S"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7219ABAA;
	Fri, 30 Aug 2024 12:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022684; cv=none; b=EWrQxq49Sr0Js2PDatwq/JWR5pydb0Ynh2GWF6x7yW+nAjeZ6SZ46lTpGX+15GWHoY1x8ec3CzaSVSFnlmFRsqVn8aoovcbhD5a9CID6t7w5onK9geTWVlKT1uA3Hrb31vSUlryjzEq6BLjocKMcBjCxOYxANkbvn877dBjMjKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022684; c=relaxed/simple;
	bh=pRzr4dw+htikBqyVyR2UfwtO0f/g1Jd6QIJAItLjm9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qr/sRhgmyi/ovRzEzPBVAjYY01JWIQcX9oYTVn/DAXKsvrq5u0DuOELZNWmKAaiMY8d1jvP4fkEYeP/lULB6wPts/dzTLo1cziXYzG2ho6oleeOcgNDxBrSu1J+pu6RwIUXKxhSGiRcsuLBLVpaYUMgGJ1YwfLJkKAKUtlQ140Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgeGhM3S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8EB8C4CEC2;
	Fri, 30 Aug 2024 12:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725022684;
	bh=pRzr4dw+htikBqyVyR2UfwtO0f/g1Jd6QIJAItLjm9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MgeGhM3S5Skkm3/czz9Sb4Q/cLEXI9TleH0U3Vau8IqpzVb/X/pDF1kqKFqwYbimK
	 HNtT7qR9MMOBs7/rPoReRuwDBqSWcQub+lzuzCTUiny9hXVbWJWhHcrx+HH46cUU/1
	 si/G+nON+U61JVnqQY2LTk+1TCnedYwS6voFpwCPblt5H4WNbzBdvDiuyieAjudA46
	 Y4GZ2CJ4UEZ3bnyJecRQp+T7JwEf4eX840m+PRjzx4gHFPqf1Xfy4RbPHcRc6tmqHM
	 g62Vw/9VGJ++mllrkCxjUKe30z5fXiRPRJGGguqj9qa1vYUFxElS23O1hbhP/VdoQ0
	 cPNTshwv7omjA==
Message-ID: <998609e2-0fa4-43e8-9f72-05af40cf62c2@kernel.org>
Date: Fri, 30 Aug 2024 14:57:56 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] platform/surface: Add OF support
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Maximilian Luz <luzmaximilian@gmail.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
 <20240814-topic-sam-v3-3-a84588aad233@quicinc.com>
 <ZszrjQChQ2aS5YjV@surfacebook.localdomain>
 <d08d41ad-edcb-48ad-a848-53edc45ab8eb@gmail.com>
 <CAHp75VcbjR8HQqPASLFEGiyYLfTFQDa6Ri+jFy+7Q1xz7gY39Q@mail.gmail.com>
 <53a56539-1d95-42ac-ad07-1b689702b2ed@gmail.com>
 <CAHp75VdsksKPrj-CwmR4QLBrm_FfaG4aZys-_jnee_L=3ZnRPQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <CAHp75VdsksKPrj-CwmR4QLBrm_FfaG4aZys-_jnee_L=3ZnRPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28.08.2024 9:06 PM, Andy Shevchenko wrote:
> On Wed, Aug 28, 2024 at 8:40 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
>> On 8/28/24 6:56 PM, Andy Shevchenko wrote:
>>> On Wed, Aug 28, 2024 at 12:10 PM Maximilian Luz <luzmaximilian@gmail.com> wrote:
> 
> ...
> 
>>> Yes, and software nodes for DT are quite strange things! Why can't you
>>> simply fix the DT to begin with?
>>
>> For the ARM/DT variants we could do that. But we still have to deal with
>> the x86/ACPI ones here.
> 
> So, then fix it there! Currently it's an abuse of software nodes
> inside the Linux kernel.
> 
>> So for me it makes more sense to have it unified
>> and just deal with everything in this module.
> 
> I understand the desire, but DT is DT and ACPI is ACPI, they are
> different despite having some common APIs in the Linux kernel.
> Moreover, DT has a validation tools and everything, making that being
> a software nodes has at least these disadvantages:
> - no official schema that must be supported and users are known of
> - no validation done
> - bloating of the Linux kernel binary and hence memory footprint

Arguably the last point isn't very strong.. DT also has to store some
strings and pointers to represent devices

> 
>> Also, if we consider that at some point we might get ACPI PEP support (I
>> know, far fetched right now): With that, ACPI on ARM might be feasible
>> and then we'd have to manage the same thing in two places...
> 
> This (PEP) is something I have no knowledge about. But I think it's
> still orthogonal to the software nodes usage.

The PEP (Power Engine Plugin) unfortunately is the reason we can't have
ACPI-based boot on WoA platforms.. This two-or-three-digit megabyte
Windows driver hardcodes almost everything related to the on-SoC power
management (buses, clocks, etc.) and only uses the bare minimum ACPI it
needs to connect devices to a bus or get notifications on standard events..

> 
>> And lastly, the EC subdevices are quite contained and I don't see them
>> interacting with any other components in the DT, so it's more of a
>> stylistic choice where to put them.
> 
> They are still part of hardware and DT describes hardware.

Unfortunately the "Surface Aggregator Module" is just a firmware
exposed on some range of MCUs running MSFT's code..

Given how.. peculiarly the "bus" that it hosts """devices""" on is
constructed (5-level-deep hierarchy without it making much sense
beyond maaaybe the first two), it's not really easy to describe in
DT in a way that would be both true to the bigger picture and make
enough sense to convince the DT maintainers, I don't think

Konrad

