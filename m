Return-Path: <linux-acpi+bounces-12597-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463ADA77E87
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 17:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAE27A2317
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2713D205ABB;
	Tue,  1 Apr 2025 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="UOqEQ6dH"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C551205E2F
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743519958; cv=none; b=nKkgGr1Z81UQgPdLS+zJl7unq/BXkPFPcm8NxtjZlA9lsUd8At2fIjRqzhgKKcL+gBExI0x/xKf6cY4CE961AGCwIduWbPCuODinL7Ntw/twdS1Qnm9OmLWeS3TWfLINCeyY99qVi9ia4Ywd7W1kLMjGv1NNaakDYfUnrmjR//0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743519958; c=relaxed/simple;
	bh=NXj17ioKCyyKjo6IcPqiGIKbZQnYvFUOfAxdMwlDt/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SG/xyyoenu8uZpVlC/AVLURM97kCvFCg5D9YXNn7/Wry/m3Y8wftMsdZCp/mgpLUiiWXK2pz/ScHnF8EUvIvErMY/zMSS1isb0c5R9Bf0PN3cLEInzdOHxCUyYSJbcInSfUjQ5fDX1cu5Spn7na8dsqE4WamQcFSb3WId74mGjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=UOqEQ6dH; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 2E5E42E09136
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 18:05:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743519953;
	bh=NXj17ioKCyyKjo6IcPqiGIKbZQnYvFUOfAxdMwlDt/k=;
	h=Received:From:Subject:To;
	b=UOqEQ6dHGggEMjEAfeLRbxGRaJWZS5BG5u9ipGQ5OGjy4ijt91bmYFzoR2MgS7FXa
	 cOR33HdjNndS2z0IEBPG/r7YMH395JO+48By8aYiF29S4i0/hYeIBQH369hSiLv3+6
	 nSX9WVYYl9fbM6TkxjIw21tpPRBsy7EsjXwHqGXc=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f180.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f180.google.com with SMTP id
 38308e7fff4ca-30613802a6bso57369851fa.1
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 08:05:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWRHjAwNv8xox4CudcuBWPfJ+4TW7fAvBq7GaeNeBRAZztZ0qgaQPy8MzyDLaeuwiYY5cXUGj3qP/bQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk0s1MZIX7TECDgIGDZ238Yy9pHIGLMIZJ5UZM95NWmgZKrW6R
	b11EX7PU4yp9at5zMNnmqIq1CwPCsbdi+bdOB2FsAVjZ5bKC5sDTOSJgeL5XS1QQk/gkWg6BboO
	UURgItR/EJchcZHxJEyfAkR6nXMM=
X-Google-Smtp-Source: 
 AGHT+IHwvBKwuC/c4lVQirxAwT5Xa88KYZ660yueYRSr90mY3w7L1yCiR5QqyqpVFsQkSITGhWIQVkQ+9q9sczWv5zU=
X-Received: by 2002:a05:651c:1478:b0:30d:b3d1:a71 with SMTP id
 38308e7fff4ca-30de0357fcfmr56053721fa.33.1743519948261; Tue, 01 Apr 2025
 08:05:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331204442.1727618-1-superm1@kernel.org>
 <CAGwozwHyRiyVkX8rsc69gkALScWdtXNAvAGn7c2aEXW_qgdWsA@mail.gmail.com>
 <CAGwozwEiCXFDi73qAPSm2K9A8OZutE7dbjFfCmbUSAOTaz8SEA@mail.gmail.com>
 <50cc3227-93eb-4cb8-8151-23e52ca91f80@kernel.org>
 <CAGwozwH7r-7uELUB1fiftAf3ziU6irgW92qiHHNOpuJ-87=WJw@mail.gmail.com>
 <90d704dc-51ea-4c98-ba4a-f95460f65061@kernel.org>
 <CAGwozwEoCc_nRodt2=6R5K5UOzhW+5Gx1uLS3H3ON4ZS_12gBg@mail.gmail.com>
 <dbfd11bb-9cde-4ec7-a9ef-0c28b7961419@gmail.com>
 <CAGwozwFodjNMxPkM+=CcBPtR4uuj73cSSqrBfpLvhL+a=U6f9g@mail.gmail.com>
 <cd7ca9d3-0ff9-4492-95e9-3d9d615ed027@gmail.com>
In-Reply-To: <cd7ca9d3-0ff9-4492-95e9-3d9d615ed027@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 17:05:35 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEXK6jSf+QcSi1O7gMT-r04u3Pj6CacTyG7B2fVJMdKNA@mail.gmail.com>
X-Gm-Features: AQ5f1JqpGmK7jggYVLRjPnihTRhYnobGPBbQ1NfVE4vcZLLppXSzUkgZR6hQVJ8
Message-ID: 
 <CAGwozwEXK6jSf+QcSi1O7gMT-r04u3Pj6CacTyG7B2fVJMdKNA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Xino Ni <phnjs211@gmail.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174351995177.31074.16682967482335840179@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 16:58, Xino Ni <phnjs211@gmail.com> wrote:
