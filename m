Return-Path: <linux-acpi+bounces-18270-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AAC12EA8
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 06:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EAAF1AA1417
	for <lists+linux-acpi@lfdr.de>; Tue, 28 Oct 2025 05:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79F525A34F;
	Tue, 28 Oct 2025 05:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ahZ/ApeX"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196DA226D1D
	for <linux-acpi@vger.kernel.org>; Tue, 28 Oct 2025 05:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761628430; cv=none; b=PxfC8hwOYv3nl2S8shimsPdv+sJ/5QTIeKFK3ria6syUJ4rcAzZx3WowICBUU7mhBawBjqlbFVZ1/iZlVi8TL7e6hThMBRu5qtArklFrkDnQYioQGHE7qpfUDakcfJq89Z7ESYQMKgR0JFV7F8jelAGMHJrmQCtqVqEsvhxOUJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761628430; c=relaxed/simple;
	bh=JzjopnCgRwMkOrIXUcs0apSqXyDx2AUYdNUeCiTo60o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3TjwhKinrz32bpUiH/vAgkCdxIvZuzXgprRotzhizCEg5cAQFBuihDXvnK6JyKOcpsuMFE66Gior5O6swXCcznrzDDZ96nFLjNnnJIEkK4H1xNhvy2l5aZYOUN7Ve0aoghz/qXzRmrXHGrpoE2pDh+E7UPmwSBO8VZT2ssgl/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ahZ/ApeX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-26d0fbe238bso39552975ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2025 22:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761628428; x=1762233228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMKDfhFuWhQebRAxT9YejjbQsAd2wDwWly97EhWdZpM=;
        b=ahZ/ApeXJcHxjMGIuThK/TYpDIMrlB974KbVA62weNBwS/URK2204TRPN88i7+HLk6
         P9D9+aAgHFBavwaEXttKRlpVdNu+NyW2pzMHJlRnUykeyfwPSVI+GRO8q4wwwxKkYvIh
         ansQe2bd+7dN44dC7mSLeB8fo5hdDPsghHCje0xZC6qUYD3NN2rz3DOudKfZOdPOXmRb
         FHWRFpScm2A3Ht6jF0j0zn1YZ+8sGg39UXlmjb5KfZ5OcTHhi+xxJI1g14Ny3U91q3r6
         xQ41KmrgndtcW6zDKldaMwD99+KfQfGhSbVHwdO3ADIVJhleg5Gh4QiwQcNsrgXh0tmq
         9seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761628428; x=1762233228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMKDfhFuWhQebRAxT9YejjbQsAd2wDwWly97EhWdZpM=;
        b=VAd27THB6cpdzMz0nFl4OUmQqIIzDw51ShaLU+SiPwVCcpcVtE2EYBvhew67Rn1/8w
         UnvuHWtNyxHfZxTtUPmKBI2uca7BSFXnsxXg4T+WNmRX10TVa6HLPstjr3NNEaotqfL/
         ZvhtmXzmAYsny6Ju1+mlOfMSBJpOPDf02P4SnpkX02MX8yD3zylVOQc0azvVAcncYbbf
         6K2u4fyogNc2sQkEj+qkzz2MX54/hwIuPZ4IeROi68n6BhmIpN9CyWA8/cckzr/zaXgK
         Y0/LM5O16yY9LBbKGZMqSpX7x1v29E5pu2Wte/CCNCSftPj0qN6OBzbCciYkolr0AzTr
         17BA==
X-Forwarded-Encrypted: i=1; AJvYcCV6fivOA768j9jy4dxsIdro5/THSrt15rkNrO+6pobi/68a/MzH0GP4dbW7WYNGVy2/RZgOJZwU6SLg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16ShJDFPgiJ1WOulk++Gn3NCZCC8ts9E42syjBmcehH95OUhN
	PrFdvyRDaUSDnohiEnf/T/oHQNscTXQPX9Bm6CjC0rsjQF1JNkI7jQlwEPCAAgtw7rU=
X-Gm-Gg: ASbGncu25j7vO56hpLH2MYNsydAJpWmZHwU3/f0X1+OqBt3Ub4V72yaKHHMR9bUoKX9
	10ucPRYtxRadlMCJGtHZnEhGH3a4IuiXNWTnwOgqsVw2tDvmJve1oNNyq5UKnAFlqdPI0MJKfeR
	CneNC+P743n01nXq4CXP47N3BQcvV37F0cWK4LhwQmGJY6oprdSErsJalNBeu7ybvIIrbJYtdhY
	gIexx7il8YXnjFU1ORe0TJRyMEsa/KFNhWJeFaCkrw9cwsJXkWBke8ORJHstOoEpq33DHSHGQ61
	60BdLQHcBuoa1jLrUHyI4rUufc5fwIEgG21aCegWOsqif410Fw8UgoEL9e7lUDHGwpDuGbE5UW6
	YkjOnbGyPzRsvNvw+VLt5aFQ5pwe5VLyGaTNjsbt0UmyDru0FlsDV3CTxFoY3kBnQ/gey6vH7ez
	i+6w==
X-Google-Smtp-Source: AGHT+IFv8BScqO2z2oq9pmjixKfhhFY8KhLHypHI2fFhnUIb23B+PdR7UKWT6j7I/gfPQdC79UF8/A==
X-Received: by 2002:a17:902:f682:b0:27e:eb98:9a13 with SMTP id d9443c01a7336-294cb3d7202mr25628145ad.22.1761628428297;
        Mon, 27 Oct 2025 22:13:48 -0700 (PDT)
Received: from localhost ([122.172.87.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42ea7sm100637885ad.101.2025.10.27.22.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 22:13:47 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:43:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>, ionela.voinescu@arm.com, 
	beata.michalska@arm.com, Sumit Gupta <sumitg@nvidia.com>, 
	Prashant Malani <pmalani@google.com>
Cc: rafael@kernel.org, zhenglifeng1@huawei.com, linux-pm@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v2 2/2] cpufreq: CPPC: Update FIE arch_freq_scale in
 ticks for non-PCC regs
Message-ID: <xpktefok4c5vsno5fkizsjirbygsict2or2biphj3ugqbdvdq5@f67kdijo66y3>
References: <20250828110212.2108653-1-zhanjie9@hisilicon.com>
 <20250828110212.2108653-3-zhanjie9@hisilicon.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250828110212.2108653-3-zhanjie9@hisilicon.com>

On 28-08-25, 19:02, Jie Zhan wrote:
> Currently, the CPPC Frequency Invariance Engine (FIE) is invoked from the
> scheduler tick but defers the update of arch_freq_scale to a separate
> thread because cppc_get_perf_ctrs() would sleep if the CPC regs are in PCC.
> 
> However, this deferred update mechanism is unnecessary and introduces extra
> overhead for non-PCC register spaces (e.g. System Memory or FFH), where
> accessing the regs won't sleep and can be safely performed from the tick
> context.  Also, reading perf counters of a remote CPU may return 0 if it's
> in a low-power idle state, e.g. power down or reset.
> 
> Update arch_freq_scale directly in ticks for non-PCC regs and keep the
> deferred update mechanism for PCC regs.
> 
> Signed-off-by: Jie Zhan <zhanjie9@hisilicon.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 52 +++++++++++++++++++++++-----------
>  1 file changed, 36 insertions(+), 16 deletions(-)

Ionela, Beata, and others.

Can someone please review this one ? This has waiting for a long time already.

-- 
viresh

