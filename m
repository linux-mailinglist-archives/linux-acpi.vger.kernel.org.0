Return-Path: <linux-acpi+bounces-15247-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4AB0B92E
	for <lists+linux-acpi@lfdr.de>; Mon, 21 Jul 2025 01:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89F341897A03
	for <lists+linux-acpi@lfdr.de>; Sun, 20 Jul 2025 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09F22422A;
	Sun, 20 Jul 2025 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="qCK/vAVz"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0C12CDA5;
	Sun, 20 Jul 2025 23:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753053819; cv=none; b=gU13u/Y5oh12HDccFdQGrLVOV0JSZXTG+sEAvP/6hGRhUnJP3AqqJYS3E0uH4fr1mggS9FwKSM7TW0Ttabb/gu/KKgjbJIaaB+m6HGKO3af10SsWt1QUSx1xMGpP+FWQd8YMZTO78sJVQDDcR0UVSboeljYXy46oAjHAUJ9vyQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753053819; c=relaxed/simple;
	bh=bS/hmZw1GacFpHmW7HdwUkKZScXPSL4rW5lEDTqY00g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RtFoJB+tyzrSCbDL3k4yfU6kI2bIQD16MrnoXL3s8DIayCZjlxpDWywXLghIILhsmZP5+WrRIQMadmDrFxel/jXJdheO4DIyMtFEhpaAAB0aGdFkE1UTH76RCnmYCPUOSns2Nv3Mp/AnbRhCJKR36tyJUqcJ4hsecYSCvgIRGsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=qCK/vAVz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1753053813; x=1753658613; i=w_armin@gmx.de;
	bh=arJsFyL3iIt2B2snnDFRsP+8McOM48YdBolwWnAxomg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=qCK/vAVz2YwWNxkznFcXByqS4f78sCUWHZAnw2Pr4rh+vQsEvnfekS/D6I//3IaL
	 aSeXJ8xH0Q4ABsB6eFZDXOlNoGbi1dohoVdOR4AeEPoYbrhqKGREOQR8znk7CuWly
	 d39MS2hRKNRSTpJElSYnUESL9c7h/KmJD5hz79F7gfCDzf9V7GmYY4xe+O1o2HNm0
	 6t9zN4mkGChTEHxA1x/UZwSp2r9ZaimLYWoO60jsw0fb5rbBUs7V/tczdOIoE64D7
	 DxXq1zZOBR4ktiNFDZhdbnBxtph2ncjS9n0q7vFxSf/rSlP3GFc6VRCVzZk68b0DU
	 p+n/ZEwl1VRkpYeIhQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.0.69] ([87.177.78.219]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5VHM-1ugOH11SVG-00rO45; Mon, 21
 Jul 2025 01:23:33 +0200
Message-ID: <68cc7f60-39b1-47f3-9120-82f8b0f26d9c@gmx.de>
Date: Mon, 21 Jul 2025 01:23:32 +0200
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
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6c7e2d8a-8c79-4311-8126-c888a6519c71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lt1SB8oa4T54n3K1iMqFB2RlYSNPzYj4tx+fHfJ6qWJH5NfwPES
 784PjL3V2SnYQGD4ZLvmZSaNnhNhr2L2hBsZuENX1GjSfb0Le60imr9feWaBhl98n7YYg3Y
 CmZS4O2aeH++zOukSwftOCpHA/fPO+W2DMsIPTrSpjabHg9nHRSw789j7At2rfVrnZzjfWE
 Hu+1jA4QWXJ+Ia+tiO0xA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1uL/1rdGI4w=;jqx31ubtB3X+bw7hkD2azMZNmnN
 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
 5WY2L/6VecDhcd3fg0gqmFB6+GvAaGd27+U

Am 20.07.25 um 01:39 schrieb Nikita Krasnov:

> Hello!
>
> I have a Xiaomi RedmiBook Pro 16 laptop and I suspect it is missing a
> driver.
>
> The laptop has a top row of F1-F12 buttons that can also control volume,
> brightness and many other things. Most of them work fine and produce a
> completely valid output (shown via `acpi_listen` from the `acpid`
> package):
>
>    button/mute MUTE 00000080 00000000
>    button/volumedown VOLDN 00000080 00000000
>    button/volumeup VOLUP 00000080 00000000
>    video/brightnessdown BRTDN 00000087 00000000
>    video/brightnessup BRTUP 00000086 00000000
>
> But then there is a "Mute mic" key (F4 button with an image of a
> crossed-out microphone). It has an LED that lights up and down when the
> button is being pressed, but there is no keycode, no dmesg message and
> no _valid_ ACPI event =E2=80=94 the message in `acpi_listen` is always t=
he same,
> no matter the state of the button. Pressing the button multiple times
> produces the same output:
>
>    wmi PNP0C14:00 00000020 00000000
>
> Might be a good time to mention that I nave 0 experience with ACPI, WMI
> and drivers in general... I tried debugging the issue further and got
> some data, but I lack the proper knowledge to interpret it.
>
> Running `acpidump -b` (from `acpica-tools` package) generated some .dat
> files which I then decompiled with `iasl -d` (from the same
> `acpica-tools` package).
>
>    # acpidump -b
>    # iasl -d dsdt.dat
>
> The resulting `dsdt.dsl` file has some code that mentions "PNP0C14".
> I've attached this file with this email.

Hi,

please share the whole output of acpidump as the DSDT contains only two un=
related
WMI devices.

> I also tried restarting the kernel with this configuration (NixOS
> shenanigans; not sure what exactly it does there), but that didn't seem
> to produce any extra files or directories on the system (in /sys and
> /dev).
>
>    boot.initrd.availableKernelModules =3D [
>      "xhci_pci"
>      "thunderbolt"
>      "nvme"
>      "usb_storage"
>      "sd_mod"
>    ];
>    boot.initrd.kernelModules =3D [ ];
>    boot.kernelModules =3D [ "kvm-intel" "wmi-sysfs" "wmi" "acpi_call" ];
>    boot.extraModulePackages =3D [ ];

Those additional modules will likely not help you, i suspect that we need
to extend the xiaomi-wmi driver a bit to add support for additional keyboa=
rd
events.

> Here is some extra info that might be relevant:
>
>    $ ls /dev/wmi
>    ls: cannot access '/dev/wmi': No such file or directory
>
>    $ ls -1 /sys/bus/wmi/devices
>    05901221-D566-11D1-B2F0-00A0C9062910
>    05901221-D566-11D1-B2F0-00A0C9062910-1
>    05901221-D566-11D1-B2F0-00A0C9062910-2
>    05901221-D566-11D1-B2F0-00A0C9062910-3
>    1DCEAF0A-4D63-44BB-BD0C-0D6281BFDDC5
>    1F13AB7F-6220-4210-8F8E-8BB5E71EE969
>    2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B
>    3F9E3C26-B077-4F86-91F5-37FF64D8C7ED
>    46C93E13-EE9B-4262-8488-563BCA757FEF
>    657B6048-310C-4A90-A211-10A17922A0AF
>    A6FEA33E-DABF-46F5-BFC8-460D961BEC9F
>    B60BFB48-3E5B-49E4-A0E9-8CFFE1B3434B
>    F80A5498-23F3-4053-A244-B39067EC476F
>    FA78E245-2C0F-4CA1-91CF-15F34E474850
>
>    $ ls /sys/bus/wmi/devices/2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B/
>    driver_override  expensive  guid  instance_count
>    modalias  object_id  power  subsystem  uevent
>
>    $ uname -a
>    Linux 6.15.5 #1-NixOS SMP PREEMPT_DYNAMIC x86_64 GNU/Linux
>   =20
>    $ ls /proc/acpi
>    button  wakeup
>
>    $ sudo cat /proc/acpi/button/lid/LID0/state
>    state:      open
>
>    $ sudo cat /proc/acpi/wakeup
>    Device    S-state    Status     Sysfs node
>    AWAC      S4         *enabled   platform:ACPI000E:00
>    XDCI      S4         *disabled
>    XHCI      S4         *enabled   pci:0000:00:14.0
>    HDAS      S4         *disabled  pci:0000:00:1f.3
>    I3C0      S4         *disabled
>    CNVW      S4         *disabled  pci:0000:00:14.3
>    RP01      S4         *disabled
>    PXSX      S4         *disabled
>    RP02      S4         *disabled
>    PXSX      S4         *disabled
>    RP03      S4         *disabled
>    PXSX      S4         *disabled
>    RP04      S4         *disabled
>    PXSX      S4         *disabled
>    RP05      S4         *disabled
>    PXSX      S4         *disabled
>    RP06      S4         *disabled
>    PXSX      S4         *disabled
>    RP07      S4         *disabled
>    PXSX      S4         *disabled
>    RP08      S4         *disabled
>    PXSX      S4         *disabled
>    RP09      S4         *enabled   pci:0000:00:06.0
>    PXSX      S4         *disabled  pci:0000:01:00.0
>    RP10      S4         *disabled
>    PXSX      S4         *disabled
>    RP11      S4         *disabled
>    PXSX      S4         *disabled
>    RP12      S4         *disabled
>    PXSX      S4         *disabled
>    TXHC      S4         *enabled   pci:0000:00:0d.0
>    TDM0      S4         *enabled   pci:0000:00:0d.2
>    TDM1      S4         *disabled
>    TRP0      S4         *disabled
>    PXSX      S4         *disabled
>    TRP1      S4         *enabled   pci:0000:00:07.0
>    PXSX      S4         *disabled
>    TRP2      S4         *disabled
>    PXSX      S4         *disabled
>    TRP3      S4         *disabled
>    PXSX      S4         *disabled
>
> As I said, I don't actually understand what I'm doing here, but I'd
> really like to learn! It would be really cool if I ended up having to
> write and contribute my first driver!
>
> Sorry if I am somehow posting this incorrectly. This is my first time
> communicating here, just trying my best.

You already provided a lot of data, good job :).

I think that we do not need another driver in this case, as the xiaomi-wmi=
 driver
is responsible for handling WMI events on Xiaomi devices. I can check what=
 needs
to be done in order to add support for those additional keyboard events, b=
ut for
that i need the full output of acpidump.

Thanks,
Armin Wolf

>
> P.S. CC'ing W_Armin@gmx.de, linux@weissschuh.net and fengwk94@gmail.com
> since I've got the impression you have some experience with this.
>

