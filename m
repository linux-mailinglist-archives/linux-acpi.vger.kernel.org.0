Return-Path: <linux-acpi+bounces-5705-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 873718C1962
	for <lists+linux-acpi@lfdr.de>; Fri, 10 May 2024 00:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1263E283644
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 22:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A56129E76;
	Thu,  9 May 2024 22:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="UlHDvFIS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C712D210
	for <linux-acpi@vger.kernel.org>; Thu,  9 May 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293948; cv=none; b=oKWEgVi835mFzRD9D/fkPs2sSPKs3wyfkYxKvhvGaAfRbM4+CM2xcoQUjXjqPlWhZY6lOBGnLU2fXY2OFbiFnwIE2nG7kbKk93rWdzzfZvSxPrtZ3erj0sLMjXRj6fwuMncT6JIfGwczjyJVeYcleKqCCWx8rD/OjMRejtk8bXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293948; c=relaxed/simple;
	bh=TtKTD4oAWa3IVTh11lBqFbprKbYh8ybw3eeOvM0XKVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8MdyKr2JcHPnRMnYGyZXQhQq1/sppsKASddZoqYemyly80YhC+suHXCmZi0MWZWQFhFOJqt++xbREauCVO5QpZhyKf5cBomVUz+7rpsMSzUBwZudOnYO1yywwzQL8vk1YhsKwB3hkBoTqKRn4GvdgtGELuDV6v+Q10VDCHpgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=UlHDvFIS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1715293920; x=1715898720; i=w_armin@gmx.de;
	bh=6LDUHwoNG/gKj+jVWpMhSwMwZlWVySANAyd/ceMI4Fk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UlHDvFISMQfZPrmsGRXW+2PHtwjFLBACnJiZ5VHrkRXzN8TBOv6X9Rjiw2iJek2B
	 wExDp6kaD4BcMhapANRtlgsGQaoGc9Wu2ZC8AYUqSFpkayX6aLc+bInrUZXSSsxQn
	 DWvZ0yJXbvjb+8Y3ZMr/KoqZQ6ESnD7xKQZtJ9m3i9HTcrXihLOyQjuUzoCQWtZr5
	 x+cGoVQIm+Eybn0yIE9xJW1KOR8B5gc+qPniqsucG9+mAiipuozzc7SBvU1IX1ueB
	 CBBMrHKXAeoGeJTra4yn+7NhNodQMbVgNbgWW+MloGMdaN/q6CEaUtBrX4vFsq6PO
	 HfGWwjeDL5tFHJV0UQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHXFr-1rrmAT1KSX-00GrNh; Fri, 10
 May 2024 00:32:00 +0200
Message-ID: <87c1a667-b0cc-46b7-b7a8-2baead94e456@gmx.de>
Date: Fri, 10 May 2024 00:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Missing default handler for the EmbeddedControl OpRegion
To: Hans de Goede <hdegoede@redhat.com>, "Rafael J. Wysocki"
 <rjw@rjwysocki.net>, Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Robert Moore <robert.moore@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>