>
> > Hi Xino,
> > no problems from my side. We tried our best to have it work but
> > sometimes life has it some other way. There is also no problem with
> > submitting the patch now, a month before or a month after. The
> > attribution is how it should be now, and that was the only problem, so
> > it's ok.
>
> Thanks again.
>
> I'd like to share more progress in the debug:
>
> After the BIOS implement standard _BTP method, the sleep-to-dead issue
> is not happen again when battery is fully charged, and the fake sleep
> heat problem is fixed also. But we observed OS crash to reboot directly
> when wake up, same as you observed.
>
> So you are right, the issue can be divided into three parts:
> 1. _BTP make the OS wake up time to time
> 2. Touch Panel signal gating device sleep again
> 3. something from EC/BIOS crashed the OS when wake up

I still got N3 on mine afterwards on performance mode. Only on
performance mode, or 30+W TDP, and only while in a game. So a lot
less.

But it has been 2 months. Does performance mode work correctly now?
Even when in-game?

If yes, then an additional patch is not needed.

Antheas

> We failed to resolve below two issues, and thanks to the ec_no_wakeup
> quirk, we never encounter below two issues after introducing it.
>
> Xino
>
> On 4/1/2025 10:46 PM, Antheas Kapenekakis wrote:
> > On Tue, 1 Apr 2025 at 16:17, Xino Ni <phnjs211@gmail.com> wrote:
> >>
> >>
> >>
> >> On 4/1/2025 5:01 PM, Antheas Kapenekakis wrote:
> >>> Anyways, you got what my problem here was. You nacked and bikeshed
> >>> this patch for 2 months, and that was after I did all the background
> >>> research, testing and deployed it [1], so you could find the real
> >>> cause, which I let you do as a _professional courtesy_. Then, out of a
> >>> sudden you are the primary author on a patch I authored and you nacked
> >>> and started testing after it was done [2].
> >>>
> >>> I guess a nicer way of saying this is that you make it hard to
> >>> collaborate on kernel development. When I bring up issues to you, do
> >>> the background research, bisect, and general grunt work for them, you
> >>> do a minor cleanup which is easy for you as a kernel developer, then
> >>> strip the credit for them and I have to hunt you down to get some of
> >>> it back. This is not a productive environment, I cannot work like
> >>> this.
> >>>
> >>> I think this is the 6th or 8th time this happened but this time it is
> >>> particularly egregious, because you had me spend 20 hours debugging
> >>> offshoots after my patch was already done in random directions trying
> >>> to find a real cause, only to see me get dropped to a normal reported
> >>> by, and that is after I told you off very harshly because of [2].
> >>> Otherwise the reported-by might have been missing too.
> >>>
> >>> In any case, there is no point in rehashing this over and over.
> >>> Authorship in this series is mostly fine now, so it can go through.
> >>>
> >>> And to avoid having this conversation again, there is another Legion
> >>> Go S [3] patch you nacked and froze the testing for, so you could go
> >>> on the manhunt for the real cause of this one. But it will probably be
> >>> needed and you will find that as you get TDP controls going. So if you
> >>> want me to prepare that in a timely manner, because that one actually
> >>> needs rewriting to be posted, now is the time to say so.
> >>>
> >>> Antheas
> >>>
> >>> [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> >>> [2] https://gitlab.com/evlaV/linux-integration/-/
> >>> commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> >>> [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
> >>
> >> Dear Antheas,
> >>
> >> Thanks for all the amazing works and advice you have contributed to
> >> Legion Go S not only in the kernel but also the HHD, I'm honored to have
> >> you help on the product.
> >>
> >> I'd say it's unfair to blame Mario for this patch submission because
> >> it's actually my request to him and it's my failure on ODM management
> >> that cannot fix these FW/EC/BIOS wake up issues, we have to submit the
> >> patch to upstream as next kernel cycle begins.
> >>
> >> Further more, I'm very grateful to the specific issue you have spend a
> >> lot of personal time on it, you gave a very important guidance in issue
> >> debugging and help us clarify the root cause.
> >>
> >> As the project is the first time I work with the community, definitely I
> >> have a long way to learn how to work together and manage the
> >> development, so please forgive me on it.
> >
> > Hi Xino,
> > no problems from my side. We tried our best to have it work but
> > sometimes life has it some other way. There is also no problem with
> > submitting the patch now, a month before or a month after. The
> > attribution is how it should be now, and that was the only problem, so
> > it's ok.
> >
> > Antheas
> >
> >> B/R
> >> Xino
> >
>

