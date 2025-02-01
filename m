Return-Path: <linux-acpi+bounces-10875-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C328A24AD8
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 17:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700DB7A2DFF
	for <lists+linux-acpi@lfdr.de>; Sat,  1 Feb 2025 16:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753F41C8FB5;
	Sat,  1 Feb 2025 16:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="h1tg8ie5"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16D208A9
	for <linux-acpi@vger.kernel.org>; Sat,  1 Feb 2025 16:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738428843; cv=none; b=o/elNiXlGNLRvbSSVT85PD9idKjxPnXhUihruJJGfcoqi5eEAusxjfzk1OmhEwnMQ+2lS1p6RZE27RuOjjj0F7JKOXSG6kLs//J84ocgwLA3LSvVuNCScgonLL5C2FeAoUX+PMCRiV6ez6JZtD3HCtG7at3Z0Vtz2mPx+MXZay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738428843; c=relaxed/simple;
	bh=xa+25ur344OEW7t7BkDF9Du5L+MmLYguJNQOy0Mq0xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4RmlwxC8J96WjmjiITAvX+ONLgGVHytA5dSmOHPKXDWG7jvz/5WqyM5pt+vazdNpgCI/UY7v6B1UuYfSK9cmgut/m7WntjDNLgr9vMSF4Yr3gIqLMbjTyXHTSHEZDldvMKescO9zv46TigoPPAbd+XT1VN/sdh+FZdd8NIMTSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=h1tg8ie5; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7be3f230436so269399985a.3
        for <linux-acpi@vger.kernel.org>; Sat, 01 Feb 2025 08:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738428841; x=1739033641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmDNfJVAoqWOWRyDOjqr6PMbGbgV/Gx/qMdbUArjGps=;
        b=h1tg8ie5GOPeKhbdbln8/Fof6Ix9EXyK2NAD9Ak42BsM25N7bLN8twjyIJMNGmIdSq
         ulbKF0tR8l204wh94VVpKo8qg3WOW3KKcM12wv+XhtfKrAALFuNqkKDceH3R8E0Kd4zV
         S9X8YQnUz8vTi1GkF3YnNrIm7bT57sJKaiyipSB9KcyV/JdetziV8v3T7pGe4aBeBJFg
         fvWBsrby9lFf9qr7rV/b3gW7+JN4FVflrc/F/Mn3GUv0ODBGyoLNTakwrkETXUiaZS1E
         f44BTGy1KmBqar7XCU6EYNp5v2sDIbHt9nZHqRTIBvbD3Ri/634BkWAmuvg1EEORBby4
         RxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738428841; x=1739033641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmDNfJVAoqWOWRyDOjqr6PMbGbgV/Gx/qMdbUArjGps=;
        b=n5/HnIYStGGkt9Jd8Ec10KCOGttRA799PSJer7a7YIRXKt2m2c7+gEV4pIKiAXnTyO
         yk0CMMX8Hf1yOE6Y6ysliiasUKR0GboiA0A74xTSAHpGOpQFiKEBjtxfaopMCmA+/puH
         8RmJYOtZ8ZKBlzA8NxC4+wfcaXi4Z0lfFcdzAbRqVge/d9rBv/cLpCOMCV43Sq3N/Xo+
         LAfrGFv2pVCTTeYUXFD92EYgOx/uHPGfUeb5nr7UpiI1LH/18799pQXxok9sx9KK8VA+
         GhRkc6acbqZy7afkEJJ1//fqqwYgx1sw+jF//P92f76Vj+4jkQ39kWY90wZc+dUTaklU
         sbyA==
X-Forwarded-Encrypted: i=1; AJvYcCU62C7jJ579DA5FKFqWl8H56uwTHwdoULkikxyZAMJa9yGb/cKFmdc/DIFD5GUwkabNgoOZ3TUODxHZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx44mAYFsdvsAbgFUJBvnjjIg1sGAOStGFIaLpj6QfYMH0+NIiE
	yhZTsYFFWyB/8ZKVC9uGptpYAxZdR3AHWfvtZi6zcSLSeG5P0DOz5D9yhBkCLTQ=
X-Gm-Gg: ASbGncuL3AtdhdqxlAzAEKZpoN8C58hUbtOukJlxmmJaK7HGicThOGBlCMXxAkchHI2
	XNdcv2iwEMHC1LoA3Q0pCFuuXIiyFpkldZrLnTRC/kHkTsiPSyfqjIfMiBHRuAR3iWsbQ5WGmjE
	DAVC/BmOqbBCQagKC4HTChrKKt7OLSYI1SCjZKEXuH/8sLSZ7PXBvvbChqV7unK3sPwAGZj5jQY
	t6/QdkRpyDI6It7MgO5JcNcNF9+7Oyn/gO1Kf5ovSM+p1HDgA5nTNpdkCQtvZ7BIBnkLXydTVqY
	+P9rsUYvxmgsitJFyNqUruSCk4eUXtIwtHgGLQo2MmQ5JFywuPMEdB2iwFV6FwbSZ5gonwtELg=
	=
X-Google-Smtp-Source: AGHT+IFFKkIsNUNoiTwwsvCnG0Xbc68Ad9IQzTVMCnnPigzL5AQ+CvWJflgv+MLDJU2UCeqLYNwvWQ==
X-Received: by 2002:a05:620a:471e:b0:7b6:d8aa:7ef8 with SMTP id af79cd13be357-7bffcd8cdd2mr2315439585a.37.1738428840845;
        Sat, 01 Feb 2025 08:54:00 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90cbe0sm314316485a.102.2025.02.01.08.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 08:54:00 -0800 (PST)
Date: Sat, 1 Feb 2025 11:53:57 -0500
From: Gregory Price <gourry@gourry.net>
To: Honggyu Kim <honggyu.km@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, ying.huang@linux.alibaba.com,
	rafael@kernel.org, lenb@kernel.org, gregkh@linuxfoundation.org,
	akpm@linux-foundation.org, honggyu.kim@sk.com, rakie.kim@sk.com,
	dan.j.williams@intel.com, Jonathan.Cameron@huawei.com,
	dave.jiang@intel.com, horen.chuang@linux.dev, hannes@cmpxchg.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-mm@kvack.org, kernel-team@meta.com, kernel_team@skhynix.com,
	42.hyeyoo@gmail.com
Subject: Re: [PATCH v4] Weighted Interleave Auto-tuning
Message-ID: <Z55RpQgsma5wrpfh@gourry-fedora-PF4VCD3F>
References: <20250128222332.3835931-1-joshua.hahnjy@gmail.com>
 <41ab5a11-f8d3-403c-9d68-33eb15aef8fa@gmail.com>
 <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z55QmybX5IkuLv6Q@gourry-fedora-PF4VCD3F>

On Sat, Feb 01, 2025 at 11:49:31AM -0500, Gregory Price wrote:
> >   1. the auto mode set the weights as 10:5:1 for node{0-2}.
> >   2. node2 is offlined, then recalculation makes it as 2:1 for node{0,1}.

Point of clarification here:  a hot-unplug event won't cause
recalculation.

What actually causes re-weight is hot-plug reporting new capacity.

So in this scenario, the weight will remain the same for node2.

> >   3. the auto sysfs interface is set to 0 to make it manual mode.

