Return-Path: <linux-acpi+bounces-9053-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD989B37A7
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 18:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D501F23E1E
	for <lists+linux-acpi@lfdr.de>; Mon, 28 Oct 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE7B1DE4E5;
	Mon, 28 Oct 2024 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDhgYrih"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD4A18BC3D;
	Mon, 28 Oct 2024 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136651; cv=none; b=a5Ekqa60zoVD6kyPgkpGEyf6TmvKxy2nRTUQsCMxJATTkqarbuzyCJlHQshUbpW5OuxbBKL4KiO7p2TN5XhVxyHWsfork1QbTSfdvCE0CpgTLlNnpF1w6W41f9Y86D6RQvlSWdrToVjSNn9NZNOBm3brj9Gk1u3+LWBTdrciit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136651; c=relaxed/simple;
	bh=en+0/b80xoMqfpIFPi3drNS6iY00gOUQkLTiBt9paQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QgbdctgH9BE+Q1nHUZ2NHbU5nYwwubQTJUr7zpiGgEGR1c8Zu2jKWVR//V9fBMf+ehxEw3QyLAlSXhJZy9BaH6ymS/Gmm0s+asCNRNgNcJOR40WHqu28oeeUlW6p1euKPdsytUD4PoaB1v6YLJmS/vYpPfEBkS0nssx4re9gRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDhgYrih; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-539f8490856so4216381e87.2;
        Mon, 28 Oct 2024 10:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136648; x=1730741448; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+npSDU/6eO84tdQb6NEblNRrwQw7Vs4S01viEtwA4sc=;
        b=cDhgYrihcqMwTfw3xFARKY8edxPBwZm7QiH2XbuoVKRXmWqDyKCahBPRObvT0ecJcj
         IqyLi6RroanbM7HJDKLPfec0qv/S7StCF7BSxq2DH2lg0ik0AmniKmVFMIEvjJJJls/a
         Ts4oTnkirqqcXdgf3v0OpENqMeL3EEL2bNl4xZyiVLzxrwx9VfWGNT58qQeyV1CUCs6e
         fh0GCWtwnWLllfZsLi8LP1RoIdo0ATkRPYyY7VDUwN8sCwsDVUEyxI8u7IiWsvjx6Qri
         nITyOUObrfffRJ1tFds3Me5uAlnnTZO4m+ZooCh9cpXAqY8q0bqqkm7E4Q9uD0kVCCCn
         mWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136648; x=1730741448;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+npSDU/6eO84tdQb6NEblNRrwQw7Vs4S01viEtwA4sc=;
        b=fAfawc2XTm9xb2V4QKiTbKq1rLtKLoUTXCkMXQevMuScbT57IrPMt5C82TUkLWwQoa
         RoMs6G6+cbwxd1dxyYWJ8WM6SceBSdTYQIKnCim7EERqYgxn6A6XT4kNyGE4AmPh+SH1
         8yx49pkQddgf/7Yc4DvAySo0MAGI7NZzpwQ6YixFaflfH9etRRFeOamumgZ3kh438YQK
         qRv3Bs7LYNOS4TUxB1dgYOObaprpxxphWfEzSWDRVuBiopJfj8/4Ky7shxKdT6IyVVPh
         fHrY68ujPmicvh3GEtGEpriFm3iUR+dWlpkzBwlIpCIO3qzqKt9b+qOWw2KCUkVqhEVC
         aXug==
X-Forwarded-Encrypted: i=1; AJvYcCU2J6DPieMMVv//gv77v4i2KSmewZPT/1JvwG1hQfP7Mujq9OnvVOTADJ2jSGw0rI3dD1H81AiSu2K9@vger.kernel.org, AJvYcCV934HcbWaXRWQaJ7NOvkvZmKcDeWV2Gu6+kNLVWd9xExxPyU5vSMVN9eH1EOrNeJ0M60SUa16Yx/IW3KsS@vger.kernel.org, AJvYcCX1PZ1th3yYkgH9YHGOPijACO83Z++/EteMs9ae2usb8czETf/fLE8rUZB/yGwd/JwRTfJJ/h/+mCE6i32H3Z8lrZQxQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUz3rdUN11KABP14OhV77yjcX4kaYe5157sY6lGp+2U/mvIbg6
	A8WiznBzJMyFNlmXJcyUq0Yta5BRHcSym+nkf8eA2Af5CAy693Lf
X-Google-Smtp-Source: AGHT+IEzlAiuaLY0pXur/4pY7BiMQ8uaSjTMPmEc83Ii2p02tll3LoFp9D/0/Fzmak84mIwejUXllg==
X-Received: by 2002:a05:6512:e99:b0:539:f496:aa88 with SMTP id 2adb3069b0e04-53b34a198c0mr3480807e87.53.1730136647146;
        Mon, 28 Oct 2024 10:30:47 -0700 (PDT)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4319360c10asm116270075e9.43.2024.10.28.10.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 10:30:46 -0700 (PDT)
Message-ID: <2934c00a-8bbc-4090-ad0d-8bc5f79cacaf@gmail.com>
Date: Mon, 28 Oct 2024 18:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/15] platform/surface: aggregator: Add platform
 handler pointer to device
To: Mario Limonciello <mario.limonciello@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lee Chun-Yi <jlee@suse.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D . Jones"
 <luke@ljones.dev>, Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Alexis Belmonte <alexbelm48@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 Ai Chao <aichao@kylinos.cn>, Gergo Koteles <soyer@irl.hu>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:ACPI" <linux-acpi@vger.kernel.org>,
 "open list:MICROSOFT SURFACE PLATFORM PROFILE DRIVER"
 <platform-driver-x86@vger.kernel.org>,
 "open list:THINKPAD ACPI EXTRAS DRIVER"
 <ibm-acpi-devel@lists.sourceforge.net>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Matthew Schwartz <matthew.schwartz@linux.dev>
References: <20241028020131.8031-1-mario.limonciello@amd.com>
 <20241028020131.8031-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20241028020131.8031-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/28/24 3:01 AM, Mario Limonciello wrote:
> To be able to reference the platform handler in remove, add
> a pointer to `struct ssam_device`.
> 
> Tested-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2:
>   * Use ssam_device_set_drvdata()
> ---
>   drivers/platform/surface/surface_platform_profile.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 61aa488a80eb5..a18eb93eebb92 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -210,6 +210,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   		return -ENOMEM;
>   
>   	tpd->sdev = sdev;
> +	ssam_device_set_drvdata(sdev, tpd);
>   
>   	tpd->handler.name = "Surface Platform Profile";
>   	tpd->handler.profile_get = ssam_platform_profile_get;

Looks good to me now, thanks!

Maybe this could/should be squashed into patch 03 now that it's just a
one-line change, but I'll leave that decision to Hans or Ilpo.

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

