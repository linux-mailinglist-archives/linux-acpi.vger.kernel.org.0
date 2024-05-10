Return-Path: <linux-acpi+bounces-5752-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497038C2987
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BA8B2507F
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69691B285;
	Fri, 10 May 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aGYUk32c"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F41CF83;
	Fri, 10 May 2024 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715363255; cv=none; b=YtgFF2O5T9ljzPnGedROw3zuAmPR0Ewq5tVxTHhPKxnPs44Heid4+yoEtjeDwqTPRgooxMAcPFGeh6K5ZnjL4LskCgXyMwj7+jGMUvXgYOgdVCpgNEDh7oKFiImFNLt0caeHSTM4tBRq/vXuSIw4t9E0y6vDeBjc7bjCMXg+/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715363255; c=relaxed/simple;
	bh=QY880VpDrKLYkLIweQTEmSAibAJZgvDYkKXiQyBJy2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4D/PTZjtHeuWzK7o+JNSJnS9bGzN9445hwOfd07+Vm29ov5Ym49Vsv/46lF+4bJAPKapKHLqPsP4eHgXdM166nEItanrIrr+K7S5eKTNZSexy0icAfqy8eSQD+EHFW/nVAP+FTnvVKYHP6v49fd7T6zol9TOlzs3E6XpcrASQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aGYUk32c; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715363237; x=1715968037; i=w_armin@gmx.de;
	bh=QY880VpDrKLYkLIweQTEmSAibAJZgvDYkKXiQyBJy2Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aGYUk32cac8X+wwRD1t/33aalJItWQnjQwDpAPcmZe0dXWXwj5DxC2E6v9QyuR8e
	 QPgoYXtZDPdHHI1uWwjXLiCcrYHAbNi+ez9SClnLh40+NZ3VrUKe3+n2NrIrLJKiR
	 AzcvqGBE1WpwTcll6Dck+xXnk/F7OivoP2PMxWwYvIXjPGlW/ELkfajqqNk9V3yYb
	 G2jxDxtWdAjWGLhzpXUK3SzpePjZ3Fuw4q5YoyVEDDS59+7YwiwezhBoL28ii8NtD
	 XEAalDW3nkztTn7qQXtLJXX5Py41OqNtj/fIStRRi6eF2yk0kVJj21plOr6gGZEF1
	 xtqRXjnfyX1q1zX2Xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDXp-1stJZQ347Z-00ucg8; Fri, 10
 May 2024 19:47:17 +0200
Message-ID: <269412ef-13de-4192-9289-52e51507e0b5@gmx.de>
Date: Fri, 10 May 2024 19:47:16 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] ACPI: EC: Install address space handler at the
 namespace root
To: Mario Limonciello <mario.limonciello@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux ACPI <linux-acpi@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5787281.DvuYhMxLoT@kreacher> <4926735.31r3eYUQgx@kreacher>
 <ac04c433-b0ac-4b82-b8eb-98ac16f872d8@gmx.de>
 <CAJZ5v0g_NjGHRvhm-N5vQFnOsqnxExSq99v8n_B_6ANoaCga0w@mail.gmail.com>
 <568291fc-fd79-4f08-9eb7-aed7f5a32345@gmx.de>
 <Zj5ZdcQeaTo9ImT4@smile.fi.intel.com>
 <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <0cdf0af6-851b-4781-83fe-99320c35544f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZbyEHJ0wNGrLD50nPO99adfJf9qe0p9BgAn4ydUTA/NNyXvVGd
 fNPu7BnQdCEgBvkJZ417/g1o9PwIhuB9NMDK6iD4qT7IqDu6me5RTrEqc5Op9iKcD3z39C3
 fL5ZzdRsVZ1g8MiVj7okBkmhmHpf3/VfFMYw2w7cyucpsXC7yGtSWRGAi0nnKQZQ09JGI8Y
 NLjVHuIOLZMnlpVQn8R1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:oHUl/hDCxWo=;AzpTXZuB7plqogmUY/9bxEW6iGX
 Ewm3HzbOe3pmKMFxHG4HntAWL8KH4LWyKlwlIBpKHyJztif8b6flVLJEqo+iFHNh1d473yYgY
 P9//MohkIYqL2yuIJo7YHerdZLqlNYGpgwZdPtyYSbi0nZsAEFisdbtrPfyvLZVhHkiPCvxL/
 zj2ufifdfa+yjHsi8K37Zk6kMY36tlu975kjS4m8l85O90norHuJ5FN8SkP3R2WI2tYofMoWn
 65vJWxR8VucdHwaF97hFtnCXtXwQAX6uK03sfmrYTR7gHKcjnwxJUvNoCNp21TGcI5g0NJLGM
 J3YE1zfln3MbqWS0+6PhEZGsYRsU/gXjbeuYMjP0kgpmhLCrMiPCCSV/C3wJBOix+6laJ8L6n
 b+kZiwHrqOPlSKKM/Jlfhm6kGn1qCIfSSCN2hTy/QykJHAmW+SVCDjS1rV52zmJqv5P21apTU
 rnLdlB+b2rOR06IPU90UjSzl2w4aYA00RzG/o4weFPQVl8FTWQJKNmeqlNxxdYxAHbaxUG0Wg
 WW78hhSZK+C3odfLo78AFIcxwS9YjiFCXrtt05OP75FxMko1ii1w3hEC3I8KIU68Fvy7qy170
 OjYy9/RFWDusfO9Q8ldnQPjLIM1lqHv15Ds0gUo6P058R83M+nCndQID2ZA6UHeXVbLvDwiLf
 PyLDsqk53QGQ3fLKVap0FZz+R8ro6tytW4BhFvFMQ1gS59sv3+7fLzmnV5hmDm6ZKDmfVQXY8
 yk6aOofW58GBiA3nPrS3Z33B1H1uZa7d7ZUHu2/XD53G4VhM5dkBkAw22Tuk07/VcYbXhWUYG
 Sr1ZM6qYPEuFp18VUgOkscJ5RDiruYr+pUzoW53CJmzS4=

