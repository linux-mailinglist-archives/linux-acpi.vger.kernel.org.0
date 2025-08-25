Return-Path: <linux-acpi+bounces-16016-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBABB34470
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 16:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D00991889BC6
	for <lists+linux-acpi@lfdr.de>; Mon, 25 Aug 2025 14:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D2E2F99BD;
	Mon, 25 Aug 2025 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPniUUrw"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E32EDD6D;
	Mon, 25 Aug 2025 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133173; cv=none; b=V5Ysf4wgdISEXHOqyqOMgUHiPtxL4eu+0Bz4cREx+wpxkC8dhWS0YoeSY92P36b14Y2Is5xtT17iVJn6xHw6oRLYPAs1tUeKyD9W5+SGszhuxpgE78tbqd1wQHru2EG3/F4nM7OamE/a/aiY9chpHs+FrxqfRHoXDRzmWb+VgzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133173; c=relaxed/simple;
	bh=xEmnkfFlFgLnGRE8xYsg89rBblVR+C4leLdQUm91MVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/cjrFwfxkvSfUawEWHtJGeOdcUN5hyLYGG8K6dPrl2vHwpQckUhRAFLXIetWTLa/U44rddg87iwOekYCvLvsgwi03ICZVb4svLTRfZj15VwrmbT5MYTvad/gCbZeHRFkCZkQXQw+CF39YRvyjEoePAxFzoPMlYYmH3xOdfimpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPniUUrw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3ABC116C6;
	Mon, 25 Aug 2025 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756133173;
	bh=xEmnkfFlFgLnGRE8xYsg89rBblVR+C4leLdQUm91MVU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UPniUUrwIkrcN9labLgDlvMkZBRGEy7UkjaQv53qahWE7oBkBMO0Jv3ginZQbQBZo
	 hyedY9wj8br4dISmR/vcRFs8HuHUVEJnkRs0KmQtSWlQFMNvU9mIfN+79G+Es6dI6n
	 bNArL6hdJZN40OqPaUVODWuiOTUXByYQ0TxJwVe/Lvmg6E+a2guwKmz5OsttDol2Gf
	 f5qOPEKNBgsobl3XGNNf4S9tK6dnXDkLG9U3NPtdv3r+j4J9BzgxSZcXCGS8ZhH3Gu
	 GEtG00/MuqSbG/GfoCPCp3rwnsndg847CFZQ94A+Kq8ZdNkw5Nd/IOmepElLX0W4SA
	 q1Eywfziov1QA==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccea6239bso2907330fac.2;
        Mon, 25 Aug 2025 07:46:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUF3f1F8JMrJc0CgVgv5mnZ6Oat67qEPLX0rP0zmS0n3IO4vt1ExteMm2mUFUJ8qppe3K6JqzRMlna3Pcyl@vger.kernel.org, AJvYcCX/17pjfEuEYNydiKStWeEeffrqifMLIZ7T+GPd218hXpkvEGJ8GqkWN+OjbXklzVE2y/ASlvqs1205@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61KNfIw+p7PsIspK4frxKHnq6yz8FSSHrFtEwt7pNvqlcu6Ss
	rMTL/VeBZEZr6UExeaMvBw1hO4r/WLkj+NdkWRqj5TMLc7UNIMp8vlbVzIlEaZ3TbHUFBFrngHM
	L7HAKW8NhZFlK53vpPaBFWczFfBLDhR0=
X-Google-Smtp-Source: AGHT+IGotPlk721rRhv52g8Ihp45jpFEDRMYxdg/8JvQ2WMQbygxvnPy/IZxecihCzGPn07MtUjRABeCimjdVBljNTY=
X-Received: by 2002:a05:687c:2be8:b0:30c:2deb:aba1 with SMTP id
 586e51a60fabf-314dcad7f31mr6959752fac.4.1756133172543; Mon, 25 Aug 2025
 07:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811134505.1162661-1-mstrozek@opensource.cirrus.com> <aKwvcaCGuKGCXosa@opensource.cirrus.com>
In-Reply-To: <aKwvcaCGuKGCXosa@opensource.cirrus.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 25 Aug 2025 16:46:01 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2DYZgwX=GDZ=YQeMPaNHEA=B2j9quxF8BREPtL2SARQ@mail.gmail.com>
X-Gm-Features: Ac12FXx3MJ8_4J0ynjpfj9nPvPbeO2nfHEXQDdPNPCb_MiYxLthwQitG_Z2y98k
Message-ID: <CAJZ5v0i2DYZgwX=GDZ=YQeMPaNHEA=B2j9quxF8BREPtL2SARQ@mail.gmail.com>
Subject: Re: [PATCH v3] ACPICA: Add SoundWire File Table (SWFT) signature
To: Charles Keepax <ckeepax@opensource.cirrus.com>, 
	Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc: Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 11:40=E2=80=AFAM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Aug 11, 2025 at 02:45:05PM +0100, Maciej Strozek wrote:
> > The File Download (FDL) process of SoundWire Class Audio (SDCA) driver,
> > which provides code/data which may be required by an SDCA device,
> > utilizes SWFT to obtain that code/data. There is a single SWFT for the
> > system, and SWFT can contain multiple files (information about the file
> > as well as its binary contents). The SWFT has a standard ACPI Descripto=
r
> > Table Header, followed by SoundWire File definitions as described in
> > Discovery and Configuration (DisCo) Specification for SoundWire=C2=AE
> >
> > Link: https://github.com/acpica/acpica/commit/18c96022
> > Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
> > ---
>
> Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Applied as 6.18 material, thanks!

