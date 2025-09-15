Return-Path: <linux-acpi+bounces-16946-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F34BB58007
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 17:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2EE4817D4
	for <lists+linux-acpi@lfdr.de>; Mon, 15 Sep 2025 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D0934166E;
	Mon, 15 Sep 2025 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YriVx8Bk"
X-Original-To: linux-acpi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57EE15D1;
	Mon, 15 Sep 2025 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948872; cv=none; b=X1pqh5pfOLzVz1Hfiw3UH++WT5TkkGUp+NrRR/mWYu4D7fD3DouNaPjFMOl40GRgaGGh0wdtAvFsNY/3bqNE/VBthEolWxlNjfGFGBWCVj9NyjWYcmMWoh+1TDg6hGYhN4vYr3UEI6BrKSogZg+K7pjEMGnUrkzNBvVymH/NZWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948872; c=relaxed/simple;
	bh=E9O/m/wb8v3DqC+2hZK4UMJAS0IXQ7UazYZ1ZtSz/GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+CL2BKf7gwyTZwtMeQUdvMlCpB80VqTXWHnBdw5xBsl4u5AQxXmh7FBBpKk2LjDVcLqHL9LfLnEuXQBLH1Eaaf8D0slwJYgtNaMw/gNzNpKm55oUipJPr/35wEYhELcV2sQHscKaAsD/Fd+DZ17jMefKWsmil3bJmNMfksYmr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YriVx8Bk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D0DC4CEF1;
	Mon, 15 Sep 2025 15:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948872;
	bh=E9O/m/wb8v3DqC+2hZK4UMJAS0IXQ7UazYZ1ZtSz/GU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YriVx8BkL92SCf1o3zVzYqSUmzRGjNQWh+8g6xKOM8qW+1F9nhjaGkHFQ7yqz0PpT
	 61Kli187nqXARGqCf2/cZb9d2COs7tXT4ZEQyQAd9m4tUbK/VPo7oejrPVc0dgKzqH
	 VC7OkLyQOuX/aeItsQu9R/rdMPOLOK8wiHsnIEcTPnZORPRT0IslCwW1QCWOvRX0SF
	 wurXxEuY44C83mgyqGPF9HaTrw+JUB9FBqcXfmODxkx0dLzE7UDs85I0lju2m/WEeT
	 oY9Oe7qH2fbpbGRhzSlS9SYrXMClAU38lrV3/M5OVVyV26LEk85D92lrfnveDwLasr
	 bWPzDV3NZyThA==
Message-ID: <523bd663-4c38-480e-a923-d53c923eea1a@kernel.org>
Date: Mon, 15 Sep 2025 17:07:47 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/25] irqchip/apple-aic: Add FW info retrieval support
To: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Rutland
 <mark.rutland@arm.com>, Will Deacon <will@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Janne Grunau
 <j@jannau.net>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 James Clark <james.clark@linaro.org>
References: <20250915085702.519996-1-maz@kernel.org>
 <20250915085702.519996-7-maz@kernel.org>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250915085702.519996-7-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.09.25 10:56, Marc Zyngier wrote:
> Plug the new .get_info() callback into the Apple AIC driver,
> using some of the existing FIQ affinity handling infrastructure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---

Acked-by: Sven Peter <sven@kernel.org>



Best,


Sven



