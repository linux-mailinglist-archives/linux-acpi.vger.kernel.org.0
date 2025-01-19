Return-Path: <linux-acpi+bounces-10756-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB66A1626F
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 16:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2297A1446
	for <lists+linux-acpi@lfdr.de>; Sun, 19 Jan 2025 15:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE5F1DED70;
	Sun, 19 Jan 2025 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PS2kTxy7"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFFFBE40;
	Sun, 19 Jan 2025 15:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737298868; cv=none; b=hdndZsPGa7MxckkfZo3qhr+4HrR8ZTJY6hU+Z60KfD0U6kijwwb+fmYwp1lgC/ij2DAGUJ8QlEa3Q5FeUS0mHksPNXMCQYqtOIr0C076F+0XPjSx9/K8F6xwU+IQ0l3G+DCh9aI8kh8Jf92spPo3DtLnetUNDY7ABdfPdncZgNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737298868; c=relaxed/simple;
	bh=t1aX6k+XGT0LlyqwHYu+F0sQ96ijz0aiD+ocae81SDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCGQ81iJtj5xqGn4qfXJC1YH9tNMfy2KlSoyw4KBAlqnN9Qj5Et0BO6wBeAxG7h/6z3TvKUseb4jYmgxQHFFx9mPDLLcUe31dOu5y3/t9LhRUrs14V587TBGJckuTQN5GZgODh5Z7A+fkEYLrxm6lqtPpWavFYYt69Sda7j78BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PS2kTxy7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43690d4605dso24142825e9.0;
        Sun, 19 Jan 2025 07:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737298865; x=1737903665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XiucCpGPI8u/lPs7/cxACKtAFpS+leo1fbFJnSmmTdQ=;
        b=PS2kTxy7ILLG4K8FeEUMBAKBXxC+ZzlsD5CyekMBvjSGOkCrCb7tcS952HVy9SuhwO
         5DwTtZn5EE4EReNDlJcxDleTXIUYtK2mkq2+hmwna8sYfg4K8Plkue+CH++3R5td70th
         AYdRQIEsSmSfzYB85Q9dRFtnaDFhuze8Qy+GvucgF7fxauYXAieYxoXJ2QFhq9Wm+E7j
         BpE3aROYKnw/4NFzIt/XxPT6Xl+PeocvzvqW1YE4whAnxKnmFfwTGyoHQsBd+w0poI04
         kcNfZGQq07OE/FDu+2Bzi5bidJ6pj5JoDAOo1cHfYSaAH5X2fRtFh/lxLV7gyK9V2+Ub
         J15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737298865; x=1737903665;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XiucCpGPI8u/lPs7/cxACKtAFpS+leo1fbFJnSmmTdQ=;
        b=h/yvUz1L+ZGUe/WsIpYfJN3Fx7iPzODMV5Ee5EpCbeL3TbI6jGfQqs9nCwi2p/en0P
         mqnxCLVGwHB1uxw0dyTX9yAvFBTG/CO+7BQLLIJB/9PD+YQWcSAm9xT7zC1ieZ6718kY
         aGE4GbPDsRNenPx0za4X70gnix8EnI93HOUzYWZelKsGmpj4RWmaYOV5xhkn4b+G/UW1
         mfVLZF0ojcScCpaPfqCklFAhuWmBi7oHdywWygbCI8Oo/bLw55g8IX8NgCBGFqJ2bNJQ
         i/6UDE7N0fiM2s/mgbCtAhQL7gDz0bD82yzdMsDZh7/D4MrqQPaQTPm1d7PMxEmWgEMV
         HB8w==
X-Forwarded-Encrypted: i=1; AJvYcCUwOKjNSbDib3YcHFn8JtRtdK1o/iwRKJFMe8QFZ+Fi0ZVChV58hT8v8UcNuhBSmDf32W2W6778Kwg9@vger.kernel.org, AJvYcCWt93n3hHEid3bzcT3MbV4dyWvP/mUp+1kg2M2dCxqbCuQRe2L7x4FLqbHwJZboDOPUVED3ScFALuvRm1bBcjRYn9OetA==@vger.kernel.org, AJvYcCX5zzzmmF31cZqfocrMGmy8tA3S5PjkdqXwp9sYif7r/xxCcP7pJC64cj48fJ9ZYAkWVZaDXJQZCKPfm8Bj@vger.kernel.org
X-Gm-Message-State: AOJu0YwjogJ/Cmu3Atf8gN9jxmTPkyUwXu9VFqUy6A3H+62nSOjDWcRS
	axCF+ovYFWlUl6fNI6xDD9EkZIpS3eKPWh7SrSlNHdxQNY0+95UB