References: <Zi+0whTvDbAdveHq@kuha.fi.intel.com>
 <CAJZ5v0iAMG251n6yg-h6KCUywK2vSg4sX3FTnOuxcLaEvUwFPQ@mail.gmail.com>
 <ZjtuKzqpfKFbRaUi@kuha.fi.intel.com> <5781917.DvuYhMxLoT@kreacher>
 <27722d8b-ecdc-40d4-af47-8150a8a0a2e6@redhat.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <27722d8b-ecdc-40d4-af47-8150a8a0a2e6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Rr0SfHQExyBhC6H6AYJS5MbFe9bhWvulZD7CbBI4Ld467kDz07c
 Y3vBa9RkQnnCLOoz+igZaWL3EpcexKGOtWr7GLh1yiYeE1JfpV5tV1fQ2Qb5aCx2UCxIWAI
 CcFz4llRjigR9HWzx1uYu8k3+/HGDE0ZS0d3EBtLi4ctFL7cCioCBukLTmQDTSsyugsMx9E
 Vr85vgrUT25ihwLk/Rcgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6YxWKIL8AKE=;WKmxLQ8PJhu4DoacG6NLmJM3U3g
 UYtElhxREyJ8DS9ApAC8BaDzJ24lOkaUOrT+urdLe9ag9A6sg6yOO7hOfcqWgJgYX9EQcLv6m
 A3xPhpMH058RuOKYbEXwAVtFqnJWpDZboBO+Rrd4eVWhLyIDKggsEowTlpgArCQvVZn6qrz0M
 OLa7RCj+6lWniRpRbhtMxeb8NZwLdINLBhA+HaLCd9pQDhJZcQYwilRBmxkWWYgxPreWdH5lT
 HxLj77TVh+uAJeAhA7E99dkauQTwkL5X4f9W/1zraoTr2KTCbabPMtNi+X0J3vcJ04VYvAJzZ
 bwpHNKMq9wuXsUZBW/EqhGIas1jaLNQ4o9hvR1V70KlzzKUsqxew+hWbimR/DvDalMbKRtn3o
 EKERlaMT2SQy45OKpHnkuhufFLr7VrMFlKIFUeDvRS/BG6UCNcUzM2VDum8ZN3WwqvOyw0L+U
 hOz5Egz03tjvFDKhEIQc+EA0hmw8LQkWjQjffqFwd/6Njq6omkScF69gIDPJ+WTzB436cio4+
 HfBY4eoHwwlHKeCvitKrshhoSh8FMLoj+7hPC0PebPrgADHodO2FnVSuF7GSO6OXKGzbznGtB
 OseL5/GN9hFFubAk3tQwXZF6F0E3Jly7gkkEQCx3eiBvdTENeMtQa1CizXqAPfHqmrPoozQ8A
 PWNdUsvhZrWGT7rNNUR3Dd2zeAINTdOlzpmOLQQWB6+gumzYc9tXRZZFzvX5Xk7hlcqhvJ+Gc
 GmvfNbya4ZruLpArObYww185vurY7aIwDG3FzAqtmx469S2Do4+R6CwQ6x5+DjnnN9Y2LHhJM
 pJKeslcsBsvxZwOHAvL6g8jZbGMZXMnaBOa/dgoStnGOo=

Am 09.05.24 um 12:35 schrieb Hans de Goede:

> Hi Rafael,
>
> On 5/8/24 2:50 PM, Rafael J. Wysocki wrote:
>> [Resending because it appears to have got lost, sorry for duplicates.]
>>
>> On Wednesday, May 8, 2024 2:20:59 PM CEST Heikki Krogerus wrote:
>>> On Mon, May 06, 2024 at 07:45:07PM +0200, Rafael J. Wysocki wrote:
>>>> Hi,
>>>>
>>>> On Mon, Apr 29, 2024 at 4:55=E2=80=AFPM Heikki Krogerus
>>>> <heikki.krogerus@linux.intel.com> wrote:
>>>>> Hi,
>>>>>
>>>>> There's a bug that is caused by an EmbeddedControl OpRegion which is
>>>>> declared inside the scope of a specific USB Type-C device (PNP0CA0):
>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=3D218789
>>>> And in this bug you are essentially proposing to install the EC
>>>> OpRegion handler at the namespace root instead of the EC device.
>>>>
>>>> This sounds reasonable, although AFAICS this is a matter of modifying
>>>> the EC driver (before the EC OpRegion handler is installed by the EC
>>>> drvier, ACPICA has no way to handle EC address space accesses anyway)=
.
>>>>
>>>>> It looks like that's not the only case where that OpRegion ID is use=
d
>>>>> outside of the EC device scope. There is at least one driver in Linu=
x
>>>>> Kernel (drivers/platform/x86/wmi.c) that already has a custom handle=
r
>>>>> for the EmbeddedControl OpRegion, and based on a quick search, the
>>>>> problem "Region EmbeddedControl (ID=3D3) has no handler" has happene=
d
>>>>> with some other devices too.
>>>> AFAICS, installing the EC address space handler at the EC device
>>>> object itself is not based on any sound technical arguments, it's jus=
t
>>>> been always done this way in Linux.  It's quite possible that the EC
>>>> address space handler should have been installed at the namespace roo=
t
>>>> from the outset.
>>> Okay, thank you for the explanation. So can we simply change it like
>>> this (I may have still misunderstood something)?
>> Roughly speaking, yes, but it is missing an analogous change around
>> the removal.
>>
>> Please see the appended patch (which I have created independently in
>> the meantime).  It doesn't break stuff for me and Andy points out that
>> there are examples of EmbeddedControl OpRegions outside the EC device
>> scope in the spec (see Section 9.17.15 in ACPI 6.5, for instance).
>>
>> So I think that this change can be made relatively safely (but adding H=
ans and
>> Mario to the CC in case they know something that might be broken by it)=
.
> +Cc Armin for WMI EC handler
>
> No objections from me against registering the EC handler at the root,
> when I saw that the WMI driver was registering its own handler I was
> already wondering why we did not just register the acpi/ec.c handler at
> the root level but I did not have time to pursue this further.
>
> One question which I have is does the drivers/acpi/ec.c version handle
> read/writes of a width other then 8 bits ? Armin recently added support
> for other widths to the WMI version of the OpRegion handler to fix
> issues on some laptop models:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3Dc663b26972eae7d2a614f584c92a266fe9a2d44c
>
> Regards,
>
> Hans

