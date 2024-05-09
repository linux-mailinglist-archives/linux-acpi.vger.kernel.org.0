Return-Path: <linux-acpi+bounces-5693-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C938C0FFF
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 14:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C5B28299C
	for <lists+linux-acpi@lfdr.de>; Thu,  9 May 2024 12:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F81147C72;
	Thu,  9 May 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cwAMr01z"
X-Original-To: linux-acpi@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3027A150984;
	Thu,  9 May 2024 12:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715259367; cv=none; b=m7V4+hupLodeH7N7oAWyAjD5UQQ5a/ONldvG/mZFqY/0cVEX9QYnxoFTACd4mc0FCbzCohAHtpj1M/TQbWJHjuluYm6In1ZNu0+ErNCXNYi2RtC3k9Q/1oCSinBmIPVOMFfUxAcguHNuHOrXdagRcQpNhrcJnIJDF12Dy2BGzt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715259367; c=relaxed/simple;
	bh=JDF0xeyMENO/odeWyrMiImKcaqtEJAiCaQpN6vwM+FU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZ83g0m4kyiLunAL621dbi6AGCrEHvgMjkxi4J7ZKWVgjjS0yY8Mf0a8ZNY62yYSkprY42DaCJD5Z3Zckx8351UvM/gCuIFVZo5xOXuxM1cFzbz0621f82/uNyhu7dqgYRTyFCXjFcfuYqgULoHubBH3b3FPNaJ61FNve+pdAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cwAMr01z; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715259360;
	bh=JDF0xeyMENO/odeWyrMiImKcaqtEJAiCaQpN6vwM+FU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cwAMr01zu7qFF8kZOVDcp+mmxiKgLmUqZQsZmlPlrJr8BjhtpkyVbLixqZ7XpOyrG
	 bRSMZcqHSxTt9AaQ1zF+746lGsmLaH8usSIbMoSKR6hy4N7W3nachwtREkLsvwWvrx
	 TLzrKqRV55wChbisWCk19t4dO2hjtWTzg2z0JOZk2T1WkBg26i6QOnr1y2frodnDTy
	 uCQ508rQhWrMQFaBr3NmrFe202moFeH8cholN+Anb7uh8SWT5SF+L5Gd4qbCy2aQpr
	 J2rTOpnL4aTAnVTD9ZTkgLm+na6qFgtAah4NiJcS3Gb9F9RjdowK0h/DGClWOqI1mk
	 jJRtNGA+dPhpQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BBF903782172;
	Thu,  9 May 2024 12:55:59 +0000 (UTC)
Message-ID: <217a8630-de33-4886-b812-53541dcdf178@collabora.com>
Date: Thu, 9 May 2024 14:55:59 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpiolib: acpi: Add ACPI device NULL check to
 acpi_can_fallback_to_crs()
To: Laura Nao <laura.nao@collabora.com>, mika.westerberg@linux.intel.com,
 andriy.shevchenko@linux.intel.com
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, kernel@collabora.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, "kernelci.org bot" <bot@kernelci.org>
References: <20240509104605.538274-1-laura.nao@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240509104605.538274-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 09/05/24 12:46, Laura Nao ha scritto:
> Check ACPI device for NULL inside acpi_can_fallback_to_crs(), so callers
> won't need to.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Closes: https://lore.kernel.org/all/20240426154208.81894-1-laura.nao@collabora.com/
> Fixes: 49c02f6e901c ("gpiolib: acpi: Move acpi_can_fallback_to_crs() out of __acpi_find_gpio()")
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


