Return-Path: <linux-acpi+bounces-6550-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F6910DC9
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 18:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F361528102D
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2024 16:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433FF1B29D9;
	Thu, 20 Jun 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnMMtLSW"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55F51AF6B5
	for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902651; cv=none; b=n525x3+3aAgH0IhLaX0Zv+7iNCjxuuq4aLaDiedvXimKtkAIRpmsD9KN6vfeid+Q5ryiZ2F8jtjmn8oS1pdzwc9CChv4wRVKPW4bQkHP1/n5ucauj2lQLkgBNwbemmI9HhcYM9ND+7o51dw5XJ2cRaagBzdXqxk0aJZoomSu9DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902651; c=relaxed/simple;
	bh=GQ2u9nlvCCmbQcOK3sHGBC0Y25LY3TAFeCu0TSsziQU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:Mime-Version:
	 References:In-Reply-To; b=B7qsHrniwAlMGeKjkFB3JIYqROz1k74tVOR7pUhIK240sApfI4J8i4ZWkRvQwH6DuE0Q720FXmrc4neib0NLEP0vOmT5UiAkec5VK13R4BJ5sy7FI1tcZge5QlAzmxXP/N2Q/TvWGIqQsOuJpFsmbDQRNG4n5hUZ0LNHNx8p0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnMMtLSW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-701b0b0be38so1049968b3a.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2024 09:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718902649; x=1719507449; darn=vger.kernel.org;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ScEFnUHD+aEd+rEVGdWkqTgafwPbJxvZugkaqP4HK4=;
        b=jnMMtLSWgCkpVvXObSO4/MF7LFotC+WfLhbFknn7MAZUUDHikNVCP33uezyDBrHZ06
         qnLS7BTym3+HrelkGPpY20jaRtLhdC4cvtpAVFEZHBM5mzwLOMZSxyftolImGYSuNLsx
         Q+kwauYLi0MbPmrn6dS8jmET7+8RtEEm6tUGEyDP+w7lRFcwgKMsnqlULuqX4UFjPPrg
         zWG7ySYrfmI+zlBlSrWjhTZ1ueU9PVK9w8QsxDQS+lmomMzKMc9ryAG0dh18EbpBwwCq
         1AwNfhiff9nDRlvtGEn0+MDncUqB6H55wM+OZFR8Q55pt4yKwZNSTKm7jZUn3BJfkpzx
         wefA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718902649; x=1719507449;
        h=in-reply-to:references:mime-version:content-transfer-encoding:to
         :from:subject:cc:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ScEFnUHD+aEd+rEVGdWkqTgafwPbJxvZugkaqP4HK4=;
        b=d19TDGgL4nw/o17TeK1VOQVu9x7RhwxbeQz2rHf1qcYpYp2z31m8Ci353GBS7vFdUO
         jgua8+z/3ySaT2KZnGTLQw1Jp+eQ1Ivw1TQhzcFCJh1EX54SV+qWthTTDQ4Tq/7KPevn
         X6FLvo4Jl3x8fjlC3LYJMonkGru2S29Rfzsry39EoPzQyp/FJyAxV12KAO2Kfl5hRMtz
         KW/34hljFEnuGrG0dHsP2NHlPXgMpyuVw4wsohqBptOgGCJYxR7KEnrPreacRH8dMRUL
         bUTnoeM7nOI4ITld588Fe+8+SGY7q4tnIxAXnRR59f1zbMnBIYHt/uoaosV4NqlIHIGq
         fDMg==
X-Gm-Message-State: AOJu0Yxc2750Pb4naURdOSjC2opsrKYwbfV3x38Mg2M3mRD1FOYb2WqM
	w2VwluMOfHA28lEbalYCABja3+CTgehEjIFNZKLNaBWvPZsaeJvhuLuXEucH
