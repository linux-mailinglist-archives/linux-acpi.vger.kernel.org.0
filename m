Return-Path: <linux-acpi+bounces-7476-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F794D5F3
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 20:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D93C9282928
	for <lists+linux-acpi@lfdr.de>; Fri,  9 Aug 2024 18:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE121CA94;
	Fri,  9 Aug 2024 18:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YFpvrpRZ"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7025D23DE
	for <linux-acpi@vger.kernel.org>; Fri,  9 Aug 2024 18:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226587; cv=none; b=NMjKXrv8vAeRsBKLpQcJ2fI92o3HmQiVhBzknQwE72IvS6wppLYrRrBEM2F3SE8KIHr0jrsjjeZvuE3wavp5NLP3ti1THQCo0/moH6o6g6TfB7rC/XM9Dg1PBoiCnQCfglgLOvYHEghe+QbxjWBWsG0YQiYI7sGam+O28ptvrtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226587; c=relaxed/simple;
	bh=oFpxUn2+xOdD+iX1VZOBfkurzlOm5vsgMNwpVxcXRQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMiVGsi2RvAakb+1pf9cBjqIb1jSlZNZrgUfYDlwHMHEVRGImx5EAPa42IZIznUExMxcRLLM/dHGCsusQaXi1ur7SJ6Mc13eOF4Le51p15xp4eyNwLA1vPSV4TzqCvdQZqNoStZWh0SiclJi3e5caS5Yr0zFpj07tyxiOFFDUQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YFpvrpRZ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1723226576; x=1723831376; i=w_armin@gmx.de;
	bh=GuAbt0EneKlnfVDcinUXqRUwwcvthi7sU+w6R1XcqmM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YFpvrpRZYgTFY5MptDPDflXzgGPieT3RFCdC3MVI6LLH5r0Q2zhOgL5qm4yKbZUm
	 DoRutn0c1sA+iOwFj+VDe2KZ6bYGoTe7kmhe1UcDyxesm6lRhP/gDv+P7fuCA0D2e
	 Yg1qcroIlToegBF24z+jQxl+EY/s+tmuisSdPkCj1S23NJfDwzSFf+ZqM0rHYwev4
	 qVijvET4iIoQtvR8tXBm8k4TWgvInBQfShrjJUJVUlP6EMY5QJEOgXCFwnc7J50Fi
	 oGU9tEu+/5qHYOI+mpN8UNNo1r45dGV5+5mcWhH0SvobxyYOdeioO8ov4Q/+9pD2a
	 uzUsvyLLMTlEIx6VHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1rpgwM046k-00mz2B; Fri, 09
 Aug 2024 20:02:56 +0200
Message-ID: <4dea0fef-d9f9-416a-b554-cc46ee6c2197@gmx.de>
Date: Fri, 9 Aug 2024 20:02:55 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "EC: Install address space handler at the namespace root" causing
 issues for some users
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>
References: <1f76b7e2-1928-4598-8037-28a1785c2d13@redhat.com>
 <c0e5414a-ec7b-44e3-980c-e71889150767@redhat.com>
 <0abc1a17-e155-4587-ada9-13f9ce5f358b@redhat.com>
 <1a426f61-1454-4a77-8262-612ab1d0d265@redhat.com>
 <CAJZ5v0iWy6oXRJ2mxhOLyWsmgp1akVjoo0i2pqDDMOg-TvWLPA@mail.gmail.com>
 <CAJZ5v0gAdAYvx=qwmQd9_tUc-d=LJW5KDzLns2eDDn=ZtCQCMw@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0gAdAYvx=qwmQd9_tUc-d=LJW5KDzLns2eDDn=ZtCQCMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnTKEcPzLwsQnJZxDoZpa9NplW0eZb9N7TyWOeI8/vFtzlHFsbb
 tqleM+01SxkGNUwr7T/7dC8Gu52I7jAEhfB+HHF0CUQH3DrA6eLs6hUqyEJdDPHbjnWMTvW
 VRfLwZnKN5drnxPUQjfaZ2/5NirZB/DjHMbk4zUs6xWVG+lt/j5FFFLKJkr+yjX9UFPKFxo
 ozgX+gzS09qwvqh8Rc2Bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t0gXtuWmS9c=;eM0vGaDHbWogqSLYuhX0HKidH8t
 Qk8+HECT4pcu+k7tcMVkikUc1f1puVpatbcLY/tTubZV/xK0wZkdrpk9u7cWAzpRXK87N2JOs
 lHsJ0fLCor2Ea2jvCL+ALYRNity46YhYkDX0a6sOxkGIgZ1MGOUO9XHlnlKbMTTsS4taSjBL5
 Q1bnUdrbKtGEHrw0sdYJ9Vheon7yaO2h9dEx/Z0m8hOFMJPWSs5WREW7QmS539PE0xWh/eMMo
 7RTD+WAhFT6+uGbbxCF72hyb94pAUjlzFkw9Di7lacfT6uWZHaqOUqtoz3TZmp+ANnUlGpAsA
 5GoRzeo6G6w4xJ8L8vaKlVlQwYdw0BuPTTCPTYJEU6ELFESdd1nRysb12GOzB/S/2o/WtC1yd
 a3T/4N+UsE4QDgXkfpn5wMnkjNWBJ4YEvg6EKKaywAxfW56A5OiIrvQpPRsRXU4O4+iDEW038
 8UFatJpQCvvCTVelIZUDXwi/f2zrmP3g0v96IeqsMXLcoPSiGVRSptEINVfDg33GoVY32GwcD
 6PhPS5U1O5zcFk8asufWaT2AGcN9Kw3HBm1kYrH7RVIvKq1IQf/aku3ZtFIul4X39Y3AadS/v
 v2AeWh6xsj09QeUoWETFDG9ww2j8iH8Ar4LJ5C27EQJv5WdaH45crkca7cByMCUjPIFI1ZY6v
 hs93B5bBJRgSRRHi9vfSdlYvYhwWbnIPtY8gGJ1AqKl+ssmUQYjAbHHm9WOcisC6OiUW6l0/i
 IdtQzkmpBu1ou4uGSmXet6lBxs2sf6pXLcP/dnJ7w7aK/sq/aJtqXUILGw2qpAvyQzgnAEe5n
 DeAFRmrUxylqAtse+j+biix9sPbu4eusw/elVa2SHxrUM=