Am 10.05.24 um 19:40 schrieb Mario Limonciello:

> On 5/10/2024 12:29, Andy Shevchenko wrote:
>> On Fri, May 10, 2024 at 06:52:41PM +0200, Armin Wolf wrote:
>>> Am 10.05.24 um 18:41 schrieb Rafael J. Wysocki:
>>>> On Fri, May 10, 2024 at 6:10=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> w=
rote:
>>>>> Am 10.05.24 um 16:03 schrieb Rafael J. Wysocki:
>>>>>
>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>
>>>>>> It is reported that _DSM evaluation fails in ucsi_acpi_dsm() on
>>>>>> Lenovo
>>>>>> IdeaPad Pro 5 due to a missing address space handler for the EC
>>>>>> address
>>>>>> space:
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0 ACPI Error: No handler for Region [ECSI] (000000=
007b8176ee)
>>>>>> [EmbeddedControl] (20230628/evregion-130)
>>>>>>
>>>>>> This happens because the EC driver only registers the EC address
>>>>>> space
>>>>>> handler for operation regions defined in the EC device scope of the
>>>>>> ACPI namespace while the operation region being accessed by the _DS=
M
>>>>>> in question is located beyond that scope.
>>>>>>
>>>>>> To address this, modify the ACPI EC driver to install the EC addres=
s
>>>>>> space handler at the root of the ACPI namespace.
>>>>>>
>>>>>> Note that this change is consistent with some examples in the ACPI
>>>>>> specification in which EC operation regions located outside the EC
>>>>>> device scope are used (for example, see Section 9.17.15 in ACPI
>>>>>> 6.5),
>>>>>> so the current behavior of the EC driver is arguably questionable.
>>>>> Hi,
>>>>>
>>>>> the patch itself looks good to me, but i wonder what happens if
>>>>> multiple
>>>>> ACPI EC devices are present. How would we handle such a situation?
>>>> I'm wondering if this is a theoretical question or do you have any
>>>> existing or planned systems in mind?
>>>>
>>>> ec_read(), ec_write() and ec_transaction() use only the first EC that
>>>> has been found anyway.
>>>
>>> Its a theoretical question, i do not know of any systems which have
>>> more than
>>> one ACPI EC device.
>>
>> The specification is clear about this case in the "ACPI Embedded
>> Controller
>> Interface Specification":
>>
>> =C2=A0 "The ACPI standard supports multiple embedded controllers in a s=
ystem,
>> =C2=A0=C2=A0 each with its own resources. Each embedded controller has =
a flat
>> =C2=A0=C2=A0 byte-addressable I/O space, currently defined as 256 bytes=
."
>>
>> However, I haven't checked deeper, so it might be a leftover in the
>> documentation.
>>
>> The OperationRegion() has no reference to the EC (or in general,
>> device) which
>> we need to speak to. The only possibility to declare OpRegion() for
>> the second+
>> EC is to use vendor specific RegionSpace, AFAIU. So, even if ACPI
>> specification
>> supports 2+ ECs, it doesn't support OpRegion():s for them under the sam=
e
>> RegionSpace.
>>
>> That said, the commit message might be extended to summarize this,
>> but at
>> the same time I see no way how this series can break anything even in
>> 2+ ECs
>> environments.
>
> It's deviating from the patch, but in practice /why/ would you even
> want to have a design with two ECs?=C2=A0 In general that is going to me=
an
> a much more complex state machine with synchronizing the interaction
> between both of them and the host.
>
> Understanding the benefit of such a design might make it easier to
> hypothesize impacts.
>
I am not saying that such designs would make sense, it was a theoretical q=
uestion only.

Maybe we can just add a small note to the Linux ACPI documentation saying =
that we only
support a single EC device?

Thanks,
Armin Wolf

>>
>>> This patch would prevent any ACPI ECs other than the first one from
>>> probing,
>>> since they would fail to register their address space handler.
>>> I am just curious if/how we want to handle such situations.
>>
>

