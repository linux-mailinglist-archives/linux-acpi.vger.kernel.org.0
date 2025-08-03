Return-Path: <linux-acpi+bounces-15473-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B4DB1940E
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E36031894D8F
	for <lists+linux-acpi@lfdr.de>; Sun,  3 Aug 2025 12:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8842222AA;
	Sun,  3 Aug 2025 12:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k7kYE4oF"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16622746A;
	Sun,  3 Aug 2025 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754225121; cv=none; b=QTs/Z2k4ikllNSp6QuHKC5PuX/7lMaojewRBO2fgYXeCvbYw21p+rf5jaNYtQSD9UKl6M419FERE+OxWe1VFtF82ftBNyYnxaWx95em/SRllQ+2MduMki0ZnQ4qnjhPRjuZ8Dz1qA4hz3En1+F87/MVKYHDIZnV3I3ZMyAt+q/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754225121; c=relaxed/simple;
	bh=pxXOv0H77qu3boXS8S20sjf3H+BGpeAjIG2LP7StaE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcIK7aA8xIjq/Zrg5PyQtbBQZoLW+3jTpg5d12+OaaislWpENWBP/+eV70cXtEpIRWQvAyOofLpl/ufYtImGI3fnXxSWCnz0WLkZa+E54MJep591vv/Ldy2iKALkTzxO0Kvqurynb3v4qAXTet/G3OSDl6q3W+vMc5r7xRA4+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k7kYE4oF; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-af93381a1d2so344966866b.3;
        Sun, 03 Aug 2025 05:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754225118; x=1754829918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxXOv0H77qu3boXS8S20sjf3H+BGpeAjIG2LP7StaE4=;
        b=k7kYE4oFGuti2HSDFuyv+URUCmwrYaQe3X0mfNHPdilRnRT0pZctZog/BOFBuN/FE1
         B6mSxbVGEAomasxZZ0TZkMw2OF0N3VEiA1ALbnO5gxCN4fL3V5llLwdfWXrqpQhsubzS
         amLN71a8CvhmasYD91woYG3cC21sS8eTZN76YUfmOGF7xYlJwWZYfMVMiX+SFE1JFmkV
         2GURASwC7Wyn0XpStZWNX4N/40fb3E+IQ0aKnpDFS1ONi3nXpyJCVoP33no09brwlNv/
         kg4Xo2iUqysj7FACOw7ozc4mLDLeLjqSzYlocQA8VT3xS8BEToHNJOkhqscZU1cYficP
         LUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754225118; x=1754829918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxXOv0H77qu3boXS8S20sjf3H+BGpeAjIG2LP7StaE4=;
        b=atXm7B0zyisWk/yohBtTYpXvddZSeA/0IPDRa80D5lJkN3xJKlNCXRjxpFUwg2XYns
         SGZzifEMdloA55fUwEKrB1A4Bw+JE2hoo3pZfX5PpDj5AJ2nBLh+aPk9+Vt5nHlGAvVO
         mfH+z4r3Z1W/JfAorsPxYJFSzQ/T1HjRbkjapXyLfZB5YYFfPufJf+NuaFdyvPNLPxDD
         /3t4lEl0jebVPdYdYdYvCojQ/M8ZwNMwmLM3xuWRqIqQmvKX78ErOrq4y1xfDg+t/x/8
         UDzwgT7b5UCkYhMY5xHBSi39ffr2TRrVB+wjBvYUUOMlDi9j+rZVOvmNagacUkOpRtDe
         bvPg==
X-Forwarded-Encrypted: i=1; AJvYcCUVvJkiH79zMsfqrnUehDISc19xgzNfsZ0qy9WmkavtBSVbwiXk6jchey/gkJPWPEavW4E0FspztCA9@vger.kernel.org, AJvYcCWVgqPct67g8W8c+kaJEfmiENNR2obFj3eNZQqBViGkPbaYiTwiLVTWBjfNoPLfRooQ4AiyisG42Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7VgIpJwCpewXf9ZmQRCH/Y+GTnUoHcJY2f9LgdSiFBUQrZ/a/
	X9NJ2omKR2XI+Co4GGcPA39r+oW5eDScSzoZ1xN45mNrMdOpQPtPWN06PypjYrbeVX0utHLF0eM
	DA7fSfGfQxp/PIPUfpVhww4p/yRfYWMjImY+IWab+dg==
