Return-Path: <linux-acpi+bounces-20644-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iL4zEi2AeGkzqgEAu9opvQ
	(envelope-from <linux-acpi+bounces-20644-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:06:53 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B20D9917AC
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 10:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6B251301682A
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 09:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573973321B9;
	Tue, 27 Jan 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+RXCr0A"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD7331A7E
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504808; cv=none; b=OX8iJrpBDVYIXuN/WRasZD/sgMRAbdItWAubx/fGQE6Kyq9hfG7y7GOoWnnG7rJ5hdEZMWb7KwLvtmyVxkenFS5WtDQC4mAGXZvLLHPsO1rf9hp858q5hygLZmclApP35aiJqePnTrCyuTO3a6VIu7LcDSGm74MyOC2Jp9VJ2yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504808; c=relaxed/simple;
	bh=7yo7xOOpqehBseors1LqgTyv5Fdnwz+Jvyg81HCJMgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdRsyMcMTlNv06ZFQqUaO8gnUwo5dAEzO3QIVCNO4OaaxeppXg9mA80OQtjAgJzyL8uE3MkniU3XmFTGAMMGn9QxNga8TaooxfaSaNeyLLnU6KEUOHIyuUJSC7+pQalyLGmsHe5WhlUjoQuC7T2xuupQ8dtXMglKhrGN8PGSUVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+RXCr0A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1056BC2BC86
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 09:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769504808;
	bh=7yo7xOOpqehBseors1LqgTyv5Fdnwz+Jvyg81HCJMgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=m+RXCr0Aag8BySJUrf8mYGE/jWVYTbIJDNb7wC9pyTwPq/jXkC2VqIFgzft2W+Nlh
	 fQ9t6YizgzivTlf+P93UITCHU6taYMun4GYJN+liqcnLUpAk//HSx2XfI4UIfzyq8M
	 bzHUf7wCc1GNnbFyEw9/njP5ErQQg1wvCMn26My3cgy8dMqicwLjVtlTKGOgLw0cMN
	 D+4JO/q476QKpLPxBg2oxQs909hqeMeNDIcFoOs3wts0b5eso7Yr4e2QVMwf1Mpu6t
	 07lAv2xmqGf8WdyPI+Ghs/4Tp2bLznbQ4OpU4S4Kl3Ohs83Beg75YW9BysKF4R4a1a
	 SRk+s74H+jSMA==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b6f267721so5065886e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 01:06:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUQ/ZzN4o8LKFyfWodZaqYYMOL+hH2yEq/ZC4xkGHfhZJhtKo3U2uX6Q4Ltc7QVw5TX1vdz9UCGA/Dj@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJ0B20ILMnlyXCjDaGgd+kr1gGik1f9lqmhLqBcsBSqbuuvJw
	rgsmGFnN0uVRxC1kqljMP0hPiSkBHKWPOqqvUIORBJApPXIteuBqZUj3KTMUUoNz1F1E6axpvUg
	/hiLCf32F3f2DRTxBcNmWc+R+TvCkMUlYF5xl+IhFEQ==
X-Received: by 2002:a05:6512:b9d:b0:59d:fb43:5474 with SMTP id
 2adb3069b0e04-59e04012f0emr440731e87.7.1769504806756; Tue, 27 Jan 2026
 01:06:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126035914.16586-1-denserg.edu@gmail.com> <20260127080759.GY2275908@black.igk.intel.com>
In-Reply-To: <20260127080759.GY2275908@black.igk.intel.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 27 Jan 2026 10:06:33 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdRQzgSNorb9rHtAGWYPOK7t2o6q2gP9FLB3ECsvgVrAQ@mail.gmail.com>
X-Gm-Features: AZwV_Qi7uqULlduHi3gXdu2rdMxzjReApBfK4jfP4VOaVK6I3RuFERAM8qKv6pY
Message-ID: <CAMRc=MdRQzgSNorb9rHtAGWYPOK7t2o6q2gP9FLB3ECsvgVrAQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: use BIT_ULL() for u64 mask in address
 space handler
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Denis Sergeev <denserg.edu@gmail.com>, westeri@kernel.org, 
	andriy.shevchenko@linux.intel.com, linusw@kernel.org, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,linux.intel.com,vger.kernel.org,linuxtesting.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-20644-lists,linux-acpi=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brgl@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-acpi];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:url]
X-Rspamd-Queue-Id: B20D9917AC
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 9:08=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> On Mon, Jan 26, 2026 at 06:59:14AM +0300, Denis Sergeev wrote:
> > The BIT() macro uses unsigned long, which is 32 bits on 32-bit
> > architectures. When iterating over GPIO pins with index >=3D 32,
> > the expression (*value & BIT(i)) causes undefined behavior due
> > to shifting by a value >=3D type width.
> >
> > Since 'value' is a pointer to u64, use BIT_ULL() to ensure correct
> > 64-bit mask on all architectures.
> >
> > Found by Linux Verification Center (linuxtesting.org) with Svace.
> >
> > Fixes: 2c4d00cb8fc5 ("gpiolib: acpi: Use BIT() macro to increase readab=
ility")
> > Signed-off-by: Denis Sergeev <denserg.edu@gmail.com>
>
> Reviewed-by: Mika Westerberg <westeri@kernel.org>

I'll queue this for v6.19-rc8.

Bart

