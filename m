Return-Path: <linux-acpi+bounces-7338-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0DE948E11
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 13:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381F01F25DE1
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A9F1C3F22;
	Tue,  6 Aug 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYAnI33n"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E6A1C379E
	for <linux-acpi@vger.kernel.org>; Tue,  6 Aug 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722944896; cv=none; b=pHS7reILjMA7vjd9QRVRbpM20Rniv9LKZlXv3EzUaKlVLXDcj14EMRNiLUUlmtePWwyl0YsQ5IKqmuZQ7QPEADi+Kn51l23FJFXx1ur20lWTs8m5+8VMtQvM2n0dsMClsbwe5fJhV4cbDu8Bt4h6EfHWtqmEqRmumDYXArTSr5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722944896; c=relaxed/simple;
	bh=KJ96BgkJZQbvnEnqdDFr5FIIureinTKxCE4K6X/Qgf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I7hyMPxysfvhOiZMvy2ABuGFEswfErNs/NPmOmuCTA6u5vOD9keneiOuVXUuSZXIh2vSqdmTE6dc0YpZKzITauHaqwYngqGC20LOxduCcz328h3lPX6BmFWbcvilgdL8U1rnVveoMtXKKiZz0iOP5sc0ove98wdwxu05UBTAtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYAnI33n; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-39834949e42so1591765ab.1
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2024 04:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722944894; x=1723549694; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YnKDLZastVXUhXCKZl6BxKY06diUTWNA7Rw0yyQiGS8=;
        b=QYAnI33nWuCXNFGLkdwzrwxE/ldAkeiSlt9GnomrS50hC3wgbGEj0L1Yb2SsY+Kv6G
         Cu4dNnqftfWfo4OQ7uMu2puh/2aJ8Ul7RVtwFOh4WqXXn8itUsvoPKOP9pmv5Ci0bgMy
         qQ9Tp4bvLJ9t2SzTTXGdTI+vKZVkIOq+e3Qw7SLqPUI+SCTS35P9xtgbLXyXBVBsnBer
         admISBSAESVom2xB+kW40f8A2F6CbcgIm0331aWUuGSKazzmzl+kDulopv5widVlHrzX
         larTb4YRrNtNywKcVgwTcJWSpqeoe0ZOP/5oqlc9Jqs3muKpC2I38Lf/HzjGNuPenvdH
         WsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722944894; x=1723549694;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YnKDLZastVXUhXCKZl6BxKY06diUTWNA7Rw0yyQiGS8=;
        b=A2whXwXFabFoy9RDJzJB7YugYZZiX2vV7k4sRKcyyxD4MoHWwjIazYHtDXUkhp/hMH
         eAK0vN0r2hFGfy+WDJgibddxUWe8IGr5xMq/rcYjRQiqJy1L9AB2UGVLKmu/Dwi/TsX3
         tMzGI0tvnLuQGmqa3sG2KB9R2pK0e01TWRFSx2v7KqK1sdHyZ6B2nCsQFC4sThRK8+uV
         nNuGPE8IbXJewsa9WNUcqME66/LJ1IcxdZ/PIv7JdyZ23pMBX9Wmob/k75dMn1tdGByS
         WMn+rIOxxGckTnNuYvKAVydMabOCBgU/9RSF42eZxC52hlQzRE6l4f/McVXWKpro2Z66
         RDnA==
X-Forwarded-Encrypted: i=1; AJvYcCV4I1z20VEi93dE20vTOTjSRPVyRMDBqE+xyIpR1M+4MeYTtMidGVS9S6unE1H/TkWwkb6+mYYNlKYx/yeT0CoHpP8O5t963Xk7Fw==
X-Gm-Message-State: AOJu0YwYOc/IWtbLFBteCqr0epDSus1PRO5vzl/1YaGeE6Fb8pFjp475
	cZ/0U/YsFC53FVHtYP+l7C7GGP1J3Z7FfOruFlMLOZSkeo25x4FWBxlNNrirVw==
X-Google-Smtp-Source: AGHT+IHDx5ouRyGybYmKI+rGA3bANIvnR3BlipR1pbrh2anF4Gl61iD5cVGF8vIXPCnZL8KlLVtx2g==
X-Received: by 2002:a05:6e02:54a:b0:39b:35c3:d5b8 with SMTP id e9e14a558f8ab-39b35c3d5e0mr100545275ab.22.1722944893872;
        Tue, 06 Aug 2024 04:48:13 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763b342e3sm5792785a12.56.2024.08.06.04.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 04:48:13 -0700 (PDT)
Date: Tue, 6 Aug 2024 17:18:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 1/4] PCI/portdrv: Make use of pci_dev::bridge_d3 for
 checking the D3 possibility
Message-ID: <20240806114808.GA2968@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-1-2426dd9e8e27@linaro.org>
 <Zqyro5mW-1kpFGQd@wunner.de>
 <CAJZ5v0hw7C2dHC3yXAwya-KAjzYxU+QgavO_MkR9Rscsm_YHvg@mail.gmail.com>
 <Zq08i2i_ETHsJiKW@wunner.de>
 <20240805132442.GA7274@thinkpad>
 <ZrHG2KnGp9N00mV_@wunner.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrHG2KnGp9N00mV_@wunner.de>

On Tue, Aug 06, 2024 at 08:46:48AM +0200, Lukas Wunner wrote:
> On Mon, Aug 05, 2024 at 06:54:42PM +0530, Manivannan Sadhasivam wrote:
> > So what is wrong in using pci_dev::bridge_d3?
> 
> The bridge_d3 flag may change at runtime, e.g. when writing to the
> d3cold_allowed attribute in sysfs.
> 
> If e.g. bridge_d3 is set when pcie_portdrv_probe() runs but no longer
> set when pcie_portdrv_remove() runs, there would be a runtime PM ref
> imbalance.  (Ref would be dropped on probe, but not reacquired on remove.)
> 

Ah, so it is the other way around. Thanks for clearing it up!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

