Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Original-To: lists+linux-acpi@lfdr.de
Delivered-To: lists+linux-acpi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE363A2575
	for <lists+linux-acpi@lfdr.de>; Thu, 10 Jun 2021 09:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbhFJH35 (ORCPT <rfc822;lists+linux-acpi@lfdr.de>);
        Thu, 10 Jun 2021 03:29:57 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39787 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhFJH34 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2021 03:29:56 -0400
Received: by mail-wm1-f52.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso5846082wmh.4
        for <linux-acpi@vger.kernel.org>; Thu, 10 Jun 2021 00:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=avXVNANZtbNtwGIzbu5/mOfsXzmuN+oN/aMUmryqr0Q=;
        b=VRc2QaSAIMV+KGi0BcOqJRfSdMyNdLNEnXzUhLI7MlCE0fkDGka7VzIygBBqC2saf9
         MPf2W6216h7Xg6oe2W1TW2qNY8OMi4TArPB3UivfENQTdjQJWZDSbeW7OPBTjSDOd3Kt
         gpkC7T9gXVRYLEWez/PECMfvnheDLFss2Sljc7DXK5q6EQ9XViOXVnnqszp7h61tIz/t
         A6T7EPBDCVW3HxlxhDfZrgtX71Q4H8Iq2BQRIlmxZNbmGfKP+bPpb2prIJk0UUGjSLk1
         AiGQEGOI0F87ozUc9J0SJbp8AxJ7Ss5VjUhtdIdM9kQSi81BL/1617BSJlYRD8gKInXi
         JnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=avXVNANZtbNtwGIzbu5/mOfsXzmuN+oN/aMUmryqr0Q=;
        b=KtqBQgUZFRqtDS8DHJVaMha5XLnetyZCTmaT8R8PJEGUxKi7k/o9jeFhoLlSqT0swY
         Tg9eLjUNmUY7kvAwbfEoWef01Owjr0JO4jcte2x0jaSPdGILkb7P/0TuM70XKw6S2LD+
         c8caxQ6+oWglulDI4NBqURCjughJJRH54deOuAFfSUuRHnVIvbEfY3sbOGWgNnQ4hUIB
         SBTxG8oNU2M17Izb/ExDFCQvofmr1LAfEN/tCyq/HzFZ74qVrc5X3cxIAHnvLBbOo8Ug
         w+ne3asqP5UwiqmLhCzLT6Yroaqh8GzYoww+N+TEtGt8TNEakblkbo3k5TM1ymGOUsW6
         30mA==
X-Gm-Message-State: AOAM5325SJxNAzKJ3H/7pHD+bQ2hVl6Ol8zfAgy41p/F5m86/UFMNTdu
        4iCg2UkNzraTlYvj7d5ZDH8akQ==
X-Google-Smtp-Source: ABdhPJwbq9CPx2IleqzQLDh7nuPcvAdqoVFXQyJlT7lKUCc0c5RG1MjzcAoY254nLwYIvQPK18ygFg==
X-Received: by 2002:a05:600c:410c:: with SMTP id j12mr3466501wmi.117.1623310020028;
        Thu, 10 Jun 2021 00:27:00 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id l16sm8809890wmj.47.2021.06.10.00.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 00:26:58 -0700 (PDT)
Date:   Thu, 10 Jun 2021 09:26:41 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kernel test robot <lkp@intel.com>, rjw@rjwysocki.net,
        lenb@kernel.org, mst@redhat.com, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, will@kernel.org,
        catalin.marinas@arm.com, baolu.lu@linux.intel.com,
        dwmw2@infradead.org, linux-acpi@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v3 2/6] ACPI: Move IOMMU setup code out of IORT
Message-ID: <YMG+sdvQ9/BkeBCe@myrica>
References: <20210602154444.1077006-3-jean-philippe@linaro.org>
 <202106030417.97asL7dA-lkp@intel.com>
 <YLiELyo+KLuYqA24@myrica>
 <YLpFHwGPuWsB3AgV@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YLpFHwGPuWsB3AgV@8bytes.org>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Fri, Jun 04, 2021 at 05:22:07PM +0200, Joerg Roedel wrote:
> On Thu, Jun 03, 2021 at 09:26:39AM +0200, Jean-Philippe Brucker wrote:
> > These are only defined when CONFIG_IOMMU_API is set. IORT uses them inside
> > an #ifdef, I can do the same. Maybe moving these two functions to a new
> > drivers/acpi/iommu.c would be nicer, though.
> 
> Not sure what the ACPI maintainers and reviewers prefer, but I would
> just #ifdef the functions and provide stubs in the #else path if
> necessary.

Yes, I'll resend with that

Thanks,
Jean

