Return-Path: <linux-acpi+bounces-14529-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AFBAE679A
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 15:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFDCA3A9E94
	for <lists+linux-acpi@lfdr.de>; Tue, 24 Jun 2025 13:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22492D12E0;
	Tue, 24 Jun 2025 13:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b="SZPiNZwm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE9028ECE0;
	Tue, 24 Jun 2025 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773404; cv=none; b=ScNKj7WWzpPjUT4/qClrAnWGqiHkTmN7mCM/JuPBXxXuZN6FYDR5rqS557WKkRxTvBQL9TrP5SZ2XcxoQDZDH4gfvRbbwVw1676jsDhmC6Nk3SfCkkU6uf3JqChcLo3D++tOaj4YDeqqNiJEOHzNLXwV92dgBZm45XaYcBbk/DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773404; c=relaxed/simple;
	bh=B6gCqFX0DYfSOHCLouznUndba41nDMKlKq4BB0mKOwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sFwqbmC+AQa4M+RzsOKtElHMVNzGWuJvj+u8EqFBKagVg9rTZCl057ClrAMARAUzpw6Y3Oc7rO3chJY/kij2M8UorIYjHM9Fz6Q4tm6sjyWr9l9Qw4fJ3snqPKWhAxmAXRw01jxcG9r/UBj1srTCog7em2hYtevVbcjMhSqtb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz; spf=pass smtp.mailfrom=listout.xyz; dkim=pass (2048-bit key) header.d=listout.xyz header.i=@listout.xyz header.b=SZPiNZwm; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=listout.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=listout.xyz
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bRRM50VM5z9t6q;
	Tue, 24 Jun 2025 15:56:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
	t=1750773393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDKHq09riz26MRUGKyYOF6elIgy9JDdvB3gqrf3U0Ss=;
	b=SZPiNZwmqPmL7WaX11SLgBmO0PsneQyb/e1xMaC4yJgg25CuVXeBUZKIhTvKVcwSmwigw1
	XZcWWPrMxRLOaPE33QSchaTFll+vCc5Gd3AgrR3cUNZ8FaKEXIzhX/H/ACUy5APxNUkYUT
	PISTECqIMt/gE9fwJo4dTNPdGLZK0e928dRkkxioQQUvkd4Vfm46PtlsElG0hizDT6hZd6
	IG+XeQQpfWqgjIDSlR2A8mEg1MeBINJfRPtqlyfU+fAC8EpLgZGWP8uPHY+WTeQt0eU+29
	MDb5v5OfV01y5QtgSj7EqMYkIOKtufaG0GEQ1k1KKet0mROFIYHWphCZlrifnw==
Date: Tue, 24 Jun 2025 19:26:28 +0530
From: Brahmajit Das <listout@listout.xyz>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, lenb@kernel.org, lv.zheng@intel.com, kees@kernel.org, 
	rui.zhang@intel.com, len.brown@intel.com
Subject: Re: [PATCH] ACPI / sysfs: Replace deprecated and unsafe functions
 with sysfs_emit
Message-ID: <jbcmfguk7sfgpf4b5jsdjvuz7nzs34yhre3dokehrzm42dj4s7@fbpzrahozjay>
References: <20250624133739.25215-1-listout@listout.xyz>
 <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jSk-NrovSq5En6qOureQXFbCsJLChorbgYXQdYfa0m3w@mail.gmail.com>

On 24.06.2025 15:46, Rafael J. Wysocki wrote:
> On Tue, Jun 24, 2025 at 3:38 PM Brahmajit Das <listout@listout.xyz> wrote:
> >
> > acpi/sysfs.c has many instances of unsafe or deprecated functions such
> > as sprintf, strcpy. This patch relaces them with sysfs_emit to safer
> 
> "replaces"
> 
> > alternavtive and better following of kernel API.
> 
> "alternative"
> 
> 1. Have you tested all of the affected interfaces and verified that
> they still work as expected after the changes?
> 2. While the replaced functions are unsafe in principle, is the usage
> of them in any places affected by this patch actually unsafe?
> 

I meant to send this as RFC. Sorry.
But I guess the questions still holds.

-- 
Regards,
listout