Am 09.08.24 um 15:17 schrieb Rafael J. Wysocki:

> On Thu, Aug 8, 2024 at 7:22=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.=
org> wrote:
>> Hi,
>>
>> On Mon, Aug 5, 2024 at 2:47=E2=80=AFPM Hans de Goede <hdegoede@redhat.c=
om> wrote:
>>> Hi,
>>>
>>> On 8/5/24 1:28 PM, Hans de Goede wrote:
>>>> Hi,
>>>>
>>>> On 8/1/24 4:28 PM, Hans de Goede wrote:
>>>>> Hi,
>>>>>
>>>>> On 7/29/24 1:15 PM, Hans de Goede wrote:
>>>>>> Hi Rafael,
>>>>>>
>>>>>> There are 2 bug reports:
>>>>>>
>>>>>> 1. Brightness up/down key-presses no longer working on LG laptop (a=
cpi-video related):
>>>>>> https://lists.fedoraproject.org/archives/list/devel@lists.fedorapro=
ject.org/thread/V2KWAGZIAX4TOWPCH6A6FSIT66PR3KMZ/
>>>>> I have filed:
>>>>>
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2302253
>>>>>
>>>>> to track this now and an acpidump of the troublesome LG laptop
>>>>> is attached there. I have also requested dmesg output of
>>>>> a non working kernel to be attached there.
>>>>>
>>>>> As a reminder this is the bug where it has been confirmed that
>>>>> reverting "EC: Install address space handler at the namespace root"
>>>>> helps, with the caveat that there is a Thunderbolt related IRQ
>>>>> storm on the ACPI event IRQ after the revert ...
>>>> Ok, so the bugzilla now has 2 different dmesg outputs:
>>>>
>>>> 1. 6.9.6, this kernel works without problems
>>>>
>>>> 2. 6.9.12 with the following patch you suggested on top:
>>>>
>>>> --- a/drivers/acpi/ec.c
>>>> +++ b/drivers/acpi/ec.c
>>>> @@ -1788,7 +1788,7 @@ void __init acpi_ec_dsdt_probe(void)
>>>>         * At this point, the GPE is not fully initialized, so do not =
to
>>>>         * handle the events.
>>>>         */
>>>> -     ret =3D acpi_ec_setup(ec, NULL, true);
>>>> +     ret =3D acpi_ec_setup(ec, NULL, false);
>>>>        if (ret) {
>>>>                acpi_ec_free(ec);
>>>>                return;
>>>>
>>>> Unfortunately this does not help. dmesg shows some EC _REG errors, wh=
ich
>>>> are now (with the above diff applied) shown just before the
>>>> "Boot DSDT EC initialization complete" message, which shows that _REG=
 now
>>>> runs from acpi_ec_add() rather then before:
>>>>
>>>> [    1.007566] ACPI BIOS Error (bug): Could not resolve symbol [\_TZ.=
FN00._OFF], AE_NOT_FOUND (20230628/psargs-330)
>>>> [    1.007576] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC.EREG d=
ue to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>> [    1.007580] ACPI Error: Aborting method \_SB.PC00.LPCB.H_EC._REG d=
ue to previous error (AE_NOT_FOUND) (20230628/psparse-52
>>>> [    1.007639] ACPI: EC: interrupt unblocked
>>>> [    1.007640] ACPI: EC: event unblocked
>>>> [    1.007675] ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
>>>> [    1.007676] ACPI: EC: GPE=3D0x6e
>>>> [    1.007677] ACPI: \_SB_.PC00.LPCB.LGEC: Boot DSDT EC initializatio=
n complete
>>>> [    1.007679] ACPI: \_SB_.PC00.LPCB.LGEC: EC: Used to handle transac=
tions and events
>>>>
>>>> Note that the errors are from calling _REG on \_SB.PC00.LPCB.H_EC, wh=
ere as the actual
>>>> EC (and the only acpi_device on which _REG would get called for the E=
C Opregion before) is:
>>>> \_SB_.PC00.LPCB.LGEC.
>>>>
>>>> Looking at the DSDT it seems that the H_EC is not used and is leftove=
r from a copy/paste
>>>> from some reference design DSDT. Its _REG however does write to the E=
C before hitting the error
>>>> and I think that that write may be causing the issue...
>>>>
>>>> The H_EC device does have an _STA method and looking closer the troub=
lesome EREG method is
>>>> also called from _INI. So I guess that _STA is returning 0 causing _I=
NI to not run and
>>>> that is the reason why we are not seeing the same EREG errors with ke=
rnel 6.9.6 where _REG is
>>>> only called for the EC opregion on \_SB_.PC00.LPCB.LGEC and not for t=
he entire ACPI device
>>>> hierarchy as is done with >=3D 6.9.7 .
>>>>
>>>> Maybe we should only call _REG for the EC opregion on present devices=
 (and devices without
>>>> a _STA)?
>>>>
>>>> Also note that both LGEC and H_EC use the same cmd + data ports.
>>>>
>>>> I'll go and ask the reporter to retrieve the status of both LGEC and =
H_EC and then see
>>>> from there.
>>> The reporter has confirmed that of the 2 EC devices ( H_EC / LGEC ) on=
ly LGEC returns
>>> a _STA of non 0:
>>>
>>>> Here it is, with kernel 6.9.6:
>>>>
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/path
>>>> \_SB_.PC00.LPCB.H_EC
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:00/status
>>>> 0
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/path
>>>> \_SB_.PC00.LPCB.LGEC
>>>> $ cat /sys/bus/acpi/devices/PNP0C09\:01/status
>>>> 15
>>> And taking a second look at the other bug:
>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D2298938
>>>
>>> That one also has 2 EC ACPI devices and the errors come from calling _=
REG on the one
>>> which is not picked as the boot_ec :
>>>
>>> jul 19 17:33:41 kernel: ACPI: EC: EC started
>>> jul 19 17:33:41 kernel: ACPI: EC: interrupt blocked
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_E=
C.ECMD due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FNCL due to p=
revious error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_TZ.FN00._OFF due=
 to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI Error: Aborting method \_SB.PCI0.LPCB.H_E=
C._REG due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
>>> jul 19 17:33:41 kernel: ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
>>> jul 19 17:33:41 kernel: ACPI: \_SB_.PCI0.LPCB.EC0_: Boot DSDT EC used =
to handle transactions
>>>
>>> Note the H_EC vs EC0_ in the errors vs the "Boot DSDT EC used to
>>> handle transactions" message.
>>>
>>> So the issue in both cases seems to be calling _REG on an unused EC ac=
pi_device.
>>> Not sure how to best fix this though ...
>> I have created an experimental acpi-ec-fixes branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log=
/?h=3Dacpi-ec-fixes
>>
>> for this which illustrates my idea (untested so far).
> This has just been updated to actually register the EC _REG for all
> devices (which would have been skipped for the majority of them due to
> the previous location of the relevant function call).

Hi,

i will ask the reporter https://bugzilla.kernel.org/show_bug.cgi?id=3D2190=
75 to try out your patches.
His LG Gram seems to be affected by this problem (it has two overlapping E=
C devices ...).

Thanks,
Armin Wolf

>> The underlying observation is that _REG only needs to be evaluated for
>> EC operation regions located in the scopes of ACPI device objects
>> representing valid devices, so it is better to do it for each of these
>> objects individually in acpi_bus_attach().
>>
>> For the EC itself, it is better to do what was done before the
>> $subject commit, so evaluate _REG for the EC operation regions in the
>> EC scope (including the "orphan" _REG).
>>
>> Accordingly, commit 0e6b6dedf168 ("Revert "ACPI: EC: Evaluate orphan
>> _REG under EC device") is reverted, acpi_execute_reg_methods() is
>> modified to take an additional depth argument and it is called for
>> each device object representing a valid device with that argument
>> equal to 1.

