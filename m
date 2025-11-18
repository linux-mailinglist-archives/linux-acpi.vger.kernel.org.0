Return-Path: <linux-acpi+bounces-19026-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC59C6AA6B
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 17:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 18F3A348DD2
	for <lists+linux-acpi@lfdr.de>; Tue, 18 Nov 2025 16:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6AE36CDF4;
	Tue, 18 Nov 2025 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUHQZY3V"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4836C588
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763482883; cv=none; b=sCSoamQy0q4aH/qhj4G1UFUPsMNHxtiJkpTffNXMRpzyKrPYt1K/CCor0UAYeSkcgz5evM8F5OVCByXE/EZgEfb1l6HIvDErViGocDcRWtYqB/rXqpfl0K0iCZxE6PRjGfz3UxkGJIJcIoylPf2mha877IH9zDIDP4/Q03kENk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763482883; c=relaxed/simple;
	bh=I3GmwJD2kwLuyDqNWP8yOBJ/E1a+4fbbXeZpSCL5F2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNRrFp4ZY7/9wEXaNhCYnMgcoauJPkTHzAvO8/u8bEgkkQ/uPeJU8J3oMPYipE+Y1Cj5N8Sr4d9+Gaade+1CMp9fot9S01L+uMieVfy6M8IsEtAGddOVYsY+fJimvJU+ueXmb/ZgZl7R7MeJrGo/GsKHPq5bmw4KuWzQqsV9cgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUHQZY3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C8CC4AF17
	for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 16:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763482882;
	bh=I3GmwJD2kwLuyDqNWP8yOBJ/E1a+4fbbXeZpSCL5F2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nUHQZY3V3VOoSssclzRTF+UTp+AicH0H4nSVV+RCFKhSYbdAPJNavKiDn/uBtGvzd
	 9SO0QTKC8T+OtJdId4QKOKf1TmLpeaNz7E+Qdy+NvD+5ITjcJ8WqBE8NAyM6purYrs
	 BcjJs5Li4SQwdu7qFqU8ogvmRH3l/Ro/jWfozURlGwtp6GS984HlyK7AbftkKhlhg5
	 ZQRR/UVj4UFm1nqWqI8P/hFxo8oguf2kriU1gjdiJ0XFlv7ugf3HywohCrw0Kg+mbD
	 9i0sz1tPWXKFwutW7CiJFZumUqhbM/BhVXjBRDa0rq5c7XJnSVs9mgInsbxdPX4FfY
	 1BRWx+f8LZ10g==
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-44fffff5f73so3244856b6e.0
        for <linux-acpi@vger.kernel.org>; Tue, 18 Nov 2025 08:21:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWOwBp7BNRrJmnVQ8pZp421jfJDmBnGsDWQgMJQ4Y4OTVVxP1OcikpSwZR/JR8Orapm3CGHJ3PiKlF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KkI4KC5LpdZt4YvwEBn+cWpf7MFmux6taF9+1FXHfOPnCSH8
	Pt12vuxsd9rXwHlXYQ21lWwbW21LrGFxypBFOSIftb1hMjKq5K00MrXNVUQa6SuRmOW2ptY3D/V
	ZP6Rre47MhtNtWLvH5huFF74JHxHGEYQ=
X-Google-Smtp-Source: AGHT+IFMJZjgP5aklepY9KBnBO8QtoifwrcGOQsz6jIsKT+WEbmuM8xcx2+qAo5tlILgNyckS9CtPcgSWVBdgHqsBXg=
X-Received: by 2002:a05:6808:30a4:b0:44f:9b51:2256 with SMTP id
 5614622812f47-450ee0ecf0bmr34581b6e.10.1763482879506; Tue, 18 Nov 2025
 08:21:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117170014.4113754-1-ben.horgan@arm.com> <20251117170014.4113754-9-ben.horgan@arm.com>
 <CAJZ5v0hAPoE96C7=ynR=Ex4huPP3b896sBRNdBiLe=3Q9vKwHQ@mail.gmail.com> <aRybF5PV_N2ODeiZ@arm.com>
In-Reply-To: <aRybF5PV_N2ODeiZ@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 18 Nov 2025 17:21:07 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jA5vWi3JFRcCMFmvpWSu8jFT-jOWvSNLt59FeqKEk3iA@mail.gmail.com>
X-Gm-Features: AWmQ_blEnEFTWdXS_gsLWB3lwSNDrraXvdDy_6ijwAdVXqjVWMksmXmFIQQ5JAo
Message-ID: <CAJZ5v0jA5vWi3JFRcCMFmvpWSu8jFT-jOWvSNLt59FeqKEk3iA@mail.gmail.com>
Subject: Re: [PATCH v5 08/34] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com, 
	amitsinght@marvell.com, baisheng.gao@unisoc.com, 
	baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com, 
	carl@os.amperecomputing.com, dakr@kernel.org, dave.martin@arm.com, 
	david@redhat.com, dfustini@baylibre.com, fenghuay@nvidia.com, 
	gregkh@linuxfoundation.org, gshan@redhat.com, guohanjun@huawei.com, 
	jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com, 
	lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com, 
	robh@kernel.org, rohit.mathew@arm.com, scott@os.amperecomputing.com, 
	sdonthineni@nvidia.com, sudeep.holla@arm.com, tan.shaopeng@fujitsu.com, 
	will@kernel.org, xhao@linux.alibaba.com, 
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Zeng Heng <zengheng4@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Tue, Nov 18, 2025 at 5:13=E2=80=AFPM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 17, 2025 at 08:46:52PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 17, 2025 at 6:01=E2=80=AFPM Ben Horgan <ben.horgan@arm.com>=
 wrote:
> > > +static inline struct acpi_table_header *acpi_get_table_ret(char *sig=
nature, u32 instance)
> >
> > Maybe call this acpi_get_table_pointer() ?
>
> Would you have time to look at the other ACPI patches in the series? If
> you are ok with them, happy to go in via the arm64 tree? Or we can put
> them on a common branch if there are conflicts with your tree.

I think that this is the only one touching ACPI code outside the MPAM
and PPTT parsers, and the other patches in the series are fine with
me.

Please feel free to take the entire lot.

Thanks!

