Return-Path: <linux-acpi+bounces-1763-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4B47F51BF
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 21:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287DB1C20357
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB7321344
	for <lists+linux-acpi@lfdr.de>; Wed, 22 Nov 2023 20:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-acpi@vger.kernel.org
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597F898;
	Wed, 22 Nov 2023 11:40:55 -0800 (PST)
Received: from [10.28.138.152] (port=30158 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1r5t5f-00080N-BL; Wed, 22 Nov 2023 22:40:51 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1r5t5f-00FEPt-1S;
	Wed, 22 Nov 2023 22:40:51 +0300
Message-ID: <cf813067-9b73-4eca-8c0a-668fc68ca6b0@ancud.ru>
Date: Wed, 22 Nov 2023 22:40:46 +0300
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: LPIT: fix u32 multiplication overflow
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <430a1271-a45c-4f5a-90c7-a62703ac7cf4@ancud.ru>
 <CAJZ5v0gHgfscDCGo3P5JVn73uUTBkpfCqRJV3QcOnFt8FP7FhQ@mail.gmail.com>
 <CAJZ5v0jGSSevWuBKFK0z+bQ2QB9+GT=ofnY=MF=53N-r7QEhSw@mail.gmail.com>
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <CAJZ5v0jGSSevWuBKFK0z+bQ2QB9+GT=ofnY=MF=53N-r7QEhSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MS-Exchange-Organization-SCL: -1

My reasoning was around something like:

1) tsc_khz is declared as unsigned int tsc_khz;

2) tsc_khz * 1000 would overflow, if the result is larger, than an 
unsigned int could hold;

3) given tsc_khz * 1000 > UINT_MAX is bad, tsc_khz > UINT_MAX / 1000 is bad;

4) if UINT_MAX is 4294967295, than tsc_khz > 4294967.295 is bad, for 
example 4294968 would lead to overflow;

5) 4294968 kHz is 4294.968 MHz, which seems realistically high to me.

For me, tsc: Refined TSC clocksource calibration: 3393.624 MHz

(seems like, it is derived from the same value,

pr_info("Refined TSC clocksource calibration: %lu.%03lu MHz\n",
         (unsigned long)tsc_khz / 1000,
         (unsigned long)tsc_khz % 1000);

)

Not sure about the math above, but it seemed reasonable enough to me to 
switch to overflow-resilient arithmetic here.


On 11/21/23 23:14, Rafael J. Wysocki wrote:
> On Tue, Nov 21, 2023 at 8:56 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> That should be "hundreds of thousands of kHz", so I was mistaken.
>
> But anyway:
>
>> Why is it really a concern?
>>

