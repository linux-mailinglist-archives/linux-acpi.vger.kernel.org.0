Return-Path: <linux-acpi+bounces-15522-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9B5B1A9CB
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 21:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28ADE7A5261
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 19:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF385233D9E;
	Mon,  4 Aug 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ezXsiYyn"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FDCA920;
	Mon,  4 Aug 2025 19:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754336998; cv=none; b=Px+b9deVzhw8myGxl6c1LXMgzg3vMWDDFxd/F7YG1ttcE+Z9RTwJo3jXdOk4QyepJfQuN7rAhmo2AsSutZAqO3IK20CNcs5aQd+NasqG7ALS0jbBB9ShFyDjwPm3vROyhBFKR9KtNFwKG21fmxqIbAVE/KwieeB5DubS9xL5gVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754336998; c=relaxed/simple;
	bh=GNzexns6pcPBUTEkIeqnIu/h9x9Gke1nRAkCyAK2Td4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dR/XHasUTBV5aDIRs0u2vu6yKuYclOUGBiXxhlFSc6Ro4HMLl6/40pi/ux89LNy8RTJXknEHKhciV4t0iBqD0bF3Vu0fqQoAl2j4WXzOjQdNYPoK6zmX+scVdeBQbo8vk4bS0VEap5xf3/r3uakl/VgYdyYTK//nMnuBKZ9rEbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ezXsiYyn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-af922ab4849so687049266b.3;
        Mon, 04 Aug 2025 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754336995; x=1754941795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNzexns6pcPBUTEkIeqnIu/h9x9Gke1nRAkCyAK2Td4=;
        b=ezXsiYynU03TOXBCxB4z6tuoNoX/55qoqhLz7pxKiZKRx96Opni0fsZ1xTAgC3DBq/
         Z94Mcf/QQQN2j7R0ESCKTIn9SOC+iE8bi9bovJZ5IHFpuLB/T8vESppsdGjHYvmpSn7w
         6Xt4KtOCSJG0gzEgiu808ZpDoDvSRR8gj3PaTRPZbfOcH1CZcKNx1nE20062VAB+unU1
         yjD3nZgv9bNpWtARXTtiwLML2NMhLeLVhJQR0noC/cznxgN8xzTYYoUxcwE6ndMrf+4+
         kSrjxQSbB6IIuE+cAe10w7duUqm+7JAkN+pdNg1W2BvuMjCrZ2IhLjPIkpCRIbSQa7zr
         FHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754336995; x=1754941795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNzexns6pcPBUTEkIeqnIu/h9x9Gke1nRAkCyAK2Td4=;
        b=f3uzRgCZ3HW1v0F9So/2/OAq9Y7T/TkHF+cit8FKSEYQ8XCIRKwsBsEJfJCfnmfraX
         Jk39Wlw22vmm1sv9VoqmnwMSFcJ3la+rGwsBh/tm+Vlw6Do0YNbLuq/HVi3GGNeaystD
         L2jOlWNFKtOYSy7pBevohw51CRICq4UAqNtre5nxXzjnlDRFpIqValPeHQH2o0m6ZBrD
         C8CHTw7hhCGAtBtrJcxmyZDZY7IoqwAaug4sMngFlYe5CYvBAJfAMQdyqIHaKHl/4NFX
         YP2vLY9kqm9UBnaxm38V18/xjYrJ0Dl37w1J9hYlOroVxs0T6HZRZCzW2afPBSlPm/xR
         PzSw==
X-Forwarded-Encrypted: i=1; AJvYcCVkVkeDP069LkG774qJwyfgH8YuiviNGZyjBPLhV5QeN80I/KqBZ04DfZKa7SELU6mYxTGgfnyZrMCD@vger.kernel.org, AJvYcCWYyx8nW8PxiTod469sM6613m63xaCZNrCudvRHSEVbIYcTjqIW8qI8O3Ph4tDWAnwRTwIBswxCjFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmayEOcMWlUPuXNe3WTHJN7HktS05GocFfUKY6C2fwP8UkQDi2
	GZKzG4+eZ7orneNelxvJKjkhXVGVz67WzdyIL328BykT1vOuPWeJ/ES0Zt9iWEFx0XOyBkd+gGy
	DFebuYmhBfBDi462dP4sa8rMz3uO1mdg=
