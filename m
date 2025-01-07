Return-Path: <linux-acpi+bounces-10425-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BEA04C15
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 23:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60147165BD9
	for <lists+linux-acpi@lfdr.de>; Tue,  7 Jan 2025 22:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C9E1A8411;
	Tue,  7 Jan 2025 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lFOYiXlE"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6076119E99A
	for <linux-acpi@vger.kernel.org>; Tue,  7 Jan 2025 22:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736288086; cv=none; b=PTbhheBBk3fnwQn4h2pQN9R4+dwqK8IQEXnUtxafohFaVFFpWO0xxmdGMarWh8ohnGkPiyTXm0h52/PGIIBDv304RDDbg9JAqW9hurtfpRXNAlKSKRvGHKo/o20X0JJrnb3vXMgNRPtJfDmvB15Ld9NOS2vJmBZyOk7a3iGFcXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736288086; c=relaxed/simple;
	bh=Q7gsPmAwcKW+iCD5IVNi31ZUXWQBjg1I4E0jayTr9Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hpdU82aiMNqyPWqcgdNIWaqcbHMKvp20Vd8oc4sHIMp7sZfWXebyKGLEUvLotLcJVO6p1+sUDd7/+90ICRf+QTeQ4JcFSkQ9nv6WzpkB/icWmhq0fRcvsXsk6qh6nj+lHp1itNAtw0jNPpDrWz//fS2H9JJZEzd2awoQLFQ4Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lFOYiXlE; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso20586065ad.3
        for <linux-acpi@vger.kernel.org>; Tue, 07 Jan 2025 14:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736288084; x=1736892884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RV+4e9KhhM+feBvIE88GxANGaUR7qFryxHJqEAou5R8=;
        b=lFOYiXlEDbzSieWXPm/49QCQUL0R+ksdaM+8gQl1rc8uKy6gjUakUiagavB+G3l9le
         /VzJC4ECyl2HpJacfH2ZzrtesaZBbdUSv9Dcqdcjg95TqECYwrxPcnvHDer1wVujXcyy
         b9cydzzwJvKwz6gyWhT4NhdwMKojwajedu0Q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736288084; x=1736892884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV+4e9KhhM+feBvIE88GxANGaUR7qFryxHJqEAou5R8=;
        b=CczELyuyAOZ2eJyY0ndwM87HxygZk5nsEyEIOShgggov6acg38YqaqKF3iRxCujvRG
         DIfCySFKJSZTIJl6WdwfKz3M0rvRS2NgJ8Z0H+RWVpAMjG+qdsTTONFOVf3LCfu9tu1t
         6s2eT5Cisdx7eXb5imrLz2s7ACkYCuHGodFokgKDz8UDofwoIldJoSf4qyOUy254HNDN
         5y16J3wloJTNLihgAE/WLmaxLaoD+Optra8VdAo3e71mKNGz+0PX9+zFN8TM2hF1mpM0
         UnFV73GcJ1PER422CR1T6RsoCW4kXCqE0taFKb3RLoWEq7Z12AveCT9QQ7jQSjJDnZIn
         sQOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbu6BNXkzjogqy42DKt2hM2BjSEZe75QNgwC4yil+45D9H8fwit6e2+I9D08ryE1DiBbRxiv30vSTx@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5sl8Ej05vbXY2+SEDysupQZ6R9OotWYFULH0H20FcHyKqWCx
	FgBxJv039hitL0xJiDfR+W/AsCVjDEdCDCrgLRlRdf+bJ8bEFislQKks85dP+Q==
X-Gm-Gg: ASbGncsXQBGow7JqJdnBHfAb4Us5cZGwe/3ANcNf+kP75CK+cx4v1JJA11MTgI5Fny2
	Nne0XiW09vxpq2D7BzqjOeCSmWNw7oYTYJtMXco81hLL5EKX0RX6I91BwOrba1is3bNJMHZJivv
	11UpSK4e3TaWsB1I5rKI28ebyYzR7S3ap+0bHnkTOLF295z4lREiPe7FLUCxrTw5kSH1+3eyH3p
	b3+6nYCfVZ2U4Vm/nQprj4DBQRrIA+TV58SeDt8V++y6IssAp8YhiOwORGV/dYAOcqXJkPSnfs2
	Tm9lZm/pYdZiuToJPVU=
X-Google-Smtp-Source: AGHT+IEkAisXGBz/e/a8gkUWJb8Iue3ft+92hn87eXDD4Dkl25YTjIs6OX+OKDfqwZwQcXi/uW2Pcg==
X-Received: by 2002:a05:6a00:ad4:b0:725:ebab:bb32 with SMTP id d2e1a72fcca58-72d2201be2amr783291b3a.26.1736288084620;
        Tue, 07 Jan 2025 14:14:44 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:183c:e247:20b9:87a9])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-72aad8fd7b0sm23040661b3a.139.2025.01.07.14.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 14:14:44 -0800 (PST)
Date: Tue, 7 Jan 2025 14:14:42 -0800
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, linux-kernel@vger.kernel.org,
	mika.westerberg@linux.intel.com, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v5] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <Z32nUpG3KzBOy-PH@google.com>
References: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126151711.v5.1.Id0a0e78ab0421b6bce51c4b0b87e6aebdfc69ec7@changeid>

Hi Bjorn,

On Tue, Nov 26, 2024 at 03:17:11PM -0800, Brian Norris wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> Unlike ACPI based platforms, there are no known issues with D3Hot for
> the PCI bridges in Device Tree based platforms. Past discussions (Link
> [1]) determined the restrictions around D3 should be relaxed for all
> Device Tree systems. So let's allow the PCI bridges to go to D3Hot
> during runtime.
> 
> To match devm_pci_alloc_host_bridge() -> devm_of_pci_bridge_init(), we
> look at the host bridge's parent when determining whether this is a
> Device Tree based platform. Not all bridges have their own node, but the
> parent (controller) should.
> 
> Link: https://lore.kernel.org/linux-pci/20240227225442.GA249898@bhelgaas/ [1]
> Link: https://lore.kernel.org/linux-pci/20240828210705.GA37859@bhelgaas/ [2]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> [Brian: look at host bridge's parent, not bridge node; rewrite
> description]
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> Based on prior work by Manivannan Sadhasivam that was part of a bigger
> series that stalled:
> 
> [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all Devicetree based platforms
> https://lore.kernel.org/linux-pci/20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org/
> 
> I'm resubmitting this single patch, since it's useful and seemingly had
> agreement. I massaged it a bit to relax some restrictions on how the
> Device Tree should look.
> 
> Changes in v5:
> - Pulled out of the larger series, as there were more controversial
>   changes in there, while this one had agreement (Link [2]).
> - Rewritten with a relaxed set of rules, because the above patch
>   required us to modify many device trees to add bridge nodes.

I'm wondering if you have any thoughts on this. Manivannan seemed happy
with this in his reply. I'd like to see this land in mainline, so I can
avoid the hacks that everyone seems to be picking up (such as adding
"pcie_port_pm=force" to their command lines).

(While I'm at it ... apologies for the poor versioning. The subject here
should probably be "v6", since I'm clearly quoting above that the prior
version from Manivannan was v5.)

Thanks,
Brian

