Return-Path: <linux-acpi+bounces-13564-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92371AADDA7
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 13:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C57DE1C080ED
	for <lists+linux-acpi@lfdr.de>; Wed,  7 May 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696EC24A063;
	Wed,  7 May 2025 11:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5P+KRcI"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B65024634F
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746618292; cv=none; b=YAvn9X+WmOxzrHvx5estK3DqyVuGxr7EMtbdidI0lZ3yYwgRoBQekbKb00HS+AIUB5a9BiP6CUJ6CeDCVBAvo6t4zbInvq8+ie1FbK0qi02+rpXs1hR/Sz4UrjVFhGD6FpbNee1qEVKYKNVT7U73BRsDHMuUSNh37vdsLziqs6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746618292; c=relaxed/simple;
	bh=cdLLcDwUr12q+WTl58iQQA3WGqL6AbJxpPDb47NfKlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XXL4uF/aHCZHJSoVmTJJT4OcDAfhEnJtWB92h4MMe0kr+XBE8K9OjQn/4JuvVLoAE7WZjAs1B+/fcvlFZKTo0+zQMyUDhU2ZZAuQ9eyRjXJ+q2O8ngq7phBL8RC2Z0WsCRhyy5gnLoD+XhIl6FSeN9PXxlysCjgHboy9rpfOLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5P+KRcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E66C4CEF0
	for <linux-acpi@vger.kernel.org>; Wed,  7 May 2025 11:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746618291;
	bh=cdLLcDwUr12q+WTl58iQQA3WGqL6AbJxpPDb47NfKlA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B5P+KRcITMfnhXFQuRUqetYTTpWmlRF97WibIcFonEyM9MahiUOlurMRWcfSfkVJ6
	 OiDkQEoue9nCXMB7jPwz5tlpS5iNtlCg93yqHI7Vlwi8euy9jtBv8aFanWWb7qWMob
	 5Hh35079p/5hvelKieQ61XK2214gByRhWp8zIDeepJsKQ8X3CGq0HsEOZ0lq38TO+K
	 Jyw5UkS4EVoXcumq2OUDD37vfEFbU13j1RrXgRpJJQJFigbC07da3ySnAnKLT3YL6O
	 qrmOOtdQSflFfkwGeUghqKA/8JHdANoLfbAKedAzDUiH++oyxJIP6hT5LoJmm33cP6
	 Q03L4LHcVwh1g==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f6dccdcadaso5121907b6e.2
        for <linux-acpi@vger.kernel.org>; Wed, 07 May 2025 04:44:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWCRdTtXgIzY2jgXUWCH8PUE+H2Mp/v/C22m/5NukARHf6X1/eYLyNQgZ8aTCGctSyQEqC36ERJdBne@vger.kernel.org
X-Gm-Message-State: AOJu0YxX1y4xvq3vBA7RnV+mk8S9ZfOSnK0H3mufIaZXTvpn1cywYE1o
	vJRD7GIBbbzUcq7bXWoXsF9EIoBARsa1CTa3s2VrF+DIUku164IyNBAR29YN7LUlcOFmMGBjXC3
	SOW95EBOLQLwHvb5+I+SB7QbkHqE=
X-Google-Smtp-Source: AGHT+IG6wCemGkcpzU5879mnYZi8vlGEFhMbUN55ebx6hz6v4/xKmbMM6BvkUkazs12A6cmc0ilfJGFKUd55q82LrJQ=
X-Received: by 2002:a05:6870:241d:b0:2a7:d856:94a with SMTP id
 586e51a60fabf-2db5bec1895mr1434658fac.22.1746618279285; Wed, 07 May 2025
 04:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507035124.28071-1-yangyicong@huawei.com> <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
In-Reply-To: <20250507-devout-mysterious-jackal-e50e00@sudeepholla>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 7 May 2025 13:44:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>
X-Gm-Features: ATxdqUE4haXG93NgBL0ZN1xyAN-TCsXqo0Tpsc2P2M4TD7SKVsW8Nsnn3OQpCxo
Message-ID: <CAJZ5v0iWJQnwamT0mP=A_wtAbRkguhxcvbMnm+b2chAET7=sGA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PPTT: Fix table length check when parsing processor nodes
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Yicong Yang <yangyicong@huawei.com>, rafael@kernel.org, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, jmeurin@google.com, jeremy.linton@arm.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, prime.zeng@hisilicon.com, 
	yangyicong@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 1:40=E2=80=AFPM Sudeep Holla <sudeep.holla@arm.com> =
wrote:
>
> On Wed, May 07, 2025 at 11:51:24AM +0800, Yicong Yang wrote:
> > From: Yicong Yang <yangyicong@hisilicon.com>
> >
> > Below error is met on my board and QEMU VM on SMT or non-SMT machine:
> >   ACPI PPTT: PPTT table found, but unable to locate core 31 (31)
> >
> > This is because the processor node is found by iterating the PPTT
> > table under condition (for both acpi_find_processor_node() and
> > acpi_pptt_leaf_node()):
> >   while (entry + proc_sz < table_end)
> >     [parse the processor node]
> >
> > If the last processor node is happened to be the last node in the
> > PPTT table, above condition will always be false since
> > entry + proc_sz =3D=3D table_end. Thus the last CPU is not parsed.
> > Fix the loop condition to resolve the issue.
> >
> > This issue is exposed by [1] but the root cause is explained above.
> > Before [1] entry + proc_sz is always smaller than table_end.
> >
>
> Another thread [1]  with similar patch.

OK, so is this a correct fix?

