Return-Path: <linux-acpi+bounces-13870-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F72EAC2947
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 20:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C4C71C00D6D
	for <lists+linux-acpi@lfdr.de>; Fri, 23 May 2025 18:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A775298CC2;
	Fri, 23 May 2025 18:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baGyH6/N"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3185A298CA4;
	Fri, 23 May 2025 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748023647; cv=none; b=uZqazWa1cSrzrXc+4tcaRmxr35VXLIJWPhHVu/UJugN/ByV11LUTdtMZzoooOUE/E2l5BUh+prF88RAxK/iiTsTDSo6iT5lTzG4DwhqT3giszicqGeaI/GyifAcRgwrFruJvrzQ/NPQ0ldlXmFjpxMOLqX2vFpXEPdqCnnmTj7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748023647; c=relaxed/simple;
	bh=r/gn4o2hzk4gDSQHSB9fbtMYtpm0eI26hWxEL77Dosk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWSbYlU7iT2670PcXGgvBrIOPtN1y/BVGpO4iEQoFyUM29ytF3Wp7E8HwpwhSDCtJMxMOJlJOSbkIYtBnXHS3VmQojT4CvGnk7sUR445zstA3vumnY2VeSY/+zqTmZzAVhSVRmWtOdktjC8NNQGWEE071/G2G6TaUFyr1xkoqpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baGyH6/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B384AC4CEF0;
	Fri, 23 May 2025 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748023646;
	bh=r/gn4o2hzk4gDSQHSB9fbtMYtpm0eI26hWxEL77Dosk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=baGyH6/NXwLEeGilh4cB+DvasNnex3MEMaK5Ys3zgK/pnGiojYWwTwgah2dORWa4C
	 tkU5rH6MXv4pSZHhNu//hWW0XjY1JPmS1F9U0iRL7eBh5Ug/a8JS3qF2MQqE1xMOBZ
	 0BysrEN7CHJWX4TlaYDSgzFqnaJiopxShpmWZ/TE33Y/VPGAkjHsQu2P6u5VwvzpTd
	 v3ibk5Uuyswd8FSA3J4Hy08K1lO+pjUmbkAxqAfKTC/dF0b0y16dqrnqxSw1pgHqU3
	 LZbEelR2Sumx1R7r9apfOPvnWg6H3LdYobYZMZvPH6BMz3es1dUtXojpXjggsY5lSw
	 bXYbdtE36muAA==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6060167af73so106954eaf.2;
        Fri, 23 May 2025 11:07:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUBmK2fiwU8aRNSURO8c8zJiKZ/f39c33aszyUCHz+08H2hqvDip9ox7bnRz0vvA6Mwb2P+MJOcqGJCFTkj@vger.kernel.org, AJvYcCWSCv2HRRIKrzMDOZCQYkE0MqLJLmpNijim1KUXbVt/qsb1imXwp9xwS06lOYe2SpAFiZeZJuoxbEg/@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzOOJxxlv3uqrCk8maRMLaWgYGgHzrbySXhTF5fpZLcYI2ENG
	A2PAeBbpn346pmlrLstfRrqV1WKuu6y18P9gQ0cZnNJoc0YpnyTZ+NjyPBu+7yAAi+R0OnAt3Ov
	r8TvOIL6xORGzbNFA2M2k6Zf2dgVBmhY=
X-Google-Smtp-Source: AGHT+IHFny9MxNSwmhQzxYpAK65IFEwTe7qIzWV5duQZfc0cpNCoxy+Elme1JaoXirSuWjB3mnDOaWc1VsKDsucrACk=
X-Received: by 2002:a05:6820:189b:b0:608:3ee9:13a4 with SMTP id
 006d021491bc7-60b9fba595fmr214429eaf.5.1748023646051; Fri, 23 May 2025
 11:07:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523172001.1761634-1-anil.s.keshavamurthy@intel.com> <SJ1PR11MB608359E8F8700DAEC9D4663AFC98A@SJ1PR11MB6083.namprd11.prod.outlook.com>
In-Reply-To: <SJ1PR11MB608359E8F8700DAEC9D4663AFC98A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 23 May 2025 20:07:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ifTUBq3KGBAZOTb4AoV5aL2VDWBWQqj6gZxcC+QFE2zA@mail.gmail.com>
X-Gm-Features: AX0GCFtwM7Wvf728b1UCbuX4pha2-SvMoGXLIHbx3fZR99ToNo6Sq3lcIACrGcw
Message-ID: <CAJZ5v0ifTUBq3KGBAZOTb4AoV5aL2VDWBWQqj6gZxcC+QFE2zA@mail.gmail.com>
Subject: Re: [PATCH] ACPI/MRRM: Fix default max memory region
To: "Luck, Tony" <tony.luck@intel.com>, 
	"Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>
Cc: "Chen, Yu C" <yu.c.chen@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2025 at 7:48=E2=80=AFPM Luck, Tony <tony.luck@intel.com> wr=
ote:
>
> > Per the spec, the default max memory region must be 1 covering
> > all system memory.
> >
> > When platform does not provide ACPI MRRM table or
> > when CONFIG_ACPI is opted out, the acpi_mrrm_max_mem_region() function
> > defaults to  returning 1 region complying to RDT spec.
> >
> > Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>
> Good (corner case) catch. I was too focused on the assumption that MRRM
> table will be present when needed. Always a good plan to have a backup
> option if BIOS does something strange.
>
> Reviewed-by: Tony Luck <tony.luck@intel.com>

Applied, thanks!

