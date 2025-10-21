Return-Path: <linux-acpi+bounces-18035-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EC2BF6C79
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 15:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95DE19A3215
	for <lists+linux-acpi@lfdr.de>; Tue, 21 Oct 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF798337116;
	Tue, 21 Oct 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hp1PBvV4"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C59334C00
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053442; cv=none; b=laUE+7dELpXPMGBsBLMZ0oFLpCSdyJGyCkK0wvHQkofAMsDUbBBLMnrR/9sjjxsyVLYiCqYca5LquR0YJhtHPWn00bKgR61z5/IkmNf6XuQjV5J3uFlpwb50iAhfvGc1SGT9JmYXApaeSo8Ex3Irig0C75FwmDOWi/wLMftgnu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053442; c=relaxed/simple;
	bh=ay0dkHqOFJnTOzLrDz4wmOz05b8apRwAqDk0W+FLKTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=esPuSFSvCOwA/NR/Pdqo0/pjxykwhU7RJWUUbAgHax28KSkdzitQ0mKYNk61RjUp8jFZh8JZeeeO2K7m0Voi62xjptnoj2v+dMQV4ibQjKNNAGNXo2cZ3heh29hhgnY+9CrVKirDyFof7Lg/CVYzkt9vKMWHZ8DQrmNitoCJZQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hp1PBvV4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492E9C116C6
	for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 13:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053442;
	bh=ay0dkHqOFJnTOzLrDz4wmOz05b8apRwAqDk0W+FLKTU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hp1PBvV4+tq046FEMR5dgEMKjgabfxyXWSw1BEEpNXDJmVz6MpRxct5ivoccBU2c7
	 dS1CtDQFrw4KBarF1mUxo1delfbLDI5h4F3uiHpQ27YGihoYOHeoJp7NkqPpaqBB7T
	 JedZWJG2BjIpGj5wCqnePBRYqj3S+Ild0pdRIOjz7xU/NV/MIsAkkcIAe0CLW1IpTk
	 nGYfrKHLrC2wTkYATf0YvFQX/aNgTBfeIXTrvI7G14vCC2u9YpPAbssB0IkSSe1gc6
	 mWfsDA2dIeN3pbAy5oqn3g7+QS9C9hqvcF8vlk3DBud3PCjFcV8D1Ie0MU8ayMczRK
	 ujrSid2vJIF4g==
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7c2846c961fso2869095a34.2
        for <linux-acpi@vger.kernel.org>; Tue, 21 Oct 2025 06:30:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWMlCgU7xXsAoJcyqxir6ozYvELJujCDTkytUcwYRNCYAkD7i3ZgWT26LtZuBvL0j+FYV+zfztZX97s@vger.kernel.org
X-Gm-Message-State: AOJu0YxKb7WmrrSbKv5SIhpS87pEqpvl0M9NkgzBXDyIqYQNlVXq6HzJ
	gn4qEvsRHr95FD4fNpde1TUDflbgrxbxGr5YV3VfOVTPaGIxDaeUQzlPLAcpace7ryIyyp/Umsl
	he+O48DqENv5spKVQs7yag99frtAbgYA=
X-Google-Smtp-Source: AGHT+IGFhGzPHkp7KHrtFrf46EU6VcCHGco92a8d17NVHe5Iy2VfivAqQSu+O7l6C7wxe0BCu6GsLwBmi9WDsPKls2I=
X-Received: by 2002:a05:6808:1383:b0:43f:5b28:f0a6 with SMTP id
 5614622812f47-443a2ee46d2mr7110230b6e.1.1761053441631; Tue, 21 Oct 2025
 06:30:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913023224.39281-1-xueshuai@linux.alibaba.com>
 <20250915093549.00006109@huawei.com> <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
In-Reply-To: <45d5e6a9-d561-4df9-96d4-285f2ca12888@linux.alibaba.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 21 Oct 2025 15:30:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
X-Gm-Features: AS18NWD0-ds4ABTfWcbmmDfPfj8D2z4ySeNwPPcVfbR-MR_mvQUUJz_X2TJ-HPw
Message-ID: <CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com>
Subject: Re: [PATCH v2] acpi,srat: Fix incorrect device handle check for
 Generic Initiator
To: Shuai Xue <xueshuai@linux.alibaba.com>, Dave Jiang <dave.jiang@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, robert.moore@intel.com, 
	andrew@kernel.org, bfaccini@nvidia.com, eahariha@linux.microsoft.com, 
	dan.j.williams@intel.com, thorsten.blum@linux.dev, gourry@gourry.net, 
	nunodasneves@linux.microsoft.com, wangyuquan1236@phytium.com.cn, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:55=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> =E5=9C=A8 2025/9/15 16:35, Jonathan Cameron =E5=86=99=E9=81=93:
> > On Sat, 13 Sep 2025 10:32:24 +0800
> > Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >
> >> The Generic Initiator Affinity Structure in SRAT table uses device
> >> handle type field to indicate the device type. According to ACPI
> >> specification, the device handle type value of 1 represents PCI device=
,
> >> not 0.
> >>
> >> Fixes: 894c26a1c274 ("ACPI: Support Generic Initiator only domains")
> >> Reported-by: Wu Zongyong <wuzongyong@linux.alibaba.com>
> >> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> >
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> >
> > Thanks!
> >
> >> ---
> >> changes since v1: drop changes in actbl3.h to make it easy to progress=
 per Jonathan
> >> ---
>
>
> Hi, Rafael,
>
> Gentle ping.
>
> Are you happy to pick this bugfix up in this cycle?

drives/acpi/numa/ is maintained by Dave.

