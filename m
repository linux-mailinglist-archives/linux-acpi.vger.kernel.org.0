Return-Path: <linux-acpi+bounces-7966-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E912964AE3
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11BF11F266F0
	for <lists+linux-acpi@lfdr.de>; Thu, 29 Aug 2024 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B791AD3E2;
	Thu, 29 Aug 2024 16:00:50 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707B71B0132
	for <linux-acpi@vger.kernel.org>; Thu, 29 Aug 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724947250; cv=none; b=HIvqNQEHfIMVJFwQENugaSJZ+UVPH0oLuHDFVUhKoZboRgsn6v3WDVK0Y728ryCK7+A1VYjBgm43Oqww/sH1VUT7KwTkIw8bNIHi62+YaYBFZV3LjCEKBMPEZqLD7JyhYv/oGSMP3NrfzBiv7q6IzAtsZLD4MvTP5sMuQi0vaOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724947250; c=relaxed/simple;
	bh=kpID/AnHT689tbVWJHhcVpCsjLAWu+om2tQs+xG4GkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIidhvrFn65zieFl0cjTR/lQiD2EyvS14FGZFmNXCkuS2Lttjqo7ENAW4hPbingULPHwxfc6Wmo1ryFNCwQixuQIlqr7wwiZvbkvJFHAvOFxULxYKwzULMHArdvAOu22HOu3YPHoNYQJQ5SZpvSAHQgbsLJKs+jEx+Kp1VJt7Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D98C3DA7;
	Thu, 29 Aug 2024 09:01:13 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9876F3F762;
	Thu, 29 Aug 2024 09:00:46 -0700 (PDT)
Date: Thu, 29 Aug 2024 17:00:44 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] ACPI: introduce acpi_arch_init
Message-ID: <ZtCbLIfCklb5kQN1@bogus>
References: <20240808-intro-acpi-arch-init-v3-1-ba510859baff@gmail.com>
 <64bd9991-61a9-5cb5-60fe-941cb4171290@huawei.com>
 <4EC8AF0D-321F-437B-93C6-E597E4D4BB34@gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4EC8AF0D-321F-437B-93C6-E597E4D4BB34@gmail.com>

On Wed, Aug 28, 2024 at 04:40:29AM +0800, Miao Wang wrote:
> 
> 
> > 2024年8月8日 17:43，Hanjun Guo <guohanjun@huawei.com> 写道：
> > 
> > On 2024/8/8 17:00, Miao Wang via B4 Relay wrote:
> >> From: Miao Wang <shankerwangmiao@gmail.com>
> >> To avoid arch-specific code in general ACPI initialization flow,
> >> we introduce a weak symbol acpi_arch_init. Currently, arm64 can
> >> utillize this to insert its specific flow. In the future,
> >> other architectures can also have chance to define their own
> >> arch-specific acpi initialization process if necessary.
> >> Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
> >> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> >> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> >> ---
> >> Changes from v1
> >> - Change acpi_arch_init from a static inline stub to a weak function
> >>   according to Haijun Guo's advice
> >> ---
> >> Changes from v2:
> >> - Add __init attribute to the weak acpi_arch_init stub
> >> - Link to v2: https://lore.kernel.org/r/20240807-intro-acpi-arch-init-v2-1-9231e23a7721@gmail.com
> > 
> > Thanks for the quick update,
> > 
> > Acked-by: Hanjun Guo <guohanjun@huawei.com>
> 
> Hi, all. I wonder whether this patch is good to be applied or
> any improvement is needed.
> 

LGTM. Rafael, do you want to take this via your tree or arm64(need your ack)
once you are happy with the change ?

-- 
Regards,
Sudeep

