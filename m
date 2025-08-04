Return-Path: <linux-acpi+bounces-15514-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C500B1A019
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 12:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D71B189859F
	for <lists+linux-acpi@lfdr.de>; Mon,  4 Aug 2025 10:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F8A24EAB1;
	Mon,  4 Aug 2025 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JyPo5kKb"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B601A9B24;
	Mon,  4 Aug 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754305064; cv=none; b=eR7cqP16kYdYHFgASZgF5wBcJGOV1rK1/APSfUoTQqy2i9Bi45P5bSope6noFpH1U+4V/HWOIK108O9lKIOwIYV1pvQdM26NjlX0FJpW1j9m2Zl6XPYZ+vLdFC4pCyOqk1W05FB72gJSQhD/8Ri26DB0k8AW573GpbjGWElSJ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754305064; c=relaxed/simple;
	bh=EKcmbw33i158VkcjIOBGndTohyXppuVVNq4r8SoAwu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MtJjCizYJYzmRKElJyGr9AABzUyaz4cPfVpS+AgGP/BDXEJoAuFd668B2lRXl44c581RKv3I4sWdN/bJXChs6Lsbbu6+/riBdFy9MRFkapuER1tlU9DNGSnpHMQJi4PN+nI+XDTHPoIFi9UzzTEJUXE8IQPc1Dtu/UzZ5VSH4fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JyPo5kKb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adfb562266cso687272066b.0;
        Mon, 04 Aug 2025 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754305061; x=1754909861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKcmbw33i158VkcjIOBGndTohyXppuVVNq4r8SoAwu4=;
        b=JyPo5kKbOop7HxAJpYSIRwQNhWhuTrnhE6MfdAKENvyt4zk1rY4T9bv7UVlWdEJbPn
         yRfsqtlldRVipq2ecq+v3xm/Kh/wzi5BQMRUyaLRycBoM5lPR2MLdog9j6+ZTIMpcJKa
         fNBo1EX9OanuBor5aOiOTrrL5i464i2psCDGM1lLcB3v5ARUeSwZVK8Yiv/wO8xIQtJK
         RJbrvVl2lALDGMGUchV+Vvby2fi+i85WXtKZ7Wulm5ks7CdEd2wg+RSKh7DUJhCz1/+1
         sTJCTks5Wq5sQUR4qMXDZdqqgRINzA11OqVDfREehPMURmDVjNsGozh0UOiSHzG5bq5L
         CJ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754305061; x=1754909861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EKcmbw33i158VkcjIOBGndTohyXppuVVNq4r8SoAwu4=;
        b=Qsy8Db5/WaeUk6tzzq+T8N49ESGaWtOtKpSo9RyAAGGDPCrqPnFTgd256eCVR5zKhN
         xtBeedJoxAXDbdFUD6Rf3jvnzQ9Qi0XJLGkH+cubXJSOd5ejnBQC6j5+wzpAA78HaAl8
         S4XFgJ3vZDqHNA5llhfSCgrGRgq/N+JxrkkWVEt8oT98/wtnF9C7k3JIZFrvHo0o/GJB
         KP0i7VC9ShMY5VxKsEZAfM+PGvRdMN7iYO2AHBwobmEwzaOKYq7i4rGX0kLQ+rAtRZRS
         J6/CkhtxS6L14C13tpH0gJ3iduLV5Wp4IjGxI1FdMHvQ/WkrlpSi2WOW91Xx3SuvRo/p
         O8ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXVpNAcxuqUEZA1K/9D+8rdDGuBkdaHEioSdMrvDpzJhSHhZwDPy74IQgXnANXtYYtDZuR2quMJwwAq@vger.kernel.org, AJvYcCXX3eJB08NIE9AE4RcFNsfAHN+C912HxijQxKWKDwnInkrmsrIpwyWMVVoD/H0nIRrdsLAQsNjbWlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSgKBgtQhmW4XKt0F98N+dwsMZXclj+ONcSclaVTjLG4cqWlAp
	+Dq6t1ISLuxM9CZXraw2koMIEfjqG1JPueO+CTrfAc9xzEsxaKtiNYf5pi4n9vlL5LPpvEWLYaP
	D9bngVwivv2QfOKepu9D6292+VPYWxhU=
