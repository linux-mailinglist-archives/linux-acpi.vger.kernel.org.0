Return-Path: <linux-acpi+bounces-7672-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0032956ED5
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 17:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78C74281391
	for <lists+linux-acpi@lfdr.de>; Mon, 19 Aug 2024 15:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E456460DCF;
	Mon, 19 Aug 2024 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3Cl6uxt"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BA24EB38
	for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 15:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724081654; cv=none; b=Rg/EclbsYrYRm864DHF28R8Fr4tDv2CmR6ED9KrTQWkDmImsTntkyU4Ykn87LY5woWe5ox994VYmwhI5M/CGW4RKTimlMWcCyuXT14hjuOjlRwZ8FeRkTbqT78SF8QhYo0ELe+ke8Q5Eqgju37GZ6W0+GuN0uHj3wTzqHDv7o9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724081654; c=relaxed/simple;
	bh=gerX1e1SAyEGGpWbACuDeKTJftuR915APXEAPgfRDW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIAGiCWx8EGxR7iUdI1Wqji3yHjBww4SWvtfduvquky1TlhseyT+/FdTvTSjhhBKPTOg0ih7wOjJOyAFYppF/sRhUaZbaG+9rpcLLYcOMDInyl+yufmGMH0ifCiWI2792XO6XIY4MjBC2g1JyC1e9nPJkfvXbc5gp3pTcaTtkjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3Cl6uxt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20230059241so8934785ad.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 08:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724081653; x=1724686453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fWHd8Dubab2kk28unZJz+ySGMDUvatysZhSqj4nkW08=;
        b=t3Cl6uxtfv7HC/ie0dbfni1fL+5rQOEFfX4wEpGVEcUFh63lbT6ZVrIhzmeLhlzhnr
         IR5U5Gr+B3sQuW6it/rgu/ZOKVRBDcBkQXVuE/ouHCgXspgkfuRnQKkrUeua4xV/Wh+U
         heMTMOFmuE4Ry/TS6RniDK52QLZcyGedcZQ81FPmG+DL2r2T5nK9rIckX20e9k6lxeVC
         1ece6FfUPdbAlaiJ46bPzX8+MDfOIJRPjHQohvkiyZ8ngt/ew4rEyJbslZHeslWHrTxo
         yyn/4mwtSELn2K18YiRJCihLHDGdGfO4tqO0fQrAxVhK+7y0vGZpQzT97jxtkENgkBft
         Huvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724081653; x=1724686453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fWHd8Dubab2kk28unZJz+ySGMDUvatysZhSqj4nkW08=;
        b=f3ya5JS1Pp1yVwyunFZ3o+Ky4WZV25OcLBwtiaLp51HEHSaPfsyj+YeahX5DgcT2JM
         QMcoOKwV/Qkhztao4nHA3/vNhYYEl6buAI65etlNnYseJ+HoEy8IU96I3NWMJImdrVco
         +iymV6PJazG+ms2aFgifLxiYDXjdYiQvySdGNZWt/tSV4GugFmIgOHUmcO/YFGNnfGG/
         TVEBYl1mI3arEepn4T84r7zmXbp303so5MliHAnL8936+CCzDH3Yrd/41x0baGKx5vAP
         qnRG5RiqImX1kw4GmaBSpmdMcn6el8yOAV0cQhzRXeVl2gXlNo7nOOLAsw0Z0PL0zhH7
         S/Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUiJFjJKPaZsaxXbb8eNFZPbPSJZCmO5aJOVokxsfVvbvxPv7XcmQToj1TGI0+DMGdxIrIqjHU/qnyL0h1dO1vGwH8FApfhSOqA2w==
X-Gm-Message-State: AOJu0Yw4FNBw2XE4zoiIMGpDCqORvVI1B2M5zruiBjJPHS+Ik3dInZlM
	cqoogfQj+crdLywHrOfu7iVZFp4s2NfRHZTUCzY9DHuER9PJ0AAohYX1LFIZbQ==
X-Google-Smtp-Source: AGHT+IFkgzCoKEl2Yj644WJFA2at4eKalzRkVxpP0Hu+EOkVJUnnpmXN5q12HO6kOgQzGQcui6MKdg==
X-Received: by 2002:a17:903:1210:b0:201:fe7d:babe with SMTP id d9443c01a7336-20203ed44b5mr130244915ad.35.1724081652535;
        Mon, 19 Aug 2024 08:34:12 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa51bsm63669295ad.53.2024.08.19.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:34:11 -0700 (PDT)
Date: Mon, 19 Aug 2024 21:04:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20240819153402.pgykwcmtwgg257m7@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
 <20240805133555.GC7274@thinkpad>
 <ZrHITXLkKrDbQKQp@wunner.de>
 <20240806124107.GB2968@thinkpad>
 <ZrIe70Z7uFven8HH@wunner.de>
 <20240806143918.GC2968@thinkpad>
 <ZrKFl-dvNSNCWd8e@wunner.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZrKFl-dvNSNCWd8e@wunner.de>

On Tue, Aug 06, 2024 at 10:20:39PM +0200, Lukas Wunner wrote:
> On Tue, Aug 06, 2024 at 08:09:18PM +0530, Manivannan Sadhasivam wrote:
> > Regarding your comment on patch 3/4, we already have the sysfs attribute
> > to control whether the device can be put into D3Cold or not and that is
> > directly coming from userspace. So there is no guarantee to assume that
> > D3Hot support is considered.
> 
> If a device is not allowed to be suspended to D3cold, it will only be
> suspended to D3hot.
> 
> If a port is put into anything deeper than D0, its secondary bus is
> no longer in B0 (PCI-PM r1.2 table 6-1) and children are inaccessible,
> so they're "effectively" in D3cold.  Hence if a device cannot be
> suspended to D3cold, it will block all parent bridges from being
> suspended.  That's what the logic in pci_bridge_d3_update() and
> pci_dev_check_d3cold() is doing.
> 

Agree.

But patch 3/4 is mostly based on the suggestion from Bjorn [1] for earlier
revision. He specifically mentioned that the platform_pci_bridge_d3() function
doesn't differentiate between D3Hot and D3Cold and that's why I splitted them:

"These are two vastly different scenarios, and I would really like to
untangle them so they aren't conflated.  I see that you're extending
platform_pci_bridge_d3(), which apparently has that conflation baked
into it already, but my personal experience is that this is really
hard to maintain."

I agree with your point that if D3Hot is not possible, then D3Cold is also not
possible as per the PCI PM reference you quoted. But here, D3Hot is possible,
but D3Cold is not. And platform_pci_power_manageable(),
platform_pci_choose_state() are already returning false for DT platforms.

So if 'true' is returned from platform_pci_bridge_d3(), then it implies that
D3Cold is also supported, but it doesn't on DT platforms. So a split seems to be
necessary IMO.

- Mani

[1] https://lore.kernel.org/linux-pci/20240221182000.GA1533634@bhelgaas/

> The d3cold_allowed attribute in sysfs is just one of several reasons
> why a device may not go to D3cold (see pci_dev_check_d3cold() for
> details).
> 
> The d3cold_allowed attribute was originally intended to disable D3cold
> on devices where it was known to not work.  Nowadays this should all
> be handled automatically, which is why we've discussed moving the
> attribute to debugfs:
> 
> https://lore.kernel.org/all/20230918132424.GA11357@wunner.de/
> https://lore.kernel.org/all/20231002181025.82746-1-mario.limonciello@amd.com/
> 
> Thanks,
> 
> Lukas

-- 
மணிவண்ணன் சதாசிவம்

