Return-Path: <linux-acpi+bounces-6015-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C458D1033
	for <lists+linux-acpi@lfdr.de>; Tue, 28 May 2024 00:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74FF1282F28
	for <lists+linux-acpi@lfdr.de>; Mon, 27 May 2024 22:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848991667E4;
	Mon, 27 May 2024 22:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W80ziovL"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE7317E8EF;
	Mon, 27 May 2024 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716848401; cv=none; b=LcF1pLK+lbADI8OLfGnZb3OSENSvKUNu290p8m06VDJG9v8fa9d13a7BZ5sfnYu8WdtCPtD+5zo60jc7hvuZ/DQrVhYw9HbCnLfEpCCMftRj/FBSfsyBGcPLpLzaxlHnW3vWJ4MCvdhczn8UNrDs2xHcKWAf+Htqpkdo5yHLtyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716848401; c=relaxed/simple;
	bh=FoLzzdavH47LDcSmQtG52Og6l3ufhO8P0y5U93/c1OQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hrKME2m0A76q9Rth3bdHanDbK3fX8dmjQTvjHwO1XPq5RBaUdR63ngWgZQ4eZyhj32Hx3cKOjdaYiU+ul0gRy3eNvdWgOMeFmM8P2p8Y1EWOrXJm7i9O/gAIGVNA9DuDIErhBTMX8NZJsR7pqdGNrbJIqoVwPq8nYQpk4tXyM4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W80ziovL; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43f8e0d8616so916121cf.1;
        Mon, 27 May 2024 15:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716848399; x=1717453199; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GaPEUS08iOQNRmu/NTHB4izZtLjTol+VJzEWZ7iLEQ=;
        b=W80ziovLfQ3RuhZGI+cp82xZgwdOCLPviMdxxBrjNjBLIL+KZwcvjxL7u1ESBweSAa
         3mQxF9OIrssw5bhkly19m+oW5HWPg7NUcjygjcIlfNszPuz71Rjq3VFk/NEPmyk4xg8a
         7Ua6e1OCtjb3r9RgAXSOwlL9aOVyq7/k32DfmH07q0gitKxzufRBP7o6lUl+p/iRdwoL
         NRdgGzzcRe8UCweLbpxUc91QOUfciVVeXoYeHLhZPmV3+aC7eBOK2x8pxPUrIK44Nwlq
         onujxUMwpcQF2dKyZy3kS6mPR9EORSGG4X/sD+rNmfXhwPrZOiPIsyiZYhYLRVVjkNEv
         mUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716848399; x=1717453199;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2GaPEUS08iOQNRmu/NTHB4izZtLjTol+VJzEWZ7iLEQ=;
        b=pGXZjbZ/MzJ7fBw1tMqD+Q80UNXR/L5HuzVTOGoOEIMkHCCDLsuOM/PawA7rEGen0M
         xRCkpZfIoxVja1CmGAytoscxWDrHQrNAvGBMdRCRvZJ3iCb4M4jiDZ2oN8Ae8SHjRDPY
         Dna5JPDN02VXPcJnb04qRLL0bLb1OAV1hxXzDEx0Rl+LDo2FYa/fKAOFpl4jMjsG1cwR
         02qzRbEv4GtugsaC2RVQYpzke5z8Q2WXV6OHz/R2+bWcoGyvTnnLu6V5GAMgZN1Bv228
         EoqpD1QS3lx5NxWeDDJe4UOlRto3yqSEXb+MhT1lyvfu8IFSZYFY9ecse4ms2mZNVdEm
         1lmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQIyxo0kXpLvPylya8Bd3j8ezVFVfB43tFAHzs0/7tb4tFnUrlK1v84D1fP+oDcrn/8diW2x9N7nhM6lG7dNpQRCCncRWRvn/HcpvGUpimwlZtZ5AmLvxyJeAoonl/lvaqk4k8exBoXQ==
X-Gm-Message-State: AOJu0Yyipppm17jMsWFUglU0teQPtfP51v+5bnR3PecqGrIiJgYrsE8h
	4aL/rfpHPqGNQ2AuZ7fLcI3FAqyWvjnMpdhedeRvvR8WL5IzzR00xGdCSo8=
X-Google-Smtp-Source: AGHT+IHk0Aha8PY3x6+VdPKIh6BftyANcRtKk9u1XCciFWbKrScAOKFFI5MUNNUtgtvaVzOf/Y75yQ==
X-Received: by 2002:a05:622a:248:b0:43e:34ea:80ef with SMTP id d75a77b69052e-43fb0e88a3bmr138875981cf.23.1716848398905;
        Mon, 27 May 2024 15:19:58 -0700 (PDT)
Received: from [120.7.1.23] (198-84-205-203.cpe.teksavvy.com. [198.84.205.203])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb17f348dsm37129721cf.38.2024.05.27.15.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 15:19:58 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] PNP: Export pnp_bus_type for modules
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Guanbing Huang <albanhuang@outlook.com>,
 Guanbing Huang <albanhuang@tencent.com>
References: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
From: Woody Suwalski <terraluna977@gmail.com>
Message-ID: <0a1a22c8-ed43-532e-bd91-e82d404eaf89@gmail.com>
Date: Mon, 27 May 2024 18:20:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240527202424.1430103-1-andy.shevchenko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Andy Shevchenko wrote:
> Since we have dev_is_pnp() macro that utilises the address of pnp_bus_type
> variable, the users, which can be compiled as modules, will be failed to
> build. Export the variable to the modules to prevent build breakage.
>
> Reported-by: Woody Suwalski <terraluna977@gmail.com>
> Closes: https://lore.kernel.org/r/cc8a93b2-2504-9754-e26c-5d5c3bd1265c@gmail.com
> Fixes: 2a49b45cd0e7 ("PNP: Add dev_is_pnp() macro")
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>   drivers/pnp/driver.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pnp/driver.c b/drivers/pnp/driver.c
> index 0a5d0d8befa8..1394d17bd6f7 100644
> --- a/drivers/pnp/driver.c
> +++ b/drivers/pnp/driver.c
> @@ -265,6 +265,7 @@ const struct bus_type pnp_bus_type = {
>   	.pm	 = &pnp_bus_dev_pm_ops,
>   	.dev_groups = pnp_dev_groups,
>   };
> +EXPORT_SYMBOL(pnp_bus_type);
>   
>   int pnp_register_driver(struct pnp_driver *drv)
>   {
Confirm the patch works OK.

Tested-by: Woody Suwalski <terraluna977@gmail.com>

Thanks, Woody


