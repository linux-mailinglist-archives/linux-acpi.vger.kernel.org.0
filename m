Return-Path: <linux-acpi+bounces-16303-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04361B41230
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 04:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44651669AC
	for <lists+linux-acpi@lfdr.de>; Wed,  3 Sep 2025 02:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CBD1E9B31;
	Wed,  3 Sep 2025 02:13:02 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305251E3DDB;
	Wed,  3 Sep 2025 02:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756865582; cv=none; b=i6bVzszNB0mZC3KfJGbrl1ylQMvMnNrRisM7hr40X1kBh3lJjxkgMyl4nH/dUUiGQjltaZy0/TlqC/KIbRncxpIe00SvqK/FO7bBQu0Fik/wtGSCO93iziqlMJtBoplKhxO010qIQ5oHlGJHFbdKaaGyC94YKapyT+adxcSyAw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756865582; c=relaxed/simple;
	bh=JI2pw/aLbFjiEEKXaJ1MnG8Mwwiicn7mraaE5Z1JEoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itRCFIklglnB4rFVGt8aq0LJIrwdh/y2VKzh0OjZQzLLgxYiqm8xkriixH75y9LKQ2kfTS6UwH/2GjPijhhHXNLIYERr8tehRQ/kQ4fR0kK8OFa9Q574pX8pPtUPQK8938t+b6zBayXfNOY0u5dUQ6fgo2jenyqlbIz+BcP+raY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 7e64a03c886b11f0b29709d653e92f7d-20250903
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:a08d3f21-1eda-4701-933a-4d08872f3f53,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:aa48c90d2685f52c421d2b43104888ae,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850,TC:nil,Content:0|50,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7e64a03c886b11f0b29709d653e92f7d-20250903
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1390030646; Wed, 03 Sep 2025 10:12:51 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A8973E008FA3;
	Wed,  3 Sep 2025 10:12:50 +0800 (CST)
X-ns-mid: postfix-68B7A422-507635249
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id E1C47E008FA2;
	Wed,  3 Sep 2025 10:12:30 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: krzk@kernel.org
Cc: airlied@gmail.com,
	alim.akhtar@samsung.com,
	beata.michalska@arm.com,
	ben.horgan@arm.com,
	bp@alien8.de,
	catalin.marinas@arm.com,
	cw00.choi@samsung.com,
	daniel.lezcano@kernel.org,
	dave.hansen@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	edubezval@gmail.com,
	festevam@gmail.com,
	imx@lists.linux.dev,
	intel-gfx@lists.freedesktop.org,
	j-keerthy@ti.com,
	jani.nikula@linux.intel.com,
	kernel@pengutronix.de,
	kyungmin.park@samsung.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	lukasz.luba@arm.com,
	mpe@ellerman.id.au,
	myungjoo.ham@samsung.com,
	pavel@kernel.org,
	ptsm@linux.microsoft.com,
	rafael@kernel.org,
	rodrigo.vivi@intel.com,
	rui.zhang@intel.com,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	simona@ffwll.ch,
	srinivas.pandruvada@linux.intel.com,
	sudeep.holla@arm.com,
	sumitg@nvidia.com,
	thierry.reding@gmail.com,
	tursulin@ursulin.net,
	viresh.kumar@linaro.org,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhangzihuan@kylinos.cn,
	zhenglifeng1@huawei.com
Subject: Re: [PATCH v3 12/12] PM: EM: Use scope-based cleanup helper
Date: Wed,  3 Sep 2025 10:12:30 +0800
Message-Id: <20250903021230.1044454-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b38e64cc-4971-4e71-931c-820453aa91a7@kernel.org>
References: <b38e64cc-4971-4e71-931c-820453aa91a7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: quoted-printable

> You are not improving the source code here. This is not how to use
>  __free() and you clearly do not understand the source code.

Sorry for the problem, policy should be assigned after cpumask_test_cpu()=
.

I actually realized earlier that __free() only frees at the end of the va=
riable=E2=80=99s lifetime.=20
I had suggested using a braced macro in cpufreq.h to allow immediate rele=
ase after use,=20
but I understand the maintainer=E2=80=99s advice to =E2=80=9Ckeep it simp=
le=E2=80=9D and will follow that.

> What's more, you did not use standard tools which would tell you this i=
s
> buggy and wrong.

Could you please let me know which standard tools you recommend for detec=
ting such issues?=20

I=E2=80=99d like to use them to avoid similar mistakes in the future.

> Don't introduce cleanup.h if you do not understand how it works.

Should I drop this patch?

