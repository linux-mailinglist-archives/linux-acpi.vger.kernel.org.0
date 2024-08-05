Return-Path: <linux-acpi+bounces-7288-lists+linux-acpi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B6947BE4
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 15:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B65283515
	for <lists+linux-acpi@lfdr.de>; Mon,  5 Aug 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297452AE69;
	Mon,  5 Aug 2024 13:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2FT/um3"
X-Original-To: linux-acpi@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18021F60A
	for <linux-acpi@vger.kernel.org>; Mon,  5 Aug 2024 13:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722864964; cv=none; b=Hdb9o2JggApSA6qPV4KbOqOf9jvtvfK83uYqLKSgr5Ay80pBVQWZJn2ntA6Xw1CgvHqupStjWjDFhRonBt9oWVCrlV3rkjG2rcaG2I47UJLIl4wHFHuhh3kjPWWAjRoUmcaQCJ+RK70hpBXsCAGEBfjPJYdITXZPnO1mGQKv1wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722864964; c=relaxed/simple;
	bh=deqBr+T59Bcyml2IfglYf2okf7dmsoF1EIG+G5SirCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTDyBw3Ip1XCpA4yr9ajGxFcwXuqbeghU+FWV5tc5Yc0okLFAxqj7o4h66ruKWaDhmGxTDuX/0vXRq1BdAWG3f7lJ3t0pdN9vykcvxA02ezhVmNcItQn/bqA6Q7hXNOM8wF9VHeeyPgWjvucrd50mi92VnsGSuvTKyfipcg+PPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2FT/um3; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70eb0ae23e4so7507338b3a.0
        for <linux-acpi@vger.kernel.org>; Mon, 05 Aug 2024 06:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722864962; x=1723469762; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rN6Gcul3E2bfV10FS1hTUxZlfG84cp2ypd628Rjblcs=;
        b=H2FT/um3RzxjN9oDN29Q26es14d1R4HfkoRcwr3m97UwuBalfJYRHebm42ho5YqqFf
         /QgmSIjqECgy17ykSImfIqovk9kS5B+Xxxn9prmyt63qKfgFAneBi+Guig32qdQB+adc
         LNhP2WPtmHwinW6bt3CBK2adE54e1UOdewj8EFo79pr005eTxCx3Wq+/+zzIgLPQOOAW
         txTn8BDX2swRadagdMLG94KaFia4gcpr/Gp85/zMDdZ39oe39E7EKd90SduwPw/0XyDo
         55vubkLYFWtZoaUCJsfUnz9SDqfXRcgTrI8P9mQDwVk4XTGDJxgxzzuOUZo9jQUq+/Dy
         3A8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722864962; x=1723469762;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rN6Gcul3E2bfV10FS1hTUxZlfG84cp2ypd628Rjblcs=;
        b=s68P9SzEgLw9WfUu4Hzlue8YymFH0sDEa83szTfYrNV6klm4BMo2BXc9XFfwWCNyam
         O6eBHHnf4L8UbtbsXaSFREyKFjAwXyCmE9yXFdb0pvQPybZg2ZCsHSUnqjAefZQ7znuX
         B77cHwzeF/yTP++yxKQVZzoY8NR641YnMXr2oNnrFkCJkVwNglRJC2fG3ysDr6AXVDfY
         nhJbnoxyBQtpQM27nYjDDW+ffkXqCQxk+3FuzBrZ6EryK7jWyEbpL1ldVm3OvB8tblHq
         0Im+GEM6fB9Fff6w2wVVQU+YlyiCzVPgueWhBpcW5WHAjs/0jYl5KCVozV7cveErU4dy
         AnBA==
