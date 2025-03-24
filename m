Return-Path: <linux-acpi+bounces-12409-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772A6A6D3FE
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 07:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFD616CE2D
	for <lists+linux-acpi@lfdr.de>; Mon, 24 Mar 2025 06:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33A5130AC8;
	Mon, 24 Mar 2025 06:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3w0aIHO"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A50134D4;
	Mon, 24 Mar 2025 06:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796401; cv=none; b=L3YstnareVPKMZQb6evTeKit0uSKCsWfkll6XQe1Abq4DA/yR+mkOaB2d8Vvex2reunF7Jp36Zuimn7+UhoSCuzrt3UDTG4b3b8LLT28LTDl+4UVroQn9bk7JSF6mhNbl6mqZGZgAptbKJoZiUboaZs1wmYboEzlwjL1drYmcME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796401; c=relaxed/simple;
	bh=3QWPYrygkvKmdtfY4tZoIshUamWMQpOTc/38UZ24KRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffRbzBIcLtHJQzvcWj3OdtC1t+C5yk0fvc6gqiLVqFW3UuYm5HDDYCDuERb9ZyaM/wrvPz3XBh3Vsw//Y5UA3tRuFvWl0wQ+bwHn9U8OGKCCnTReDRsZo5chdbk2ItCN6EHBCk6fQeL65HKs4+RdHmEZzTSfZNi3f9zrl8qOAL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3w0aIHO; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499659e669so4448359e87.3;
        Sun, 23 Mar 2025 23:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742796397; x=1743401197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6+La/06o/hNpfO9Htb9ip8NKJGTUg/3Nh9D7pegwlw=;
        b=a3w0aIHObUnG07IoI8SEcptnY40eGXrj5p40PMYX+QxCym6E7zZbBDE1goGXl2U9Ho
         /8J7y2yHUSzsZlIR+FVRNpv2YdvTBfHDGA17foxzqVSonmwFWrnjbooV9m+3S3JCOH8R
         Y8CUAeAt5Ca92buQLbEDBofkZJLnYgOYqSCOfYzKm/qtDU08THxUsV0pBuKF3CLcBo6d
         jt/iVDoUHW0RM1R8ryUeBE6HGgSa766GvWUFfwstbpcJUhIGmTqgRf6EtW9YLG1dtyfE
         NqBHkID4g+kUTHLh/A9xMy7cLGZZkOHh+iL8vSOhmqLRLysFSOqHZnNXJbwskEXp56Hg
         3LZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742796397; x=1743401197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6+La/06o/hNpfO9Htb9ip8NKJGTUg/3Nh9D7pegwlw=;
        b=OVQam5N3vhMnYCMIejkNmuxvB6TKfBoiWTVeDWLz3930bLqx+5cgxOE2wign34G6TO
         LN7rBNyQplYfe4PSFgyrxLs6F2jw/g0/EiQ0BI023tI8JJcCjJjagtPkqRYUuM4rIN08
         2wOPaY18bGYe1Yvo3UbbG8QsUsH+7aH7VDOUoTpwzLHWq35H8zG2JkRffi4YVSSFCWZL
         ZLxMOE+hAWCDXVUxLkVBiOKD3af55pkUVWKpAgHb88b+P7Dn7/ToHA90tRz9UL1FIIeE
         iOKgdwc55DPjYk4ePyGf51r4nbOHYhzLy2eHV6b/kORDP7NC1TA/5CYPoThsrNSHVaSb
         KNwg==
X-Forwarded-Encrypted: i=1; AJvYcCWH/hDyHg1vX2v6+64YkMz8wfX+ZfW9i1HXWDruUp5cvA4iDtCa14vF3/oMjdHb4bdvyQrh14fym20BPNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiXaxhOqq6oZbJsCeW20WkxmH5zikb/Ll+gOTrEG0eQ5X4Bo0I
	97pQQEBLwE03bw0wWXFn7n9eUzajMtO9F6c42MfMRsFzAkA4tJgqTtvz7fAyZlY5E/lHSCGW8N9
	FrVPJn50NNoEN8D2Kin2oJAIkkg==
