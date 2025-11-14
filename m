Return-Path: <linux-acpi+bounces-18912-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649AC5E227
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 17:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 74ECB3C3F98
	for <lists+linux-acpi@lfdr.de>; Fri, 14 Nov 2025 15:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3383D33CE81;
	Fri, 14 Nov 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BN8vcAXL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F44733123E
	for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763135357; cv=none; b=fQgG2tEtXANLiZfaZvScGf47xpjkEGlUSZoY7mnU5kzMfiMlItarURW9vpiMxGSqaV+82cTidLwKyabyv4tFqWxh85GtbFLxRjtAAkwI+kaVZp8YCBGFK8y42rGhD5cImf5/vQpBXSwc6XBtP3jxb9Y9sJGzXxFxDZh10k9dctQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763135357; c=relaxed/simple;
	bh=B/GmxQ/elcm/ZuovOaADJnNg3oNZvWBVTh8gcjxVNDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VhhFxNVBmIdhg2zvZxwDOK/wxA4H/a9NO+VdWHPuDo53KncXaPjGHTVlv6wmGKMm/ou5YhGH1tlfYd9pQRwn2q+HUOI7HJkjR8+aYpb+BGgMGp49vifsLNNBt3iQpTPs7ZzSWPWMBFdUnA5LM2Hr7bPQmBu5dwFmsOwHJ2YNLAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BN8vcAXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DDCC4AF09
	for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763135356;
	bh=B/GmxQ/elcm/ZuovOaADJnNg3oNZvWBVTh8gcjxVNDU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BN8vcAXLfuGc9hXd9TwVdyG/lR0ST9E2WXYPxXXq4EH3TKELaQ1M8EVtuKrCYqlec
	 m1KvUaWOhayop/OxgZqA1YtQ8ayzbUL7jsLYDmhSyxGm4WU/bF8TIAwppsaUwJOQC6
	 MLRA06njj+z2DbMXrCq4slqCpxLRVSRrq2QqQTcuMRl0mk1WdyhALhGwxnxL8z9ykl
	 lXT1C3srIJaNT9kKHoot/EpXEBp1g+27P/XBMMwdSzPiVDepPa3mXfjDws05czzHGF
	 lVJfVPlBrVJtPGb1ms3ZxYA3Aegaq2GK61E4cWK9sSW7wKY9iGtgnRiBB6zS3bKsy0
	 qkSBLruXPAhgA==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-656cd6c1c5eso864979eaf.0
        for <linux-acpi@vger.kernel.org>; Fri, 14 Nov 2025 07:49:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2AuGWSP7JJ/tkattu2bvIUr15IjVcvgBeTdYatweBD+WzO1Q1OyZP2j11LcT0q4xzLJmjDyeYoToL@vger.kernel.org
X-Gm-Message-State: AOJu0YzBGsF77Ouu8wEzjDZiSGtAzWbs8CPpOCoCa8S5Yn37nB5Fa4QD
	Fnnx08vb3WmQ4DIUpSJahW0b3GScRB0Q1fAuMjXk+nWMgYo93uclcCA+KtWeQvdNeGEUoObPXIg
	ja+QdcnYiEegy9DrnlsiA0/WcDCQ5N4A=
X-Google-Smtp-Source: AGHT+IG00tkBeQEfJ5o3NmnrcYFW28ZRDZ1pElpA8utQLvBiOnjiTimys8Dh6lBso/9z+uL9lVFiqxXMPvVfdfvbUTo=
X-Received: by 2002:a05:6820:4dc7:b0:656:b62a:e554 with SMTP id
 006d021491bc7-65733c2f2ebmr1346005eaf.2.1763135356131; Fri, 14 Nov 2025
 07:49:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5959587.DvuYhMxLoT@rafael.j.wysocki> <20251114131031.00003b60@huawei.com>
In-Reply-To: <20251114131031.00003b60@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 14 Nov 2025 16:49:04 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hpO34hf2hqrqy5Eh0Rmfj-yBdnuTVvs0savrUpqSdTrg@mail.gmail.com>
X-Gm-Features: AWmQ_bm0KlKqGhfHxuPdyY1Vevb-DPKwi67T_6vM_r4EoRCvM6dm77j5mSFN7gY
Message-ID: <CAJZ5v0hpO34hf2hqrqy5Eh0Rmfj-yBdnuTVvs0savrUpqSdTrg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] PM: runtime: Wrapper macros for usage counter guards
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, 
	LKML <linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, 
	Frank Li <Frank.Li@nxp.com>, Dhruva Gole <d-gole@ti.com>, 
	Dan Williams <dan.j.williams@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, 
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 2:10=E2=80=AFPM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 13 Nov 2025 20:24:57 +0100
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>
> > Hi All,
> >
> > This supersedes
> >
> > https://lore.kernel.org/linux-pm/13883374.uLZWGnKmhe@rafael.j.wysocki/
> >
> > as discussed here:
> >
> > https://lore.kernel.org/linux-pm/5068916.31r3eYUQgx@rafael.j.wysocki/
> >
> > It adds runtime PM wrapper macros around ACQUIRE() and ACQUIRE_ERR() in=
volving
> > the guards added recently (patch [1/3]) and then updates the code alrea=
dy
> > using those guards (patches [2/3] and [3/3]) to make it look more
> > straightforward.
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> for whole series.

Thank you!

