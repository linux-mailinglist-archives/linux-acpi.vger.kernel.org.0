Return-Path: <linux-acpi+bounces-4989-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660EA8A3B78
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Apr 2024 09:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07291F223F1
	for <lists+linux-acpi@lfdr.de>; Sat, 13 Apr 2024 07:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACE01CD39;
	Sat, 13 Apr 2024 07:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aSgbbn62"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3D333C5
	for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 07:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712993970; cv=none; b=Fy7DTS9aVqOnNAUbSEH48RUmTBaIzd7z3Q7RtMEE9y1/YBEoPBJjeTFxkZnhN3T473EflAp/8whP54wsM0/HdrCFN/tCJSSt1hg/iJWU43ysPCswZSbFNaiXIyjjGL3wxL/dlxTTlGgNhZ26Lb4pTBe26BEtjjOuIEDE0KRNuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712993970; c=relaxed/simple;
	bh=THA54mTHnxlwGRcOfqJBJ5oecxOmGAHiv7CzGirlZRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/iSlkSQqjscrVgEkIIPtxrBUnckc4tjPIqVqeD4oTfUcHc+Yz3bQsVjWyddTYa/INVFJV2/IunkOOeCq77Ao4NYMbnSg07FKxmC2diXE8EYdL8ZUHRG3Xj/o5CIB7El8k2B0YigtEoFokrz2cfUYaNkc8yxB8XMVkMlE3KNi+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aSgbbn62; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c6fefbfb86so182279b6e.2
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 00:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712993967; x=1713598767; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qMyf5Oj5lrQbMkI22lImwyVKQFhh8ozHX3TjsQhzrkQ=;
        b=aSgbbn62f4oriHOrK4qyUKRrRexB0fGwruZyH0bMJUPD9OLeeyG/2i+oaMuatR/KNV
         4PCXkcBnfjbmi+P0QKOPJ3f0Sj7l8BSxI52A9BWhHg+YiPro9SryxWml2wpwz6Aw95eK
         /+bkOdupJzA6DXLMGFORIRyy/7i9i5WdjzmgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712993967; x=1713598767;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMyf5Oj5lrQbMkI22lImwyVKQFhh8ozHX3TjsQhzrkQ=;
        b=G/Jj2pD0TdXA/7BxTPiFjZnMR1fRb89tywaLCjTDp242OhrgvZU3oHrUr9DpjjSH+j
         TWXVSbfnsAL1tQDNVlgvcg6TLKBaZ1WPcrI6Qyewas/QZY9rvNE5cwSEtYm1n1j2+ExN
         eyqFh590Kua7Vc+U4FpafnVxlG7yjcTvdq5XvErKM3X8Zij3ZXIgb3DPumF3nSX2LnVD
         OW+IacPTHTLAIrGjuywUbs4Ri8L8sLz/qgu5/LvmZqyvaamH66bm3LCfKWv1hRs1q8Ya
         wxmHNGwZeZI2tJqUQx3ewoZdVlw+UXcInr9tJZNo4nh8ZtvBEVdNTHETOej6yRuKe821
         3pIA==
X-Forwarded-Encrypted: i=1; AJvYcCXQM0iRQG0zIf8SJcc8hRRTidlM1N7q6/6au282VVhH/wS/k3MTSPfsVjvIwDzBvxQdtnWex2xDzymMoL7EUALkk4sZIa6mBlb/4g==
X-Gm-Message-State: AOJu0YzekO+/2FPThEagIpVeJsyC0bIXhdmVCASf9Zb27O106X/Ngge4
	TW+QW8uA0VYF+QRZdbh764sokyWfoZ2OnFkUg4AVLZjt7M4tIWUkrQPPubiuU1cSXpTV4KwrEpY
	=
X-Google-Smtp-Source: AGHT+IEAgTp64n90oyaFjwEJ3I72lJ1OJChYx4js+tvxgxTeUQ5utC94OjVbJ2kRkJFtp0HcSLWSwg==
X-Received: by 2002:a05:6808:9b6:b0:3c3:d932:4ae1 with SMTP id e22-20020a05680809b600b003c3d9324ae1mr4672601oig.35.1712993967171;
        Sat, 13 Apr 2024 00:39:27 -0700 (PDT)
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com. [209.85.219.51])
        by smtp.gmail.com with ESMTPSA id r8-20020ac87948000000b00436714b18b1sm2713295qtt.30.2024.04.13.00.39.26
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Apr 2024 00:39:26 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-69b4454e2f1so5719266d6.0
        for <linux-acpi@vger.kernel.org>; Sat, 13 Apr 2024 00:39:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWeaVGNIT03Oiz09RyIqpvMWYoY1v7TGFTbmniI/x04NWCK23chMLm0cFO/hiWyO2mLGwVJs+BL8p5Bfq0OHdsMroG10/t48sjvRQ==