X-Gm-Gg: ASbGncsQCbnroeaq4X0X/qZXPB2dU01nRR6DujUXClDBPszF5XUJTd59ZN3iiGWqwMW
	/or79HF96X7vjHnwAuvq7Q4hmutDqvXNe00du0Ro25RYSl+OImxGVshP5ago5nBvuK0RR7nkt54
	O8H0a/mywRLpCavd3tYGMB8d96Tw==
X-Google-Smtp-Source: AGHT+IFUhll+7JSFc8Ehk+nfMsa+fstfVxwLN2MBZJKqMDOB5JXE9rTKNth6TDiI6hA68CStQDxsHp58xpR6VrXrnaI=
X-Received: by 2002:ac2:51d2:0:b0:549:490e:240d with SMTP id
 2adb3069b0e04-54ad64a6d4amr4148109e87.28.1742796397011; Sun, 23 Mar 2025
 23:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMciSVUVjLj44LW+3ALB1fJQsUiw_2BQ5tLgpNJH08Xmj=Wr9w@mail.gmail.com>
 <07e2fb25-625b-441e-86f7-d0d54138c4aa@gmx.de> <CAMciSVUwy2cB4=hdX7Qki4Uc3maYdyrWa9t=_c9Uth=Pzh-KAg@mail.gmail.com>
 <d713393c-5d08-4b7f-8d5a-1a65f6f29f59@gmx.de>
