Return-Path: <linux-acpi+bounces-10637-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CA3A10DC5
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 18:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0353A2AF1
	for <lists+linux-acpi@lfdr.de>; Tue, 14 Jan 2025 17:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318691D3576;
	Tue, 14 Jan 2025 17:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOA1DEF6"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0596714A609;
	Tue, 14 Jan 2025 17:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875767; cv=none; b=hj6sdXe+4xATwgu4L5aykMJhC03JjW6iem+Azzlx7IX0RroKADg3J8+5J5OiBC1w/q7RmREbxhYu/H/X6ZtfZ1+/CvMGmQsIJxa1TBs9NKnC/1kWX++QJL6pqdnLdTPiH98vGj1N+v+OrlLMwHTnYfM94mTrFCexb9DnlNGpB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875767; c=relaxed/simple;
	bh=TkFCMzhVxdhNr+Bis623+fc8S6ZZnrfPwokt//tZ3ag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgWys+GNltkRIPO1O3HKHdQZkj+j+sqWO9L/qdWaPt0Fei+zft50Pjc3J06ezPBou0wLpzfnSv6k/Ua6Qk/fDksf5uix0VjyhObvnbpZ58b6P/BVXZYuNIA3c9LcjZpa6T8akc+NNpXzYNRxb8q0Y/8Gu666ylVuvJNSza/dmJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOA1DEF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A43DC4AF09;
	Tue, 14 Jan 2025 17:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875765;
	bh=TkFCMzhVxdhNr+Bis623+fc8S6ZZnrfPwokt//tZ3ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=vOA1DEF6VTG/fey2N8OSkxUIr3tvUM2l4xQUFQHme3c6LPpapUz2vzoGpt8tnLwL7
	 I0+8IxlmHeP/HddFKFyOikXzmo4nXBFN4Y/be39fISKvGuQ1o4ypZTGdKdg3vytpLm
	 qXjOr6uX0bDmfCTpAmVr6IdgnVgTkg1KD86xO2OieX6sGtE7yYq6PN67xpGoGAcKPq
	 kqYGN03+96nk+GMrwnnRlFMWNty9jMfJ550AazGVLb0vYw6l0LBXBHYVjd49onvSCB
	 2J4GlO9OsSi0ZyTj4GO7qyqDNeCv2PZnbYY9G70QmjAAsoT0Zfg4E+/mEyfvs48gw6
	 9ledrV3brxmrQ==
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3eba50d6da7so1449093b6e.2;
        Tue, 14 Jan 2025 09:29:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMGtyVgPMDYotL7Tiid1EmV4dgm1+AyNF1cOLAETbiXBNNj9E/Wk1QD9lW/0IUTf0sGMGFoLOSAJI+@vger.kernel.org, AJvYcCXRMgXt6pJxsEEZgPWKWmM2Ll5gSG9yac9Tr2Q7XfVekHU9CoDWnDKA3an/zcDUZSi9BdcDMQ5XUdOfRQ0P@vger.kernel.org
X-Gm-Message-State: AOJu0Yypg097J9D5tkOKb4Qujc60k5pow0JHpV9yRuLQtz9g006kZg+O
	6MU9Owbh19NitCkf0gW5kERRugonEKAohU5w/qorG+S9+q4n+K682UdbU/b6VLsZnMGpLkPJE4O
	7UcAQ5/d5k1Ojh/esCunKFSEC54I=
X-Google-Smtp-Source: AGHT+IHmclVY58TGSrsBptcum+ae2vLUwPXyMQZcaKumleWgGEW64iLu+2kiDmvkU0gSQxxE0oUzobckGKu2eBUTjfQ=
X-Received: by 2002:a05:6808:124a:b0:3eb:42d0:f3e with SMTP id
 5614622812f47-3ef2ebb90d0mr17969552b6e.7.1736875764797; Tue, 14 Jan 2025
 09:29:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241230121009.GDZ3KNoe0-hUwQDLG7@fat_crate.local>
 <Z3KaSxr2sjCC8FpJ@U-2FWC9VHC-2323.local> <20241230132403.GEZ3Ke8zm7HxSv84pA@fat_crate.local>
 <Z3OS4LCCxfVN32uH@U-2FWC9VHC-2323.local> <20241231092358.GAZ3O4LroNtlnztneC@fat_crate.local>
 <Z3PEXxFTGXW2j2F3@U-2FWC9VHC-2323.local> <20241231111314.GDZ3PRyq_tiU002p5d@fat_crate.local>
 <87ikqydja9.fsf@DESKTOP-5N7EMDA> <20250102083509.GAZ3ZPvcUhl9v6Kbp_@fat_crate.local>
 <20250113125224.GFZ4UMiNtWIJvgpveU@fat_crate.local> <678572b7c28b0_182bf92941f@iweiny-mobl.notmuch>
In-Reply-To: <678572b7c28b0_182bf92941f@iweiny-mobl.notmuch>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 14 Jan 2025 18:29:13 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0irZKMEyxqh7Eekam91uoMcyEkMvZxmgqP4orRqg69nbQ@mail.gmail.com>
X-Gm-Features: AbW1kvZYupCQUmQYCFCzRXQpFpmdkDgI1vWRAFUnf4oz_BV8Pxk_8t4dmdgAVq8
Message-ID: <CAJZ5v0irZKMEyxqh7Eekam91uoMcyEkMvZxmgqP4orRqg69nbQ@mail.gmail.com>
Subject: Re: [PATCH] APEI: GHES: Have GHES honor the panic= setting
To: Ira Weiny <ira.weiny@intel.com>, Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Huang, Ying" <ying.huang@linux.alibaba.com>, 
	Feng Tang <feng.tang@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
	James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, 
	Dan Williams <dan.j.williams@intel.com>, Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 9:08=E2=80=AFPM Ira Weiny <ira.weiny@intel.com> wro=
te:
>
> Borislav Petkov wrote:
> > The GHES driver overrides the panic=3D setting by force-rebooting the
> > system after a fatal hw error has been reported. The intent being that
> > such an error would be reported earlier.
> >
> > However, this is not optimal when a hard-to-debug issue requires long
> > time to reproduce and when that happens, the box will get rebooted afte=
r
> > 30 seconds and thus destroy the whole hw context of when the error
> > happened.
> >
> > So rip out the default GHES panic timeout and honor the global one.
> >
> > In the panic disabled (panic=3D0) case, the error will still be logged =
to
> > dmesg for later inspection and if panic after a hw error is really
> > required, then that can be controlled the usual way - use panic=3D on t=
he
> > cmdline or set it in the kernel .config's CONFIG_PANIC_TIMEOUT.
> >
> > Reported-by: Feng Tang <feng.tang@linux.alibaba.com>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Reviewed-by: Feng Tang <feng.tang@linux.alibaba.com>
>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Applied as 6.14 material, thanks!

