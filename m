Return-Path: <linux-acpi+bounces-16722-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC90AB54D9A
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 14:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7C11886D89
	for <lists+linux-acpi@lfdr.de>; Fri, 12 Sep 2025 12:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B6B2868B7;
	Fri, 12 Sep 2025 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pz3/fCPS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F952561A2;
	Fri, 12 Sep 2025 12:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679856; cv=none; b=GTKcWE0euKSvYyTE+BQ1zcCXgbWZhxcZ0CgZlrWb8LtighBnLn9aL0KAVndU8IY5MIaN4nXz+bDZb+dq6HhU71iPvIGVWo+gcCEazNm8aU2W1S04RS/23As/I675wu2AvYVkoV8lv27D4fBj5fMN8fArZRXJYbV3Fqr2aPz9MS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679856; c=relaxed/simple;
	bh=od8mdrwkFCucL7c5OIibbhPuLKy5/ajXQPaO6t7X4Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M99yRBqbW/UV3bw1Yes7dS1mTYfM/Wwgy3SpgXIEReCPvSn15UUxC7nXeou0c3UYd5cVPc/syFrszPdLee4nuqbf06uTVCt/BMuuK6Q/Iz6HvZXgoBU0uyDpJIZAIQSlr7D9JTyT3H46x5fDij2spNoM67op/6e6KIRl9knA1o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pz3/fCPS; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757679845; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QQuh3qe7GHr4oD3y/e8p6XQV009E4bY1By63t7qFAqE=;
	b=pz3/fCPSFd372EboXM15wxFX1sPq/An4GdxBWP2MBTRJT9FgsR1ux1KNnCGpRAdoPpNevDSTRR/O+Kx+HevkH9NtcemMivuLze83oyQPK6+93oOEaG6na14vmqjIAvwhwx0Wx5mzClwFjYKtsEWlPqjL4Ca4G30x00KhEjkGTAg=
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0Wnr56a8_1757679839 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 20:24:04 +0800
From: cp0613@linux.alibaba.com
To: rafael@kernel.org
Cc: cp0613@linux.alibaba.com,
	guoren@kernel.org,
	jeeheng.sia@starfivetech.com,
	lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: SPCR: Support Precise Baud Rate filed
Date: Fri, 12 Sep 2025 20:23:49 +0800
Message-ID: <20250912122349.2247-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJZ5v0iZmHCOzcTD6b4XGNXWUWEoO0v_qLMDFNtA43XLAOmhZQ@mail.gmail.com>
References: <CAJZ5v0iZmHCOzcTD6b4XGNXWUWEoO0v_qLMDFNtA43XLAOmhZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 12 Sep 2025 11:29:44 +0200, rafael@kernel.org wrote:

> > +       if (table->precise_baudrate)
> > +               baud_rate =3D table->precise_baudrate;
> > +       else {> 

> The outer braces here are redundant and if you combined the "else"
> above with the "switch ()" statement below in one line, the patch
> would be smaller.> 

> > +               switch (table->baud_rate) {
> > +               case 0:

Thanks for your suggestion. I will modify it.


