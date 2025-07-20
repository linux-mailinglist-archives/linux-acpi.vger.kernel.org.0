Return-Path: <linux-acpi+bounces-15246-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6136AB0B91C
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 01:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 712E73ACC79
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 23:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89B021B8F7;
	Sun, 20 Jul 2025 23:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iN6YQqyB"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F212CDA5;
	Sun, 20 Jul 2025 23:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053442; cv=none; b=AOrYZsrz2LSOBySyQsyBkXEt5eSHkvwspiPKgZyvlYr7YXoPTLurKD8yRh7OD4+StlyQ+pp32EVdjxzq2ElrSVr93M57tnQKbgkTlpfF1MTtTt8o5fQ+FujMQ66DUH+erfinsjbmOng1ilqVXF+c06MN1DToTcP1VykJ8KCCtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053442; c=relaxed/simple;
	bh=jX6VfLTUwab4NIGju/tbC3wwTlUY5p4UZMirdG+//qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=P45tUQMiWsrCAcdikeRZzhJET8kijdiPPFQuaSwEdCFs1varLxCKckQwa7AOltGzyNLbJzsHzcBJfVK15v+S7ZZ7w5mvOojr5+V3JNoGbTsRxGnILyi2Y1u7ulC/Ih9NQgilS3l0PYXdq1XYO8cEx+D+myaKgZ1DMlIcv2m42vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iN6YQqyB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753053438; x=1753658238; i=w_armin@gmx.de;
	bh=jX6VfLTUwab4NIGju/tbC3wwTlUY5p4UZMirdG+//qw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iN6YQqyBeq9L8cQ8OtofINr+h097dkVSHhip0VE2EfrLHiPAM0x1u5ICJL7MYZkR
	 neraWmVRs1zlec9D0oRtzauOzXO1O8Ft2uCYat7GpqX/VFWku2Lgnr9r7SFdDy0BY
	 GGKYYubaaYJZnpg4IJXVi5aM39beyUOcWSmnQaQGab/Ivxu+O1CNaonkHqCTJu4D0
	 0C42vYEqcQNm4DOm7rKYSAs3T8UE3aDavdT6D/4E+sbM/ZIClrbcqfdGFnsUerbHt
	 q+y6F7IMWn4SIA/p+jgBaKEGdQ5QbbUmEAR1vZCBi+MyOClZrUyaBw01yxWHOlGXu
	 r/SYxjiXjYv1cvWgYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N17Ye-1ukoDv35OU-00vnyo; Mon, 21
 Jul 2025 01:17:17 +0200
Message-ID: <f485dfb4-0e56-4f12-8c80-68b39ae9a78f@gmx.de>
Date: Mon, 21 Jul 2025 01:17:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing ACPI driver for a keyboard button in Xiaomi RedmiBook Pro
 16
To: Nikita Krasnov <nikita.nikita.krasnov@gmail.com>,
 linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux@weissschuh.net, fengwk94@gmail.com
References: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
 <08a8e2ad-591c-4f2b-86f5-16ac2df1b17c@gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <08a8e2ad-591c-4f2b-86f5-16ac2df1b17c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:qq1H9WiVraaOXs9X1kGyYhln76fECLmadRwP0kZvtU1BAfosLKf
 8om+L2V+r4K/i827A594MmqdEozDurJwMvF5mtHiHsKsKYpSue9ELb8QMT1cC8FpM3/DKV5
 v3bb2gH2RJikLi52nVY9ipzBoAIJf/8vhJCw2mXPWcPh02MbuLuvdJFa6UoB50Txee4xxnU
 yP/pRbgaR0gPo8hta5X1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ngKmhI55xNY=;OwMF1vG87dwdwfTjtOPIYcz/aGi
 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
 YV11M7hnobXo24=

Am 20.07.25 um 12:58 schrieb Nikita Krasnov:
> I wonder if this should have also been CC'ed to linux-kernel in case
> there is someone with the same hardware, who might be interested in this
> (I bet this also affects RedmiBooks 14 an 15).
>
> I'm not subscribed to that list, so I'm not really sure what belongs
> there.

Hi,

its fine to not send a request concerning only the x86 platform driver developers
the the general linux kernel mailing list.

Thanks,
Armin Wolf