X-Forwarded-Encrypted: i=1; AJvYcCXrRjSL7owDGO6O9h9nW1a/Wt24uyWPGE07eqelLh/cHXfTG7XPwvDjeuCRAfECF8XecyvWBFmpLWikCfdbTZyqn79pma9OuQqZcw==
X-Gm-Message-State: AOJu0Yw3uJ98di1be3AP8Ey8ZRc2uFPjLtj3/jgV2acp9/Ed8UCieJkD
	bssIv0BOUVgRIbpviLU6nfO3JLNB9YWClWgj3m4hThzszlRFI1uiq1beY525bkaJOMqm6tUdSI0
	=
X-Google-Smtp-Source: AGHT+IFoNCsEZXQAHNUKIBafzI7fNNpxmNX2K2ix9w1zj91Ywjl+lHWsxvc5LDXihwNMbH/uk3cmqg==
X-Received: by 2002:a05:6a00:9143:b0:706:375e:220d with SMTP id d2e1a72fcca58-7106d04747cmr8068000b3a.30.1722864961872;
        Mon, 05 Aug 2024 06:36:01 -0700 (PDT)
Received: from thinkpad ([120.56.197.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d553sm5371438b3a.202.2024.08.05.06.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 06:36:00 -0700 (PDT)
Date: Mon, 5 Aug 2024 19:05:55 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	mika.westerberg@linux.intel.com, Hsin-Yi Wang <hsinyi@chromium.org>
Subject: Re: [PATCH v5 4/4] PCI: Allow PCI bridges to go to D3Hot on all
 Devicetree based platforms
Message-ID: <20240805133555.GC7274@thinkpad>
References: <20240802-pci-bridge-d3-v5-0-2426dd9e8e27@linaro.org>
 <20240802-pci-bridge-d3-v5-4-2426dd9e8e27@linaro.org>
 <ZqyxS8spZ-ohsP3R@wunner.de>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZqyxS8spZ-ohsP3R@wunner.de>

On Fri, Aug 02, 2024 at 12:13:31PM +0200, Lukas Wunner wrote:
> On Fri, Aug 02, 2024 at 11:25:03AM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > Unlike ACPI based platforms, there are no known issues with D3Hot for the
> > PCI bridges in the Devicetree based platforms. So let's allow the PCI
> > bridges to go to D3Hot during runtime. It should be noted that the bridges
> > need to be defined in Devicetree for this to work.
> [...]
> > +		if (state == PCI_D3hot && dev_of_node(&bridge->dev))
> > +			return true;
> 
> For such a simple change which several parties are interested in,
> I think it would be better to move it to the front of the series.
> 
> Patch [1/4] looks like an optimization (using a cached value)
> which this patch doesn't depend on.  Patch [2/4] looks like a
> change of bikeshed color which isn't strictly necessary for
> this fourth patch either.  If you want to propose those changes,
> fine, but by making this fourth patch depend on them, you risk
> delaying its acceptance.  As an upstreaming strategy it's usually
> smarter to move potentially controversial or unnecessary material
> to the back of the series, or submit it separately if it can be
> applied standalone.
> 

Agree with you! Even after doing upstreaming for this much time, I tend to
ignore this...

> 
> > Currently, D3Cold is not allowed since Vcc supply which is required for
> > transitioning the device to D3Cold is not exposed on all Devicetree based
> > platforms.
> 
> The PCI core cannot put devices into D3cold without help from the
> platform.  Checking whether D3cold is possible (or allowed or
> whatever) thus requires asking platform support code via
> platform_pci_power_manageable(), platform_pci_choose_state() etc.
> 
> I think patch [3/4] is a little confusing because it creates
> infrastructure to decide whether D3cold is supported (allowed?)
> but we already have that in the platform_pci_*() functions.
> So I'm not sure if patch [3/4] adds value.  I think generally
> speaking if D3hot isn't possible (allowed?), D3cold is assumed
> to not be possible either.
> 

Why? D3Hot is useful for runtime PM and if the platform doesn't want to do
runtime PM, it can always skip D3Hot (not ideal though). But D3Cold is a power
off state, and the platform may choose to use it for the case of system suspend.

So I still feel that decoupling D3Hot and D3Cold is necessary.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