In-Reply-To: <d713393c-5d08-4b7f-8d5a-1a65f6f29f59@gmx.de>
From: Naveen Kumar P <naveenkumar.parna@gmail.com>
Date: Mon, 24 Mar 2025 11:36:24 +0530
X-Gm-Features: AQ5f1Joc9gp_QYXoM8kK28SXOFU9NAgdFxv8TpxqkfkgKqKt5_4fMS21KGIwDko
Message-ID: <CAMciSVXLkCrhUTXcf2WZiDkhHSO-Wdp3MhuK6ASkUL+ObtWvmw@mail.gmail.com>
Subject: Re: ACPI Error: AE_AML_LOOP_TIMEOUT in \_SB.PCI0.SBUS.RDWD & \_SB.PCI0.SBRG.ADP1._PSR
To: Armin Wolf <W_Armin@gmx.de>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 3:25=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 22.03.25 um 16:40 schrieb Naveen Kumar P:
>
> > On Sat, Mar 22, 2025 at 3:02=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 19.03.25 um 12:29 schrieb Naveen Kumar P:
> >>
> >>> Hi all,
> >>>
> >>> I am encountering repeated AE_AML_LOOP_TIMEOUT errors in the ACPI RDW=
D
> >>> & \_SB.PCI0.SBRG.ADP1._PSR methods. Below are relevant log entries
> >>> from my system running Linux kernel 6.13.0+:
> >>>
> >>> [77998.038653]
> >>>                  Initialized Local Variables for Method [RDWD]:
> >>> [77998.038691]   Local1: 00000000d0fe9fee <Obj>           Integer
> >>> 0000000000000015
> >>> [77998.038862]   Local6: 00000000f41c1645 <Obj>           Integer
> >>> 0000000000000000
> >>> [77998.039031]   Local7: 0000000040665c5c <Obj>           Integer
> >>> 000000000000AA55
> >>>
> >>> [77998.039237] Initialized Arguments for Method [RDWD]:  (2 arguments
> >>> defined for method invocation)
> >>> [77998.039273]   Arg0:   00000000397dc53d <Obj>           Integer
> >>> 0000000000000014
> >>> [77998.039442]   Arg1:   000000001099e334 <Obj>           Integer
> >>> 0000000000000002
> >>>
> >>> [77998.039673] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> >>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [77998.040455] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> >>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [77998.043659] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> >>> state: AE_AML_LOOP_TIMEOUT
> >>>
> >>> [78028.442980]
> >>>                  Initialized Local Variables for Method [RDWD]:
> >>> [78028.443019]   Local1: 00000000898a9a7e <Obj>           Integer
> >>> 0000000000000017
> >>> [78028.443192]   Local6: 000000000cf0c853 <Obj>           Integer
> >>> 0000000000000000
> >>> [78028.443362]   Local7: 00000000bb4aa65f <Obj>           Integer
> >>> 000000000000AA55
> >>>
> >>> [78028.443569] Initialized Arguments for Method [RDWD]:  (2 arguments
> >>> defined for method invocation)
> >>> [78028.443606]   Arg0:   00000000ef8d445b <Obj>           Integer
> >>> 0000000000000016
> >>> [78028.443775]   Arg1:   000000006cacc887 <Obj>           Integer
> >>> 0000000000000003
> >>>
> >>> [78028.444006] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> >>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [78028.446366] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> >>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [78028.451179] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> >>> state: AE_AML_LOOP_TIMEOUT
> >>>
> >>> [78032.877472]
> >>>                  Initialized Local Variables for Method [RDWD]:
> >>> [78032.877509]   Local1: 00000000cf6291ae <Obj>           Integer
> >>> 0000000000000017
> >>> [78032.877682]   Local6: 0000000026aa8a7a <Obj>           Integer
> >>> 0000000000000003
> >>> [78032.877851]   Local7: 00000000acfa20e0 <Obj>           Integer
> >>> 000000000000AA55
> >>>
> >>> [78032.878058] Initialized Arguments for Method [RDWD]:  (2 arguments
> >>> defined for method invocation)
> >>> [78032.878094]   Arg0:   00000000a186096f <Obj>           Integer
> >>> 0000000000000016
> >>> [78032.878262]   Arg1:   00000000d0e1eefe <Obj>           Integer
> >>> 0000000000000003
> >>>
> >>> [78032.878492] ACPI Error: Aborting method \_SB.PCI0.SBUS.RDWD due to
> >>> previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [78032.881011] ACPI Error: Aborting method \_SB.PCI0.SBRG.ADP1._PSR
> >>> due to previous error (AE_AML_LOOP_TIMEOUT) (20240827/psparse-529)
> >>> [78032.883061] ACPI: \_SB_.PCI0.SBRG.ADP1: Error reading AC Adapter
> >>> state: AE_AML_LOOP_TIMEOUT
> >>>
> >>>
> >>> This issue appears randomly, affecting the RDWD method, which is
> >>> likely responsible for reading data from a bus, and consequently
> >>> causing the _PSR method (power state read) to fail.
> >>>
> >>>
> >>> Questions:
> >>> 1. What typically causes AE_AML_LOOP_TIMEOUT errors?
> >> AFAIK this error is caused by a while loop taking too long to finish. =
I suspect that
> >> the ACPI bytecode tries to wait for a non-responsive hardware device.
> >>
> >>> 2. Could these ACPI errors impact PCI device access?
> >>> Since the error originates from _SB.PCI0.SBUS.RDWD, could this failur=
e
> >>> affect PCI device communication or cause failures when accessing PCI
> >>> devices?
> >> I do not think so, the SBUS device is likely just a SMBus controller a=
ttached to the PCI bus.
> >>
> >>> 3. Could this be a firmware/BIOS issue?If so, what tools or steps
> >>> should I use to verify and debug the ACPI tables?
> >> It is either a hardware issue or a BIOS bug. Can you share the output =
of the "acpidump" utility
> >> provided by the ACPICA project? Many Linux distributions already packa=
ge ACPICA in their package repositories.
> > I have attached the acpi.tar.gz file as requested. This archive
> > contains the output from the "acpidump" utility. Below is a list of
> > the files included in the archive:
> >
> > ls -ltr acpi
> > total 760
> > -rw-rw-r-- 1 murphy murphy 205609 Mar 19 18:30 acpi_tables.txt
> > -rw-r--r-- 1 root   root       60 Mar 19 18:31 mcfg.dat
> > -rw-r--r-- 1 root   root      132 Mar 19 18:31 apic.dat
> > -rw-r--r-- 1 root   root      656 Mar 19 18:31 ssdt2.dat
> > -rw-r--r-- 1 root   root       66 Mar 19 18:31 uefi.dat
> > -rw-r--r-- 1 root   root    36402 Mar 19 18:31 dsdt.dat
> > -rw-r--r-- 1 root   root      260 Mar 19 18:31 lpit.dat
> > -rw-r--r-- 1 root   root      378 Mar 19 18:31 ssdt3.dat
> > -rw-r--r-- 1 root   root      268 Mar 19 18:31 facp.dat
> > -rw-r--r-- 1 root   root       68 Mar 19 18:31 fpdt.dat
> > -rw-r--r-- 1 root   root     1891 Mar 19 18:31 ssdt1.dat
> > -rw-r--r-- 1 root   root      332 Mar 19 18:31 csrt.dat
> > -rw-r--r-- 1 root   root       56 Mar 19 18:31 hpet.dat
> > -rw-r--r-- 1 root   root       64 Mar 19 18:31 facs.dat
> > -rw-r--r-- 1 root   root      890 Mar 19 18:31 ssdt4.dat
> > -rw-r--r-- 1 root   root      141 Mar 19 18:31 ssdt7.dat
> > -rw-r--r-- 1 root   root     1075 Mar 19 18:31 ssdt5.dat
> > -rw-r--r-- 1 root   root      351 Mar 19 18:31 ssdt6.dat
> > -rw-rw-r-- 1 murphy murphy   5919 Mar 19 18:31 apic.dsl
> > -rw-rw-r-- 1 murphy murphy   8131 Mar 19 18:31 csrt.dsl
> > -rw-rw-r-- 1 murphy murphy 337832 Mar 19 18:31 dsdt.dsl
> > -rw-rw-r-- 1 murphy murphy  10103 Mar 19 18:31 facp.dsl
> > -rw-rw-r-- 1 murphy murphy   1368 Mar 19 18:31 facs.dsl
> > -rw-rw-r-- 1 murphy murphy   1802 Mar 19 18:31 fpdt.dsl
> > -rw-rw-r-- 1 murphy murphy   1863 Mar 19 18:31 hpet.dsl
> > -rw-rw-r-- 1 murphy murphy   7523 Mar 19 18:31 lpit.dsl
> > -rw-rw-r-- 1 murphy murphy   1524 Mar 19 18:31 mcfg.dsl
> > -rw-rw-r-- 1 murphy murphy   9996 Mar 19 18:31 ssdt1.dsl
> > -rw-rw-r-- 1 murphy murphy   7692 Mar 19 18:31 ssdt2.dsl
> > -rw-rw-r-- 1 murphy murphy   4296 Mar 19 18:31 ssdt3.dsl
> > -rw-rw-r-- 1 murphy murphy   8290 Mar 19 18:31 ssdt4.dsl
> > -rw-rw-r-- 1 murphy murphy  16968 Mar 19 18:31 ssdt5.dsl
> > -rw-rw-r-- 1 murphy murphy   2843 Mar 19 18:31 ssdt6.dsl
> > -rw-rw-r-- 1 murphy murphy   1337 Mar 19 18:31 ssdt7.dsl
> > -rw-rw-r-- 1 murphy murphy   1383 Mar 19 18:31 uefi.dsl
> >
> >
> > Please let me know if you need any further details or additional
> > information to assist in debugging the ACPI tables.
> >
> > Thank you for your help.
>
> Alright, it seems that the ACPI bytecode is trying to access the charger =
using the smbus interface.
> For some reason this takes over 30 seconds which causes the ACPI interpre=
ter to throw this error.
>
> Can you check how long it normally takes to read the "online" sysfs attri=
bute of the charger located
> under "/sys/class/power_supply/ADP1"?
I have written a script to measure the time it takes to read the
"online" sysfs attribute of the charger located under
/sys/class/power_supply/ADP1. Below is the script and the results:

