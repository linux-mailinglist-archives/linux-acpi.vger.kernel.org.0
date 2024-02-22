Return-Path: <linux-acpi+bounces-3847-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6605A85F607
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 11:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB45285875
	for <lists+linux-acpi@lfdr.de>; Thu, 22 Feb 2024 10:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9563F9EA;
	Thu, 22 Feb 2024 10:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mBLobr3R"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6BB39FFC
	for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 10:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708598894; cv=none; b=Fk173GBbIUdd7asRAbh6ICYasmeQW/A8iAsQ33rDXuLldS8eMcOwJ/SfV6U5cYq8oA260KHBZVj3jze3IYdNq9sYJ6JYtkDCKHCWHEBd2O+eacQGENo8dN0vFrFQBbCqttImRdwb4w2Pnq5eMc9A8KGJUVPy17FAO3giJXmDwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708598894; c=relaxed/simple;
	bh=k9sBpNexw7nybOFrsaBxJZModR7TqqGCIuG7UPZ6EhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka0yRiE6k+SzL4KCyEj83vOdRzkRB3kJmFx3YsFBexoBi+Fj+f0T7EDti3V9EK55s4S+UqfFtHZqB6bn6I/CRBNS6agchdbENYCzYP3zElCSsDN4uw5q5l0O9vlXr0m8qCVlnHMJy5cwjl0cwsQZyl7Ngbs4PFaF5jv5kqdXVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mBLobr3R; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41241f64c6bso11953375e9.0
        for <linux-acpi@vger.kernel.org>; Thu, 22 Feb 2024 02:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708598891; x=1709203691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaPZ0gnges6CixkiAGzHAtGp1CFRPMZ1FV++RtCtVaQ=;
        b=mBLobr3RwgxRwmjJ6C6pGjWeLll/UuRAdN3grNYuemLmfVEx42+JKPMtQ97FAkw83G
         7fVq//dmWMWykfgi2pLNN3iJOrVqZtpkO6EpthzMlFYBdOaYLUHkYkFJEDamqaJK8x1p
         MPkps/msHSLbhteapxVDYtKB5vsflLXdOTYiKHOQHkilevdcpRVOu9xAuO8nmU6IUK/+
         tsGmJUZ1KhBIQ9d6MucJMGXfbwEMvx33v63TbP+FdlXKPH7pL0Ki4W13RUUKOAwJwU+t
         mO/MQC1FsxVanbhdNqoNangqLrsH7ZHuO/wbs0GDEhU1WahgQrs4RhhUa550G/8/jKpR
         9UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708598891; x=1709203691;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaPZ0gnges6CixkiAGzHAtGp1CFRPMZ1FV++RtCtVaQ=;
        b=pzEMC6cYfzvujqQIzboWkbcY/dGoRkRx3Qhz4nypcr3s6fapyGih1hvNPPa6ishLlI
         LShXXgg/6AY+bepMMbE9V8nkPXXqHqQzVEn5MFXN7hpW+AOhSiM45Zt5NGr5Xs8XriD3
         uI3hfawFjA0aZENoDgFOum+dAdTkl3qU8MszmWQNI9SualS3Swj6pEUVJsMrGq0ck45k
         8fbRCI7BDRg3P07twxB/pwguKqFnMxjIaQpDuQJ2j89bXDswq/5fNTsmM++gDFuCuCzl
         1PMfCz5bgTLrLSWdjwNeah9hWpvKLloduoY0Gw4nWZrDvJT+FwsZrDWbDw/GLxEHM3+q
         Djtw==
X-Forwarded-Encrypted: i=1; AJvYcCVl2v5i1U/JBKNfXUDBmqMr01HDlvLe7/y28t77AEK458Hc+g0VfAyyHrDN27HT4WkNeCYI+7bJykf8v1HeWTmRLjFwZqzR1WTQsw==
X-Gm-Message-State: AOJu0YyKpmF9DqO0WBmj7vQnX+oAMQ9fvnMtTbEf/w1CgHR00soL6dv0
	bHzl/yeH24mgRToW6KzOgmm6aJGewI9pNf5vBrPnd0rA+A3jrnmRzqmwJy0aif4=
X-Google-Smtp-Source: AGHT+IEaKbEQ4+W/yPiy+1ShUDPbgwywFQu2bABbwGjGz/RHC4KkDOiCPxT4IkLM8a9aGlSqpMx/7Q==
X-Received: by 2002:a5d:6051:0:b0:33d:3ab8:2da7 with SMTP id j17-20020a5d6051000000b0033d3ab82da7mr8525002wrt.11.1708598891121;
        Thu, 22 Feb 2024 02:48:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id bo29-20020a056000069d00b0033d5f5571b4sm11278754wrb.44.2024.02.22.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:48:10 -0800 (PST)
Message-ID: <53878b7e-6477-4cab-901d-1da64e2dfdc5@linaro.org>
Date: Thu, 22 Feb 2024 11:48:10 +0100
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] thermal: ACPI: Constify acpi_thermal_zone_ops
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <3552599.iIbC2pHGDl@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3552599.iIbC2pHGDl@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:48, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, acpi_thermal_zone_ops need not be modified by
> the thermal core and so it can be const.
> 
> Adjust the code accordingly.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


