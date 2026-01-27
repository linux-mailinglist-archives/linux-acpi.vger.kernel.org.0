Return-Path: <linux-acpi+bounces-20668-lists+linux-acpi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-acpi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KI/B0ffeGkCtwEAu9opvQ
	(envelope-from <linux-acpi+bounces-20668-lists+linux-acpi=lfdr.de@vger.kernel.org>)
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:52:39 +0100
X-Original-To: lists+linux-acpi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B50971FB
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 16:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C824B30327E0
	for <lists+linux-acpi@lfdr.de>; Tue, 27 Jan 2026 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C52F2FE598;
	Tue, 27 Jan 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fsz96Hyv"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9EF2652B2
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528208; cv=none; b=hAUSaUhdAzrnBy6cfUr6f3XmJjfgfknfql+cOdm1vtLJYEV2syW5MRGf1yXuoQz9kT96B7XDBHqhVNTioV8zvIRcOjJ0aqyKImGuojZCRYzo3bTpWhmGcrUDpmq/WSoT3Y/QwbKsplq5k6rsyufvtUWjxQ2HFC8bOC8Y6Ww/zsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528208; c=relaxed/simple;
	bh=/rL29wBK2VyCq0Uw+Rgs1l98Q1X+eJF4rtTos+0n+zI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSGVXBPjrvGsE5sbkpfW14qv3zQjeNEEj5qqiQTIwjz4J5lM4IwxC2FcWzgm5j5O0s4uCueXqdtO22uSh/Mbr7PMRslLSyMsk1IMVWl05YtHV9ArsOBeBJSJMHjvNc83Bi7/mMeRKr9QvAaF0NDFLuwOuJ0ANg4KzSey9Huv7yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fsz96Hyv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91267C19422
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 15:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769528208;
	bh=/rL29wBK2VyCq0Uw+Rgs1l98Q1X+eJF4rtTos+0n+zI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Fsz96HyvvjmOqlkUjP0dzEA1FeLzyXncxWKWb2N+bKt5Cn13VbJUX/uTe4MJFTcOW
	 z/X0z4wWE9e99cikxP+J5SuL8aUjpgN5yVZUcb6YY/AuV7KKR0zmEkuYs/QRraZ5Fn
	 xUGGDys/f1Uh/XxnCZYrwRrSaVYCOvdtfX5FGOJMq6blitncFpUbnbARW+u2Og68zQ
	 s3AZtAE9vdXZJw+/LQ6tTVPefZiWw32QYUSPgmH2DSFuU7f40+wosXU1kjKYZI5vKH
	 tf2V5mQ9j/GX3hiXKq02urHShAJo35X/uf2+YY2DDQXQ5kcBcpY1Bq0/vIJZ9BXSll
	 si2N6xU0T1BUw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-66106a2f8d1so1968837eaf.1
        for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 07:36:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWK25xl5ZzR14DzqwmBdk7zmVHcAIiInnGh31RZlCsGhiVeBa9hd8dAJ4ArS8knJdZQJ4dRBj7EbLNP@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQlBFHSYJhWoUUkTf/oD7i1oqZNtJ8jMLf4zyXl8gpr14CvZ9
	MCC4fCUSepeX16LgjHT/2D9vVicLC3i4Ti9tBe8+Yy5myP6BNWQQwHhEnOY6SWIz1ObteXWRyLZ
	/Ckag7Kj4ESHAo+5qci67mSHHTgGLvnc=
X-Received: by 2002:a05:6820:4610:b0:659:9a49:9042 with SMTP id
 006d021491bc7-662f2021f55mr947902eaf.13.1769528207445; Tue, 27 Jan 2026
 07:36:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120112258.1595164-1-lihuisong@huawei.com>
In-Reply-To: <20260120112258.1595164-1-lihuisong@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 27 Jan 2026 16:36:35 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gg7QcNCLHL2wy7jr6WguQ-qMP9Fu1RrOziAct8YuD+2A@mail.gmail.com>
X-Gm-Features: AZwV_Qih6vJX854JVs5ONMEwV0NaxXHrSibmfSEIKiFCxGR5w_A-PINqN8X6L3o
Message-ID: <CAJZ5v0gg7QcNCLHL2wy7jr6WguQ-qMP9Fu1RrOziAct8YuD+2A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ACPI: processor: idle: Enhance LPI verification
 and some cleancode
To: Huisong Li <lihuisong@huawei.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com, wangzhi12@huawei.com, zhangpengjie2@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20668-lists,linux-acpi=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-acpi@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-acpi];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A3B50971FB
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 12:23=E2=80=AFPM Huisong Li <lihuisong@huawei.com> =
wrote:
>
> This series is aimed to enhance LPI verification and redefine
> two functions to void, which is a part of the series in link [1].
>
> [1] https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei=
.com
>
> ---
> Changes in v2:
>  - reorder patch
>  - fix commit log in patch 1/3 and 2/3
>
> ---
> Huisong Li (3):
>   ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_states to
>     void
>   ACPI: processor: idle: Redefine acpi_processor_setup_cpuidle_dev to
>     void
>   ACPI: processor: idle: Relocate and verify
>     acpi_processor_ffh_lpi_probe
>
>  drivers/acpi/processor_idle.c | 40 ++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
>
> --

Applied as 6.20 material (with some modifications, mostly in subjects
and changelogs).

Thanks!