X-Gm-Gg: ASbGnctCfxMx1cJwpC8I3QUgmqPJtwaaLtlvSgWEF/fffgH9QqtZX8z2BFnVG9As/Rq
	XPpCyXZxJVOXmjnCIaId5LfRq7fcDVzXooQ8PRFfMOz1KmnHNBo55CVGCrnyWSkkdloIC+yUrmJ
	N86FujEay9h021cuw2FXeb944X9C82lsPhpNHBKBCzkUO6NAOgc7nGdAR6h2TzxKutbpSnNf6Rw
	d1g1hPkHPbQffF3qrA=
X-Google-Smtp-Source: AGHT+IEKgWeCpweInZoRf8h+ySc8h8Zd/5K3fLo9Iz1IaB8JQ0OeLLaC5QAwreLPpuNZD9vPayfW02ltcKhkV1SLfyI=
X-Received: by 2002:a17:907:2da5:b0:af2:5a26:b32a with SMTP id
 a640c23a62f3a-af9401a7898mr948553966b.30.1754305060799; Mon, 04 Aug 2025
 03:57:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com> <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
 <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com>
In-Reply-To: <0b15e33603a46f6cc7ad7d09a156044f11367169@intel.com>
From: Andy Mindful <andy.mindful@gmail.com>
Date: Mon, 4 Aug 2025 13:57:29 +0300
X-Gm-Features: Ac12FXzOJ88j54Uw6RBDAtH4-5VhCyZG1ALSoSGb8O5tAtMwgrRtuY8do-ly4uo
Message-ID: <CACTEcX47bUd2tp=LYkQnhK29Js=vLN0JfXL8Aq6mOFBVYumpzQ@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: regressions@lists.linux.dev, pbonzini@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org, ville.syrjala@linux.intel.com, 
	tglx@linutronix.de, Christian Brauner <brauner@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Double-checked bisect, looks like I've have found broken commit:

git bisect start
# status: waiting for both good and bad commits
# good: [6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1] Linux 6.7.11
git bisect good 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
# status: waiting for bad commit, 1 good commit known
# bad: [6613476e225e090cc9aad49be7fa504e290dd33d] Linux 6.8-rc1
git bisect bad 6613476e225e090cc9aad49be7fa504e290dd33d
# skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a
# good: [ba5afb9a84df2e6b26a1b6389b98849cd16ea757] fs: rework
listmount() implementation
git bisect good ba5afb9a84df2e6b26a1b6389b98849cd16ea757
# good: [61da593f4458f25c59f65cfd9ba1bda570db5db7] Merge tag
'media/v6.8-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
git bisect good 61da593f4458f25c59f65cfd9ba1bda570db5db7
# bad: [e38f734add21d75d76dbcf7b214f4823131c1bae] Merge tag
'staging-6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
git bisect bad e38f734add21d75d76dbcf7b214f4823131c1bae
# bad: [5d197e97fb106c09d3d013be341e5961fd70ec8a] Merge tag
'hsi-for-6.8' of
git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi
git bisect bad 5d197e97fb106c09d3d013be341e5961fd70ec8a
# good: [1b1934dbbdcf9aa2d507932ff488cec47999cf3f] Merge tag
'docs-6.8-2' of git://git.lwn.net/linux
git bisect good 1b1934dbbdcf9aa2d507932ff488cec47999cf3f
# bad: [8c9244af4dc8680a453e759331f0c93d5bde1898] Merge tag
'kvm-x86-svm-6.8' of https://github.com/kvm-x86/linux into HEAD
git bisect bad 8c9244af4dc8680a453e759331f0c93d5bde1898
# bad: [783288010035e4c250a0b6491a4642cdb8d30548] KVM: x86: add
missing "depends on KVM"
git bisect bad 783288010035e4c250a0b6491a4642cdb8d30548
# bad: [1c3c87d720cbd1ff86dc1bfc6df8ee9adce5879b] Merge tag
'kvm-x86-selftests-6.7-rcN' of https://github.com/kvm-x86/linux into
HEAD
git bisect bad 1c3c87d720cbd1ff86dc1bfc6df8ee9adce5879b
# good: [8d99e347c097ab3f9fb93d0f88dddf20051d7c88] KVM: selftests:
Convert lib's mem regions to KVM_SET_USER_MEMORY_REGION2
git bisect good 8d99e347c097ab3f9fb93d0f88dddf20051d7c88
# bad: [6c370dc65374db5afbc5c6c64c662f922a2555ad] Merge branch
'kvm-guestmemfd' into HEAD
git bisect bad 6c370dc65374db5afbc5c6c64c662f922a2555ad
# good: [43f623f350ce1c46c53b6b77f4dbe741af8c44f3] KVM: selftests: Add
x86-only selftest for private memory conversions
git bisect good 43f623f350ce1c46c53b6b77f4dbe741af8c44f3
# good: [8a89efd43423cb3005c5e641e846184e292c1465] KVM: selftests: Add
basic selftest for guest_memfd()
git bisect good 8a89efd43423cb3005c5e641e846184e292c1465
# good: [5d74316466f4aabdd2ee1e33b45e4933c9bc3ea1] KVM: selftests: Add
a memory region subtest to validate invalid flags
git bisect good 5d74316466f4aabdd2ee1e33b45e4933c9bc3ea1
# first bad commit: [6c370dc65374db5afbc5c6c64c662f922a2555ad] Merge
branch 'kvm-guestmemfd' into HEAD

