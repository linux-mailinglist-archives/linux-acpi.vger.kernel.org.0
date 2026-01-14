Return-Path: <linux-acpi+bounces-20324-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C628D1F9E0
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 16:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C9FD30089BF
	for <lists+linux-acpi@lfdr.de>; Wed, 14 Jan 2026 15:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FC9314D21;
	Wed, 14 Jan 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze/zU0JL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B9B314D0B
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768403272; cv=none; b=STtT0B1P6ixdi15AAYSGfl1ig9ch+bw14f2xCJqFGa9wYs5X6M3nYcf21KtSJnsKJGWS+3s9LQpELg/7xCNTP4SBhJ2uMWqBogySkdjYvAi1dliRTqmgZs7jm412rsD9/ljX9wqDPxVB5SAjfMnbLabtciOhVpVgRC5VH2E1+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768403272; c=relaxed/simple;
	bh=i9wMg14fRcwejDBHf8uxH/kO55NPxh0rwEf6jc8SAjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dy+vk31/4TlcnouMpWvPH5grocDfiwx1G1v+hk23UWuQ/tzRbNgBb6K+D3pqrfUq7Ty5KpqVo36o0gx3NN34aumMLL+KP1w2LzzIxYXF670qCrFpZf3k+hAa3gbuVgE9xNW4lCyyHrzYgC9vaTzm1RvG9NOULx2nb//rcB6UIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze/zU0JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F079C2BC87
	for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768403272;
	bh=i9wMg14fRcwejDBHf8uxH/kO55NPxh0rwEf6jc8SAjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ze/zU0JLIfRZ5UXxtR2eIUx94nJXVPsdT5W84QhdMnUH/xkHbq3Tnp/9dkategGTT
	 kpdhvgApkFNpEA6F2PqGevSQJVuGD9pFYg8Swlkh8/ZgOpiAl25l+R+hkRsatWOkFK
	 2wVZAB/39sRQxtTiEcd3QAqgL+F95oBZ+rv7epc6cnkvTJ3T7E4fNeWvLDxkmxANsS
	 73BAfJt4pPGGIx7+ce1y/V4hkEvxcgJ0UOOIj7X4C3Wsj8seAWxlg/G0gdg9eaCscu
	 tZnmSC4l+o8+3BkQ2/I3euM5dslCfgPPnlGLukVm8KhCAqF/Ma80HEv+kvpH0zQ8cy
	 ukFTa+kZy7XTA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-3f13043e2fdso3272421fac.1
        for <linux-acpi@vger.kernel.org>; Wed, 14 Jan 2026 07:07:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUPBGB5hjAXIlevqZs/QyFIJkxrm/QK8+SPzwRQeBmgnFL4NgarfFfV44LLGzY82GDB7dikbskgueKh@vger.kernel.org
X-Gm-Message-State: AOJu0YxcAG4RM6KRrbS5p5xOmPijikc5iTlugkpVvfzUE7wFYbmkI1Gf
	e/PutQLf//Wm0cOBGcyALRyOlF4ujLtsDjmTNr1V1DCiYT9v93zNiwMw7NNSeV8I4cupF6ge7fT
	cysMYeYUXTpJNkeU1LZDpjy1auN0hbVQ=
X-Received: by 2002:a05:6820:2226:b0:65b:33ec:1bca with SMTP id
 006d021491bc7-66102df1f28mr1780216eaf.60.1768403271148; Wed, 14 Jan 2026
 07:07:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231104909.80362-1-feng.tang@linux.alibaba.com>
 <aWUpQ04uNcXtp0wR@bogus> <aWYBef5ZUNKVpg1W@U-2FWC9VHC-2323.local>
 <aWZZeD496CPi20Gc@bogus> <aWdAiaC10ear9ajR@U-2FWC9VHC-2323.local>
 <CAJZ5v0h-hjrE85_=6YOJ6oRRZ4=SmKWrs7hCKnrP6_KZTuDePw@mail.gmail.com>
 <aWeoA7LDNSB_F38I@U-2FWC9VHC-2323.local> <aWew4SHS4c34z0AU@bogus>
In-Reply-To: <aWew4SHS4c34z0AU@bogus>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 14 Jan 2026 16:07:40 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gEXGo0c=5MB6fJftAHysvYZ5RUjRG53E2cH4GKF7SdqQ@mail.gmail.com>
X-Gm-Features: AZwV_QjOKe0gCepbVYF90364-SLeBLfpa6hl6I84mCegNIF5L-VGj_qeApT72yQ
Message-ID: <CAJZ5v0gEXGo0c=5MB6fJftAHysvYZ5RUjRG53E2cH4GKF7SdqQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: PPTT: Dump PPTT table when error detected
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Jeremy Linton <jeremy.linton@arm.com>, 
	Hanjun Guo <guohanjun@huawei.com>, James Morse <james.morse@arm.com>, 
	Joanthan Cameron <Jonathan.Cameron@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 4:06=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com>=
 wrote:
>
> On Wed, Jan 14, 2026 at 10:28:19PM +0800, Feng Tang wrote:
> >
> > As for the original issue where kernel printed the error message
> > " ACPI PPTT: PPTT table found, but unable to locate core 1 (1)",
> > can we just printed out all the CPU entries of the PPTT table?
> > which is much cleaner and smaller, and have the enough information
> > for quickly identifying the root cause. As the number of cache
> > items is usually 3X of number of CPUs.
>
> I am still not sure what additional value is gained by listing all those =
CPU
> entries. On a 512-CPU system, for example, if an issue is identified with=
 the
> entry for CPU 256, what extra information is obtained by listing all the =
other
> CPUs, such as those sharing the same L3 cache or entire list of CPUs on t=
his
> system?
>
> The message above already indicates that something is wrong with core
> (n =3D 1 in above case). If that is not sufficiently clear, it should be
> improved to be more specific about the issue. Simply listing all CPUs in =
the
> PPTT provides no additional insight and only results in an unnecessarily =
long
> and distracting CPU list in the kernel log.

Fair enough.

