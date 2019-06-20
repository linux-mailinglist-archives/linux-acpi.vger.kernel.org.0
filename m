Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C00D4C8BD
	for <lists+linux-acpi@lfdr.de>; Thu, 20 Jun 2019 09:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbfFTH5g (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 20 Jun 2019 03:57:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33253 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfFTH5g (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Jun 2019 03:57:36 -0400
Received: by mail-wm1-f65.google.com with SMTP id h19so6306794wme.0
        for <linux-acpi@vger.kernel.org>; Thu, 20 Jun 2019 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=YQGObdl7kH+wEvSqxa3FaWAQlmAcdn2aMFRJreWKZJ0=;
        b=Xbqowj37eqV+b9k1NLVHC7JwZDta/+JDzrrS82yOXNGCstfgYJjW6mwRqSqrUWlS3L
         1/8SQNYcmzWvXsmCzetHTO6JlLdz3Id/uddvH1551kLp+ptg+bQ1j50ILkH28rrlU0ZU
         jmN/HIDMQsfJr48uD3R5FYWLPdRDLx9CEWMcCc0/fjCBi2EPF1aVLt5OwzxKvYAXNuJX
         KshcHWrLBBHaXj/vr4PvVEkwDWNuzZB/F+QSnwDu5Is0r+N94SG1NiPuv7MwEILYddxF
         78pmCuwckrZVmiiLLofI6l1GLKG8ruskdYQAGYTcG4DGJrf2tEkVmS2jzMcclNRLJsVm
         oSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=YQGObdl7kH+wEvSqxa3FaWAQlmAcdn2aMFRJreWKZJ0=;
        b=rA/5YyvLbYHU/+Z+Hh63iNdWuigwo53UW99g62S2gqv4QoFAH2Hp6qmWb8yX8qe/Uh
         gWm4hMtBtsBFISL9Ey/fuakTCDxyquyZ6qNUs+9ASXXbTGWQlfWu3EHsxzMSf5mcoXz6
         FYHyYQAfbBHHcqGhRTB+b7cVT4TFwugBRxoMcURgMBsCtmzVdEuSNJxwNoZuNLiMu/79
         i7ysRWziEIvX+nLE75gm2e8LWWMpZ9DFLf0/GwvEbcA/zna4SZO4RvU5qtbRcblFUrqB
         qGAx0kfxUg4AqqrEK+Ie+opP7RuRa6qNtUDhlTDn/NaxxTFrhkgppVReDPBE4m0unB1O
         BBaQ==
X-Gm-Message-State: APjAAAWE5IiNrQ+M85Z9aoBeszs6Ug94tFJqBKGchvGe2dB6zjmAeCRH
        H6jnc+GWhaUpd+vlD7TC421tgg==
X-Google-Smtp-Source: APXvYqyVIG+SggD0Ywg3p6wX7nREHzj8RkzQTZNsXYDvoszka9op+STK5gM62OIDMaI2Pdh9fGFtxw==
X-Received: by 2002:a1c:cf0b:: with SMTP id f11mr1671215wmg.138.1561017454297;
        Thu, 20 Jun 2019 00:57:34 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id x8sm3646616wmc.5.2019.06.20.00.57.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 00:57:33 -0700 (PDT)
Date:   Thu, 20 Jun 2019 08:57:32 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org,
        catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, leif.lindholm@linaro.org
Subject: Re: [RFC PATCH] acpi/arm64: ignore 5.1 FADTs that are reported as 5.0
Message-ID: <20190620075732.GB4699@dell>
References: <20190619121831.7614-1-ard.biesheuvel@linaro.org>
 <20190619122434.GA25656@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619122434.GA25656@e107155-lin>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-acpi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Wed, 19 Jun 2019, Sudeep Holla wrote:

> On Wed, Jun 19, 2019 at 02:18:31PM +0200, Ard Biesheuvel wrote:
> > Some Qualcomm Snapdragon based laptops built to run Microsoft Windows
> > are clearly ACPI 5.1 based, given that that is the first ACPI revision
> > that supports ARM, and introduced the FADT 'arm_boot_flags' field,
> > which has a non-zero field on those systems.
> > 
> > So in these cases, infer from the ARM boot flags that the FADT must be
> > 5.1 or later, and treat it as 5.1.
> > 
> 
> Makes sense and looks simple to me.
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Could we pleeeeease have this in for v5.3?

We have available, consumer-level platforms that rely on this change.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