=D0=BF=D0=BD, 4 =D1=81=D0=B5=D1=80=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 11:15=
 Jani Nikula <jani.nikula@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 03 Aug 2025, Andy Mindful <andy.mindful@gmail.com> wrote:
> > Here what I have from bisecting, please let me know if it makes things
> > clearer or not.
>
> Doesn't point at graphics, anyway.
>
> Cc: Christian.
>
>
> BR,
> Jani.
>
>
> >
> > git bisect log
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1] Linux 6.7.11
> > git bisect good 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [6613476e225e090cc9aad49be7fa504e290dd33d] Linux 6.8-rc1
> > git bisect bad 6613476e225e090cc9aad49be7fa504e290dd33d
> > # skip: [0dd3ee31125508cd67f7e7172247f05b7fd1753a] Linux 6.7
> > git bisect skip 0dd3ee31125508cd67f7e7172247f05b7fd1753a
> > # good: [ba5afb9a84df2e6b26a1b6389b98849cd16ea757] fs: rework
> > listmount() implementation
> > git bisect good ba5afb9a84df2e6b26a1b6389b98849cd16ea757
> > # good: [61da593f4458f25c59f65cfd9ba1bda570db5db7] Merge tag
> > 'media/v6.8-2' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> > git bisect good 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > # bad: [e38f734add21d75d76dbcf7b214f4823131c1bae] Merge tag
> > 'staging-6.8-rc1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging
> > git bisect bad e38f734add21d75d76dbcf7b214f4823131c1bae
> > # bad: [5d197e97fb106c09d3d013be341e5961fd70ec8a] Merge tag
> > 'hsi-for-6.8' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-hsi
> > git bisect bad 5d197e97fb106c09d3d013be341e5961fd70ec8a
> > # good: [1b1934dbbdcf9aa2d507932ff488cec47999cf3f] Merge tag
> > 'docs-6.8-2' of git://git.lwn.net/linux
> > git bisect good 1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > # good: [1b1934dbbdcf9aa2d507932ff488cec47999cf3f] Merge tag
> > 'docs-6.8-2' of git://git.lwn.net/linux
> > git bisect good 1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > # bad: [8c9244af4dc8680a453e759331f0c93d5bde1898] Merge tag
> > 'kvm-x86-svm-6.8' of https://github.com/kvm-x86/linux into HEAD
> > git bisect bad 8c9244af4dc8680a453e759331f0c93d5bde1898
> > # bad: [783288010035e4c250a0b6491a4642cdb8d30548] KVM: x86: add
> > missing "depends on KVM"
> > git bisect bad 783288010035e4c250a0b6491a4642cdb8d30548
> > # bad: [783288010035e4c250a0b6491a4642cdb8d30548] KVM: x86: add
> > missing "depends on KVM"
> > git bisect bad 783288010035e4c250a0b6491a4642cdb8d30548
> > # bad: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
> > git bisect bad 861deac3b092f37b2c5e6871732f3e11486f7082
> >
> > # being on a 861deac3b092
> > git bisect bad
> > The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
> > This means the bug has been fixed between
> > ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
> > [1b1934dbbdcf9aa2d507932ff488cec47999cf3f
> > 61da593f4458f25c59f65cfd9ba1bda570db5db7
> > 6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
> > ba5afb9a84df2e6b26a1b6389b98849cd16ea757].
> >
> > Thanks.
> >
> > =D0=B2=D1=82, 29 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 13:20 =
Jani Nikula <jani.nikula@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On Tue, 29 Jul 2025, Andy Mindful <andy.mindful@gmail.com> wrote:
> >> > Please let me know if any further information or testing is required=
.
> >>
> >> Likely the quickest way to find the root cause is to bisect the issue.
> >>
> >>
> >> BR,
> >> Jani.
> >>
> >> --
> >> Jani Nikula, Intel
>
> --
> Jani Nikula, Intel

