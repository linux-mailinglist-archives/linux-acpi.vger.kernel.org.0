Return-Path: <linux-acpi+bounces-7655-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C3C956A0E
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 13:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 142C41C21FAB
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCBE169382;
	Mon, 19 Aug 2024 11:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doCPUDfm"
X-Original-To: linux-acpi@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3EC166F3E
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724068646; cv=none; b=MAuOhIbnteW7+2DH5sckhPyamO1C3Q9JzdcXFp5YCbk7t8quqG4Mp5PA2G+CTZfmOzUuZzCO5Rb3ZOdKdzCQSpofMpho5n6XWyRrlE+AB/DOJvbPIsjNpK7b3oc4mG0wdvNnAeXM5Ql8h1NJTGbPDjAiptmGxURAg35Ayw3vWkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724068646; c=relaxed/simple;
	bh=ij/RhKXAEL9cVBO15IYVkcQPnrzyZPTaGryR8ECRDDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bHSqAnOoZiz0m0+fr0eJHbQwD5f3exgxaJD+5Mr+WqItgIW7A0neI4VzCHEtLnWTYYTNYAfqZmK93zub31hvIkkX/lGxH1qOJoMWZIIYsPT9sWGZk/0HiauMACWDAeqXl5L7CdWdGWYLB3wsPaiZMmXEZeHJMnxF4jX9rRgbQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doCPUDfm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724068643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84PhB6eF89FFZ8ucHgT9n7pmJgWbulzk/3Qj97ioNCk=;
	b=doCPUDfmbb9RrUFBJlCBcXdCJZ5jLv0wcfehRVkb44p+Z1Ce+DKEfTTdNk1soeIlJVfxnj
	LntEIU7uQ5d2DAUEFdBlgxHRZjV0GHsSusJcgdGm+C2A056qfsz94e63Ar0T9DTfzKWQQo
	7c0LSBLcoBkK41qP0uqYuwDeleyxJjo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-SDdMxKz9O7K3TqcjWDva8A-1; Mon, 19 Aug 2024 07:57:22 -0400
X-MC-Unique: SDdMxKz9O7K3TqcjWDva8A-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bed96c350aso3163492a12.0
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 04:57:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724068641; x=1724673441;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=84PhB6eF89FFZ8ucHgT9n7pmJgWbulzk/3Qj97ioNCk=;
        b=l1U3c7cPea6aTHQ6ouBRwEew+kmmTpby7S6eBZnzQmARpjTTPYhRM9cev/FkOmAvw1
         WSfpXt9DzlauzWge5RjG5fZXS0rWlYOzqDYi/P9az8mjNAK0bzaWNoZ+Abge9ACkjZll
         nvMoowtuEUPajgHRCYPfw36S/WgziEUTQW7dSk0eo3PVQMAUWCJdLLaQ6R6LN8KcnFnZ
         bWFA92qcvC0q+kWtFEx93QeK+CB2ezezwFrwlOrXGAfymjF4xbDGfhufGo4NkJi4nhdI
         yEUCyjSNfZKev/v3iH/eKHU/yKfFyRDF/ciS7LkLJVwe0VH/ZaDCBbUdYDEdqFmjLIve
         wthQ==
X-Forwarded-Encrypted: i=1; AJvYcCW97oAuRQBJg+RfHIRy6Uk2zQNZmuoHI+dCiUsULrLsKsICoRI/+gPO28WH+e5rQHn+VUkNWOvXLQjO9E+4iBHNti0opf1DqHeaJQ==
X-Gm-Message-State: AOJu0YxmcRHakp5QHssh6DWxKJ/nu0C8oVeqv0s8XL+AWV2llhC3pM2e
	UFMZTisd/fLK6Z6Y7Rr+V+B+QqxFOnnNC+QGSSg9yURLqHU6yupdC+7i5xCQ1uSETYUJyuuer46
	2O5T78QF1hhu3Tz2usAT1MgA+CcyTAHqtBbHs+rjFFTZS3J8Vxc6P3ffi588=
X-Received: by 2002:a05:6402:34d4:b0:5be:ecd9:c73e with SMTP id 4fb4d7f45d1cf-5beecd9cbf3mr4997304a12.2.1724068641332;
        Mon, 19 Aug 2024 04:57:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnRo8JGhy8S0tLVgxUpCSUbuvlldmz7SLn5JDTjjd9seJwXdLBAybiRE42CshwTS82wSQmig==
