Return-Path: <linux-acpi+bounces-18167-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B17C03559
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 22:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 148371AA155F
	for <lists+linux-acpi@lfdr.de>; Thu, 23 Oct 2025 20:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C934B664;
	Thu, 23 Oct 2025 20:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="mNiBy30M"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAD2DCC03;
	Thu, 23 Oct 2025 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761250425; cv=none; b=HVK2KnMuhMXrDjLUaCFg5lyOauZLFmlg+rSvElqT4g/06n34cRSHVi/JoNxvSyabw3iEHWSvwHyL/KQuV0riuudOK7B7WkCx6VEKLyyp96S8nQ7r1D7p/JrhitcsLcTw3mKUY04I1+Tf/AyDTksO3pFNjAmxPtAwPvtomlbvswg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761250425; c=relaxed/simple;
	bh=PjnRGjtlO1HEPYlFuE1Vrq/O2rITjL30nou3cAeplSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4UbtClIAgtzy57ml4wvcsixB13a8bNERCuM3IHZEjKuMj3WHRqajUDsdpYCQHkn5kK18AH/SFEp15agNLYZeVRkPyNccdSGnStz7iCJSqBLElbHW5j2yEPZ0h7fC6Je8pCZoqXTxZ9LbfzmBcbbGeg1vqGtkfCmXEj3PmmNuKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=mNiBy30M; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1761250416; x=1761855216; i=w_armin@gmx.de;
	bh=PjnRGjtlO1HEPYlFuE1Vrq/O2rITjL30nou3cAeplSo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mNiBy30Mnk2lET3vzJ4F+xRpGl0kCofU4VdPK1U4fGWFuRxEtLAnY1GLNlofmGvn
	 k2g6x2sQt7Ptv/v/WwGxpUdlX2ujGwVdgJq2IDQ1EbEl3zAcxcuACH9SvbE9dueFP
	 xdgldfDUWl4O3R3WeuaQkLJiYkE+/GNn+d6dk6sRkGK/Ec4s+zdbsKQ5Da414navz
	 ykTDMCCzY2y1c2pXtQaLUniYAR20/13akp/8b/7frkttwotcNemZ0C9yVTedIYm0n
	 px0KGQD77tx56yRUFbDRjf8TOUJnx7Q+zZsKSE24mfGBP8jZq/MRl/le8UWNzacTw
	 bzN6PSZXLZJ9UIZBiw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.24] ([93.202.247.91]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N9dsb-1u9Nw52U6P-014COw; Thu, 23
 Oct 2025 22:13:36 +0200
Message-ID: <de8dc59e-d301-4954-b39c-f032b6aa0db9@gmx.de>
Date: Thu, 23 Oct 2025 22:13:35 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] ACPI fan _DSM support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251007234149.2769-1-W_Armin@gmx.de>
 <ec099f39-89a2-46ee-a10c-1350ecf7fc83@gmx.de>
 <CAJZ5v0h8w0wrO5ziqQchN_f5Cb=Duqfc6=uOzR_-pk5_UcJ95g@mail.gmail.com>
 <CAJZ5v0idydJCQqnEs38KJT+1TmVJuhLeCFikypDLD1Yd_8zWhg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0idydJCQqnEs38KJT+1TmVJuhLeCFikypDLD1Yd_8zWhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k2WBDIDLwCM2jvlN9KDj+t4vAzVyeI3SZRSQ9S0dN16Z4tjjeLg
 RFfVqY3zR/lkG/AKsWs0SHDKqyNCo9ddMCUMxS6Wnoym7MoHC9S8L+Sln343oe0TRNbt56B
 IitA+O/6z2DwCIzU5BbHmjMiotdUBapI6/vlPg2AdxTFOFHaSRDjhN5Cb9K4UFBLZUbpcqr
 aTz7i7nD3c4Zd9RPNMEhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:A0olCMeADvk=;jkqqeZ45FHJP8atn4WdQSg7TQwh
 Y0OSet75gSYXC6EAzdZD2WM8PhBlTik2gdheeNvDhnp99uEf5HuqkOdQbblgQgF/I8e07hnD0
 VTo6XUxIh5C0c1h5VYSn7KLqxg/MbhUjpczlDqOm65y3dbRPbpLWIEeC3H1yqo+Zyaw2aEf07
 hG8XL3hOStVcdNu+xdIcRgmO4nK43ULLpp3JM1UZI7zpIpOgMStDM0cpDlYcLWtFBPbh3VXvE
 EEsD3tLgz/Bb/AJShiBvd/2Cs46nkU/GIXFvE+e9Kqaq1Y5qvO3dB0dTYIhcHb4aHOQGmr9ll
 72csQtDaJqE0BDRZ9QPQJVu6C1HQwO3HSuuFsVoykyoM+GPn2KoLRCcFkkP5z+VCXh3q8BxJK
 LzKXPvaJbgzabO3CXsHlT+AVduokrtG9yDivOB0a9aCYpUWRp2q4OsGdZzHGrKCAn+vEFDgb5
 ypTXEirfBUB56M6DBp1kdP7mjJ6WIH0vyuOTsaUhjzVZQJmnZ8PBc4kiU26IUqZ3mxAmYmwYt
 U7Ps7gtlT37a0s0jth1iRs1aDmuB9dvHqwzccnGT4HiZIDNEeMwDwAdkYSuCa6bm2JpSLirVd
 Oxwb5veZa8q9cA8GcefL62a6I2Xp5M3xmZRJeK8J0/UiEi9vBnsFSSyQX5eRY0iQpIYRxSgDK
 DH9ieTsADltn+/3OwAc7tGvZiHqMUQ0pTg17j9brXAyJs03zr0lQAxlAaNeVZ3LQ1oXIcZsAq
 +hBHRKlDhnlm1BAIHQCZLak7d46b9Z7tQ5I3NaFS2oHRVEPEDgw2a9fk3whVCmfp3T+Itf/pA
 JtZYCSsktodHAH52vm8tM9TUoR3KCNAnaObGAcfYja0CA4vQzCkdn25o5hgjF9lLIyoT2a1JZ
 8goDq5iyOR5nYDXmb+xdTOtpUsO1ENKid1WARF46Na0IQGmGzQ8Xn2c5BJ9IUnjjTvIkmygqw
 tdqsdkTDvsxCyIzJ87WJjr/r8IBuZ4dawiNXLaiIMcEoCytq0l4Uq/q7+3O62ZN9Zl0dMpXBi
 mmQZ7Ou3/c+mnml7Kvo3uAfyE/8hz9Z5nLwMepoSKPun+KHSOkmCbHOA8OtccvTZspq/xXyVo
 KIYnvkIpTBtmTtB7lOj53Io0/TZ+NR6Lg9BVMTP2Xux+c9pxACoOrA1hT92bd2UQe4/rL4OuT
 Hx+djEp7jxmjZEh4fIbRhsfLDGuFht91tViZxOEa17FtLf39ksIPfpiqClMXcdE29o01EVBww
 8bUU47M2I1uyW5sTg4mN6q+tldkXPyih7ydErbMGI97938N3vCXudHa9Y85BluK2oREE6eb+U
 +IOZDNO+3ifBU7DjxuQWpGfYZOOEI6zsLQP/oC2KxD4UpAhGE7doOAhfwrcjFc8SNw1G/tUR+
 OrURsYuIqn0saBORzVI7NlNR/D5XQBrsIRVl1ksiUkd/hdXYHPjeHzanYXJJj8P1Mop2WfVRF
 cbFb/P7SupdqPc0B2r6Hsh6NC2OgVJz+buRw3Rq+GYDVpVLx+TOVblNtQx5I6MDvu2TxGRqX5
 ZCzahUrvgkWrQhh8QynqqnpnCzQfF9uJKHHgj96kxmg6e8+BqlvbRtGvcvIyrIo8ZwPkgxTRc
 6LUr2m9p/P+cN57NiuVWjljs1/fje1sMdhijd5tXqT0vyOA4uc5lCiv3GW7SyuCzXKlZ8Dh27
 G5Ejqh881hRl48NmouTwtR9hVw2R4ERWl2/cfBy09X7yldpUAWPo1Sr8onePu8U7jFBTMsVDz
 KpJ6oPtpKQLSybxXFaORU0rj0mW4X8IXaFJmmfDWU15N+0ucagAGo921DNJ5X0SqaIAzrgOGT
 rumaKAzPTSnhekxV+IkZgn1uCrMWymjitIaeVuXm0LSS4mc4qhJ9TzXYoVzQLYg+otE23PVNF
 u/F8MB+YSfYYuHKko5fdq/221qdqc+EXIMeFvcn93uhTW3zvgcBfW4MHrn0FsSe/rEcon85Tq
 mg29C6ZVdAupdh6UzNFa0+Du31S+IRJXzmvP2XKigFpoB13Sd+bgmEldUzEB8Z0brBZMi6bro
 PuPUp6GxOMhqA9LsMVD+RqUGhqstTcHfL6trsKSG8UWl2QIkYs097m8C3PjKRfuh0PljCO4Nt
 rb+TkPGXhvjEY2Wz379rtR7gJErZC0kXTO9RyeYt6rw8Q9CNiQjGyfwRQsK6siw8wlyvFO+xo
 De/bvc0WozCoAaH7aR1DfAJh/290kL3dJkiZC7CmqrXSl71H2rl6KAb7g6Vt6GQ3Z6heQ7fPZ
 N3Io7Z354yzFe4BJ85ptcr+ScWTJVcZnVPPwDpbjBwI3Xr9gjV9jSi54Hb7Ni3NczMsxxyfwP
 RxgFvte/ppwBZc2Z2hEQEMVXHxgCTifyKbdjXSmck0prpmZmhEhc/xgeXZs8WBwO/vW9WxQLX
 ky5ioqK4R+VNcZxvosJmpSpZ1pvYTGyQ5Nwz9+iXdTpn9HjKSFGYsAmwqIwllXS1ud7x1cSPz
 gdLVc6KicUVK4HNxFBB+4LNp+VOmzKDZ5nMyhJITe6KQPvKjQhhWgAlz3IZ3B6WFB2DfoMFl8
 +zwZf9fzPWTJGh0autMIdyjWU2XBA70XwRR3V1ojofsUWpMY8zcWZL/n//6gnrCW+l6mSMtqP
 KNOA4sI5WBflxGYN5bdPlk55fr/v4pqjKv4LIXFaw4b2bCZekzpMDBtlvWwoqH/h+k6Q2WDtE
 cneevJKVOFrNweTJUGjwKBv2KL+6jnJYW3YkAP78OE0GrHeNzG/k23OleKv228C6mfppDbGQ/
 9OujgR1bvl+inxUCFGTM8AUjkQljgNWyW1gCmFzVeUnX9yF3UcLVYZM4cmP22CThxlo3vEAYb
 D91JWC+qwZhJS+G9VlfRlDH2IlUKRuyITtpeySHtNs96tO0yK+bEmiw4vqoJAAD/rqqaxhHap
 jpEXeTgqMDMHA3OzGA/zvdKeqhWd08sMJUY+eNNE2SwbWtl1JAsrbMIaItNDYzS+d1ZUzMGUL
 taPQH2PfXCNwlb2LWyWiGWTliQfe/EtYuiRsyTqaF+LaoaF6JR5VILIPbf34Occ3rtTrYWYfH
 E/p77JGgQL+j6T8j4x0nyjVYbAh6uE4B4bWpNYo1bQdLWUTrNzVPKpNQg3xwpycWhoQxHk5oY
 IFZ1Cth+VfuGkHYDr7ni4nAPgGIlVQuboevkPwtwfGtUQJlZDp0fqFvkYD8ryniG4HTT1dzHU
 wdsksajxTu1QQtDR9x+qI7OIr9APz/bAgRVeOvcPK+YkVJuxIYzwDkyMpeis+AGWdAoOeSUqH
 QK5P1viJxjywFThVjM6SYvBnIlEwj1VyP4zvsqATweSmy/JxB8aGQ3+mFfo91yoV7g+BvTWbA
 LNb6v/NSnAf0+mYSAEVSO4tyzLY9IA0cdLrUXts6KGuRdzE+Tk+37ussoATbfy7r2RDCUUANH
 4fxPxBwnbPs85yaVfhqCdLq9VXs8QsNAHotndAiRaxP0ebBs8Oy46K1t4+Ev0vFoxNatkUhvo
 feQqw9YfzyRCmBdpGo73PpMKnMyiY7AOGxfhnYSSubEs2PXWENhL1A5aONG8ap5BEILFhSeTK
 CsSXC2/8ew9+5JnUsJc8YB9xlJQqk4C0HQJrKyI2fLoYl0zwtee0RHBbxJrN2Zhl36S/qWcN4
 lN3XHS6IaBJolUfU63dY3kjuXQJhLuWutcicH5hNrZHOia9Azsd/rR4YH5WoKBvhLUbTJKh0v
 0YD9rP9i4dgRJhC6VZ6m6eTPPJ6k3G7uqHH5A1VspW3pg2JqRJI+1RaH2sBBWbnDyiGX26CEW
 aAk8M54JldAFp7zwy3O9aLgekl4BS+Flj3yuu9p3KAgd0zLcJ4PqoMBamkru++CjCnQUl/VdG
 djjSOSIoqsA0PbPSLOnCO/I3pMUBoaUpL4vvmkFiSovSxl/pKrUHd6YIPUz35e/DCt5uLc1aC
 cOemAVfzys1F58pfrtrWqvMCs06knB4LIoLec1QRyM6GWpke92bNDY88cpuSr6bs2xr73SnzC
 QzfcWUPNbDXQ3VDYh7l5LkAOxKmNAslpcPIBnQ9CtDipiwz+nDm/NAySecUhbbNy511HGKaQU
 bgyJqn0cZBUL2ltdO4CYfdgfSXrzKB696R8Xw+396KwoEhxvDiAaRdWMTOEfhI652RXB0Bb34
 gRaGwDifHxAmol/PUJESUBbVrGKmJ+RaXgoakPXta3QTn0jRNffZrye4zpXAHtL15RnejmaYr
 eDbccqVYIOUnQf/rXs4GmYyXvYOizKPmLjSM80918d5s4/MskRDy2Qk+ucQQdHeLyBteXavXf
 70iTL45k1J5HokqhhrbCsC9Ui6kbWJHyCAwaKSOKZwp4Wo/EdQkyKqXpqD+a1zEZgK5OPkgbh
 A3SO25retYjhDfIoAb7Ulee/MughSXBf+2Kmiwz5CP/uu4oRAYBdiVZmh/olMz3BmEamLmcgR
 U0g1bEK+xnjxyMhPhphu6iOtAS/PrTUFZtrACll7HFkZFg9iE/aGE27MtzGvM8/iI9XNTQ7o3
 4ZhgWRxn6PVS0Ni3cc1DB6EA7Kosqz28JntUODuEscQHlfaDy75j5lLzauCLKa5A2eBFU1Sr/
 GeJPLoINwxcwPojNHByHIookYvOpdQVBtDK0X4C10/8BaUGzg3mTUVkfJwuqRBv7TIT9I3PP7
 e6bpmIawQ1c+YQrn6jnjwR1IMq+aO52FG1SUGIa/pTcZUVlQOrXUpcT5K+e/3f4YqVLoGJlb/
 0GBJADLE9PY3ZFcgUH1JTxFg5DqqBOL3Os1S7mzW+pwo2Sfdt36jFAdMut526XbWQwEHfZMRK
 iKrKrhMIa5LffeMWOXiBoJV277SRks2nyKngWru5mFyDhu7ViG98uydxBDkPmbZOrSD8c9B0y
 rrJBGBPXqopDdWf6msDk9Rb4TC/41PvymgHV4iBITEmOcE83Frbb8lxGVdUJabpf1X50TIByS
 BCZ8FfhnZjc9gQPFGyGpVQcbVwarTlW5TpCGjeZRkveM=

