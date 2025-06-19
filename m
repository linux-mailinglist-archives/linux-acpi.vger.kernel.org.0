Return-Path: <linux-acpi+bounces-14462-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 569E7ADFD2A
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 07:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA4C188F148
	for <lists+linux-acpi@lfdr.de>; Thu, 19 Jun 2025 05:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FC242D89;
	Thu, 19 Jun 2025 05:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u11Km7ns"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03742239E8D
	for <linux-acpi@vger.kernel.org>; Thu, 19 Jun 2025 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750312082; cv=none; b=t1ViKkqdBvnz19phdpn7iPt/lrPF1Kkk+jMVi/SeQ3zCXobIddQ0MesE0NYjb5GAQ3SMMxh3qC6qDaPLImp8cVGKOwrXr1Uz8EVMo3d3Jd5djVeEerhSJeGHL6RQm9oH4UUANVZsiECWnJ+Z8ko50dISelYLiVdAfQ7QfkT0ZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750312082; c=relaxed/simple;
	bh=G1pBc79YHeOc8teFMiWj0r25pQg23ExTkVNwbJHUxeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxHMu/LcZ//eHKbFu0lZUsQ0AcGKGfBJbtLm2NPRuN8atAPuDKvurgeVpQDjadj8AlfZ5J/fNneIO5+zyG4/tDVHgspoe8xILT/K+OdtGiazvx9r4vG9tauoqEHOflWuKvqhVKfAAa1ompf63RpbC9Ypyo4VRWaHi7enfx39Fjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u11Km7ns; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2350b1b9129so3427365ad.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 Jun 2025 22:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750312080; x=1750916880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w06pRHUxpM/QQNGaUX6TLUa1ZCwsg87mdzg1cVqYuMY=;
        b=u11Km7nsRaFeAjr6NcA2cCOpcGPPe4gPB6F60BFTa2SDqFGAo/kEDOERtAErFJ7OZT
         wqfPAFeif9DFvTX+y+awgweW1sf3x9kePNlLY7bXKapDEaGctVBYMJzrWr6uq5/WniSy
         qEgLXfYR6pJrKhoXIr8mb+CzbIs+WI+sU4t0NdRJRQMzrQfUCSqwl1T8kWVtSZzwJUmI
         44sQH5wDEqWGDTOIbx0Mi4GhGPCcCvKI/1iSiwCnAdXPnwiNVzT6kzxBiZ3wc+Rs9nnl
         mBaY8iisvG2UCZMREpb2Nb1JgzHG4p76lc/k/1ApqGPj48K25lM3BWaPqyBspvvWaN+j
         n4Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750312080; x=1750916880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w06pRHUxpM/QQNGaUX6TLUa1ZCwsg87mdzg1cVqYuMY=;
        b=DrjtAp3mmcHdkprgMhMeGuMevDw1vy5MAz6it3klbfGOPjxd0iwcph75QNI7uMlFMD
         FDX3XY3Rk/zeftDmFeSkfj27AChQCzHBBJCVbebNAy2mQWTLVzQzkEteujXXGXa1DYQm
         Le2ASzFPMeeBAl3KIRSNF2AGTczfrHaj4M9eB23PR2kXwlGaVS3k7xGO9RX9MFxDtLP4
         N66Obp7pQfuwYGExrCKjgFo4EirPH9oOzYV6pSjnM2ar5IfqhQ2GAuCCYeWFVy2S4sB2
         /2HUoKV9uPLZTqpYgMTlmCzli6aN/d73srh6tBUDRDHtIDpcifdzLl/ZYGxZelldjsvk
         W3Hg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfWifqljjJlofpIE31DK8DT++Hw+YFU9bJEZYhGwGNsmwUEtg0HRJtenMcoInIuwP04vZRMTTouvf@vger.kernel.org
X-Gm-Message-State: AOJu0YwzRLpGiCu9808tUhf1m1g7CVdR5ypXkbOfdNPKub94gXLuSn/h
	alAsA6gmi/0TFsw6N5bsXofyn8EEh8n38eoGddeJxIXuv1rp1YCWO12r1gG0ESCQ9gnvXGl45Dt
	JUDVh
X-Gm-Gg: ASbGncucW8prp7Bjfo5Vlqizs3So1x8YOmaUveWm3FiP8FTOUHVpjYAMIIVfX2bZlCP
	O9z3khgAl0gRlrwZDQlcadmK48barP3ZJCEYjB7NwFPY6ONwuI42aQHOVTUOPZLKm9hUFWDY+/f
	N0wCqS6/zDrGsOnxI/SwwBxP+3QyvlipBttOeps6vM7w8JzZfXZoopmMB87XjR2+aW75OPPv3JR
	Qbb3rid7rYfbOaL6bBudlAFG/jrX2NjXZxM2D2+C7ueR0Mu0Vga5ImV8XfNUAK7L1LlvaCS8wXQ
	0Bg6crHEwNfrU+2jn0+dRi/SbdlpCNarLZdlU7KnWHoGcyzmF2MIpQrIHvtlILw=
X-Google-Smtp-Source: AGHT+IF25Vmp36Sdt4Pjj6dvxhJMSBF+fxUEb8+u1l4GZz3Fuz0LFMidJsQ+FCmOU1nj7dvp8f6VIw==
X-Received: by 2002:a17:902:e788:b0:235:2375:7e94 with SMTP id d9443c01a7336-2366b3c5b99mr313228455ad.24.1750312080362;
        Wed, 18 Jun 2025 22:48:00 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680c54sm12206227a12.47.2025.06.18.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 22:47:59 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:17:57 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "zhenglifeng (A)" <zhenglifeng1@huawei.com>, robert.moore@intel.com,
	lenb@kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxarm@huawei.com, jonathan.cameron@huawei.com,
	zhanjie9@hisilicon.com, lihuisong@huawei.com, yubowen8@huawei.com
Subject: Re: [PATCH 0/3] cpufreq: CPPC: Some optimizations for cppc_cpufreq.c.
Message-ID: <20250619054757.5nxaeckvmaiji5gn@vireshk-i7>
References: <20250526113057.3086513-1-zhenglifeng1@huawei.com>
 <9c82abca-0772-444c-8122-59a953c83984@huawei.com>
 <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hyMANsOwskEUi1c3XB+heE6z0_-Dk1nqnw-SbZ0dM3zA@mail.gmail.com>

On 18-06-25, 21:06, Rafael J. Wysocki wrote:
> On Tue, Jun 17, 2025 at 4:33 AM zhenglifeng (A) <zhenglifeng1@huawei.com> wrote:
> >
> > Gentle ping.
> >
> > On 2025/5/26 19:30, Lifeng Zheng wrote:
> > > This patch series makes some minor optimizations for cppc_cpufreq.c to
> > > makes codes cleaner.
> > >
> > > Lifeng Zheng (3):
> > >   cpufreq: CPPC: Remove cpu_data_list
> > >   cpufreq: CPPC: Return void in populate_efficiency_class()
> > >   cpufreq: CPPC: Remove forward declaration of
> > >     cppc_cpufreq_register_em()
> > >
> > >  drivers/cpufreq/cppc_cpufreq.c | 59 +++++++++-------------------------
> > >  include/acpi/cppc_acpi.h       |  1 -
> > >  2 files changed, 15 insertions(+), 45 deletions(-)
> 
> I've started to process this because it has been sent to linux-acpi
> and then I realized that Viresh should take it, but since I've applied
> it already, I may as well queue it up for 6.17.
> 
> Viresh, please let me know if you have any concerns about it.

I applied this before I saw your email.. Please keep it, I will drop it. Thanks.

-- 
viresh