X-Received: by 2002:a05:6402:34d4:b0:5be:ecd9:c73e with SMTP id 4fb4d7f45d1cf-5beecd9cbf3mr4997268a12.2.1724068640890;
        Mon, 19 Aug 2024 04:57:20 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bed05f0a30sm3999829a12.30.2024.08.19.04.57.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 04:57:20 -0700 (PDT)
Message-ID: <1edadffb-67d9-476e-b0f7-7f3fc34e9592@redhat.com>
Date: Mon, 19 Aug 2024 13:57:19 +0200
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] OF support for Surface System Aggregator Module
To: Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-acpi@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <quic_kdybcio@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
References: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240814-topic-sam-v3-0-a84588aad233@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 8/14/24 12:27 PM, Konrad Dybcio wrote:
> Wire up OF support for SSAM drivers, to use with Surface Laptop 7 and
> other Qualcomm-based devices.
> 
> Patch 3 references compatible strings introduced in [1]
> 
> [1] https://lore.kernel.org/linux-arm-msm/20240809-topic-sl7-v1-1-2090433d8dfc@quicinc.com/T/#u
> 
> Signed-off-by: Konrad Dybcio <quic_kdybcio@quicinc.com>

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

I did notice the following compiler warning when test building:

drivers/platform/surface/surface_aggregator_registry.c:278:36: warning: ‘ssam_node_group_sl7’ defined but not used [-Wunused-variable]
  278 | static const struct software_node *ssam_node_group_sl7[] = {
      |                                    ^~~~~~~~~~~~~~~~~~~

One way to fix this would be add #ifdef CONFIG_OF around the definition
of ssam_node_group_sl7, but then future devicetree based surface devices
would need more #ifdef-s so instead I've solved it by squashing in this fix:

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index 495cb4300617..ac96e883cb57 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -415,14 +415,12 @@ static const struct acpi_device_id ssam_platform_hub_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, ssam_platform_hub_acpi_match);
 
-#ifdef CONFIG_OF
-static const struct of_device_id ssam_platform_hub_of_match[] = {
+static const struct of_device_id ssam_platform_hub_of_match[] __maybe_unused = {
 	/* Surface Laptop 7 */
 	{ .compatible = "microsoft,romulus13", (void *)ssam_node_group_sl7 },
 	{ .compatible = "microsoft,romulus15", (void *)ssam_node_group_sl7 },
 	{ },
 };
-#endif
 
 static int ssam_platform_hub_probe(struct platform_device *pdev)
 {

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans


> ---
> Changes in v3:
> - Drop unnecessary nullchecks
> - Add MODULE_ALIAS in the platform hub driver
> - Fix MODULE_DEVICE_TABLE after rename
> - Prolong the '----' comment to 80 lines
> - Change the current-speed bindings description to ": true", in
>   preparation for krzk's serial device bindings reorganization
> - Link to v2: https://lore.kernel.org/r/20240810-topic-sam-v2-0-8a8eb368a4f0@quicinc.com
> 
> Changes in v2:
> - Fix kerneldoc
> - Drop the drivers/acpi change (oops)
> - Style fixes
> - Don't assign int to acpi_status
> - Don't scan the bus twice in SAM core probe
> - Link to v1: https://lore.kernel.org/r/20240809-topic-sam-v1-0-05bca1932614@quicinc.com
> 
> ---
> Konrad Dybcio (3):
>       dt-bindings: serial: Allow embedded-controller as child node
>       dt-bindings: platform: Add Surface System Aggregator Module
>       platform/surface: Add OF support
> 
>  .../bindings/platform/microsoft,surface-sam.yaml   | 47 +++++++++++++
>  .../devicetree/bindings/serial/serial.yaml         |  2 +-
>  drivers/platform/surface/aggregator/bus.c          |  2 +
>  drivers/platform/surface/aggregator/controller.c   | 67 ++++++++++++++----
>  drivers/platform/surface/aggregator/core.c         | 82 +++++++++++++++++-----
>  drivers/platform/surface/surface3_power.c          |  1 +
>  drivers/platform/surface/surface_acpi_notify.c     |  1 +
>  .../platform/surface/surface_aggregator_registry.c | 47 +++++++++++--
>  8 files changed, 210 insertions(+), 39 deletions(-)
> ---
> base-commit: 1e391b34f6aa043c7afa40a2103163a0ef06d179
> change-id: 20240809-topic-sam-5de2f0ec9370
> 
> Best regards,


