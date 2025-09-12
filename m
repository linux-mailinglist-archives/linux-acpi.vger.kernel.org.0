Return-Path: <linux-acpi+bounces-16709-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ECBB549F3
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E52917598E
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 10:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E96F2EB5B0;
	Fri, 12 Sep 2025 10:35:57 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD4A41;
	Fri, 12 Sep 2025 10:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673357; cv=none; b=nYUy7HofStAaUOVI0Y1+T3L9dMc3q5E9xd/g160c38rP5p4UvyGB0KSEh+Tmqxr0e0bvLpv1WBmaxCD4PPfJIie+DJ1Jx/3JNX4l5FmzkN1NWX/n/fsSKCH55ZUzHMdgxFgj74MLNKaSSi83lk6hSDyxYrGzWXMft+yQz8qxo6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673357; c=relaxed/simple;
	bh=8isM4pnEl1DTTq0/TamOYHRx+JNwrYDasXNQxd2lPO0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K1nd4NiEN6c7+P9VNEzoMI39MQXvPdQzlDWULQkOwyDV5U95HYcAVyanHy7BB9p3nFbed2BA+retjvDnYx6gIl4pLVIhbWkw9LHyntMZcq4l3galHNW1bBBjIkhY58cxiQSux9a/OTy50R1KO3KC0OI2wJ8cYY6SmpGN0H9ufIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3a2640328fc411f0b29709d653e92f7d-20250912
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:239f42ab-7810-4b7b-af4f-1f1d5c2920a3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:0cc55e3327b48de50b7d63ac00146cdd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|817|850,TC:nil,Content:-
	10|-8|-5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 1,FCT|NGT
X-CID-BAS: 1,FCT|NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3a2640328fc411f0b29709d653e92f7d-20250912
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 949768031; Fri, 12 Sep 2025 18:35:40 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id CD10CE009008;
	Fri, 12 Sep 2025 18:35:39 +0800 (CST)
X-ns-mid: postfix-68C3F77B-7006584
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 20C2EE009008;
	Fri, 12 Sep 2025 18:35:39 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: hansg@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mario.limonciello@amd.com,
	rafael@kernel.org,
	stable@vger.kernel.org,
	zhangzihuan@kylinos.cn
Subject: Re: [PATCH v1] ACPI: video: Fix missing backlight node creation on
Date: Fri, 12 Sep 2025 18:35:38 +0800
Message-Id: <20250912103538.3657242-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <17cc74d6-2e49-4370-ae37-39cddfe67d7d@kernel.org>
References: <17cc74d6-2e49-4370-ae37-39cddfe67d7d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> 1. There must be a GPU driver for these laptops somewhere?
> Even if out of tree using a laptop without a GPU these days
> just does not give a good user experience. So fix the GPU
> driver to call acpi_video_register_backlight().
>=20
> Note acpi_video_register_backlight() is deliberately exported
> without requiring the consuming out of tree kernel module to
> be GPL to allow this.
>=20
> Other options would be:
>=20
> 2. Add some special heuristics for Zhaoxin CPUs,
> the kernel already has a CPUID match mechanism for
> things like this. This could potentially be combined
> with a DMI system-vendor check to only do this special
> case handling on e.g. Lenovo and Inspur laptops.
>=20
> 3. Instead of adding the CPU-id based special case
> just outright use DMI quirks. In this case lets try
> to use substring matches to cover multiple models
> with a single entry so as to not grow the quirk
> table too much.


Got it, thanks!

In fact, we have tried a few approaches (cmdline option, CPU-ID based qui=
rk, and DMI quirk),
and all of them work.=20
I will sync this information with Zhaoxin to see which way they prefer.