Hi,

the handling of multi-byte reads/writes was taken from the ec driver itsel=
f, so
using the standard ec handler should make no difference for the WMI driver=
.

Thanks,
Armin Wolf

>>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>>> index 02255795b800..6b9dd27171ee 100644
>>> --- a/drivers/acpi/ec.c
>>> +++ b/drivers/acpi/ec.c
>>> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct acpi_ec *e=
c, struct acpi_device *device,
>>>
>>>          if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>>                  acpi_ec_enter_noirq(ec);
>>> -               status =3D acpi_install_address_space_handler_no_reg(e=
c->handle,
>>> +               status =3D acpi_install_address_space_handler_no_reg(A=
CPI_ROOT_OBJECT,
>>>                                                                     AC=
PI_ADR_SPACE_EC,
>>>                                                                     &a=
cpi_ec_space_handler,
>>>                                                                     NU=
LL, ec);
>>> @@ -1497,7 +1497,7 @@ static int ec_install_handlers(struct acpi_ec *e=
c, struct acpi_device *device,
>>>                          return -ENODEV;
>>>                  }
>>>                  set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>>> -               ec->address_space_handler_holder =3D ec->handle;
>>> +               ec->address_space_handler_holder =3D ACPI_ROOT_OBJECT;
>>>          }
>>>
>>>          if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)=
) {
>>>
>> ---
>>   drivers/acpi/ec.c       |   10 +++++-----
>>   drivers/acpi/internal.h |    1 -
>>   2 files changed, 5 insertions(+), 6 deletions(-)
>>
>> Index: linux-pm/drivers/acpi/ec.c
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-pm.orig/drivers/acpi/ec.c
>> +++ linux-pm/drivers/acpi/ec.c
>> @@ -1488,7 +1488,7 @@ static int ec_install_handlers(struct ac
>>
>>   	if (!test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>   		acpi_ec_enter_noirq(ec);
>> -		status =3D acpi_install_address_space_handler_no_reg(ec->handle,
>> +		status =3D acpi_install_address_space_handler_no_reg(ACPI_ROOT_OBJEC=
T,
>>   								   ACPI_ADR_SPACE_EC,
>>   								   &acpi_ec_space_handler,
>>   								   NULL, ec);
>> @@ -1497,11 +1497,10 @@ static int ec_install_handlers(struct ac
>>   			return -ENODEV;
>>   		}
>>   		set_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>> -		ec->address_space_handler_holder =3D ec->handle;
>>   	}
>>
>>   	if (call_reg && !test_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags)) {
>> -		acpi_execute_reg_methods(ec->handle, ACPI_ADR_SPACE_EC);
>> +		acpi_execute_reg_methods(ACPI_ROOT_OBJECT, ACPI_ADR_SPACE_EC);
>>   		set_bit(EC_FLAGS_EC_REG_CALLED, &ec->flags);
>>   	}
>>
>> @@ -1555,8 +1554,9 @@ static void ec_remove_handlers(struct ac
>>   {
>>   	if (test_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags)) {
>>   		if (ACPI_FAILURE(acpi_remove_address_space_handler(
>> -					ec->address_space_handler_holder,
>> -					ACPI_ADR_SPACE_EC, &acpi_ec_space_handler)))
>> +						ACPI_ROOT_OBJECT,
>> +						ACPI_ADR_SPACE_EC,
>> +						&acpi_ec_space_handler)))
>>   			pr_err("failed to remove space handler\n");
>>   		clear_bit(EC_FLAGS_EC_HANDLER_INSTALLED, &ec->flags);
>>   	}
>> Index: linux-pm/drivers/acpi/internal.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- linux-pm.orig/drivers/acpi/internal.h
>> +++ linux-pm/drivers/acpi/internal.h
>> @@ -186,7 +186,6 @@ enum acpi_ec_event_state {
>>
>>   struct acpi_ec {
>>   	acpi_handle handle;
>> -	acpi_handle address_space_handler_holder;
>>   	int gpe;
>>   	int irq;
>>   	unsigned long command_addr;
>>
>>

