Return-Path: <linux-acpi+bounces-3047-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8ECA83CDCC
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jan 2024 21:53:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CB83B24485
	for <lists+linux-acpi@lfdr.de>; Thu, 25 Jan 2024 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E001131737;
	Thu, 25 Jan 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CcsQiv2C"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8096257A;
	Thu, 25 Jan 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706216001; cv=none; b=MEzfp8euc9EGxMmLuCm0Db9kclJEeVyz4mJv7kXyl1hJYQzeCAMwiI56cQaaHizZOphZkxV2waTzUEd7cAxRwOOALyT632LENuPAqBeHiYbtCfuS73s2Fw6VZIZfJJF+sQtfyx6aAx+Wlfy3Q44h7WYaLuu5YHnGWJmcYu0RP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706216001; c=relaxed/simple;
	bh=cfTQUlvW5xfRrYsLXxFIzJRcjCjeqlbNfUjbQeDzhM4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qgMgvh7425NXu80TuDbjPfXwEqBMfDicP5wYQfbWYjP/PBxAgBdK3KCfUho9G9GRptQVXWOGzj/r5q79Qn4uEYszxb8V0+ocMkAKoc6CvhW5QqUPC4Fhw/ab5CEQs3MR7neyvIa0179fbBUjk3ECQuozaJIzjINb72RHtgnFvNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CcsQiv2C; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706215987; x=1706820787; i=w_armin@gmx.de;
	bh=cfTQUlvW5xfRrYsLXxFIzJRcjCjeqlbNfUjbQeDzhM4=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=CcsQiv2C2HJ8QXlDzqPlbVbfwFrepIMVdyQWI9kyxq1r6O0+RsbL+bjTSdg3It8f
	 SvNDMNolVNBaIWdkR9plQnNCQNOfzbn8wpB3rm1FRJC/KD2ipaFIPRIW2pmpbK/RY
	 se9k9FfVVR2KXlUbgnLb1s+uN0QlpMkbLlx42msuTbYZuz4OaZIkTgHUnl8o0PJ0e
	 S5KrsFTC0s19wZSl+FOCr5/afFjW7ChZ7G/lxTWR/QpME9XSW9frqws7Rbur7VlhG
	 EmEu0+bet8tNX4lQAZK1+j7y0yYEniB+hfAx6rM7zKyWbFhDl5Hd3u2SuPBTaVZyu
	 SPnRC0Fvbs4pz+UlWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.35] ([91.137.126.34]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MBDjA-1rN5Mz1D4A-00CkPy; Thu, 25
 Jan 2024 21:53:07 +0100
Message-ID: <6775d202-6cdc-4de7-b562-39d659a4667d@gmx.de>
Date: Thu, 25 Jan 2024 21:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hp-wmi: info hotkey has no keycode or scancode
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
To: Hans de Goede <hdegoede@redhat.com>,
 Dennis Nezic <dennisn@dennisn.mooo.com>
Cc: platform-driver-x86@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <ZawX2mquuTCv0tuF@panther>
 <a8fa0308-0998-48e4-a104-c2b57ee9bd8e@gmx.de> <Zaw9mnfEL65B5r4O@panther>
 <e97ae805-d006-4f0c-96c0-976385772bb7@gmx.de> <Za4T0RwClHOoCPCy@panther>
 <cd86386a-653e-401c-9b70-0860d2e1906a@gmx.de> <Za8xL39m1X22f2Bb@panther>
 <Za9DQdLg2d_CnrZG@panther> <3e574768-8d5b-465b-9860-567d0845d3fb@gmx.de>
 <3e517aa3-4020-4b29-b7b3-85271503d03d@gmx.de> <Za_Xss52DlydJOOO@panther>
 <e53a660b-f766-479c-8507-ffe25ca0e26e@redhat.com>
 <57df06ee-3aa1-4501-9dc6-a7bc57d770be@gmx.de>
In-Reply-To: <57df06ee-3aa1-4501-9dc6-a7bc57d770be@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:awVOBpSXWLzOCHB4qN9eiUm6STBXfIpUuSk+V4+v6wZ/EzHa6ev
 jDbms7TvJcu4WjvUlk4N9qotzyOhsG1sE2M9K9jv+f7Jfg+Bd5cov/9J9z0wywNi2Pk90Vp
 qqFhlvLyyCXilW9KxHa2quOoVmhLwK3Bw7HXYP3Hs4HeKSO+wUuzS/WxtHHAcKhV86NrP9K
 ERKm0XT0mHu/XeoWtPgLw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WLaN8oKPgl8=;IsOTh+Co9mEr+LUhhFcnIN+Ftmw
 YyU1QICgKAG8j6abkzWwYXM5SrSS7O5+6Lu05RHNEbL65hytqkXTcKfSU0h/wGPXu8oLq3VhF
 GTBKFteQlNSGGjc1UBEeMByyphjGH95qKGVn8Yqa3o8je1XB9oqtWPBIbwUeoT00WjdIrz4XH
 Ta7iUt4v4jjN+NADFUh8HHjq9YstfiSxJWdwC9V9cAx1PjurR0ogzmHqqiWodVEtfCT+a96Ac
 CZZKMXxCbW29gn/dEHuDoRtAjx1/Rtit6w5TeU9pJF+j6DJ3HLMJCo+Dn8XPDWhYqfppxVwwF
 zDSatRO58LmsY1VIfIGbPya4lR/BoCaCbKwR2N2Ib5q9rEf0pvtF58luj6jN7f0nMZAG1G7M+
 z4jYTxjhRq3JBwSV05lAVjh01alk0a7ihg311+fDkY/JdJoxzCNfuXespI5WFkxt7l8trxZrY
 C364d5cUnbS6xETlxZVEFKhBhXM8YEmpclMqcqUrVy9g/cI8UWftc9WZitwNkq+KEnyTOsaAr
 tcHQLZNI1RRzFOlVEbDeivlTD/VIS5eQo9oeyY8StPcWJZCOBEsUZeu3W9zgNvNbhL//4esjL
 GDiC607R43MW/aj6YIqTAIkc2lBjuILbdO58A/jyYEYJz63ZDlhpqdDfGko8PMTpxbBtcRLQx
 5ZlPH0i0OVTaM6yaSSJX0r+wftSBdqpcqG00xYdCgKMRve48dFsi2JsiZHAKIbVIqOOX+q85R
 /B8wHA51zTUyra+zghva8/s+OFgirutJKwTTJxhlZSzDC4K8l+3apS6rNmSCYEy6b886ghHM8
 r5bvSuduVGbMMCmBM7r++CuCLxiPsdgUnqO9Oe/SxgQKWN140aCBKISYSOpA+9NMScvs1azgM
 kBKv1s4XMHoVcFkIs61GBaScqUmsIBhpzQ3XXHnZYWoILRNhPmzqrSfWuE1x2AvHaZu9eHnc0
 qz2vi3qUDdmSJ6xR9aXJs3yRH1eDyw16nubuOrylfqJM4qFEDAQdIC6g8BhVm1DeEOoKXw==

Am 23.01.24 um 20:58 schrieb Armin Wolf:

> Am 23.01.24 um 16:34 schrieb Hans de Goede:
>
>> Hi,
>>
>> On 1/23/24 16:13, Dennis Nezic wrote:
>>> On 23 Jan 15:22, Armin Wolf wrote:
>>>> Am 23.01.24 um 09:58 schrieb Armin Wolf:
>>>>
>>>>> Am 23.01.24 um 05:40 schrieb Dennis Nezic:
>>>>>
>>>>>> On 22 Jan 22:23, Dennis Nezic wrote:
>>>>>>> On 22 Jan 11:44, Armin Wolf wrote:
>>>>>>>> Am 22.01.24 um 08:05 schrieb Dennis Nezic:
>>>>>>>>
>>>>>>>>> On 21 Jan 16:16, Armin Wolf wrote:
>>>>>>>>>> Am 20.01.24 um 22:39 schrieb Dennis Nezic:
>>>>>>>>>>
>>>>>>>>>>> On 20 Jan 21:52, Armin Wolf wrote:
>>>>>>>>>>>> Am 20.01.24 um 19:58 schrieb Dennis Nezic:
>>>>>>>>>>>>
>>>>>>>>>>>>> Guys, the "info" illuminated touch-key (hotkey?) on my lapto=
p
>>>>>>>>>>>>> "doesn't
>>>>>>>>>>>>> work", showkey doesn't report any keycode or scancode. I
>>>>>>>>>>>>> don't
>>>>>>>>>>>>> see any
>>>>>>>>>>>>> wmi related error messages from dmesg. All the other
>>>>>>>>>>>>> illuminated
>>>>>>>>>>>>> "hotkeys" work fine, although confusingly evtest and
>>>>>>>>>>>>> "libinput
>>>>>>>>>>>>> debug-events" report that they're coming through the event
>>>>>>>>>>>>> interface
>>>>>>>>>>>>> associated with "AT Translated Set 2 keyboard" instead of
>>>>>>>>>>>>> "HP WMI
>>>>>>>>>>>>> hotkeys", but hey, as long as I receive them I'm okay :p.
>>>>>>>>>>>>>
>>>>>>>>>>>>> hp-wmi.c does seem to reference it:
>>>>>>>>>>>>>
>>>>>>>>>>>>> How can I go about troubleshooting this? (I'm using kernel
>>>>>>>>>>>>> 6.6.8)
>>>>>>>>>>>> it can be possible that your machine does not use hp-wmi to
>>>>>>>>>>>> deliver keycodes
>>>>>>>>>>>> to the operating system, but instead emulates a standard
>>>>>>>>>>>> keyboard controller.
>>>>>>>>>>>>
>>>>>>>>>>>> Can you check with "kacpimon" that events concerning a PNP0C1=
4
>>>>>>>>>>>> device are being
>>>>>>>>>>>> received?
>>>>>>>>>>> Very possible indeed. "kacpimon" doesn't show anything when I
>>>>>>>>>>> press that
>>>>>>>>>>> touchkey, but it does when I press all the other touchkeys. (I
>>>>>>>>>>> do get
>>>>>>>>>>> lots of accelerometer noise.)
>>>>>>>>>>>
>>>>>>>>>> Interesting, can you please share the output of:
>>>>>>>>>> - "kacpimon" while you where pressing the buttons
>>>>>>>>>> - "acpidump"
>>>>>>>>> ...
>>>>>>>> Those events are touchscreen events, maybe your mouse is
>>>>>>>> responsible for them.
>>>>>>> Right, of course, woops, these must have been the touchpad press
>>>>>>> events,
>>>>>>> as I was moving the mouse around :P
>>>>>>>
>>>>>>>> Instead they look like this:
>>>>>>>>
>>>>>>> I'm definitely not seeing anything like that, just "^Input Layer:
>>>>>>> Type"'s
>>>>>>>
>>>>>>>> Can you try to use kacpimon again but without root privileges?
>>>>>>>> This
>>>>>>>> way only netlink events show up.
>>>>>>>> You might also stop acpid while you are using kacpimon.
>>>>>>> 0 output from/with netlink, even though kacpimon said:
>>>>>>>
>>>>>>> Netlink ACPI Family ID: 24
>>>>>>> Netlink ACPI Multicast Group ID: 5
>>>>>>> netlink opened successfully
>>>>>>>
>>>>>>> Remember all my other fancy hotkeys "work", but they appear as
>>>>>>> regular
>>>>>>> keypress events from an "AT Translated Set 2 keyboard".
>>>>>>>
>>>>>>>> If you still cannot receive any netlink events, then i might need
>>>>>>>> to take a look at your ACPI tables
>>>>>>>> via acpidump.
>>>>>>> https://dennisn.mooo.com/stuff/dump.txt
>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Armin Wolf
>>>>>>> Thank you again sir!
>>>>>> A1799AC3-9429-4529-927E-DFE13736EEBA has zero instances
>>>>>> 8232DE3D-663D-4327-A8F4-E293ADB9BF05 has zero instances
>>>>>> 8F1F6436-9F42-42C8-BADC-0E9424F20C9A has zero instances
>>>>>> 8F1F6435-9F42-42C8-BADC-0E9424F20C9A has zero instances
>>>>>>
>>>>>> (Btw that "info" key does get illuminated when I touch/press it,
>>>>>> even
>>>>>> though no codes are seen.)
>>>>> These warnings in dmesg are harmless, they are informing you that
>>>>> some
>>>>> WMI devices are unavailable.
>>>>>
>>>>> I took a look at your ACPI tables and it seems that the WMI device
>>>>> used by hp-wmi is indeed unused.
>>>>> What is the model name of your HP notebook?
>>> HP Compaq 8710p
>>>
>>>> Also i just noted that your notebook might contain a PNP0C32
>>>> quickstart button device.
>>>> Can you tell me the output of "cat
>>>> /sys/bus/acpi/devices/PNP0C32\:00/status"?
>>> 15
>> Interesting.
>>
>> There have been several attempts to add support for this
>> in the past. The last one being:
>>
>> https://lore.kernel.org/platform-driver-x86/20220922182424.934340-1-lkm=
l@vorpal.se/
>>
>>
>> Note that in this case this also required some vender
>> specific poking in toshiba_acpi to get things to work.
>>
>> I see that the HP Compaq 8710p is about the same vintage
>> as the Toshiba Z830 on which the last attempt to do
>> something about the quick start buttons was done.
>>
>> So this might very well explain the missing button issue.
>>
>> Regards,
>>
>> Hans
>>
> I can try to upstream the necessary changes. But i cannot test the
> changes concerning the toshiba_acpi driver.
> Would it be ok if i omit those changes?
>
> Dennis, can you check that your device runs the latest BIOS? And if
> this is not the case, could you do a BIOS
> update and send me an updated acpidump?
>
> The reason for this is that currently, the button device receives only
> system wake events, but no button press
> events during runtime. Maybe this is a BIOS bug, although this could
> also be intentional (fancy power button).
>
> Armin Wolf
>
Hi,

while modifying the quickstart button driver to use the standard pm wake i=
nfrastructure, i have run into a
little problem: how to properly hook up the platform device with the ACPI =
device wakeup infrastructure?

Is this possible when using a platform driver, or do i need to use a ACPI =
driver?

Thanks,
Armin Wolf


