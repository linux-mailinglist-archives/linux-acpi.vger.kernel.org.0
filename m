Return-Path: <linux-acpi+bounces-4345-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4025587C7C5
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 03:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0086282AA0
	for <lists+linux-acpi@lfdr.de>; Fri, 15 Mar 2024 02:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6C38F6D;
	Fri, 15 Mar 2024 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b="R/EVY4VR"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DCD266
	for <linux-acpi@vger.kernel.org>; Fri, 15 Mar 2024 02:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710471590; cv=none; b=j376wKU3zw11NuR20PIHIBllcfy7kZBYXLu8O051mS/zP+r1l8Tx5SunSvYWeQGVcgT8+nqyTpngZyxcOVKiJcBsozsKE1v1sLWdtyXxpFdIcxtZRYiCVL86aTdmwzDnj4iZzXMfglwi7nAxA4AzrhSw8VDKL90QYk9zXJxGSK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710471590; c=relaxed/simple;
	bh=Gi6bYkUhl40PWspGJBH44VCyXQYToNIWB6h8WhyMJBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BLuhY/hCfAh5cey51WhBkEUyWer1eBfaXvQvRGUbLpgivU2XzyRSUeipvw0JordSPyn1pScmPaXEPva7ZsTh0WLgUrvfMEncvQMCCOqdaejWvsjdJA3AGJpxUNQfZtOsh94+YmqtaldNRyazAA662H1c6XMhHrim3frsia6x0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com; spf=none smtp.mailfrom=pdp7.com; dkim=pass (2048-bit key) header.d=pdp7-com.20230601.gappssmtp.com header.i=@pdp7-com.20230601.gappssmtp.com header.b=R/EVY4VR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pdp7.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pdp7.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1dd9b6098aeso11811795ad.0
        for <linux-acpi@vger.kernel.org>; Thu, 14 Mar 2024 19:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20230601.gappssmtp.com; s=20230601; t=1710471589; x=1711076389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DF3u6fUKhDyXy3K2gFHmZ27anukGMBI1JFmpHSdBQdY=;
        b=R/EVY4VRFul6Eut1Bifc+7CmzHFnJppkp34RnIOoiS3P/dRoY2y/0I9C0BDA4sVpVj
         HVNOHL6meawiwM6tVp02Via/+JqD7LQyZ0kqaYMDDpBjrCloV+f8T9Y0Y9QPqMXIcYUR
         3t9Erp3Ijc5ZeYtiwwupcZPbknL3JiZY4mTVS1/5jUEf9+Pmtgpnh2g7nVKuoUoE/ILp
         SDP/iv6BcIRvzuz7iDSTQCVq5Decko86e+RbJgOuBYHPddzVMciMMcmSqCCSDie+0V+u
         asbx69iBKUWHLZg0vYMRXxeoqAkY3PScndkVX7VyOERZ9nWDuuk2cUdgoF6g2FRWT4R9
         rWCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710471589; x=1711076389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DF3u6fUKhDyXy3K2gFHmZ27anukGMBI1JFmpHSdBQdY=;
        b=Dvi35LcjrF9ztDuJa/az0tqSIUBWtWm6uhCDM0Qy7v2ko99DT1xwwie4AvW36a/s68
         /s6RZ64hEjam8r49/RccvEtqjoaHGY000cTVaQihJxDdzvQ+Q94kvLS9wBAKySZPU990
         6Cz484Eb3bnwYa2MFqLNQkd19dUR1HbPaVTFNvdUZZcsZ3g91vNAL17dZ5Nj4yMFaSvQ
         tcRybA8mBJRxlSJ3T5qRv0VvWl73OxySjmpVEwGqEqTK4Y3z/ytmDJPWGB8rkHNmBb7M
         6TnigebfJoRtTUzQQUiKXiU4R4qUgvOWUU5m7576fATJkImwCaXWPjM6HjIsUmgM9wmf
         4BGA==
X-Forwarded-Encrypted: i=1; AJvYcCWJc+iJrEBAsRQkDkHYgGnjqvH5gk2UeLXcislY3k6LAOQdCen1fgGCXMyi6814odwBofC7PbhNYvc8ax18ooJJ1XqNrhZNwPShkQ==
X-Gm-Message-State: AOJu0YyFzpndieArYuZOhIAq2KgkhsxHamam4MmwaH8BCXwTjoVCHkjh
	YlLUcLBDxUngifbrWzqxlN76WUwUQ7Bt+BDXFctn/2QKyA1cc3KU91Y0kK3P78Q=
X-Google-Smtp-Source: AGHT+IFCcd+8CehiYUMhG/6taZofm4Zmag/eB0icU74TL0kdsU7vlKVvJ1lw2qGnNTk4BdQ6IicmvA==
X-Received: by 2002:a17:902:cecf:b0:1dd:d412:906c with SMTP id d15-20020a170902cecf00b001ddd412906cmr4971466plg.12.1710471588778;
        Thu, 14 Mar 2024 19:59:48 -0700 (PDT)
Received: from x1 ([2601:1c2:1800:a790:ff9e:11a8:fac0:d063])
        by smtp.gmail.com with ESMTPSA id cp5-20020a170902e78500b001def18c0cfdsm112750plb.300.2024.03.14.19.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 19:59:48 -0700 (PDT)
Date: Thu, 14 Mar 2024 19:59:46 -0700
From: Drew Fustini <drew@pdp7.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: linux-pm@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Len Brown <lenb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Atish Kumar Patra <atishp@rivosinc.com>
Subject: Re: [PATCH v3 -next 0/3] RISC-V: ACPI: Add LPI support
Message-ID: <ZfO5oiVSVSmlP8eL@x1>
References: <20240118062930.245937-1-sunilvl@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118062930.245937-1-sunilvl@ventanamicro.com>

On Thu, Jan 18, 2024 at 11:59:27AM +0530, Sunil V L wrote:
> This series adds support for Low Power Idle (LPI) on ACPI based
> platforms. 
> 
> LPI is described in the ACPI spec [1]. RISC-V FFH spec required to
> enable this is available at [2].

I'm interested in trying out this series. Might you be able to provide
some guidance on how to setup a test environment?

Are there specific branches of qemu and edk2 that I should use?

thanks,
drew

