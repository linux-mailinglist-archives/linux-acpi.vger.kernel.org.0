Return-Path: <linux-acpi+bounces-7698-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC19A957D35
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 08:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC5A1C23F7E
	for <lists+linux-acpi@lfdr.de>; Tue, 20 Aug 2024 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62ACA14A4DC;
	Tue, 20 Aug 2024 06:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SVubNwED"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EB161FDF
	for <linux-acpi@vger.kernel.org>; Tue, 20 Aug 2024 06:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724133627; cv=none; b=aoC1vP4CQjdjcC15dRxzAShB8bbgetPAei/L1Wv8OlsAewO5hQuWfCWl4tn+jwImTGSO606FJa2n5pxMjosGGvYvBsYUSoS8kfigCmZEri/1IZbUMsHjSBAPFuX+49t/EBPQpFZaIeYj0e/GAI7y6wdMF4hvnGh3p5+mYutFmds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724133627; c=relaxed/simple;
	bh=sF3PRRiLeL/D5znM6gXQZ3NeF2qGdjIeuDfpPWTothE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B9rgkepD21Xfx+Z9n7N9DIAP38d76TwhIKSHTNFpdbDQMGLWBe8SbAGRU5Hm2Z51Tdl+cz0UrO4prhTieo3TP0zK6QKjQY1UPnQ3Ukl4QUw6cheFBqFmuhAKY4SoP+WqnExqf6tACzbKclhTZZs/g1j7dy63+QwSGHFOXOAi16U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SVubNwED; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7140ff4b1e9so93208b3a.3
        for <linux-acpi@vger.kernel.org>; Mon, 19 Aug 2024 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724133624; x=1724738424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=SVubNwED69a/mXs1SjT0rjRq1WPUZ0detoMNm4mzDGId+IuW7LsyU2+8mJDHN+9UlA
         +Nx/n7yOYkzbra1aXxdICCB7VeAhcGjs4eiffZ4DMFoY5PfvTxmrwZdxjZJ2ZAOjBDuy
         1xH7H1ATRN1fS8wAPKD8+wPkj6bCyDkmaqGGsazK0s24NwHvvFMlSKBCq8FnYAW36SxP
         7WBW996b0+s+utBRglB49u7IN5L2eTAwYreXxnKJKKlWS/d6byeBo0Gh4vWdQoTwlUcu
         c0Bvmlkv/mSLa7IhS1JwoGUC55GNXa9dbnpoicKz2LFo2vBJ7npsHBTHpi4osoRh5njv
         xO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724133624; x=1724738424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lgLMdruNV2huc5fRfMZfd6Ggx0Cp1DwK5971y3VUjeQ=;
        b=i+vJgIEjMNNuNh65v8TQ/Tfxz68rGaYwaAtChZBRDQWukss5Rao5fPGJ1gGU8v3Zi5
         aPPDvf5lD0q3t+AnUspJf4w725Mzu4elpxkScIlAPcUINI0EcNiOOFjpJc7yvV5Ua7AL
         Kg6SIhrCVQvT2xzNKfMRXJ84fvwJLfH7Qh5fIzkF2XubYamgawncHhmuWrFEMRiJn7X0
         VVT21mcQHB2hDIdPreEOen2cJPip6o0ImHXVLjtgyqyxoqZ0Qf/1YPKaEZvQcbQ3jwad
         hjfk9NNIl+JBBjDWx6DrOD8SzomVMJz6AB6DYdcUNIYesVIlp6xMNBwNBEX9Ulhzi4Au
         oQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCVA9GCz14Y6HGlNCXJCALB9yW7kzzSVqfhaTBgabe2lqh/x+sT5x6n7x9bl/9MLQ0y0ijsLQ3OpiJztOFgfZrXC91SpuuGq74VUJQ==
X-Gm-Message-State: AOJu0YxaLBbQoBArE/ufy67PA4KXjQK9gz5VC+DKszR/dU30CONIVr6s
	eDulKgD4zyGeXOIL6NF1rF6IwRyMkZMjOGArcwFCjyyy/wDnJX5wzUnMGufZQg==
X-Google-Smtp-Source: AGHT+IGMZLlXvU8CAUAv9DT+q3r5OtQYUBhXTxRSLpbUg/fgZlURHFtLGiA10dUYE7hx79M25yG/rA==
X-Received: by 2002:a05:6a00:928e:b0:706:74b7:9d7d with SMTP id d2e1a72fcca58-713c4f19e9amr15133166b3a.25.1724133624443;
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Received: from thinkpad ([120.60.128.138])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3c380sm7489929b3a.203.2024.08.19.23.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 23:00:24 -0700 (PDT)
Date: Tue, 20 Aug 2024 11:30:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	lukas@wunner.de, mika.westerberg@linux.intel.com,
	Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 3/4] PCI: Decouple D3Hot and D3Cold handling for
 bridges
Message-ID: <20240820060008.jbghpqibbohbemfz@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-3-2426dd9e8e27@linaro.org>
 <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c5dd04f-8ac0-41eb-a11d-cc48c898c8f3@suse.com>

On Mon, Aug 19, 2024 at 02:44:43PM +0200, Oliver Neukum wrote:
> On 02.08.24 07:55, Manivannan Sadhasivam via B4 Relay wrote:
> 
> > --- a/drivers/pci/pci-acpi.c
> > +++ b/drivers/pci/pci-acpi.c
> > @@ -1434,7 +1434,7 @@ void pci_acpi_setup(struct device *dev, struct acpi_device *adev)
> >   	 * reason is that the bridge may have additional methods such as
> >   	 * _DSW that need to be called.
> >   	 */
> > -	if (pci_dev->bridge_d3_allowed)
> > +	if (pci_dev->bridge_d3cold_allowed && pci_dev->bridge_d3hot_allowed)
> 
> Are you sure you want to require both capabilities here?
> 

Wakeup is common for both D3Hot and D3Cold, isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