X-Gm-Gg: ASbGnctE6Rx7dTPndmsY8Pz4pf5mY9WhuLK1T2F3hUAV9JxpedPsSCAaseZXPykSg3+
	QV8jAQcG9s6goj/6g5hbNFLwi6jBOL7+ZLfIuM+a7zg1txxidkDkrYYsw5iHUXXa+eYoTrCLQ8j
	FZtfE/o4B0XUf+bfeOCjKYsfQJIF3SWTce2qDnTN4hVH9SLB8GgW2o1Ki9WW8yE3OEKgSy+Gubk
	AVQ9wPo1+X4Yo2Nk9H8AGp4o+LecQkz02SJDPsP65kVhysRpswbXr5hsyHbehhbJhl97rDpFi0w
	C1KW1++Mrgat0GMDAZE0Cxs90Hl7sB1X0H6YP3mF62vGPBM=
X-Google-Smtp-Source: AGHT+IEdk6n3s7xyqSJfwq8hOpPHgrbG76IpaefBrngVpNYMAGPWc1Jv/7+HagWmU+aBxQOX1dpzGg==
X-Received: by 2002:a05:600c:3585:b0:434:f297:8e85 with SMTP id 5b1f17b1804b1-438913d5da1mr105712975e9.10.1737298865077;
        Sun, 19 Jan 2025 07:01:05 -0800 (PST)
Received: from ?IPV6:2a02:8071:b783:140:927c:82ba:d32d:99c1? ([2a02:8071:b783:140:927c:82ba:d32d:99c1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753ca42sm161468555e9.35.2025.01.19.07.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2025 07:01:03 -0800 (PST)
Message-ID: <b30cc543-7687-452d-a5ce-7cbfe17c3b11@gmail.com>
Date: Sun, 19 Jan 2025 16:01:02 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/19] platform/surface: surface_platform_profile: Use
 devm_platform_profile_register()
To: Kurt Borja <kuurtb@gmail.com>, platform-driver-x86@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Armin Wolf <W_Armin@gmx.de>,
 Joshua Grisham <josh@joshuagrisham.com>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>, "Lee, Chun-Yi" <jlee@suse.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones"
 <luke@ljones.dev>, Lyndon Sanche <lsanche@lyndeno.ca>,
 Ike Panhc <ike.pan@canonical.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 Alexis Belmonte <alexbelm48@gmail.com>, Ai Chao <aichao@kylinos.cn>,
 Gergo Koteles <soyer@irl.hu>, Dell.Client.Kernel@dell.com,
 ibm-acpi-devel@lists.sourceforge.net
References: <20250116002721.75592-1-kuurtb@gmail.com>
 <20250116002721.75592-7-kuurtb@gmail.com>
Content-Language: en-US
From: Maximilian Luz <luzmaximilian@gmail.com>
In-Reply-To: <20250116002721.75592-7-kuurtb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/16/25 1:27 AM, Kurt Borja wrote:
> Replace platform_profile_register() with it's device managed version.
> 
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>

Makes sense, thanks!

Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>

> ---
>   drivers/platform/surface/surface_platform_profile.c | 11 +----------
>   1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/platform/surface/surface_platform_profile.c b/drivers/platform/surface/surface_platform_profile.c
> index 48cfe9cb89c8..bbdc873cb788 100644
> --- a/drivers/platform/surface/surface_platform_profile.c
> +++ b/drivers/platform/surface/surface_platform_profile.c
> @@ -234,15 +234,7 @@ static int surface_platform_profile_probe(struct ssam_device *sdev)
>   
>   	tpd->has_fan = device_property_read_bool(&sdev->dev, "has_fan");
>   
> -	return platform_profile_register(&tpd->handler, tpd);
> -}
> -
> -static void surface_platform_profile_remove(struct ssam_device *sdev)
> -{
> -	struct ssam_platform_profile_device *tpd;
> -
> -	tpd = ssam_device_get_drvdata(sdev);
> -	platform_profile_remove(&tpd->handler);
> +	return devm_platform_profile_register(&tpd->handler, tpd);
>   }
>   
>   static const struct ssam_device_id ssam_platform_profile_match[] = {
> @@ -253,7 +245,6 @@ MODULE_DEVICE_TABLE(ssam, ssam_platform_profile_match);
>   
>   static struct ssam_device_driver surface_platform_profile = {
>   	.probe = surface_platform_profile_probe,
> -	.remove = surface_platform_profile_remove,
>   	.match_table = ssam_platform_profile_match,
>   	.driver = {
>   		.name = "surface_platform_profile",


