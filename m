Return-Path: <linux-acpi+bounces-10122-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678AC9EE64E
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 13:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 248B928251A
	for <lists+linux-acpi@lfdr.de>; Thu, 12 Dec 2024 12:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF692116EC;
	Thu, 12 Dec 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNVwvEro"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9123259495
	for <linux-acpi@vger.kernel.org>; Thu, 12 Dec 2024 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734005265; cv=none; b=INZE0s4f2+VCB+z8WENkOygvQ1z8npW8BJqxJDvVQ9CEm3YxnBDfDreRue6Ea2sLafPS/2QMLJ1V3gjJHrh/IiwCgpqDs9Ez34Z25ux4gVLA8Cb45MQn8F1PP20B45R8XUQtkH5/NNXyFroARB283J23VAxybeQXWdTGnwaBTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734005265; c=relaxed/simple;
	bh=JT9FEYCVS3TcQTfOlTyHV5SKGTyDyU5l2j7x235JHic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gpHk0RQNtNJ/2D6AQejNIuZQtzg96oovoTNa0Q0xzMtnOcnnxsQVPqmkcF5ZoKrCmvH2Li1MOKUKmv8YRZX1vBTz90+M/LTO9mWP+5p9E4OMPnVKzj5KfkvXmWwnRcR6mF8XEv640oSaMZM0pFMdNJ0n5NT2G0xxKduHblSZlVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNVwvEro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E9AC4CED4;
	Thu, 12 Dec 2024 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734005265;
	bh=JT9FEYCVS3TcQTfOlTyHV5SKGTyDyU5l2j7x235JHic=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nNVwvEro0mKIEep23Ee3LFgeeo3D87hSjY6FbKGL64Q/aGrAlV+HB69DNJZ6t5Tus
	 n1VJlMNoJVitpLKNSyFYq9qOiarq+UL+OFF0wizi/Gr0wGlME+4DcbBii9rqAr61WN
	 mIkYWak1RN0cRYGDel5TSrkB6ezBcKjR+DPWUHJ1jKn4R5ZAhOroQavTh3oVpSbBAO
	 NVv1UV57uxsBS3x5jMtAcGPkdsHxC8UGOD6l1MUxNsRF9v15CIO6MfaRO/BFEFuyM4
	 9hRvFNMKRH2/mt/B5Wq4JqQzSu5dRaJ/GL/GWv9+VaEzUrROfsHe3igk5hyuQNr4Fa
	 +GZQTP2Tx/BBA==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3eb972dd8e5so261066b6e.2;
        Thu, 12 Dec 2024 04:07:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUs+VaH4Yjkmi0PglpoNGTva3xzIEMnCnSpiZ+IHlEeUjaTeqEGvZFeygxGfrhpdjSZJKmX2OOh0ZoCFDA=@vger.kernel.org, AJvYcCW3FkzZt+BDYvl574m6uP9wwDRA1ymgWQfPQoxXDdFVMB5oarkLxf/h9cmvHMhTi1uuxJngaWBNuvd+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg2xWDUxVIbqk3smU3OUxiTHWK6TrIgpMwNfN3GkMKB4IAv46M
	EvS614gbwk0OKjYpZpTNVUu3gnRe11StSc0T6tqZbPknsxeJ0lhqJ57TbjadPdJ3LqHjwatbACo
	mApkvedT/0AeWpaSdMSGJDskR0xA=
X-Google-Smtp-Source: AGHT+IG/xNLik3IYMPR3nHB19u522a/GimIHHZEFDpaBI5ZzjJLlazTpO/GaxrsZkF3sj6As+oJ0B16Sd6z7aXIEIqo=
X-Received: by 2002:a05:6808:2226:b0:3e7:a1f5:781b with SMTP id
 5614622812f47-3eb85b4be15mr4241091b6e.5.1734005264553; Thu, 12 Dec 2024
 04:07:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0gooYrx7er_gpNG_vickyh05HRt7beN_-RqnV6=h-RdVA@mail.gmail.com>
 <20241212115451.183076-1-xiongyining1480@phytium.com.cn>
In-Reply-To: <20241212115451.183076-1-xiongyining1480@phytium.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Dec 2024 13:07:33 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0iJD3x1S+Y3uD29AzbF-dtATrp_6nHWX1dxi5GUidcE-A@mail.gmail.com>
Message-ID: <CAJZ5v0iJD3x1S+Y3uD29AzbF-dtATrp_6nHWX1dxi5GUidcE-A@mail.gmail.com>
Subject: Re: [PATCH 1/1] acpi_driver: add CONFIG_ACPI_KERN_DEBUG config to
 enable KERN_DEBU
To: Xiong Yining <xiongyining1480@phytium.com.cn>
Cc: rafael@kernel.org, len@kernel.org, linux-acpi@vger.kernel.org, 
	linx-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 12:55=E2=80=AFPM Xiong Yining
<xiongyining1480@phytium.com.cn> wrote:
>
> > > In the API module, there is no unified configuration switch to contro=
l de=3D
>         bug
>
> > You mean ACPI I suppose?
>
> Oh~, Sorry for the typo.
>
> > > output, and the current approach is to enable debugging by adding "de=
fine=3D
>         DEBUG"
> > > in the file, which is both cumbersome and difficult to manage. a glob=
al d=3D
>         ebug config
> > > to control the debug output of the ACPI module will be more easily an=
d cl=3D
>         early.
>
> > So there is only one KERN_DEBUG printk() statement in the entire
>   drivers/acpi/ directory, the rest is pr_debug() or dev_dbg() that
>   shouldn't need this change.
>
> The original intention of this patch is to manage the printing function
> of all KERN_DEBUG levels in drivers/acpi, including acpi_handle_debug(),
> pr_debug(), and dev_debg().
>
> Why don't pr_debug() need this change?

Because they can be enabled through dynamic debug which IMV is
superior to a compile-time switch.