X-Gm-Gg: ASbGncv2207x6rgYKWqKchi+w61H+IrVvbogufh5q7sgoe9AELV20MTN04IqRQydBxw
	a/Vz27Mfz6S+s1pKxnarYF5fmV5gSPrz1cwo1WarOt5PoyI37Guqkgk3xCsGKJb68xXWUIxlfX7
	bLKJwnVHDx2JQTu4gABWxwJMhXDi908dTc/uVaG+DQ3gQ5yB27r7cWmFAfeTn0uths8G3cYzJ1f
	q7xa+w=
X-Google-Smtp-Source: AGHT+IGcMq3bxCdaYN7JTYB4ZRdZj5ChB4GQUWGwwN1A04vvH51/5tRA4ycCUTXjUODp6yMy5vQnnC3OMmCbWz5atD4=
X-Received: by 2002:a17:907:9407:b0:ae0:cc5f:88ef with SMTP id
 a640c23a62f3a-af9401af514mr1075474166b.32.1754336995289; Mon, 04 Aug 2025
 12:49:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com> <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
 <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
In-Reply-To: <CABgObfZKKeqMrAUyS8CB4ARkW_8Z9QREgpgYcq2jxoQ9ppS6MA@mail.gmail.com>
From: Andy Mindful <andy.mindful@gmail.com>
Date: Mon, 4 Aug 2025 22:49:43 +0300
X-Gm-Features: Ac12FXwoncyyo3lMGdVFGmeOSercSw0CMzqTN4N7YKEyC89vLmt21SqpqVGopCE
Message-ID: <CACTEcX7oa+Shj=uYiRMoWpng+RZXDeQrOa-VTRmzVVtXJMCgLQ@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, ville.syrjala@linux.intel.com, 
	tglx@linutronix.de, Christian Brauner <brauner@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Can you please advise on how to bisect further?

andy@lenovo:~/linux-stable$ git bisect bad
The merge base 0dd3ee31125508cd67f7e7172247f05b7fd1753a is bad.
This means the bug has been fixed between
0dd3ee31125508cd67f7e7172247f05b7fd1753a and
[6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1].

andy@DESKTOP-0R165CF:~/linux-stable$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# good: [6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1] Linux 6.7.11
git bisect good 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
# status: waiting for bad commit, 1 good commit known
# bad: [6613476e225e090cc9aad49be7fa504e290dd33d] Linux 6.8-rc1
git bisect bad 6613476e225e090cc9aad49be7fa504e290dd33d
# bad: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect bad 0dd3ee31125508cd67f7e7172247f05b7fd1753a

andy@lenovo:~/linux-stable$ git status
HEAD detached at 0dd3ee311255
You are currently bisecting, started from branch '6fc5460ed8dd'.
(use "git bisect reset" to get back to the original branch)

It is not moving further.

=D0=BF=D0=BD, 4 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 17:50=
 Paolo Bonzini <pbonzini@redhat.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon, Aug 4, 2025 at 12:57=E2=80=AFPM Andy Mindful <andy.mindful@gmail.=
com> wrote:
> > Double-checked bisect, looks like I've have found broken commit:
> >
> > > > git bisect bad
> > > > The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
> > > > This means the bug has been fixed between
> > > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
> > > > [1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > > > 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > > > 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > > > ba5afb9a84df2e6b26a1b6389b98849cd16ea757].
>
> This skip is messing up the results:
>
> # skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
> git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a
>
> and there are still 3858 commits in
> ba5afb9a84df2e6b26a1b6389b98849cd16ea757..{1b1934dbbdcf9aa2d507932ff488ce=
c47999cf3f,61da593f4458f25c59f65cfd9ba1bda570db5db7,ba5afb9a84df2e6b26a1b63=
89b98849cd16ea757}
>
> Any chance you can get 6.7 to work and restrict the range further?
>
> Thanks,
>
> Paolo
>