$cat test.sh
#!/bin/bash

start_time=3D$(date +%s%N)
cat /sys/class/power_supply/ADP1/online
end_time=3D$(date +%s%N)

elapsed_time=3D$((end_time - start_time))
echo "Time taken: $((elapsed_time / 1000000)) ms"

$ sudo ./test.sh
1
Time taken: 3809 ms

$ sudo ./test.sh
1
Time taken: 1688 ms

$ sudo ./test.sh
1
Time taken: 1685 ms

$ sudo ./test.sh
1
Time taken: 1688 ms


As you can see, the first run took 3809 ms, and the subsequent runs
took around 1688 ms.

>
> Also please share the output of "lspci -v".
$ sudo lspci -v
00:00.0 Host bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series SoC Transaction Register (rev 11)
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series SoC Transaction Register
        Flags: bus master, fast devsel, latency 0
        Kernel driver in use: iosf_mbi_pci

00:02.0 VGA compatible controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Graphics & Display (rev 11) (prog-if 00 [VGA
controller])
        DeviceName:  Onboard IGD
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Graphics & Display
        Flags: bus master, fast devsel, latency 0, IRQ 97
        Memory at b0000000 (32-bit, non-prefetchable) [size=3D4M]
        Memory at a0000000 (32-bit, prefetchable) [size=3D256M]
        I/O ports at e080 [size=3D8]
        Expansion ROM at 000c0000 [virtual] [disabled] [size=3D128K]
        Capabilities: [d0] Power Management version 2
        Capabilities: [90] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Capabilities: [b0] Vendor Specific Information: Len=3D07 <?>
        Kernel driver in use: i915
        Kernel modules: i915