X-Received: by 2002:a0c:ea27:0:b0:69b:bec:562e with SMTP id
 t7-20020a0cea27000000b0069b0bec562emr4999252qvp.12.1712993965596; Sat, 13 Apr
 2024 00:39:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiDSCtJKZDwSpy3RWW7FPQiJf+LqxrZJs=N7KrvCz0EFjh2wQ@mail.gmail.com>
 <Zhoeec0lfVEPmGj0@gpd>
In-Reply-To: <Zhoeec0lfVEPmGj0@gpd>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Sat, 13 Apr 2024 09:39:09 +0200
X-Gmail-Original-Message-ID: <CANiDSCuikv8Lw3x27qQnyNh=tBSkmcvYkUjaqL=8uMqLmn2A6w@mail.gmail.com>
Message-ID: <CANiDSCuikv8Lw3x27qQnyNh=tBSkmcvYkUjaqL=8uMqLmn2A6w@mail.gmail.com>
Subject: Re: ACPI timeouts when enabling KASAN
To: Andrea Righi <andrea.righi@canonical.com>
Cc: virtualization@lists.linux.dev, stevensd@chromium.org, 
	"mst@redhat.com" <mst@redhat.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 13 Apr 2024 at 07:56, Andrea Righi <andrea.righi@canonical.com> wrote:
>
> On Fri, Apr 12, 2024 at 11:43:22PM +0200, Ricardo Ribalda wrote:
> > Hi
>
> Hi Ricardo,

Hi Andrea!

>
> >
> > I am using virtme to do some CI around linux-media.
> >
> > Everything works as expected, but when I enable KASAN, I am starting
> > to get a lot of timeouts when the Method _PRT is executed. Eg:
> >
> > [   56.335875] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   56.529826] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   56.532391] virtio-pci 0000:00:02.0: can't derive routing for PCI INT A
> > [   56.532823] virtio-pci 0000:00:02.0: PCI INT A: no GSI
> > [   86.877471] ACPI Error: Aborting method \_SB.PCI0._PRT due to
> > previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> > [   87.073854] ACPI Error: Method execution failed \_SB.PCI0._PRT due
> > to previous error (AE_AML_LOOP_TIMEOUT) (20230628/uteval-68)
> > [   87.075550] virtio-pci 0000:00:04.0: can't derive routing for PCI INT A
> > [   87.075810] virtio-pci 0000:00:04.0: PCI INT A: no GSI
> >
> > 0000:00:04.0 and 0000:00:02.0 are virtio devices (console and 9p-filesystem)
> >
> > If I increase the timeout (ACPI_MAX_LOOP_TIMEOUT), then the Method is
> > always executed, but it is very annoying that I have to wait more than
> > 5 minutes to start the vm.
> >
> > Despite not having kvm enabled, the machine is quite decent, so I
> > would expect that it could run that method relatively fast.
> >
> > Do you have any hint of what I should be looking at?
>
> I'm wondering if it's a microvm-related issue...
>
> Can you try to add --disable-microvm to your virtme command line and see
> if it makes any difference?

I get the same results :(. BTW, this is the service that I think it is
taking lots of time:


            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                Local0 = Package (0x80){}
                Local1 = Zero
                While ((Local1 < 0x80))
                {
                    Local2 = (Local1 >> 0x02)
                    Local3 = ((Local1 + Local2) & 0x03)
                    If ((Local3 == Zero))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKD,
                                Zero
                            }
                    }

                    If ((Local3 == One))
                    {
                        If ((Local1 == 0x04))
                        {
                            Local4 = Package (0x04)
                                {
                                    Zero,
                                    Zero,
                                    LNKS,
                                    Zero
                                }
                        }
                        Else
                        {
                            Local4 = Package (0x04)
                                {
                                    Zero,
                                    Zero,
                                    LNKA,
                                    Zero
                                }
                        }
                    }

                    If ((Local3 == 0x02))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKB,
                                Zero
                            }
                    }

                    If ((Local3 == 0x03))
                    {
                        Local4 = Package (0x04)
                            {
                                Zero,
                                Zero,
                                LNKC,
                                Zero
                            }
                    }

                    Local4 [Zero] = ((Local2 << 0x10) | 0xFFFF)
                    Local4 [One] = (Local1 & 0x03)
                    Local0 [Local1] = Local4
                    Local1++
                }

                Return (Local0)
            }
        }
>
> Thanks,
> -Andrea
>
> >
> > Thanks!
> >
> > ```
> > # virtme-ng --version
> > virtme-ng 1.23
> > # qemu-system-amd64 --version
> > QEMU emulator version 8.2.1 (Debian 1:8.2.1+ds-2)
> > Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
> > # git describe
> > v6.9-rc3-208-g586b5dfb51b96
> >
> > # virtme-configkernel --defconfig --arch x86_64
> > # scripts/config -e KASAN
> > # make olddefconfig
> > # make all -j 256
> > # virtme-run --kdir . --mods=auto --show-command --show-boot-console
> > --verbose  --cpus 2 --memory 4G --script-sh "echo HelloWorld"
> > ```
> >
> >
> >
> > --
> > Ricardo Ribalda
> > Software Engineer
> > ribalda@google.com



-- 
Ricardo Ribalda

