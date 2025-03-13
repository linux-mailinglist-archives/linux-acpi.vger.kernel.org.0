Return-Path: <linux-acpi+bounces-12218-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B390A5FBC4
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 17:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 082A21897B63
	for <lists+linux-acpi@lfdr.de>; Thu, 13 Mar 2025 16:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AFC1487F4;
	Thu, 13 Mar 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BdSHNCwS"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0233813AA27
	for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 16:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741883424; cv=none; b=triMOzUNDiF/71i6dD7vt21PoD1Yt/a0KkSbbvbw8E6owy/ADO0nSGyaRvRlKlBlj9X8va1bx4X5MXi3SfJKHL9vgMkjiOMSzXi4Dwf6NvQjtM6/Jau4q4luULIxoslIli6Con4fBDxqTqwkfztzgIyLL1+emqLwjrzdrgVPNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741883424; c=relaxed/simple;
	bh=4hhdqF3Rp1vH31nmCsGM4U9PNPxQFzWtChioTmpUmgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u4azSGd9qlx1MKjlyaCfcnTpvuBUi4Ois4eaefwJ2sVUc/z28BuVyw9TMJNTJqc4IMbzz7vxAANxFl1WcPanfKyCEL84y4jCvTE7WsxDmIxUfovlTZQO+tHlkBz2VYKFiSA4E8SilNyzLXvpSc7M0UgtYeOecnv8FjsHqoGMuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BdSHNCwS; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5499ba72f0fso114482e87.3
        for <linux-acpi@vger.kernel.org>; Thu, 13 Mar 2025 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741883420; x=1742488220; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=BdSHNCwSAeeL5Y3xTG/X+vUoIFihijZZoWuYcRRMTHFIRnsBz4De3p6QtmdcHbrb3Y
         16F1R4C+ZCbk4YBFzW3fXK0CV5BR5BpPaUfnTf615Lflxjhcup3I9ZQqhc+TCDRxbGEq
         RtVJnuC3ZKo4tDm5GL76ZfoPvN4MJrn3WVaujV50V5L9sfjEfFKirOx1AZ86PJqDFT/v
         /PsMoNS+jNceKIuS4QmqRoFqYYNSDhw0Vf8NTF6ypP6ZtP3DQuJK7d4YrFMJz11EBsXl
         mzP81WvgtvLLUYJxKUX6Oyk5o/nXoo9wksUJaImn7aG3/KZmRKly2eCYKXfnWpAW92KG
         3V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741883420; x=1742488220;
        h=content-transfer-encoding:content-language:user-agent:mime-version
         :list-unsubscribe:list-subscribe:list-id:precedence:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aFrAK725pGLGAzrUp2Rsi/GlBUn5vFqjGk9jd1UKZys=;
        b=lx4TwI1ult6zKZpCyNoTjFG/j4apK6bGC/VKsP2Twz3oaNqhD9Xb36fieCxuD2oNyg
         q2TUPFPrLCGSjw66quIiyblRZsvsCWIniuTB/CmloKvWSJDfUaVKMcOEbSoBw1NXclfV
         Df6MKTcWtUlr1aB+JjdtLhvPtDBrNmjJegziDNn0IPTstCPuXyI6DD59N2BWOiPNw1vq
         yK+BBCZ0yan9QiE3X7RMcerQhm8e6N8cLDS79z3l9eepEFTOgK5mcB1H7SUj+fq6UUhX
         0tiCa+u+UtngX3YhEN+5mtu8kE2QUGHyENKmhH8aiVDnFG7/gxNP0JPhjUaE3b5OJuMI
         mIQw==
X-Forwarded-Encrypted: i=1; AJvYcCUGPCvROkk50W3By90eCuhtQbq6rtcgJpRZq+Cawhmgku3zgCaTEDZdlYbj1Fkj6HBs91gnoFAQid7W@vger.kernel.org
X-Gm-Message-State: AOJu0YwK4hiwuK4BfgbcaVmyA0gOs3uXlW9mx4onDCcQinFdfaMsPpRm
	0dke6pXJ2jsdXaLGAm5kFszZWA0YwVm6ztkx94DPMj10/otRwGAGAAHcu6Rw48k=
X-Gm-Gg: ASbGncu8xnCmO+Wb/d8a7oMSmZjGn3vq/40rbc2+DbE0BkGfg9m+GZ2psHGPfTfVq2V
	yOG9qkx0TaMTow1WZ9JqT6UYeuW0mCy85IEdSpejB1n7QeqMYI2J5xZ8O3Q3cvhdIn8kUj3TRvt
	9D1cNeMXk0IxoBo6PT1NIAu9hFn7cPwEmr9jim1aXesD+1bt7hQrATPKmgQMKTZEgwOAxYJehdJ
	2+JtBY+4QzfpYdabrvS0O9/MdCjn70gE6kO4QPmmGahSCnm+zkOSUrqMups/7Ynz7dvtyf1yKvO
	t045FO0hT7KlHxQG7cJQOc5YBEcMtzvwNstHOgpMeDwBXk2w4FOFR0MEIkszxIxGRQ9qzMBivzC
	Oc6fLLeATCc3hun92nQ==