Am 23.10.25 um 21:22 schrieb Rafael J. Wysocki:

> On Thu, Oct 23, 2025 at 11:59=E2=80=AFAM Rafael J. Wysocki <rafael@kerne=
l.org> wrote:
>> On Wed, Oct 22, 2025 at 11:41=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wr=
ote:
>>> Am 08.10.25 um 01:41 schrieb Armin Wolf:
>>>
>>>> Microsoft has designed a _DSM interface for the ACPI fan device [1]
>>>> that allows the OS to set fan speed trip points. The ACPI firmware
>>>> will notify the ACPI fan device when said trip points are triggered.
>>>>
>>>> Unfortunately some device manufacturers (like HP) blindly assume that
>>>> the OS will use this _DSM interface and thus only update the fan spee=
d
>>>> value returned by the _FST control method when sending a notification
>>>> to the ACPI fan device. This results in stale fan speed values being
>>>> reported by the ACPI fan driver [2].
>>>>
>>>> The first patch performs a simple cleanup in order to reduce the usag=
e
>>>> of the acpi_device struct. The second patch fixes an issue with some
>>>> 64-bit ACPI implementations where an invalid value was reported
>>>> instead of the standard ACPI placeholder value (0xFFFFFFFF). The thir=
d
>>>> patch fixes an unrelated issue inside the hwmon support code while th=
e
>>>> next two patches add support for the ACPI fan notifications as
>>>> specified in ACPI 11.2.3. The last patch finally adds support for the
>>>> Microsoft _DSM interface.
>>>>
>>>> All patches where tested with a custom SSDT [3] and the acpi_call [4]
>>>> kernel module and appear to work just fine.
>>> Any thought on this?
>> Not yet, but I'm going to get to it today.
>>
>>> I tested it with a custom SSDT, so i can prove that those patches work=
.
>> OK
> I've applied two first patches for 6.19 and the third one for 6.18-rc, a=
s a fix.

Please note that the third patch depends on the first patch! Otherwise you=
 will
get a runtime error when acpi_fan_hwmon_read() tries to cast the platform =
device
to a ACPI device.

> My understanding is that patches [4-5/6] are preparations for the last
> one that needs a pointer to the MSFT documentation it is based on.

I understand, i will send a v3 series without the first three patch and th=
is
issue being addressed.

Thanks,
Armin Wolf


