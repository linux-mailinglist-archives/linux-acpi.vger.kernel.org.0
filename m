Return-Path: <linux-acpi+bounces-15426-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B421B165A0
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 19:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB205808EA
	for <lists+linux-acpi@lfdr.de>; Wed, 30 Jul 2025 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BB22DECBF;
	Wed, 30 Jul 2025 17:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ByzjVFWP"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10958248881;
	Wed, 30 Jul 2025 17:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897134; cv=none; b=EHWtFOHS84EaY118xVL3tQPqtN93s6okpSQxbNKwAD4RVO1R0hhVHK9E5n4CO0rIL/t/PUDtkHdA8mqzDcBATrRn6jl5ljIxswMMyNoDCUEh8CFod43M/eauIF6P85DFd0aWY4qsoSSKGCJsMf9TR7xPjGGzY6gulpltgWx51fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897134; c=relaxed/simple;
	bh=wTaM4EIZupPze/D4abES2l3zjaFFgNQ0twjNa9GR1Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pbx1Z3vlcbamsY8CBiiOZ8HQ2wkFHg37+2FM4y9CoxbEBTWvbjMDM1jHsqTSHlLnDd3L3waPIgU+VZi/5eJMErJd12iAJ1ZEOZerxHt1DCd7fiuWRH5RRwXYrGeawqk2Q7DIbMdyxIaTbO4E4AJWkd+GePJng4iun0WdT2+tlRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ByzjVFWP; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753897129; x=1754501929; i=w_armin@gmx.de;
	bh=wTaM4EIZupPze/D4abES2l3zjaFFgNQ0twjNa9GR1Eg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ByzjVFWPrK0R1adXQGQ8Jv5UPL/aZNfOX4J4icUFFnTDvHw+9xTwwAxnef7YfQ3d
	 UeUNOwO2Jbm53QDVHznc4q7a0XZB7dEhYJgQO/YvMezEIfcbmRUqooQPVE9pHRNEu
	 olzqDr/BxjK+dr776S4AvNMrsT/BazuYdyN8QdVxDlKQmjiEWFfxHA2Gw8R7/YoPu
	 jwqN/UnMM5q24Lmkuuwe1lFGY5s6npqpkKswh7mlSpBOxD6Ytyo3dIpWOnzbLXQao
	 pqWmx4fZk2Y6g6gEGgstF8geDYOxwaG522qMa/Pm0+YEGrDCGmMnEeLNENvxpkFr/
	 pwscD7MNAeH1nWf3Og==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MkHMP-1uF0s52EUz-00nbDq; Wed, 30
 Jul 2025 19:38:48 +0200
Message-ID: <abf93c41-b026-486e-94bc-e1c2b46b81f8@gmx.de>
Date: Wed, 30 Jul 2025 19:38:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: EC: Relax sanity check of the ECDT ID string
To: Ilya K <me@0upti.me>, rafael@kernel.org, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250729062038.303734-1-W_Armin@gmx.de>
 <e911ca96-fe8f-4cc5-bf68-f20ec7da46be@0upti.me>
 <d8f9875b-03be-465b-9715-addd8334a782@gmx.de>
 <992be8dd-f0da-4a3c-8f82-85a6a605e2cb@0upti.me>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <992be8dd-f0da-4a3c-8f82-85a6a605e2cb@0upti.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:b16ofJ6TS7urR6IjDHEoK913HHi2esjyWmQ4JFBW1hsq7m/4w/l
 AiW2xoavQdA9bftOvoxK0wscU0L0rvW4Pry9/38Lu45KQCdwoCeLNA7o2Civc+VcdIFHiWz
 Ry8+Ng6dKmkLuAo/DQhJUrmukapyAX+Zpas+o6CRhkOgOghMQ8UVXpbU2Ih5QPRo/CGfFai
 cJ3JOhYCcdfX/urUhXwFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+mFvznxMq08=;hQegvhYBY+SziLYq9YMMaJsjg9V
 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
 7P8xUiQ2eLv4ExAOGYYFXS5+J1yhNKZQ=

Am 30.07.25 um 18:59 schrieb Ilya K:

>> The Linux kernel is not a verification kit, so i am against keeping the old check. Instead i suggest that we ensure that
>> the FWTS project (https://github.com/fwts/fwts) detects such invalid ECDT tables. Can you share the full output of
>> acpidump so that i can run the fwts tool on it?
>>
> Uploaded here: https://github.com/K900/21mr-acpi-dumps
>
> Thanks!

FWTS already warns that the ID string is wrong, so all good on this site.

Thanks,
Armin Wolf