00:13.0 SATA controller: Intel Corporation Atom Processor E3800 Series
SATA AHCI Controller (rev 11) (prog-if 01 [AHCI 1.0])
        Subsystem: Intel Corporation Atom Processor E3800 Series SATA
AHCI Controller
        Flags: bus master, 66MHz, medium devsel, latency 0, IRQ 91
        I/O ports at e070 [size=3D8]
        I/O ports at e060 [size=3D4]
        I/O ports at e050 [size=3D8]
        I/O ports at e040 [size=3D4]
        I/O ports at e020 [size=3D32]
        Memory at b0b17000 (32-bit, non-prefetchable) [size=3D2K]
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Capabilities: [70] Power Management version 3
        Capabilities: [a8] SATA HBA v1.0
        Kernel driver in use: ahci
        Kernel modules: ahci

00:14.0 USB controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx, Celeron N2000 Series USB xHCI (rev 11) (prog-if 30
[XHCI])
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx,
Celeron N2000 Series USB xHCI
        Flags: bus master, medium devsel, latency 0, IRQ 90
        Memory at b0b00000 (64-bit, non-prefetchable) [size=3D64K]
        Capabilities: [70] Power Management version 2
        Capabilities: [80] MSI: Enable+ Count=3D1/8 Maskable- 64bit+
        Kernel driver in use: xhci_hcd

00:17.0 SD Host controller: Intel Corporation Atom Processor E3800
Series eMMC 4.5 Controller (rev 11) (prog-if 01)
        Flags: bus master, fast devsel, latency 0, IRQ 23
        Memory at b0b16000 (32-bit, non-prefetchable) [size=3D4K]
        Memory at b0b15000 (32-bit, non-prefetchable) [size=3D4K]
        Capabilities: [80] Power Management version 3
        Kernel driver in use: sdhci-pci
        Kernel modules: sdhci_pci

00:1a.0 Encryption controller: Intel Corporation Atom Processor
Z36xxx/Z37xxx Series Trusted Execution Engine (rev 11)
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Trusted Execution Engine
        Flags: bus master, fast devsel, latency 0, IRQ 98
        Memory at b0900000 (32-bit, non-prefetchable) [size=3D1M]
        Memory at b0800000 (32-bit, non-prefetchable) [size=3D1M]
        Capabilities: [80] Power Management version 3
        Capabilities: [a0] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Kernel driver in use: mei_txe
        Kernel modules: mei_txe

00:1b.0 Audio device: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller (rev 11)
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series High Definition Audio Controller
        Flags: bus master, fast devsel, latency 0, IRQ 10
        Memory at b0b10000 (64-bit, non-prefetchable) [size=3D16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] MSI: Enable- Count=3D1/1 Maskable- 64bit+
        Kernel modules: snd_hda_intel