X-Google-Smtp-Source: AGHT+IGxKKKt7qbwiwD3DtaOrQk3t8hZYnaaaiZeCNVFBy5V6s9yhgUg+WckVO6+f+8hwH0QwVyamw==
X-Received: by 2002:a05:6a00:2e9a:b0:706:334a:43d1 with SMTP id d2e1a72fcca58-706334a455cmr7048085b3a.10.1718902648824;
        Thu, 20 Jun 2024 09:57:28 -0700 (PDT)
Received: from localhost ([2001:f70:860:4100:e712:ac1a:da07:2e53])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf0becf4sm11245464a12.44.2024.06.20.09.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 09:57:28 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Jun 2024 01:57:20 +0900
Message-Id: <D2504RNGXBRM.3DUONJULSWL6H@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH] ACPI: EC: Use ec_no_wakeup on ThinkPad T14 Gen 5
From: "Yutaro Ohno" <yutaro.ono.418@gmail.com>
To: "Mark Pearson" <mpearson-lenovo@squebb.ca>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Len Brown" <lenb@kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.17.0
References: <ZnFYpWHJ5Ml724Nv@ohnotp>
 <40ec6e11-c279-44ba-993f-2f2475c15073@app.fastmail.com>
 <D24VBFQ86ZIA.3KHVV0P1I3MNX@gmail.com>
 <6b80e4cb-47fb-4467-b834-ffa04c9b4d8e@app.fastmail.com>
In-Reply-To: <6b80e4cb-47fb-4467-b834-ffa04c9b4d8e@app.fastmail.com>

On Fri Jun 21, 2024 at 12:35 AM JST, Mark Pearson wrote:
> >>  - Get a report from running the Intel S0ix test tool - https://github=
.com/intel/S0ixSelftestTool. Run it with the -S option
> >
> > It may not work as my machine is not Intel, but here's the output:
> <snip>
>
> Yeah - that won't work. The AMD test tool is here:
> https://gitlab.freedesktop.org/drm/amd/-/blob/master/scripts/amd_s2idle.p=
y
> Can you try that please?

Sure. I've tried with/without the kernel parameter `acpi.ec_no_wakeup=3D1`.

Booting with the kernel parameter:
```
$ sudo python3 amd_s2idle.py
Location of log file (default s2idle_report-2024-06-21.txt)?
Debugging script for s2idle on AMD systems
=F0=9F=92=BB LENOVO 21MCCTO1WW (ThinkPad T14 Gen 5) running BIOS 1.4 (R2LET=
23W (1.04 )) released 04/01/2024 and EC 1.1
=F0=9F=90=A7 Arch Linux
=F0=9F=90=A7 Kernel 6.9.5-arch1-1
=F0=9F=94=8B Battery BAT0 (SMP 5B11H56415) is operating at 101.22% of desig=
n
Checking prerequisites for s2idle
=E2=9C=85 Logs are provided via systemd
=E2=9C=85 AMD Ryzen 7 PRO 8840U w/ Radeon 780M Graphics (family 19 model 75=
)
=E2=9C=85 SMT enabled
=E2=9C=85 LPS0 _DSM enabled
=E2=9C=85 ACPI FADT supports Low-power S0 idle
=E2=9C=85 HSMP driver `amd_hsmp` not detected (blocked: False)
=E2=9C=85 PMC driver `amd_pmc` loaded (Program 0 Firmware 76.83.0)
=E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.5
=E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.6
=E2=9C=85 GPU driver `amdgpu` bound to 0000:c4:00.0
=E2=9C=85 System is configured for s2idle
=E2=9C=85 NVME KIOXIA Corporation NVMe SSD Controller XG8 is configured for=
 s2idle in BIOS
=E2=9C=85 GPIO driver `pinctrl_amd` available
=F0=9F=9A=A6 Device firmware checks unavailable without gobject introspecti=
on
=E2=9C=85 WCN6855 WLAN (fw build id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SIL=
ICONZ_LITE-3.6510.37)
How long should suspend cycles last in seconds (default 10)?
How long to wait in between suspend cycles in seconds (default 4)?
How many suspend cycles to run (default 1)?
Started at 2024-06-21 01:05:15.386691 (cycle finish expected @ 2024-06-21 0=
1:05:29.386714)
Results from last s2idle cycle
=E2=97=8B Suspend count: 1
=E2=97=8B Hardware sleep cycle count: 1
=E2=97=8B Wakeup triggered from IRQ 9: ACPI SCI
=E2=97=8B Woke up from IRQ 9: ACPI SCI
=E2=97=8B gpe07 increased from 9957 to 10219
=E2=9C=85 Userspace suspended for 0:00:12.386591
=E2=9C=85 In a hardware sleep state for 0:00:08.692840 (70.18%)
=F0=9F=94=8B Battery BAT0 lost 10000 =C2=B5Wh (0.02%) [Average rate 0.29W]
```

