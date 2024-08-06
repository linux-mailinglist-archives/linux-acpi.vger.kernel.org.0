Return-Path: <linux-acpi+bounces-7339-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCCB948F62
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 14:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 193511F2124F
	for <lists+linux-acpi@lfdr.de>; Tue,  6 Aug 2024 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35A21C4616;
	Tue,  6 Aug 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSgdo8xj"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC061DDE9
	for <linux-acpi@vger.kernel.org>; Tue,  6 Aug 2024 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722948075; cv=none; b=uDLf1cP6G1XE/rnkeLOnUZmMEdEkFWKvqnj7S6E4DX828ybF+e8PGjcdceUc5t1NNTajSvRQxQcTXC0wpVwmtJ5h2szx9kstP1yiK9CkHIuHlZgUlQSqFbjLd5IQJTzZMAm6xKAQgprAIKZNBgVswh5ZWu/Wt5EacpWC4n6HKQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722948075; c=relaxed/simple;
	bh=/PSyPU+sjxYnvFTtQAn0dQ1UDz+wT7qcDxGZFNmLtrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd4ghyBLyODR29DAWMNjIrlmIp0SkkTX4RatS6bmJJEQ/XypJpNsY1858bCRVgKcb9T11Pva6qHMMn/ayB+E5tqkydC/9/ictbgV1+diMu3EZJN8AupZtFeQcah7FE2pSsws/zF9+Gw6uOS0bsZ6p9CkBHzLjdk/5tYwzdTu5QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SSgdo8xj; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc569440e1so6387475ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 06 Aug 2024 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722948073; x=1723552873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVpEw07jfarO8EM/3LJ96WQ6UxVaQr8DD1O4wcj9h/Q=;
        b=SSgdo8xjLxyIAgFqSUgK6Kdf48H2lXTmWJXy+R/7cFVjho4fRmWFyRnxPLBKVLjuRb
         cI28YnvojXprPvxZBS2Jn4H9PdgB0Jga2FIATRozHxUvPFb5cXfurX2JpgebGeVICDLY
         oHkZw667r/KKVttCMlsUc1ij9uC6Q2V1WrppdKu+W/rgxaf4HDZvGRN59h4rtPk65BAT
         hQ5rcDd5ULmUFQUt5SVgqImP7Umx2O8j3ibYcZr5AJ6uV5eVlZUMmfvoCgKfwI+UpnrT
         QyIckKdTaCXeJalnM58v6RAZGIfs8m6gDQdvwwocnrm6o3X69ij0b8KRGIpIBYzLHsTo
         Fd9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722948073; x=1723552873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVpEw07jfarO8EM/3LJ96WQ6UxVaQr8DD1O4wcj9h/Q=;
        b=a5AARmRWBj9qQdoZCOypMAbLDskD7A7fVVE33glxjodaHln2Z3F0aSkNGTKD89fTOc
         Kd4YvPD1nTPGZIQaT48yASq5VkEYaOSb5luX00/WkHzxmRp4hvsR0hU+E12T7rjg7zKW
         fGLLVjqSko1XiC78CdriY+YKtWTDWHjez7J5gD3xvjpDanBouH/huvPGRDhO8zIt0LDs
         Y0U3bNaoMlKhi1rImTp9p0xHd5x6DDajszI1r+AsTrZk/GkkXYmCajOyNsuFI63IZgxe
         PvtIklHagSHSI74KnKeqQdTGxfVEZvsZR6B1S9qm61gHHYSJvx6ANFn1IWuExvA6iHhH
         L2Fw==
X-Forwarded-Encrypted: i=1; AJvYcCUaAz+ldWBFIMznPYDwEuzSkDJF3PiqtKi7CxTJgBtXdGYFr7cQJJP1WK+m9rImy/9lnWIiXLErprhGgzw6Yyd6+3JTQlqnNfWo2g==
X-Gm-Message-State: AOJu0YyEt1FjHg/0tTVh/a+Q7gv8STXe8EJHclCrEsWAoRN89Nna7Y0V
	F5ti3WRKVzVvvN8y8kKtSe6i6KXC1k+LlP2oewLXLO7QOqgtTBauv2YfTSzqyg==
X-Google-Smtp-Source: AGHT+IFHB9bUhT160f38WZeHXI1PMJWR/79pLH/7+rB0SJdnhHS8nIU4R/ZG7aRt7CXjRPAKKiG2tg==
X-Received: by 2002:a17:902:ec91:b0:1fd:8e8b:b2d1 with SMTP id d9443c01a7336-1ff572c5565mr137947335ad.33.1722948073313;
        Tue, 06 Aug 2024 05:41:13 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5929457dsm86501905ad.249.2024.08.06.05.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:41:12 -0700 (PDT)
Date: Tue, 6 Aug 2024 18:11:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20240806124107.GB2968@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
 <ZrHITXLkKrDbQKQp@wunner.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrHITXLkKrDbQKQp@wunner.de>

On Tue, Aug 06, 2024 at 08:53:01AM +0200, Lukas Wunner wrote:
> On Mon, Aug 05, 2024 at 07:05:55PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Aug 02, 2024 at 12:13:31PM +0200, Lukas Wunner wrote:
> > > The PCI core cannot put devices into D3cold without help from the
> > > platform.  Checking whether D3cold is possible (or allowed or
> > > whatever) thus requires asking platform support code via
> > > platform_pci_power_manageable(), platform_pci_choose_state() etc.
> > > 
> > > I think patch [3/4] is a little confusing because it creates
> > > infrastructure to decide whether D3cold is supported (allowed?)
> > > but we already have that in the platform_pci_*() functions.
> > > So I'm not sure if patch [3/4] adds value.  I think generally
> > > speaking if D3hot isn't possible (allowed?), D3cold is assumed
> > > to not be possible either.
> > 
> > Why? D3Hot is useful for runtime PM and if the platform doesn't want to do
> > runtime PM, it can always skip D3Hot (not ideal though).
> 
> AFAICS we always program the device to go to D3hot and the platform
> then cuts power, thereby putting it into D3cold.  So D3hot is never
> skipped.  See __pci_set_power_state():
> 
> 	if (state == PCI_D3cold) {
> 		/*
> 		 * To put the device in D3cold, put it into D3hot in the native
> 		 * way, then put it into D3cold using platform ops.
> 		 */
> 		error = pci_set_low_power_state(dev, PCI_D3hot, locked);
> 
> 		if (pci_platform_power_transition(dev, PCI_D3cold))
> 			return error;
> 

This is applicable only to pci_set_power_state(), but AFAIK PCIe spec doesn't
mandate switching to D3Hot for entering D3Cold. So the PCIe host controller
drivers (especically non-ACPI platforms) may just send PME_Turn_Off followed by
removing the slot power (which again is not controlled by pci_set_power_state())
as there are no non-ACPI related hooks as of now.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

