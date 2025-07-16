Return-Path: <linux-acpi+bounces-15193-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D71B075F6
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 14:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D0061C2681D
	for <lists+linux-acpi@lfdr.de>; Wed, 16 Jul 2025 12:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8CD2F50A7;
	Wed, 16 Jul 2025 12:43:04 +0000 (UTC)
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C9C2F2734;
	Wed, 16 Jul 2025 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752669784; cv=none; b=bD3n4nfRuT08rByYasG10C84ShXzMY+Beq760zrdaQgHXzsZg0rryGJusn4QyGEbD3DCkCtwn59xalEDpSyv/Ge3Np1UkvQ2nircTvrfb5FRQHdQ4GQ3x4OYGqFy2LFNKLUeSWs7urzxDt//2sIHdX18vUjB3/uYGeiIyw6ud+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752669784; c=relaxed/simple;
	bh=1pcwcS6neY1sn2H+xK5xryo5Tog9aCx7zCH97zzeIBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8ecJZsWaToHbE/3W7zqpR0nw5ZSuOkgDLo9v32Dsyp8wNvcu67EUG7yM8oU2UDT1M4b4v6OGqNH+JsOMn+e1V3/aDrouJiCqjz/Mu+Ve65UoLa9ApKjjjFoqqJInlaGGB+PMoFhaqsZYFwxwUJpOgSzdt02+0wvoziHlRdG7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1298337366b.1;
        Wed, 16 Jul 2025 05:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752669781; x=1753274581;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47CMAEiZR5yTBll2g42B2pUuFdN90l8OtcScb22RuEY=;
        b=Wpqvcm+mool5PME/Orvl0kYfEIMvBsMycaNse3pxXzh8/6DjcKBn4b7lAqX9drO7GB
         +As/Xs4dwulC/hVFgfT41aaS0ZUXdsWLTfuKlCInu5oIrWcuTJfSG69jgjS5INsprypr
         mut/Zyjk3uqHVqsFPrsEkau/CIoCu3lyDs6hRznP5mVVDVhGl1AC/BWq1/QZzeUHSROX
         q+hcdAFEKMpxuJSapCpQT+dhQqTaatL1syR15FPAUeX3BtJJAreTQ3BSeTLoi45Q3RdJ
         hvYVsPOHSAmow9t7Ox6HoCsnvFmv/Rw/bG0vWhMTnJNDvs29Vjz7ZRKWh4UgopAPh/tC
         IVCw==
X-Forwarded-Encrypted: i=1; AJvYcCWq3AjQmB6G3q3d3bC0C+RdnTPET6N7A3q/ZGfRVewbWq9MkJbSGm6wRyJlrlXix0RL2BlvRRHNpux2@vger.kernel.org, AJvYcCXBkWALr0nccBSVrvZ6UdqeaJaDzGSmXeRw1jB2momtoGThMX1kpAzEv2P5U1PFFzvz3nxQPvdN0rDK7m72@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3PDgKz1lHuDD42FV4enTt8VrDPoIZuF3JAzUuOEgrKRta/p3+
	XtOL/9RISNMv6h+cgs1UPY2imjP0xMOd6/1Z8nM9z2N0umEhdczj8PRe
X-Gm-Gg: ASbGncsvM9QLQOkUS8ufJ8TZyqeSJugsXxE/JaS1YZB/F7bQlJ4N/2QWuh4RqX/rTfl
	0YVeHOTeVADBnJO/PticymhoT/kw3rRdsPrQ0gVioFsYxYtrSMtsEOLmuYV5qAcDhx1A2Y4Jm3z
	UbXOdRjeyAr4zV8MT8zIPlJ3YGn4z1KQvx5P7MQNQPLIb9D99R+Fs/IAdthLRIX4cqOIS3ndRk/
	bdX5wK8h7fXL6D1uBNrru3HgP56sIpdcRL1T1yDYfP9s0dD9XucmljGO7cGdhzgwRtMB0pLhVw+
	er+ijKxuPLFQXjzRYpqqRItJMEC/EfFoR/EUMAwb3j1fnkl1pQinLjv6BXEN8hBUZzHwOpuoGGt
	9XSf5QIMeecamEwJJig3m6sU=
X-Google-Smtp-Source: AGHT+IHl2TvHHkyPF2WMEidSU/J9NKBX3P3D97oaMObyNwb+BsCscwB+ZjdEMjtI9BgxMGx5SAhIew==
X-Received: by 2002:a17:907:7f94:b0:ae6:c561:764a with SMTP id a640c23a62f3a-ae9cdd82e94mr244577666b.2.1752669780320;
        Wed, 16 Jul 2025 05:43:00 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8295623sm1185331866b.116.2025.07.16.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 05:42:59 -0700 (PDT)
Date: Wed, 16 Jul 2025 05:42:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Borislav Petkov <bp@alien8.de>, Alexander Graf <graf@amazon.com>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Gonda <pgonda@google.com>, 
	"Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	"Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, 
	"kernel-team@meta.com" <kernel-team@meta.com>
Subject: Re: [PATCH] ghes: Track number of recovered hardware errors
Message-ID: <ckn7d3e3xynnup4bbombn7z7xxvld3a7xmqpg4pzp57qebywfc@t2yrn3zqmnje>
References: <20250714173556.GQaHU__LL6IUIPCDIW@fat_crate.local>
 <aHWC-J851eaHa_Au@agluck-desk3>
 <20250715082939.GAaHYRc3Yn49jyvYzc@fat_crate.local>
 <kyprjdilgyz3xgw3slnrsemptnpp6h75mipv6a3lgp2dmwqekg@s7azbepy7nu2>
 <20250715103125.GFaHYt_TnFQW6ti0ST@fat_crate.local>
 <vs5x5qvw2veurxdljmdiumqpseze2myx6quw3rmt7li7d3dbin@duoky4z44zzz>
 <20250715125327.GGaHZPRz9QLNNO-7q8@fat_crate.local>
 <68b6961c-4443-48a8-a7f7-ed94f3352d7d@linux.alibaba.com>
 <p2iytcdfvgm74zif6ihd7gs4kuaeza4b4p52cr5ya4upabiome@kr3yy7fjznwe>
 <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b4c39a87-c5a4-4525-b598-61fc28a8dc36@linux.alibaba.com>

hello Shuai,

On Wed, Jul 16, 2025 at 11:04:28AM +0800, Shuai Xue wrote:
> > My plan with this patch is to have a counter for hardware errors that
> > would be exposed to the crashdump. So, post-morten analyzes tooling can
> > easily query if there are hardware errors and query RAS information in
> > the right databases, in case it seems a smoking gun.
> 
> I see your point. But does using a single ghes_recovered_errors counter
> to track all corrected and non-fatal errors for CPU, memory, and PCIe
> really help?

It provides a quick indication that hardware issues have occurred, which
can prompt the operator to investigate further via RAS events.

That said, Tony proposed a more robust approach—categorizing and
tracking errors by their source. This would involve maintaining separate
counters for each source using an counter per enum type:

	enum recovered_error_sources {
		ERR_GHES,
		ERR_MCE,
		ERR_AER,
		...
		ERR_NUM_SOURCES
	};

See more at: https://lore.kernel.org/all/aHWC-J851eaHa_Au@agluck-desk3/

Do you think this would help you by any chance?

Thanks
--breno