X-Gm-Gg: ASbGncuknGGWBn0a38+2T364G7gom0b0qphD7RPBU8UM/Fm4vzRWkG8Lp1gylIv/YMD
	EWrOOFhMsb89kD82t58k3PigS2Zxqpg5YCL1ZrlXdy+Z4uAuA95kgmoYmTIYHzHTT0nFGLphR5Y
	bdmdFc7GEHBLvWubiQjuJxdwOxScAripdMT7Vq5w1PW0X7VMRHRvku9tFNzj5Ydp+0lNT19N9dZ
	ibwPOw=
X-Google-Smtp-Source: AGHT+IHFQr61biS993WpaTiLN314ukC/GGuYrmWFHzReiBI+xBUUZ2E1nmjUhmzhYsuLobiRAM+1bP/mpJx6eUe4McA=
X-Received: by 2002:a17:907:724a:b0:ae0:aa0d:7bfa with SMTP id
 a640c23a62f3a-af9402301f3mr558310866b.50.1754225117967; Sun, 03 Aug 2025
 05:45:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACTEcX6oXBot1VBApOyKVMVXsAN9BsvQMLa8J0iKpNeB-eLttQ@mail.gmail.com>
 <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com>
In-Reply-To: <642d439ea1be8e48ee5c47fd3921a786452fb931@intel.com>
From: Andy Mindful <andy.mindful@gmail.com>
Date: Sun, 3 Aug 2025 15:45:06 +0300
X-Gm-Features: Ac12FXwQ1gQW4qwRV_K-3Velp0hCrjgNlIh5_C2All-wPbXiQ1zvu-N5hZpFRGU
Message-ID: <CACTEcX5Y3PNXNkhnK1dGFe+k3sigOZNpj66KKGAS9XeHqRu35w@mail.gmail.com>
Subject: Re: [REGRESSION] tty lockup and WWAN loss after hibernate/suspend in
 6.8+ on ThinkPad X1 Carbon Gen 10
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	rafael@kernel.org, ville.syrjala@linux.intel.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Here what I have from bisecting, please let me know if it makes things
clearer or not.

git bisect log
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
# good: [1b1934dbbdcf9aa2d507932ff488cec47999cf3f] Merge tag
'docs-6.8-2' of git://git.lwn.net/linux
git bisect good 1b1934dbbdcf9aa2d507932ff488cec47999cf3f
# bad: [8c9244af4dc8680a453e759331f0c93d5bde1898] Merge tag
'kvm-x86-svm-6.8' of https://github.com/kvm-x86/linux into HEAD
git bisect bad 8c9244af4dc8680a453e759331f0c93d5bde1898
# bad: [783288010035e4c250a0b6491a4642cdb8d30548] KVM: x86: add
missing "depends on KVM"
git bisect bad 783288010035e4c250a0b6491a4642cdb8d30548
# bad: [783288010035e4c250a0b6491a4642cdb8d30548] KVM: x86: add
missing "depends on KVM"
git bisect bad 783288010035e4c250a0b6491a4642cdb8d30548
# bad: [861deac3b092f37b2c5e6871732f3e11486f7082] Linux 6.7-rc7
git bisect bad 861deac3b092f37b2c5e6871732f3e11486f7082

# being on a 861deac3b092
git bisect bad
The merge base ba5afb9a84df2e6b26a1b6389b98849cd16ea757 is bad.
This means the bug has been fixed between
ba5afb9a84df2e6b26a1b6389b98849cd16ea757 and
[1b1934dbbdcf9aa2d507932ff488cec47999cf3f
61da593f4458f25c59f65cfd9ba1bda570db5db7
6fc5460ed8dd0edf29e7c5cfb1ef9b1aa04208a1
ba5afb9a84df2e6b26a1b6389b98849cd16ea757].

Thanks.

=D0=B2=D1=82, 29 =D0=BB=D0=B8=D0=BF. 2025=E2=80=AF=D1=80. =D0=BE 13:20 Jani=
 Nikula <jani.nikula@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Tue, 29 Jul 2025, Andy Mindful <andy.mindful@gmail.com> wrote:
> > Please let me know if any further information or testing is required.
>
> Likely the quickest way to find the root cause is to bisect the issue.
>
>
> BR,
> Jani.
>
> --
> Jani Nikula, Intel