X-Google-Smtp-Source: AGHT+IGtn9WumNOaMuo9cAzRTdloUKB5tTLRLe9/61uA56u97uNJuHXYLD/mRuofS9RqJFSJqixgYg==
X-Received: by 2002:a05:6512:b0a:b0:549:8f39:3e63 with SMTP id 2adb3069b0e04-549abaea8b6mr1524832e87.9.1741883419995;
        Thu, 13 Mar 2025 09:30:19 -0700 (PDT)
Received: from localhost (c-85-229-14-155.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with UTF8SMTPSA id 2adb3069b0e04-549ba8851e1sm256528e87.201.2025.03.13.09.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 09:30:18 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: robin.murphy@arm.com,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Stuart Yoder <stuyoder@gmail.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	Nipun Gupta <nipun.gupta@amd.com>,
	Nikhil Agarwal <nikhil.agarwal@amd.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	quic_charante@quicinc.com,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
Date: Thu, 13 Mar 2025 17:30:11 +0100
Message-ID: <417d6f59-0d78-4e81-ad0b-e06846f786b0@arm.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com> <CGME20250313095633eucas1p29cb55f2504b4bcf67c16b3bd3fa9b8cd@eucas1p2.samsung.com> <9b358d68-332e-404e-9a75-740297f7b28d@samsung.com>
Received: from foss.arm.com (foss.arm.com [217.140.110.172]) by smtp.subspace.kernel.org (Postfix) with ESMTP id 65FBD1EE7A7 for <iommu@lists.linux.dev>; Thu, 13 Mar 2025 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14]) by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21D5E1516; Thu, 13 Mar 2025 04:01:50 -0700 (PDT)
Received: from [10.57.40.246] (unknown [10.57.40.246]) by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C60353F673; Thu, 13 Mar 2025 04:01:35 -0700 (PDT)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

From: Robin Murphy <robin.murphy@arm.com>

> On 2025-03-13 9:56 am, Marek Szyprowski wrote:
> [...]
> > This patch landed in yesterday's linux-next as commit bcb81ac6ae3c
> > ("iommu: Get DT/ACPI parsing into the proper probe path"). In my tests I
> > found it breaks booting of ARM64 RK3568-based Odroid-M1 board
> > (arch/arm64/boot/dts/rockchip/rk3568-odroid-m1.dts). Here is the
> > relevant kernel log:
> 
> ...and the bug-flushing-out begins!
> 
> > Unable to handle kernel NULL pointer dereference at virtual address
> > 00000000000003e8
> > Mem abort info:
> >     ESR = 0x0000000096000004
> >     EC = 0x25: DABT (current EL), IL = 32 bits
> >     SET = 0, FnV = 0
> >     EA = 0, S1PTW = 0
> >     FSC = 0x04: level 0 translation fault
> > Data abort info:
> >     ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
> >     CM = 0, WnR = 0, TnD = 0, TagAccess = 0
> >     GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
> > [00000000000003e8] user address but active_mm is swapper
> > Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 3 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.14.0-rc3+ #15533
> > Hardware name: Hardkernel ODROID-M1 (DT)
> > pstate: 00400009 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> > pc : devm_kmalloc+0x2c/0x114
> > lr : rk_iommu_of_xlate+0x30/0x90
> > ...
> > Call trace:
> >    devm_kmalloc+0x2c/0x114 (P)
> >    rk_iommu_of_xlate+0x30/0x90
> 
> Yeah, looks like this is doing something a bit questionable which can't
> work properly. TBH the whole dma_dev thing could probably be cleaned up
> now that we have proper instances, but for now does this work?
> 
> (annoyingly none of my Rockchip boards are set up for testing right now, 
> but I might have time to dig one out later)
> 
> Thanks,
> Robin.
> 
> ----->8-----
> 
> Subject: [PATCH] iommu/rockchip: Allocate per-device data sensibly
> 
> Now that DT-based probing is finally happening in the right order again,
> it reveals an issue in Rockchip's of_xlate, which can now be called
> during registration, but is using the global dma_dev which is only
> assigned later. However, this makes little sense when we're already
> looking up the correct IOMMU device, who should logically be the owner
> of the devm allocation anyway.
> 
> Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe 
> path")
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This patch fixed the boot on rockpi4.
Applied it ontop of next-20250313

Tested-by: Anders Roxell <anders.roxell@linaro.org>

Cheers,
Anders