00:1c.0 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 1 (rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 87
        Bus: primary=3D00, secondary=3D01, subordinate=3D01, sec-latency=3D=
0
        I/O behind bridge: 00001000-00001fff [size=3D4K]
        Memory behind bridge: b0400000-b07fffff [size=3D4M]
        Prefetchable memory behind bridge: [disabled]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Intel Corporation Atom Processor
E3800 Series PCI Express Root Port 1
        Capabilities: [a0] Power Management version 3
        Kernel driver in use: pcieport

00:1c.2 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 3 (rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 88
        Bus: primary=3D00, secondary=3D02, subordinate=3D02, sec-latency=3D=
0
        I/O behind bridge: 00002000-00002fff [size=3D4K]
        Memory behind bridge: [disabled]
        Prefetchable memory behind bridge: [disabled]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Intel Corporation Atom Processor
E3800 Series PCI Express Root Port 3
        Capabilities: [a0] Power Management version 3
        Kernel driver in use: pcieport

00:1c.3 PCI bridge: Intel Corporation Atom Processor E3800 Series PCI
Express Root Port 4 (rev 11) (prog-if 00 [Normal decode])
        Flags: bus master, fast devsel, latency 0, IRQ 89
        Bus: primary=3D00, secondary=3D03, subordinate=3D03, sec-latency=3D=
0
        I/O behind bridge: 0000d000-0000dfff [size=3D4K]
        Memory behind bridge: b0a00000-b0afffff [size=3D1M]
        Prefetchable memory behind bridge: [disabled]
        Capabilities: [40] Express Root Port (Slot+), MSI 00
        Capabilities: [80] MSI: Enable+ Count=3D1/1 Maskable- 64bit-
        Capabilities: [90] Subsystem: Intel Corporation Atom Processor
E3800 Series PCI Express Root Port 4
        Capabilities: [a0] Power Management version 3
        Kernel driver in use: pcieport

00:1f.0 ISA bridge: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Power Control Unit (rev 11)
        Subsystem: Intel Corporation Atom Processor Z36xxx/Z37xxx
Series Power Control Unit
        Flags: bus master, medium devsel, latency 0
        Capabilities: [e0] Vendor Specific Information: Len=3D0c <?>
        Kernel driver in use: lpc_ich
        Kernel modules: lpc_ich

00:1f.3 SMBus: Intel Corporation Atom Processor E3800 Series SMBus
Controller (rev 11)
        Subsystem: Intel Corporation Atom Processor E3800 Series SMBus
Controller
        Flags: medium devsel, IRQ 18
        Memory at b0b14000 (32-bit, non-prefetchable) [size=3D32]
        I/O ports at e000 [size=3D32]
        Capabilities: [50] Power Management version 3
        Kernel driver in use: i801_smbus
        Kernel modules: i2c_i801

01:00.0 RAM memory: PLDA Device 5555
        Subsystem: Device 4000:0000
        Flags: fast devsel, IRQ 11
        Memory at b0400000 (32-bit, non-prefetchable) [virtual] [size=3D4M]
        Capabilities: [40] Power Management version 3
        Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit-
        Capabilities: [60] Express Endpoint, MSI 00

03:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network
Connection (rev 03)
        Flags: bus master, fast devsel, latency 0, IRQ 19
        Memory at b0a00000 (32-bit, non-prefetchable) [size=3D512K]
        I/O ports at d000 [size=3D32]
        Memory at b0a80000 (32-bit, non-prefetchable) [size=3D16K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable- Count=3D1/1 Maskable+ 64bit+
        Capabilities: [70] MSI-X: Enable+ Count=3D5 Masked-
        Capabilities: [a0] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [140] Device Serial Number 00-30-64-ff-ff-a2-59-aa
        Capabilities: [1a0] Transaction Processing Hints
        Kernel driver in use: igb
        Kernel modules: igb

>
> Thanks,
> Armin Wolf
>
> >>> 4. Is there a recommended workaround to mitigate this issue?
> >> You can check if a BIOS update is available for your device.
> >>
> >>> 4. How can I debug this further?I can enable additional ACPI debuggin=
g
> >>> logs or provide dumps of ACPI tables if necessary.
> >> I can take a look at the \_SB.PCI0.SBUS.RDWD method inside the ACPI ta=
ble dumps
> >> to see where the error is coming from.
> >>
> >> Thanks,
> >> Armin Wolf
> >>
> >>> Any guidance on resolving or further diagnosing this issue would be
> >>> highly appreciated.
> >>>
> >>> Best regards,
> >>> Naveen
> >>>

