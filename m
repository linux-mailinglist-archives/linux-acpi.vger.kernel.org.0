Return-Path: <linux-acpi+bounces-12594-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8579A77E27
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 16:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACDF1674B5
	for <lists+linux-acpi@lfdr.de>; Tue,  1 Apr 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2872046BC;
	Tue,  1 Apr 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="DUzdtYNk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD920408A
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743518809; cv=none; b=a1yteIgBDdDNhrVvjaIcKo1ykWwtBdUO017aebd2u++oaj4yf6YUvhPQDGF2nMlGDVRMybetZImoj8raT7fbELeb7UZhv0ukk4OymthFxbfgNENFdI5tPc98ROV90DuKJppgI+vVfRY1tQfhW/xeFcYo56lV8FvbMmQ370K0lbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743518809; c=relaxed/simple;
	bh=N3feEDcBYphI50eEUCLRV0Iiw2eXbnfxKw2m+PdGAU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hP74sWVL8XUJlLlHwQhW2PaMINrK+fJZKc/vYI84IurrEp4JqtKemRyG2HRllz81LUFbv8mkRMAw1vSYHQ0gKLe+yazZtlkw5FEbX502PM04F+rJ/S/V5zRP2J27CS72MZPSUVU/9dL2k9cGLyJYSeW0tePCrMQ4bQ9D4gLbMmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=DUzdtYNk; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 17FBB2E08F50
	for <linux-acpi@vger.kernel.org>; Tue,  1 Apr 2025 17:46:41 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1743518801;
	bh=N3feEDcBYphI50eEUCLRV0Iiw2eXbnfxKw2m+PdGAU0=;
	h=Received:From:Subject:To;
	b=DUzdtYNkYySR6e0GhERKegSNWGqKYHRd6QGvcrhhtxn9NKO36MFo/MuCPsafitKjx
	 h45I90ydQYeWf9JlJoJqhCckoS/sjhy/lwqw/ULOV80KBug2XedQwn4DHyr1XS/ru5
	 v3G3n38W849AAUpS8f9Gl7k+jVLEMotVDFOLLz+M=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.182) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f182.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-30c44a87b9cso43609981fa.3
        for <linux-acpi@vger.kernel.org>;
 Tue, 01 Apr 2025 07:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCWftPqpWXpSJiI74P2l1AnlaFWf4Z5PBBY/+B9uH/jeOxxecQ85rcrz3i4yXoKqYE5EIzaGPHEORW+0@vger.kernel.org
X-Gm-Message-State: AOJu0YzJaNsiootC+/vZGmwx/xoFGKC6WV6lB4YzoPHjZ00Y32CcGK1d
	SowFnMWoRCd8fAg7DvEON+KWrjPbe0d27ogFHYQLJOhQgJpvAT9zkbwMGHqcuur6gX0nVz6bmLn
	N9cK30jaLHAX/OcZGxECJqfz+MpY=
X-Google-Smtp-Source: 
 AGHT+IGrNmT908/4yMkd5AmcBod9v+aasMAiOiP16xfEAozUnUp7zsaajkgxK9PqO65QAlxm8g3XKSRJpl9nLwdyIKY=
X-Received: by 2002:a05:651c:505:b0:30c:7fe:9c95 with SMTP id
 38308e7fff4ca-30de022def0mr44762491fa.8.1743518800327; Tue, 01 Apr 2025
 07:46:40 -0700 (PDT)
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
In-Reply-To: <dbfd11bb-9cde-4ec7-a9ef-0c28b7961419@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 1 Apr 2025 16:46:28 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFodjNMxPkM+=CcBPtR4uuj73cSSqrBfpLvhL+a=U6f9g@mail.gmail.com>
X-Gm-Features: AQ5f1JqtMIsuXPz7mISz1uiOmV71uYaFY_kMzehYZFiF6EA6etgol1JIWX5jeY0
Message-ID: 
 <CAGwozwFodjNMxPkM+=CcBPtR4uuj73cSSqrBfpLvhL+a=U6f9g@mail.gmail.com>
Subject: Re: [PATCH] ACPI: EC: Set ec_no_wakeup for Lenovo Go S
To: Xino Ni <phnjs211@gmail.com>
Cc: mario.limonciello@amd.com, rafael@kernel.org,
	Xino JS1 Ni <nijs1@lenovo.com>, linux-acpi@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174351880147.15168.6498846756132770758@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

On Tue, 1 Apr 2025 at 16:17, Xino Ni <phnjs211@gmail.com> wrote:
>
>
>
> On 4/1/2025 5:01 PM, Antheas Kapenekakis wrote:
> > Anyways, you got what my problem here was. You nacked and bikeshed
> > this patch for 2 months, and that was after I did all the background
> > research, testing and deployed it [1], so you could find the real
> > cause, which I let you do as a _professional courtesy_. Then, out of a
> > sudden you are the primary author on a patch I authored and you nacked
> > and started testing after it was done [2].
> >
> > I guess a nicer way of saying this is that you make it hard to
> > collaborate on kernel development. When I bring up issues to you, do
> > the background research, bisect, and general grunt work for them, you
> > do a minor cleanup which is easy for you as a kernel developer, then
> > strip the credit for them and I have to hunt you down to get some of
> > it back. This is not a productive environment, I cannot work like
> > this.
> >
> > I think this is the 6th or 8th time this happened but this time it is
> > particularly egregious, because you had me spend 20 hours debugging
> > offshoots after my patch was already done in random directions trying
> > to find a real cause, only to see me get dropped to a normal reported
> > by, and that is after I told you off very harshly because of [2].
> > Otherwise the reported-by might have been missing too.
> >
> > In any case, there is no point in rehashing this over and over.
> > Authorship in this series is mostly fine now, so it can go through.
> >
> > And to avoid having this conversation again, there is another Legion
> > Go S [3] patch you nacked and froze the testing for, so you could go
> > on the manhunt for the real cause of this one. But it will probably be
> > needed and you will find that as you get TDP controls going. So if you
> > want me to prepare that in a timely manner, because that one actually
> > needs rewriting to be posted, now is the time to say so.
> >
> > Antheas
> >
> > [1] https://github.com/bazzite-org/kernel-bazzite/releases/tag/6.12.12-201
> > [2] https://gitlab.com/evlaV/linux-integration/-/
> > commit/6c5a3a96be9b061f07bf9a1bcc33156c932ddf67
> > [3] https://gitlab.freedesktop.org/drm/amd/-/issues/3929#note_2764760
>
> Dear Antheas,
>
> Thanks for all the amazing works and advice you have contributed to
> Legion Go S not only in the kernel but also the HHD, I'm honored to have
> you help on the product.
>
> I'd say it's unfair to blame Mario for this patch submission because
> it's actually my request to him and it's my failure on ODM management
> that cannot fix these FW/EC/BIOS wake up issues, we have to submit the
> patch to upstream as next kernel cycle begins.
>
> Further more, I'm very grateful to the specific issue you have spend a
> lot of personal time on it, you gave a very important guidance in issue
> debugging and help us clarify the root cause.
>
> As the project is the first time I work with the community, definitely I
> have a long way to learn how to work together and manage the
> development, so please forgive me on it.

Hi Xino,
no problems from my side. We tried our best to have it work but
sometimes life has it some other way. There is also no problem with
submitting the patch now, a month before or a month after. The
attribution is how it should be now, and that was the only problem, so
it's ok.

Antheas

> B/R
> Xino

