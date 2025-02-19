Return-Path: <linux-acpi+bounces-11332-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A77A3CA7F
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 21:57:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C06A18986E3
	for <lists+linux-acpi@lfdr.de>; Wed, 19 Feb 2025 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A69624E4BC;
	Wed, 19 Feb 2025 20:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aVkq3dIg"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E7B247DE1;
	Wed, 19 Feb 2025 20:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998580; cv=none; b=usdhf+rHUqj3rG13FZQxngAKDT6AbnIS45Ox1j1LSO1id+af/3/VnIgJOyBZIHJ0ylhAjO7319FShmMdC5ryaca2xBkUcLII3kciJDcrptG7NtvwOOmoh4jbbl0Qhy9w3X8p7o0WoLOZ1UAFFObuu/w3dD8MIFV0FVeQfR/SgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998580; c=relaxed/simple;
	bh=j3Z1m9Hj7+QyCu8uQvcw8xqLLqcrNWzvxMOS2qVC2J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTYhAjS1Ra89uEM40uC8MQIpjqi1egv/nAt3AKgiendOX2IJMu6HAtHCJvQSKVMVZj8QqeneRvdrw/WLFP77FF2l7yI8z11zxk0db14kI/veSxpHfu05Nl2A/tj6O2pzzQDS+pSdfzESBc2ezxr33XxUIXNggAcb/KmcuympnAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aVkq3dIg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 526C840E015F;
	Wed, 19 Feb 2025 20:56:17 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id sylMmaoy6Uec; Wed, 19 Feb 2025 20:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739998572; bh=BzSk146EZPdEuoi3fRzTjgIcSI+I1KqFNXTcwx/L4Bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVkq3dIgPr6+5o1k3zYpUi4eS1vWXA2yWgboIFcAiLRGdxot0OWfOmMJD8cmcQfET
	 u60oS07EkLaLM2rqBXDWYDhT1Yk1iCeGB3k5EjQo7348HK8MZuHhvNaqKwHHmDnZ88
	 8eEMMVrZramrswk7Myjw0GM8iRBd32XJmXLCF8ML2K7F6jTu8kKxRnbEuvmcI0PNN9
	 Ex3AKfASEDn+9HkY3HYF27f6iSg1YMhdto1FVaJeNlLvvAyUFQOAZNOArqNX84ru18
	 e7R/FgZieLXkmidmG4qcvPS17I916+k0xG5zJRuiyzC7XIOzVcFEDxvcRufJdu6RF5
	 GPLApVlOzRtqqg3ilMMkaapKBfMlZL2V2CLZnPyt7I43YHsB9dVbuaDpwYqAk9hEQK
	 Pq62XBNGabRcHr7A3EoUg3C8DwCH3uvBxhI6LheWeCihDS3M9T3RC1Et8HjFQAO9Kz
	 SK9yt8bpxtu+OxGVHZzlInnKN0cRhsmikPnLxDMsx10SS047lnbounb6GxZwF4wAB/
	 ENsGPeCmZ+Ia8gS/pW89+4TmaufrjOoedJTnpxL6/FBQinE1K4oXqEKlHpESXUGqBB
	 BlIjV85hfV122bQ/hvdLs2ylzDYA2/Y2fkmtQY3KRkYf2CN0T4pAVLYFmzSEzAOQDf
	 Ffnx3AKuELfYb+9D49NOXvNM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FB2A40E015D;
	Wed, 19 Feb 2025 20:55:57 +0000 (UTC)
Date: Wed, 19 Feb 2025 21:55:56 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ruidong Tian <tianruidong@linux.alibaba.com>
Cc: catalin.marinas@arm.com, will@kernel.org, lpieralisi@kernel.org,
	guohanjun@huawei.com, sudeep.holla@arm.com,
	xueshuai@linux.alibaba.com, baolin.wang@linux.alibaba.com,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, rafael@kernel.org,
	lenb@kernel.org, tony.luck@intel.com, yazen.ghannam@amd.com
Subject: Re: [PATCH v3 2/5] RAS/AEST: Introduce AEST driver sysfs interface
Message-ID: <20250219205556.GSZ7ZFXL0In8nPzRIm@fat_crate.local>
References: <20250115084228.107573-1-tianruidong@linux.alibaba.com>
 <20250115084228.107573-3-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250115084228.107573-3-tianruidong@linux.alibaba.com>

On Wed, Jan 15, 2025 at 04:42:25PM +0800, Ruidong Tian wrote:
> Exposes certain AEST driver information to userspace.

Why?

Why do we need to support a debug interface indefinitely.

If "no real reason", then drop it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

