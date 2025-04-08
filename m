Return-Path: <linux-acpi+bounces-12837-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 612C8A7F7ED
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 10:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F181899569
	for <lists+linux-acpi@lfdr.de>; Tue,  8 Apr 2025 08:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938E12185B8;
	Tue,  8 Apr 2025 08:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b="eZjKIkFt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5B0156CA
	for <linux-acpi@vger.kernel.org>; Tue,  8 Apr 2025 08:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744101110; cv=none; b=Q8mHFjfIer86eBahCiaOWsgh2w2HOqnYf4Y3NgNWs9YmZ9lWK3g3l5N7Z/1xPgNmk11uGiFftWIQPsJFXZZok/F/Lnkii3MBhjLE/+JTj+48j38Ww+exFau9vo5Z+772wCCjgT835gyOyArLkUDgn1kRXUXqGIBcR3TgXkdpHms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744101110; c=relaxed/simple;
	bh=Hq7OJ3RwBznOdA733fpGmrFHhd5qVLu5ZN47Y78qB7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WAn6iiI+9GkI5/kP+6y20XgongvMOoM9R1PNFBhJ3eNT5L9Ud93jxzt02T4x/Sop+hmQ9ktU/uI1peG2CaOzqiUm1TlZZHblM7hAN7N6PXGW3zOolADAaSEYWJP48/HTVIYxIzGpNDiG1dkhUzOvLOje03mIpCb76PUBLZXskfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=diogo.ivo@siemens.com header.b=eZjKIkFt; arc=none smtp.client-ip=185.136.64.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2025040808314078657e0c94498ab2db
        for <linux-acpi@vger.kernel.org>;
        Tue, 08 Apr 2025 10:31:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=diogo.ivo@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=aWpO5qb18Mjrv4G9P3h8hBHuno7AfWs3U1lfu4A/j7o=;
 b=eZjKIkFtN42XbkSvuCCCHrc8/AuX8zzbomK2+pWvDT74ckB2Itv7Sn8gjVqGwQSZhbCYI6
 ZikeGt/ZJ+S7gUzYpf44yas18L+bqVb3Ed2Ahjlygsr9Grp/u+XofI+H2B5AZvmm+TpRi70V
 MxHtCEmat8Ktqvr/nZGy3mHS8hv+YwuNXkIF1HwXTXMPUxQz8nAleqDheqLaG9c+VzsB85uS
 QSiv4sNrrZt2nBw0vPXxHJ82gkoSX2KOWiggdiDvlSZkMDlcZomoxIpAmdjZQWnMXS7cR7lI
 WAHgIoe5iAZlwZSK7/2rwPDpnHbG22tT1Tr8PfOjCNONZmUZu77c82JQ==;
Message-ID: <daeedd95-1d4a-4d17-baa1-9c1580095de9@siemens.com>
Date: Tue, 8 Apr 2025 09:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] watchdog: Add driver for Intel OC WDT
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-watchdog@vger.kernel.org, jan.kiszka@siemens.com,
 benedikt.niedermayr@siemens.com
References: <20250317-ivo-intel_oc_wdt-v3-0-32c396f4eefd@siemens.com>
 <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@siemens.com>
In-Reply-To: <20250317-ivo-intel_oc_wdt-v3-1-32c396f4eefd@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328357:519-21489:flowmailer

Hello,

On 3/17/25 10:55 AM, Diogo Ivo wrote:
> Add a driver for the Intel Over-Clocking Watchdog found in Intel
> Platform Controller (PCH) chipsets. This watchdog is controlled
> via a simple single-register interface and would otherwise be
> standard except for the presence of a LOCK bit that can only be
> set once per power cycle, needing extra handling around it.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Diogo Ivo <diogo.ivo@siemens.com>
> ---
> v2->v3:
>   - Collect R-b from Guenter
> 
> v1->v2:
>   - Split v1 into two patches, adding the ACPI IDs in a separate patch
>   - Initialize hearbeat module parameter to zero
>   - Clarify wording around lock handling
>   - Properly print resource with %pR when failing to obtain it
>   - Enable compile testing and add dependency on HAS_IOPORT
>   - Drop unneeded ACPI_PTR() and MODULE_ALIAS()
> ---
> ---
>   drivers/watchdog/Kconfig        |  11 ++
>   drivers/watchdog/Makefile       |   1 +
>   drivers/watchdog/intel_oc_wdt.c | 233 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 245 insertions(+)
> 

Gentle ping on this patch.

Best regards,
Diogo