Booting without the kernel parameter:
```
$ sudo python3 ./amd_s2idle.py
Location of log file (default s2idle_report-2024-06-21.txt)?
Debugging script for s2idle on AMD systems
=F0=9F=92=BB LENOVO 21MCCTO1WW (ThinkPad T14 Gen 5) running BIOS 1.4 (R2LET=
23W (1.04 )) released 04/01/2024 and EC 1.1
=F0=9F=90=A7 Arch Linux
=F0=9F=90=A7 Kernel 6.9.5-arch1-1
=F0=9F=94=8B Battery BAT0 (SMP 5B11H56415) is operating at 101.22% of desig=
n
Checking prerequisites for s2idle
=E2=9C=85 Logs are provided via systemd
=E2=9C=85 AMD Ryzen 7 PRO 8840U w/ Radeon 780M Graphics (family 19 model 75=
)
=E2=9C=85 SMT enabled
=E2=9C=85 LPS0 _DSM enabled
=E2=9C=85 ACPI FADT supports Low-power S0 idle
=E2=9C=85 HSMP driver `amd_hsmp` not detected (blocked: False)
=E2=9C=85 PMC driver `amd_pmc` loaded (Program 0 Firmware 76.83.0)
=E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.5
=E2=9C=85 USB4 driver `thunderbolt` bound to 0000:c6:00.6
=E2=9C=85 GPU driver `amdgpu` bound to 0000:c4:00.0
=E2=9C=85 System is configured for s2idle
=E2=9C=85 NVME KIOXIA Corporation NVMe SSD Controller XG8 is configured for=
 s2idle in BIOS
=E2=9C=85 GPIO driver `pinctrl_amd` available
=F0=9F=9A=A6 Device firmware checks unavailable without gobject introspecti=
on
=E2=9C=85 WCN6855 WLAN (fw build id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SIL=
ICONZ_LITE-3.6510.37)
How long should suspend cycles last in seconds (default 10)?
How long to wait in between suspend cycles in seconds (default 4)?
How many suspend cycles to run (default 1)?
Started at 2024-06-21 01:16:58.754215 (cycle finish expected @ 2024-06-21 0=
1:17:12.754238)
Results from last s2idle cycle
=E2=97=8B Suspend count: 1
=E2=97=8B Hardware sleep cycle count: 10
=E2=97=8B Wakeup triggered from IRQ 9: ACPI SCI
=E2=97=8B Woke up from IRQ 9: ACPI SCI
=E2=97=8B gpe07 increased from 1823 to 2085
=E2=9C=85 Userspace suspended for 0:00:12.962868
=E2=9C=85 In a hardware sleep state for 0:00:01.672448 (12.90%)
=F0=9F=94=8B Battery BAT0 lost 30000 =C2=B5Wh (0.06%) [Average rate 0.83W]
```

> One more question - which Wifi module do you have? The Qualcomm NCM825 Wi=
fi7 device still has a lot of problems (it's currently the main thing gatin=
g our Linux certification of the platform).

From `lspci`, it's the QCNFA765.

Thanks,
Yutaro

